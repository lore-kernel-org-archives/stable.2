Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D52339366
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716253; cv=none; b=XN0o7xlwMHiDKkWevfKaXGji37IN0bcDD0qlmWdSMtc6DsrNvjvSFjDZDqPQzIIESWMzLn9BjRWW7UZWbRkgqwWtjPvUVF3DZ6acGg+MwycZYGzgKT2ko8IZ9287Gnwe7k7nZ5DOz9Fi7ddwX9WdPUcDCswScUvD0vSJJgxSrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716253; c=relaxed/simple;
	bh=VoEanVfBKpy2JtZasogS0CNJ94qeuMONEFJVaJVgY+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1tJzWcIGRsZgQL1KDMUaM5lJA9+1HN2uQmrijoTCJhkztWi2zAhLzg4ChSO8Z7ntD083USPJI14sIdjzcqAbycMusQMsNjKknjZ/oywpHNP1uQitMOG+R/Hysb3LFznQ3w++7ODn/b2wJGsyxfQoCwgRAy9DCdXefZQHSkVYBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYNixXof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYNixXof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E742A1F00A3D;
	Wed, 22 Jul 2026 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716251;
	bh=ZoZV67FU1+trwM124c8fr9D9qUwmUA7A9JIiG1TFuOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CYNixXofxmzEgSo4n+kBucTC5pp9W/bbqeIv4IJCpMwQkENYXZn1QqHd+gBL0+VQU
	 Qjs2mcOcnveVVHAzyFybXieTbVMP3R5YOu1MFplqc3gbBGTgugjT81iDgZB4aOp6lN
	 MkrUaoYkrNOH+lMomvbV7S6lq9Gpq4+zZKmwTQmFaM1Xo+leW+61ejN00JiUhvu7Qj
	 Mwamg6/u/1zMjHfcf5wPl7w/1EZ3AcF0BLeYq3MlDpY6RWEaNeCSRJY+fiIjXcLHlK
	 NjZ+UozmS2WtkdIqG9B/eaVsZ5D8hIG7csbeVuvSk9qtsXe6Ca2rIqRt5E/8FyazA8
	 tcHfQeG4YK8KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] audit: widen ino fields to u64
Date: Wed, 22 Jul 2026 06:30:46 -0400
Message-ID: <20260722103048.891900-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722103048.891900-1-sashal@kernel.org>
References: <2026071652-lying-deacon-92a0@gregkh>
 <20260722103048.891900-1-sashal@kernel.org>
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
index e952868c8d2e9c..c86c2280231b72 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -15,7 +15,7 @@
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 
-#define AUDIT_INO_UNSET ((unsigned long)-1)
+#define AUDIT_INO_UNSET ((u64)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
 
 struct audit_sig_info {
diff --git a/kernel/audit.h b/kernel/audit.h
index 0232798e38b3d6..c104c6f9d1d762 100644
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
index 60f5daebc5ef83..c3a665fd635e22 100644
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
index fb16fcf5b79880..a509e58db55442 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -868,7 +868,7 @@ static void audit_filter_syscall(struct task_struct *tsk,
 static int audit_filter_inode_name(struct task_struct *tsk,
 				   struct audit_names *n,
 				   struct audit_context *ctx) {
-	int h = audit_hash_ino((u32)n->ino);
+	int h = audit_hash_ino(n->ino);
 	struct list_head *list = &audit_inode_hash[h];
 	struct audit_entry *e;
 	enum audit_state state;
@@ -1545,7 +1545,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		audit_log_format(ab, " name=(null)");
 
 	if (n->ino != AUDIT_INO_UNSET)
-		audit_log_format(ab, " inode=%lu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
+		audit_log_format(ab, " inode=%llu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
 				 n->ino,
 				 MAJOR(n->dev),
 				 MINOR(n->dev),
-- 
2.53.0

