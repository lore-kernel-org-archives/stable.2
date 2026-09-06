Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B807339362
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723058; cv=none; b=UdH1/6szcYEd+XyX2wpXh2X1QHww7r4v5e5fLuCqm5fwZ8qe41oHyKeqYF0GnzZzrXPxTFnKAFJoUbJ3ZgZnaSyp28d1hYHipam2CrWNDQRgnt7Oe2oyy4bDxdpDPk6MPF25Il7FzQhpkRL0+U5s8p13iKDAeDnUSmPCiMm02CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723058; c=relaxed/simple;
	bh=8rzHu9XeXcdICdj/vec04OD/ONQAG9xSEiMBm+BP0bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/XfPcwvR27trLb+H+SiQHO+HfDwSgewn1liKkHHO1eCHm6tdqvMzZT3bp8NN8UXs10pTdkcEGCFUx9BDc+qM8DS70Pi9EnoxC+N5GVJpqf5ZJCMnfhQuZECvlwQDA2uvm2GHNcl0m2kU42CJGZUVDlmQ0pQXK8zmV1371GzveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2mPHb2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2mPHb2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991CF1F00AC4;
	Sun,  6 Sep 2026 19:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723055;
	bh=cfKY1foLWsexb3/c7nsS32epphiMZXjmMwxsZYohW1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j2mPHb2Mn/+tCmGyhpRJUJSTK5DdbySWcANhep87CDY1bBHEGNd9vjMm6LA2P+Scu
	 dPgIczAlP7viRqZloZ2BHaqQdves7NJ9RmYNJJsRj1Ehc7+cVo0VQJRk/iTTyWaLm+
	 LzaZ7pHTGc7FGhaY3NORXcDb/psBCZEy4ly9Wp4dTKwwvbR4gJIRqe/I7NIXxSdihS
	 4AXMFA94Eg+4+kCn+4ux0zhAjMp3b4PsqSJKIGJlJvfMdAQM7TTXKy5L27OTg1gc7t
	 t7EcaDEkrcUXpjjuCZqwWdWj7AMTVdwJLzteubhtgO1jZT8RVvYm1o/ZO0kkKGPuHl
	 SvMv9osLSsydQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/8] btrfs: pass struct btrfs_inode to btrfs_sync_inode_flags_to_i_flags()
Date: Sun,  6 Sep 2026 15:30:47 -0400
Message-ID: <20260906193048.1791749-7-sashal@kernel.org>
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

[ Upstream commit 4f27a693940bcf313d17792ac4ec13a83f71cf25 ]

Pass a struct btrfs_inode to btrfs_sync_inode_flags_to_i_flags() as it's
an internal interface.

Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c  |  4 ++--
 fs/btrfs/ioctl.c  | 19 +++++++++----------
 fs/btrfs/ioctl.h  |  4 ++--
 fs/btrfs/verity.c |  4 ++--
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9f8b6a8a36928..3d0dd228c6dbd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3972,7 +3972,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 		break;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(BTRFS_I(inode));
 	return 0;
 }
 
@@ -6209,7 +6209,7 @@ static void btrfs_inherit_iflags(struct btrfs_inode *inode, struct btrfs_inode *
 			inode->flags |= BTRFS_INODE_NODATASUM;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 }
 
 int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bbd7f0db6ae53..8f87f13cf2500 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -166,25 +166,24 @@ static unsigned int btrfs_inode_flags_to_fsflags(const struct btrfs_inode *binod
 /*
  * Update inode->i_flags based on the btrfs internal flags.
  */
-void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
+void btrfs_sync_inode_flags_to_i_flags(struct btrfs_inode *inode)
 {
-	struct btrfs_inode *binode = BTRFS_I(inode);
 	unsigned int new_fl = 0;
 
-	if (binode->flags & BTRFS_INODE_SYNC)
+	if (inode->flags & BTRFS_INODE_SYNC)
 		new_fl |= S_SYNC;
-	if (binode->flags & BTRFS_INODE_IMMUTABLE)
+	if (inode->flags & BTRFS_INODE_IMMUTABLE)
 		new_fl |= S_IMMUTABLE;
-	if (binode->flags & BTRFS_INODE_APPEND)
+	if (inode->flags & BTRFS_INODE_APPEND)
 		new_fl |= S_APPEND;
-	if (binode->flags & BTRFS_INODE_NOATIME)
+	if (inode->flags & BTRFS_INODE_NOATIME)
 		new_fl |= S_NOATIME;
-	if (binode->flags & BTRFS_INODE_DIRSYNC)
+	if (inode->flags & BTRFS_INODE_DIRSYNC)
 		new_fl |= S_DIRSYNC;
-	if (binode->ro_flags & BTRFS_INODE_RO_VERITY)
+	if (inode->ro_flags & BTRFS_INODE_RO_VERITY)
 		new_fl |= S_VERITY;
 
-	set_mask_bits(&inode->i_flags,
+	set_mask_bits(&inode->vfs_inode.i_flags,
 		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC |
 		      S_VERITY, new_fl);
 }
@@ -395,7 +394,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		mapping_clear_stable_writes(inode->vfs_inode.i_mapping);
 	else
 		mapping_set_stable_writes(inode->vfs_inode.i_mapping);
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
 	ret = btrfs_update_inode(trans, inode);
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index 389a9bf6fc1ed..d4e35fae1a25d 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -9,8 +9,8 @@ struct file;
 struct dentry;
 struct mnt_idmap;
 struct fileattr;
-struct inode;
 struct io_uring_cmd;
+struct btrfs_inode;
 struct btrfs_fs_info;
 struct btrfs_ioctl_balance_args;
 
@@ -20,7 +20,7 @@ int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
-void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
+void btrfs_sync_inode_flags_to_i_flags(struct btrfs_inode *inode);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 				     struct btrfs_ioctl_balance_args *bargs);
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index e97ad824ae16d..b7a96a005487e 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -485,7 +485,7 @@ static int rollback_verity(struct btrfs_inode *inode)
 		goto out;
 	}
 	inode->ro_flags &= ~BTRFS_INODE_RO_VERITY;
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 	ret = btrfs_update_inode(trans, inode);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -552,7 +552,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 		goto out;
 	}
 	inode->ro_flags |= BTRFS_INODE_RO_VERITY;
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 	ret = btrfs_update_inode(trans, inode);
 	if (ret)
 		goto end_trans;
-- 
2.53.0

