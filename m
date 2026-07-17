Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B2041A913
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296822; cv=none; b=llZIi7tyJeItdmfW26j3M3vDRUhK1mkS8+IKwyqplSIN5FTGCY0kcFRIXesODQBXQU6fEvQs/sLVC5KxsDqek39M1GIt+Pq/S37JjPS3GLfNx6Lhc2mZwdyyd25sw9B6mFQXcEDrgw7e+Jn4yBbzJvf7QtCecqnEgNuiHWJR7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296822; c=relaxed/simple;
	bh=Gv1ieTaR+bYzUDfCWp3Url56mqsf6ZWkYaAZqQMuDh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGEWPjRIgtnuvaSPf7Y8qT7e4b2zK1BrVJMj3W9bJD+P0gmLcXaARX2SzTjOKLE7G9JtE0/gkL33ShnzZjZ7UOUMyxRdBalcPJcdEMvX3YJuSbnrgKHUYRqImBFuyhjFIc+qyYEywdhT7QUJrKHnuCMnpTAAXUzMwo43LyQrT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX4muKRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX4muKRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213DF1F000E9;
	Fri, 17 Jul 2026 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296820;
	bh=WeiJ97eJr5E9j46+RPqqSipeirDTFz071qMvP+wZGv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FX4muKRCNI4RoMzZm+NNSt3L8yLf025Md6C7cTWGaiLnwv9Jp/w1DMMtXnU03FY6f
	 BLcClATWSndK4gZBX98f/XIKYQhUvuvyDiUc0dTazMXwKVpFduqCtfpMqRkRvkwQ7A
	 /qHuL8xfXn4XE2jBbZbqkI9SHAyqBfjWmNa98OCPhsVka1rb5aetbM33epuMdWKBOx
	 p42LuC2vRkQ4y/dNxGL+k2WzrhNlX3JG5DycjUIRc6BYvlpqQ9E9aNMMQ5hSxDQj9D
	 9JZLzl8hMvvQ6BR95CSFPIKVnNv2cf5HKMWI+9rvnMPhgjcXKQYossqUKWMV7bKlXr
	 rWlKcjV5Hdomg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] proc: rename proc_setattr to proc_nochmod_setattr
Date: Fri, 17 Jul 2026 10:00:15 -0400
Message-ID: <20260717140016.1717138-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717140016.1717138-1-sashal@kernel.org>
References: <2026071447-twitter-wick-5966@gregkh>
 <20260717140016.1717138-1-sashal@kernel.org>
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
 fs/proc/fd.c         | 12 ++++++------
 fs/proc/internal.h   |  4 ++--
 fs/proc/namespaces.c |  4 ++--
 fs/proc/proc_net.c   |  2 +-
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 3405005199b613..93b0b5e89d0803 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -721,7 +721,7 @@ static int proc_fd_access_allowed(struct inode *inode)
 	return allowed;
 }
 
-int proc_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int proc_nochmod_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	int error;
@@ -795,7 +795,7 @@ static int proc_pid_permission(struct user_namespace *mnt_userns,
 
 
 static const struct inode_operations proc_def_inode_operations = {
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static int proc_single_show(struct seq_file *m, void *v)
@@ -1868,7 +1868,7 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
 const struct inode_operations proc_pid_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
 	.get_link	= proc_pid_get_link,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 
@@ -2316,7 +2316,7 @@ proc_map_files_get_link(struct dentry *dentry,
 static const struct inode_operations proc_map_files_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
 	.get_link	= proc_map_files_get_link,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *
@@ -2395,7 +2395,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 static const struct inode_operations proc_map_files_inode_operations = {
 	.lookup		= proc_map_files_lookup,
 	.permission	= proc_fd_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static int
@@ -2887,7 +2887,7 @@ static struct dentry *proc_##LSM##_attr_dir_lookup(struct inode *dir, \
 static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
 	.lookup		= proc_##LSM##_attr_dir_lookup, \
 	.getattr	= pid_getattr, \
-	.setattr	= proc_setattr, \
+	.setattr	= proc_nochmod_setattr, \
 }
 
 #ifdef CONFIG_SECURITY_SMACK
@@ -2946,7 +2946,7 @@ static struct dentry *proc_attr_dir_lookup(struct inode *dir,
 static const struct inode_operations proc_attr_dir_inode_operations = {
 	.lookup		= proc_attr_dir_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 #endif
@@ -3403,7 +3403,7 @@ static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *de
 static const struct inode_operations proc_tgid_base_inode_operations = {
 	.lookup		= proc_tgid_base_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 	.permission	= proc_pid_permission,
 };
 
@@ -3603,7 +3603,7 @@ static int proc_tid_comm_permission(struct user_namespace *mnt_userns,
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.setattr	= proc_setattr,
+		.setattr	= proc_nochmod_setattr,
 		.permission	= proc_tid_comm_permission,
 };
 
@@ -3730,7 +3730,7 @@ static const struct file_operations proc_tid_base_operations = {
 static const struct inode_operations proc_tid_base_inode_operations = {
 	.lookup		= proc_tid_base_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *proc_task_instantiate(struct dentry *dentry,
@@ -3926,7 +3926,7 @@ static int proc_task_getattr(struct user_namespace *mnt_userns,
 static const struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.getattr	= proc_task_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 	.permission	= proc_pid_permission,
 };
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 1cb1f0dbe59e06..6da3da68d5e6e4 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -82,8 +82,8 @@ static int seq_fdinfo_open(struct inode *inode, struct file *file)
  * that the current task has PTRACE_MODE_READ in addition to the normal
  * POSIX-like checks.
  */
-static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
-				  int mask)
+static int proc_fdinfo_permission(struct user_namespace *mnt_userns,
+				  struct inode *inode, int mask)
 {
 	bool allowed = false;
 	struct task_struct *task = get_proc_task(inode);
@@ -97,12 +97,12 @@ static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
 	if (!allowed)
 		return -EACCES;
 
-	return generic_permission(idmap, inode, mask);
+	return generic_permission(mnt_userns, inode, mask);
 }
 
 static const struct inode_operations proc_fdinfo_file_inode_operations = {
 	.permission	= proc_fdinfo_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static const struct file_operations proc_fdinfo_file_operations = {
@@ -328,7 +328,7 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
 const struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_fd_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
@@ -369,7 +369,7 @@ static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
 	.permission	= proc_fdinfo_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 407a3c54c27bd3..4020245a89c233 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -178,8 +178,8 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
 extern const struct dentry_operations pid_dentry_operations;
 extern int pid_getattr(struct user_namespace *, const struct path *,
 		       struct kstat *, u32, unsigned int);
-extern int proc_setattr(struct user_namespace *, struct dentry *,
-			struct iattr *);
+int proc_nochmod_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+			struct iattr *attr);
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
index 06ae48da253c8c..4b4d8bf608f72b 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -311,7 +311,7 @@ static int proc_tgid_net_getattr(struct user_namespace *mnt_userns,
 const struct inode_operations proc_net_inode_operations = {
 	.lookup		= proc_tgid_net_lookup,
 	.getattr	= proc_tgid_net_getattr,
-	.setattr        = proc_setattr,
+	.setattr        = proc_nochmod_setattr,
 };
 
 static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
-- 
2.53.0

