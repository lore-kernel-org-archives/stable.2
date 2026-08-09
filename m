Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBF3D1CA5
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287842; cv=none; b=aFH7jsqDUsqyIlRwKvohxxbSA5U2bzi3DB4CNFzncRVi/Zdai6bSx/CnU3W3eT8ezTDAk6Rgl28dK+UwUhEKbHJHRwuy0lJCjaG1Jd4RhxsjOkNARaME1m760PwFzLo2lv6Yh+IT0ZhujGFvBRk6JHmdd6e6D+cZhnrEBOWqleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287842; c=relaxed/simple;
	bh=k8UbcOo1xwkt85TcxTtybKCNK3YCuGPSdxgvZJupghQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOTIqABTogblDfdO0OUjQanRW9FuFYcKrjr/OTB8++PlTGBL1PEwxhOCTbWKNSAZxvQOqh7byFcwmC+qrrXGRY6FxcQEWdZhRubQw1TRSTPqRRIKhF2gyWSPMfzsyZFPPc66rshPlfyqQEMQuAFM7Lvd1HPyUoL0zQEihpzkxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJnlEx1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJnlEx1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9971A1F00A3D;
	Sun,  9 Aug 2026 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786287840;
	bh=W++BkZYC1wk4zryDqovmB53o43oHpYDEVJn79ZUV6Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eJnlEx1DiUvdiYpQ8WYd4zlZSXLBMVjsLesjMMwEoIG3Ui7aPzzI/BojasOeEg2pX
	 VbeFm3Wx5vzb1I0vF2Sl5gI5T/3GTbJZvrcGRrvSEV32waJ2v4goDjiYrxWLQMazcL
	 Ca+3obeyXTZkC771hMbk5kfkZQgiJSC36A06m++BJtccY7c2xezo8iaWYwuL5GwQbs
	 VdSpwpzMlG93DQWpc5pwrrbjrcZJKtDe2CMzw6wGVvNuR2qT0zbK4gC5uCQvEnPwXz
	 FeNDcJzYwxjUUJvRiCMgc1zmeOxIcBxNZif1yoylfGMvQkhzJcAEFAlzQ6N0h1FZ7P
	 svLb0x7IlILrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] btrfs: remove fs_info argument from btrfs_zoned_activate_one_bg()
Date: Sun,  9 Aug 2026 11:03:55 -0400
Message-ID: <20260809150356.1872210-3-sashal@kernel.org>
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
index 2e8c7b530fc25..8741495a8decd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3018,7 +3018,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	 * We have allocated a new chunk. We also need to activate that chunk to
 	 * grant metadata tickets for zoned filesystem.
 	 */
-	ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
+	ret = btrfs_zoned_activate_one_bg(space_info, true);
 	if (ret < 0)
 		goto out;
 
@@ -4284,7 +4284,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 			 * We have a new chunk. We also need to activate it for
 			 * zoned filesystem.
 			 */
-			ret = btrfs_zoned_activate_one_bg(fs_info, info, true);
+			ret = btrfs_zoned_activate_one_bg(info, true);
 			if (ret < 0)
 				return;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index dabbfc3b7d776..8076cd65c0c56 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2453,10 +2453,9 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
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
index c18f31d3dc25f..2cc73218dcd51 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -81,8 +81,7 @@ bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
 int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
-int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info, bool do_finish);
+int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
@@ -253,8 +252,7 @@ static inline int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
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

