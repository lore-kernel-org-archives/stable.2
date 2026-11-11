Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437054;
	b=nnQEsTQJovah37w6SDHKfhvesFNUdHJWrDDcJ/9b4DoFf6Pc4dA67AL1UHa5B5+IWmdz
	 AZJooUHkQIaZZp8qvnV2FKfufdKSz7V5NckH7yQx5V+GKLTHCghlrt+35IaNO3K1oWe/d
	 pCLwyNwm2h49NGOrS84cA2S7d6ulrtve8ghbknk2ngCCS+7qyTeBkBlRnglEs+iUcDCJ+
	 vs0BNVdv1tWwc62Jl9JmtIp9I0ApfaErfzy8no3i5+Z9PWmZEcTzZm+W6+Q10g4SSvYBt
	 Qq2sO7VWkjDJAK0B6CwwfGabbN30nSgZpUFI1xLnM4RnxfjLC/5xgJbQHwAub0/XBzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a54Wr9rMAqzqgyTpfn0tZqG6zvtV3tRgDmxyD0rSuIY=;
	b=vEYMxn1coyKI97CSZfNiRc19rYB+LFm5kLf4fmhLyDc9jUymuGsiIuTA5kQ5NLNGc9K2
	 Bv8zMoObBKuVr6SsUI5UNThH5+3KDIQRgErqIZ82b/UWJYNWlkE5dVkjOXemst7aLNNTq
	 7fWYGC4OSpwX6JKrsiOcQltyylq7NnGip/lLu8lJIxv55sl2DZ63c2GRn/lsSF3mojI+4
	 fsjixxhsDSQnKfNWvLI25zM6MY0/PWekuLMsZaSdcI7IyONNqzkfqWcATfDaN6+e3H1Ia
	 FkQtcDdCjNfUFQW7v9pkuNVFLoW/f0ptgzP8Fmc/Ej3yCjAz4uWpM6E++bhCGnEFX/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFVI6xXO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86537606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFVI6xXO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E054B1F00A07;
	Wed, 11 Nov 2026 22:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437054;
	bh=a54Wr9rMAqzqgyTpfn0tZqG6zvtV3tRgDmxyD0rSuIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFVI6xXOCaTzwvU430Xp9brZT157zIsmETWvDR/AgY8rtgITSadhQ7NSHFwDzE//r
	 Auy8qxs/WcuY0cEGDFigB57MPMRn7HMUuZAmP5uvSzJaF2d9uPhJ06TUG7PB1PlIsq
	 6o4mCjqaOj+caO/yrDC1wD+n0SJiiXg5PFte7aJfgAjQ8DOHRnNCk1gCFmdLXw8O3j
	 UaxJZepo3nJ6i8tTZfGCDUw0SfvdBqlB/BTLXi4eHBT2QmrSo977FRhTzgHwa1JnpV
	 nGz6SmM8rMO6a5Sz2ITGb7aQrrN/mV74AXlMae2+vkD6OhUGpGPBkJ3OlJRS177btN
	 djc0raYlLOD8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/6] procfs: kill ->proc_dops
Date: Wed, 11 Nov 2026 17:44:08 -0500
Message-ID: <20261111224335.80100-3-sashal@kernel.org>
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
index 3651bc8245227..ab9f499fc749f 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -261,7 +261,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
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
@@ -453,9 +456,8 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	INIT_LIST_HEAD(&ent->pde_openers);
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
 
-	ent->proc_dops = &proc_misc_dentry_ops;
 	/* Revalidate everything under /proc/${pid}/net */
-	if ((*parent)->proc_dops == &proc_net_dentry_ops)
+	if ((*parent)->flags & PROC_ENTRY_FORCE_LOOKUP)
 		pde_force_lookup(ent);
 
 out:
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index e35e28415dd8e..56fc4197d92b8 100644
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
@@ -329,7 +328,7 @@ extern const struct dentry_operations proc_net_dentry_ops;
 static inline void pde_force_lookup(struct proc_dir_entry *pde)
 {
 	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
-	pde->proc_dops = &proc_net_dentry_ops;
+	pde->flags |= PROC_ENTRY_FORCE_LOOKUP;
 }
 
 /*
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 9f8e0072b30fe..cd320ccb60bf6 100644
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

