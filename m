Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1E3DC4BC;
	Tue,  6 Oct 2026 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322609; cv=none; b=MT55EQ3kTqQJ8tOsPZHauDZdCw1/lId6AjFD7RcWWL3vvJecJPIHJE2uKm0NQ579D/0RxmCZIIaM6rVRDU5Dal9RH1SWrrG8lfsUABEpBMN1IuEkUwJzelZknm8jKCSof3Z7smLQlEglNbfEzTUG6zpKmonmVAWNtY1g7NrP+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322609; c=relaxed/simple;
	bh=wsiwDFtrbESdWeZHiEFXMq7YLTyLn5Xt5GEzN03Vu/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHBimFRyFeFQTuWhyyyGh39uZawNCha6xEMm0kGky4lEoQWRwTzWn87mE6+CQdOVs48+nyKokxLNoPFBki9DXbwZDM3PBgMlhRW1Y2oKv5pHWCJV9tuLPO/L56uasWjFQc7eEY5CmUQMcETqoNnW5eWk6dnL4oeLBpLWQvIAqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOI6oxB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOI6oxB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F601F0089C;
	Tue,  6 Oct 2026 21:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322608;
	bh=R4GuV1awq/IsTl16JWMXSAyA633xWjm+gBzQ4wiR914=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bOI6oxB/6X0uIzgZwjYYfhaq33xQfIS59Pw1rE/Vta/aZ7WO8oP2aPPSbV43C/cB+
	 SX2rd+2iIuguvDV7rJ0kW7jm2BoPdfh2Y4ns1RGGHHicTbUEyChW1lRrJ/1TcdVoJR
	 47dr1opTUT9YuheekFIeNGWyr8eOQW9M5tUcjQIatagadrB01N1yOy+Uq8uVczdHmh
	 EfSR8F2giiRo5mlTWh5WahUEroQmu9iBF/HvsLegQcc5dLmx41xHpZfraVm1eZl6o1
	 nS201qKxEiRahtKqmh5CBmoOkiOPN84G3ffHDj9IqMJF1hGm6eAOWouQD1JMd95iiQ
	 gnqDyM819h7BA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 1/2] fs,fsverity: reject size changes on fsverity files in setattr_prepare
Date: Tue,  6 Oct 2026 23:36:04 +0200
Message-ID: <20261006213605.46946-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006213605.46946-1-ebiggers@kernel.org>
References: <20261006213605.46946-1-ebiggers@kernel.org>
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
index 795f231d00e8..2c94af08be18 100644
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
index 3b2891f18540..d2977c560c96 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5898,10 +5898,6 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
index 222b2a8bbc94..791f1cf198c1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1123,10 +1123,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (err)
 		return err;
 
-	err = fsverity_prepare_setattr(dentry, attr);
-	if (err)
-		return err;
-
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return -EPERM;
 
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 77b1c977af02..2aa5eae5a540 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -384,14 +384,6 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
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
 	struct fsverity_info **vi_addr = fsverity_info_addr(inode);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 5bc7280425a7..86fb1708676b 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -179,7 +179,6 @@ int fsverity_get_digest(struct inode *inode,
 /* open.c */
 
 int __fsverity_file_open(struct inode *inode, struct file *filp);
-int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void __fsverity_cleanup_inode(struct inode *inode);
 
 /**
@@ -251,12 +250,6 @@ static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
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
@@ -338,22 +331,4 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
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

