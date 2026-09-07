Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF7463B66
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797088; cv=none; b=oYv+I76piSROeipIrg8iTLserTtzz/SNXPngxT6qOodjvBcCqE7mhQeN17JlzSWEk+lkAau1JDk9CezjK3vdqbpbtQ1GHTn7ph9VHs5jELN5YHrCzPMgSh561QRaH8Q5zvr7Ip22pSwOMm3tAdtFIcdxwUFsXvF/8F4ZHhgnxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797088; c=relaxed/simple;
	bh=jQNCuuCTZOfZtkTA8TXKgDGdgRlct5So0J5pGSI4BCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbIsj/3HR6boxCew0Bv2faHvZkkWu279oCVnfwYd16TwpJTMS5eQeX73IG2M6kVHav89+RI25EjXg2ZZfoeqUiXxmgNfP7WjTcBt1+owwYZDem6UjgsqeFr6D3AAp5WqFsnAVYBhEJ/lrtZS+Fxe63cGt+E8jsvO2MFgGjs+e9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Koy216nO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Koy216nO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6EA1F00ACA;
	Mon,  7 Sep 2026 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788797085;
	bh=pUI9WDOdqxchC0vyR1C0+vUmW+ffleafLP7eJThRO9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Koy216nOlVvdsFytKQIj2LqH9ij9+GSvKt20z27rjdoaT08O3THe+k7RoX84PH/cp
	 D96XtmHGb+Y3jlAoy5J0eoTfYZfQDeW0LOMS+5mtwUIsUOS6FuxQnGG/g5Z3xO0rV4
	 W+bY/v5kSAkGlQwvbXaUD7nwDEu4J6kq5wC3udEqEAlE8p8R+kAX1bPmW9ZSkxKmaM
	 vAaMN/G7D67VcDsFglXHhyPPF5FadjChaVg0J7zhL/9DHfMoY0ShVezJ2OGIRH4CwB
	 3fxedQ8HpCsP9x/auhTwjb6GNFKof+CVO+40ZupDhwZkNIRe2LGOno6RyFoGm+hMcO
	 LgkeMqYK3whkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] btrfs: pass struct btrfs_inode to btrfs_sync_inode_flags_to_i_flags()
Date: Mon,  7 Sep 2026 12:04:41 -0400
Message-ID: <20260907160442.4160058-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907160442.4160058-1-sashal@kernel.org>
References: <2026090331-audibly-scallop-6a11@gregkh>
 <20260907160442.4160058-1-sashal@kernel.org>
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
  backport carries 3. Not backported here:
  fs/btrfs/ioctl.h
  fs/btrfs/verity.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.h |  2 +-
 fs/btrfs/inode.c |  4 ++--
 fs/btrfs/ioctl.c | 19 +++++++++----------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a9926fb10c491..55dfb73d8e323 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3082,7 +3082,7 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int btrfs_ioctl_get_supported_features(void __user *arg);
-void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
+void btrfs_sync_inode_flags_to_i_flags(struct btrfs_inode *inode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
 int btrfs_defrag_file(struct inode *inode, struct file *file,
 		      struct btrfs_ioctl_defrag_range_args *range,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3c61f540597d2..7451e18e06eeb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3463,7 +3463,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 		break;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(BTRFS_I(inode));
 	return 0;
 }
 
@@ -5976,7 +5976,7 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(BTRFS_I(inode));
 }
 
 static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f0a9fb928b39e..86b4137fc3e9e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -133,23 +133,22 @@ static unsigned int btrfs_inode_flags_to_fsflags(unsigned int flags)
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
 
-	set_mask_bits(&inode->i_flags,
+	set_mask_bits(&inode->vfs_inode.i_flags,
 		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC,
 		      new_fl);
 }
@@ -333,7 +332,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	}
 
 	inode->flags = inode_flags;
-	btrfs_sync_inode_flags_to_i_flags(vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(vfs_inode);
 	vfs_inode->i_ctime = current_time(vfs_inode);
 	ret = btrfs_update_inode(trans, root, vfs_inode);
@@ -476,7 +475,7 @@ static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
 		goto out_unlock;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(binode);
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
 	ret = btrfs_update_inode(trans, root, inode);
-- 
2.53.0

