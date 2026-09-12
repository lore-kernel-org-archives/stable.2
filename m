Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958C4BEE20
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222850; cv=none; b=DSvzmIBBH6FyU8qi5QG/KLaZDq2VhUM0pE15H4dg9dsvNKOoHP1I+XGqu3ziuAW+c3RDySXJ3i/z7JjQdq9oGhr/c8/Tpng1lT7/yKwViLyG1jVXipEO1p2PnuOcFB3FVUa2oeGjy6CVKujSd/6GL5lEsfps1SOwH/jOvnPXQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222850; c=relaxed/simple;
	bh=O/Ty0kLM90XEdhh+W4abmf5WeMZevFfuhT8DpDkbCCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urx9cDrnFGi1XXSrSoLNEjoNrn5mGD/gYsqK4SPfxnotm3Jr5eXJ85fP8WrutW+nt/jwhr/Ju/k8i2PTBhY08rbceP8GJKZsAVZEWHHaD/Z0wdVCWY4ihFefmJTUemp7rDnjDSqk9IVIwHHLWdkt6fWcbFI/+63p/Srx9gGvOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSjOu1j3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSjOu1j3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366B11F000FF;
	Sat, 12 Sep 2026 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222848;
	bh=mC2OHIcVuyvQc9aCPB4eZ71wn+U4/POWj9M4RcsQ2Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nSjOu1j3frokwFhNoIfRNl14seLyPxY3E0FawCSuJ1M7Tyc5mzZhd6ttBNFT+l+N9
	 hPQAIoFL0oXcEFysIOmqc37yG/rF0jNcNbOWIwOsCtMsIlhizdSmlW27OCQ1nDOyP7
	 uP3vigp+en6QnZs0oGeXVkLa0UMSMCTuZnePxwGXKDrUpyKdGy0GPLAyJJifuFsmDH
	 eDKgZIEiTYksDsXcI9/zdXB3iKgzvJft3mQ6BXxElDslf0nwrcejTuJzyw41T+sb9I
	 d3K9Vw2cl8zNEHF4n5dbKQwbUSDui5or/4pbyaAk6VNFBTIy5MlzVAc1Pfq+JPtjF+
	 2jlOkK/j1HZtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: embed f2fs_gc_kthread in f2fs_sb_info
Date: Sat, 12 Sep 2026 10:20:46 -0400
Message-ID: <20260912142046.2911258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090904-humpback-deferred-9103@gregkh>
References: <2026090904-humpback-deferred-9103@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ adapted GC structure access changes to Linux 5.15’s existing fields and APIs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/debug.c   |  4 ----
 fs/f2fs/f2fs.h    | 22 +++++++++++++++++++++-
 fs/f2fs/gc.c      | 33 ++++++++++++---------------------
 fs/f2fs/gc.h      | 20 --------------------
 fs/f2fs/segment.c |  9 ++++-----
 fs/f2fs/super.c   |  4 ++--
 fs/f2fs/sysfs.c   |  8 ++++----
 7 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index cd21b4edeca1c..9298847d7549f 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -275,10 +275,6 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
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
index fe17f10257371..bd13a38ab57fe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1561,6 +1561,26 @@ struct decompress_io_ctx {
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
+	unsigned int gc_wake;
+
+	/* for GC_MERGE mount option */
+	wait_queue_head_t fggc_wq;		/*
+						 * caller of f2fs_balance_fs()
+						 * will wait on this wait queue.
+						 */
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1677,7 +1697,7 @@ struct f2fs_sb_info {
 						 * semaphore for GC, avoid
 						 * race between GC and GC or CP
 						 */
-	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
+	struct f2fs_gc_kthread gc_thread;	/* GC thread */
 	struct atgc_management am;		/* atgc management */
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 69a51fcfbead4..663835527298f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -30,9 +30,9 @@ static unsigned int count_bits(const unsigned long *addr,
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
 
 	wait_ms = gc_th->min_sleep_time;
@@ -146,16 +146,10 @@ static int gc_thread_func(void *data)
 
 int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th;
+	struct f2fs_gc_kthread *gc_th = &sbi->gc_thread;
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	int err = 0;
 
-	gc_th = f2fs_kmalloc(sbi, sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
-	if (!gc_th) {
-		err = -ENOMEM;
-		goto out;
-	}
-
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
 	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
 	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
@@ -163,30 +157,27 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 	gc_th->gc_wake = 0;
 
-	sbi->gc_thread = gc_th;
-	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
-	init_waitqueue_head(&sbi->gc_thread->fggc_wq);
-	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
+	init_waitqueue_head(&gc_th->gc_wait_queue_head);
+	init_waitqueue_head(&gc_th->fggc_wq);
+	gc_th->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
 			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(gc_th->f2fs_gc_task)) {
 		err = PTR_ERR(gc_th->f2fs_gc_task);
-		kfree(gc_th);
-		sbi->gc_thread = NULL;
+		gc_th->f2fs_gc_task = NULL;
 	}
-out:
 	return err;
 }
 
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
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 3fe145e8e594f..f29c3ca07d70c 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -30,26 +30,6 @@
 /* Search max. number of dirty segments to select a victim segment */
 #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
 
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
-	unsigned int gc_wake;
-
-	/* for GC_MERGE mount option */
-	wait_queue_head_t fggc_wq;		/*
-						 * caller of f2fs_balance_fs()
-						 * will wait on this wait queue.
-						 */
-};
-
 struct gc_inode_list {
 	struct list_head ilist;
 	struct radix_tree_root iroot;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6c47cebbd0f11..0d10bea639372 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -522,15 +522,14 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 		f2fs_submit_merged_write(sbi, DATA);
 		f2fs_submit_all_merged_ipu_writes(sbi);
 
-		if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
-					sbi->gc_thread->f2fs_gc_task) {
+		if (test_opt(sbi, GC_MERGE) && sbi->gc_thread.f2fs_gc_task) {
 			DEFINE_WAIT(wait);
 
-			prepare_to_wait(&sbi->gc_thread->fggc_wq, &wait,
+			prepare_to_wait(&sbi->gc_thread.fggc_wq, &wait,
 						TASK_UNINTERRUPTIBLE);
-			wake_up(&sbi->gc_thread->gc_wait_queue_head);
+			wake_up(&sbi->gc_thread.gc_wait_queue_head);
 			io_schedule();
-			finish_wait(&sbi->gc_thread->fggc_wq, &wait);
+			finish_wait(&sbi->gc_thread.fggc_wq, &wait);
 		} else {
 			down_write(&sbi->gc_lock);
 			f2fs_gc(sbi, false, false, false, NULL_SEGNO);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 757f0bd843dde..a40dc08b3a1e8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2349,11 +2349,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if ((*flags & SB_RDONLY) ||
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
index cb13d47725432..70bdc2a6a5a24 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -58,7 +58,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 {
 	if (struct_type == GC_THREAD)
-		return (unsigned char *)sbi->gc_thread;
+		return (unsigned char *)&sbi->gc_thread;
 	else if (struct_type == SM_INFO)
 		return (unsigned char *)SM_I(sbi);
 	else if (struct_type == DCC_INFO)
@@ -499,10 +499,10 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			sbi->gc_mode = GC_NORMAL;
 		} else if (t == 1) {
 			sbi->gc_mode = GC_URGENT_HIGH;
-			if (sbi->gc_thread) {
-				sbi->gc_thread->gc_wake = 1;
+			if (sbi->gc_thread.f2fs_gc_task) {
+				sbi->gc_thread.gc_wake = 1;
 				wake_up_interruptible_all(
-					&sbi->gc_thread->gc_wait_queue_head);
+					&sbi->gc_thread.gc_wait_queue_head);
 				wake_up_discard_thread(sbi, true);
 			}
 		} else if (t == 2) {
-- 
2.53.0

