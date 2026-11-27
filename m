Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776985;
	b=wtwxMqBj2NOSOUQ8WozWzjBoKxQPnQfC/jpWipUtdXEQCsXbCDrJ60BzJ62fxclSH/dm
	 oC1XqTYaHGgXUHXjd5mzm+EbJqHQRGmJ7bhrlnqQgNBkapkUkkovXCHPFEgXUALKBq1HQ
	 yV6pYhzLmGp1lDzqdbrVaoRu7s4nWdT7e9/RLxWLKdG4KO4CE30sRUwvA6VeW4v5S4yne
	 s8X0pySpjUX8K70DS6yTXn/lrwzfHpnNbfUt5qUiJwDy75pJAfVsL2XVD1OCHMSvSzmbu
	 2pojCrIC+uRa72OP+SvPCJWLXgern7JzwNLPlKNIFX8iPDdLSeO02WIk4rJk1K0Z8eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776985;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i3dVGIDEFMQ4QWIPW3txAjldYA5a7I1PUoZWQj/99WU=;
	b=zsdiBJKY/AlN6KqrXGO/pzVq+IsbUcSdVNmYJ9y1HzIYnnNYGL5Y6XoptiwZdKYwtJGi
	 A0Rom3idG43qoCwFK+Gbr57kkxUg4hIotZ43jkRlwhE0r4PV/xlwrJzzyjZgvxZCcNoeC
	 oYTq3k96SgHLH2jJseuO84vjTwf09V+B+qvZTKjRakJ4EWrtMhGgiBVo24LR2oyzWvaAy
	 erHMAIY8qcSwpu3QcXqoXYt6zZyGejzi2/lHJ9mdsx4YWgDRAkJ/AazE1a7rkTZm5SMpR
	 iBb8ejlJDhfIfQVzPRpNn4wp/56Ksfne0wCG9719O5+svL7ZJ6XAIeoeapln+4k+q4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfXjBjhp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D939606A686;
	Fri, 27 Nov 2026 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfXjBjhp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014BE1F0092A;
	Fri, 27 Nov 2026 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776984;
	bh=i3dVGIDEFMQ4QWIPW3txAjldYA5a7I1PUoZWQj/99WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfXjBjhpeR8q51ETOb4XcZSEtB1pRbb4GhcGsLoSyJgCSLAdL3UjmzbIceMl1PX1R
	 b8Po9NFAdliuTgVHQ/SFclpG/B/rndbVrJYiaJQMMDIotUgUzmVPIAIjlQBAlDShYL
	 VeyORWUji39RD0WD436loU1WuFNj1aLjXQRWobT0Uo/Cq3eDGK0a6NviKLl+HEOSAw
	 pAPgnsWiKMv+vN+4XGxgYrc0gkKAuUD0Qnb+1Vr5/OOwnAXNFe2j3F4p1AcKrxTyMv
	 Lr46PN+kFL8VSSpYV/aY7vm7BcJtsc85gQ/AppalRS4I1iHRF5iV/zVAbC4V6WvKlW
	 tlAnOhOc7cA0A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 7/7] f2fs: cache: fix to initialize f2fs_writeback info at mount time
Date: Fri, 27 Nov 2026 10:56:14 +0000
Message-ID: <20261127105608.537148-14-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105608.537148-8-chao@kernel.org>
References: <20261127105608.537148-8-chao@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

f2fs_start_cache_wb_thread() initializes cache_wb_wq and f2fs_writeback
tunables every time f2fs_writeback thread is started, e.g. in remount,
which causes below race conditions:

1. cache_wb_interval, cache_wb_dirty_threshold and
   cache_wb_total_threshold configured via sysfs will be reset to
   default value after remount.

2. remount will reinitialize cache_wb_wq, which may be used by another
   thread, e.g. f2fs_wake_up_cache_wb(), concurrently.

Let's introduce f2fs_init_cache_wb_info() to initialize them only once
in f2fs_fill_super(), then f2fs_start_cache_wb_thread() only needs to
reset cache_wb_throttled, and READ_ONCE()/WRITE_ONCE() is enough for
cache_wb_task.

Cc: stable@vger.kernel.org
Fixes: f45afeabd5df ("f2fs: cache: introduce writeback thread")
Fixes: eeadc4807c95 ("f2fs: cache: wake up f2fs_writeback when exceeding threshold")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to the latest dev-test branch.

 fs/f2fs/cache.c | 23 ++++++++++++++---------
 fs/f2fs/cache.h |  1 +
 fs/f2fs/super.c |  1 +
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index ddf94b5791e7..6cac7662fc1a 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -844,8 +844,7 @@ void f2fs_wake_up_cache_wb(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
 
-	/* pairs with smp_store_release() in f2fs_start_cache_wb_thread() */
-	if (!smp_load_acquire(&cache_thread->cache_wb_task))
+	if (!READ_ONCE(cache_thread->cache_wb_task))
 		return;
 
 	if (!f2fs_should_wake_up_cache_wb(sbi))
@@ -855,6 +854,17 @@ void f2fs_wake_up_cache_wb(struct f2fs_sb_info *sbi)
 		wake_up(&cache_thread->cache_wb_wq);
 }
 
+void f2fs_init_cache_wb_info(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
+
+	init_waitqueue_head(&cache_thread->cache_wb_wq);
+	cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;
+	cache_thread->cache_wb_dirty_threshold = DEF_CACHE_WB_DIRTY_THRESH;
+	cache_thread->cache_wb_total_threshold = 0;
+	cache_thread->cache_wb_throttled = false;
+}
+
 int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
@@ -865,11 +875,7 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 	if (cache_thread->cache_wb_task)
 		return 0;
 
-	init_waitqueue_head(&cache_thread->cache_wb_wq);
-	cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;
-	cache_thread->cache_wb_dirty_threshold = DEF_CACHE_WB_DIRTY_THRESH;
-	cache_thread->cache_wb_total_threshold = 0;
-	cache_thread->cache_wb_throttled = false;
+	WRITE_ONCE(cache_thread->cache_wb_throttled, false);
 	snprintf(name, sizeof(name), "f2fs_writeback-%u:%u",
 			MAJOR(dev), MINOR(dev));
 
@@ -877,8 +883,7 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 
-	/* pairs with smp_load_acquire() in f2fs_wake_up_cache_wb() */
-	smp_store_release(&cache_thread->cache_wb_task, task);
+	WRITE_ONCE(cache_thread->cache_wb_task, task);
 	return 0;
 }
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 5408727dd321..cd017c1b188f 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -245,6 +245,7 @@ struct f2fs_cache_kthread {
 	bool cache_wb_throttled;	/* last round made no progress */
 };
 
+void f2fs_init_cache_wb_info(struct f2fs_sb_info *sbi);
 int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
 void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 void f2fs_wake_up_cache_wb(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 43ef7a4ac219..3fd8a18ac482 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5449,6 +5449,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	f2fs_init_cache(sbi, META_CACHE(sbi), F2FS_META_CACHE);
 	f2fs_init_cache(sbi, NODE_CACHE(sbi), F2FS_NODE_CACHE);
 	f2fs_init_cache(sbi, COMPRESS_CACHE(sbi), F2FS_COMPRESS_CACHE);
+	f2fs_init_cache_wb_info(sbi);
 
 	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
-- 
2.49.0

