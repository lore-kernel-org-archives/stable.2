Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512841;
	b=fWcrwx8WZbKP2GlT5yQWy5A6BCkOQvJQiPWXQaAfui7mUf4Mgi1fOzLip/B0nKrAqsEn
	 9dGIj0t8tHyWwhOUOR+5pz6XyleD6FwJq5Wj3LYoRc6lS6dmkq0NqnBzylj8UtxAJ6L9I
	 Ah9qbICbE8keTLFwuqZwydJlE+TVdcR2u/CA+Njq6+y2k0epwF0NJ8Ia5Cq4kuivHzGKY
	 F9l05f17aDGXVeajm8jCQGKJMR1HOrIRJW5WhvlCRGdJIwvQ2hPzCvVWsR/SBKesEphdh
	 HZGnwybevGv3o8ypwyRbOm1YboO/icrKUwa30Yaniw0HCyLaCqmVk0/E3v9Tcug+bZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512841;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xnHM6QCSfz4haO8qh+eGQ5MTOzq7qkQC9H2pOHh/vPs=;
	b=fAtcViomDSxvifKo+lO9oUTI83IThtkH2SGPN4+IJpayDhMvTwn7N65CL3AC3DRi/Adm
	 kiP78IPwNyLV5N+AZsfTYY1Z1mUW0xkSd+kUUgmfhZIbS6sZ2G+GlzZVsWNNY5NqZq/oq
	 kX80uf1kdR5u1obRoxstPDmm46skyUHuMugqiDJmM2I9jqnEBfGhqZxOVE4ZpRsyc1sh9
	 0ZSLTXdQsZkCN9YCGqSjpE2yOpEUbRUL7jTpw6PFWqE+MG+dhmxIyrZ/k0jh/fmbcCWiK
	 v4OBw6h4qhwJh9jGcpmFWc105wNLhA3Xt9YplNV3ivhYXhg0ZXr16kzSI2VzO31nX3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NOloo2kW;
	arc=none smtp.remote-ip=95.215.58.245
Received: from mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0263606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0263606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NOloo2kW
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GYbL3+eOGyznpi+w5XQwf2OJd3SoN6YCyYiWbmrjVzE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795512838; v=1; x=1796117638;
 b=NOloo2kWnlG5LoWIxCLgiwDCTtmRE2Pv8tGIj/d2rdCb32NHPpq1V9DmsYEO9oi4JxwXvL4p
 +nyu2N40/WpDjXLEFQBZf2FKKm3tU7TG+UXSFOAZ+PwkufyMUcwE7ZI81UV2cOHEiwS1UYn9nMU
 40VaX/2pJq5tqI2gEcT6JRVA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8c63c8a366e7c598;
	Tue, 24 Nov 2026 09:33:58 +0000
X-Mizu-Trace-ID: 8c63c8a366e7c598
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ming Lei <tom.leiming@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	Zhao Gongyi <zhaogongyi@bytedance.com>,
	stable@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH] loop: fix stale dma_alignment when direct I/O is silently dropped
Date: Tue, 24 Nov 2026 17:33:42 +0800
Message-ID: <20261124093342.838490-1-cui.tao@linux.dev>
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
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

LOOP_SET_BLOCK_SIZE and LOOP_CONFIGURE can silently drop
LO_FLAGS_DIRECT_IO when the new block size is smaller than the backing
device's DIO alignment or the offset is unaligned.  The drop happens in
loop_update_dio(), which runs after queue_limits_commit_update(), so the
committed limits keep the dma_alignment computed from the pre-drop flag
state, i.e. the backing file's alignment.  With an f2fs backing file,
setting the block size to 512 then leaves every O_DIRECT request
requiring 4K-aligned buffers.

loop_set_status() has the same window in a different shape: an offset
change can drop the flag but nothing recomputes the queue limits.

Judge direct I/O usability against the block size the limits are being
computed for rather than the committed one, and let loop_set_dma_limit()
fall back to SECTOR_SIZE - 1 when the flag is about to be dropped, which
is the order loop_set_dio() already uses.  Recompute the DMA alignment
after the flag flip in loop_set_status().

Fixes: 6c8dec275ccc35e8f ("loop: set dma_alignment from the backing file for direct I/O")
Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/block/loop.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 194f51d9dab6..4798c4d47a0e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -179,11 +179,11 @@ static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
  * of backing device, and the logical block size of loop is bigger than that of
  * the backing device.
  */
-static bool lo_can_use_dio(struct loop_device *lo)
+static bool lo_can_use_dio(struct loop_device *lo, unsigned int bsize)
 {
 	if (!(lo->lo_backing_file->f_mode & FMODE_CAN_ODIRECT))
 		return false;
-	if (queue_logical_block_size(lo->lo_queue) < lo->lo_min_dio_size)
+	if (bsize < lo->lo_min_dio_size)
 		return false;
 	if (lo->lo_offset & (lo->lo_min_dio_size - 1))
 		return false;
@@ -204,7 +204,8 @@ static inline void loop_update_dio(struct loop_device *lo)
 	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
 		     lo->lo_queue->mq_freeze_depth == 0);
 
-	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
+	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) &&
+	    !lo_can_use_dio(lo, queue_logical_block_size(lo->lo_queue)))
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
 }
 
@@ -840,13 +841,17 @@ static unsigned int loop_default_blocksize(struct loop_device *lo)
 	return SECTOR_SIZE;
 }
 
-static void loop_set_dma_limit(struct loop_device *lo, struct queue_limits *lim)
+static void loop_set_dma_limit(struct loop_device *lo, struct queue_limits *lim,
+		unsigned int bsize)
 {
 	/*
 	 * Direct I/O forwards the user pages to the backing file unchanged, so
 	 * track the backing's DMA alignment requirement as the mode is toggled.
+	 * Judge usability against @bsize rather than the committed block size,
+	 * so limits computed for a pending change match the flag state that
+	 * loop_update_dio() settles on right after the commit.
 	 */
-	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && lo_can_use_dio(lo, bsize))
 		lim->dma_alignment = max_t(unsigned int, lo->lo_dio_mem_align,
 					   SECTOR_SIZE - 1);
 	else
@@ -874,7 +879,7 @@ static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
 	lim->logical_block_size = bsize;
 	lim->physical_block_size = bsize;
 	lim->io_min = bsize;
-	loop_set_dma_limit(lo, lim);
+	loop_set_dma_limit(lo, lim, bsize);
 	lim->features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
 	if (file->f_op->fsync && !(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		lim->features |= BLK_FEAT_WRITE_CACHE;
@@ -1134,6 +1139,7 @@ loop_set_status(struct loop_device *lo, blk_mode_t mode,
 		struct block_device *bdev, const struct loop_info64 *info)
 {
 	struct block_device *claim_bdev = bdev_whole(bdev);
+	struct queue_limits lim;
 	int err;
 	bool partscan = false;
 	bool size_changed = false;
@@ -1189,6 +1195,15 @@ loop_set_status(struct loop_device *lo, blk_mode_t mode,
 	/* update the direct I/O flag if lo_offset changed */
 	loop_update_dio(lo);
 
+	/*
+	 * The offset change may have silently dropped LO_FLAGS_DIRECT_IO;
+	 * refresh the DMA alignment so the queue limits match the new flag
+	 * state.
+	 */
+	lim = queue_limits_start_update(lo->lo_queue);
+	loop_set_dma_limit(lo, &lim, queue_logical_block_size(lo->lo_queue));
+	queue_limits_commit_update(lo->lo_queue, &lim);
+
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
@@ -1361,7 +1376,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 		return 0;
 
 	if (use_dio) {
-		if (!lo_can_use_dio(lo))
+		if (!lo_can_use_dio(lo, queue_logical_block_size(lo->lo_queue)))
 			return -EINVAL;
 		/* flush dirty pages before starting to use direct I/O */
 		vfs_fsync(lo->lo_backing_file, 0);
@@ -1373,7 +1388,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 	else
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
-	loop_set_dma_limit(lo, &lim);
+	loop_set_dma_limit(lo, &lim, queue_logical_block_size(lo->lo_queue));
 	queue_limits_commit_update(lo->lo_queue, &lim);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	return 0;
-- 
2.53.0

