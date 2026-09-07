Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25AF4D98EF
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789268; cv=none; b=rtRRJjda1jX0OxqsCEcImMX08uMKtiPXgICdLIn3cMQFYeKnkkGQ/LAk9mKxc/gu91gh+Gwr/fw5VIEI7IGpBFSWxkDCbWqfp/4dzZcdf5IF7BzSN5rYkpLPnBVpF+1BIsN9oh+NEWwSrFgWQiYCX56Lc8RXB3Wt0USXuApXNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789268; c=relaxed/simple;
	bh=aBZZs6Yr6ulyJBM8XIcNbVBmZQY+0NOUnSAoT4rEAjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVx6SwJ4YGRK0/F8f+DbexjTRpobSBuxQxlzAJk46g0OCB9BsYx64AUWDMs1GsdhSBaplU7IXvEt6+nw+ZIoGvq4cS52jna3Iw8qqPLESc1kXUBC2RDVAN4Ou0oNgGVVpv047nSWJ5FybBhYKwvtFptjFqepGsDpSFXvwozhjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV6WF4Vs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV6WF4Vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BC41F00A3A;
	Mon,  7 Sep 2026 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789266;
	bh=H63rOyDSGQZrETSYc+g1K26kJjLKI2IY2glqKBBpRFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MV6WF4Vsckwu+vNrwfIIjQSiCnIxxK/abS7Zg3TFk48PIbYnRnNf6IgsNqiz4LXRR
	 BUR+BxgWoUfu5+eSo5AxeOjU6TSnrNSmxP1C+IfX6PTndGDMoN7CHR7KVbbGTPlrAB
	 G7AlWu+yBoZ+x/IxUZ5jM1KVP/jsSeXAp5YGL1GV3ariesBG8wVOg2S/Rl2uy5OsvB
	 2vGJK3O7hupt8M910+BbWSlExcGCdsx6bjoHjZe/bCyKdq1fO7NT8bbejqp6Yxa8Bg
	 GvfBrw9U/mUl+e5XpsEsMzhsUpghvNvBp3CbXWy9yIxqawOmr7jo3QQc9bhhtASU11
	 ws62gQn/zJYmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
Date: Mon,  7 Sep 2026 09:54:22 -0400
Message-ID: <20260907135424.3120784-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090331-stipulate-faction-d656@gregkh>
References: <2026090331-stipulate-faction-d656@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a5b3f117daead61c3c9c88cd1159d38fa4ad1362 ]

It's a generic helper not specific to ioctls and used in several places,
so move it out from ioctl.c and into fs.c. While at it change its return
type from int to bool and declare the loop variable in the loop itself.

This also slightly reduces the module's size.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1781492	 161037	  16920	1959449	 1de619	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1781340	 161037	  16920	1959297	 1de581	fs/btrfs/btrfs.ko

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

[ sashal: Reduced backport -- upstream a5b3f117daead touches 4 file(s), this
  backport carries 1. Not backported here:
  fs/btrfs/fs.c
  fs/btrfs/fs.h
  fs/btrfs/ioctl.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 85 ++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d56d6144707bb..6f9f4455d3e2e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -214,15 +214,14 @@ int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 		       struct dentry *dentry, struct fileattr *fa)
 {
-	struct inode *inode = d_inode(dentry);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_inode *binode = BTRFS_I(inode);
-	struct btrfs_root *root = binode->root;
+	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
 	unsigned int fsflags, old_fsflags;
 	int ret;
 	const char *comp = NULL;
-	u32 binode_flags;
+	u32 inode_flags;
 
 	if (btrfs_root_readonly(root))
 		return -EROFS;
@@ -230,8 +229,8 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
-	fsflags = btrfs_mask_fsflags_for_type(inode, fa->flags);
-	old_fsflags = btrfs_inode_flags_to_fsflags(binode);
+	fsflags = btrfs_mask_fsflags_for_type(&inode->vfs_inode, fa->flags);
+	old_fsflags = btrfs_inode_flags_to_fsflags(inode);
 	ret = check_fsflags(old_fsflags, fsflags);
 	if (ret)
 		return ret;
@@ -240,27 +239,27 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
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
@@ -272,32 +271,32 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
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
 
@@ -307,21 +306,21 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
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
@@ -333,14 +332,14 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
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
@@ -349,11 +348,11 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
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

