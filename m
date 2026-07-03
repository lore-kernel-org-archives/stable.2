Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD03D9690
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085467; cv=none; b=iCLae9DyYJwyRRkK9sL68C/txwKzVgoOfQfdyWuToKCNww/7bPquW0D3uxmh1Pp2RrUYRQt59jGwYvVSTg1V1cUqzQt9U/DcWkf0g3+7j/sikAE+blU7oZhGjk0CDLrbjfrrSvIzf66TtujB40MZR9mIYDR2nWzxE/3rRdRAvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085467; c=relaxed/simple;
	bh=1yJ1ldlX/it+oiYxH6Pt8Ubgw73SgjbWOex3clGys1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0012/CZvMHd7h+2e1x09W02Ba1aYqKK9PMW8NCz8bcvGE5SsiPTNatZeCT/gOrDC03cH6JqAxiESUq4LxWSV8vWM9oGFTaBGeIhJ2n3Q1ziaBOPHLwx1dUnHm3Wej7tBTzHp389loqbNimLalPZNCed20I6/x0193HJHFtb7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcvjbKnK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcvjbKnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725181F00A3F;
	Fri,  3 Jul 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085465;
	bh=qdXp/Qk7PeYa/TfkvJPWMArGy/cFt15nIc8FJStS5Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fcvjbKnKREZ2yIaXt8ygjq3DtzCUd3lM0HwfDkIWRCznG7h0XJAxKdoqKMzmTysZE
	 8+AlFoVRVjo429Xt7/WH4TtfMflNa6ptXdwUTQV/tSrQPJgLZkEl+gOFy9aPj/3Gyz
	 Njr6MAV05GroA3Al8/p+S8AbTaHcH69VJskIeQjSMplLvmorI0T5CbFWxog13obC18
	 LnyufsumSMN40Wswr6C2+zEx+iqiIPijAD92sW1P/IIZM3XOoLPrEuZq6YoEi/lgcj
	 5xUwamusWcjDh+QVu+L9AbzdQA66anKIuauQ2vtIslTHhaXiqo1Vh2F0V8BEW03+4o
	 qsMEF6Mwuibfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] f2fs: adjust zone capacity when considering valid block count
Date: Fri,  3 Jul 2026 09:31:00 -0400
Message-ID: <20260703133101.4123681-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070256-cranberry-relax-7024@gregkh>
References: <2026070256-cranberry-relax-7024@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 074b5ea2900ea8e40f8e7a3fd37e0a55ad3d5874 ]

This patch fixes counting unusable blocks set by zone capacity when
checking the valid block count in a section.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 4275b59673eb ("f2fs: fix to round down start offset of fallocate for pin file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/debug.c   | 2 +-
 fs/f2fs/file.c    | 6 +++---
 fs/f2fs/gc.c      | 4 ++--
 fs/f2fs/segment.c | 7 +++----
 fs/f2fs/segment.h | 8 ++++----
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 197c914119da8e..5f52d004105aea 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -39,7 +39,7 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi)
 
 	bimodal = 0;
 	total_vblocks = 0;
-	blks_per_sec = BLKS_PER_SEC(sbi);
+	blks_per_sec = CAP_BLKS_PER_SEC(sbi);
 	hblks_per_sec = blks_per_sec / 2;
 	for (segno = 0; segno < MAIN_SEGS(sbi); segno += sbi->segs_per_sec) {
 		vblocks = get_valid_blocks(sbi, segno, true);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 624368e3f89ea1..f2a4faf04331ee 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1681,7 +1681,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		return 0;
 
 	if (f2fs_is_pinned_file(inode)) {
-		block_t sec_blks = BLKS_PER_SEC(sbi);
+		block_t sec_blks = CAP_BLKS_PER_SEC(sbi);
 		block_t sec_len = roundup(map.m_len, sec_blks);
 
 		map.m_len = sec_blks;
@@ -2595,7 +2595,7 @@ static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
 			ret = -EAGAIN;
 		goto out;
 	}
-	range->start += BLKS_PER_SEC(sbi);
+	range->start += CAP_BLKS_PER_SEC(sbi);
 	if (range->start <= end)
 		goto do_more;
 out:
@@ -2717,7 +2717,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		goto out;
 	}
 
-	sec_num = DIV_ROUND_UP(total, BLKS_PER_SEC(sbi));
+	sec_num = DIV_ROUND_UP(total, CAP_BLKS_PER_SEC(sbi));
 
 	/*
 	 * make sure there are enough free section for LFS allocation, this can
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index dfa99cd195b836..379839f5b4b746 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -441,7 +441,7 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
 	unsigned long long age, u, accu;
 	unsigned long long max_mtime = sit_i->dirty_max_mtime;
 	unsigned long long min_mtime = sit_i->dirty_min_mtime;
-	unsigned int sec_blocks = BLKS_PER_SEC(sbi);
+	unsigned int sec_blocks = CAP_BLKS_PER_SEC(sbi);
 	unsigned int vblocks;
 	unsigned int dirty_threshold = max(am->max_candidate_count,
 					am->candidate_ratio *
@@ -1421,7 +1421,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		 */
 		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
 			(!force_migrate && get_valid_blocks(sbi, segno, true) ==
-							BLKS_PER_SEC(sbi)))
+							CAP_BLKS_PER_SEC(sbi)))
 			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a6d05264f13659..08f27fd2dfd471 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -820,7 +820,7 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 				get_valid_blocks(sbi, segno, true);
 
 			f2fs_bug_on(sbi, unlikely(!valid_blocks ||
-					valid_blocks == BLKS_PER_SEC(sbi)));
+					valid_blocks == CAP_BLKS_PER_SEC(sbi)));
 
 			if (!IS_CURSEC(sbi, secno))
 				set_bit(secno, dirty_i->dirty_secmap);
@@ -856,7 +856,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 			unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
 
 			if (!valid_blocks ||
-					valid_blocks == BLKS_PER_SEC(sbi)) {
+					valid_blocks == CAP_BLKS_PER_SEC(sbi)) {
 				clear_bit(secno, dirty_i->dirty_secmap);
 				return;
 			}
@@ -4577,7 +4577,6 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int segno = 0, offset = 0, secno;
 	block_t valid_blocks, usable_blks_in_seg;
-	block_t blks_per_sec = BLKS_PER_SEC(sbi);
 
 	while (1) {
 		/* find dirty segment based on free segmap */
@@ -4606,7 +4605,7 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 		valid_blocks = get_valid_blocks(sbi, segno, true);
 		secno = GET_SEC_FROM_SEG(sbi, segno);
 
-		if (!valid_blocks || valid_blocks == blks_per_sec)
+		if (!valid_blocks || valid_blocks == CAP_BLKS_PER_SEC(sbi))
 			continue;
 		if (IS_CURSEC(sbi, secno))
 			continue;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 720951ce2f9d14..9c82cb772422f5 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -608,10 +608,10 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 					get_pages(sbi, F2FS_DIRTY_DENTS) +
 					get_pages(sbi, F2FS_DIRTY_IMETA);
 	unsigned int total_dent_blocks = get_pages(sbi, F2FS_DIRTY_DENTS);
-	unsigned int node_secs = total_node_blocks / BLKS_PER_SEC(sbi);
-	unsigned int dent_secs = total_dent_blocks / BLKS_PER_SEC(sbi);
-	unsigned int node_blocks = total_node_blocks % BLKS_PER_SEC(sbi);
-	unsigned int dent_blocks = total_dent_blocks % BLKS_PER_SEC(sbi);
+	unsigned int node_secs = total_node_blocks / CAP_BLKS_PER_SEC(sbi);
+	unsigned int dent_secs = total_dent_blocks / CAP_BLKS_PER_SEC(sbi);
+	unsigned int node_blocks = total_node_blocks % CAP_BLKS_PER_SEC(sbi);
+	unsigned int dent_blocks = total_dent_blocks % CAP_BLKS_PER_SEC(sbi);
 	unsigned int free, need_lower, need_upper;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-- 
2.53.0

