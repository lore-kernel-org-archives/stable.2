Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CE336EDA
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681480; cv=none; b=mroLIH2hsX3UksH/2HE5GfzcOVQfMNn7c3kcF9cHsWd6fus0kDVCQWWwrQlYVJISG6y5W+L6JTM2BUHvcOBnrgIDX20PY6Cft8WeKUoFsk2bHWmBSqlvIdZM9RErVXtpw+Rr3ClMCXYaGKpTs3htAZQYgdRpqmFBwaL9gy5G5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681480; c=relaxed/simple;
	bh=bum2pqc0LGl20DsYmJccD8QoaP+/GTRpmsYAh78himg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFXuEmBVigZIGEtd707eFnvykG7RWJsmrjcNxhWobwa/XyYoXw9AB64uQn70n0jt3VK9ku1Joe5JajcAYQCUEgYhUT6+taMdpEa+VWrBcJ5WdKg0M7vGfd+CxTGOxAGbPO/oPqs1ZHBWBLRcmMdDnQ4Y5VY34UIXnEcU3/2U6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk0rSYA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk0rSYA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F5E1F00A3E;
	Wed, 22 Jul 2026 00:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681478;
	bh=Er0XtKZPHO3zx42u061iXRwi2L9UUGIgT1kJjLiAHXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nk0rSYA5PAJF48IDnYQTQ/lzEGcw2gyxarYQSAJxoypO8ueAd/f5Q19QJAlEUGIoo
	 VjTTPg8pXmKSKnQC95ybL8hogNliE2wyZdlHDXBqQM9m5PJqDKWw61BQ2t9vjO8CU4
	 7Gg3Zxed7JGK6tQTlVUcj/wpTLYCrChW63c0/aI+NYufHuOyzfPhywKJO48QP/xvEE
	 A6UIxWyyenDHCm1vKgROpKP2KvpOcx8Ahl4GG+meaazI9T7VGe6SM0DZLOUZEZ5eGC
	 HhqWzzot5Qmdvv9yq8FYw6GPo5A6lMDRWbvn/S6gIjJtbg+5hJ47hvNEZeCWALHJPH
	 jhvMG8W5skSww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] audit: widen ino fields to u64
Date: Tue, 21 Jul 2026 20:51:13 -0400
Message-ID: <20260722005116.605624-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722005116.605624-1-sashal@kernel.org>
References: <2026071651-dismount-trapped-aafe@gregkh>
 <20260722005116.605624-1-sashal@kernel.org>
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
index 517c665da25975..4b060b0f3d70cd 100644
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
index bb3cea8c71488f..575551b50b3d14 100644
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

