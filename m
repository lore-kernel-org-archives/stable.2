Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525353D3D18
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691776; cv=none; b=RtgiQBhz+A5Sy8jBywsLMzZmUUeorjmz58Ad3TxNGnVHa20dX31qAoqUb8cLKwVZ8qhF7ddYRfRCGgzJNZbUF3Ekds2tHGFv7nQnOE8330k98hSyr4KMWRytg5L/4rIvKPnxaEo/mhkMKMI30BaXVPwS8B2UYLhhUY50cn3MN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691776; c=relaxed/simple;
	bh=wx1u5/U13bsgpEqnUiFwi0sZ6hNYN98yhUsbt7WIiGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgTvf0qZ3HGZ2i65TBLClMNnxmCIutrl854UX5siWSCpWgQW1GF4rOAmAuADF2fvtwV4bH/Jx1gzwh/3pFEl+c/mzf/tIUM4vYnenbolDnz4rViWLH7b2aoLAiBAhmn4Lyo9y+iOU0ItBeDb+9arxa8AIWFS12GWZK5hWqfX9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSSrJ5ss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSSrJ5ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CD11F000FF;
	Tue, 29 Sep 2026 14:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691774;
	bh=0P0AeNXQAO9RzQFjJiKOia3NAYdpOwrRbwA2AA1vSu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZSSrJ5sskotQlGZ4i0vhlx59eaRviYfNxPcY1LR7epC92Igi/Xt04b3Acrxc1gV57
	 of9shfGnIWyFMX0yyyjKTQu2JWcJAsDhcfrC7VxyHCNAFtgEuVRe7lLCwLyu91rE3n
	 ryv3IELMEQ5H6fOk3MzN3LPIo/bagn/l6bMKEvWIQpNsKCOOKA/hkmaSVzXlDqF1c4
	 O6Yt7ozEda021SoX1wfD+IThHUqNMDUAN9wDg1gHet7ElF1qIDKzAlVXvq7xsiA7qL
	 6d34pw63ol77SZjRYvaXsfHNDaI1Wy5+GVN2J9lE//v6RX4T7qmnzoXV9JTYt0VovZ
	 yjmbk7rHSWGZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] fs/ntfs3: Redesign ntfs_create_inode to return error code instead of inode
Date: Tue, 29 Sep 2026 10:22:52 -0400
Message-ID: <20260929142253.3582339-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092906-gestation-filtrate-f5c2@gregkh>
References: <2026092906-gestation-filtrate-f5c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit c935c66878867dc87c36c36b21d35d7e7f08adec ]

As Al Viro correctly pointed out, there is no need to return
the whole structure to check the error.
https://lore.kernel.org/ntfs3/20240322023515.GK538574@ZenIV/

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[Stable 6.1 dependency adaptation: retain the user_namespace API and
existing directory-lock lifetime. Return an integer status from
ntfs_create_inode and pass it through all four callers. Omit the
unrelated switch to resident data for newly created regular files.
The success-only unlock_new_inode epilogue allows target
1abd643f3783ea8f8e273c18697ff0413aa92dc7 to apply cleanly.]

Stable-dep-of: 1abd643f3783 ("fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c   | 18 ++++++++----------
 fs/ntfs3/namei.c   | 31 ++++++++-----------------------
 fs/ntfs3/ntfs_fs.h |  9 ++++-----
 3 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index acd5be0d36c0c..243791cc3c529 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1202,11 +1202,10 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 	return ERR_PTR(err);
 }
 
-struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
-				struct inode *dir, struct dentry *dentry,
-				const struct cpu_str *uni, umode_t mode,
-				dev_t dev, const char *symname, u32 size,
-				struct ntfs_fnd *fnd)
+int ntfs_create_inode(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, const struct cpu_str *uni,
+		      umode_t mode, dev_t dev, const char *symname, u32 size,
+		      struct ntfs_fnd *fnd)
 {
 	int err;
 	struct super_block *sb = dir->i_sb;
@@ -1675,14 +1674,13 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 	kfree(rp);
 
 out1:
-	if (err) {
+	if (err)
 		ni_unlock(dir_ni);
-		return ERR_PTR(err);
-	}
 
-	unlock_new_inode(inode);
+	if (!err)
+		unlock_new_inode(inode);
 
-	return inode;
+	return err;
 }
 
 int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 9d454b9a9c149..0fecfb1961af8 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -105,12 +105,8 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 static int ntfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct inode *inode;
-
-	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFREG | mode,
-				  0, NULL, 0, NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFREG | mode,
+				 0, NULL, 0, NULL);
 }
 
 /*
@@ -121,12 +117,8 @@ static int ntfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 static int ntfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
-	struct inode *inode;
-
-	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, mode, rdev,
-				  NULL, 0, NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(mnt_userns, dir, dentry, NULL, mode, rdev,
+				 NULL, 0, NULL);
 }
 
 /*
@@ -195,12 +187,9 @@ static int ntfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
 	u32 size = strlen(symname);
-	struct inode *inode;
-
-	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFLNK | 0777,
-				  0, symname, size, NULL);
 
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFLNK | 0777,
+				 0, symname, size, NULL);
 }
 
 /*
@@ -209,12 +198,8 @@ static int ntfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 static int ntfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
-	struct inode *inode;
-
-	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFDIR | mode,
-				  0, NULL, 0, NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFDIR | mode,
+				 0, NULL, 0, NULL);
 }
 
 /*
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a03dce278221e..a270e03e94bc8 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -701,11 +701,10 @@ int ntfs_sync_inode(struct inode *inode);
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 		      struct inode *i2);
 int inode_write_data(struct inode *inode, const void *data, size_t bytes);
-struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
-				struct inode *dir, struct dentry *dentry,
-				const struct cpu_str *uni, umode_t mode,
-				dev_t dev, const char *symname, u32 size,
-				struct ntfs_fnd *fnd);
+int ntfs_create_inode(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, const struct cpu_str *uni,
+		      umode_t mode, dev_t dev, const char *symname, u32 size,
+		      struct ntfs_fnd *fnd);
 int ntfs_link_inode(struct inode *inode, struct dentry *dentry);
 int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry);
 void ntfs_evict_inode(struct inode *inode);
-- 
2.53.0

