Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F663EB0FE
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306305; cv=none; b=fMIbv4Lmcj9W2pHSX9Qw0cY93iD5Q2FQNE8ydDqyssvIgdLB3okf82G6W0AgpbrOFLKCvLFW1tg3vEgOrUgPyKsKXwfQe8fb4upiLI4mRDsJOTKx26WnlVvbo9JlMeURb305iGU6QG4dmoRt0O6Yo4vkiQNZOk7CQeUs/VkkHxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306305; c=relaxed/simple;
	bh=z4MPTybjIo6DdmWkuaj0AIY6NEvuBRIeCMpxmQ+OS50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bV0OLzOAo59aEGuUd1unLnX67IkY0MighOrEGsrmf35FUFfdtYZ1CWwzKPN28VoPIajAftZPYx4h223Csm5SoGAOQ6JheXu4Bvbskjlsnz44VMdGj+oW15DKTBz73gK61RvIzACq5gPqR74gKe79AgLe3HB+fkwB4ammJtqS2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTvfM8pi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTvfM8pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2F01F00A3E;
	Fri, 17 Jul 2026 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306304;
	bh=p+AroVBjbRs7i/YFooKSNMBRCeXnzdd96gOGsfN6qlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTvfM8pikZNmjQ+vsfPl484XXWFsUgSzQ3fjiMN+oHE8KXfsEDVqXvoiLxyFm3CFz
	 rPyqlYucq4g/txvT+STNKjk0oLVTaPvOOSnVH00ci3ES7QBp9dYbZ5SytlHhjKXLmA
	 FXHusup+rNXNzSjS9giuw2/bGoqGLCmNFLq3Rufa54m1zw35LWACNWKBsinsY/VuL9
	 GZRe5pBzBVjQyRc6URmgj/amoZFH7eno8MDTIZucKxaoZszyznjK/cyFvUWyoPshJc
	 DyyttQDDbpHiGWpMnQS6FkrkBOoJsl7vQXVqnZfYjFHFFwLIOlNAZ9vhmAq3+fGTkX
	 ngoGkyLpXulIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] proc: rename proc_setattr to proc_nochmod_setattr
Date: Fri, 17 Jul 2026 12:38:20 -0400
Message-ID: <20260717163821.2035203-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717163821.2035203-1-sashal@kernel.org>
References: <2026071447-magnesium-aghast-e41f@gregkh>
 <20260717163821.2035203-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 690005b0b1e6b567c88b7790e6d90d4d6c9e09cc ]

What is currently proc_setattr is a special version added after the more
general procfs ->seattr in commit 6d76fa58b050 ("Don't allow chmod() on
the /proc/<pid>/ files").  Give it a name that reflects that to free the
proc_setattr name and better describe what is doing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260325063711.3298685-5-hch@lst.de
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 6255da28d4bb ("proc: protect ptrace_may_access() with exec_update_lock (FD links)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/base.c       | 22 +++++++++++-----------
 fs/proc/fd.c         |  4 ++--
 fs/proc/internal.h   |  2 +-
 fs/proc/namespaces.c |  4 ++--
 fs/proc/proc_net.c   |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b09cc9e6d5914e..b19c215f05597c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -720,7 +720,7 @@ static int proc_fd_access_allowed(struct inode *inode)
 	return allowed;
 }
 
-int proc_setattr(struct dentry *dentry, struct iattr *attr)
+int proc_nochmod_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	int error;
 	struct inode *inode = d_inode(dentry);
@@ -792,7 +792,7 @@ static int proc_pid_permission(struct inode *inode, int mask)
 
 
 static const struct inode_operations proc_def_inode_operations = {
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static int proc_single_show(struct seq_file *m, void *v)
@@ -1863,7 +1863,7 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
 const struct inode_operations proc_pid_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
 	.get_link	= proc_pid_get_link,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 
@@ -2311,7 +2311,7 @@ proc_map_files_get_link(struct dentry *dentry,
 static const struct inode_operations proc_map_files_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
 	.get_link	= proc_map_files_get_link,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *
@@ -2390,7 +2390,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 static const struct inode_operations proc_map_files_inode_operations = {
 	.lookup		= proc_map_files_lookup,
 	.permission	= proc_fd_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static int
@@ -2882,7 +2882,7 @@ static struct dentry *proc_##LSM##_attr_dir_lookup(struct inode *dir, \
 static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
 	.lookup		= proc_##LSM##_attr_dir_lookup, \
 	.getattr	= pid_getattr, \
-	.setattr	= proc_setattr, \
+	.setattr	= proc_nochmod_setattr, \
 }
 
 #ifdef CONFIG_SECURITY_SMACK
@@ -2941,7 +2941,7 @@ static struct dentry *proc_attr_dir_lookup(struct inode *dir,
 static const struct inode_operations proc_attr_dir_inode_operations = {
 	.lookup		= proc_attr_dir_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 #endif
@@ -3395,7 +3395,7 @@ static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *de
 static const struct inode_operations proc_tgid_base_inode_operations = {
 	.lookup		= proc_tgid_base_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 	.permission	= proc_pid_permission,
 };
 
@@ -3594,7 +3594,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.setattr	= proc_setattr,
+		.setattr	= proc_nochmod_setattr,
 		.permission	= proc_tid_comm_permission,
 };
 
@@ -3718,7 +3718,7 @@ static const struct file_operations proc_tid_base_operations = {
 static const struct inode_operations proc_tid_base_inode_operations = {
 	.lookup		= proc_tid_base_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *proc_task_instantiate(struct dentry *dentry,
@@ -3913,7 +3913,7 @@ static int proc_task_getattr(const struct path *path, struct kstat *stat,
 static const struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.getattr	= proc_task_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 	.permission	= proc_pid_permission,
 };
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index cb51763ed554b8..102a823beeb376 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -297,7 +297,7 @@ int proc_fd_permission(struct inode *inode, int mask)
 const struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_fd_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
@@ -335,7 +335,7 @@ static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
 
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 939adac4bfa3bd..71d8cbba3d4d37 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -177,7 +177,7 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
  */
 extern const struct dentry_operations pid_dentry_operations;
 extern int pid_getattr(const struct path *, struct kstat *, u32, unsigned int);
-extern int proc_setattr(struct dentry *, struct iattr *);
+int proc_nochmod_setattr(struct dentry *dentry, struct iattr *attr);
 extern void proc_pid_evict_inode(struct proc_inode *);
 extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
 extern void pid_update_inode(struct task_struct *, struct inode *);
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc78c0a12..a28b47bd87cf14 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -92,7 +92,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 static const struct inode_operations proc_ns_link_inode_operations = {
 	.readlink	= proc_ns_readlink,
 	.get_link	= proc_ns_get_link,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *proc_ns_instantiate(struct dentry *dentry,
@@ -179,5 +179,5 @@ static struct dentry *proc_ns_dir_lookup(struct inode *dir,
 const struct inode_operations proc_ns_dir_inode_operations = {
 	.lookup		= proc_ns_dir_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index b15b43d97dc9ed..7c59935f131ab4 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -310,7 +310,7 @@ static int proc_tgid_net_getattr(const struct path *path, struct kstat *stat,
 const struct inode_operations proc_net_inode_operations = {
 	.lookup		= proc_tgid_net_lookup,
 	.getattr	= proc_tgid_net_getattr,
-	.setattr        = proc_setattr,
+	.setattr        = proc_nochmod_setattr,
 };
 
 static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
-- 
2.53.0

