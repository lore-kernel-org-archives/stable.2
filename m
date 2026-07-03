Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341E3D2FE6
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085020; cv=none; b=gM/QLAMt4BLybQF7bSHlXTG9O/FRN9k2ZaqsHnWZQjkJgR5mADAkF9CKkLlpy2Fz58u5o7Ke7tM7VF+f7DlqDAiBT9JbvNETAsuBRFf0iV0TnqYHYj1yAE1DUS0qXIZwmbAg3DbXsJJgJpDMebM89nEJSzT8Wu9PqNhHxzV6LUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085020; c=relaxed/simple;
	bh=/Ls9/eWR3E56pKDnwiTc/D+Dg4ygCPxpXwTATFHTtXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lmv5dq7vZDxtF4Rfj2FYOApUI9zwLd7Go+D7umZswmRvBfCMmPagk5uiW9v5HxJuL781XKu18v0cSsQkwsEmeoSPJc36mA340Bm5NUnY1lNCB34ro3t91bveWWmLVUw4ff5duIKyqGwZ5iJnSz8zRrfTO/zr6gKlB2P1+C2/69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4crB9Pz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4crB9Pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906D21F000E9;
	Fri,  3 Jul 2026 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085017;
	bh=3O5vulOw1RkXtdUS3Z+fHklQNxCITJv+5Ql+ilx1ZAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U4crB9PzOtsIpn6tzq7j9+A4Y+dfKA+MHZXjzqVhaV018rUr8Z4Pd3IqTCDj5UnbN
	 VR4GmSSGH1yu4vcwuHKy/lQMbucHk9dCgqlT7/FolKskv2Zu+pL9olRBA+HVsfyXHT
	 KsOUPi98JiaH08VugpuOmBcWtoPdf9PIshX+CnM+X7XbIXJSIX8pfEAo3ZIa7oKXb1
	 2vAt9iYas94m0aBKy2GSz98PzwLsxOGJUMVY8905yWPfYoS0M2XUehILCwlPZ6cJHP
	 3ck6uhcF9WM7riFZz2PRQkeFh3+GHbdoM7ZWF7xnRX5Mz+5kNyp7LAPYMx9/HKk6c6
	 08IkwS1f8XJ3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] f2fs: adjust zone capacity when considering valid block count
Date: Fri,  3 Jul 2026 09:23:33 -0400
Message-ID: <20260703132334.4098206-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070255-livable-cheese-d39c@gregkh>
References: <2026070255-livable-cheese-d39c@gregkh>
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
index b449c7a372a4b1..cd21b4edeca1cb 100644
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
index 1c5f2964649f27..d4d485032e6ea6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1694,7 +1694,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		return 0;
 
 	if (f2fs_is_pinned_file(inode)) {
-		block_t sec_blks = BLKS_PER_SEC(sbi);
+		block_t sec_blks = CAP_BLKS_PER_SEC(sbi);
 		block_t sec_len = roundup(map.m_len, sec_blks);
 
 		map.m_len = sec_blks;
@@ -2547,7 +2547,7 @@ static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
 			ret = -EAGAIN;
 		goto out;
 	}
-	range->start += BLKS_PER_SEC(sbi);
+	range->start += CAP_BLKS_PER_SEC(sbi);
 	if (range->start <= end)
 		goto do_more;
 out:
@@ -2672,7 +2672,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		goto out;
 	}
 
-	sec_num = DIV_ROUND_UP(total, BLKS_PER_SEC(sbi));
+	sec_num = DIV_ROUND_UP(total, CAP_BLKS_PER_SEC(sbi));
 
 	/*
 	 * make sure there are enough free section for LFS allocation, this can
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9a57754e6e0c1d..69a51fcfbead45 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -461,7 +461,7 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
 	unsigned long long age, u, accu;
 	unsigned long long max_mtime = sit_i->dirty_max_mtime;
 	unsigned long long min_mtime = sit_i->dirty_min_mtime;
-	unsigned int sec_blocks = BLKS_PER_SEC(sbi);
+	unsigned int sec_blocks = CAP_BLKS_PER_SEC(sbi);
 	unsigned int vblocks;
 	unsigned int dirty_threshold = max(am->max_candidate_count,
 					am->candidate_ratio *
@@ -1445,7 +1445,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		 */
 		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
 			(!force_migrate && get_valid_blocks(sbi, segno, true) ==
-							BLKS_PER_SEC(sbi)))
+							CAP_BLKS_PER_SEC(sbi)))
 			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 52d5915cee9674..95fdad8b19fdaf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -833,7 +833,7 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 				get_valid_blocks(sbi, segno, true);
 
 			f2fs_bug_on(sbi, unlikely(!valid_blocks ||
-					valid_blocks == BLKS_PER_SEC(sbi)));
+					valid_blocks == CAP_BLKS_PER_SEC(sbi)));
 
 			if (!IS_CURSEC(sbi, secno))
 				set_bit(secno, dirty_i->dirty_secmap);
@@ -869,7 +869,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 			unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
 
 			if (!valid_blocks ||
-					valid_blocks == BLKS_PER_SEC(sbi)) {
+					valid_blocks == CAP_BLKS_PER_SEC(sbi)) {
 				clear_bit(secno, dirty_i->dirty_secmap);
 				return;
 			}
@@ -4679,7 +4679,6 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int segno = 0, offset = 0, secno;
 	block_t valid_blocks, usable_blks_in_seg;
-	block_t blks_per_sec = BLKS_PER_SEC(sbi);
 
 	while (1) {
 		/* find dirty segment based on free segmap */
@@ -4708,7 +4707,7 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 		valid_blocks = get_valid_blocks(sbi, segno, true);
 		secno = GET_SEC_FROM_SEG(sbi, segno);
 
-		if (!valid_blocks || valid_blocks == blks_per_sec)
+		if (!valid_blocks || valid_blocks == CAP_BLKS_PER_SEC(sbi))
 			continue;
 		if (IS_CURSEC(sbi, secno))
 			continue;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index e59b330ed83351..5fdb393524c888 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -605,10 +605,10 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
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

