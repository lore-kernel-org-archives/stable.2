Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361602;
	b=T1Rr9Ds2u7qAIwDeGXMCcmWM1PFx7kcMoi6WU/qcnSPRu3VPlcy/8QCvcDJvQIGYF6lZ
	 eBCIzqdUqwi4qy6xYDa3a0F8yPzmRJcVmdjfKnRXwjPdwTUegrZzXidWJ1l9bZjxh6OHf
	 OXtI5cKj2+E3kudqCBSsFii0tqIqObXSISyYGg4b3XEGzBFDBgmDpri6T0LApMVxbItpy
	 u/xzKHMwk5WRM37+BPC6fn4o5yCfl3e/ZQLruJahlpdRcHGuGPQ1qDGTIei37lBM8YjiL
	 YZ8gnc2XmrwA/Q8i3ktmf75E20tnaMeoj134webJPy7azHrn1lwvglRQxDIb3HVAkgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UGJXQA4o8cMC0lmeshvw+28fy6V4fRp4Tmu/ypbmmcQ=;
	b=0EqEXyLqqctVt5XoSkA8RWbZosW134jV+M30X6JnN7SWLeX+rZBZ1rMxYDx1D2hatwBU
	 MWoWf+1a4lmC/vuEqJVPYZgY61bqxbSHDlhYiY3NyxmfI33KzzBt+YdRpqob/3oM0ZAIB
	 g7TK+MsH5GbhJ1avtxy6ki8vPeSYxFBe+m/eRgxqrvpkmTvW4EA0glSyUxLcVSALefnWQ
	 D8nP1jMVhSH782ifv+s3OvkxvuDyxs5hVBycRz8m9h1GV47LhwUlQVm70vSfYzc1Jk0hF
	 squ4WQzf00RkY5MCjWhpxpgCIeTMqCx0hyc4DC775htPTJgQBP6P5xeVC34dGWVa8Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IZy/mdj9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F21606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZy/mdj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E961F0089F;
	Wed, 11 Nov 2026 01:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361602;
	bh=UGJXQA4o8cMC0lmeshvw+28fy6V4fRp4Tmu/ypbmmcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IZy/mdj9gU/SWDLJ54vZ6dIITxlxK4TK1Admp6MDIb5WLTX2DDeZHWO2CjJOSBTyj
	 e8bAR1kFBPIiTGx+3SPpwWeTKQJvOYc80/6NT91T+dtD1CQrREAmx+LlaG39RWcjh0
	 QS4nPUi/vBRX4y+HCngest68Lkx6lQ3krIAeNzwbj8ZJ902OcjBAgQImN2E8gM3Fhv
	 aYwdXduJ4PtCwYUh8Viu7782xoGctXZErZKege0d7eVStqij8mNvvVg/7jqVdGOWvD
	 ecisksE1upOM39A+mEwSgMPMHulhQmQ0SkDlNoAT8SEr8EuC3/SZkb7FGVaEW59QhD
	 HnFzxfm4ufL+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm-writecache: fix REQ_FUA processing
Date: Tue, 10 Nov 2026 20:46:40 -0500
Message-ID: <20261111014526.402915-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060120-failed-5.15-c0df022cb0fa@kernel.org>
References: <20261107060120-failed-5.15-c0df022cb0fa@kernel.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit c0df022cb0fa2bbee74bd9b90c66790bcd4e3050 ]

REQ_FUA did not flush metadata in SSD mode, this commit fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: c1005322ff02 ("dm writecache: handle REQ_FUA")
Assisted-by: Claude:claude-opus-5
Assisted-by: Codex:gpt-6-sol
[ sashal: added a blank line after the bool fua declaration in writecache_end_io() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-writecache.c | 46 +++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index b0d827b84cdb5..7c1825de25f8d 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -198,6 +198,7 @@ struct dm_writecache {
 	struct task_struct *endio_thread;
 
 	struct task_struct *flush_thread;
+	spinlock_t flush_list_lock;
 	struct bio_list flush_list;
 
 	struct dm_kcopyd_client *dm_kcopyd;
@@ -1279,9 +1280,11 @@ static int writecache_flush_thread(void *data)
 		struct bio *bio;
 
 		wc_lock(wc);
+		spin_lock_irq(&wc->flush_list_lock);
 		bio = bio_list_pop(&wc->flush_list);
 		if (!bio) {
 			set_current_state(TASK_INTERRUPTIBLE);
+			spin_unlock_irq(&wc->flush_list_lock);
 			wc_unlock(wc);
 
 			if (unlikely(kthread_should_stop())) {
@@ -1292,6 +1295,7 @@ static int writecache_flush_thread(void *data)
 			schedule();
 			continue;
 		}
+		spin_unlock_irq(&wc->flush_list_lock);
 
 		if (bio_op(bio) == REQ_OP_DISCARD) {
 			writecache_discard(wc, bio->bi_iter.bi_sector,
@@ -1313,9 +1317,12 @@ static int writecache_flush_thread(void *data)
 
 static void writecache_offload_bio(struct dm_writecache *wc, struct bio *bio)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&wc->flush_list_lock, flags);
 	if (bio_list_empty(&wc->flush_list))
 		wake_up_process(wc->flush_thread);
 	bio_list_add(&wc->flush_list, bio);
+	spin_unlock_irqrestore(&wc->flush_list_lock, flags);
 }
 
 enum wc_map_op {
@@ -1425,6 +1432,8 @@ static void writecache_bio_copy_ssd(struct dm_writecache *wc, struct bio *bio,
 static enum wc_map_op writecache_map_write(struct dm_writecache *wc, struct bio *bio)
 {
 	struct wc_entry *e;
+	enum wc_map_op ret = WC_MAP_SUBMIT;
+	bool need_flush = false;
 
 	do {
 		bool found_entry = false;
@@ -1460,7 +1469,8 @@ static enum wc_map_op writecache_map_write(struct dm_writecache *wc, struct bio
 				writecache_map_remap_origin(wc, bio, e);
 				wc->stats.writes_around += bio->bi_iter.bi_size >> wc->block_size_bits;
 				wc->stats.writes += bio->bi_iter.bi_size >> wc->block_size_bits;
-				return WC_MAP_REMAP_ORIGIN;
+				ret = WC_MAP_REMAP_ORIGIN;
+				goto flush_pmem_and_ret;
 			}
 			wc->stats.writes_blocked_on_freelist++;
 			writecache_wait_on_freelist(wc);
@@ -1474,21 +1484,25 @@ static enum wc_map_op writecache_map_write(struct dm_writecache *wc, struct bio
 		if (WC_MODE_PMEM(wc)) {
 			bio_copy_block(wc, bio, memory_data(wc, e));
 			wc->stats.writes++;
+			need_flush = true;
 		} else {
 			writecache_bio_copy_ssd(wc, bio, e, search_used);
 			return WC_MAP_REMAP;
 		}
 	} while (bio->bi_iter.bi_size);
 
-	if (unlikely(bio->bi_opf & REQ_FUA || wc->uncommitted_blocks >= wc->autocommit_blocks)) {
-		writecache_flush(wc);
-		if (writecache_has_error(wc))
-			bio->bi_status = BLK_STS_IOERR;
-	} else {
-		writecache_schedule_autocommit(wc);
+flush_pmem_and_ret:
+	if (need_flush) {
+		if (unlikely(bio->bi_opf & REQ_FUA || wc->uncommitted_blocks >= wc->autocommit_blocks)) {
+			writecache_flush(wc);
+			if (writecache_has_error(wc))
+				ret = WC_MAP_ERROR;
+		} else {
+			writecache_schedule_autocommit(wc);
+		}
 	}
 
-	return WC_MAP_SUBMIT;
+	return ret;
 }
 
 static enum wc_map_op writecache_map_flush(struct dm_writecache *wc, struct bio *bio)
@@ -1578,7 +1592,10 @@ static int writecache_map(struct dm_target *ti, struct bio *bio)
 
 	case WC_MAP_REMAP:
 		/* make sure that writecache_end_io decrements bio_in_progress: */
-		bio->bi_private = (void *)1;
+		if (unlikely(bio->bi_opf & REQ_FUA) && bio_op(bio) == REQ_OP_WRITE)
+			bio->bi_private = (void *)3;
+		else
+			bio->bi_private = (void *)1;
 		atomic_inc(&wc->bio_in_progress[bio_data_dir(bio)]);
 		wc_unlock(wc);
 		return DM_MAPIO_REMAPPED;
@@ -1607,11 +1624,19 @@ static int writecache_end_io(struct dm_target *ti, struct bio *bio, blk_status_t
 {
 	struct dm_writecache *wc = ti->private;
 
-	if (bio->bi_private == (void *)1) {
+	if (bio->bi_private == (void *)1 || bio->bi_private == (void *)3) {
 		int dir = bio_data_dir(bio);
+		bool fua = bio->bi_private == (void *)3;
+
 		if (atomic_dec_and_test(&wc->bio_in_progress[dir]))
 			if (unlikely(waitqueue_active(&wc->bio_in_progress_wait[dir])))
 				wake_up(&wc->bio_in_progress_wait[dir]);
+
+		if (fua && likely(*status == BLK_STS_OK)) {
+			bio->bi_private = NULL;
+			writecache_offload_bio(wc, bio);
+			return DM_ENDIO_INCOMPLETE;
+		}
 	} else if (bio->bi_private == (void *)2) {
 		dm_iot_io_end(&wc->iot, 1);
 	}
@@ -2506,6 +2531,7 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 		wc->memory_map_size -= (uint64_t)wc->start_sector << SECTOR_SHIFT;
 
+		spin_lock_init(&wc->flush_list_lock);
 		bio_list_init(&wc->flush_list);
 		wc->flush_thread = kthread_create(writecache_flush_thread, wc, "dm_writecache_flush");
 		if (IS_ERR(wc->flush_thread)) {
-- 
2.53.0

