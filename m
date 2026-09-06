Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3221CA03
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723057; cv=none; b=pWbgJV2YIwM70UUg2vLWbjPulK2bIfQ0zzLVE5Ac1MPVetqggF/vCNvZsrHmo9YrmxV/91OKIRQJVfqtTwRQqmAbBERAEZK3YGd6KZUZ0kEcVOnDStUHWKDyI755aakNxZWmCQ7SjdvJDheqCIixE3557KzP5vFCHfpUj7nf2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723057; c=relaxed/simple;
	bh=ts1wTv2Z2DOMjNWxb8AJEBBZoVPdXCsi7a+vKLKOtHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myiLx5u/0GGJawR0ClUO1QnB0j3c8WrTyg8omiVFkWJeXFXi/n7hGwsFX8DEpsMTadXN3i7GwuxlH5ZK5de9aJJRa+kfyiEdofup349mHv7sxQf7MRHwZx4pUZFCMZtNczc4rGtC2kUCShV3jIj/bFWZXXq5YVoMeuA1aqJMQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIzC1Zsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIzC1Zsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C211F00A3F;
	Sun,  6 Sep 2026 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723054;
	bh=cr3d3LN/9088mUBtv0gqZcCJPLi8Ju3Qx/AniGNqeWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KIzC1ZshdkP5wWhA4FPJQJC6h2UkCSn5BGsSw2KVLZg80QUFTJWqwylqF5xLWOAA4
	 wDIfIsTGC9eNtR9yodAO+A8FhEgYZkx2uOSETVDmPZUXvbpraiLsYgdYVMHfVq04fl
	 GMf9JivUnzrk/wvLBXO5X2BjihbaePNK/21OVF2TvOhi6MqZdt+8b05k/E4nx92XVU
	 K4bTvrt10jrmYQPGWYqGuofCSpW9uEH1jD3W4c88+dZjQgo4aaR+jcseEwfLb+5J2P
	 vKwvUAu6G6anWCulYnGC66ViknpzYx0K4Bcr/1/V28h/+ZWWcaBEzXz8iiax8I8zPu
	 8rjQjI5I5PLwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/8] btrfs: parameter constification in ioctl.c
Date: Sun,  6 Sep 2026 15:30:46 -0400
Message-ID: <20260906193048.1791749-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906193048.1791749-1-sashal@kernel.org>
References: <2026090330-nappy-discharge-0af0@gregkh>
 <20260906193048.1791749-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 5e54f9420fc9b8096d0a4b579a84806a3ef0bf88 ]

Add const to function parameters that are not changed.

Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8997e65d32863..bbd7f0db6ae53 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -117,8 +117,8 @@ struct btrfs_ioctl_encoded_io_args_32 {
 #endif
 
 /* Mask out flags that are inappropriate for the given type of inode. */
-static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
-		unsigned int flags)
+static unsigned int btrfs_mask_fsflags_for_type(const struct inode *inode,
+						unsigned int flags)
 {
 	if (S_ISDIR(inode->i_mode))
 		return flags;
@@ -132,7 +132,7 @@ static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
  * Export internal inode flags to the format expected by the FS_IOC_GETFLAGS
  * ioctl.
  */
-static unsigned int btrfs_inode_flags_to_fsflags(struct btrfs_inode *binode)
+static unsigned int btrfs_inode_flags_to_fsflags(const struct btrfs_inode *binode)
 {
 	unsigned int iflags = 0;
 	u32 flags = binode->flags;
@@ -218,7 +218,7 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
 	return 0;
 }
 
-static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
+static int check_fsflags_compatible(const struct btrfs_fs_info *fs_info,
 				    unsigned int flags)
 {
 	if (btrfs_is_zoned(fs_info) && (flags & FS_NOCOW_FL))
@@ -247,7 +247,7 @@ static int btrfs_check_ioctl_vol_args2_subvol_name(const struct btrfs_ioctl_vol_
  */
 int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
-	struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
+	const struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
 
 	fileattr_fill_flags(fa, btrfs_inode_flags_to_fsflags(binode));
 	return 0;
@@ -485,7 +485,7 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 	}
 }
 
-static int btrfs_ioctl_getversion(struct inode *inode, int __user *arg)
+static int btrfs_ioctl_getversion(const struct inode *inode, int __user *arg)
 {
 	return put_user(inode->i_generation, arg);
 }
@@ -557,7 +557,7 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
  * Calculate the number of transaction items to reserve for creating a subvolume
  * or snapshot, not including the inode, directory entries, or parent directory.
  */
-static unsigned int create_subvol_num_items(struct btrfs_qgroup_inherit *inherit)
+static unsigned int create_subvol_num_items(const struct btrfs_qgroup_inherit *inherit)
 {
 	/*
 	 * 1 to add root block
@@ -967,7 +967,7 @@ static int btrfs_may_delete(struct mnt_idmap *idmap,
 
 /* copy of may_create in fs/namei.c() */
 static inline int btrfs_may_create(struct mnt_idmap *idmap,
-				   struct inode *dir, struct dentry *child)
+				   struct inode *dir, const struct dentry *child)
 {
 	if (d_really_is_positive(child))
 		return -EEXIST;
@@ -1539,8 +1539,8 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	return ret;
 }
 
-static noinline int key_in_sk(struct btrfs_key *key,
-			      struct btrfs_ioctl_search_key *sk)
+static noinline int key_in_sk(const struct btrfs_key *key,
+			      const struct btrfs_ioctl_search_key *sk)
 {
 	struct btrfs_key test;
 	int ret;
@@ -1565,7 +1565,7 @@ static noinline int key_in_sk(struct btrfs_key *key,
 
 static noinline int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
-			       struct btrfs_ioctl_search_key *sk,
+			       const struct btrfs_ioctl_search_key *sk,
 			       u64 *buf_size,
 			       char __user *ubuf,
 			       unsigned long *sk_offset,
@@ -2844,7 +2844,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	return ret;
 }
 
-static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
+static long btrfs_ioctl_fs_info(const struct btrfs_fs_info *fs_info,
 				void __user *arg)
 {
 	struct btrfs_ioctl_fs_info_args *fi_args;
@@ -2898,7 +2898,7 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
+static long btrfs_ioctl_dev_info(const struct btrfs_fs_info *fs_info,
 				 void __user *arg)
 {
 	BTRFS_DEV_LOOKUP_ARGS(args);
@@ -4356,7 +4356,7 @@ static int btrfs_ioctl_get_features(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static int check_feature_bits(struct btrfs_fs_info *fs_info,
+static int check_feature_bits(const struct btrfs_fs_info *fs_info,
 			      enum btrfs_feature_set set,
 			      u64 change_mask, u64 flags, u64 supported_flags,
 			      u64 safe_set, u64 safe_clear)
-- 
2.53.0

