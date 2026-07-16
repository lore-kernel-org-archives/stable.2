Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1087C384CF7
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220326; cv=none; b=q7SNoDXg8q8gTXUKMjy6qaMGdXYqYICITCBHqCGvxrqqTJr9aw7Ac3dOW07H5z2XGBnQ+sPsZbR91kaf+vtfQLUU/+yLOOPB20FYz7hB+ePqGSMyx0vyyMshbCi503AJy4enHwlAVmCriXygrZbb40dn+EejNkgBHArlMSNR528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220326; c=relaxed/simple;
	bh=ytvR8/Z12x1Q09JvbMCym81pQeD1BjTGyn9J7l7wCus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgOWTIEcJyChIPPZZiUsw1b6zPHdiAqWPsJl2aIIQSuXmmJes2hR6xlqmzTQ/hwESBcvkOfF6tpA/5Jfy+Pg66QrvStujVX+UxU43cURZC35LSYDZrhgVuXZyQkBt6WjbxRY17cwNjg+/YH0s4A1Il3fV+tLtbjfBiSvAbefzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyIqSW/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyIqSW/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86811F000E9;
	Thu, 16 Jul 2026 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220316;
	bh=91DP6tTRKG/zrFEmFAjbIXgSBBKzelM4cLJS9631CVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyIqSW/LZgB791bFGQnbsrQdFOXDd+3L3KX/+wPPEkRg+pZHbZhLenEAzpgiDwTSD
	 hbCrVDzu8M0PUb2oWgDaKTQNQsCjgQdZsWM3BboAKg4gS0e5NzzMcZKYpOk9wea0aV
	 wf4HfS/Axm8JvDDMr4Zpr7QvlI6t3R//3Hf5ANymdPIVp4wupe5aaTcNZo7wyDXyGH
	 Izv1iC6SfhPbIBZqsSQiRVgr92AQwfWFWFla0577elqo6hL8A47IuQcVUuzNTTneX2
	 DOPdZGBq5GRyceA3wEqsJqZ/hUCJG4vEYZ6Y6MgodlUk+R6vTBGMCv1FHEwWPnC7Jz
	 nPKrzTu9p8trg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] proc: rename proc_setattr to proc_nochmod_setattr
Date: Thu, 16 Jul 2026 12:45:13 -0400
Message-ID: <20260716164514.668766-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071446-art-flip-74fe@gregkh>
References: <2026071446-art-flip-74fe@gregkh>
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
index a314fd9af17c08..998c6cce77c192 100644
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
@@ -1866,7 +1866,7 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
 const struct inode_operations proc_pid_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
 	.get_link	= proc_pid_get_link,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 
@@ -2319,7 +2319,7 @@ proc_map_files_get_link(struct dentry *dentry,
 static const struct inode_operations proc_map_files_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
 	.get_link	= proc_map_files_get_link,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *
@@ -2398,7 +2398,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 static const struct inode_operations proc_map_files_inode_operations = {
 	.lookup		= proc_map_files_lookup,
 	.permission	= proc_fd_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static int
@@ -2885,7 +2885,7 @@ static struct dentry *proc_##LSM##_attr_dir_lookup(struct inode *dir, \
 static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
 	.lookup		= proc_##LSM##_attr_dir_lookup, \
 	.getattr	= pid_getattr, \
-	.setattr	= proc_setattr, \
+	.setattr	= proc_nochmod_setattr, \
 }
 
 #ifdef CONFIG_SECURITY_SMACK
@@ -2944,7 +2944,7 @@ static struct dentry *proc_attr_dir_lookup(struct inode *dir,
 static const struct inode_operations proc_attr_dir_inode_operations = {
 	.lookup		= proc_attr_dir_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 #endif
@@ -3460,7 +3460,7 @@ static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *de
 static const struct inode_operations proc_tgid_base_inode_operations = {
 	.lookup		= proc_tgid_base_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 	.permission	= proc_pid_permission,
 };
 
@@ -3659,7 +3659,7 @@ static int proc_tid_comm_permission(struct mnt_idmap *idmap,
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.setattr	= proc_setattr,
+		.setattr	= proc_nochmod_setattr,
 		.permission	= proc_tid_comm_permission,
 };
 
@@ -3788,7 +3788,7 @@ static const struct file_operations proc_tid_base_operations = {
 static const struct inode_operations proc_tid_base_inode_operations = {
 	.lookup		= proc_tid_base_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *proc_task_instantiate(struct dentry *dentry,
@@ -4001,7 +4001,7 @@ static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
 static const struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.getattr	= proc_task_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 	.permission	= proc_pid_permission,
 };
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 9eeccff49b2abf..8a48ff4a19ecb3 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -102,7 +102,7 @@ static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
 
 static const struct inode_operations proc_fdinfo_file_inode_operations = {
 	.permission	= proc_fdinfo_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static const struct file_operations proc_fdinfo_file_operations = {
@@ -361,7 +361,7 @@ const struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_fd_permission,
 	.getattr	= proc_fd_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
@@ -402,7 +402,7 @@ static int proc_fdinfo_iterate(struct file *file, struct dir_context *ctx)
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
 	.permission	= proc_fdinfo_permission,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index d1598576506c1e..2807306004e5e6 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -257,8 +257,8 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
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
index ea2b597fd92cdb..39f4169f669f63 100644
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
@@ -178,5 +178,5 @@ static struct dentry *proc_ns_dir_lookup(struct inode *dir,
 const struct inode_operations proc_ns_dir_inode_operations = {
 	.lookup		= proc_ns_dir_lookup,
 	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	.setattr	= proc_nochmod_setattr,
 };
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 52f0b75cbce2ca..184cddeb8215cb 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -322,7 +322,7 @@ static int proc_tgid_net_getattr(struct mnt_idmap *idmap,
 const struct inode_operations proc_net_inode_operations = {
 	.lookup		= proc_tgid_net_lookup,
 	.getattr	= proc_tgid_net_getattr,
-	.setattr        = proc_setattr,
+	.setattr        = proc_nochmod_setattr,
 };
 
 static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
-- 
2.53.0

