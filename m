Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB282EDD58
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287841; cv=none; b=n765qusLD6Pj5lsU0/sXSis+ez+L22yCrL3ZHGvCP14NAA5COGpWep9vDH6rXP1iNU8PNBTQ6AAmdte2/QEU5OafCv3u5kZmRDTz1CgwoQsSaO8CyGvVHN8Lx5cZkpnVwRTV1pM/lcocfRgpbVTbZNc/q8/eJzWr0j02SJjzPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287841; c=relaxed/simple;
	bh=X9MJtnX/TwjZGoaTvUMnI90EetKSjRZYEjAK5VhUt5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4K1Qc7QKaTyzyhH9k5383c2wnhzUWWCIu6AAyhmygL+HZbakbIMmFvPAH0diATJMhzB004x1sSrUud1jn/QpB0bEpEuyZAgFlqLV60zWI8+MbkV72aMovLTGWQwsOyVAL12q7Ru3SwS1BPnFa0DRKlPAqT4v3+OVzPHxmvnujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHnMrfzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHnMrfzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BBD1F000E9;
	Sun,  9 Aug 2026 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786287839;
	bh=0UHj2C/LLHSnKqvcBKQnmaQUpodEgYwKWHaKvwLaJE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHnMrfzdvo8VIU7eV9eNm6WC4pvxCF1zC92bhrXvklQyUvJD/13uu3VKJaY4YN42w
	 +9nizPrFK9kNmFDpXrRdkg/SfWpPwVX0nqCt9A6VhYUoNwSo0oIuA74csN8XK0BpWT
	 1wxhj4Tzon4O1ERYga4XGdSuKwK703WB0nXg3wjVlnCzSbetXiLNbbcZ6rm45twpNB
	 XVsAgJvg+hKT9IEdCR6rFn2iHavF6Kwx6dN865cKoV3C1XA5+LuzDzl00Ma+OSE7pm
	 VCvP6fRvbVTEjseT0HVz/HC/9OQfvrMHkfVCl50X8oJA9FdxX+VLvNeCf3nSOfoiWN
	 pVxAgbj92qKCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] btrfs: add space_info argument to btrfs_chunk_alloc()
Date: Sun,  9 Aug 2026 11:03:54 -0400
Message-ID: <20260809150356.1872210-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809150356.1872210-1-sashal@kernel.org>
References: <2026080520-wikipedia-kindness-ddd8@gregkh>
 <20260809150356.1872210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit 098a442d5b6d440602604dc1a88706a2a91bce4e ]

Take a btrfs_space_info argument in btrfs_chunk_alloc(). New block group
will belong to that space_info.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 8bc4d7209611 ("btrfs: zoned: fix missing chunk metadata reservation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 27 +++++++++++++++++----------
 fs/btrfs/block-group.h |  3 ++-
 fs/btrfs/extent-tree.c |  6 ++++--
 fs/btrfs/space-info.c  |  2 +-
 fs/btrfs/transaction.c |  5 +++--
 5 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3bc6c99ed2e38..2e8c7b530fc25 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2929,6 +2929,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 			     bool do_chunk_alloc)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_space_info *space_info = cache->space_info;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	u64 alloc_flags;
@@ -2981,7 +2982,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		 */
 		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		if (alloc_flags != cache->flags) {
-			ret = btrfs_chunk_alloc(trans, alloc_flags,
+			ret = btrfs_chunk_alloc(trans, space_info, alloc_flags,
 						CHUNK_ALLOC_FORCE);
 			/*
 			 * ENOSPC is allowed here, we may have enough space
@@ -3009,15 +3010,15 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	    (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM))
 		goto unlock_out;
 
-	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
-	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	alloc_flags = btrfs_get_alloc_profile(fs_info, space_info->flags);
+	ret = btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
 	/*
 	 * We have allocated a new chunk. We also need to activate that chunk to
 	 * grant metadata tickets for zoned filesystem.
 	 */
-	ret = btrfs_zoned_activate_one_bg(fs_info, cache->space_info, true);
+	ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
 	if (ret < 0)
 		goto out;
 
@@ -3875,8 +3876,15 @@ static int should_alloc_chunk(const struct btrfs_fs_info *fs_info,
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 {
 	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
+	struct btrfs_space_info *space_info;
+
+	space_info = btrfs_find_space_info(trans->fs_info, type);
+	if (!space_info) {
+		DEBUG_WARN();
+		return -EINVAL;
+	}
 
-	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	return btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
 static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
@@ -4072,6 +4080,8 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
  *
  * This function, btrfs_chunk_alloc(), belongs to phase 1.
  *
+ * @space_info: specify which space_info the new chunk should belong to.
+ *
  * If @force is CHUNK_ALLOC_FORCE:
  *    - return 1 if it successfully allocates a chunk,
  *    - return errors including -ENOSPC otherwise.
@@ -4080,11 +4090,11 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
  *    - return 1 if it successfully allocates a chunk,
  *    - return errors including -ENOSPC otherwise.
  */
-int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
+		      struct btrfs_space_info *space_info, u64 flags,
 		      enum btrfs_chunk_alloc_enum force)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_space_info *space_info;
 	struct btrfs_block_group *ret_bg;
 	bool wait_for_alloc = false;
 	bool should_alloc = false;
@@ -4123,9 +4133,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return -ENOSPC;
 
-	space_info = btrfs_find_space_info(fs_info, flags);
-	ASSERT(space_info);
-
 	do {
 		spin_lock(&space_info->lock);
 		if (force < space_info->force_alloc)
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a8a6a21e393d2..509c963e4e1e2 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -327,7 +327,8 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 			     bool force_wrong_size_class);
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 			       u64 num_bytes, int delalloc);
-int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
+		      struct btrfs_space_info *space_info, u64 flags,
 		      enum btrfs_chunk_alloc_enum force);
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 72d32a254cdb5..ebb94ec9f3d70 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4034,6 +4034,7 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
 static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					struct btrfs_key *ins,
 					struct find_free_extent_ctl *ffe_ctl,
+					struct btrfs_space_info *space_info,
 					bool full_search)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
@@ -4088,7 +4089,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 				return ret;
 			}
 
-			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
+			ret = btrfs_chunk_alloc(trans, space_info, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE_FOR_EXTENT);
 
 			/* Do not bail out on ENOSPC since we can do more. */
@@ -4488,7 +4489,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, full_search);
+	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, space_info,
+					   full_search);
 	if (ret > 0)
 		goto search;
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a54649a5e0785..a50f0db756337 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -807,7 +807,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(trans);
 			break;
 		}
-		ret = btrfs_chunk_alloc(trans,
+		ret = btrfs_chunk_alloc(trans, space_info,
 				btrfs_get_alloc_profile(fs_info, space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8de686b83adbf..04367e5dc96a9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -729,9 +729,10 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * value here.
 	 */
 	if (do_chunk_alloc && num_bytes) {
-		u64 flags = h->block_rsv->space_info->flags;
+		struct btrfs_space_info *space_info = h->block_rsv->space_info;
+		u64 flags = space_info->flags;
 
-		btrfs_chunk_alloc(h, btrfs_get_alloc_profile(fs_info, flags),
+		btrfs_chunk_alloc(h, space_info, btrfs_get_alloc_profile(fs_info, flags),
 				  CHUNK_ALLOC_NO_FORCE);
 	}
 
-- 
2.53.0

