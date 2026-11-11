Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437024;
	b=2Yhj6RleI8rN9o6KERwFKSsNDmdif6nPDVuWxuZBpHqt0d9FojpZZ9DQ7A/gdLPOAofn
	 HaYV26+0fc3RrATnU2QFsK4+Tr2R02b6/jeDcdAbTkImmG8guR71StjCvtKSzA5LxFsCX
	 SmBkcl7E3oI45NJyfEE2LDRGssOO+mhkQQA9ZxHgQHuODUTxG1GfX6H4+OVjLPjOtkgOd
	 92bYTSwA0g7K4a4R6zFmBmBkUsJipRdjt8n+Jb62rpkULyix2i+iiXPFNz8moOiIAT2vM
	 Dy8ypbqdKTcESiwKE36HcMt9lPKVnokEytFzsf124aaKOJZdeZ42nub0vDbws8B7sDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437024;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P4bXL5fwdaBmYoGQH5fKaLcMyESUtYwF8O3L4P3Kg+U=;
	b=k64LeOVdwy6NI7rwkCErt9W6F2SrVODFoD3mcrD9bLJ07+P6Yl1IEPPCrGKtl0w59voa
	 8YHJ/UTCApgpkk4rZ0Mj0bA3Ws0onPMIetR2fBqxSC+jhG/DgZ97iAaxelX0gaMdg5PVf
	 LaVvIQlK/KmLz7kgdMU797SJOvFkerxBK6dC0IZLYkhY/taJlI7Q2ypDcJoXGOpQluZ0D
	 4xav2aV+47YEq038+b535+IejXoNA4N7sFBFdJ1o30P44SExq7gxC2DjwEaZn6ApK4JoY
	 Zya04V7PSehDZyttOAi3ijCP6Vdk+/fYAbkz/rxkpoqdpndzdhTcQ4rarDz3RUJtGYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mfr/YaST";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20EE606A88B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfr/YaST
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF411F00AD3;
	Wed, 11 Nov 2026 22:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437024;
	bh=P4bXL5fwdaBmYoGQH5fKaLcMyESUtYwF8O3L4P3Kg+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mfr/YaSTGfnwkob1kXR/DlMSUB6Galdc8rpqe0mFMbJDVoWp2yGsUGbVXjWgkaNlc
	 rgJ7n0Q5tSvf0WlXG/eCcxpj2+e6r+hxaAKWiLEZHU7r0idHnxW4m6SvWzxS6ViHvt
	 CEDDSR1Vmxdsl9+EXPXgIcxyhZlOqAiKrKJQb/BTVnwEId6bXdMIYUTJ89nMmb2+OT
	 XQmeMx+g/a39BP/OvyvJNEV5F8Lwj1SOiwaUFzMO8+7d11OXFC0gQctwp1/QEDk5Hk
	 muzRPYT1QutfCTkjVRbPcRBWnGkget6TABbEIWxxL/ghhwSfBgrE5B1nyildSIdN1A
	 S/QLB+THzl9oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] procfs: kill ->proc_dops
Date: Wed, 11 Nov 2026 17:43:38 -0500
Message-ID: <20261111224250.73064-3-sashal@kernel.org>
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

[ Upstream commit 5943c611c47c9444e834555c867dec744158b7ad ]

It has two possible values - one for "forced lookup" entries, another
for the normal ones.  We'd be better off with that as an explicit
flag anyway and in addition to that it opens some fun possibilities
with ->d_op and ->d_flags handling.

[moved PROC_ENTRY_FORCE_LOOKUP to include/linux/proc_fs.h, switched it
to an unused bit - there was a conflict]

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: eeecea75ece2 ("proc: don't let an entry below /proc/<pid>/net be a mountpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/generic.c       | 8 +++++---
 fs/proc/internal.h      | 3 +--
 include/linux/proc_fs.h | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 81756fd46c4ca..4a438f1f318d1 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -256,7 +256,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
-		d_set_d_op(dentry, de->proc_dops);
+		if (de->flags & PROC_ENTRY_FORCE_LOOKUP)
+			d_set_d_op(dentry, &proc_net_dentry_ops);
+		else
+			d_set_d_op(dentry, &proc_misc_dentry_ops);
 		return d_splice_alias(inode, dentry);
 	}
 	read_unlock(&proc_subdir_lock);
@@ -448,9 +451,8 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	INIT_LIST_HEAD(&ent->pde_openers);
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
 
-	ent->proc_dops = &proc_misc_dentry_ops;
 	/* Revalidate everything under /proc/${pid}/net */
-	if ((*parent)->proc_dops == &proc_net_dentry_ops)
+	if ((*parent)->flags & PROC_ENTRY_FORCE_LOOKUP)
 		pde_force_lookup(ent);
 
 out:
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 2c652681172b8..a51ff1a60e804 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -43,7 +43,6 @@ struct proc_dir_entry {
 		const struct proc_ops *proc_ops;
 		const struct file_operations *proc_dir_ops;
 	};
-	const struct dentry_operations *proc_dops;
 	union {
 		const struct seq_operations *seq_ops;
 		int (*single_show)(struct seq_file *, void *);
@@ -330,7 +329,7 @@ extern const struct dentry_operations proc_net_dentry_ops;
 static inline void pde_force_lookup(struct proc_dir_entry *pde)
 {
 	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
-	pde->proc_dops = &proc_net_dentry_ops;
+	pde->flags |= PROC_ENTRY_FORCE_LOOKUP;
 }
 
 /*
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 4789761707463..2d4c7e5801dee 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -27,6 +27,8 @@ enum {
 
 	PROC_ENTRY_proc_read_iter	= 1U << 1,
 	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
+
+	PROC_ENTRY_FORCE_LOOKUP		= 1U << 7,
 };
 
 struct proc_ops {
-- 
2.53.0

