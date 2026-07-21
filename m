Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC64746A2
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678348; cv=none; b=PKdoPjFGhFkcTZXP5qNAjKTl8zOSl3zOC/dbgnxjp04ylzR4p7pXsotw8JsWo/+alOchHchdxVIAtD98P+RqfvzHeHvkuixDqnzJ8la6lQ2VUIwi89HkP8+HS1Mtm2RgtwMPV/5GAJBzbs8RQbHcwPvY4HQaFlbMqhda88QAVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678348; c=relaxed/simple;
	bh=Rmf6lTH5UJxIVKmGYcHE1fd0RNnacPBm+pxPxQxc9No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/mx6yijOA/v+jDDySLTTgPj2pJN3hkkzNBITqRcf6je0jxYEeWSz1rJoSLj6nRHu86TvIZa9S3/cH6N+ai3vN1gySVejQX0CstclGu8Umk2I3DdbxXkr4qktQodq/+LUdmkDyNhXr+4mBccvUZCT52nX4RcI9/QsmtCU5i1XNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4NNePll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4NNePll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45931F000E9;
	Tue, 21 Jul 2026 23:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678346;
	bh=qjHySF4fjRRyWlBL2GWaefgGqD8MABPHzK4DN6YE0B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k4NNePllP8fypBjuZpjiu9TtS7/YfUjCtAwFJoXmAAk12VyXoGJf5VBW2Bx5lPY8H
	 k2S3lHC0MgQSMgbi1EJ4kE1Stwmz8jyHRx+lGAPj1wNxiycsdvuQCVuXaVPkGUfvv1
	 iTG5b9bUyLf8+kRSq5DA+xeG6qkyzcWpb3OC0plGSJrBxOigcM6jXBOgQ80Fy2uuye
	 MsE/SravBGV/w6fubv8laFyLptyerjMotT2mNDI5KGUKTqD6TV9164uk59+SL5UXs8
	 3OVpA/1HnAwO1TXbjdMpZmrmf4jbQTJCPGFjeWacydNxd10CA8IbdYcq8jNHqB2gZB
	 k8B+EOWwiKvLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] VFS/audit: introduce kern_path_parent() for audit
Date: Tue, 21 Jul 2026 19:59:01 -0400
Message-ID: <20260721235904.525962-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071650-cycle-stray-bbb5@gregkh>
References: <2026071650-cycle-stray-bbb5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

[ Upstream commit 76a53de6f7ff0641570364234fb4489f4d4fc8e9 ]

audit_alloc_mark() and audit_get_nd() both need to perform a path
lookup getting the parent dentry (which must exist) and the final
target (following a LAST_NORM name) which sometimes doesn't need to
exist.

They don't need the parent to be locked, but use kern_path_locked() or
kern_path_locked_negative() anyway.  This is somewhat misleading to the
casual reader.

This patch introduces a more targeted function, kern_path_parent(),
which returns not holding locks.  On success the "path" will
be set to the parent, which must be found, and the return value is the
dentry of the target, which might be negative.

This will clear the way to rename kern_path_locked() which is
otherwise only used to prepare for removing something.

It also allows us to remove kern_path_locked_negative(), which is
transformed into the new kern_path_parent().

Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 81905b5acbe7 ("audit: fix recursive locking deadlock in audit_dupe_exe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namei.c              | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h   |  1 +
 kernel/audit.h          |  4 ++--
 kernel/audit_fsnotify.c |  9 +++------
 kernel/audit_watch.c    |  9 ++++++---
 5 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1eb20cb5e58f9e..c9b969960021c9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2700,6 +2700,49 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 	return d;
 }
 
+/**
+ * kern_path_parent: lookup path returning parent and target
+ * @name: path name
+ * @path: path to store parent in
+ *
+ * The path @name should end with a normal component, not "." or ".." or "/".
+ * A lookup is performed and if successful the parent information
+ * is store in @parent and the dentry is returned.
+ *
+ * The dentry maybe negative, the parent will be positive.
+ *
+ * Returns:  dentry or error.
+ */
+struct dentry *kern_path_parent(const char *name, struct path *path)
+{
+	struct filename *filename = getname_kernel(name);
+	struct path parent_path;
+	struct dentry *d;
+	struct qstr last;
+	int type, error;
+
+	error = filename_parentat(AT_FDCWD, filename, 0, &parent_path, &last, &type);
+	if (error) {
+		d = ERR_PTR(error);
+		goto out;
+	}
+	if (unlikely(type != LAST_NORM)) {
+		path_put(&parent_path);
+		d = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	d = lookup_one_len_unlocked(last.name, parent_path.dentry, last.len);
+	if (IS_ERR(d)) {
+		path_put(&parent_path);
+		goto out;
+	}
+	*path = parent_path;
+out:
+	putname(filename);
+	return d;
+}
+
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 8ec8fed3bce81d..5012eb604f7b9e 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -56,6 +56,7 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base,
 				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
+struct dentry *kern_path_parent(const char *name, struct path *parent);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
diff --git a/kernel/audit.h b/kernel/audit.h
index 5156ecd3545733..99afd1c58ebc9f 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -279,8 +279,8 @@ extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
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
index c565fbf66ac876..2b237895157d6e 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -57,7 +57,7 @@ char *audit_mark_path(struct audit_fsnotify_mark *mark)
 	return mark->path;
 }
 
-int audit_mark_compare(struct audit_fsnotify_mark *mark, unsigned long ino, dev_t dev)
+int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino, dev_t dev)
 {
 	if (mark->ino == AUDIT_INO_UNSET)
 		return 0;
@@ -76,17 +76,14 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	struct audit_fsnotify_mark *audit_mark;
 	struct path path;
 	struct dentry *dentry;
-	struct inode *inode;
 	int ret;
 
 	if (pathname[0] != '/' || pathname[len-1] == '/')
 		return ERR_PTR(-EINVAL);
 
-	dentry = kern_path_locked(pathname, &path);
+	dentry = kern_path_parent(pathname, &path);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry); /* returning an error */
-	inode = path.dentry->d_inode;
-	inode_unlock(inode);
 
 	audit_mark = kzalloc(sizeof(*audit_mark), GFP_KERNEL);
 	if (unlikely(!audit_mark)) {
@@ -100,7 +97,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
 	if (ret < 0) {
 		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 7f358740e95826..5303c5f6e82d6d 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -244,7 +244,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       unsigned long ino, unsigned invalidating)
+			       u64 ino, unsigned int invalidating)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
@@ -347,15 +347,18 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
 /* Get path information necessary for adding watches. */
 static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 {
-	struct dentry *d = kern_path_locked(watch->path, parent);
+	struct dentry *d;
+
+	d = kern_path_parent(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
+
 	if (d_is_positive(d)) {
 		/* update watch filter fields */
 		watch->dev = d->d_sb->s_dev;
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
-	inode_unlock(d_backing_inode(parent->dentry));
+
 	dput(d);
 	return 0;
 }
-- 
2.53.0

