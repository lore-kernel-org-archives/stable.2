Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925AB41BA6A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201895; cv=none; b=Zzg1/a/DUdd/DQlZnDV7urldJ8XV+S4sbAwzgcCyPJjFXNXQiIH3XmdWc21CzgpLaxNO13nZCJVonM5jBJ0Cb8MaIF+7GjO3pVehfWjxKSk3Q7JROhgP3H+qLFjZFmfUP4Zfhk2WA5M41adDUjHlwcOq25cfP+VildNN8iEGjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201895; c=relaxed/simple;
	bh=071uITwORtFJqLM8qQ7mIoBXU7IHTfdSedlVp4WLfTg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rgSr55iUpr/SbIURhx69sHH7qaUT5qeiN8JGVGUn0cqKb0uCJPxSKUicL3fPyZrR8c+gUW/x7GPlsdCcGHQV/BaVW53VEAP3OE3deaObCyCOEvDhTwbwy2Tmp/k/vSdgWNqkvvrcoSGgqGjzsAD/BjR12FEnqfcIUT+Gl/and4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MogeOtfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MogeOtfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15021F000E9;
	Thu, 16 Jul 2026 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201890;
	bh=9hqAEWxI80QBq4PgX6uFjsDVDUOEDqKQKCXjIK7eY4w=;
	h=Subject:To:Cc:From:Date;
	b=MogeOtfZnLArtePIGY6cD/1pSSzHrLt1cluvpOoeeY+wH7fqaTpXKM1JKbqyM9mZA
	 X1IZXv1k8wo9G+jb0tIUltCvtPnSROr+Ef1NVmF7Xoshn4emZL2/a3UttFwqaTYTJR
	 mumcxJ4cXPRDM5HdqR27dNoxsseD1CY4Z3+OLun8=
Subject: FAILED: patch "[PATCH] audit: fix recursive locking deadlock in audit_dupe_exe()" failed to apply to 5.15-stable tree
To: rrobaina@redhat.com,longman@redhat.com,nathan@kernel.org,paul@paul-moore.com,rgb@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:37:53 +0200
Message-ID: <2026071653-tartly-scoundrel-d2b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 81905b5acbe77284734438df3fbec1158e6429a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071653-tartly-scoundrel-d2b3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81905b5acbe77284734438df3fbec1158e6429a3 Mon Sep 17 00:00:00 2001
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 19:15:34 -0400
Subject: [PATCH] audit: fix recursive locking deadlock in audit_dupe_exe()

A deadlock occurs in the audit subsystem when duplicating
executable-related rules.

When a file is moved (e.g., via do_renameat2()), the VFS layer locks
the parent directory (I_MUTEX_PARENT), which synchronously triggers an
fsnotify_move event. If an existing executable audit rule matches the
file being moved, the audit subsystem catches this event and calls
audit_dupe_exe() to duplicate the watch and update the rule. Then,
audit_alloc_mark() would call kern_path_parent() to resolve the path,
leading to a blind attempt to acquire the exact same I_MUTEX_PARENT lock
already held by the task, resulting in the following recursive locking
deadlock:

 ============================================
 WARNING: possible recursive locking detected
 6.12.0-55.27.1.el10_0.x86_64+debug #1 Not tainted
 --------------------------------------------
 mv/5099 is trying to acquire lock:
 ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
 at: __kern_path_locked+0x10a/0x2f0

 but task is already holding lock:
 ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
 at: lock_two_directories+0x13f/0x2b0

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
   lock(&inode->i_sb->s_type->i_mutex_dir_key/1);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

  6 locks held by mv/5099:
  #0: ffff888112a9c440 (sb_writers#13)
  at: do_renameat2+0x34c/0xbc0
  #1: ffff888112a9c790 (&type->s_vfs_rename_key#3)
  at: do_renameat2+0x415/0xbc0
  #2: ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1)
  at: lock_two_directories+0x13f/0x2b0
  #3: ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/5)
  at: lock_two_directories+0x175/0x2b0
  #4: ffffffffb3a1fb10 (&fsnotify_mark_srcu)
  at: fsnotify+0x454/0x28a0
  #5: ffffffffaf886230 (audit_filter_mutex)
  at: audit_update_watch+0x36/0x11e0

 stack backtrace:
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6f/0xb0
  print_deadlock_bug.cold+0xbd/0xca
  validate_chain+0x83a/0xf00
  __lock_acquire+0xcac/0x1d20
  lock_acquire.part.0+0x11b/0x360
  down_write_nested+0x9f/0x230
  __kern_path_locked+0x10a/0x2f0
  kern_path_locked+0x26/0x40
  audit_alloc_mark+0xfb/0x4f0
  audit_dupe_exe+0x6c/0xe0
  audit_dupe_rule+0x6c2/0xc00
  audit_update_watch+0x4cc/0x11e0
  audit_watch_handle_event+0x12c/0x1b0
  send_to_group+0x5d0/0x8b0
  fsnotify+0x615/0x28a0
  fsnotify_move+0x1d8/0x630
  vfs_rename+0xdcd/0x1df0
  do_renameat2+0x9d4/0xbc0
  __x64_sys_renameat+0x192/0x260
  do_syscall_64+0x92/0x180
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f0491fe8c4e
 Code: 0f 1f 40 00 48 8b 15 c1 e1 16 00 f7 d8 64 89 02 b8 ff ff ff ff
 c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 08 01 00 00 0f 05 <48>
 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 89
 RSP: 002b:00007ffc7210bf38 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0491fe8c4e
 RDX: 0000000000000003 RSI: 00007ffc7210e6c8 RDI: 00000000ffffff9c
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
 R10: 00005575eb2dae2a R11: 0000000000000246 R12: 00005575eb2dae2a
 R13: 00007ffc7210e6c8 R14: 0000000000000003 R15: 00000000ffffff9c
  </TASK>

The aforementioned deadlock can be consistently reproduced by running
the script below:

 audit-dupe-exe-deadlock.sh
 --------------------------
 #!/bin/bash
 auditctl -D
 mkdir -p /tmp/foo
 touch /tmp/file
 auditctl -a always,exit -F exe=/tmp/file -F path=/tmp/file -S all -k dr
 mv /tmp/file /tmp/foo/file
 rm -Rf /tmp/foo

This patch fixes the issue by introducing struct audit_watch_ctx to pass
the fsnotify event context down to audit_alloc_mark(). By utilizing the
already-resolved directory inode provided by the event, we bypass the
kern_path_parent() path resolution entirely, safely avoiding the
recursive lock. Furthermore, it explicitly allows duplicate fsnotify
marks (allow_dups = 1) during the rename update, allowing the new rule's
mark to safely coexist with the old rule's mark until the old rule is
freed.

P.S.: This issue was identified and reproduced during a comprehensive
code coverage analysis of the audit subsystem. The full report is
available at the link below:

https://people.redhat.com/rrobaina/audit-code-coverage-analysis.pdf

P.P.S: With the permission of both Ricardo and Nathan, I've squashed a
fixup patch from Nathan that addresses a compile time error when
CONFIG_AUDITSYSCALL=n.

Cc: stable@kernel.org
Fixes: 34d99af52ad4 ("audit: implement audit by executable")
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
[PM: move link metadata into the msg, apply fix from NC]
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/kernel/audit.h b/kernel/audit.h
index a5926c83e61b..92d5e723d570 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -256,8 +256,13 @@ extern int audit_del_rule(struct audit_entry *entry);
 extern void audit_free_rule_rcu(struct rcu_head *head);
 extern struct list_head audit_filter_list[];
 
-extern struct audit_entry *audit_dupe_rule(struct audit_krule *old);
+struct audit_watch_ctx {
+	struct inode *dir;
+	struct inode *child;
+};
 
+extern struct audit_entry *audit_dupe_rule(struct audit_krule *old,
+					   struct audit_watch_ctx *ctx);
 extern void audit_log_d_path_exe(struct audit_buffer *ab,
 				 struct mm_struct *mm);
 
@@ -280,13 +285,15 @@ extern char *audit_watch_path(struct audit_watch *watch);
 extern int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev);
 
 extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
-						    char *pathname, int len);
+						    char *pathname, int len,
+						    struct audit_watch_ctx *ctx);
 extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
 extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
 extern void audit_remove_mark_rule(struct audit_krule *krule);
 extern int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino,
 			      dev_t dev);
-extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old);
+extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old,
+			  struct audit_watch_ctx *ctx);
 extern int audit_exe_compare(struct task_struct *tsk,
 			     struct audit_fsnotify_mark *mark);
 
@@ -317,13 +324,13 @@ extern struct list_head *audit_killed_trees(void);
 #define audit_watch_path(w) ""
 #define audit_watch_compare(w, i, d) 0
 
-#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
+#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
 #define audit_mark_path(m) ""
 #define audit_remove_mark(m) do { } while (0)
 #define audit_remove_mark_rule(k) do { } while (0)
 #define audit_mark_compare(m, i, d) 0
 #define audit_exe_compare(t, m) (-EINVAL)
-#define audit_dupe_exe(n, o) (-EINVAL)
+#define audit_dupe_exe(n, o, c) (-EINVAL)
 
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index ae0e75403f76..fa33d57e4320 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -71,19 +71,30 @@ static void audit_update_mark(struct audit_fsnotify_mark *audit_mark,
 	audit_mark->ino = inode ? inode->i_ino : AUDIT_INO_UNSET;
 }
 
-struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname, int len)
+struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname,
+					     int len, struct audit_watch_ctx *ctx)
 {
 	struct audit_fsnotify_mark *audit_mark;
 	struct path path;
 	struct dentry *dentry;
-	int ret;
+	struct inode *dir, *child;
+	int ret, allow_dups;
 
 	if (pathname[0] != '/' || pathname[len-1] == '/')
 		return ERR_PTR(-EINVAL);
 
-	dentry = kern_path_parent(pathname, &path);
-	if (IS_ERR(dentry))
-		return ERR_CAST(dentry); /* returning an error */
+	if (!ctx) {
+		dentry = kern_path_parent(pathname, &path);
+		if (IS_ERR(dentry))
+			return ERR_CAST(dentry); /* returning an error */
+		dir = d_inode(path.dentry);
+		child = d_inode(dentry);
+		allow_dups = 0;
+	} else {
+		dir = ctx->dir;
+		child = ctx->child;
+		allow_dups = 1;
+	}
 
 	audit_mark = kzalloc_obj(*audit_mark);
 	if (unlikely(!audit_mark)) {
@@ -94,18 +105,21 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	fsnotify_init_mark(&audit_mark->mark, audit_fsnotify_group);
 	audit_mark->mark.mask = AUDIT_FS_EVENTS;
 	audit_mark->path = pathname;
-	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
+	audit_update_mark(audit_mark, child);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, dir, allow_dups);
+
 	if (ret < 0) {
 		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
 	}
 out:
-	dput(dentry);
-	path_put(&path);
+	if (!ctx) {
+		dput(dentry);
+		path_put(&path);
+	}
 	return audit_mark;
 }
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index c9fe64f73ffc..06dd0ebe73e2 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -244,7 +244,8 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       u64 ino, unsigned int invalidating)
+			       u64 ino, unsigned int invalidating,
+			       struct audit_watch_ctx *ctx)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
@@ -280,7 +281,7 @@ static void audit_update_watch(struct audit_parent *parent,
 			list_del(&oentry->rule.rlist);
 			list_del_rcu(&oentry->list);
 
-			nentry = audit_dupe_rule(&oentry->rule);
+			nentry = audit_dupe_rule(&oentry->rule, ctx);
 			if (IS_ERR(nentry)) {
 				list_del(&oentry->rule.list);
 				audit_panic("error updating watch, removing");
@@ -479,10 +480,17 @@ static int audit_watch_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group))
 		return 0;
 
-	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
-		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
-	else if (mask & (FS_DELETE|FS_MOVED_FROM))
-		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
+	if (mask & (FS_CREATE|FS_MOVED_TO) && inode) {
+		struct audit_watch_ctx ctx = { .dir = dir, .child = inode };
+
+		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0,
+				   &ctx);
+	} else if (mask & (FS_DELETE|FS_MOVED_FROM)) {
+		struct audit_watch_ctx ctx = { .dir = dir, .child = NULL };
+
+		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1,
+				   &ctx);
+	}
 	else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
 		audit_remove_parent_watches(parent);
 
@@ -505,7 +513,8 @@ static int __init audit_watch_init(void)
 }
 device_initcall(audit_watch_init);
 
-int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
+int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old,
+		   struct audit_watch_ctx *ctx)
 {
 	struct audit_fsnotify_mark *audit_mark;
 	char *pathname;
@@ -514,7 +523,7 @@ int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
 	if (!pathname)
 		return -ENOMEM;
 
-	audit_mark = audit_alloc_mark(new, pathname, strlen(pathname));
+	audit_mark = audit_alloc_mark(new, pathname, strlen(pathname), ctx);
 	if (IS_ERR(audit_mark)) {
 		kfree(pathname);
 		return PTR_ERR(audit_mark);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index b97c97495807..4401119b5275 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -589,7 +589,7 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 				err = PTR_ERR(str);
 				goto exit_free;
 			}
-			audit_mark = audit_alloc_mark(&entry->rule, str, f_val);
+			audit_mark = audit_alloc_mark(&entry->rule, str, f_val, NULL);
 			if (IS_ERR(audit_mark)) {
 				kfree(str);
 				err = PTR_ERR(audit_mark);
@@ -816,7 +816,8 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
  * rule with the new rule in the filterlist, then free the old rule.
  * The rlist element is undefined; list manipulations are handled apart from
  * the initial copy. */
-struct audit_entry *audit_dupe_rule(struct audit_krule *old)
+struct audit_entry *audit_dupe_rule(struct audit_krule *old,
+				    struct audit_watch_ctx *ctx)
 {
 	u32 fcount = old->field_count;
 	struct audit_entry *entry;
@@ -875,7 +876,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 				new->filterkey = fk;
 			break;
 		case AUDIT_EXE:
-			err = audit_dupe_exe(new, old);
+			err = audit_dupe_exe(new, old, ctx);
 			break;
 		}
 		if (err) {
@@ -1414,7 +1415,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	if (!security_audit_rule_known(r))
 		return 0;
 
-	nentry = audit_dupe_rule(r);
+	nentry = audit_dupe_rule(r, NULL);
 	if (entry->rule.exe)
 		audit_remove_mark(entry->rule.exe);
 	if (IS_ERR(nentry)) {

