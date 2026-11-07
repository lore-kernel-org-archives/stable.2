Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050290;
	b=RmUGwJdBD3Wl/rHQkOlwH91zy3Uf4LbvaqrYDX+PB6c86IGOjbB2PWsy5I9tlOWSka6/
	 pzUswFIv9BbSKwK4JEWN6S61fN7WXNHJk+VG3Ng9a+T114H6qHAcnx9akzX2TplSyKpm1
	 yvNnBE8KotLgAbI4JXTmdRhEuT6upo5NQVIf+52QLWK/y6CACQl/FiTNRzTf5MAeIlytZ
	 xjYRezYw/LaLJKX/51Key2JO5KdpYUd3eAqxR+WTZNexia2pYtw/RSQYJLnlt5cJXak6I
	 ARS7WNEp4KSKsDZmVvxsZdf5UNi/Ay+L2zbqzK2Xc6cC327NnASYSCgqwtRBdKTTVpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050290;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=h5oIqI/fC/urPX9irVGo4VlPS8bCqGNH9wvHmH3hCgg=;
	b=NSgSSKQoa/m/kUJ/Escc7W97rZd+OIg4k3YajBMaU+Nsz96cT55ZG+Bv018mJsoLqYkv
	 8blOiH7MfpPXwuGcQCYh6gKEsmb2iTfoIszJt9RiOa/RlUs7mBX4oeuWhPqInLz5pinVv
	 9T4BdYdOqyPfeaYOwhjUyfv4fx99ubJi2drPteUJkkZeii+gOhPE0soj07A/vpxVvjovg
	 MSjZt4SR8QjyWDXNf38uD3dyp/tVn+mcnZShb9JTe8ATf4uley6yBs9EyQQWZDwaiS+W/
	 hw0gdISeJhScpuMPvVokyOEuD7n5OY/LdutB2h9+OHtEo3w8+o9Y2pFf0ruqiQ6138g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNxdn3gJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77725606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNxdn3gJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093981F0089F;
	Sat,  7 Nov 2026 11:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050290;
	bh=h5oIqI/fC/urPX9irVGo4VlPS8bCqGNH9wvHmH3hCgg=;
	h=From:To:Cc:Subject:Date;
	b=HNxdn3gJl1GoPTDG8bUSVsNkt56j49OcoLJks+OO2Eg9XE6tQMXpBL5zTZaQ+Qp6m
	 AxD44VkaBEdz1eAFlwWnU/A7TXdnL/YEaRWoYknZO8X5kiaIgXd4+3VjWqWdhMel5q
	 ZPZ2k/QIHNVDA5dp+pvxdzMDo+MEtW/PC774Bv6sgKsBM01c8LCc2LTSxg1rutyz1q
	 YePgFfgzdFCWgkmGH4QtYcJM0wSGtePDcVeQzzY2fY2vZWtg81X+SwRqQ2VyTJ1Nne
	 HZJ82h+1xyjDVaVs10sCYsFpekFUb7GTid7tJSyUm5BU0bndKOCUcRNTcv/9bRCj79
	 xsqLZUUovADCw==
From: Sasha Levin <sashal@kernel.org>
To: mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm-writecache: fix REQ_FUA processing" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:08 -0500
Message-ID: <20261107061808-failed-5.10-c0df022cb0fa@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c0df022cb0fa2bbee74bd9b90c66790bcd4e3050
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061808-failed-5.10-c0df022cb0fa@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c0df022cb0fa2bbee74bd9b90c66790bcd4e3050 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 30 Sep 2026 21:43:26 +0200
Subject: [PATCH] dm-writecache: fix REQ_FUA processing

REQ_FUA did not flush metadata in SSD mode, this commit fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: c1005322ff02 ("dm writecache: handle REQ_FUA")
Assisted-by: Claude:claude-opus-5
Assisted-by: Codex:gpt-6-sol
---
 drivers/md/dm-writecache.c | 45 +++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index a38780a7b1be9..6f977fb8c9397 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -188,6 +188,7 @@ struct dm_writecache {
 	struct task_struct *endio_thread;
 
 	struct task_struct *flush_thread;
+	spinlock_t flush_list_lock;
 	struct bio_list flush_list;
 
 	struct dm_kcopyd_client *dm_kcopyd;
@@ -1289,9 +1290,11 @@ static int writecache_flush_thread(void *data)
 		struct bio *bio;
 
 		wc_lock(wc);
+		spin_lock_irq(&wc->flush_list_lock);
 		bio = bio_list_pop(&wc->flush_list);
 		if (!bio) {
 			set_current_state(TASK_INTERRUPTIBLE);
+			spin_unlock_irq(&wc->flush_list_lock);
 			wc_unlock(wc);
 
 			if (unlikely(kthread_should_stop())) {
@@ -1302,6 +1305,7 @@ static int writecache_flush_thread(void *data)
 			schedule();
 			continue;
 		}
+		spin_unlock_irq(&wc->flush_list_lock);
 
 		if (bio_op(bio) == REQ_OP_DISCARD) {
 			writecache_discard(wc, bio->bi_iter.bi_sector,
@@ -1323,9 +1327,12 @@ static int writecache_flush_thread(void *data)
 
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
@@ -1437,6 +1444,8 @@ static void writecache_bio_copy_ssd(struct dm_writecache *wc, struct bio *bio,
 static enum wc_map_op writecache_map_write(struct dm_writecache *wc, struct bio *bio)
 {
 	struct wc_entry *e;
+	enum wc_map_op ret = WC_MAP_SUBMIT;
+	bool need_flush = false;
 
 	do {
 		bool found_entry = false;
@@ -1473,7 +1482,8 @@ static enum wc_map_op writecache_map_write(struct dm_writecache *wc, struct bio
 				writecache_map_remap_origin(wc, bio, e);
 				wc->stats.writes_around += bio->bi_iter.bi_size >> wc->block_size_bits;
 				wc->stats.writes += bio->bi_iter.bi_size >> wc->block_size_bits;
-				return WC_MAP_REMAP_ORIGIN;
+				ret = WC_MAP_REMAP_ORIGIN;
+				goto flush_pmem_and_ret;
 			}
 			wc->stats.writes_blocked_on_freelist++;
 			writecache_wait_on_freelist(wc);
@@ -1487,21 +1497,25 @@ static enum wc_map_op writecache_map_write(struct dm_writecache *wc, struct bio
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
@@ -1591,7 +1605,10 @@ static int writecache_map(struct dm_target *ti, struct bio *bio)
 
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
@@ -1621,12 +1638,19 @@ static int writecache_end_io(struct dm_target *ti, struct bio *bio, blk_status_t
 {
 	struct dm_writecache *wc = ti->private;
 
-	if (bio->bi_private == (void *)1) {
+	if (bio->bi_private == (void *)1 || bio->bi_private == (void *)3) {
 		int dir = bio_data_dir(bio);
+		bool fua = bio->bi_private == (void *)3;
 
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
@@ -2519,6 +2543,7 @@ static int writecache_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 		wc->memory_map_size -= (uint64_t)wc->start_sector << SECTOR_SHIFT;
 
+		spin_lock_init(&wc->flush_list_lock);
 		bio_list_init(&wc->flush_list);
 		wc->flush_thread = kthread_run(writecache_flush_thread, wc, "dm_writecache_flush");
 		if (IS_ERR(wc->flush_thread)) {
-- 
2.53.0




