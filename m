Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF335111BE
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797089; cv=none; b=Exi8uFuH0FwZzFIT3gi/M80ilJOxphmTpxvUBIoEuKPMglaEmBc85IoA5V2b1Ijxq1JD6o/uq1HRVNPyTlAahfMgmpAF39z2KDZtBMMs/HvL9FPi21cQg6nzDvYjfNyIxyYJ+5o1C/zfRdoYqZuny5P3EKTdV24L5YMa5ErK6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797089; c=relaxed/simple;
	bh=6WuMJP/Hu3H3UD62Pyk+v1Y4sh/vErGWhmasbszmy28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCD0PkaAxvt7uWPQ8H9nQKOJBfNRs+OsSTegVagrltsHj0k7hhxKcYPOLPI+wvdOBgv3aOFdcbd72eVuOJgNrV/0rC2GlSk743x8/IrNUuw6D04bFf/Q0Q1KAsinvVxQJO+792Eab+0QykqXLGVx4a7o2I7gl0Oh1EIkMN7Vdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYh2yTFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYh2yTFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F8B1F00A3A;
	Mon,  7 Sep 2026 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788797084;
	bh=/hi0BhaKOQ6FGJY7z0SErenCB+aq0IJThV60L+5UA6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IYh2yTFUUfR8KotDx44mTAV8uPcgmt8ebiyrLK85A+1FrrLSqOwNC4xeiCAWpBleq
	 JBWbbKP0jnoxvZGFqgxo6h43uQJhVuHz2E0Xi6wrn8b1T4Hv2A9Njofi3QB3uFh6VC
	 B/Ri1gEoMWXINlt+CHPQc775Dx36fb7AfCCwVHl5/h8ceZNIt4QDXv+QmRXnE/YJWp
	 ZA36FwVVv9i9IG/A0VesLLA3NxAcMBbXmMKD70DNF8dUn3QWfEIX/waY2oQHzJgA/N
	 Zk0/e+h3jHofW2FX2ep/B/NZNNdBaKWDKQedb7VtRctB4hP6C3Y5Qe/FnanmRybktY
	 S6m9mEhwzr/pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
Date: Mon,  7 Sep 2026 12:04:40 -0400
Message-ID: <20260907160442.4160058-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090331-audibly-scallop-6a11@gregkh>
References: <2026090331-audibly-scallop-6a11@gregkh>
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

     text          data     bss     dec     hex filename
  1781492        161037   16920 1959449  1de619 fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text          data     bss     dec     hex filename
  1781340        161037   16920 1959297  1de581 fs/btrfs/btrfs.ko

[ stable: The fs.c split does not exist in 5.10, so keep the helper in
  ioctl.c and instead align btrfs_ioctl_setflags() variable naming with
  the target commit's context. This is a behavior-neutral refactor. ]

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
 fs/btrfs/ioctl.c | 94 ++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 16c397062809f..f0a9fb928b39e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -195,17 +195,17 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
 
 static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_inode *binode = BTRFS_I(inode);
-	struct btrfs_root *root = binode->root;
+	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
+	struct inode *vfs_inode = &inode->vfs_inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(vfs_inode->i_sb);
+	struct btrfs_root *root = inode->root;
 	struct btrfs_trans_handle *trans;
 	unsigned int fsflags, old_fsflags;
 	int ret;
 	const char *comp = NULL;
-	u32 binode_flags;
+	u32 inode_flags;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(vfs_inode))
 		return -EPERM;
 
 	if (btrfs_root_readonly(root))
@@ -218,11 +218,11 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
-	inode_lock(inode);
-	fsflags = btrfs_mask_fsflags_for_type(inode, fsflags);
-	old_fsflags = btrfs_inode_flags_to_fsflags(binode->flags);
+	inode_lock(vfs_inode);
+	fsflags = btrfs_mask_fsflags_for_type(vfs_inode, fsflags);
+	old_fsflags = btrfs_inode_flags_to_fsflags(inode->flags);
 
-	ret = vfs_ioc_setflags_prepare(inode, old_fsflags, fsflags);
+	ret = vfs_ioc_setflags_prepare(vfs_inode, old_fsflags, fsflags);
 	if (ret)
 		goto out_unlock;
 
@@ -230,54 +230,54 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	if (ret)
 		goto out_unlock;
 
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
 
@@ -287,23 +287,23 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	 * things smaller.
 	 */
 	if (fsflags & FS_NOCOMP_FL) {
-		binode_flags &= ~BTRFS_INODE_COMPRESS;
-		binode_flags |= BTRFS_INODE_NOCOMPRESS;
+		inode_flags &= ~BTRFS_INODE_COMPRESS;
+		inode_flags |= BTRFS_INODE_NOCOMPRESS;
 	} else if (fsflags & FS_COMPR_FL) {
 
-		if (IS_SWAPFILE(inode)) {
+		if (IS_SWAPFILE(vfs_inode)) {
 			ret = -ETXTBSY;
 			goto out_unlock;
 		}
 
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
@@ -317,14 +317,14 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	}
 
 	if (comp) {
-		ret = btrfs_set_prop(trans, inode, "btrfs.compression", comp,
+		ret = btrfs_set_prop(trans, vfs_inode, "btrfs.compression", comp,
 				     strlen(comp), 0);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
 		}
 	} else {
-		ret = btrfs_set_prop(trans, inode, "btrfs.compression", NULL,
+		ret = btrfs_set_prop(trans, vfs_inode, "btrfs.compression", NULL,
 				     0, 0);
 		if (ret && ret != -ENODATA) {
 			btrfs_abort_transaction(trans, ret);
@@ -332,16 +332,16 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 		}
 	}
 
-	binode->flags = binode_flags;
-	btrfs_sync_inode_flags_to_i_flags(inode);
-	inode_inc_iversion(inode);
-	inode->i_ctime = current_time(inode);
-	ret = btrfs_update_inode(trans, root, inode);
+	inode->flags = inode_flags;
+	btrfs_sync_inode_flags_to_i_flags(vfs_inode);
+	inode_inc_iversion(vfs_inode);
+	vfs_inode->i_ctime = current_time(vfs_inode);
+	ret = btrfs_update_inode(trans, root, vfs_inode);
 
  out_end_trans:
 	btrfs_end_transaction(trans);
  out_unlock:
-	inode_unlock(inode);
+	inode_unlock(vfs_inode);
 	mnt_drop_write_file(file);
 	return ret;
 }
-- 
2.53.0

