Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560359;
	b=SLm1m2NaKcvQvykHVbjxAkV5BHi5o5DrO2ef5oR9lliIzXbeJrTMdKcmwWtLAZJ93jP7
	 jUf0zjmy9rhHSDTdw74TcLA04PMHy/C6PmtE7vJDh6DZ44IkPIhqAHHGQUzY3q3954wA7
	 yXfPz4wghTcvySSSOYz5bLWT3Gx3BUiyuYgaDp00RcCK+NnhDxWsuEEFX1wWzk6nHVe64
	 x8T3f8gY91lr43AqJ1348iws5MHsQsHdOPg4IabVnPiLNpXLasPk9g6nKBIYg/ZW8+ROf
	 523E0CzxTnL0KCnxApuf5X/UWxGYc3WbfK/DtZVnxlYFRc4Uf6vQ9inNyB/T+6aSVtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xs/Twu+AWxLueb6ZCrW66epyWmuOSxU3esmUATb2huU=;
	b=sd78CMredc1hf66+gmmmnmZDq9th3YmO9kArUOYSA+QfSgFylsJV64RmvVtJ9sO2Qzdi
	 MWxB+XbSgfO0FjkhxUkcZigyGptXNGB2L/N8NpQgyIK4021oqcnwSJsbUQbfzXyY/Vj6h
	 ahChwrqBTOui6OaDEAZZ4iTayYN41XzJ8go1IrriEqLyzMHPBDzooct4S49bUbt0ee8RH
	 dPHHSyrvhIrOIcJ1rp1rC1r4s8nYnaLbg8LW3wBTxUDMUl1ahFRmc99BYL7cZfq4FzvJ7
	 8zhxcaSZN8jl/BAQ54C0mX2gfDkCLGxz8Y/O1lKXyvzqsyBQU6N+KlxxZWcPFwQ7N4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDozjrct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCD606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDozjrct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8E41F000D3;
	Tue, 24 Nov 2026 22:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560358;
	bh=xs/Twu+AWxLueb6ZCrW66epyWmuOSxU3esmUATb2huU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDozjrctxl0RqSPkBLuJPdFO/GkYIOH957Ev58TAgDPAwdpl2lhkVWsqPKEp5iD/F
	 MvhIO5f0/RqSHAKLCnlCJFpbTE2oaqHZuISVAtUHpZ2Q9IZy4g3Y2J4alsE6zeD43P
	 BunT20ppf4bHd21mdur4ElSlpjtNU+92WML0SO5TCasGu3NAtqXw8EXum5QYDR5peo
	 OEb+xKfnmRv1THvwbD+T64SBy2g1bMK17RqTf7jK+UolA2JwbPI6mIV2qAoalCdZO2
	 75oKukHtnZvgc+TtkOQzBHpm75ObCeH6pxknIA74Ji6FAlgPTC6mltmZ8tsD1PcCxv
	 hB20/uevvYp/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] btrfs: make more ASSERTs verbose, part 3
Date: Tue, 24 Nov 2026 17:45:54 -0500
Message-ID: <20261124224517.3116600-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124224517.3116600-1-sashal@kernel.org>
References: <2026112428-spearmint-famished-4675@gregkh>
 <20261124224517.3116600-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 3fc0803f1c644e60b24cdb175109fcae83b2849a ]

We have support for optional string to be printed in ASSERT() (added in
19468a623a9109 ("btrfs: enhance ASSERT() to take optional format
string")), it's not yet everywhere it could be so add a few more files.

Try to finish what was left after 1c094e6ccead7a ("btrfs: make a few
more ASSERTs verbose").

Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 9a58e56e70f6 ("btrfs: reject refs=0 subvolume without DEAD in SUBVOL_SYNC_WAIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/backref.c          |  4 ++--
 fs/btrfs/extent-tree.c      | 15 ++++++++++-----
 fs/btrfs/extent_map.c       |  6 +++---
 fs/btrfs/fiemap.c           |  2 +-
 fs/btrfs/file-item.c        |  4 +++-
 fs/btrfs/file.c             |  7 +++++--
 fs/btrfs/ioctl.c            |  3 ++-
 fs/btrfs/ordered-data.c     | 12 +++++++-----
 fs/btrfs/raid-stripe-tree.c |  4 +++-
 fs/btrfs/reflink.c          |  5 +++--
 10 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 0c47b4570a7bf..ac6aaef57cf1c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2363,7 +2363,7 @@ int tree_backref_for_extent(unsigned long *ptr, struct extent_buffer *eb,
 		info = (struct btrfs_tree_block_info *)(ei + 1);
 		*out_level = btrfs_tree_block_level(eb, info);
 	} else {
-		ASSERT(key->type == BTRFS_METADATA_ITEM_KEY);
+		ASSERT(key->type == BTRFS_METADATA_ITEM_KEY, "key->type=%hhu", key->type);
 		*out_level = (u8)key->offset;
 	}
 
@@ -3189,7 +3189,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 	struct btrfs_backref_node *upper;
 	struct rb_node *rb_node;
 
-	ASSERT(ref_key->type == BTRFS_SHARED_BLOCK_REF_KEY);
+	ASSERT(ref_key->type == BTRFS_SHARED_BLOCK_REF_KEY, "ref_key->type=%hhu", ref_key->type);
 
 	/* Only reloc root uses backref pointing to itself */
 	if (ref_key->objectid == ref_key->offset) {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2f207bca62720..b53319023d76a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -372,7 +372,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 					return type;
 			}
 		} else {
-			ASSERT(is_data == BTRFS_REF_TYPE_ANY);
+			ASSERT(is_data == BTRFS_REF_TYPE_ANY, "is_data=%d", is_data);
 			return type;
 		}
 	}
@@ -2444,8 +2444,11 @@ int btrfs_cross_ref_exist(struct btrfs_inode *inode, u64 offset,
 				struct btrfs_key key;
 
 				btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-				ASSERT(key.objectid == bytenr);
-				ASSERT(key.type == BTRFS_EXTENT_ITEM_KEY);
+				ASSERT(key.objectid == bytenr,
+				       "key.objectid=%llu bytenr=%llu",
+				       key.objectid, bytenr);
+				ASSERT(key.type == BTRFS_EXTENT_ITEM_KEY, "key.type=%u",
+				       key.type);
 			}
 		}
 
@@ -4407,10 +4410,12 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		/* Use dedicated sub-space_info for dedicated block group users. */
 		if (ffe_ctl->for_data_reloc) {
 			space_info = space_info->sub_group[0];
-			ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
+			ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC,
+			       "space_info->subgroup_id=%d", space_info->subgroup_id);
 		} else if (ffe_ctl->for_treelog) {
 			space_info = space_info->sub_group[0];
-			ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_TREELOG);
+			ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_TREELOG,
+			       "space_info->subgroup_id=%d", space_info->subgroup_id);
 		}
 	}
 	if (!space_info) {
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 21eb104ee2aef..23610d7ebb305 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -705,7 +705,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 	 * file offset. Here just do a sanity check.
 	 */
 	if (em->disk_bytenr == EXTENT_MAP_INLINE)
-		ASSERT(em->start == 0);
+		ASSERT(em->start == 0, "em->start=%llu", em->start);
 
 	ret = add_extent_mapping(inode, em, false);
 	/* it is possible that someone inserted the extent into the tree
@@ -749,7 +749,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 		}
 	}
 
-	ASSERT(ret == 0 || ret == -EEXIST);
+	ASSERT(ret == 0 || ret == -EEXIST, "ret=%d", ret);
 	return ret;
 }
 
@@ -931,7 +931,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 				ret = add_extent_mapping(inode, split, modified);
 				/* Logic error, shouldn't happen. */
-				ASSERT(ret == 0);
+				ASSERT(ret == 0, "ret=%d", ret);
 				if (WARN_ON(ret != 0) && modified)
 					btrfs_set_inode_full_sync(inode);
 			}
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index 5fb7342a616d1..385c68bfd0dc1 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -112,7 +112,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	u64 cache_end;
 
 	/* Set at the end of extent_fiemap(). */
-	ASSERT((flags & FIEMAP_EXTENT_LAST) == 0);
+	ASSERT((flags & FIEMAP_EXTENT_LAST) == 0, "flags=0x%u", flags);
 
 	if (!cache->cached)
 		goto assign;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 9b19b33e85b68..e4918ee92a52a 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -319,7 +319,9 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 
 	csum_start = key.offset;
 	csum_len = (itemsize / csum_size) * sectorsize;
-	ASSERT(in_range(disk_bytenr, csum_start, csum_len));
+	ASSERT(in_range(disk_bytenr, csum_start, csum_len),
+	       "disk_bytenr=%llu csum_start=%llu csum_len=%llu",
+	       disk_bytenr, csum_start, csum_len);
 
 found:
 	ret = (min(csum_start + csum_len, disk_bytenr + len) -
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 19f0f9df038cc..e12426c4dc272 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1214,8 +1214,11 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 		return ret;
 	reserved_len = ret;
 	/* Write range must be inside the reserved range. */
-	ASSERT(reserved_start <= start);
-	ASSERT(start + write_bytes <= reserved_start + reserved_len);
+	ASSERT(reserved_start <= start, "reserved_start=%llu start=%llu",
+	       reserved_start, start);
+	ASSERT(start + write_bytes <= reserved_start + reserved_len,
+	       "start=%llu write_bytes=%zu reserved_start=%llu reserved_len=%llu",
+	       start, write_bytes, reserved_start, reserved_len);
 
 again:
 	ret = balance_dirty_pages_ratelimited_flags(inode->vfs_inode.i_mapping,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 84305ed0dc70e..091d090b650e0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5224,7 +5224,8 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
 			return -ENOENT;
 
 		wait_for_deletion = true;
-		ASSERT(root_flags & BTRFS_ROOT_SUBVOL_DEAD);
+		ASSERT(root_flags & BTRFS_ROOT_SUBVOL_DEAD, "root_flags=0x%llx",
+		       root_flags);
 		sched_ret = schedule_timeout_interruptible(HZ);
 		/* Early wake up or error. */
 		if (sched_ret != 0)
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 03b1d1e28cfec..cfceb39c0fdcd 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -157,7 +157,8 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
 
 	/* Only one type flag can be set. */
-	ASSERT(has_single_bit_set(flags & BTRFS_ORDERED_EXCLUSIVE_FLAGS));
+	ASSERT(has_single_bit_set(flags & BTRFS_ORDERED_EXCLUSIVE_FLAGS),
+	       "flags=0x%lx", flags);
 
 	/* DIRECT cannot be set with COMPRESSED nor ENCODED. */
 	if (test_bit(BTRFS_ORDERED_DIRECT, &flags)) {
@@ -297,7 +298,7 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 {
 	struct btrfs_ordered_extent *entry;
 
-	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
+	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0, "flags=0x%lx", flags);
 
 	/*
 	 * For regular writes, we just use the members in @file_extent.
@@ -1252,7 +1253,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 
 	trace_btrfs_ordered_extent_split(inode, ordered);
 
-	ASSERT(!(flags & (1U << BTRFS_ORDERED_COMPRESSED)));
+	ASSERT(!(flags & (1U << BTRFS_ORDERED_COMPRESSED)), "flags=0x%lx", flags);
 
 	/*
 	 * The entire bio must be covered by the ordered extent, but we can't
@@ -1274,7 +1275,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	}
 	/* We cannot split partially completed ordered extents. */
 	if (ordered->bytes_left) {
-		ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
+		ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS), "flags=0x%lx", flags);
 		if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes))
 			return ERR_PTR(-EINVAL);
 	}
@@ -1323,7 +1324,8 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	ordered->ram_bytes -= len;
 
 	if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags)) {
-		ASSERT(ordered->bytes_left == 0);
+		ASSERT(ordered->bytes_left == 0, "ordered->bytes_left=%llu",
+		       ordered->bytes_left);
 		new->bytes_left = 0;
 	} else {
 		ordered->bytes_left -= len;
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 707fe664b0771..6763114588c95 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -239,7 +239,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 			btrfs_partially_delete_raid_extent(trans, path, &key,
 							   key.offset - length,
 							   length);
-			ASSERT(key.offset - diff_end == length);
+			ASSERT(key.offset - diff_end == length,
+			       "key.offset=%llu diff_end=%llu length=%llu",
+			       key.offset, diff_end, length);
 			break;
 		}
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index c6f8db5027a42..fec41636b540e 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -68,7 +68,8 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	int ret;
 
-	ASSERT(IS_ALIGNED(file_offset, block_size));
+	ASSERT(IS_ALIGNED(file_offset, block_size), "file_offset=%llu block_size=%u",
+	       file_offset, block_size);
 
 	/*
 	 * We have flushed and locked the ranges of the source and destination
@@ -469,7 +470,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		    key.objectid != btrfs_ino(BTRFS_I(src)))
 			break;
 
-		ASSERT(key.type == BTRFS_EXTENT_DATA_KEY);
+		ASSERT(key.type == BTRFS_EXTENT_DATA_KEY, "key.type=%u", key.type);
 
 		extent = btrfs_item_ptr(leaf, slot,
 					struct btrfs_file_extent_item);
-- 
2.53.0

