Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109E29B781
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720326; cv=none; b=cicm8vRUMWKuGk3pZTQJJ2syx+G7MvBgAgbbyG5bOLVGofEqFVFDMbQtsUITon/chOQjt5AMZl9eMoq7LLucCU4Klytq2JVmDumalKfP8OlwKeI0gSlHQ3z+AmcCG+p0IDO8NulZloCkqmsWf/Tg0PQreic3g4WKW5j3ylQCLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720326; c=relaxed/simple;
	bh=7Z7V2tFRvul5lDmHYafEfqiQB1CQcxLdxzXW87JcQco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPWBVph2OwQ40euYf+FvwwKrbRLjKfb9erAl4nKMed6fSZXB+3L2GYHOcWd5m1TfPmY32nFNntFY4gE3+Rkqcq4kxKwZghP+M5gULihnzO88VPqIghY9x3dd9/Z/7X/FDvCxdP6MNgWl8fRkh1NIYBiFXx3Y8yEHmL1P6TQaqm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzXNDW0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzXNDW0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3DA1F000E9;
	Wed, 22 Jul 2026 11:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720323;
	bh=2ljfWA744/4zEOas2IgwKnAV54yqB2nz0knxf9OPQSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PzXNDW0InCbtyDgiWIc/hfb2aorhOWtiNorakkunZdEncTvfDed3ObWtexNieysRT
	 rxPy6n01+QhavwhhVkc/Uikz/N6j4AVMy+roIWRGxNyAIwYf6Vm6Q8iuorkawMk194
	 jNs+DIXwnTCCqyhs7a1dLLtKiJ0h/NuBcA0vry88+gccgJgG9BpmfyawMYGoBSLlRi
	 hcRvS5nKlM/rBoQLCkGRAW3v4OnshDDO6TyaiQ5KcKaZVnJwsAMhu//Zi4nd/OULgl
	 usPyP0T+GG+UNMpIuBmaf1EHq6bGJpw6u+gDLkSaJxuuBTRvCwNe7LRkKEhx3bvcIg
	 Tv3f4V/X+lELA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] VFS/audit: introduce kern_path_parent() for audit
Date: Wed, 22 Jul 2026 07:38:38 -0400
Message-ID: <20260722113841.1168662-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071653-tartly-scoundrel-d2b3@gregkh>
References: <2026071653-tartly-scoundrel-d2b3@gregkh>
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
index 5cc5b3e9846284..6dec38e68ce3f3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2575,6 +2575,49 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
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
index 53c03d9ed34c00..35e805c3be82e4 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -61,6 +61,7 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base,
 				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
+struct dentry *kern_path_parent(const char *name, struct path *parent);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
diff --git a/kernel/audit.h b/kernel/audit.h
index b2ef4c0d3ec033..1b65283f306875 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -274,8 +274,8 @@ extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
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
index 5cf22fe301493f..d8c6c523ed70a8 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -243,7 +243,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       unsigned long ino, unsigned invalidating)
+			       u64 ino, unsigned int invalidating)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
@@ -346,15 +346,18 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
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

