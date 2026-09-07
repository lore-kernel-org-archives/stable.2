Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB8191F94
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743001; cv=none; b=E4NXCCW5lSH5V9nVDuFjy1e6fqpb08rtfKiMR2TfSgjWuPjgx+sF6pBmALY3hlSRxlgpj4qlE4ZNn3XptDzNoeCWWGfbSfU+V9nxC+kSkv7TFckWzR62zdQgwxI+uCUx4ZxZ94wRBPwxOUyr/wuWomEhuKxo4+P9bttdBf/eVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743001; c=relaxed/simple;
	bh=FjGOZr2ZLBA9zJ9eVPXkA7/8tBjExhrq76xoxGh28k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfdkxCRwA0gnwSBNFi+1jvXQ29V/qrdHQegXs0VJv86q7P38Z5gHLaa2L0+pYZjiWhVi0yLIVY+7tiirAlDibFId1XO0XB2YUlmvpZNf+8YzGX+65Jy0FXZxN9KY6ZLV9le7NuIsOVh6O5+T9DQQNio1j1H79CtOeSkScYqWL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3iL15Ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3iL15Ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1614A1F00A3F;
	Mon,  7 Sep 2026 01:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788742999;
	bh=74nGudiTTUuVe9JXlmhw/gE2yQQFUIEOEDUZx7sSs74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3iL15KiyQby8v+PWXCaPV/DE6hjkdVNwewH3kTUXQSfJ40GNxhmIceF1z8XSPQaj
	 d7YtJwx8TnkDkutSNavDh662scs0NfkmkXn70Voy1dxiUK7nPfExbhPbCnK6kKpbWd
	 VZgIEzzjpnwa9vUI267dkfEmqhTVK4/7tRJTKdS7p/OzzB+r/W/yyoYiZk/ckBi7kh
	 6R3mSbZ/m4PnW8zyjKn20oQDxWU96Rlkt7KW/ruRE4k49oBraVg1n0t8s0xWDGSxh6
	 3nNMq+nydk9bUJkUCc6IfYkHlPyRxewOunUBIwKNgiHhZwFWrptz/dbMG9iB0Iyr0r
	 nycoaJUznUwDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
Date: Sun,  6 Sep 2026 21:03:14 -0400
Message-ID: <20260907010317.1950131-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090330-ferocity-flavorful-f5e4@gregkh>
References: <2026090330-ferocity-flavorful-f5e4@gregkh>
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
Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/fs.c    |  9 +++++
 fs/btrfs/fs.h    |  2 +
 fs/btrfs/ioctl.c | 96 +++++++++++++++++++++---------------------------
 fs/btrfs/ioctl.h |  1 -
 4 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 31c1648bc0b46..e2b2b0f4c770f 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -5,6 +5,15 @@
 #include "fs.h"
 #include "accessors.h"
 
+bool __pure btrfs_is_empty_uuid(const u8 *uuid)
+{
+	for (int i = 0; i < BTRFS_UUID_SIZE; i++) {
+		if (uuid[i] != 0)
+			return false;
+	}
+	return true;
+}
+
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name)
 {
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b8b9ce8921baf..b35aa4556d96f 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -888,6 +888,8 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
 void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 			  enum btrfs_exclusive_operation op);
 
+bool __pure btrfs_is_empty_uuid(const u8 *uuid);
+
 /* Compatibility and incompatibility defines */
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d17d1eff8eff4..46eb80580d3bd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -246,15 +246,14 @@ int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 int btrfs_fileattr_set(struct mnt_idmap *idmap,
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
@@ -262,8 +261,8 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
-	fsflags = btrfs_mask_fsflags_for_type(inode, fa->flags);
-	old_fsflags = btrfs_inode_flags_to_fsflags(binode);
+	fsflags = btrfs_mask_fsflags_for_type(&inode->vfs_inode, fa->flags);
+	old_fsflags = btrfs_inode_flags_to_fsflags(inode);
 	ret = check_fsflags(old_fsflags, fsflags);
 	if (ret)
 		return ret;
@@ -272,27 +271,27 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
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
@@ -304,32 +303,32 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
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
 
@@ -339,21 +338,21 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
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
@@ -365,14 +364,14 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
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
@@ -381,11 +380,11 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	}
 
 update_flags:
-	binode->flags = binode_flags;
-	btrfs_sync_inode_flags_to_i_flags(inode);
-	inode_inc_iversion(inode);
-	inode_set_ctime_current(inode);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	inode->flags = inode_flags;
+	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	inode_inc_iversion(&inode->vfs_inode);
+	inode_set_ctime_current(&inode->vfs_inode);
+	ret = btrfs_update_inode(trans, root, inode);
 
  out_end_trans:
 	btrfs_end_transaction(trans);
@@ -540,17 +539,6 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int __pure btrfs_is_empty_uuid(u8 *uuid)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_UUID_SIZE; i++) {
-		if (uuid[i])
-			return 0;
-	}
-	return 1;
-}
-
 /*
  * Calculate the number of transaction items to reserve for creating a subvolume
  * or snapshot, not including the inode, directory entries, or parent directory.
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index d51b9a2f2f6e8..21ee96c274819 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -10,7 +10,6 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
-int __pure btrfs_is_empty_uuid(u8 *uuid);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 				     struct btrfs_ioctl_balance_args *bargs);
 
-- 
2.53.0

