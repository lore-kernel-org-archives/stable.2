Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2003090DE
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786286887; cv=none; b=go7WqeL8foYjUbPCs1zWm0SPk7NrlOB3k/3WvMD3KvKFTHlun9KHWGtAMPA7rm1oinCb61LDhmCCkq5crmh/G4fgD3Cu0FmdBoNOqHChCMS6M4g3qv+NggwVTXt+pmNyvr+7/Ub9Yqz5urHq6tu3RMto8LqwowSzqkrYawMt8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786286887; c=relaxed/simple;
	bh=LacXDtSfw2uQxU93/LW7uduFPxVsyh7o70SFxZMrgqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ba6Nbd2hvVcUI9rhpeVkSyIbjTYJcHAUpyyZYTPXx/HODDb2Q62+B239TIibaRJ9x2hYTZyxsBgsNTLlU0VaiJXHgyTp20UkWpFSleje0Oc6W8AS4iiDSJrS/sEMXIriz4wul4/C76+SOgyPiZStDeI4t7Qz9lAzA93I3/+xl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Suz5RhrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Suz5RhrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837C81F00A3A;
	Sun,  9 Aug 2026 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786286884;
	bh=HHoSxaE3Hqdxu1sbzxHlSuS27hDBLINeQs4T71mVyog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Suz5RhrU0o6QlFuH+aDRW9floPqoAtX8ED4GLJEQk6gh2nIq50mbBcFAYPSi5Ed7s
	 ZaucIVPG6Q+MK/4TkL4g+9CyaBfE7X2DM5YJ0OhmLfDjr47mynKYmTXg6MpCeQVmZx
	 Z/G0Wc5zs8cojH/w0xl79eCb9A5RpG2sOclHaYnRHXy2n5YdBCQ6NJjee2wjc10UJH
	 XF74Y3KG5bUvjLkzL4Lyi1dZEyt1YJS/toQvIIy9iq9gBPY1wnjMlWbNAHo8Rok4Xz
	 ddyWSBYx/vHY8tjWE5pSqT6L0dkUKXbTX/RAlTxCQxTw+SzsmiK/2zYOi6ugM7dFso
	 P4ufcdXAsUfkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] btrfs: add space_info argument to btrfs_chunk_alloc()
Date: Sun,  9 Aug 2026 10:47:59 -0400
Message-ID: <20260809144801.1787109-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809144801.1787109-1-sashal@kernel.org>
References: <2026080520-punk-economist-e412@gregkh>
 <20260809144801.1787109-1-sashal@kernel.org>
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
index 3ca24a0845cbe..a40814eb121b3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3003,6 +3003,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 			     bool do_chunk_alloc)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_space_info *space_info = cache->space_info;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	u64 alloc_flags;
@@ -3055,7 +3056,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		 */
 		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		if (alloc_flags != cache->flags) {
-			ret = btrfs_chunk_alloc(trans, alloc_flags,
+			ret = btrfs_chunk_alloc(trans, space_info, alloc_flags,
 						CHUNK_ALLOC_FORCE);
 			/*
 			 * ENOSPC is allowed here, we may have enough space
@@ -3083,15 +3084,15 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
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
 
@@ -3941,8 +3942,15 @@ static int should_alloc_chunk(const struct btrfs_fs_info *fs_info,
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
@@ -4138,6 +4146,8 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
  *
  * This function, btrfs_chunk_alloc(), belongs to phase 1.
  *
+ * @space_info: specify which space_info the new chunk should belong to.
+ *
  * If @force is CHUNK_ALLOC_FORCE:
  *    - return 1 if it successfully allocates a chunk,
  *    - return errors including -ENOSPC otherwise.
@@ -4146,11 +4156,11 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
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
@@ -4189,9 +4199,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return -ENOSPC;
 
-	space_info = btrfs_find_space_info(fs_info, flags);
-	ASSERT(space_info);
-
 	do {
 		spin_lock(&space_info->lock);
 		if (force < space_info->force_alloc)
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 36937eeab9b8a..c01f3af726a17 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -342,7 +342,8 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
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
index 28dca13fb9b09..399c7e10bc14c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4147,6 +4147,7 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
 static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					struct btrfs_key *ins,
 					struct find_free_extent_ctl *ffe_ctl,
+					struct btrfs_space_info *space_info,
 					bool full_search)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
@@ -4201,7 +4202,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 				return ret;
 			}
 
-			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
+			ret = btrfs_chunk_alloc(trans, space_info, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE_FOR_EXTENT);
 
 			/* Do not bail out on ENOSPC since we can do more. */
@@ -4601,7 +4602,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, full_search);
+	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, space_info,
+					   full_search);
 	if (ret > 0)
 		goto search;
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2b71ed343b63d..402eb3b54fb1e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -850,7 +850,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(trans);
 			break;
 		}
-		ret = btrfs_chunk_alloc(trans,
+		ret = btrfs_chunk_alloc(trans, space_info,
 				btrfs_get_alloc_profile(fs_info, space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0a147bc5f0903..da837e034030c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -764,9 +764,10 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
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

