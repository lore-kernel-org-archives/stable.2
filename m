Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E63F20E8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161335; cv=none; b=RoWIHIA8Cgvb281qYHwnPX3ewl7efS+ebg29b56EzNEuphWh2P53PjORBvoS2UOT4GVqz1gF5G7BcQ7Cags0FMhhEyumAvCYcgDZFvFffHz22oGO/D8lM96p2LoBjB7fmSF9JfQxmWpYkx4pPZ04PsR2OywZ55kS3EZfiJ7glIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161335; c=relaxed/simple;
	bh=nGrkyxINvu3gvbTSa0RdRBhLQ5NVvtkbxGRgjBOeMMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0e1AS8Xrw2tbnETIPRvtspykSi5KWKIWi51fGqE0TXPSG+nmJxIKDpVSZB+4TfHBXQlnd9DpKnxGI2D54ZjymuUjkg46iAZbPQhuVcwo3RXl7tdmCP0YG/kevXzkk+mgTSJn6+nsAjNgA08pkGu2pOwAg8XdL7QGA3N4ikXoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjyNKjqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjyNKjqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5D31F000FF;
	Fri, 11 Sep 2026 21:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161333;
	bh=cRNtgW4AF6us8+HoY5NaRAEpZqmEOpxjwLTxIy1FNf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QjyNKjqhWa55o3pWD6vY3l2Yw7ZmUnPSYagxSpyjJENUhaGdy7E+Ce3P71/uz+Nqg
	 LqnD45Mopxx/Jum9uxTD8HIjbyEefBiSOnpgBnrc0+UNxwEtmC6108Z/X0d3IdScD6
	 oqaxu8JTX3rO42rDIU97Noog1NFjSXRPY2WFAqcleRxuqn68CORAL6V581E95QGWji
	 Pc/dYyHyzuV5Hi0c8EUz9hZQINpf977DW2V30giGvB1yRCgx4NTGvqQjYkwd4640Cp
	 FeZ10AARj4b0QpEGcuu2L7mVspaKXGZrMvxE4bMoBhkQDlq5hWqPKH+H1+hYZ4q80U
	 j1KBUICSgDgfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] f2fs: embed f2fs_gc_kthread in f2fs_sb_info
Date: Fri, 11 Sep 2026 17:15:31 -0400
Message-ID: <20260911211531.1531527-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090903-sitting-sponge-7dd0@gregkh>
References: <2026090903-sitting-sponge-7dd0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 3d7bca9d583793bb7d0bac0d95a24ddd2e129eed ]

Instead of allocating f2fs_gc_kthread dynamically, embed it in
f2fs_sb_info. This simplifies lifetime management and prepares for
fixing race conditions during teardown.

- __sbi_store			- remount|shutdown
				 - f2fs_stop_gc_thread
 - access sbi->gc_thread
				  - sbi->gc_thread = NULL
 - access sbi->gc_thread->f2fs_gc_task

Fixes: 52190933c37a ("f2fs: sysfs: introduce critical_task_priority")
Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Omitted the GC access conversion in critical_task_priority because the target branch lacks that handler. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/debug.c   |  4 ----
 fs/f2fs/f2fs.h    | 29 ++++++++++++++++++++++++++++-
 fs/f2fs/gc.c      | 36 +++++++++++++++---------------------
 fs/f2fs/gc.h      | 27 +--------------------------
 fs/f2fs/segment.c |  9 ++++-----
 fs/f2fs/super.c   |  4 ++--
 fs/f2fs/sysfs.c   | 18 +++++++++---------
 7 files changed, 59 insertions(+), 68 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 43a83bbd3bc5a..0650af1305577 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -351,10 +351,6 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 get_cache:
 	si->cache_mem = 0;
 
-	/* build gc */
-	if (sbi->gc_thread)
-		si->cache_mem += sizeof(struct f2fs_gc_kthread);
-
 	/* build merge flush thread */
 	if (SM_I(sbi)->fcc_info)
 		si->cache_mem += sizeof(struct flush_cmd_control);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1d7a22293b37..b025a0d386e2b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1683,6 +1683,33 @@ struct decompress_io_ctx {
 #define MAX_COMPRESS_LOG_SIZE		8
 #define MAX_COMPRESS_WINDOW_SIZE(log_size)	((PAGE_SIZE) << (log_size))
 
+struct f2fs_gc_kthread {
+	struct task_struct *f2fs_gc_task;
+	wait_queue_head_t gc_wait_queue_head;
+
+	/* for gc sleep time */
+	unsigned int urgent_sleep_time;
+	unsigned int min_sleep_time;
+	unsigned int max_sleep_time;
+	unsigned int no_gc_sleep_time;
+
+	/* for changing gc mode */
+	bool gc_wake;
+
+	/* for GC_MERGE mount option */
+	wait_queue_head_t fggc_wq;		/*
+						 * caller of f2fs_balance_fs()
+						 * will wait on this wait queue.
+						 */
+
+	/* for gc control for zoned devices */
+	unsigned int no_zoned_gc_percent;
+	unsigned int boost_zoned_gc_percent;
+	unsigned int valid_thresh_ratio;
+	unsigned int boost_gc_multiple;
+	unsigned int boost_gc_greedy;
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1818,7 +1845,7 @@ struct f2fs_sb_info {
 						 * semaphore for GC, avoid
 						 * race between GC and GC or CP
 						 */
-	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
+	struct f2fs_gc_kthread gc_thread;	/* GC thread */
 	struct atgc_management am;		/* atgc management */
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 429fc5bd4ae0d..eaa9a1b6acdb6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -31,9 +31,9 @@ static unsigned int count_bits(const unsigned long *addr,
 static int gc_thread_func(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
-	wait_queue_head_t *wq = &sbi->gc_thread->gc_wait_queue_head;
-	wait_queue_head_t *fggc_wq = &sbi->gc_thread->fggc_wq;
+	struct f2fs_gc_kthread *gc_th = &sbi->gc_thread;
+	wait_queue_head_t *wq = &sbi->gc_thread.gc_wait_queue_head;
+	wait_queue_head_t *fggc_wq = &sbi->gc_thread.fggc_wq;
 	unsigned int wait_ms;
 	struct f2fs_gc_control gc_control = {
 		.victim_segno = NULL_SEGNO,
@@ -191,13 +191,9 @@ static int gc_thread_func(void *data)
 
 int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th;
+	struct f2fs_gc_kthread *gc_th = &sbi->gc_thread;
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 
-	gc_th = f2fs_kmalloc(sbi, sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
-	if (!gc_th)
-		return -ENOMEM;
-
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
 	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
 	gc_th->boost_gc_multiple = BOOST_GC_MULTIPLE;
@@ -219,16 +215,14 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 	gc_th->gc_wake = false;
 
-	sbi->gc_thread = gc_th;
-	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
-	init_waitqueue_head(&sbi->gc_thread->fggc_wq);
-	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
+	init_waitqueue_head(&gc_th->gc_wait_queue_head);
+	init_waitqueue_head(&gc_th->fggc_wq);
+	gc_th->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
 			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(gc_th->f2fs_gc_task)) {
 		int err = PTR_ERR(gc_th->f2fs_gc_task);
 
-		kfree(gc_th);
-		sbi->gc_thread = NULL;
+		gc_th->f2fs_gc_task = NULL;
 		return err;
 	}
 
@@ -237,14 +231,14 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th = &sbi->gc_thread;
 
-	if (!gc_th)
+	if (!gc_th->f2fs_gc_task)
 		return;
+
 	kthread_stop(gc_th->f2fs_gc_task);
+	gc_th->f2fs_gc_task = NULL;
 	wake_up_all(&gc_th->fggc_wq);
-	kfree(gc_th);
-	sbi->gc_thread = NULL;
 }
 
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
@@ -791,7 +785,7 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 	if (one_time) {
 		p.one_time_gc = one_time;
 		if (has_enough_free_secs(sbi, 0, NR_PERSISTENT_LOG))
-			valid_thresh_ratio = sbi->gc_thread->valid_thresh_ratio;
+			valid_thresh_ratio = sbi->gc_thread.valid_thresh_ratio;
 	}
 
 retry:
@@ -1793,9 +1787,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 			if (f2fs_sb_has_blkzoned(sbi) &&
 					!has_enough_free_blocks(sbi,
-					sbi->gc_thread->boost_zoned_gc_percent))
+					sbi->gc_thread.boost_zoned_gc_percent))
 				window_granularity *=
-					sbi->gc_thread->boost_gc_multiple;
+					sbi->gc_thread.boost_gc_multiple;
 
 			end_segno = start_segno + window_granularity;
 		}
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 24e8b1c27acc4..2568d8017bf01 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -45,32 +45,7 @@
 
 #define NR_GC_CHECKPOINT_SECS (3)	/* data/node/dentry sections */
 
-struct f2fs_gc_kthread {
-	struct task_struct *f2fs_gc_task;
-	wait_queue_head_t gc_wait_queue_head;
-
-	/* for gc sleep time */
-	unsigned int urgent_sleep_time;
-	unsigned int min_sleep_time;
-	unsigned int max_sleep_time;
-	unsigned int no_gc_sleep_time;
-
-	/* for changing gc mode */
-	bool gc_wake;
-
-	/* for GC_MERGE mount option */
-	wait_queue_head_t fggc_wq;		/*
-						 * caller of f2fs_balance_fs()
-						 * will wait on this wait queue.
-						 */
 
-	/* for gc control for zoned devices */
-	unsigned int no_zoned_gc_percent;
-	unsigned int boost_zoned_gc_percent;
-	unsigned int valid_thresh_ratio;
-	unsigned int boost_gc_multiple;
-	unsigned int boost_gc_greedy;
-};
 
 struct gc_inode_list {
 	struct list_head ilist;
@@ -197,6 +172,6 @@ static inline bool need_to_boost_gc(struct f2fs_sb_info *sbi)
 {
 	if (f2fs_sb_has_blkzoned(sbi))
 		return !has_enough_free_blocks(sbi,
-				sbi->gc_thread->boost_zoned_gc_percent);
+				sbi->gc_thread.boost_zoned_gc_percent);
 	return has_enough_invalid_blocks(sbi);
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5e2789cd96b5e..072d1d200b397 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -450,15 +450,14 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	f2fs_submit_merged_write(sbi, DATA);
 	f2fs_submit_all_merged_ipu_writes(sbi);
 
-	if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
-				sbi->gc_thread->f2fs_gc_task) {
+	if (test_opt(sbi, GC_MERGE) && sbi->gc_thread.f2fs_gc_task) {
 		DEFINE_WAIT(wait);
 
-		prepare_to_wait(&sbi->gc_thread->fggc_wq, &wait,
+		prepare_to_wait(&sbi->gc_thread.fggc_wq, &wait,
 					TASK_UNINTERRUPTIBLE);
-		wake_up(&sbi->gc_thread->gc_wait_queue_head);
+		wake_up(&sbi->gc_thread.gc_wait_queue_head);
 		io_schedule();
-		finish_wait(&sbi->gc_thread->fggc_wq, &wait);
+		finish_wait(&sbi->gc_thread.fggc_wq, &wait);
 	} else {
 		struct f2fs_gc_control gc_control = {
 			.victim_segno = NULL_SEGNO,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6f787cbeefd09..543a3879d1184 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2846,11 +2846,11 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	if ((flags & SB_RDONLY) ||
 			(F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF &&
 			!test_opt(sbi, GC_MERGE))) {
-		if (sbi->gc_thread) {
+		if (sbi->gc_thread.f2fs_gc_task) {
 			f2fs_stop_gc_thread(sbi);
 			need_restart_gc = true;
 		}
-	} else if (!sbi->gc_thread) {
+	} else if (!sbi->gc_thread.f2fs_gc_task) {
 		err = f2fs_start_gc_thread(sbi);
 		if (err)
 			goto restore_opts;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6071bb6f7b4ca..3f9643d34f568 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -74,7 +74,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 {
 	if (struct_type == GC_THREAD)
-		return (unsigned char *)sbi->gc_thread;
+		return (unsigned char *)&sbi->gc_thread;
 	else if (struct_type == SM_INFO)
 		return (unsigned char *)SM_I(sbi);
 	else if (struct_type == DCC_INFO)
@@ -648,20 +648,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			sbi->gc_mode = GC_NORMAL;
 		} else if (t == 1) {
 			sbi->gc_mode = GC_URGENT_HIGH;
-			if (sbi->gc_thread) {
-				sbi->gc_thread->gc_wake = true;
+			if (sbi->gc_thread.f2fs_gc_task) {
+				sbi->gc_thread.gc_wake = true;
 				wake_up_interruptible_all(
-					&sbi->gc_thread->gc_wait_queue_head);
+					&sbi->gc_thread.gc_wait_queue_head);
 				wake_up_discard_thread(sbi, true);
 			}
 		} else if (t == 2) {
 			sbi->gc_mode = GC_URGENT_LOW;
 		} else if (t == 3) {
 			sbi->gc_mode = GC_URGENT_MID;
-			if (sbi->gc_thread) {
-				sbi->gc_thread->gc_wake = true;
+			if (sbi->gc_thread.f2fs_gc_task) {
+				sbi->gc_thread.gc_wake = true;
 				wake_up_interruptible_all(
-					&sbi->gc_thread->gc_wait_queue_head);
+					&sbi->gc_thread.gc_wait_queue_head);
 			}
 		} else {
 			return -EINVAL;
@@ -918,14 +918,14 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
 		if (t < 1 || t > SEGS_PER_SEC(sbi))
 			return -EINVAL;
-		sbi->gc_thread->boost_gc_multiple = (unsigned int)t;
+		sbi->gc_thread.boost_gc_multiple = (unsigned int)t;
 		return count;
 	}
 
 	if (!strcmp(a->attr.name, "gc_boost_gc_greedy")) {
 		if (t > GC_GREEDY)
 			return -EINVAL;
-		sbi->gc_thread->boost_gc_greedy = (unsigned int)t;
+		sbi->gc_thread.boost_gc_greedy = (unsigned int)t;
 		return count;
 	}
 
-- 
2.53.0

