Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620EC4BEE32
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211801; cv=none; b=UukLaUUB+Z+bEUtldzafsTv3I9ts33ANyuoyRFqZB8paVsqGwgg/PKFTSkZNrOORMP6joQVSPKQnrPbVwYvXKxIZgoSLfQvdyA+N5Qk4d9hQaPQAqkcOao96h1ra2HP0qzbRlFZsbSwvhpEoTdss6v/2oOa3qrqvEBdmyH9UOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211801; c=relaxed/simple;
	bh=FeFYya/5z+IL8OVATUxWL7wVzhxDOHMRTvac+AMPHUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+VwnYehPMoUoy/dnPMMjLtF2KBP1b5u9FXIOMOGuWHJNk7E7GDe/sratgc0QhQNpoCp3p0tAj8n9Htv+D7vm28G1Rg5w58uB4PI92aKR0JDc7HLpjCu7E5IxSZ77J3YCktA4eDzQ4b/vlgq5gtkSf4ay5I/E8zJDlaSbvBTqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q07uS1yF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q07uS1yF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977241F00893;
	Sat, 12 Sep 2026 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211800;
	bh=XvlwApDobQ5osvDnCvmTSnibidRWIW+qBWI4xjV+OvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q07uS1yFBV5XUKga9I+eni3tQiX2ldpnEMslZYnm3MGGmVtTaNrKtTdUcBKHX/sBZ
	 +zN/nLIjIymiLOBZsvsUO4EJC+EwSxTs2tJ877aDM8CvSm0MKM8QR+5y40HOQeck3n
	 Otn2wpdt9WLUlbxvMfj1joHjpW/tCVdVtH4a7CBlciXxBoXgJRRGTGg0xdzwVcRMJJ
	 7gY5KmYzZbCV0ZLhY8Pn8aCo3uICZd6HaZH1TN9gfC+S7/o525pgeTytIdUQ9ZgY05
	 sCIXe5XVHZJmHrUJCzuYoDgYm0uVIdiT3JAwfbxYpi0E8e303Ssl7oBibJyQjM2n4/
	 lvCMSw1MhLfjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: embed f2fs_gc_kthread in f2fs_sb_info
Date: Sat, 12 Sep 2026 07:16:38 -0400
Message-ID: <20260912111638.2266450-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090904-edging-unleash-26d5@gregkh>
References: <2026090904-edging-unleash-26d5@gregkh>
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
[ adapted to the 6.1 GC-thread structure without newer zoned-GC fields. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/debug.c   |  4 ----
 fs/f2fs/f2fs.h    | 22 +++++++++++++++++++++-
 fs/f2fs/gc.c      | 33 ++++++++++++---------------------
 fs/f2fs/gc.h      | 20 --------------------
 fs/f2fs/segment.c |  9 ++++-----
 fs/f2fs/super.c   |  4 ++--
 fs/f2fs/sysfs.c   | 14 +++++++-------
 7 files changed, 46 insertions(+), 60 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index dd6e8a10193b4..711b4262a0c75 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -280,10 +280,6 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
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
index cbf4032b5b7ee..3b1d99d03ab1b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1599,6 +1599,26 @@ struct decompress_io_ctx {
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
@@ -1715,7 +1735,7 @@ struct f2fs_sb_info {
 						 * semaphore for GC, avoid
 						 * race between GC and GC or CP
 						 */
-	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
+	struct f2fs_gc_kthread gc_thread;	/* GC thread */
 	struct atgc_management am;		/* atgc management */
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 687b2ce82c854..0254e3116e552 100644
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
@@ -169,16 +169,10 @@ static int gc_thread_func(void *data)
 
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
@@ -186,30 +180,27 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
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
index 47357101b03cd..0ff8138f0174f 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -32,26 +32,6 @@
 
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
index d185b209f89a5..db126347ca057 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -415,15 +415,14 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
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
 			struct f2fs_gc_control gc_control = {
 				.victim_segno = NULL_SEGNO,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9d1b5699f5bf1..dc06771fb1e9e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2393,11 +2393,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
index 503a50542ac53..b0607fdd5ad40 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -68,7 +68,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 {
 	if (struct_type == GC_THREAD)
-		return (unsigned char *)sbi->gc_thread;
+		return (unsigned char *)&sbi->gc_thread;
 	else if (struct_type == SM_INFO)
 		return (unsigned char *)SM_I(sbi);
 	else if (struct_type == DCC_INFO)
@@ -543,20 +543,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
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
 			sbi->gc_mode = GC_URGENT_LOW;
 		} else if (t == 3) {
 			sbi->gc_mode = GC_URGENT_MID;
-			if (sbi->gc_thread) {
-				sbi->gc_thread->gc_wake = 1;
+			if (sbi->gc_thread.f2fs_gc_task) {
+				sbi->gc_thread.gc_wake = 1;
 				wake_up_interruptible_all(
-					&sbi->gc_thread->gc_wait_queue_head);
+					&sbi->gc_thread.gc_wait_queue_head);
 			}
 		} else {
 			return -EINVAL;
-- 
2.53.0

