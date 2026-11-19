Vagrant 構築時間の計測結果
===========================

`vagrant up` を未作成状態から実行し、仮想マシンの構築が完了するまでの時間を計測した結果です。

最終計測日: 2026-11-20

計測条件
---------------------------

| 項目         | 内容                                                     |
| ------------ | -------------------------------------------------------- |
| 実行コマンド | `vagrant up`(引数なし)                                   |
| 開始状態     | 未作成(`vagrant status` が not created)                  |
| ホスト       | macOS (Apple Silicon)、VirtualBox プロバイダ             |
| ツール       | Vagrant 2.4.9、ansible-core 2.21.6                       |
| box          | `debian-13`(ローカルキャッシュ済み)                      |
| 仮想マシン   | 4096 MB / 4 vCPU、`192.168.33.101`                       |
| 設定         | `provision.yml` 既定(`role_update: true`)                |
| レポート     | 脆弱性レポート有効(`report_vulnerability_enabled: true`) |

結果
---------------------------

- **合計 28分32.5秒(1712.5秒)**、終了コード 0
- 3つの Playbook(構築・検証・レポート)はすべて `failed=0`

前回計測(2026-11-18)との比較
---------------------------

| 項目             | 2026-11-18 | 2026-11-20 |   差分 | 増減率 |
| ---------------- | ---------: | ---------: | -----: | -----: |
| 合計             |     2016.3 |     1712.5 | -303.8 | -15.1% |
| PLAY 1(構築)     |     1532.6 |     1518.3 |  -14.3 |  -0.9% |
| PLAY 2(検証)     |       16.4 |       13.4 |   -3.0 | -18.3% |
| PLAY 3(レポート) |      397.0 |      109.0 | -288.0 | -72.5% |

前回は脆弱性スキャンに `osv-scanner` を使用していました。  
`report` ロールの trivy 移行により、レポート生成フェーズだけで  
**288秒(6分37秒 → 1分49秒)** 短縮されています。

フェーズ別
---------------------------

| フェーズ                                            | 開始    | 所要    |
| --------------------------------------------------- | ------- | ------- |
| box インポート                                      | 0:00.7  | 4.3s    |
| VM 起動(Booting -> booted & ready)                  | 0:05.9  | 32.8s   |
| 起動後設定(ホスト名・ネットワーク・共有フォルダ)    | 0:38.8  | 10.3s   |
| ansible-galaxy(ロール取得)                          | 0:49.2  | 20.8s   |
| PLAY 1 pre_tasks(apt update / upgrade)              | 1:10.0  | 58.3s   |
| PLAY 1 ロール(14個)                                 | 2:08.3  | 1455.3s |
| PLAY 1 tasks / post_tasks(後片付け・サービス再起動) | 26:23.5 | 4.8s    |
| PLAY 2 verify                                       | 26:29.1 | 13.4s   |
| PLAY 3 report                                       | 26:43.4 | 109.0s  |

ロール別(PLAY 1)
---------------------------

| ロール           | 開始    | 所要   | 構成比 |
| ---------------- | ------- | ------ | ------ |
| `common`         | 2:08.3  | 354.2s | 24.4%  |
| `nodejs`         | 8:01.1  | 58.7s  | 4.0%   |
| `opendkim`       | 8:59.5  | 20.7s  | 1.4%   |
| `mariadb`        | 9:16.9  | 51.6s  | 3.6%   |
| `redis`          | 10:07.6 | 12.1s  | 0.8%   |
| `dehydrated`     | 10:19.7 | 89.5s  | 6.2%   |
| `nginx`          | 11:49.2 | 42.5s  | 2.9%   |
| `redmine`        | 12:31.3 | 402.5s | 27.7%  |
| `tools`          | 19:06.2 | 325.6s | 22.4%  |
| `logrotate`      | 24:32.0 | 1.1s   | 0.1%   |
| `backup`         | 24:33.1 | 14.0s  | 1.0%   |
| `mackerel_agent` | 24:47.0 | 34.9s  | 2.4%   |
| `spamassassin`   | 25:21.9 | 25.1s  | 1.7%   |
| `mailpit`        | 25:46.8 | 19.5s  | 1.3%   |

構成比はロール合計(1452.0秒)に対する割合です。  
`redmine`、`common`、`tools` の3ロールで約74%を占めます。

レポート生成(PLAY 3)の内訳
---------------------------

| 処理                            | 開始    | 所要  |
| ------------------------------- | ------- | ----- |
| pre_tasks(apt update / upgrade) | 26:43.4 | 42.0s |
| `report` ロール                 | 27:25.4 | 64.6s |
| post_tasks(Cleanup packages)    | 28:30.1 | 2.4s  |

`report` ロールのうち、脆弱性スキャン関連は以下です  
(括弧内は前回の osv-scanner 版)。

| 処理                                       | 所要          |
| ------------------------------------------ | ------------- |
| `Scan SBOM for vulnerabilities with trivy` | 17.4s(195.7s) |
| `Generate vulnerability report`            | 5.9s(82.8s)   |
| `Generate SBOM with trivy`                 | 0.4s(-)       |

脆弱性スキャン関連の合計は 23.3秒(前回 278.5秒)で、  
**255.2秒(-91.6%)** の短縮です。

所要時間の大きい処理
---------------------------

1. `redmine : Install plugin from git` — 137.3s
2. `redmine : Install theme from git` — 93.2s
3. `Update package cache and packages`(PLAY 1 pre_tasks)— 57.9s
4. `Update package cache and packages`(PLAY 3 pre_tasks)— 42.0s
5. `common : Install common packages` — 39.9s
6. `common : Install glances` — 30.3s
7. `dehydrated : Register account key` — 28.8s
8. `redmine : Install/update gem packages` — 28.0s
9. `redmine : Checkout Redmine` — 27.3s
10. `mariadb : Install MariaDB packages` — 26.2s

前回 1〜2 位だった脆弱性スキャン(195.7s / 82.8s)は上位から外れています。

検証結果
---------------------------

| Playbook       | ok  | changed | failed |
| -------------- | --- | ------- | ------ |
| `playbook.yml` | 769 | 285     | 0      |
| `verify.yml`   | 109 | 0       | 0      |
| `report.yml`   | 60  | 14      | 0      |

考察
---------------------------

- レポート生成(PLAY 3)は 6分37秒 → 1分49秒 となり、全体に占める割合は  
  約20%から約6%に下がりました。  
  処理時間の大半を占めていた脆弱性スキャン関連  
  (osv-scanner 195.7秒 → trivy 17.4秒、レポート生成 82.8秒 → 5.9秒)が  
  解消されたことが要因です。
- trivy は `tools` ロールで既にインストール済みのため、  
  `report : Install trivy` は 0.4秒(ok)で完了します。  
  また初回スキャン時は脆弱性DB(展開後約1.7GB)のダウンロードが発生し、  
  今回の17.4秒に含まれます。  
  DBがキャッシュ済みの2回目以降はさらに短くなります。
- PLAY 1 の差(-14.3秒)はほぼ誤差です。  
  `redmine` ロールのプラグイン/テーマ取得が 137.3秒 + 93.2秒と上位を占め、  
  GitHub 側の応答速度に左右されます。
- 脆弱性レポートは 8,724件(修正版が提供されているもののみ)で、  
  対象はカーネルヘッダ3パッケージに集中しています。  
  ノイズを減らす場合は `report_vulnerability_ignorefile` で除外定義を渡せます。
- 前回の計測で使っていた `report_osv_scanner_save_output` は trivy 移行に伴い  
  廃止されたため、`provision/host_vars/default.yml` を  
  `report_vulnerability_enabled: true` に置き換えました。  
  旧設定が出力した `provision/report/default/osv-scanner-result.json`(211MB)は  
  不要であれば削除できます。
- `role_update: true` のため、毎回 ansible-galaxy がロールを取得します  
  (今回20.8秒)。  
  再現性を重視する計測では `role_update: false` と比較するとよいです。
- box はキャッシュ済みだったためインポートは4.3秒でした。  
  初回の box 取得はこれに加算されます。

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
