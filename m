Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9618485CE1
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781647; cv=none; b=UilUcksM/Bs2joD3joRy9GJLPwOCG+QUTIWuzsoMYfLWYbv8VG0jkYid+R1ZzkEGYb9WqTFuemdCn3QRyijx8x/LLiuxV8kSZcvaUo8MewIIhci9ju+IRJohb7bnOAObEKntNmu2Rr6VIZWZPwySJaFj8sVDzQUuDqj6hwTNKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781647; c=relaxed/simple;
	bh=bbq0a5wuQdMi1m/7oPpui24qqrAGrqdnZEm7gMYbj8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rp+oQpwKDWL7FJww5Eggx4LMumIF3XwW8FoUiKjq82mglcqgNWLS/W6AHegIdWDrZhBI7+vsS44A5/D45os/6VszWj898rQg5EbShhY/q5KN6xbdMDTTk1GPKZcMdEjQy2NZBe3WVLMcsBnbtZG20OPTL0erKmal8erSJH3xeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeRqiHCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeRqiHCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7881F00A3A;
	Mon,  7 Sep 2026 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781645;
	bh=QCt6TGWyNAriFzjOeTLnWx0iEW7zptvNHs9IUzwQr2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NeRqiHCjGtDLyalJLK9+9IuLg0nJ7lIxasAYBErpXI7daB85X26N2jjuoyGXXgATR
	 lnvuYUmanuiS91BuxxP41ssj6/hHmfzVLtMSTXeUYQwcFt4jmuqfIaskFxmTL98PNo
	 2ZTH5/FqffLChARqsNyr35zmALaqpy6atkBJH+dO8cIgD85PFl6LUirG+gvmEuIqwq
	 srKfapsFysPHgcxyu7fZLxHmfjmh8WiS+79pTnC0fLrov3FLY3/iMCUwoUCuX0ikzZ
	 yUKRhCyEkFuDDK3rn8M5CKEhoIhQ2kWCc6NMYpCsEjs4bQJur8IXR459WtstnAJ0Y0
	 DCtxIpgW8R6Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] btrfs: move BTRFS_BYTES_TO_BLKS() into fs.h
Date: Mon,  7 Sep 2026 07:47:21 -0400
Message-ID: <20260907114723.2870432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090330-antelope-bullfrog-bfbf@gregkh>
References: <2026090330-antelope-bullfrog-bfbf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a4545b74e2de98989c1d14bc48c52c2f9fa734b6 ]

Currently BTRFS_BYTES_TO_BLKS() is defined in ctree.h but it's not related
at all to the btree data structure, so move it into fs.h.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

[ sashal: Reduced backport -- upstream a4545b74e2de9 touches 2 file(s), this
  backport carries 2. Not backported here:
  fs/btrfs/fs.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.h |  6 ++--
 fs/btrfs/ioctl.c | 85 ++++++++++++++++++++++++------------------------
 2 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 16795e91aee29..c2482c2b634cd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1130,6 +1130,9 @@ static inline u64 btrfs_calc_metadata_size(struct btrfs_fs_info *fs_info,
 #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
 					sizeof(struct btrfs_item))
 
+#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
+				((bytes) >> (fs_info)->sectorsize_bits)
+
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 {
 	return fs_info->zone_size > 0;
@@ -1733,9 +1736,6 @@ struct btrfs_map_token {
 	unsigned long offset;
 };
 
-#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
-				((bytes) >> (fs_info)->sectorsize_bits)
-
 static inline void btrfs_init_map_token(struct btrfs_map_token *token,
 					struct extent_buffer *eb)
 {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b84b1cce17723..6dc4e88827740 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -235,15 +235,14 @@ int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 		       struct dentry *dentry, struct fileattr *fa)
 {
-	struct inode *inode = d_inode(dentry);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_inode *binode = BTRFS_I(inode);
-	struct btrfs_root *root = binode->root;
+	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_root *root = inode->root;
 	struct btrfs_trans_handle *trans;
 	unsigned int fsflags, old_fsflags;
 	int ret;
 	const char *comp = NULL;
-	u32 binode_flags;
+	u32 inode_flags;
 
 	if (btrfs_root_readonly(root))
 		return -EROFS;
@@ -251,8 +250,8 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
-	fsflags = btrfs_mask_fsflags_for_type(inode, fa->flags);
-	old_fsflags = btrfs_inode_flags_to_fsflags(binode);
+	fsflags = btrfs_mask_fsflags_for_type(&inode->vfs_inode, fa->flags);
+	old_fsflags = btrfs_inode_flags_to_fsflags(inode);
 	ret = check_fsflags(old_fsflags, fsflags);
 	if (ret)
 		return ret;
@@ -261,27 +260,27 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	if (ret)
 		return ret;
 
-	binode_flags = binode->flags;
+	inode_flags = inode->flags;
 	if (fsflags & FS_SYNC_FL)
-		binode_flags |= BTRFS_INODE_SYNC;
+		inode_flags |= BTRFS_INODE_SYNC;
 	else
-		binode_flags &= ~BTRFS_INODE_SYNC;
+		inode_flags &= ~BTRFS_INODE_SYNC;
 	if (fsflags & FS_IMMUTABLE_FL)
-		binode_flags |= BTRFS_INODE_IMMUTABLE;
+		inode_flags |= BTRFS_INODE_IMMUTABLE;
 	else
-		binode_flags &= ~BTRFS_INODE_IMMUTABLE;
+		inode_flags &= ~BTRFS_INODE_IMMUTABLE;
 	if (fsflags & FS_APPEND_FL)
-		binode_flags |= BTRFS_INODE_APPEND;
+		inode_flags |= BTRFS_INODE_APPEND;
 	else
-		binode_flags &= ~BTRFS_INODE_APPEND;
+		inode_flags &= ~BTRFS_INODE_APPEND;
 	if (fsflags & FS_NODUMP_FL)
-		binode_flags |= BTRFS_INODE_NODUMP;
+		inode_flags |= BTRFS_INODE_NODUMP;
 	else
-		binode_flags &= ~BTRFS_INODE_NODUMP;
+		inode_flags &= ~BTRFS_INODE_NODUMP;
 	if (fsflags & FS_NOATIME_FL)
-		binode_flags |= BTRFS_INODE_NOATIME;
+		inode_flags |= BTRFS_INODE_NOATIME;
 	else
-		binode_flags &= ~BTRFS_INODE_NOATIME;
+		inode_flags &= ~BTRFS_INODE_NOATIME;
 
 	/* If coming from FS_IOC_FSSETXATTR then skip unconverted flags */
 	if (!fa->flags_valid) {
@@ -293,32 +292,32 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	}
 
 	if (fsflags & FS_DIRSYNC_FL)
-		binode_flags |= BTRFS_INODE_DIRSYNC;
+		inode_flags |= BTRFS_INODE_DIRSYNC;
 	else
-		binode_flags &= ~BTRFS_INODE_DIRSYNC;
+		inode_flags &= ~BTRFS_INODE_DIRSYNC;
 	if (fsflags & FS_NOCOW_FL) {
-		if (S_ISREG(inode->i_mode)) {
+		if (S_ISREG(inode->vfs_inode.i_mode)) {
 			/*
 			 * It's safe to turn csums off here, no extents exist.
 			 * Otherwise we want the flag to reflect the real COW
 			 * status of the file and will not set it.
 			 */
-			if (inode->i_size == 0)
-				binode_flags |= BTRFS_INODE_NODATACOW |
-						BTRFS_INODE_NODATASUM;
+			if (inode->vfs_inode.i_size == 0)
+				inode_flags |= BTRFS_INODE_NODATACOW |
+					       BTRFS_INODE_NODATASUM;
 		} else {
-			binode_flags |= BTRFS_INODE_NODATACOW;
+			inode_flags |= BTRFS_INODE_NODATACOW;
 		}
 	} else {
 		/*
 		 * Revert back under same assumptions as above
 		 */
-		if (S_ISREG(inode->i_mode)) {
-			if (inode->i_size == 0)
-				binode_flags &= ~(BTRFS_INODE_NODATACOW |
-						  BTRFS_INODE_NODATASUM);
+		if (S_ISREG(inode->vfs_inode.i_mode)) {
+			if (inode->vfs_inode.i_size == 0)
+				inode_flags &= ~(BTRFS_INODE_NODATACOW |
+						 BTRFS_INODE_NODATASUM);
 		} else {
-			binode_flags &= ~BTRFS_INODE_NODATACOW;
+			inode_flags &= ~BTRFS_INODE_NODATACOW;
 		}
 	}
 
@@ -328,21 +327,21 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	 * things smaller.
 	 */
 	if (fsflags & FS_NOCOMP_FL) {
-		binode_flags &= ~BTRFS_INODE_COMPRESS;
-		binode_flags |= BTRFS_INODE_NOCOMPRESS;
+		inode_flags &= ~BTRFS_INODE_COMPRESS;
+		inode_flags |= BTRFS_INODE_NOCOMPRESS;
 	} else if (fsflags & FS_COMPR_FL) {
 
-		if (IS_SWAPFILE(inode))
+		if (IS_SWAPFILE(&inode->vfs_inode))
 			return -ETXTBSY;
 
-		binode_flags |= BTRFS_INODE_COMPRESS;
-		binode_flags &= ~BTRFS_INODE_NOCOMPRESS;
+		inode_flags |= BTRFS_INODE_COMPRESS;
+		inode_flags &= ~BTRFS_INODE_NOCOMPRESS;
 
 		comp = btrfs_compress_type2str(fs_info->compress_type);
 		if (!comp || comp[0] == 0)
 			comp = btrfs_compress_type2str(BTRFS_COMPRESS_ZLIB);
 	} else {
-		binode_flags &= ~(BTRFS_INODE_COMPRESS | BTRFS_INODE_NOCOMPRESS);
+		inode_flags &= ~(BTRFS_INODE_COMPRESS | BTRFS_INODE_NOCOMPRESS);
 	}
 
 	/*
@@ -354,14 +353,14 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 		return PTR_ERR(trans);
 
 	if (comp) {
-		ret = btrfs_set_prop(trans, inode, "btrfs.compression", comp,
+		ret = btrfs_set_prop(trans, &inode->vfs_inode, "btrfs.compression", comp,
 				     strlen(comp), 0);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
 		}
 	} else {
-		ret = btrfs_set_prop(trans, inode, "btrfs.compression", NULL,
+		ret = btrfs_set_prop(trans, &inode->vfs_inode, "btrfs.compression", NULL,
 				     0, 0);
 		if (ret && ret != -ENODATA) {
 			btrfs_abort_transaction(trans, ret);
@@ -370,11 +369,11 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	}
 
 update_flags:
-	binode->flags = binode_flags;
-	btrfs_sync_inode_flags_to_i_flags(inode);
-	inode_inc_iversion(inode);
-	inode->i_ctime = current_time(inode);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	inode->flags = inode_flags;
+	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	inode_inc_iversion(&inode->vfs_inode);
+	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
+	ret = btrfs_update_inode(trans, root, inode);
 
  out_end_trans:
 	btrfs_end_transaction(trans);
-- 
2.53.0

