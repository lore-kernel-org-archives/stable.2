Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721773A7F5F
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783170070; cv=none; b=WiNV2fMPEf34KpcJ5EDP8QZCTPPdBGfm4ehnwoFmnnLB8IcgfBK9qQLSRxM2We1y71xT8iRBZ3LNyxSWwMlgz6IZA/NfMmWVeFhEH2qG88PMV0JVQh9aPEu291oa7nO+VGlYy60j0jtR1LESQjSdSOeQM2CzdLT3mlMeBHXIMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783170070; c=relaxed/simple;
	bh=O4axFH1tAfuxDOU+gtLB6WNRQCzLWQQg3sUJJwXHhyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBdKmlI0wYjKTiF5RIMHav6Xkv1SL+aVdpIChd5nGf1PhQY8q5GdmU8nSiNW6E2DHJ3leazDuCmOo+YC/LVWCa40ZI4w1EDfKPoAa1ikJFHjsD94NbBowBbEFxrbrIob3Kg+qCz+yZEzcKHT63ZRLF1LpSvtjk+rrowDZ4tcOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiTPTvGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiTPTvGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0771F00A3A;
	Sat,  4 Jul 2026 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783170069;
	bh=URrQQPDouhMMmGbmSVaP5nHj2QN+H0gPjhA0U4TLbV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YiTPTvGvHQeuDdqvY3+y1k0HlMm4u58awBOok7OhODP6yNn7s651InY+9v79DzdN9
	 Gx91JyX639PM4XeJlN71vST/+Upi2r18K0UN3El7WVLUXqhIiEsYSyr1PWPezUvgfi
	 9IMlDVvuqJEFcDViBroGzVUoQu2cAfa1UtCDKWkYqFpoGvpRbXq5r+KaELq15WJ7F3
	 GF63pRN7XP9zuBAfxmqKGa7oynPdKQuC331pnYPr5BS2/0xX8uuum5I0UB2nasBLaQ
	 ZPHBOp5VVjanFEr7aKBCVgvJkmY020k7hc/fIdA4e+XGsHSa6T1xlOPBYH1GpBlF6n
	 feaWYMdOaKd9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] f2fs: introduce f2fs_schedule_timeout()
Date: Sat,  4 Jul 2026 09:01:03 -0400
Message-ID: <20260704130106.828918-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260704130106.828918-1-sashal@kernel.org>
References: <2026070234-outdated-refutable-f834@gregkh>
 <20260704130106.828918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 76e780d88c771921ea643fb8a6c8d0b08c17cb7b ]

In f2fs retry logic, we will call f2fs_io_schedule_timeout() to sleep as
uninterruptible state (waiting for IO) for a while, however, in several
paths below, we are not blocked by IO:
- f2fs_write_single_data_page() return -EAGAIN due to racing on cp_rwsem.
- f2fs_flush_device_cache() failed to submit preflush command.
- __issue_discard_cmd_range() sleeps periodically in between two in batch
discard submissions.

So, in order to reveal state of task more accurate, let's introduce
f2fs_schedule_timeout() and call it in above paths in where we are waiting
for non-IO reasons.

Then we can get real reason of uninterruptible sleep for a thread in
tracepoint, perfetto, etc.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8712353ed80f ("f2fs: fix to do sanity check on f2fs_get_node_folio_ra()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/compress.c   |  4 ++--
 fs/f2fs/data.c       |  4 ++--
 fs/f2fs/f2fs.h       | 22 +++++++++++++++-------
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/super.c      |  2 +-
 6 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bbe07e3a6c75ac..4c401b5b29336b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1318,7 +1318,7 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 			f2fs_submit_merged_write(sbi, DATA);
 
 		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
-		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+		io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 	}
 	finish_wait(&sbi->cp_wait, &wait);
 }
@@ -1974,7 +1974,7 @@ void f2fs_flush_ckpt_thread(struct f2fs_sb_info *sbi)
 
 	/* Let's wait for the previous dispatched checkpoint. */
 	while (atomic_read(&cprc->queued_ckpt))
-		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+		io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 }
 
 void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ae36bb1f93519d..0399db98fccfc3 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1057,7 +1057,7 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
 		f2fs_submit_merged_write(F2FS_I_SB(cc->inode), DATA);
 		while (atomic_read(&cic->pending_pages) !=
 					(cc->valid_nr_cpages - submitted + 1))
-			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+			f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 	}
 
 	/* Cancel writeback and stay locked. */
@@ -1582,7 +1582,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				 */
 				if (IS_NOQUOTA(cc->inode))
 					goto out;
-				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+				f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 				goto retry_write;
 			}
 			goto out;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f468cba89f303b..1408c5bce358f6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3185,8 +3185,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				} else if (ret == -EAGAIN) {
 					ret = 0;
 					if (wbc->sync_mode == WB_SYNC_ALL) {
-						f2fs_io_schedule_timeout(
-							DEFAULT_IO_TIMEOUT);
+						f2fs_schedule_timeout(
+							DEFAULT_SCHEDULE_TIMEOUT);
 						goto retry_write;
 					}
 					goto next;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a77858bd38779f..ef1a3861b0bf5c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -665,8 +665,8 @@ enum {
 
 #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
 
-/* congestion wait timeout value, default: 20ms */
-#define	DEFAULT_IO_TIMEOUT	(msecs_to_jiffies(20))
+/* IO/non-IO congestion wait timeout value, default: 20ms */
+#define	DEFAULT_SCHEDULE_TIMEOUT	(msecs_to_jiffies(20))
 
 /* timeout value injected, default: 1000ms */
 #define DEFAULT_FAULT_TIMEOUT	(msecs_to_jiffies(1000))
@@ -4939,22 +4939,30 @@ static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
 }
 
-static inline void f2fs_io_schedule_timeout(long timeout)
+static inline void __f2fs_schedule_timeout(long timeout, bool io)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	io_schedule_timeout(timeout);
+	if (io)
+		io_schedule_timeout(timeout);
+	else
+		schedule_timeout(timeout);
 }
 
+#define f2fs_io_schedule_timeout(timeout)		\
+			__f2fs_schedule_timeout(timeout, true)
+#define f2fs_schedule_timeout(timeout)			\
+			__f2fs_schedule_timeout(timeout, false)
+
 static inline void f2fs_io_schedule_timeout_killable(long timeout)
 {
 	while (timeout) {
 		if (fatal_signal_pending(current))
 			return;
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
-		if (timeout <= DEFAULT_IO_TIMEOUT)
+		io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
+		if (timeout <= DEFAULT_SCHEDULE_TIMEOUT)
 			return;
-		timeout -= DEFAULT_IO_TIMEOUT;
+		timeout -= DEFAULT_SCHEDULE_TIMEOUT;
 	}
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4739decfc88863..3a3e751ec9f766 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -750,7 +750,7 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 		do {
 			ret = __submit_flush_wait(sbi, FDEV(i).bdev);
 			if (ret)
-				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+				f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 		} while (ret && --count);
 
 		if (ret) {
@@ -3472,7 +3472,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
 			trimmed += __wait_all_discard_cmd(sbi, NULL);
-			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+			f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 			goto next;
 		}
 skip:
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fc4a2e915ca09a..f6b75ce11d1c1a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2656,7 +2656,7 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	/* we should flush all the data to keep data consistency */
 	while (get_pages(sbi, F2FS_DIRTY_DATA)) {
 		writeback_inodes_sb_nr(sbi->sb, nr_pages, WB_REASON_SYNC);
-		f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 
 		if (f2fs_time_over(sbi, ENABLE_TIME))
 			break;
-- 
2.53.0

