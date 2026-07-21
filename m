Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F401472F9C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678348; cv=none; b=sxCpcuqNX+OeeukLWaGp2hhZBN4lf3E8ggTya4oxMknM1QXw9OaRTpb81KcMi9jXl6ZaCrsU4KnL3UcUoM6ghRQBXD/1pbO4KuVy5ut5q1AJzafQhYHf+5x2PmIAhI0hF9GSMeuwK6jTQ6rK+XsTcKcbqvCOuoDGwIdwFzls20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678348; c=relaxed/simple;
	bh=udUjPN2eS+KDVZegLoTMTWiZ+cFMfLe99MzccEZOgCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0AzkJLDKFmN/MlTgDhGa1CndFAxXmH1Vkg4aw1vxkSCSOb/xUzc6A3XdR+EU73J53oovStcmA3PUvH8YS3KM3//TnrUK9NYMIYmstlKkNj1fa8fGYDJQPlKqYzniGxaYkW1fnlpRqWTCyYDdbN12ckKk9RDjecibcQmMwaFg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuBABsOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuBABsOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8456D1F00A3D;
	Tue, 21 Jul 2026 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678347;
	bh=Z4aRVgTs+V+GDyYkWrnavPaTpHiURBqrD8KGCGtAEeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kuBABsOmKsScoW2u/wMlIwbK+OleUsY/MfVPP1CX/xr4qzjT3HNiuqB67mgVLLmpW
	 ry/nbl/tfcWsqq7Uf4Vm7FTrtBXdZuPXoC1O6BczABs8uVQ/Bg7FzfUtwM9i14BSB7
	 jl2nQZ4wDVwK5itOXRyfkiRFsR9SVVUpkuJ0lbQmJh1bTMv76wBzPW+bChfLuhE5il
	 LtsYIzyvNRiPOb9Xb8meEhcNc08jPcEBakSOYdSKMYDks/tPjSGVBssa1VtvB90xxT
	 ILp2dESQsF8zs3cOAbIXF7hc2hPjk+kHdoo/25RywMid4psuYsibJcHL/Ba1XBgRla
	 KaO8K7FrdWA0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] audit: widen ino fields to u64
Date: Tue, 21 Jul 2026 19:59:02 -0400
Message-ID: <20260721235904.525962-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721235904.525962-1-sashal@kernel.org>
References: <2026071650-cycle-stray-bbb5@gregkh>
 <20260721235904.525962-1-sashal@kernel.org>
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
 kernel/audit.h          |  9 ++++-----
 kernel/audit_fsnotify.c |  2 +-
 kernel/audit_watch.c    | 10 +++++-----
 kernel/auditsc.c        |  4 ++--
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 73fb8a4bcf2ae6..85ac6e739c66c7 100644
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
index 99afd1c58ebc9f..e7610428ee448b 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -75,7 +75,7 @@ struct audit_names {
 	int			name_len;	/* number of chars to log */
 	bool			hidden;		/* don't log this record */
 
-	unsigned long		ino;
+	u64			ino;
 	dev_t			dev;
 	umode_t			mode;
 	kuid_t			uid;
@@ -219,9 +219,9 @@ extern int auditd_test_task(struct task_struct *task);
 #define AUDIT_INODE_BUCKETS	32
 extern struct list_head audit_inode_hash[AUDIT_INODE_BUCKETS];
 
-static inline int audit_hash_ino(u32 ino)
+static inline int audit_hash_ino(u64 ino)
 {
-	return (ino & (AUDIT_INODE_BUCKETS-1));
+	return ((u32)ino & (AUDIT_INODE_BUCKETS-1));
 }
 
 /* Indicates that audit should log the full pathname. */
@@ -271,8 +271,7 @@ extern int audit_to_watch(struct audit_krule *krule, char *path, int len,
 extern int audit_add_watch(struct audit_krule *krule, struct list_head **list);
 extern void audit_remove_watch_rule(struct audit_krule *krule);
 extern char *audit_watch_path(struct audit_watch *watch);
-extern int audit_watch_compare(struct audit_watch *watch, unsigned long ino,
-			       dev_t dev);
+extern int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev);
 
 extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
 						    char *pathname, int len);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 2b237895157d6e..35753fb9029a29 100644
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
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 5303c5f6e82d6d..f7b101e71d002a 100644
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
index 3b3ca37343490c..25a3f17e647bb7 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -884,7 +884,7 @@ static int audit_filter_inode_name(struct task_struct *tsk,
 				   struct audit_names *n,
 				   struct audit_context *ctx)
 {
-	int h = audit_hash_ino((u32)n->ino);
+	int h = audit_hash_ino(n->ino);
 	struct list_head *list = &audit_inode_hash[h];
 
 	return __audit_filter_op(tsk, ctx, list, n, ctx->major);
@@ -1549,7 +1549,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		audit_log_format(ab, " name=(null)");
 
 	if (n->ino != AUDIT_INO_UNSET)
-		audit_log_format(ab, " inode=%lu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
+		audit_log_format(ab, " inode=%llu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
 				 n->ino,
 				 MAJOR(n->dev),
 				 MINOR(n->dev),
-- 
2.53.0

