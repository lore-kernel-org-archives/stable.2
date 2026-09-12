Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC94BEE32
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211817; cv=none; b=LpmMNdZ1trKdFPKr8mn+efgICO1tI8Ygg1pIU3x/WKT6/IjVidICr46/cIuxSvyPe0TXpqw+CdeQ1tcEgqqMMbqOd1ztN0PUXxY2s19hRXUBWVvTmkGKdcoJ5v3+La+a4OmXc5bHCRSHmBSLIwlTGRjPmVI1KZDT/UF4bEhZ9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211817; c=relaxed/simple;
	bh=HmOixl4/Ifc2weEpLkYRzXkTrXjFoJJUcZKns9ZmpAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPTLyPZt8x1p9n5nk5wl6WQvKZp5G63Wi6RUM0l6NBqw+tq/vxXiSdODCQLubQopi9ldFIapeLGH0VFrncaHIunNqMh785lmVm7/ruQevjcm6SpKGmACtNt3LDUPBi5fTyOweoZq9ZkcMJ/oF5RHDz353tYShUVvm7PR0xJevyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNikQxWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNikQxWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABD31F000FF;
	Sat, 12 Sep 2026 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211815;
	bh=LTyFAJ8Qpbw61zkTZ/SPiqYz/mdwPtL9kNofaX8dCN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNikQxWNTwhMOOEHFt5GYCZqpm2B3Ck4aGG0AK1H1KmYC1RenAWN2ZLh7/gP/BAQ3
	 e4YtGY/EdiGWxx/n0UkcoS6a4fxCzE8cXbdOqkXl9oyUcqYe/XGMPq2WWmh5tLMWq0
	 hfauRpZ1ek+iWkhESGAaTCopEoMDBfGJVqiZg32bh9m8dj5a/sNfFsqgQjPjaMPrEl
	 Lczx4tB5nWgD6ZgAddBa+oJQgf8yAWQZ4maWMpmoaeUVab4CJbzW6Y64CbLH8DmoRm
	 5EkxF5HK8Y7KjVIYb+vOK0SlOlIjpbnRrOiVvNQ1aeUd5r3hSo3G5EP2MtxdC9zHPd
	 9UTAc++N95oYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	wallentx <william.allentx@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] Revert: "f2fs: check in-memory block bitmap"
Date: Sat, 12 Sep 2026 07:16:50 -0400
Message-ID: <20260912111653.2276190-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090944-reprint-spruce-0599@gregkh>
References: <2026090944-reprint-spruce-0599@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit a2b251259bf2bdf550893bac078e9ce0a10e76c9 ]

Commit 355e78913c0d ("f2fs: check in-memory block bitmap") added
a mirror for valid block bitmap, it expects to detect in-memory
corruption, however we never got any reports from the check points
for almost decade, let's remove the code, it can help to save
memories.

Cc: wallentx <william.allentx@gmail.com>
Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 2b8704b6a8b2 ("f2fs: fix to reset all pinned status during fggc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 38 --------------------------------------
 fs/f2fs/segment.h |  6 ------
 2 files changed, 44 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5e2789cd96b5e..b39dcf8973a10 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2459,9 +2459,6 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 				unsigned int segno, block_t blkaddr, unsigned int offset, int del)
 {
 	bool exist;
-#ifdef CONFIG_F2FS_CHECK_FS
-	bool mir_exist;
-#endif
 	int i;
 	int del_count = -del;
 
@@ -2469,15 +2466,6 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 
 	for (i = 0; i < del_count; i++) {
 		exist = f2fs_test_and_clear_bit(offset + i, se->cur_valid_map);
-#ifdef CONFIG_F2FS_CHECK_FS
-		mir_exist = f2fs_test_and_clear_bit(offset + i,
-						se->cur_valid_map_mir);
-		if (unlikely(exist != mir_exist)) {
-			f2fs_err(sbi, "Inconsistent error when clearing bitmap, blk:%u, old bit:%d",
-				blkaddr + i, exist);
-			f2fs_bug_on(sbi, 1);
-		}
-#endif
 		if (unlikely(!exist)) {
 			f2fs_err(sbi, "Bitmap was wrongly cleared, blk:%u", blkaddr + i);
 			f2fs_bug_on(sbi, 1);
@@ -2518,20 +2506,8 @@ static int update_sit_entry_for_alloc(struct f2fs_sb_info *sbi, struct seg_entry
 				unsigned int segno, block_t blkaddr, unsigned int offset, int del)
 {
 	bool exist;
-#ifdef CONFIG_F2FS_CHECK_FS
-	bool mir_exist;
-#endif
 
 	exist = f2fs_test_and_set_bit(offset, se->cur_valid_map);
-#ifdef CONFIG_F2FS_CHECK_FS
-	mir_exist = f2fs_test_and_set_bit(offset,
-					se->cur_valid_map_mir);
-	if (unlikely(exist != mir_exist)) {
-		f2fs_err(sbi, "Inconsistent error when setting bitmap, blk:%u, old bit:%d",
-			blkaddr, exist);
-		f2fs_bug_on(sbi, 1);
-	}
-#endif
 	if (unlikely(exist)) {
 		f2fs_err(sbi, "Bitmap was wrongly set, blk:%u", blkaddr);
 		f2fs_bug_on(sbi, 1);
@@ -4759,11 +4735,6 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			int offset, sit_offset;
 
 			se = get_seg_entry(sbi, segno);
-#ifdef CONFIG_F2FS_CHECK_FS
-			if (memcmp(se->cur_valid_map, se->cur_valid_map_mir,
-						SIT_VBLOCK_MAP_SIZE))
-				f2fs_bug_on(sbi, 1);
-#endif
 
 			/* add discard candidates */
 			if (!(cpc->reason & CP_DISCARD)) {
@@ -4854,11 +4825,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	if (!sit_i->dirty_sentries_bitmap)
 		return -ENOMEM;
 
-#ifdef CONFIG_F2FS_CHECK_FS
-	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * (3 + discard_map);
-#else
 	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * (2 + discard_map);
-#endif
 	sit_i->bitmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
 	if (!sit_i->bitmap)
 		return -ENOMEM;
@@ -4872,11 +4839,6 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 		sit_i->sentries[start].ckpt_valid_map = bitmap;
 		bitmap += SIT_VBLOCK_MAP_SIZE;
 
-#ifdef CONFIG_F2FS_CHECK_FS
-		sit_i->sentries[start].cur_valid_map_mir = bitmap;
-		bitmap += SIT_VBLOCK_MAP_SIZE;
-#endif
-
 		if (discard_map) {
 			sit_i->sentries[start].discard_map = bitmap;
 			bitmap += SIT_VBLOCK_MAP_SIZE;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index d05d133c89aff..21ada383f19a4 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -172,9 +172,6 @@ struct seg_entry {
 	unsigned int ckpt_valid_blocks:10;	/* # of valid blocks last cp */
 	unsigned int padding:6;		/* padding */
 	unsigned char *cur_valid_map;	/* validity bitmap of blocks */
-#ifdef CONFIG_F2FS_CHECK_FS
-	unsigned char *cur_valid_map_mir;	/* mirror of current valid bitmap */
-#endif
 	/*
 	 * # of valid blocks and the validity bitmap stored in the last
 	 * checkpoint pack. This information is used by the SSR mode.
@@ -403,9 +400,6 @@ static inline void seg_info_from_raw_sit(struct seg_entry *se,
 	se->ckpt_valid_blocks = GET_SIT_VBLOCKS(rs);
 	memcpy(se->cur_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 	memcpy(se->ckpt_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
-#ifdef CONFIG_F2FS_CHECK_FS
-	memcpy(se->cur_valid_map_mir, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
-#endif
 	se->type = GET_SIT_TYPE(rs);
 	se->mtime = le64_to_cpu(rs->mtime);
 }
-- 
2.53.0

