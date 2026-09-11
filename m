Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E545563F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164031; cv=none; b=ljeAz7+pl7JreNbwjPv4EMc+2I9OVwE7EyDxBYhPLuNAM12rcmsskED5222Csjd5ZAiHq3r0NZWg+TB+vO0tDRdqzEVzk2LNjnnZ+YpuVGfYMKM4ua4K8OXkLIiOfbl9cKG5LBMnFRncmXO76xzh7OQqnJaJPIb+H7lUxkybal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164031; c=relaxed/simple;
	bh=2GzDz+Ei7UqgePcHiBLaHtxQ0jSyUk87alrM3D+nw2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6+yDa5OMh+c40nHQm1AFklsojczgDJecRyfnE346pCHgG6xMR0IkmupbuYfP9Q6aMCMUvklGaZLWhtya8tNXn1UAHnz2ZmUGh5vsH5u/xPoADMBI0H1/UcJF0sRuaFFv7k4DjU5OFipcjYHsLjjU39eRfqvuqNw7Hzkd0oQ8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH/e/Rv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH/e/Rv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA60B1F00898;
	Fri, 11 Sep 2026 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164029;
	bh=lxTh7hlOg6jGTZOMpv0YMUOkPvOOtytmGie1W9nABMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HH/e/Rv4qbDrGr7G0HaJxutpIegH9f25pAR05BOVntyA9wRtZ47pGyj8I6xNq9KXH
	 Tylmf1ZCQEy55mzcDuUPp8J9dJdreP3HUIa5ApExpuyrLo8FaY2WErBdy/aYxCFSM4
	 TDe7jXzpY56RHaKWoYBoP9Q92PBRwLS2pW2UvXK6TRpXiE61XVg2Osz8GCgN4/sZMy
	 lC9QnrAkrojB9dlxH6yXx+vpBc5boJV7mCHcF6psTFNKi3yl7MQUKlyzZyR87k6+Fx
	 nslmjD/aQNbg+fnCYmcqD0wW0sHfIN/S5BATZfLHdy14hNeu7eWecq4+WlYdzfUmUE
	 rN6Swz3En7C0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] f2fs: fix to handle error paths of {new,change}_curseg()
Date: Fri, 11 Sep 2026 18:00:24 -0400
Message-ID: <20260911220025.1624949-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911220025.1624949-1-sashal@kernel.org>
References: <2026090946-clumsily-stuck-0ea2@gregkh>
 <20260911220025.1624949-1-sashal@kernel.org>
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

For the 6.6 backport, retain reset_checkpoint at its existing location
so recovery-skipping paths still initialize the in-memory cursegs.
Check any outstanding recovery error before assigning the initializer's
return value; otherwise a successful initialization could mask that error.
Route initialization failures through the existing sync_free_meta cleanup.

Keep the resize allocation error propagation and loop structure needed by
8ec06f50ddd8 ("f2fs: fix to migrate all curseg types during
free_segment_range"). No functions are added.

Stable-dep-of: 8ec06f50ddd8 ("f2fs: fix to migrate all curseg types during free_segment_range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h    |  4 ++--
 fs/f2fs/gc.c      |  7 ++++--
 fs/f2fs/segment.c | 57 +++++++++++++++++++++++++++++------------------
 fs/f2fs/super.c   |  6 ++++-
 4 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 629b1e5d2f6ca..298332e26d031 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3734,10 +3734,10 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
 void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
 int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
 bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
-void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
+int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
 int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ec68bc87ef008..115b6d6c6bc7a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2103,8 +2103,11 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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
 	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 66eeb1c6a349b..da6ea02b6f796 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2874,7 +2874,7 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
  * This function always allocates a used segment(from dirty seglist) by SSR
  * manner, so it should recover the existing segment information of valid blocks
  */
-static void change_curseg(struct f2fs_sb_info *sbi, int type)
+static int change_curseg(struct f2fs_sb_info *sbi, int type)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2900,21 +2900,23 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
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
 				int alloc_mode, unsigned long long age);
 
-static void get_atssr_segment(struct f2fs_sb_info *sbi, int type,
+static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
 					int target_type, int alloc_mode,
 					unsigned long long age)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	int ret = 0;
 
 	curseg->seg_type = target_type;
 
@@ -2922,38 +2924,41 @@ static void get_atssr_segment(struct f2fs_sb_info *sbi, int type,
 		struct seg_entry *se = get_seg_entry(sbi, curseg->next_segno);
 
 		curseg->seg_type = se->type;
-		change_curseg(sbi, type);
+		ret = change_curseg(sbi, type);
 	} else {
 		/* allocate cold segment by default */
 		curseg->seg_type = CURSEG_COLD_DATA;
-		new_curseg(sbi, type, true);
+		ret = new_curseg(sbi, type, true);
 	}
 	stat_inc_seg_type(sbi, curseg);
+	return ret;
 }
 
-static void __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
+static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
+	int ret = 0;
 
 	if (!sbi->am.atgc_enabled)
-		return;
+		return 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 
 	mutex_lock(&curseg->curseg_mutex);
 	down_write(&SIT_I(sbi)->sentry_lock);
 
-	get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC, CURSEG_COLD_DATA, SSR, 0);
+	ret = get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC,
+					CURSEG_COLD_DATA, SSR, 0);
 
 	up_write(&SIT_I(sbi)->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
 
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
-
+	return ret;
 }
-void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
+int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
 {
-	__f2fs_init_atgc_curseg(sbi);
+	return __f2fs_init_atgc_curseg(sbi);
 }
 
 static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
@@ -3081,11 +3086,12 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
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
@@ -3096,9 +3102,9 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 		goto unlock;
 
 	if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type, SSR, 0))
-		change_curseg(sbi, type);
+		ret = change_curseg(sbi, type);
 	else
-		new_curseg(sbi, type, true);
+		ret = new_curseg(sbi, type, true);
 
 	stat_inc_seg_type(sbi, curseg);
 
@@ -3112,6 +3118,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+	return ret;
 }
 
 static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
@@ -3483,14 +3490,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	bool from_gc = (type == CURSEG_ALL_DATA_ATGC);
 	struct seg_entry *se = NULL;
 	bool segment_full = false;
+	int ret = 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 
 	mutex_lock(&curseg->curseg_mutex);
 	down_write(&sit_i->sentry_lock);
 
-	if (curseg->segno == NULL_SEGNO)
+	if (curseg->segno == NULL_SEGNO) {
+		ret = -ENOSPC;
 		goto out_err;
+	}
 
 	if (from_gc) {
 		f2fs_bug_on(sbi, GET_SEGNO(sbi, old_blkaddr) == NULL_SEGNO);
@@ -3544,17 +3554,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		}
 
 		if (from_gc) {
-			get_atssr_segment(sbi, type, se->type,
+			ret = get_atssr_segment(sbi, type, se->type,
 						AT_SSR, se->mtime);
 		} else {
 			if (need_new_seg(sbi, type))
-				new_curseg(sbi, type, false);
+				ret = new_curseg(sbi, type, false);
 			else
-				change_curseg(sbi, type);
+				ret = change_curseg(sbi, type);
 			stat_inc_seg_type(sbi, curseg);
 		}
 
-		if (curseg->segno == NULL_SEGNO)
+		if (ret)
 			goto out_err;
 	}
 
@@ -3602,7 +3612,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	up_write(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
-	return -ENOSPC;
+	return ret;
 
 }
 
@@ -3831,7 +3841,8 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	/* change the current segment */
 	if (segno != curseg->segno) {
 		curseg->next_segno = segno;
-		change_curseg(sbi, type);
+		if (change_curseg(sbi, type))
+			goto out_unlock;
 	}
 
 	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
@@ -3857,12 +3868,14 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	if (recover_curseg) {
 		if (old_cursegno != curseg->segno) {
 			curseg->next_segno = old_cursegno;
-			change_curseg(sbi, type);
+			if (change_curseg(sbi, type))
+				goto out_unlock;
 		}
 		curseg->next_blkoff = old_blkoff;
 		curseg->alloc_type = old_alloc_type;
 	}
 
+out_unlock:
 	up_write(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_write(&SM_I(sbi)->curseg_lock);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 95adc2c4c3c08..3d7e987bf5f1a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4729,7 +4729,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 reset_checkpoint:
-	f2fs_init_inmem_curseg(sbi);
+	if (err)
+		goto free_meta;
+	err = f2fs_init_inmem_curseg(sbi);
+	if (err)
+		goto sync_free_meta;
 
 	/* f2fs_recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
-- 
2.53.0

