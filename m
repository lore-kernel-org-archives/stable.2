Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437056;
	b=O4V6hKOlMzBHkjUpXnFEefjj0CaPGEwQqNQqatzShqjMGRWTclEn82jODS1WHFSqbrin
	 dt9lrxNTRPhnPTn+QUmFMQp+1fkNZdjVvDZGmm9yOATHMk9TwnfFnsukgQFX5epD/dbav
	 qkRlqUXp2aso4LwEcnqSlB+n5ol6GBm4Yt0rUD9hRWFK5y1wc+W8OjUaRX+p/d4Pfuxkq
	 iyhlXkw+iV5bJs1LiA3jraL/R9f9rHKgCOFMoZgrYCZIgR++mG/O4ef+GupUTTrv0wpMr
	 dpsqHJ/cq0TFLOpnIf8YnDYE3rMTKrggdO5tP9zcGt+isuOAyi2XW7oVc8zW41lgi0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437056;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2tq2mEvXsRvgKO8ZaQIF1IUjYNToq21a1wPTxHRvCEQ=;
	b=hqicPtAMQaG2svK+I4uPfpaswLNT0OlCl1Nwko4vFe/AN5eHo8/ybEthdEpRBQn0pAsF
	 z4aQwe1VOuzecZ6zX0IYeNKlOR7q3owl22A9Bs8mJ5guI5+Y80r5J/qEwBSTQF3odV5F8
	 2b5w6y/VEw85tW7Qynq9PcC1lD7Qzcx35frm0MgUNJ/0DXV1tY5pDhLMGZXpvMbjiDRkb
	 U9FwvigG0NVQ7ytK3yRmpH6XISOdPHW2DAxNeV6hleLhyMyuEzRDUmUgJSoDL+KVyCID6
	 Gw3DDnt+4bXoYJ/6EVtG3TiNClgDzugyOqT51hh//eaYB1OURB2sH3NHdfq/CCTXDSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRokIDO0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63E606B745
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRokIDO0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5956F1F00A05;
	Wed, 11 Nov 2026 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437055;
	bh=2tq2mEvXsRvgKO8ZaQIF1IUjYNToq21a1wPTxHRvCEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRokIDO07SoXld8fx7a/SPIiqjgrlSV4fVmpmf/yhSnNq6GMnH+pJ9pE9IFIxJs6h
	 feQT+B5mb20XibBuZoHeRufXHXXic/ygWU7gewuLxT1luN4YPj66GCkkEMSkzU4x+Q
	 LDzBIikWe5gKmO8Q1BRGocL/eHYVGGR4jGksgag0lZe5VoM32nWFosXRuV3hU5ORK0
	 QA2SMm9DO75Wcf2ff3B2luzBihM1g8Lxa1V2ByR2mkUKn/Nc2SQCUH28qe9X3bmD7E
	 NM1tcWq2oHyRQJBWn1Y78NwiyTNCEvVX6q7ydYogaqqA4B3AEfbooX+/4fnM+hSaIw
	 kAfc5SN/c5j9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/6] switch procfs from d_set_d_op() to d_splice_alias_ops()
Date: Wed, 11 Nov 2026 17:44:10 -0500
Message-ID: <20261111224335.80100-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111224335.80100-1-sashal@kernel.org>
References: <20261107063040-failed-5.10-eeecea75ece2@kernel.org>
 <20261111224335.80100-1-sashal@kernel.org>
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
index b4e58fb07f484..7a54625bc35f2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2685,8 +2685,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 		inode->i_fop = p->fop;
 	ei->op = p->op;
 	pid_update_inode(task, inode);
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 static struct dentry *proc_pident_lookup(struct inode *dir, 
@@ -3422,8 +3421,7 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 	set_nlink(inode, nlink_tgid);
 	pid_update_inode(task, inode);
 
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
@@ -3719,8 +3717,7 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
 	set_nlink(inode, nlink_tid);
 	pid_update_inode(task, inode);
 
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, unsigned int flags)
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index ab9f499fc749f..98d88b504478d 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -262,10 +262,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
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
index 56fc4197d92b8..cda48c98ec8cd 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -339,7 +339,6 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
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
index b7e3d36737cfe..2b233e04f53b8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -524,9 +524,8 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 			goto out;
 	}
 
-	d_set_d_op(dentry, &proc_sys_dentry_operations);
 	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
-	err = d_splice_alias(inode, dentry);
+	err = d_splice_alias_ops(inode, dentry, &proc_sys_dentry_operations);
 
 out:
 	if (h)
@@ -683,9 +682,9 @@ static bool proc_sys_fill_cache(struct file *file,
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

