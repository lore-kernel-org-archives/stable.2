Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0946EF77
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212087; cv=none; b=fbSYPBrXQh2kngqzZ20yxUbzetAzmBPdHxfq6dees5z3Mj2hCr0ij9jOUIjJnbl0baj6LMOQBjxKlPLl2MO/pxl6UbkVDE5mVQMGF5Jn6nNbUB2Q7f0kYqoN3igfu9UysAaU1gg0wGps/VLcyh3XsS5oVunVJboNdqvjSQtMvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212087; c=relaxed/simple;
	bh=5LonhNIh8I4QILs8FHCpwSVFhSr4ljDaRR7yk3VNJmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+ycHcRWMipxNC7w4q0NPuvbyz4wCm+qXr9DesNRYh6YZuq/FpB5UyqbYItS+U/h93LXYE2aseHSDYGeK9wSdydnEetsKh5eCWUNaR/RglWFY7E+y3xR4YngAwBdvcnfv1V9ZWnUwMd/sjOq26/uQ7pf+MPj2Oreu6f7eqZ12y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYrKXNdN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYrKXNdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6E31F000FF;
	Sat, 12 Sep 2026 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212086;
	bh=PEutHF8wY601R4rRGeevJfsHlWmCrDUlNgMeWMBQBsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XYrKXNdNWGm2voHtPNGZJooWfJdMqMwdyZvkAwLclzT1iMfuIQ7Fthcmpl4gJ4grw
	 t+F1hFLFSLd0aBS6hIn1VOl+HWkkD0UxnnnMyjnzn5H9nDn62Oua2n6pwGTVw7Uvpu
	 PeCsB2YHVjkKZ2rZrVyoKQ8MOPy28J6ZVRtqBU+/lcRMAX/VFQJ5Rad/2ym4gNRJV3
	 homPrBLo5NTA2cJSnAX8i8gta79wyulzifLcOhpz7dXgK+DUbZ1iZCnZnok8tTnmQi
	 RM8J4whEyIxj6uez6XoF/m7nMwjnjUswWhPRHlemKvXtUIL66oEsiwzSPvmIOZDygC
	 W2m4LZ5UOkYLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] f2fs: stop checkpoint when get a out-of-bounds segment
Date: Sat, 12 Sep 2026 07:21:22 -0400
Message-ID: <20260912112123.2312505-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912112123.2312505-1-sashal@kernel.org>
References: <2026090947-bankable-stroller-237b@gregkh>
 <20260912112123.2312505-1-sashal@kernel.org>
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
index c99436e829af1..b9fb11708392e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3365,7 +3365,7 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 379839f5b4b74..33a2079b77c2b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1877,8 +1877,11 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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
index 1313caa60a4d2..f0c96826ee3e0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2479,6 +2479,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	bool init = true;
 	int go_left = 0;
 	int i;
+	int ret = 0;
 
 	spin_lock(&free_i->segmap_lock);
 
@@ -2494,7 +2495,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
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
@@ -2510,7 +2514,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
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
@@ -2551,7 +2558,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
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
@@ -2898,7 +2911,7 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2929,6 +2942,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 
 	mutex_unlock(&curseg->curseg_mutex);
 	up_read(&SM_I(sbi)->curseg_lock);
+	return f2fs_cp_error(sbi) ? -EIO : 0;
 }
 
 static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
-- 
2.53.0

