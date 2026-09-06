Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146C3932C6
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723061; cv=none; b=lPgzOi6uIPpS/wHEcSAQCsVm9+C3iVe93kbPkkeUcaZ0NXYxxYMyhq/UIbPza+aUpZqiePqIAn5ZQ7Guf/tgg5Ks4SN/92NSpt4atk4q4lyVs1hnHyNrc3CqpMZWREnWce8a9jToiyc3dqf1fZiPjoP8eekPbJf58k4TWidkbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723061; c=relaxed/simple;
	bh=ggF4veuO+o9yTr7zBvBWcCr3bdmcNoh1aA/CvPrn+Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xbdie/dcimE0uNyjLANLmg8287L6pkzfqz53CTUByqysevL5INWOsCI56Ex/9bjO7s1MsOwnSxbm+RWUilbCr/ZyCyrTMDRrZOUWfKgvF36lLN+4LNwY27H3SjUaEBgv64xpiN5BEIdfINs+4tEjnXTzKQIWS/4hMGVJHt0++FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH+/q0gG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH+/q0gG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B581F00ACA;
	Sun,  6 Sep 2026 19:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723059;
	bh=zPB1SP2uJugmgHLQHu3dkiPtjAgvQ7BpBhupa9tewoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iH+/q0gGWUJfuI2GxsmXwpXqjiYcepfg665XkJUpmzQRHR+ohAXOoWouF/mpQyx/S
	 9g9Wti98D6hrBE8scXnlnO/qo15ml5K+D9s+ktXjpqvQ+AYC6XYl1N6JxJByfSwgBs
	 aV7msw3IF/gOtxD2efJFOx80V9rM9vNImNBNTPppJIArYWhfs5TOFYlajgpfsV5wwG
	 agS6Yarc8VxT0wD6pEO/UloyFd9GO0TFRBYB7PZXscckTw9hmYWfN7S9jrWmrq8cMv
	 BlGBoC20dQnHPeV+UXX+Wc40bkV8lUTU18hqeIyuUkbr7dEzkUcFImExmnT/9OJQp/
	 fQ4aGytAjSqBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Daniel Vacek <neelx@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] btrfs: use BTRFS_PATH_AUTO_FREE in can_nocow_extent()
Date: Sun,  6 Sep 2026 15:30:53 -0400
Message-ID: <20260906193056.1792186-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906193056.1792186-1-sashal@kernel.org>
References: <2026090310-unwarlike-canister-1f00@gregkh>
 <20260906193056.1792186-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 5e8632035a173a8c54c17301ecff69c79babb4bf ]

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Reviewed-by: Daniel Vacek <neelx@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 3f950867c307 ("btrfs: fix extent map leak in NOCOW direct I/O write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ab7f19ca21457..ab30015e52a7c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7043,7 +7043,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 	struct extent_buffer *leaf;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -7060,13 +7060,12 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	ret = btrfs_lookup_file_extent(NULL, root, path,
 			btrfs_ino(BTRFS_I(inode)), offset, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (ret == 1) {
 		if (path->slots[0] == 0) {
-			/* can't find the item, must cow */
-			ret = 0;
-			goto out;
+			/* Can't find the item, must COW. */
+			return 0;
 		}
 		path->slots[0]--;
 	}
@@ -7075,17 +7074,17 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	if (key.objectid != btrfs_ino(BTRFS_I(inode)) ||
 	    key.type != BTRFS_EXTENT_DATA_KEY) {
-		/* not our file or wrong item type, must cow */
-		goto out;
+		/* Not our file or wrong item type, must COW. */
+		return 0;
 	}
 
 	if (key.offset > offset) {
-		/* Wrong offset, must cow */
-		goto out;
+		/* Wrong offset, must COW. */
+		return 0;
 	}
 
 	if (btrfs_file_extent_end(path) <= offset)
-		goto out;
+		return 0;
 
 	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	found_type = btrfs_file_extent_type(leaf, fi);
@@ -7101,15 +7100,13 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 
 	if (ret != 1) {
 		/* Treat errors as not being able to NOCOW. */
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
-	ret = 0;
 	if (btrfs_extent_readonly(fs_info,
 				  nocow_args.file_extent.disk_bytenr +
 				  nocow_args.file_extent.offset))
-		goto out;
+		return 0;
 
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
@@ -7118,20 +7115,16 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		range_end = round_up(offset + nocow_args.file_extent.num_bytes,
 				     root->fs_info->sectorsize) - 1;
 		ret = test_range_bit_exists(io_tree, offset, range_end, EXTENT_DELALLOC);
-		if (ret) {
-			ret = -EAGAIN;
-			goto out;
-		}
+		if (ret)
+			return -EAGAIN;
 	}
 
 	if (file_extent)
 		memcpy(file_extent, &nocow_args.file_extent, sizeof(*file_extent));
 
 	*len = nocow_args.file_extent.num_bytes;
-	ret = 1;
-out:
-	btrfs_free_path(path);
-	return ret;
+
+	return 1;
 }
 
 /* The callers of this must take lock_extent() */
-- 
2.53.0

