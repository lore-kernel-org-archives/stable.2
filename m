Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D54A2638;
	Tue,  6 Oct 2026 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322665; cv=none; b=dJs/sBIsKAr34/MaIQMTv7tA7mvEnw9OAyRuact1Cjubpii1j9kZpY7/9smtxgyRCmy7oJ4VOPSVeeMOLnF9+YKpABso/vxG6QPmiZMQJxnLu6XAK19SF4Mtp15SEGE/c++plbnrkxibUBn0WVilFCnX0RYNzLfbT7B5mYtV69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322665; c=relaxed/simple;
	bh=uNBBti6gMimEQCmbYPP16rubNocP437bxzdNKV08N3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pa9X8t/WeRmGCfG1y0iYvtopSIpB4dswRmivTrgaH/NIl+st4diaXBQsrMsJlANObEwhfdzYpDrwFhHyPkoHpgEvHsNj5iVvvbPxi8J4W//0ph3auMqb2z+XutymsB1sN/D0V9tvy83VM4PN67m3uV8bsS1SsK5dWSECtfCUMHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR0wmnkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR0wmnkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00031F0089C;
	Tue,  6 Oct 2026 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322659;
	bh=dea5S6Lx22UU6xvhpnYR6J26hlvYIMb3bORP7o5WZhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jR0wmnkGZWNSuZmFIav0i5ZvaN7JzCFMic3R5EUcSs4sk2b7pUz+FyN7RA6haeja/
	 88/mWqS3XhUo3arV8AsAA04BsFQ2a/ifjtRUocgqQBsCVwROvEoBDkY9bOlXPYbQKj
	 FN+1/HRe1yPJz2WFdNpho9SVKZdJ6kfeAYkyVg+Y63sLt/UTxTjh567qa6JOGnOYb0
	 CDXpnR3dj0uvNeOAREIW0Z2RzoC1RqSszLyORbccgcZWypPWeOgrzCXOYujht55ctv
	 sUSH9hF2M78wyJG3EaPZveinYLVHpxiEDUsdefIAKB9lVktzMoevUD6qXm65nz081j
	 c/bmMRS8SjKMQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.12 1/2] fs,fsverity: reject size changes on fsverity files in setattr_prepare
Date: Tue,  6 Oct 2026 23:37:24 +0200
Message-ID: <20261006213725.47114-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006213725.47114-1-ebiggers@kernel.org>
References: <20261006213725.47114-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

commit e9734653c523c744f03333ece6ae7a315187f05c upstream.

Add the check to reject truncates of fsverity files directly to
setattr_prepare instead of requiring the file system to handle it.
Besides removing boilerplate code, this also fixes the complete lack of
such check in btrfs.

Fixes: 146054090b08 ("btrfs: initial fsverity support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Link: https://lore.kernel.org/r/20260128152630.627409-2-hch@lst.de
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/attr.c                | 12 +++++++++++-
 fs/ext4/inode.c          |  4 ----
 fs/f2fs/file.c           |  4 ----
 fs/verity/open.c         |  8 --------
 include/linux/fsverity.h | 25 -------------------------
 5 files changed, 11 insertions(+), 42 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index c04d19b58f12..714f159d58ea 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -169,7 +169,17 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * ATTR_FORCE.
 	 */
 	if (ia_valid & ATTR_SIZE) {
-		int error = inode_newsize_ok(inode, attr->ia_size);
+		int error;
+
+		/*
+		 * Verity files are immutable, so deny truncates.  This isn't
+		 * covered by the open-time check because sys_truncate() takes a
+		 * path, not an open file.
+		 */
+		if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+			return -EPERM;
+
+		error = inode_newsize_ok(inode, attr->ia_size);
 		if (error)
 			return error;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa303effb18a..24b5925a7c7e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5444,10 +5444,6 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		return error;
 
-	error = fsverity_prepare_setattr(dentry, attr);
-	if (error)
-		return error;
-
 	if (is_quota_modification(idmap, inode, attr)) {
 		error = dquot_initialize(inode);
 		if (error)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a7ad5e02433c..b4bd73648a01 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1078,10 +1078,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (err)
 		return err;
 
-	err = fsverity_prepare_setattr(dentry, attr);
-	if (err)
-		return err;
-
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return -EPERM;
 
diff --git a/fs/verity/open.c b/fs/verity/open.c
index fdeb95eca3af..bd0497da5cea 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -392,14 +392,6 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
-int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
-{
-	if (attr->ia_valid & ATTR_SIZE)
-		return -EPERM;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__fsverity_prepare_setattr);
-
 void __fsverity_cleanup_inode(struct inode *inode)
 {
 	fsverity_free_info(inode->i_verity_info);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 1eb7eae580be..139a6f5c6217 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -149,7 +149,6 @@ int fsverity_get_digest(struct inode *inode,
 /* open.c */
 
 int __fsverity_file_open(struct inode *inode, struct file *filp);
-int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void __fsverity_cleanup_inode(struct inode *inode);
 
 /**
@@ -214,12 +213,6 @@ static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
 	return -EOPNOTSUPP;
 }
 
-static inline int __fsverity_prepare_setattr(struct dentry *dentry,
-					     struct iattr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void fsverity_cleanup_inode(struct inode *inode)
 {
 }
@@ -301,22 +294,4 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-/**
- * fsverity_prepare_setattr() - prepare to change a verity inode's attributes
- * @dentry: dentry through which the inode is being changed
- * @attr: attributes to change
- *
- * Verity files are immutable, so deny truncates.  This isn't covered by the
- * open-time check because sys_truncate() takes a path, not a file descriptor.
- *
- * Return: 0 on success, -errno on failure
- */
-static inline int fsverity_prepare_setattr(struct dentry *dentry,
-					   struct iattr *attr)
-{
-	if (IS_VERITY(d_inode(dentry)))
-		return __fsverity_prepare_setattr(dentry, attr);
-	return 0;
-}
-
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.56.0

