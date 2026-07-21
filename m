Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4828432E74
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662577; cv=none; b=JQsGC89dcNpo5e8EuBZTOkhhOezOY3435QyVO1EKgp1JmvIk8pRKyl3KLu+BUGW5HmPiwUsySbO5+Iw1H9QTVWSlrOCnWAVr4Nv+5S8iEgzzU9M77v5e1bmN1Djfh+5cc0y02gGQDeGlvOfA3LkivtOdAVuIbY2Uu9fV98JjoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662577; c=relaxed/simple;
	bh=/o6Qt4m1oP35JG3I2068gC3OKlf9F28RfHyWCvd3HL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIo+OTnX1jE0S6OiTKuMSAqEnxPRRBIM6b8T7m5AFgnik55Pk5z82g1ADiGuDHMpQ9wYVfMxYqrHEPN+9SG/MmBmBP/4d6t0DzsMbs7q5KGj85xhWzOBPcT3IIZxAh+CrQXXztPvn0LecGkBehdJ6vhXptnZTCXtDGRjXLZnQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS4y4OrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS4y4OrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2AE1F000E9;
	Tue, 21 Jul 2026 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662575;
	bh=r1Ua2K/nGx0ucxZOyuXOwuworVmc+ttdjHojEiXDMvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oS4y4OrF1qE4EEhVVGEoSTiisxHewIpWdbasWX5kYm61tHnLsuFsKO2drjJbze7dA
	 Ihutn9KbsJ3Y3jq9Zk0xmhTwUWUYGzd5WiQgfPdzKcQJ/OKS2ms/0UjoviL0wNdXnG
	 FQt5wLTX5IHJfnJGuUZ0acEmASA5EK/J6PgQ3xaX0RWXOp3rCHHbJsYU6KAYrs2G1n
	 hIAL7ZXnGPRDXHPwoMmobehUDv8NvLlqjNnP2s1QY5VwDnfricb/zlPSLDmKQJnXJk
	 wWVB9oVOSadul87I6Glc9S81I1mseGELL9KM0tCWy+bkKQtrmDsusAgrgmhbxSXAjf
	 O9JAn8ut2ohWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] audit: widen ino fields to u64
Date: Tue, 21 Jul 2026 15:36:11 -0400
Message-ID: <20260721193613.410665-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071649-unify-resurrect-9786@gregkh>
References: <2026071649-unify-resurrect-9786@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 125dfa218134df7cc112667e92984de9d8cd0bf6 ]

inode->i_ino is being widened from unsigned long to u64. The audit
subsystem uses unsigned long ino in struct fields, function parameters,
and local variables that store inode numbers from arbitrary filesystems.
On 32-bit platforms this truncates inode numbers that exceed 32 bits,
which will cause incorrect audit log entries and broken watch/mark
comparisons.

Widen all audit ino fields, parameters, and locals to u64, and update
the inode format string from %lu to %llu to match.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260304-iino-u64-v3-2-2257ad83d372@kernel.org
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 81905b5acbe7 ("audit: fix recursive locking deadlock in audit_dupe_exe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/audit.h   |  2 +-
 kernel/audit.h          | 13 ++++++-------
 kernel/audit_fsnotify.c |  4 ++--
 kernel/audit_watch.c    | 12 ++++++------
 kernel/auditsc.c        |  4 ++--
 5 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index b8d8029c6c480c..4ab9310ba2881e 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -16,7 +16,7 @@
 #include <uapi/linux/netfilter/nf_tables.h>
 #include <uapi/linux/fanotify.h>
 
-#define AUDIT_INO_UNSET ((unsigned long)-1)
+#define AUDIT_INO_UNSET ((u64)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
 
 struct audit_sig_info {
diff --git a/kernel/audit.h b/kernel/audit.h
index 0f05933a173be0..bf25675fc718f7 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -76,7 +76,7 @@ struct audit_names {
 	int			name_len;	/* number of chars to log */
 	bool			hidden;		/* don't log this record */
 
-	unsigned long		ino;
+	u64			ino;
 	dev_t			dev;
 	umode_t			mode;
 	kuid_t			uid;
@@ -225,9 +225,9 @@ extern int auditd_test_task(struct task_struct *task);
 #define AUDIT_INODE_BUCKETS	32
 extern struct list_head audit_inode_hash[AUDIT_INODE_BUCKETS];
 
-static inline int audit_hash_ino(u32 ino)
+static inline int audit_hash_ino(u64 ino)
 {
-	return (ino & (AUDIT_INODE_BUCKETS-1));
+	return ((u32)ino & (AUDIT_INODE_BUCKETS-1));
 }
 
 /* Indicates that audit should log the full pathname. */
@@ -277,16 +277,15 @@ extern int audit_to_watch(struct audit_krule *krule, char *path, int len,
 extern int audit_add_watch(struct audit_krule *krule, struct list_head **list);
 extern void audit_remove_watch_rule(struct audit_krule *krule);
 extern char *audit_watch_path(struct audit_watch *watch);
-extern int audit_watch_compare(struct audit_watch *watch, unsigned long ino,
-			       dev_t dev);
+extern int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev);
 
 extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
 						    char *pathname, int len);
 extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
 extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
 extern void audit_remove_mark_rule(struct audit_krule *krule);
-extern int audit_mark_compare(struct audit_fsnotify_mark *mark,
-			      unsigned long ino, dev_t dev);
+extern int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino,
+			      dev_t dev);
 extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old);
 extern int audit_exe_compare(struct task_struct *tsk,
 			     struct audit_fsnotify_mark *mark);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 0046f93ae91442..35753fb9029a29 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -25,7 +25,7 @@
  */
 struct audit_fsnotify_mark {
 	dev_t dev;		/* associated superblock device */
-	unsigned long ino;	/* associated inode number */
+	u64 ino;		/* associated inode number */
 	char *path;		/* insertion path */
 	struct fsnotify_mark mark; /* fsnotify mark on the inode */
 	struct audit_krule *rule;
@@ -57,7 +57,7 @@ char *audit_mark_path(struct audit_fsnotify_mark *mark)
 	return mark->path;
 }
 
-int audit_mark_compare(struct audit_fsnotify_mark *mark, unsigned long ino, dev_t dev)
+int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino, dev_t dev)
 {
 	if (mark->ino == AUDIT_INO_UNSET)
 		return 0;
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index a700e3c8925ff7..e64172dc69bd59 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -37,7 +37,7 @@ struct audit_watch {
 	refcount_t		count;	/* reference count */
 	dev_t			dev;	/* associated superblock device */
 	char			*path;	/* insertion path */
-	unsigned long		ino;	/* associated inode number */
+	u64			ino;	/* associated inode number */
 	struct audit_parent	*parent; /* associated parent */
 	struct list_head	wlist;	/* entry in parent->watches list */
 	struct list_head	rules;	/* anchor for krule->rlist */
@@ -125,7 +125,7 @@ char *audit_watch_path(struct audit_watch *watch)
 	return watch->path;
 }
 
-int audit_watch_compare(struct audit_watch *watch, unsigned long ino, dev_t dev)
+int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev)
 {
 	return (watch->ino != AUDIT_INO_UNSET) &&
 		(watch->ino == ino) &&
@@ -244,7 +244,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       unsigned long ino, unsigned invalidating)
+			       u64 ino, unsigned invalidating)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
@@ -285,7 +285,7 @@ static void audit_update_watch(struct audit_parent *parent,
 				list_del(&oentry->rule.list);
 				audit_panic("error updating watch, removing");
 			} else {
-				int h = audit_hash_ino((u32)ino);
+				int h = audit_hash_ino(ino);
 
 				/*
 				 * nentry->rule.watch == oentry->rule.watch so
@@ -439,7 +439,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 
 	audit_add_to_parent(krule, parent);
 
-	h = audit_hash_ino((u32)watch->ino);
+	h = audit_hash_ino(watch->ino);
 	*list = &audit_inode_hash[h];
 error:
 	path_put(&parent_path);
@@ -527,7 +527,7 @@ int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
 int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 {
 	struct file *exe_file;
-	unsigned long ino;
+	u64 ino;
 	dev_t dev;
 
 	/* only do exe filtering if we are recording @current events/records */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3e42d32ebb2856..40917dc4137b5a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -886,7 +886,7 @@ static int audit_filter_inode_name(struct task_struct *tsk,
 				   struct audit_names *n,
 				   struct audit_context *ctx)
 {
-	int h = audit_hash_ino((u32)n->ino);
+	int h = audit_hash_ino(n->ino);
 	struct list_head *list = &audit_inode_hash[h];
 
 	return __audit_filter_op(tsk, ctx, list, n, ctx->major);
@@ -1534,7 +1534,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		audit_log_format(ab, " name=(null)");
 
 	if (n->ino != AUDIT_INO_UNSET)
-		audit_log_format(ab, " inode=%lu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
+		audit_log_format(ab, " inode=%llu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
 				 n->ino,
 				 MAJOR(n->dev),
 				 MINOR(n->dev),
-- 
2.53.0

