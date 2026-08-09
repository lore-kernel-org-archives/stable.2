Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E7156C6A
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786284162; cv=none; b=CLfxrNr2hEdWI+EBWSXaNY5X2ILhDAbfatL51imaFxpZqLt+trmuXHLxW8C64EqvxIMTCUt4b9kCPMY7vbEJrvwGeOwAZM82zicarvmQWCynv5kN5fJ08JiUg14HYayIVSv/zpirUpgu5ClWvRqQsUlb8HjD0GQI8JvkOvGqHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786284162; c=relaxed/simple;
	bh=bPoHkXKtxglMbvXDmmq75VOHctm+8v1Jcg4oO1pz4tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThgMpH7oATizyayTAmlxWeJ+PsfdBoncywiLhB1eBgdlN85/40PCrQjD92ydeaRf2ghc4L2u8LNFVjEqrNvX9aKR7cqyYh+HiD/SeTyEPS3S9uQ605qN20KEgx1n7d6fv2sarm/dYv9o6EMDIYXYFuOyiHcp6zkGDZgGoF0z7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6APnmqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6APnmqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DC11F000E9;
	Sun,  9 Aug 2026 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786284160;
	bh=Jl0I3FZLRdE8sA0y3jny0pMLxvmOja0gnfdhRUGiUfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V6APnmqcOMI65DQ7dMhpm7UhtZ+FEWrtZzyPZvQZYLPnWjR6fxq1ICoaBx0F7OP4O
	 AN4weEmxU24/+hnsqpQCIp9/CfsjaERCqrIlnnRu9gSX7btyP2VSEozJVK9L0bGzjT
	 TOKeP+EUNolwv7gTQVj5XOT5inCj4DhNpZsOkoiPJ0vv/DOzWb86B32HYhdXWG3Lat
	 NIgdYT7YHG9gm3o7wwBkTrS59+A7GoT4tbF3URY/FKb+IDLpDUgc3cusskfMFdC3Nu
	 HJbcUKQy2Ss/NX0Q2rU4bVEV7EqtHZU1yTZeZhJQD0EgWWrlxKen0Lj9p9aQT2RjuD
	 Ohwv/t2BTTREw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] btrfs: remove fs_info argument from btrfs_zoned_activate_one_bg()
Date: Sun,  9 Aug 2026 10:02:37 -0400
Message-ID: <20260809140238.1592207-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080520-celestial-balmy-f31a@gregkh>
References: <2026080520-celestial-balmy-f31a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a232ff90d14657c8637c6e94b606bb5d700a2ecb ]

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 8bc4d7209611 ("btrfs: zoned: fix missing chunk metadata reservation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 4 ++--
 fs/btrfs/zoned.c       | 5 ++---
 fs/btrfs/zoned.h       | 6 ++----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e6bac34ebe83d..2c1827cb957c6 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3073,7 +3073,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	 * We have allocated a new chunk. We also need to activate that chunk to
 	 * grant metadata tickets for zoned filesystem.
 	 */
-	ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
+	ret = btrfs_zoned_activate_one_bg(space_info, true);
 	if (ret < 0)
 		goto out;
 
@@ -4354,7 +4354,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 			 * We have a new chunk. We also need to activate it for
 			 * zoned filesystem.
 			 */
-			ret = btrfs_zoned_activate_one_bg(fs_info, info, true);
+			ret = btrfs_zoned_activate_one_bg(info, true);
 			if (ret < 0)
 				return;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b8fc97e33009b..b09cc6621c072 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2959,10 +2959,9 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 	return ret < 0 ? ret : 1;
 }
 
-int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info,
-				bool do_finish)
+int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_finish)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct btrfs_block_group *bg;
 	int index;
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 2b807a02d1a8a..5cefdeb08b7b7 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -93,8 +93,7 @@ bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
 int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
-int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info, bool do_finish);
+int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
 int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num_bytes);
 #else /* CONFIG_BLK_DEV_ZONED */
@@ -261,8 +260,7 @@ static inline int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 	return 1;
 }
 
-static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-					      struct btrfs_space_info *space_info,
+static inline int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info,
 					      bool do_finish)
 {
 	/* Consider all the block groups are active */
-- 
2.53.0

