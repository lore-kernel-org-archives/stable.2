Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212E4BEE32
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211826; cv=none; b=VCV/bom17TFnQrU/vy0f30W1SsPJFajxMQWLxfDk+AG/K49OqaJ4+dYxTsCU5N+X5fGQZ9UH0aOiMv0Xp4fEMsibNrWJgvJyXpLCjRMkXmhX/iOIBjt56kLmb2Wpddu1LjvuO6dIX4ikAXQD9FETIX8Z9JEPq+c3NokRQAnUPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211826; c=relaxed/simple;
	bh=0xXwmEgL+aompYTWC4ug3qQhcG7P09P+8QKFI9h5Ew4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkfR65a/FIF4gtM9OjkazBXHysd1S/LkTOO2gWfKYnTiazuW+lWInQ3QTA0Xr9f7sqng88Hy3XoVXw67bOMMZes/9RUQqrNNKtoNbEm1HR2CKxPecDLStssJl5qlS+cUOxBfoRoEMGSUxdC04Bw5nmx087bNrwqpaA0lj9eTjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5vav8yN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5vav8yN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF401F00893;
	Sat, 12 Sep 2026 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211825;
	bh=V245YnrLeCfoiOlhI9EfKPw1n7G5fwVKnKfk6E+Cnxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h5vav8yNUkoPwcpMyded00XQ+QtsNETKjgsGUqvCJCAhM472NJ75p/ssznOzyvaxd
	 0QAslf224CPKbHuJNBzLri+kQXcrvd29SpH71kzchGNw5cPepJ9i/jaAAqHrXyCPMA
	 /DSmPk1s5EYIX+p86Z9Fcuf55gbTFqVwZZQfu17zRWZuQHi/K/ENJyvlCPHpjXlvmV
	 gMIkDYPFvuJziMyL9LVUeR+Qbg2FStfkueCacHg5NVK/fzMX9PXASir/h2m0YquKpk
	 FPq5lW3SJG64PYKNTNrWo6TkXJ7HWZPe26ncuAv29lYT6SlRGcXVLSi5l6aWpclxh/
	 dUcB43PM54EqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] f2fs: stop checkpoint when get a out-of-bounds segment
Date: Sat, 12 Sep 2026 07:17:01 -0400
Message-ID: <20260912111702.2280721-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111702.2280721-1-sashal@kernel.org>
References: <2026090947-hardwired-robust-7d28@gregkh>
 <20260912111702.2280721-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit f9e28904e6442019043a8e94ec6747a064d06003 ]

There is low probability that an out-of-bounds segment will be got
on a small-capacity device. In order to prevent subsequent write requests
allocating block address from this invalid segment, which may cause
unexpected issue, stop checkpoint should be performed.

Also introduce a new stop cp reason: STOP_CP_REASON_NO_SEGMENT.

Note, f2fs_stop_checkpoint(, false) is complex and it may sleep, so we should
move it outside segmap_lock spinlock coverage in get_new_segment().

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

[5.15 dependency adaptation]
Keep the existing left/right allocation policy and stop checkpointing after
releasing segmap_lock when either free-section search is exhausted. Use the
existing two-argument f2fs_stop_checkpoint() API; omit the stop-reason enum
hunk because this branch has no checkpoint-reason recording infrastructure.

Prepare the existing resize loop for 8ec06f50ddd8 without adding functions:
make f2fs_allocate_segment_for_resize() return -EIO when checkpointing has
failed, and have free_segment_range() unwind on that error. The older
allocation helpers do not return errors, so use the existing checkpoint
error flag rather than importing their newer interfaces. Leave the loop's
NR_CURSEG_PERSIST_TYPE bound for the target commit to change.

[ sashal: Reduced backport -- upstream f9e28904e6442 touches 2 file(s), this
  backport carries 3. Not backported here:
  include/linux/f2fs_fs.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 8ec06f50ddd8 ("f2fs: fix to migrate all curseg types during free_segment_range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/gc.c      |  7 +++++--
 fs/f2fs/segment.c | 20 +++++++++++++++++---
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 09da1f3440a8b..238f412a4b4d6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3482,7 +3482,7 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 69a51fcfbead4..56c72a8a82840 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1900,8 +1900,11 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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
index 6c47cebbd0f11..6ce8edbe676a0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2537,6 +2537,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	bool init = true;
 	int go_left = 0;
 	int i;
+	int ret = 0;
 
 	spin_lock(&free_i->segmap_lock);
 
@@ -2552,7 +2553,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		if (dir == ALLOC_RIGHT) {
 			secno = find_next_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi), 0);
-			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
+			if (secno >= MAIN_SECS(sbi)) {
+				ret = -ENOSPC;
+				goto out_unlock;
+			}
 		} else {
 			go_left = 1;
 			left_start = hint - 1;
@@ -2568,7 +2572,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		}
 		left_start = find_next_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi), 0);
-		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
+		if (left_start >= MAIN_SECS(sbi)) {
+			ret = -ENOSPC;
+			goto out_unlock;
+		}
 		break;
 	}
 	secno = left_start;
@@ -2609,7 +2616,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
 	__set_inuse(sbi, segno);
 	*newseg = segno;
+out_unlock:
 	spin_unlock(&free_i->segmap_lock);
+
+	if (ret) {
+		f2fs_stop_checkpoint(sbi, false);
+		f2fs_bug_on(sbi, 1);
+	}
 }
 
 static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
@@ -2944,7 +2957,7 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2975,6 +2988,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 
 	mutex_unlock(&curseg->curseg_mutex);
 	up_read(&SM_I(sbi)->curseg_lock);
+	return f2fs_cp_error(sbi) ? -EIO : 0;
 }
 
 static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
-- 
2.53.0

