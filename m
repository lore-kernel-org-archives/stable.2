Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437026;
	b=w9GOBLnv3fj0o+vQuyqn4t5EHalhqLgHTvvNqXyJSNIhQTroHSwSB4qE0kxyM5Wc7kuQ
	 TOfhFYtzwYnTpT/NBxJMOIcwNtofAVP6d1Hyzl5Dv8xTB4FhH8p8cePkvhnoyhrvNT8Yp
	 ks99RKPSs+nfJcADRsbxIKT+LS5P3UCkxbFMVaqJklp9ODm7pJsbs5m9aFTTlybu5av3y
	 3wTI0d3gd2c6ShiDlEKLJgpprutx4QDnHlOYblhkhEnGpNJgdK7gjEb7qbhShfvN7ouSr
	 wZQSC8s+/YIK4rDU1/DlxPkYjgNEMnixh1qUelwwejWau1WsJcXi4LagbfmHFlvUGnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437026;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5A8rLkjlbGDS6kgBrArp6zhzRDpG96tmxRA3hZAdZ68=;
	b=QCZ5MlELBfwMZbC52QzZ0cjkZSvY6lWfZ9CtcZCKzQsFX2G5/O/0qv0ArKyw51R6l4aw
	 YAa8FgGNAMBuH/zCkT6NfV6blUL4eg0CHLr86oehUjjHT5m4080PyAqySsqcrOzuQX+wg
	 T5WR8RxqGdXFtN8ffQFlG+hp0GVrgx53MCfh70/mdYg+DomnsAcIe8pw/wCWYb+mOFI6I
	 yJUU1gcUEHfUTUAg6WSi1wMuSUsHqMD6NkHRmIJQPbnu7rW/WvysJiZzUFnrZYUYWuZNG
	 jfWdcVrAdoNobCdPcwICnp9XX2Usu3LTbxqBuwmqC1Sj8z7pDNdrxCUvHw6IuurLvOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtM7wApR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B3606B03E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtM7wApR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696CD1F00A0D;
	Wed, 11 Nov 2026 22:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437025;
	bh=5A8rLkjlbGDS6kgBrArp6zhzRDpG96tmxRA3hZAdZ68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZtM7wApRqrQtM2PbQKxSQ5b/nUuPIy4WR6Fdc8JQWKaRJT7rfAlUhA5wigvU1Cb7I
	 /Q7RxLbMyE0SsRrerY45YsZUIdx07wgkPgmk2++x8Gs2+b0qf3Dv6hqDw9Md0CrAQB
	 PKxEmU/DtQmsaPITuEYobkkT0atxQ9GTmsTadCh8WvMAc8/n/KFz3zHCZFqnnSHOtG
	 iblAfUbXaJKVdA9fz5HA+dEf6+BDs/GXOpF3JDXIkPehO/0D5rpaX5o1SdlvDTjB+Z
	 P9jrg5SgPEfhxuU3uCTD0TG7eQQx+1ClsWxwH7eb1p9oSIELcm+pTSY/FG76pO9FP4
	 TS+idDDVPbh4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] switch procfs from d_set_d_op() to d_splice_alias_ops()
Date: Wed, 11 Nov 2026 17:43:40 -0500
Message-ID: <20261111224250.73064-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111224250.73064-1-sashal@kernel.org>
References: <20261107061331-failed-5.15-eeecea75ece2@kernel.org>
 <20261111224250.73064-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit ec169ef86ba45389b353189cf1fc06461163f667 ]

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: eeecea75ece2 ("proc: don't let an entry below /proc/<pid>/net be a mountpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/base.c        | 9 +++------
 fs/proc/generic.c     | 8 ++++----
 fs/proc/internal.h    | 3 +--
 fs/proc/namespaces.c  | 3 +--
 fs/proc/proc_sysctl.c | 7 +++----
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b0b99219a2ad0..015db2b964b7d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2690,8 +2690,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 		inode->i_fop = p->fop;
 	ei->op = p->op;
 	pid_update_inode(task, inode);
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 static struct dentry *proc_pident_lookup(struct inode *dir, 
@@ -3430,8 +3429,7 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 	set_nlink(inode, nlink_tgid);
 	pid_update_inode(task, inode);
 
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
@@ -3731,8 +3729,7 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
 	set_nlink(inode, nlink_tid);
 	pid_update_inode(task, inode);
 
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, unsigned int flags)
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 4a438f1f318d1..e88a274269cbb 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -257,10 +257,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
 		if (de->flags & PROC_ENTRY_FORCE_LOOKUP)
-			d_set_d_op(dentry, &proc_net_dentry_ops);
-		else
-			d_set_d_op(dentry, &proc_misc_dentry_ops);
-		return d_splice_alias(inode, dentry);
+			return d_splice_alias_ops(inode, dentry,
+						  &proc_net_dentry_ops);
+		return d_splice_alias_ops(inode, dentry,
+					  &proc_misc_dentry_ops);
 	}
 	read_unlock(&proc_subdir_lock);
 	return ERR_PTR(-ENOENT);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a51ff1a60e804..49e34d94b9c64 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -340,7 +340,6 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
 static inline struct dentry *proc_splice_unmountable(struct inode *inode,
 		struct dentry *dentry, const struct dentry_operations *d_ops)
 {
-	d_set_d_op(dentry, d_ops);
 	dont_mount(dentry);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, d_ops);
 }
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 203d3363e3d5a..9f4bb90a536e6 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -125,8 +125,7 @@ static struct dentry *proc_ns_instantiate(struct dentry *dentry,
 	ei->ns_ops = ns_ops;
 	pid_update_inode(task, inode);
 
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 static int proc_ns_dir_readdir(struct file *file, struct dir_context *ctx)
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7f7ffbc9276c5..780d182d75425 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -522,9 +522,8 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 			goto out;
 	}
 
-	d_set_d_op(dentry, &proc_sys_dentry_operations);
 	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
-	err = d_splice_alias(inode, dentry);
+	err = d_splice_alias_ops(inode, dentry, &proc_sys_dentry_operations);
 
 out:
 	if (h)
@@ -681,9 +680,9 @@ static bool proc_sys_fill_cache(struct file *file,
 			return false;
 		if (d_in_lookup(child)) {
 			struct dentry *res;
-			d_set_d_op(child, &proc_sys_dentry_operations);
 			inode = proc_sys_make_inode(dir->d_sb, head, table);
-			res = d_splice_alias(inode, child);
+			res = d_splice_alias_ops(inode, child,
+						 &proc_sys_dentry_operations);
 			d_lookup_done(child);
 			if (unlikely(res)) {
 				if (IS_ERR(res)) {
-- 
2.53.0

