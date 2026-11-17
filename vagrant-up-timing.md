Vagrant 構築時間の計測結果
===========================

`vagrant up` を未作成状態から実行し、仮想マシンの構築が完了するまでの時間を計測した結果です。

最終計測日: 2026-11-18

計測条件
---------------------------

| 項目         | 内容                                         |
| ------------ | -------------------------------------------- |
| 実行コマンド | `vagrant up`(引数なし)                       |
| 開始状態     | 未作成(`vagrant status` が not created)      |
| ホスト       | macOS (Apple Silicon)、VirtualBox プロバイダ |
| ツール       | Vagrant 2.4.9、ansible-core 2.21.6           |
| box          | `debian-13`(ローカルキャッシュ済み)          |
| 仮想マシン   | 4096 MB / 4 vCPU、`192.168.33.101`           |
| 設定         | `provision.yml` 既定(`role_update: true`)    |

結果
---------------------------

- **合計 33分36秒(2016.3秒)**、終了コード 0
- 3つの Playbook(構築・検証・レポート)はすべて `failed=0`

フェーズ別
---------------------------

| フェーズ                                            | 開始    | 所要    |
| --------------------------------------------------- | ------- | ------- |
| box インポート                                      | 0:00.8  | 3.6s    |
| VM 起動(Booting -> booted & ready)                  | 0:05.6  | 34.6s   |
| 起動後設定(ホスト名・ネットワーク・共有フォルダ)    | 0:40.2  | 7.4s    |
| ansible-galaxy(ロール取得)                          | 0:47.8  | 18.7s   |
| PLAY 1 pre_tasks(apt update / upgrade)              | 1:08.2  | 60.2s   |
| PLAY 1 ロール(14個)                                 | 2:08.4  | 24:11.1 |
| PLAY 1 tasks / post_tasks(後片付け・サービス再起動) | 26:19.5 | 21.3s   |
| PLAY 2 verify                                       | 26:41.7 | 16.4s   |
| PLAY 3 report                                       | 26:58.9 | 6:37.0  |

ロール別(PLAY 1)
---------------------------

| ロール           | 開始    | 所要   | 構成比 |
| ---------------- | ------- | ------ | ------ |
| `common`         | 2:08.4  | 349.9s | 24.1%  |
| `nodejs`         | 7:58.4  | 58.2s  | 4.0%   |
| `opendkim`       | 8:56.5  | 19.1s  | 1.3%   |
| `mariadb`        | 9:15.7  | 55.3s  | 3.8%   |
| `redis`          | 10:10.9 | 13.9s  | 1.0%   |
| `dehydrated`     | 10:24.9 | 88.9s  | 6.1%   |
| `nginx`          | 11:53.7 | 45.0s  | 3.1%   |
| `redmine`        | 12:38.8 | 399.0s | 27.5%  |
| `tools`          | 19:17.8 | 323.2s | 22.3%  |
| `logrotate`      | 24:41.0 | 1.1s   | 0.1%   |
| `backup`         | 24:42.1 | 14.0s  | 1.0%   |
| `mackerel_agent` | 24:56.0 | 35.8s  | 2.5%   |
| `spamassassin`   | 25:31.8 | 27.7s  | 1.9%   |
| `mailpit`        | 25:59.5 | 20.0s  | 1.4%   |

構成比はロール合計(1451.1秒)に対する割合です。`redmine`、`common`、`tools` の3ロールで
約74%を占めます。

所要時間の大きい処理
---------------------------

1. `report : Scan vulnerabilities with osv-scanner` — 195.7s
2. `report : Generate vulnerability report` — 82.8s
3. `Update package cache and packages`(PLAY 1 pre_tasks)— 58.2s
4. `Update package cache and packages`(PLAY 3 pre_tasks)— 46.9s
5. `common : Install common packages` — 33.6s
6. `common : Install glances` — 32.0s
7. `mariadb : Install MariaDB packages` — 30.6s
8. `redmine : Install/update gem packages` — 29.1s
9. `dehydrated : Register account key` — 28.1s
10. `spamassassin : Install spamassassin packages` — 27.1s

検証結果
---------------------------

| Playbook       | ok  | changed | failed |
| -------------- | --- | ------- | ------ |
| `playbook.yml` | 770 | 285     | 0      |
| `verify.yml`   | 109 | 0       | 0      |
| `report.yml`   | 52  | 8       | 0      |

考察
---------------------------

- レポート生成(PLAY 3)が 6分37秒と全体の約2割を占めます。うち `osv-scanner` のスキャンが195.7秒、
  脆弱性レポートの生成が82.8秒で、構築そのものより時間を使っています。
  レポートが不要な場合は `provision/report.yml` を外すことで短縮できます。
- `role_update: true` のため、毎回 ansible-galaxy がロールを取得します(今回18.7秒)。
  再現性を重視する計測では `role_update: false` と比較するとよいです。
- box はキャッシュ済みだったためインポートは3.6秒でした。初回の box 取得はこれに加算されます。
- `redmine` ロールの gem インストールは29.1秒で、ホスト側のキャッシュ状況に左右されます。

付録: 計測方法
---------------------------

経過時間を全行に付与して計測しました。以下を `run.py` として保存し、
`python3 run.py vagrant up` で実行しています(疑似端末経由で出力のバッファリングを回避)。

```python
import os, pty, re, select, subprocess, sys, time

ANSI = re.compile(rb'\x1b\[[0-9;?]*[a-zA-Z]')
cmd = sys.argv[1:]
start = time.monotonic()

master, slave = pty.openpty()
proc = subprocess.Popen(cmd, stdin=subprocess.DEVNULL, stdout=slave, stderr=slave,
                        cwd=os.getcwd(), env={**os.environ, "VAGRANT_FORCE_COLOR": "0"})
os.close(slave)

buf = b''
def emit(line, elapsed):
    mins, secs = divmod(elapsed, 60)
    print(f"[+{int(mins):02d}:{secs:06.3f}] {ANSI.sub(b'', line).decode('utf-8', 'replace').rstrip()}",
          flush=True)

while True:
    ready, _, _ = select.select([master], [], [], 1.0)
    if ready:
        chunk = os.read(master, 65536)
        if not chunk:
            break
        buf += chunk
        while b'\n' in buf:
            line, buf = buf.split(b'\n', 1)
            emit(line, time.monotonic() - start)
    elif proc.poll() is not None:
        break

if buf:
    emit(buf, time.monotonic() - start)

rc = proc.wait()
os.close(master)
total = time.monotonic() - start
print(f"TOTAL ELAPSED: {total:.1f}s ({total/60:.2f} min) exit={rc}")
sys.exit(rc)
```
