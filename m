Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3E379C3F
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221145; cv=none; b=tgUFuH/NqGEnCpkU26EECfq4QCnxdON/9yIbxLrBj5EaBx9rB0JO20Q7WZyhr30C9rVsv92vEROo+dlbqXI3jtUO84aYQEFJOsZ5c04N0kEv+uNqz/79eDkDv0JfAd/FZRSqNSK3jVv38PuE9c13hbTcdxiOuCvPY2+lFRsS07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221145; c=relaxed/simple;
	bh=BXL1zj5orfRtVARKxiiVUwTv4nJkwCI+FgMtXy1vv30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnHfQRyEuL4kiPWmLs4XvQAxlz+kvJjMpxpJ8ibsSrRZKEtKeSCgifLQMpXk2if1EWgJvao5cmPe44mrh5y2KWgrnfgvAUCTUzQj/eHbI2Jy3prjnjZJpnB+f4bL/WK4VK/ewXeO7F2OPBoDTGk2KBV+ov8cMT86LNETsp2g95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQfD9NBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQfD9NBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5D51F000E9;
	Thu, 16 Jul 2026 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221139;
	bh=x+MELC6hlZolg3ShskcYJuoSbfuKF0281RcqMdY4XzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MQfD9NBWYiX+ZQdZpYUl9r+RHWSDM8AaBZKDeoPlb+vizrgoM2vRfiT+2AjwzzgUg
	 T7dxmYR/amJbJWfaYwnDzFwD/y+52rYRpHd9tP2HQLisXywko+4FVvE7n+zUJjrM3y
	 CMQCD2rz2dkgKjXrncva86mtqE/tqGuogEbhjRK0UpLp7XjmXUIzr2UrR+cXIWMnvn
	 fulcD/5rD0pLo+plkVDD00D2Je725E/OhqOolfo4WhaKrVQcc2qC35MWlwEnP63Dfv
	 dOho2/s20azY92QwOouJI1uc983QsmqL+CLV+CZT9NVK9aeDZBewcHbD2zLN5tQ5hQ
	 g/l5deCof7YVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] proc: rename proc_setattr to proc_nochmod_setattr
Date: Thu, 16 Jul 2026 12:58:55 -0400
Message-ID: <20260716165856.683482-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071446-vitality-excretion-f7c6@gregkh>
References: <2026071446-vitality-excretion-f7c6@gregkh>
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
 fs/proc/fd.c         |  6 +++---
 fs/proc/internal.h   |  4 ++--
 fs/proc/namespaces.c |  4 ++--
 fs/proc/proc_net.c   |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d444155581cabc..2c32cf455fcfc7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -721,7 +721,7 @@ static bool proc_fd_access_allowed(struct inode *inode)
 	return allowed;
 }
 
-int proc_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+int proc_nochmod_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	int error;
@@ -794,7 +794,7 @@ static int proc_pid_permission(struct mnt_idmap *idmap,
 
 
 static const struct inode_operations proc_def_inode_operations = {
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static int proc_single_show(struct seq_file *m, void *v)
@@ -1867,7 +1867,7 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
 const struct inode_operations proc_pid_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
 	.get_link	= proc_pid_get_link,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 
@@ -2317,7 +2317,7 @@ proc_map_files_get_link(struct dentry *dentry,
 static const struct inode_operations proc_map_files_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
 	.get_link	= proc_map_files_get_link,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *
@@ -2396,7 +2396,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 static const struct inode_operations proc_map_files_inode_operations = {
 	.lookup		= proc_map_files_lookup,
 	.permission	= proc_fd_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static int
@@ -2892,7 +2892,7 @@ static struct dentry *proc_##LSM##_attr_dir_lookup(struct inode *dir, \
 static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
 	.lookup		= proc_##LSM##_attr_dir_lookup, \
 	.getattr	= pid_getattr, \
-	.setattr	= proc_setattr, \
+	.setattr	= proc_nochmod_setattr, \
 }
 
 #ifdef CONFIG_SECURITY_SMACK
@@ -2951,7 +2951,7 @@ static struct dentry *proc_attr_dir_lookup(struct inode *dir,
 static const struct inode_operations proc_attr_dir_inode_operations = {
 	.lookup		= proc_attr_dir_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 #endif
@@ -3444,7 +3444,7 @@ static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *de
 static const struct inode_operations proc_tgid_base_inode_operations = {
 	.lookup		= proc_tgid_base_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 	.permission	= proc_pid_permission,
 };
 
@@ -3644,7 +3644,7 @@ static int proc_tid_comm_permission(struct mnt_idmap *idmap,
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.setattr	= proc_setattr,
+		.setattr	= proc_nochmod_setattr,
 		.permission	= proc_tid_comm_permission,
 };
 
@@ -3775,7 +3775,7 @@ static const struct file_operations proc_tid_base_operations = {
 static const struct inode_operations proc_tid_base_inode_operations = {
 	.lookup		= proc_tid_base_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *proc_task_instantiate(struct dentry *dentry,
@@ -3973,7 +3973,7 @@ static int proc_task_getattr(struct mnt_idmap *idmap,
 static const struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.getattr	= proc_task_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 	.permission	= proc_pid_permission,
 };
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 4297287f6ca09d..361833920c1836 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -104,7 +104,7 @@ static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
 
 static const struct inode_operations proc_fdinfo_file_inode_operations = {
 	.permission	= proc_fdinfo_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static const struct file_operations proc_fdinfo_file_operations = {
@@ -374,7 +374,7 @@ const struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_fd_permission,
 	.getattr	= proc_fd_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
@@ -415,7 +415,7 @@ static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
 	.permission	= proc_fdinfo_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index fe378136012076..16b1d968edfabc 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -183,8 +183,8 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
 extern const struct dentry_operations pid_dentry_operations;
 extern int pid_getattr(struct mnt_idmap *, const struct path *,
 		       struct kstat *, u32, unsigned int);
-extern int proc_setattr(struct mnt_idmap *, struct dentry *,
-			struct iattr *);
+int proc_nochmod_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
index 2ba31b6d68c077..39328b507245af 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -321,7 +321,7 @@ static int proc_tgid_net_getattr(struct mnt_idmap *idmap,
 const struct inode_operations proc_net_inode_operations = {
 	.lookup		= proc_tgid_net_lookup,
 	.getattr	= proc_tgid_net_getattr,
-	.setattr        = proc_setattr,
+	.setattr        = proc_nochmod_setattr,
 };
 
 static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
-- 
2.53.0

