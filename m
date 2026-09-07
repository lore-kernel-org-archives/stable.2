Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979247143E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789268; cv=none; b=W+dEVIoazjbVwVEvCInM68e93wzCuC3syvzotwEOLeFx72sz27JTpgSIFHlfl3EH/YS1S3FUiH8E4KcE87gAAMkGvysAztP/W5XTpJNVb0MG6N4nQ3yQFrIINz/WnYmShu7xmeGgyzdQd70iQ5XG6/D6wJoMsvp1anYgq9qmOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789268; c=relaxed/simple;
	bh=mFmS/Z8bqcklLjipDZmO71j3mBbw3nbECIgcQn34OgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew00pjO/BtwWhLoEfujC+WbS0U92Y5oB5g9RDvxAFY5+M0FFX8jPbQEcwrldlCYzokMgZUQ0ZHmK1I09Po+wg+R9jB357XsxpI78IE3WwcRdXBIPm3bD8xd5/2fB24W0/V/xDXrK3BcH9/O/SkggSE7v/+n8toNDXydneR+tfkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwJC5hwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwJC5hwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B6B1F00A3D;
	Mon,  7 Sep 2026 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789267;
	bh=0JyGAGCCxaS8OuXM43qAfg6p9E9F6+rfzV2nThSlw1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bwJC5hwbSC5CVKkpxd74Ht2Fwl6D9jESngi0Y41O1lEUqlERHdjUjhy8oY8EXmcXq
	 NttL1e6THxQjO355XiP96USq4to1aMSRioloxTltXHAt+aAt2Oq5anHwCTGgWktCJX
	 olvUyLXCTobrB2G/2xYY/fg0T8ruUlgcYnxriUgW2djA0hg4ZaqMCkSQkCKQU77Ze6
	 tKLVGv2AOOL3Tkpm5sCQ/tiytt/cduwXDSAA3+bp9BCSG2GhGG+qG4UtxOhOldqHol
	 2PkI1sUEqlwLFW6Y4PO+6B1q7zY+9PwzgEC2IMlivJ+gGxHr1BQYxsCXzQxIinb8I9
	 IJ7noUFmAf5bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] btrfs: pass struct btrfs_inode to btrfs_sync_inode_flags_to_i_flags()
Date: Mon,  7 Sep 2026 09:54:23 -0400
Message-ID: <20260907135424.3120784-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907135424.3120784-1-sashal@kernel.org>
References: <2026090331-stipulate-faction-d656@gregkh>
 <20260907135424.3120784-1-sashal@kernel.org>
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

[ sashal: Reduced backport -- upstream 4f27a693940bc touches 4 file(s), this
  backport carries 4. Not backported here:
  fs/btrfs/ioctl.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.h  |  2 +-
 fs/btrfs/inode.c  |  4 ++--
 fs/btrfs/ioctl.c  | 19 +++++++++----------
 fs/btrfs/verity.c |  4 ++--
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 61ec4ba5414d5..c007b381fe93c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3291,7 +3291,7 @@ int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 		       struct dentry *dentry, struct fileattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
-void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
+void btrfs_sync_inode_flags_to_i_flags(struct btrfs_inode *inode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
 int btrfs_defrag_file(struct inode *inode, struct file *file,
 		      struct btrfs_ioctl_defrag_range_args *range,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1f8e8cd49c12a..cd8b25efc52f1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3982,7 +3982,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 		break;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(BTRFS_I(inode));
 	return 0;
 }
 
@@ -6560,7 +6560,7 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(BTRFS_I(inode));
 }
 
 static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6f9f4455d3e2e..ea17c73bd5fec 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -138,25 +138,24 @@ static unsigned int btrfs_inode_flags_to_fsflags(struct btrfs_inode *binode)
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
@@ -349,7 +348,7 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 
 update_flags:
 	inode->flags = inode_flags;
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
 	ret = btrfs_update_inode(trans, root, inode);
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 4968535dfff0a..45be09f6aa200 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -480,7 +480,7 @@ static int rollback_verity(struct btrfs_inode *inode)
 		goto out;
 	}
 	inode->ro_flags &= ~BTRFS_INODE_RO_VERITY;
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -547,7 +547,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 		goto out;
 	}
 	inode->ro_flags |= BTRFS_INODE_RO_VERITY;
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret)
 		goto end_trans;
-- 
2.53.0

