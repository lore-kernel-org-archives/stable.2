Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C42DAFDE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176742; cv=none; b=I3/u0rf0nu7U7eIPBZH4MWHu8W/WypRDle9iqGv0k85prb7Pv2lh/1qQ1k/N3uIVwuACf22uydv1RyIQRFPSP3QwRLFAUG0zmKsJyQb9iEafvLdxOzZ7PB+bB/TBgHvvfVP/PKrFYvMrNFogp8DVctWdAv3qTFsFF6X4B/po78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176742; c=relaxed/simple;
	bh=VqNmQLo+W3R7vgEWPwSWkM8cnWGKt8+/PMW0rZc94m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9WeZ/SwCFvbkvOGLkXN3mXyW5XxrlEA+P19/CVj1OaPt3tbA7ZVtQQgFRP55/CeRumDzuIbAOF9ejC19IPYZRtU0vvrsoX93VFd1TKXDAoWnhTxm8JvDChGpNcb3D+Ly0nI45IfuI6SvQiohVEC6Qa3xlg6TsjoN2QZ8fh3Hu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7+Lj2MM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7+Lj2MM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22BC1F000FF;
	Sat, 12 Sep 2026 01:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176741;
	bh=SFTZ2dfYsDX5Gc8OAhF+m729MWwRsoC1df1lhYeOzUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f7+Lj2MMVDDPbjVvWOTyPkascmCYBMZkclE3kf0CnrD07xTgYdyZNt4vz36IG4GyJ
	 WY5CxuoY565GBm173uQwq9cvSEg8FeRZEDUAIcKNqPhMASWxFO/g8EfBFZYMxCODB4
	 ShTPHqfEcD5vYQF3gY9uisHrClth6n8++6uq3xYN7sfGQFIGIzbKFHN1cBs40YVcgF
	 538sHezsUFsh4RXHUdJ3neQF1J2Zi38C6KjdhJfFJ5062e+1p4DN/9rl9R9Uqd+uTW
	 xiHxEQWH+j0qWrUdm6av5qbQHwTRTpreSj9x24OXiVCmDQpALVClvcn0390BnBRYYQ
	 jdMP6JsloNadA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] f2fs: fix to handle error paths of {new,change}_curseg()
Date: Fri, 11 Sep 2026 21:32:17 -0400
Message-ID: <20260912013218.1761900-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013218.1761900-1-sashal@kernel.org>
References: <2026090947-whimsical-pleat-2344@gregkh>
 <20260912013218.1761900-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit 245930617c9bd85330c78e1a70775e1f61b12f7a ]

{new,change}_curseg() may return error in some special cases,
error handling should be did in their callers, and this will also
facilitate subsequent error path expansion in {new,change}_curseg().

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

[ Backport to 6.1: retain the resize error-handling prerequisite for
  8ec06f50ddd8 ("f2fs: fix to migrate all curseg types during
  free_segment_range"). Return summary-page read errors from change_curseg()
  through f2fs_allocate_segment_for_resize(), and stop free_segment_range()
  through its existing cleanup path on failure.

  Keep new_curseg() as void: this branch's get_new_segment() has no
  recoverable error return. Drop the unrelated ATGC initialization, mount,
  data-allocation and block-replacement hunks. The data-allocation changes
  assume newer return-value and ENOSPC handling absent from this tree, and
  none of these paths is required by the target's resize-loop fix. ]

[ sashal: Reduced backport -- upstream 245930617c9bd touches 4 file(s), this
  backport carries 3. Not backported here:
  fs/f2fs/super.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 8ec06f50ddd8 ("f2fs: fix to migrate all curseg types during free_segment_range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/gc.c      |  7 +++++--
 fs/f2fs/segment.c | 11 +++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4fa1e514a84bb..206b996fd341a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3653,7 +3653,7 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 687b2ce82c854..3ce72db26fe68 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2014,8 +2014,11 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++)
-		f2fs_allocate_segment_for_resize(sbi, type, start, end);
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
+		if (err)
+			goto out;
+	}
 
 	/* do GC to move out valid blocks in the range */
 	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d185b209f89a5..6c3b83cfc8ccb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2674,7 +2674,7 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
  * This function always allocates a used segment(from dirty seglist) by SSR
  * manner, so it should recover the existing segment information of valid blocks
  */
-static void change_curseg(struct f2fs_sb_info *sbi, int type)
+static int change_curseg(struct f2fs_sb_info *sbi, int type)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2700,11 +2700,12 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
 	if (IS_ERR(sum_page)) {
 		/* GC won't be able to use stale summary pages by cp_error */
 		memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
-		return;
+		return PTR_ERR(sum_page);
 	}
 	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
 	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
 	f2fs_put_page(sum_page, 1);
+	return 0;
 }
 
 static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
@@ -2882,11 +2883,12 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int segno;
+	int ret = 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 	mutex_lock(&curseg->curseg_mutex);
@@ -2897,7 +2899,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 		goto unlock;
 
 	if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type, SSR, 0))
-		change_curseg(sbi, type);
+		ret = change_curseg(sbi, type);
 	else
 		new_curseg(sbi, type, true);
 
@@ -2913,6 +2915,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+	return ret;
 }
 
 static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
-- 
2.53.0

