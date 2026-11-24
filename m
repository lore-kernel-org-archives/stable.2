Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517779;
	b=V/DLEf1Pz6yDq3/o0u6gxUDjAafBmZ4JHizVZ1sVQOaL/6SuPgQDFB0rQfZ13VCKuoIU
	 iBNoVaMVmaPUMlC00n0JyQxoawk+8n94vu3rJVg+eVwiAQ0JKIVybJ5BoMvUz87SdC+H4
	 nTgXDOg4bDqxtgF98sLBpco8phsv18Ake3noAwqmTYplvKtLtsl13gi0vQa2niVU0KOxG
	 Pk0e9KXzQj0xSVBTFaSmx3RWUSZR3/PrlTUicOuLSQm3WP91EdCHzUMeKElUTA9Uym9HH
	 z3/BbEsFHXFiSPn+TlT7z4Q8dyC+tijvXb5T2vvuzeBN+oykF0hgwXeAfD1FpuDShdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517779;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xmnfXuIY/Jn1B753Y1ZTE4+arq0cUHrxI399VlR39Mw=;
	b=fx80PutSFWm86Xff8padvDJg8wjKNeOeRBa2fjflStH/RjrWJ0TV0knKMq+Fi/pSPq0F
	 ACvjEwEzdcs69wvVds/8oPgx762xsoOUatiPX/jaustjMTxkD4VCCG/8/sJyDSxkfpMf/
	 OeEtr6F3dGZZnriZBtCu3qsdgARczm1zIASsCbpX05hdGG40wGJPaSVmXQ9oUSIV0xMfH
	 fAhJJBdrndY0FBDKeKxeFq48tC1A5nystfaBtPRU43dcvBTdsgVNzbWsdRuY1skZID/+1
	 LqZiMOLaDOgQ/dHt/qPLchhFKgZt2b94TSA+zXdOKbno89Dku7kWrSizKLihWbuBdhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NwXymmWD;
	arc=none smtp.remote-ip=91.218.175.92
Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFC606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BADFC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NwXymmWD
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JNmC9rO7QZA8+/ZXv0emIiOalj0YlPZAufEGeW8OFug=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795517775; v=1; x=1796122575;
 b=NwXymmWDbs3Rp7Z7iMRzAmKAwwQSAtDs5f/JXiD5kGWCmTR5svhieAnP+W/h+y9gnbx1OshU
 XTh9fFCvPfIu5zv3EhBKIhKFJFDghpAOlLc0TWgFNPuCld0n00f+gZ84fzo9f5jJOSVivgsHoDl
 ZUetk0j3hsQoZ+Mjun/8DBDU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eafe4333877ed642;
	Tue, 24 Nov 2026 10:56:14 +0000
X-Mizu-Trace-ID: eafe4333877ed642
X-Migadu-Flow: FLOW_OUT
Message-ID: <96ffc97d-62bc-4a91-ae3d-9baa28ef500b@linux.dev>
Date: Tue, 24 Nov 2026 18:56:06 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, Keith Busch <kbusch@kernel.org>,
 Jan Kara <jack@suse.cz>, Ming Lei <tom.leiming@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 Zhao Gongyi <zhaogongyi@bytedance.com>, stable@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [PATCH] loop: fix stale dma_alignment when direct I/O is silently
 dropped
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
References: <20261124093342.838490-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261124093342.838490-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello，

在 2026/11/24 17:33, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> LOOP_SET_BLOCK_SIZE and LOOP_CONFIGURE can silently drop
> LO_FLAGS_DIRECT_IO when the new block size is smaller than the backing
> device's DIO alignment or the offset is unaligned.  The drop happens in
> loop_update_dio(), which runs after queue_limits_commit_update(), so the
> committed limits keep the dma_alignment computed from the pre-drop flag
> state, i.e. the backing file's alignment.  With an f2fs backing file,
> setting the block size to 512 then leaves every O_DIRECT request
> requiring 4K-aligned buffers.
> 
> loop_set_status() has the same window in a different shape: an offset
> change can drop the flag but nothing recomputes the queue limits.
> 
> Judge direct I/O usability against the block size the limits are being
> computed for rather than the committed one, and let loop_set_dma_limit()
> fall back to SECTOR_SIZE - 1 when the flag is about to be dropped, which
> is the order loop_set_dio() already uses.  Recompute the DMA alignment
> after the flag flip in loop_set_status().
> 
I noticed the sashiko report [1].  The lock order in loop_set_status() is indeed different from 06a2ff603f1f, but I think the reported deadlock cannot be reached through this code.  The queue is frozen and fully drained before queue_limits_start_update() takes q->limits_lock, and nothing between start_update() and commit_update() blocks, so the new code never waits for anything while holding the lock.

I am more worried about the suggested reorder: with start_update() before blk_mq_freeze_queue(), loop_set_status() would hold limits_lock while draining, and an in-flight write-zeroes request on an unsupported backing file would block in loop_clear_limits() on that lock while holding a queue usage counter, so the freeze would never complete.  The snapshot taken before the drain could also overwrite a concurrent loop_clear_limits() commit.

The cycle in the report does exist, but it predates this patch: it needs a thread that keeps limits_lock across a drain, for example queue_attr_store() via queue_limits_commit_update_frozen(), racing an unsupported fallocate in flight.  The "loop: defer the queue limits clear to a workqueue" series removes it at the root.

So I would like to keep the patch as it stands, but happy to discuss further.

Thanks,
Tao.

[1] https://sashiko.dev/#/patchset/20261124093342.838490-1-cui.tao@linux.dev

> Fixes: 6c8dec275ccc35e8f ("loop: set dma_alignment from the backing file for direct I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  drivers/block/loop.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 194f51d9dab6..4798c4d47a0e 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -179,11 +179,11 @@ static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
>   * of backing device, and the logical block size of loop is bigger than that of
>   * the backing device.
>   */
> -static bool lo_can_use_dio(struct loop_device *lo)
> +static bool lo_can_use_dio(struct loop_device *lo, unsigned int bsize)
>  {
>  	if (!(lo->lo_backing_file->f_mode & FMODE_CAN_ODIRECT))
>  		return false;
> -	if (queue_logical_block_size(lo->lo_queue) < lo->lo_min_dio_size)
> +	if (bsize < lo->lo_min_dio_size)
>  		return false;
>  	if (lo->lo_offset & (lo->lo_min_dio_size - 1))
>  		return false;
> @@ -204,7 +204,8 @@ static inline void loop_update_dio(struct loop_device *lo)
>  	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
>  		     lo->lo_queue->mq_freeze_depth == 0);
>  
> -	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
> +	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) &&
> +	    !lo_can_use_dio(lo, queue_logical_block_size(lo->lo_queue)))
>  		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
>  }
>  
> @@ -840,13 +841,17 @@ static unsigned int loop_default_blocksize(struct loop_device *lo)
>  	return SECTOR_SIZE;
>  }
>  
> -static void loop_set_dma_limit(struct loop_device *lo, struct queue_limits *lim)
> +static void loop_set_dma_limit(struct loop_device *lo, struct queue_limits *lim,
> +		unsigned int bsize)
>  {
>  	/*
>  	 * Direct I/O forwards the user pages to the backing file unchanged, so
>  	 * track the backing's DMA alignment requirement as the mode is toggled.
> +	 * Judge usability against @bsize rather than the committed block size,
> +	 * so limits computed for a pending change match the flag state that
> +	 * loop_update_dio() settles on right after the commit.
>  	 */
> -	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
> +	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && lo_can_use_dio(lo, bsize))
>  		lim->dma_alignment = max_t(unsigned int, lo->lo_dio_mem_align,
>  					   SECTOR_SIZE - 1);
>  	else
> @@ -874,7 +879,7 @@ static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
>  	lim->logical_block_size = bsize;
>  	lim->physical_block_size = bsize;
>  	lim->io_min = bsize;
> -	loop_set_dma_limit(lo, lim);
> +	loop_set_dma_limit(lo, lim, bsize);
>  	lim->features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
>  	if (file->f_op->fsync && !(lo->lo_flags & LO_FLAGS_READ_ONLY))
>  		lim->features |= BLK_FEAT_WRITE_CACHE;
> @@ -1134,6 +1139,7 @@ loop_set_status(struct loop_device *lo, blk_mode_t mode,
>  		struct block_device *bdev, const struct loop_info64 *info)
>  {
>  	struct block_device *claim_bdev = bdev_whole(bdev);
> +	struct queue_limits lim;
>  	int err;
>  	bool partscan = false;
>  	bool size_changed = false;
> @@ -1189,6 +1195,15 @@ loop_set_status(struct loop_device *lo, blk_mode_t mode,
>  	/* update the direct I/O flag if lo_offset changed */
>  	loop_update_dio(lo);
>  
> +	/*
> +	 * The offset change may have silently dropped LO_FLAGS_DIRECT_IO;
> +	 * refresh the DMA alignment so the queue limits match the new flag
> +	 * state.
> +	 */
> +	lim = queue_limits_start_update(lo->lo_queue);
> +	loop_set_dma_limit(lo, &lim, queue_logical_block_size(lo->lo_queue));
> +	queue_limits_commit_update(lo->lo_queue, &lim);
> +
>  	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
>  	if (partscan)
>  		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
> @@ -1361,7 +1376,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
>  		return 0;
>  
>  	if (use_dio) {
> -		if (!lo_can_use_dio(lo))
> +		if (!lo_can_use_dio(lo, queue_logical_block_size(lo->lo_queue)))
>  			return -EINVAL;
>  		/* flush dirty pages before starting to use direct I/O */
>  		vfs_fsync(lo->lo_backing_file, 0);
> @@ -1373,7 +1388,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
>  		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
>  	else
>  		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
> -	loop_set_dma_limit(lo, &lim);
> +	loop_set_dma_limit(lo, &lim, queue_logical_block_size(lo->lo_queue));
>  	queue_limits_commit_update(lo->lo_queue, &lim);
>  	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
>  	return 0;

