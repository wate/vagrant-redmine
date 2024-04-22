ルーティング情報
===================================

```
                                Prefix Verb               URI Pattern                                                                       Controller#Action
                                  home GET                /                                                                                 welcome#index
                                signin GET|POST           /login(.:format)                                                                  account#login
                               signout GET|POST           /logout(.:format)                                                                 account#logout
                 account_twofa_confirm GET                /account/twofa/confirm(.:format)                                                  account#twofa_confirm
                  account_twofa_resend POST               /account/twofa/resend(.:format)                                                   account#twofa_resend
                         account_twofa GET|POST           /account/twofa(.:format)                                                          account#twofa
                              register GET|POST           /account/register(.:format)                                                       account#register
                         lost_password GET|POST           /account/lost_password(.:format)                                                  account#lost_password
                      account_activate GET                /account/activate(.:format)                                                       account#activate
                      activation_email GET                /account/activation_email(.:format)                                               account#activation_email
                          preview_news GET|POST|PUT|PATCH /news/preview(.:format)                                                           previews#news
                         preview_issue GET|POST|PUT|PATCH /issues/preview(.:format)                                                         previews#issue
                          preview_text GET|POST|PUT|PATCH /preview/text(.:format)                                                           previews#text
                                       GET|POST           /projects/:id/wiki/destroy(.:format)                                              wikis#destroy
                     new_board_message GET|POST           /boards/:board_id/topics/new(.:format)                                            messages#new
                         board_message GET                /boards/:board_id/topics/:id(.:format)                                            messages#show
                                       GET|POST           /boards/:board_id/topics/quote/:id(.:format)                                      messages#quote
                                       GET                /boards/:board_id/topics/:id/edit(.:format)                                       messages#edit
                 preview_board_message POST               /boards/:board_id/topics/preview(.:format)                                        messages#preview
                                       POST               /boards/:board_id/topics/:id/replies(.:format)                                    messages#reply
                                       POST               /boards/:board_id/topics/:id/edit(.:format)                                       messages#edit
                                       POST               /boards/:board_id/topics/:id/destroy(.:format)                                    messages#destroy
                  auto_complete_issues GET                /issues/auto_complete(.:format)                                                   auto_completes#issues
              auto_complete_wiki_pages GET                /wiki_pages/auto_complete(.:format)                                               auto_completes#wiki_pages
                   issues_context_menu GET|POST           /issues/context_menu(.:format)                                                    context_menus#issues
                         issue_changes GET                /issues/changes(.:format)                                                         journals#index
                          quoted_issue POST               /issues/:id/quoted(.:format)                                                      journals#new {:id=>/\d+/}
                          diff_journal GET                /journals/:id/diff(.:format)                                                      journals#diff
                          edit_journal GET                /journals/:id/edit(.:format)                                                      journals#edit
                               journal PATCH              /journals/:id(.:format)                                                           journals#update
                                       PUT                /journals/:id(.:format)                                                           journals#update
                         project_gantt GET                /projects/:project_id/issues/gantt(.:format)                                      gantts#show
                          issues_gantt GET                /issues/gantt(.:format)                                                           gantts#show
                      project_calendar GET                /projects/:project_id/issues/calendar(.:format)                                   calendars#show
                       issues_calendar GET                /issues/calendar(.:format)                                                        calendars#show
                 project_issues_report GET                /projects/:id/issues/report(.:format)                                             reports#issue_report
         project_issues_report_details GET                /projects/:id/issues/report/:detail(.:format)                                     reports#issue_report_details
                     new_issues_import GET                /issues/imports/new(.:format)                                                     imports#new {:type=>"IssueImport"}
               new_time_entries_import GET                /time_entries/imports/new(.:format)                                               imports#new {:type=>"TimeEntryImport"}
                      new_users_import GET                /users/imports/new(.:format)                                                      imports#new {:type=>"UserImport"}
                               imports POST               /imports(.:format)                                                                imports#create
                                import GET                /imports/:id(.:format)                                                            imports#show
                       import_settings GET|POST           /imports/:id/settings(.:format)                                                   imports#settings
                        import_mapping GET|POST           /imports/:id/mapping(.:format)                                                    imports#mapping
                            import_run GET|POST           /imports/:id/run(.:format)                                                        imports#run
                            my_account GET|PUT            /my/account(.:format)                                                             my#account
                     delete_my_account GET|POST           /my/account/destroy(.:format)                                                     my#destroy
                               my_page GET                /my/page(.:format)                                                                my#page
                                       POST               /my/page(.:format)                                                                my#update_page
                                    my GET                /my(.:format)                                                                     my#index
                            my_api_key GET                /my/api_key(.:format)                                                             my#show_api_key
                                       POST               /my/api_key(.:format)                                                             my#reset_api_key
                           my_atom_key POST               /my/atom_key(.:format)                                                            my#reset_atom_key
                           my_password GET|POST           /my/password(.:format)                                                            my#password
                          my_add_block POST               /my/add_block(.:format)                                                           my#add_block
                       my_remove_block POST               /my/remove_block(.:format)                                                        my#remove_block
                       my_order_blocks POST               /my/order_blocks(.:format)                                                        my#order_blocks
                my_twofa_activate_init POST               /my/twofa/activate/init(.:format)                                                 twofa#activate_init
                                       POST               /my/twofa/:scheme/activate/init(.:format)                                         twofa#activate_init
                                       GET                /my/twofa/:scheme/activate/confirm(.:format)                                      twofa#activate_confirm
                                       GET|POST           /my/twofa/:scheme/activate(.:format)                                              twofa#activate
                                       POST               /my/twofa/:scheme/deactivate/init(.:format)                                       twofa#deactivate_init
                                       GET                /my/twofa/:scheme/deactivate/confirm(.:format)                                    twofa#deactivate_confirm
                                       GET|POST           /my/twofa/:scheme/deactivate(.:format)                                            twofa#deactivate
                my_twofa_select_scheme GET                /my/twofa/select_scheme(.:format)                                                 twofa#select_scheme
            my_twofa_backup_codes_init POST               /my/twofa/backup_codes/init(.:format)                                             twofa_backup_codes#init
         my_twofa_backup_codes_confirm GET                /my/twofa/backup_codes/confirm(.:format)                                          twofa_backup_codes#confirm
          my_twofa_backup_codes_create GET|POST           /my/twofa/backup_codes/create(.:format)                                           twofa_backup_codes#create
                 my_twofa_backup_codes GET                /my/twofa/backup_codes(.:format)                                                  twofa_backup_codes#show
                                       POST               /users/:user_id/twofa/deactivate(.:format)                                        twofa#admin_deactivate
                    users_context_menu GET|POST           /users/context_menu(.:format)                                                     context_menus#users
                    bulk_destroy_users DELETE             /users/bulk_destroy(.:format)                                                     users#bulk_destroy
                      user_memberships GET                /users/:user_id/memberships(.:format)                                             principal_memberships#index
                                       POST               /users/:user_id/memberships(.:format)                                             principal_memberships#create
                   new_user_membership GET                /users/:user_id/memberships/new(.:format)                                         principal_memberships#new
                  edit_user_membership GET                /users/:user_id/memberships/:id/edit(.:format)                                    principal_memberships#edit
                       user_membership GET                /users/:user_id/memberships/:id(.:format)                                         principal_memberships#show
                                       PATCH              /users/:user_id/memberships/:id(.:format)                                         principal_memberships#update
                                       PUT                /users/:user_id/memberships/:id(.:format)                                         principal_memberships#update
                                       DELETE             /users/:user_id/memberships/:id(.:format)                                         principal_memberships#destroy
                  user_email_addresses GET                /users/:user_id/email_addresses(.:format)                                         email_addresses#index
                                       POST               /users/:user_id/email_addresses(.:format)                                         email_addresses#create
                    user_email_address PATCH              /users/:user_id/email_addresses/:id(.:format)                                     email_addresses#update
                                       PUT                /users/:user_id/email_addresses/:id(.:format)                                     email_addresses#update
                                       DELETE             /users/:user_id/email_addresses/:id(.:format)                                     email_addresses#destroy
                                 users GET                /users(.:format)                                                                  users#index
                                       POST               /users(.:format)                                                                  users#create
                              new_user GET                /users/new(.:format)                                                              users#new
                             edit_user GET                /users/:id/edit(.:format)                                                         users#edit
                                  user GET                /users/:id(.:format)                                                              users#show
                                       PATCH              /users/:id(.:format)                                                              users#update
                                       PUT                /users/:id(.:format)                                                              users#update
                                       DELETE             /users/:id(.:format)                                                              users#destroy
                                 watch POST               /watchers/watch(.:format)                                                         watchers#watch
                        watchers_watch DELETE             /watchers/watch(.:format)                                                         watchers#unwatch
                          new_watchers GET                /watchers/new(.:format)                                                           watchers#new
                              watchers POST               /watchers(.:format)                                                               watchers#create
                       watchers_append POST               /watchers/append(.:format)                                                        watchers#append
                                       DELETE             /watchers(.:format)                                                               watchers#destroy
     watchers_autocomplete_for_mention GET                /watchers/autocomplete_for_mention(.:format)                                      watchers#autocomplete_for_mention
        watchers_autocomplete_for_user GET                /watchers/autocomplete_for_user(.:format)                                         watchers#autocomplete_for_user
                                       POST               /issues/:object_id/watchers(.:format)                                             watchers#create {:object_type=>"issue"}
                                       DELETE             /issues/:object_id/watchers/:user_id(.:format)                                    watchers#destroy {:object_type=>"issue"}
                 autocomplete_projects GET                /projects/autocomplete(.:format)                                                  projects#autocomplete
                 bulk_destroy_projects DELETE             /projects/bulk_destroy(.:format)                                                  projects#bulk_destroy
                      settings_project GET                /projects/:id/settings(/:tab)(.:format)                                           projects#settings
                       archive_project POST|PUT           /projects/:id/archive(.:format)                                                   projects#archive
                     unarchive_project POST|PUT           /projects/:id/unarchive(.:format)                                                 projects#unarchive
                         close_project POST|PUT           /projects/:id/close(.:format)                                                     projects#close
                        reopen_project POST|PUT           /projects/:id/reopen(.:format)                                                    projects#reopen
                          copy_project GET|POST           /projects/:id/copy(.:format)                                                      projects#copy
                      bookmark_project DELETE|POST        /projects/:id/bookmark(.:format)                                                  projects#bookmark
      autocomplete_project_memberships GET                /projects/:project_id/memberships/autocomplete(.:format)                          members#autocomplete
                   project_memberships GET                /projects/:project_id/memberships(.:format)                                       members#index
                                       POST               /projects/:project_id/memberships(.:format)                                       members#create
                new_project_membership GET                /projects/:project_id/memberships/new(.:format)                                   members#new
                       edit_membership GET                /memberships/:id/edit(.:format)                                                   members#edit
                            membership GET                /memberships/:id(.:format)                                                        members#show
                                       PATCH              /memberships/:id(.:format)                                                        members#update
                                       PUT                /memberships/:id(.:format)                                                        members#update
                                       DELETE             /memberships/:id(.:format)                                                        members#destroy
                  project_enumerations PATCH              /projects/:project_id/enumerations(.:format)                                      project_enumerations#update
                                       PUT                /projects/:project_id/enumerations(.:format)                                      project_enumerations#update
                                       DELETE             /projects/:project_id/enumerations(.:format)                                      project_enumerations#destroy
                    project_copy_issue GET                /projects/:project_id/issues/:copy_from/copy(.:format)                            issues#new
                        project_issues GET                /projects/:project_id/issues(.:format)                                            issues#index
                                       POST               /projects/:project_id/issues(.:format)                                            issues#create
                     new_project_issue GET                /projects/:project_id/issues/new(.:format)                                        issues#new
                    project_issues_new POST               /projects/:project_id/issues/new(.:format)                                        issues#new
                         project_files GET                /projects/:project_id/files(.:format)                                             files#index
                                       POST               /projects/:project_id/files(.:format)                                             files#create
                      new_project_file GET                /projects/:project_id/files/new(.:format)                                         files#new
      close_completed_project_versions PUT                /projects/:project_id/versions/close_completed(.:format)                          versions#close_completed
                      project_versions POST               /projects/:project_id/versions(.:format)                                          versions#create
                   new_project_version GET                /projects/:project_id/versions/new(.:format)                                      versions#new
                                       GET                /projects/:project_id/versions.:format                                            versions#index
                       project_roadmap GET                /projects/:project_id/roadmap                                                     versions#index
                                       GET                /projects/:project_id/versions(.:format)                                          versions#index
                    project_news_index GET                /projects/:project_id/news(.:format)                                              news#index
                                       POST               /projects/:project_id/news(.:format)                                              news#create
                      new_project_news GET                /projects/:project_id/news/new(.:format)                                          news#new
           report_project_time_entries GET                /projects/:project_id/time_entries/report(.:format)                               timelog#report
                  project_time_entries GET                /projects/:project_id/time_entries(.:format)                                      timelog#index
                                       POST               /projects/:project_id/time_entries(.:format)                                      timelog#create
                new_project_time_entry GET                /projects/:project_id/time_entries/new(.:format)                                  timelog#new
                       project_queries POST               /projects/:project_id/queries(.:format)                                           queries#create
                     new_project_query GET                /projects/:project_id/queries/new(.:format)                                       queries#new
              project_issue_categories GET                /projects/:project_id/issue_categories(.:format)                                  issue_categories#index
                                       POST               /projects/:project_id/issue_categories(.:format)                                  issue_categories#create
            new_project_issue_category GET                /projects/:project_id/issue_categories/new(.:format)                              issue_categories#new
                   edit_issue_category GET                /issue_categories/:id/edit(.:format)                                              issue_categories#edit
                        issue_category GET                /issue_categories/:id(.:format)                                                   issue_categories#show
                                       PATCH              /issue_categories/:id(.:format)                                                   issue_categories#update
                                       PUT                /issue_categories/:id(.:format)                                                   issue_categories#update
                                       DELETE             /issue_categories/:id(.:format)                                                   issue_categories#destroy
                     project_documents GET                /projects/:project_id/documents(.:format)                                         documents#index
                                       POST               /projects/:project_id/documents(.:format)                                         documents#create
                  new_project_document GET                /projects/:project_id/documents/new(.:format)                                     documents#new
                        project_boards GET                /projects/:project_id/boards(.:format)                                            boards#index
                                       POST               /projects/:project_id/boards(.:format)                                            boards#create
                     new_project_board GET                /projects/:project_id/boards/new(.:format)                                        boards#new
                    edit_project_board GET                /projects/:project_id/boards/:id/edit(.:format)                                   boards#edit
                         project_board GET                /projects/:project_id/boards/:id(.:format)                                        boards#show
                                       PATCH              /projects/:project_id/boards/:id(.:format)                                        boards#update
                                       PUT                /projects/:project_id/boards/:id(.:format)                                        boards#update
                                       DELETE             /projects/:project_id/boards/:id(.:format)                                        boards#destroy
                 committers_repository GET|POST           /repositories/:id/committers(.:format)                                            repositories#committers
                  project_repositories POST               /projects/:project_id/repositories(.:format)                                      repositories#create
                new_project_repository GET                /projects/:project_id/repositories/new(.:format)                                  repositories#new
                       edit_repository GET                /repositories/:id/edit(.:format)                                                  repositories#edit
                            repository PATCH              /repositories/:id(.:format)                                                       repositories#update
                                       PUT                /repositories/:id(.:format)                                                       repositories#update
                                       DELETE             /repositories/:id(.:format)                                                       repositories#destroy
                    project_wiki_index GET                /projects/:project_id/wiki/index(.:format)                                        wiki#index
              rename_project_wiki_page GET                /projects/:project_id/wiki/:id/rename(.:format)                                   wiki#rename
                                       POST               /projects/:project_id/wiki/:id/rename(.:format)                                   wiki#rename
             history_project_wiki_page GET                /projects/:project_id/wiki/:id/history(.:format)                                  wiki#history
                diff_project_wiki_page GET                /projects/:project_id/wiki/:id/diff(.:format)                                     wiki#diff
             preview_project_wiki_page POST|PUT|PATCH     /projects/:project_id/wiki/:id/preview(.:format)                                  wiki#preview
             protect_project_wiki_page POST               /projects/:project_id/wiki/:id/protect(.:format)                                  wiki#protect
      add_attachment_project_wiki_page POST               /projects/:project_id/wiki/:id/add_attachment(.:format)                           wiki#add_attachment
        export_project_wiki_page_index GET                /projects/:project_id/wiki/export(.:format)                                       wiki#export
    date_index_project_wiki_page_index GET                /projects/:project_id/wiki/date_index(.:format)                                   wiki#date_index
               project_wiki_page_index POST               /projects/:project_id/wiki/new(.:format)                                          wiki#new
                 new_project_wiki_page GET                /projects/:project_id/wiki/new(.:format)                                          wiki#new
                edit_project_wiki_page GET                /projects/:project_id/wiki/:id/edit(.:format)                                     wiki#edit
                     project_wiki_page GET                /projects/:project_id/wiki/:id(.:format)                                          wiki#show
                                       PATCH              /projects/:project_id/wiki/:id(.:format)                                          wiki#update
                                       PUT                /projects/:project_id/wiki/:id(.:format)                                          wiki#update
                                       DELETE             /projects/:project_id/wiki/:id(.:format)                                          wiki#destroy
                          project_wiki GET                /projects/:project_id/wiki(.:format)                                              wiki#show
                                       GET                /projects/:project_id/wiki/:id/:version(.:format)                                 wiki#show {:version=>/\d+/}
                                       DELETE             /projects/:project_id/wiki/:id/:version(.:format)                                 wiki#destroy_version
                                       GET                /projects/:project_id/wiki/:id/:version/annotate(.:format)                        wiki#annotate
                                       GET                /projects/:project_id/wiki/:id/:version/diff(.:format)                            wiki#diff
                              projects GET                /projects(.:format)                                                               projects#index
                                       POST               /projects(.:format)                                                               projects#create
                           new_project GET                /projects/new(.:format)                                                           projects#new
                          edit_project GET                /projects/:id/edit(.:format)                                                      projects#edit
                               project GET                /projects/:id(.:format)                                                           projects#show
                                       PATCH              /projects/:id(.:format)                                                           projects#update
                                       PUT                /projects/:id(.:format)                                                           projects#update
                                       DELETE             /projects/:id(.:format)                                                           projects#destroy
                            edit_issue PATCH              /issues/:id/edit(.:format)                                                        issues#edit
                             tab_issue GET                /issues/:id/tab/:name(.:format)                                                   issues#issue_tab
                      bulk_edit_issues GET|POST           /issues/bulk_edit(.:format)                                                       issues#bulk_edit
                    bulk_update_issues POST|PATCH         /issues/bulk_update(.:format)                                                     issues#bulk_update
                    issue_time_entries POST               /issues/:issue_id/time_entries(.:format)                                          timelog#create
                  new_issue_time_entry GET                /issues/:issue_id/time_entries/new(.:format)                                      timelog#new
                       issue_relations GET                /issues/:issue_id/relations(.:format)                                             issue_relations#index
                                       POST               /issues/:issue_id/relations(.:format)                                             issue_relations#create
                              relation GET                /relations/:id(.:format)                                                          issue_relations#show
                                       DELETE             /relations/:id(.:format)                                                          issue_relations#destroy
                                issues GET                /issues(.:format)                                                                 issues#index
                                       POST               /issues(.:format)                                                                 issues#create
                             new_issue GET                /issues/new(.:format)                                                             issues#new
                                       GET                /issues/:id/edit(.:format)                                                        issues#edit
                                 issue GET                /issues/:id(.:format)                                                             issues#show
                                       PATCH              /issues/:id(.:format)                                                             issues#update
                                       PUT                /issues/:id(.:format)                                                             issues#update
                                       DELETE             /issues/:id(.:format)                                                             issues#destroy
                            issues_new POST               /issues/new(.:format)                                                             issues#new
                                       DELETE             /issues(.:format)                                                                 issues#destroy
                               queries GET                /queries(.:format)                                                                queries#index
                                       POST               /queries(.:format)                                                                queries#create
                             new_query GET                /queries/new(.:format)                                                            queries#new
                            edit_query GET                /queries/:id/edit(.:format)                                                       queries#edit
                                 query PATCH              /queries/:id(.:format)                                                            queries#update
                                       PUT                /queries/:id(.:format)                                                            queries#update
                                       DELETE             /queries/:id(.:format)                                                            queries#destroy
                        queries_filter GET                /queries/filter(.:format)                                                         queries#filter
                            news_index GET                /news(.:format)                                                                   news#index
                                       POST               /news(.:format)                                                                   news#create
                              new_news GET                /news/new(.:format)                                                               news#new
                             edit_news GET                /news/:id/edit(.:format)                                                          news#edit
                                  news GET                /news/:id(.:format)                                                               news#show
                                       PATCH              /news/:id(.:format)                                                               news#update
                                       PUT                /news/:id(.:format)                                                               news#update
                                       DELETE             /news/:id(.:format)                                                               news#destroy
                                       POST               /news/:id/comments(.:format)                                                      comments#create
                                       DELETE             /news/:id/comments/:comment_id(.:format)                                          comments#destroy
                     status_by_version POST               /versions/:id/status_by(.:format)                                                 versions#status_by
                          edit_version GET                /versions/:id/edit(.:format)                                                      versions#edit
                               version GET                /versions/:id(.:format)                                                           versions#show
                                       PATCH              /versions/:id(.:format)                                                           versions#update
                                       PUT                /versions/:id(.:format)                                                           versions#update
                                       DELETE             /versions/:id(.:format)                                                           versions#destroy
               add_attachment_document POST               /documents/:id/add_attachment(.:format)                                           documents#add_attachment
                         edit_document GET                /documents/:id/edit(.:format)                                                     documents#edit
                              document GET                /documents/:id(.:format)                                                          documents#show
                                       PATCH              /documents/:id(.:format)                                                          documents#update
                                       PUT                /documents/:id(.:format)                                                          documents#update
                                       DELETE             /documents/:id(.:format)                                                          documents#destroy
             time_entries_context_menu GET|POST           /time_entries/context_menu(.:format)                                              context_menus#time_entries
                       edit_time_entry PATCH              /time_entries/:id/edit(.:format)                                                  timelog#edit
                   report_time_entries GET                /time_entries/report(.:format)                                                    timelog#report
                bulk_edit_time_entries GET                /time_entries/bulk_edit(.:format)                                                 timelog#bulk_edit
              bulk_update_time_entries POST               /time_entries/bulk_update(.:format)                                               timelog#bulk_update
                          time_entries GET                /time_entries(.:format)                                                           timelog#index
                                       POST               /time_entries(.:format)                                                           timelog#create
                        new_time_entry GET                /time_entries/new(.:format)                                                       timelog#new
                                       GET                /time_entries/:id/edit(.:format)                                                  timelog#edit
                            time_entry GET                /time_entries/:id(.:format)                                                       timelog#show
                                       PATCH              /time_entries/:id(.:format)                                                       timelog#update
                                       PUT                /time_entries/:id(.:format)                                                       timelog#update
                                       DELETE             /time_entries/:id(.:format)                                                       timelog#destroy {:id=>/\d+/}
                  time_entries_destroy DELETE             /time_entries/destroy(.:format)                                                   timelog#destroy
                      time_entries_new POST               /time_entries/new(.:format)                                                       timelog#new
                time_entries_bulk_edit POST               /time_entries/bulk_edit(.:format)                                                 timelog#bulk_edit
                      project_activity GET                /projects/:id/activity(.:format)                                                  activities#index
                              activity GET                /activity(.:format)                                                               activities#index
                                       GET                /projects/:id/repository/:repository_id/statistics(.:format)                      repositories#stats
                                       GET                /projects/:id/repository/:repository_id/graph(.:format)                           repositories#graph
                                       POST               /projects/:id/repository/:repository_id/fetch_changesets(.:format)                repositories#fetch_changesets
                                       GET                /projects/:id/repository/:repository_id/revisions/:rev(.:format)                  repositories#revision
                                       GET                /projects/:id/repository/:repository_id/revision(.:format)                        repositories#revision
                                       POST               /projects/:id/repository/:repository_id/revisions/:rev/issues(.:format)           repositories#add_related_issue
                                       DELETE             /projects/:id/repository/:repository_id/revisions/:rev/issues/:issue_id(.:format) repositories#remove_related_issue
                                       GET                /projects/:id/repository/:repository_id/revisions(.:format)                       repositories#revisions
                                       GET                /projects/:id/repository/:repository_id/revisions/:rev/browse(/*path)(.:format)   repositories#browse {:format=>/html/, :path=>/.*/, :rev=>/[a-z0-9\.\-_]+/}
                                       GET                /projects/:id/repository/:repository_id/revisions/:rev/show(/*path)(.:format)     repositories#show {:format=>/html/, :path=>/.*/, :rev=>/[a-z0-9\.\-_]+/}
                                       GET                /projects/:id/repository/:repository_id/revisions/:rev/entry(/*path)(.:format)    repositories#entry {:format=>/html/, :path=>/.*/, :rev=>/[a-z0-9\.\-_]+/}
                                       GET                /projects/:id/repository/:repository_id/revisions/:rev/raw(/*path)(.:format)      repositories#raw {:format=>/html/, :path=>/.*/, :rev=>/[a-z0-9\.\-_]+/}
                                       GET                /projects/:id/repository/:repository_id/revisions/:rev/annotate(/*path)(.:format) repositories#annotate {:format=>/html/, :path=>/.*/, :rev=>/[a-z0-9\.\-_]+/}
                                       GET                /projects/:id/repository/:repository_id/browse(/*path)(.:format)                  repositories#browse {:format=>/html/, :path=>/.*/}
                                       GET                /projects/:id/repository/:repository_id/entry(/*path)(.:format)                   repositories#entry {:format=>/html/, :path=>/.*/}
                                       GET                /projects/:id/repository/:repository_id/raw(/*path)(.:format)                     repositories#raw {:format=>/html/, :path=>/.*/}
                                       GET                /projects/:id/repository/:repository_id/changes(/*path)(.:format)                 repositories#changes {:format=>/html/, :path=>/.*/}
                                       GET                /projects/:id/repository/:repository_id/annotate(/*path)(.:format)                repositories#annotate {:format=>/html/, :path=>/.*/}
                                       GET                /projects/:id/repository/:repository_id/revisions/:rev/diff(/*path)               repositories#diff {:rev=>/[a-z0-9\.\-_]+/, :path=>/.*/}
                                       GET                /projects/:id/repository/:repository_id/diff(/*path)                              repositories#diff {:path=>/.*/}
                                       GET                /projects/:id/repository/:repository_id/show/*path(.:format)                      repositories#show {:format=>/html/, :path=>/.*/}
                                       GET                /projects/:id/repository/:repository_id(.:format)                                 repositories#show
                                       GET                /projects/:id/repository(.:format)                                                repositories#show
                      named_attachment GET                /attachments/:id/:filename(.:format)                                              attachments#show {:format=>/html/, :id=>/\d+/, :filename=>/.*/}
             download_named_attachment GET                /attachments/download/:id/:filename(.:format)                                     attachments#download {:id=>/\d+/, :filename=>/.*/}
                                       GET                /attachments/download/:id(.:format)                                               attachments#download {:id=>/\d+/}
                             thumbnail GET                /attachments/thumbnail/:id(/:size)(.:format)                                      attachments#thumbnail {:id=>/\d+/, :size=>/\d+/}
                            attachment GET                /attachments/:id(.:format)                                                        attachments#show
                                       PATCH              /attachments/:id(.:format)                                                        attachments#update
                                       PUT                /attachments/:id(.:format)                                                        attachments#update
                                       DELETE             /attachments/:id(.:format)                                                        attachments#destroy
               object_attachments_edit GET                /attachments/:object_type/:object_id/edit(.:format)                               attachments#edit_all
                    object_attachments PATCH              /attachments/:object_type/:object_id(.:format)                                    attachments#update_all
           object_attachments_download GET                /attachments/:object_type/:object_id/download(.:format)                           attachments#download_all
                     group_memberships GET                /groups/:group_id/memberships(.:format)                                           principal_memberships#index
                                       POST               /groups/:group_id/memberships(.:format)                                           principal_memberships#create
                  new_group_membership GET                /groups/:group_id/memberships/new(.:format)                                       principal_memberships#new
                 edit_group_membership GET                /groups/:group_id/memberships/:id/edit(.:format)                                  principal_memberships#edit
                      group_membership GET                /groups/:group_id/memberships/:id(.:format)                                       principal_memberships#show
                                       PATCH              /groups/:group_id/memberships/:id(.:format)                                       principal_memberships#update
                                       PUT                /groups/:group_id/memberships/:id(.:format)                                       principal_memberships#update
                                       DELETE             /groups/:group_id/memberships/:id(.:format)                                       principal_memberships#destroy
           autocomplete_for_user_group GET                /groups/:id/autocomplete_for_user(.:format)                                       groups#autocomplete_for_user
                                groups GET                /groups(.:format)                                                                 groups#index
                                       POST               /groups(.:format)                                                                 groups#create
                             new_group GET                /groups/new(.:format)                                                             groups#new
                            edit_group GET                /groups/:id/edit(.:format)                                                        groups#edit
                                 group GET                /groups/:id(.:format)                                                             groups#show
                                       PATCH              /groups/:id(.:format)                                                             groups#update
                                       PUT                /groups/:id(.:format)                                                             groups#update
                                       DELETE             /groups/:id(.:format)                                                             groups#destroy
                       new_group_users GET                /groups/:id/users/new(.:format)                                                   groups#new_users {:id=>/\d+/}
                           group_users POST               /groups/:id/users(.:format)                                                       groups#add_users {:id=>/\d+/}
                            group_user DELETE             /groups/:id/users/:user_id(.:format)                                              groups#remove_user {:id=>/\d+/}
                       fields_trackers GET|POST           /trackers/fields(.:format)                                                        trackers#fields
                              trackers GET                /trackers(.:format)                                                               trackers#index
                                       POST               /trackers(.:format)                                                               trackers#create
                           new_tracker GET                /trackers/new(.:format)                                                           trackers#new
                          edit_tracker GET                /trackers/:id/edit(.:format)                                                      trackers#edit
                               tracker PATCH              /trackers/:id(.:format)                                                           trackers#update
                                       PUT                /trackers/:id(.:format)                                                           trackers#update
                                       DELETE             /trackers/:id(.:format)                                                           trackers#destroy
update_issue_done_ratio_issue_statuses POST               /issue_statuses/update_issue_done_ratio(.:format)                                 issue_statuses#update_issue_done_ratio
                        issue_statuses GET                /issue_statuses(.:format)                                                         issue_statuses#index
                                       POST               /issue_statuses(.:format)                                                         issue_statuses#create
                      new_issue_status GET                /issue_statuses/new(.:format)                                                     issue_statuses#new
                     edit_issue_status GET                /issue_statuses/:id/edit(.:format)                                                issue_statuses#edit
                          issue_status PATCH              /issue_statuses/:id(.:format)                                                     issue_statuses#update
                                       PUT                /issue_statuses/:id(.:format)                                                     issue_statuses#update
                                       DELETE             /issue_statuses/:id(.:format)                                                     issue_statuses#destroy
             custom_field_enumerations GET                /custom_fields/:custom_field_id/enumerations(.:format)                            custom_field_enumerations#index
                                       POST               /custom_fields/:custom_field_id/enumerations(.:format)                            custom_field_enumerations#create
              custom_field_enumeration PATCH              /custom_fields/:custom_field_id/enumerations/:id(.:format)                        custom_field_enumerations#update
                                       PUT                /custom_fields/:custom_field_id/enumerations/:id(.:format)                        custom_field_enumerations#update
                                       DELETE             /custom_fields/:custom_field_id/enumerations/:id(.:format)                        custom_field_enumerations#destroy
                                       PUT                /custom_fields/:custom_field_id/enumerations(.:format)                            custom_field_enumerations#update_each
                         custom_fields GET                /custom_fields(.:format)                                                          custom_fields#index
                                       POST               /custom_fields(.:format)                                                          custom_fields#create
                      new_custom_field GET                /custom_fields/new(.:format)                                                      custom_fields#new
                     edit_custom_field GET                /custom_fields/:id/edit(.:format)                                                 custom_fields#edit
                          custom_field PATCH              /custom_fields/:id(.:format)                                                      custom_fields#update
                                       PUT                /custom_fields/:id(.:format)                                                      custom_fields#update
                                       DELETE             /custom_fields/:id(.:format)                                                      custom_fields#destroy
                     permissions_roles GET                /roles/permissions(.:format)                                                      roles#permissions
                                       POST               /roles/permissions(.:format)                                                      roles#update_permissions
                                 roles GET                /roles(.:format)                                                                  roles#index
                                       POST               /roles(.:format)                                                                  roles#create
                              new_role GET                /roles/new(.:format)                                                              roles#new
                             edit_role GET                /roles/:id/edit(.:format)                                                         roles#edit
                                  role GET                /roles/:id(.:format)                                                              roles#show
                                       PATCH              /roles/:id(.:format)                                                              roles#update
                                       PUT                /roles/:id(.:format)                                                              roles#update
                                       DELETE             /roles/:id(.:format)                                                              roles#destroy
                          enumerations GET                /enumerations(.:format)                                                           enumerations#index
                                       POST               /enumerations(.:format)                                                           enumerations#create
                       new_enumeration GET                /enumerations/new(.:format)                                                       enumerations#new
                      edit_enumeration GET                /enumerations/:id/edit(.:format)                                                  enumerations#edit
                           enumeration PATCH              /enumerations/:id(.:format)                                                       enumerations#update
                                       PUT                /enumerations/:id(.:format)                                                       enumerations#update
                                       DELETE             /enumerations/:id(.:format)                                                       enumerations#destroy
                                       GET                /enumerations/:type(.:format)                                                     enumerations#index
                                search GET                (/projects/:id)/search(.:format)                                                  search#index
                          mail_handler GET                /mail_handler(.:format)                                                           mail_handler#new
                                       POST               /mail_handler(.:format)                                                           mail_handler#index
                                 admin GET                /admin(.:format)                                                                  admin#index
                        admin_projects GET                /admin/projects(.:format)                                                         admin#projects
                         admin_plugins GET                /admin/plugins(.:format)                                                          admin#plugins
                            admin_info GET                /admin/info(.:format)                                                             admin#info
                            test_email POST               /admin/test_email(.:format)                                                       admin#test_email
           admin_default_configuration POST               /admin/default_configuration(.:format)                                            admin#default_configuration
                 projects_context_menu GET|POST           /admin/projects_context_menu(.:format)                                            context_menus#projects
            try_connection_auth_source GET                /auth_sources/:id/test_connection(.:format)                                       auth_sources#test_connection
autocomplete_for_new_user_auth_sources GET                /auth_sources/autocomplete_for_new_user(.:format)                                 auth_sources#autocomplete_for_new_user
                          auth_sources GET                /auth_sources(.:format)                                                           auth_sources#index
                                       POST               /auth_sources(.:format)                                                           auth_sources#create
                       new_auth_source GET                /auth_sources/new(.:format)                                                       auth_sources#new
                      edit_auth_source GET                /auth_sources/:id/edit(.:format)                                                  auth_sources#edit
                           auth_source GET                /auth_sources/:id(.:format)                                                       auth_sources#show
                                       PATCH              /auth_sources/:id(.:format)                                                       auth_sources#update
                                       PUT                /auth_sources/:id(.:format)                                                       auth_sources#update
                                       DELETE             /auth_sources/:id(.:format)                                                       auth_sources#destroy
                        edit_workflows GET                /workflows/edit(.:format)                                                         workflows#edit
                             workflows PATCH              /workflows/update(.:format)                                                       workflows#update
                 permissions_workflows GET                /workflows/permissions(.:format)                                                  workflows#permissions
          update_permissions_workflows PATCH              /workflows/update_permissions(.:format)                                           workflows#update_permissions
                        copy_workflows GET                /workflows/copy(.:format)                                                         workflows#copy
                   duplicate_workflows POST               /workflows/duplicate(.:format)                                                    workflows#duplicate
                                       GET                /workflows(.:format)                                                              workflows#index
                              settings GET                /settings(.:format)                                                               settings#index
                         settings_edit GET|POST           /settings/edit(.:format)                                                          settings#edit
                       plugin_settings GET|POST           /settings/plugin/:id(.:format)                                                    settings#plugin
                          sys_projects GET                /sys/projects(.:format)                                                           sys#projects
                                       POST               /sys/projects/:id/repository(.:format)                                            sys#create_project_repository
                  sys_fetch_changesets GET|POST           /sys/fetch_changesets(.:format)                                                   sys#fetch_changesets
                               uploads POST               /uploads(.:format)                                                                attachments#upload
                                       GET                /robots.:format                                                                   welcome#robots {:format=>"txt"}
```
