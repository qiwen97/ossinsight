class Partition < ActiveRecord::Migration[6.1]
  def change
    create_sql = <<~SQL
      CREATE TABLE if not exists `github_events` (
        `id` bigint(20) NOT NULL DEFAULT 0,
        `type` varchar(29) NOT NULL DEFAULT 'Event',
        `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
        `repo_id` bigint(20) NOT NULL DEFAULT 0,
        `repo_name` varchar(140)  NOT NULL DEFAULT '',
        `actor_id` bigint(20) NOT NULL DEFAULT 0,
        `actor_login` varchar(40) NOT NULL DEFAULT '',
        `language` varchar(26) NOT NULL DEFAULT '',
        `additions` bigint(20) NOT NULL DEFAULT 0,
        `deletions` bigint(20) NOT NULL DEFAULT 0,
        `action` varchar(11) NOT NULL DEFAULT '',
        `number` int(11) NOT NULL DEFAULT 0,
        `commit_id` varchar(40) NOT NULL DEFAULT '',
        `comment_id` bigint(20) NOT NULL DEFAULT 0,
        `org_login` varchar(40) NOT NULL DEFAULT '',
        `org_id` bigint(20) NOT NULL DEFAULT 0,
        `state` varchar(6) NOT NULL DEFAULT '',
        `closed_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
        `comments` int(11) NOT NULL DEFAULT 0,
        `pr_merged_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
        `pr_merged` tinyint(1) NOT NULL DEFAULT 0,
        `pr_changed_files` int(11) NOT NULL DEFAULT 0,
        `pr_review_comments` int(11) NOT NULL DEFAULT 0,
        `pr_or_issue_id` bigint(20) NOT NULL DEFAULT 0,
        `event_day` date NOT NULL,
        `event_month` date NOT NULL,
        `event_year` int(11) NOT NULL,
        `push_size` int(11) NOT NULL DEFAULT 0,
        `push_distinct_size` int(11) NOT NULL DEFAULT 0,
        `creator_user_login` varchar(40) NOT NULL DEFAULT '',
        `creator_user_id` bigint(20) NOT NULL DEFAULT 0,
        `pr_or_issue_created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',

        KEY `index_github_events_on_id` (`id`),
        KEY `index_github_events_on_actor_login` (`actor_login`),
        KEY `index_github_events_on_created_at` (`created_at`),
        KEY `index_github_events_on_repo_name` (`repo_name`),
        KEY `index_github_events_on_repo_id_type_action_month_actor_login` (`repo_id`,`type`,`action`,`event_month`,`actor_login`),
        KEY `index_ge_on_repo_id_type_action_pr_merged_created_at_add_del` (`repo_id`,`type`,`action`,`pr_merged`,`created_at`,`additions`,`deletions`),
        KEY `index_ge_on_creator_id_type_action_merged_created_at_add_del` (`creator_user_id`,`type`,`action`,`pr_merged`,`created_at`,`additions`,`deletions`),
        KEY `index_ge_on_actor_id_type_action_created_at_repo_id_commits` (`actor_id`,`type`,`action`,`created_at`,`repo_id`,`push_distinct_size`),
        KEY `index_ge_on_org_id_type_action_pr_merged_created_at_add_del` (`org_id`,`type`,`action`,`pr_merged`,`created_at`,`additions`,`deletions`),
        KEY `index_ge_on_repo_id_type_action_created_at_number_pdsize_psize` (`repo_id`,`type`,`action`,`created_at`,`number`,`push_distinct_size`,`push_size`),
        KEY `index_ge_on_org_id_type_action_created_at_number_pdsize_psize` (`org_id`,`type`,`action`,`created_at`,`number`,`push_distinct_size`,`push_size`),
        KEY `index_github_events_on_org_id_type_action_month_actor_login` (`org_id`,`type`,`action`,`event_month`,`actor_login`)
        
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin
      PARTITION BY LIST COLUMNS(`type`)
      (PARTITION `push_event` VALUES IN ('PushEvent'),
      PARTITION `create_event` VALUES IN ('CreateEvent'),
      PARTITION `pull_request_event` VALUES IN ('PullRequestEvent'),
      PARTITION `watch_event` VALUES IN ('WatchEvent'),
      PARTITION `issue_comment_event` VALUES IN ('IssueCommentEvent'),
      PARTITION `issues_event` VALUES IN ('IssuesEvent'),
      PARTITION `delete_event` VALUES IN ('DeleteEvent'),
      PARTITION `fork_event` VALUES IN ('ForkEvent'),
      PARTITION `pull_request_review_comment_event` VALUES IN ('PullRequestReviewCommentEvent'),
      PARTITION `pull_request_review_event` VALUES IN ('PullRequestReviewEvent'),
      PARTITION `gollum_event` VALUES IN ('GollumEvent'),
      PARTITION `release_event` VALUES IN ('ReleaseEvent'),
      PARTITION `member_event` VALUES IN ('MemberEvent'),
      PARTITION `commit_comment_event` VALUES IN ('CommitCommentEvent'),
      PARTITION `public_event` VALUES IN ('PublicEvent'),
      PARTITION `gist_event` VALUES IN ('GistEvent'),
      PARTITION `follow_event` VALUES IN ('FollowEvent'),
      PARTITION `event` VALUES IN ('Event'),
      PARTITION `download_event` VALUES IN ('DownloadEvent'),
      PARTITION `team_add_event` VALUES IN ('TeamAddEvent'),
      PARTITION `fork_apply_event` VALUES IN ('ForkApplyEvent'));
    SQL
    execute(create_sql)
  end
end
