Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322902;
	b=s5fL46kt5qaHHh+0kPJI77mGRp0Rto3mCghJMxOWt3uDwh2Q0ruk0M+ROaqAJS4o4i8j
	 Pzj4gc7YACF7Sr+gt0XhivdEHM6cFH7olq0c6nUC3kEHLIGNzVWHs3HnvwLtYrEMvv+7L
	 JHd6n2HpJW8sAcOp7wMJIdXPzhkRUEhqQO1d07UGifziiKPPkCBLGb2Z5NGIVlTMP2P1B
	 suWXr9MwUUh4nYHVsO9bEaIFyOcN9Dih/PsCWkZtor9U8pug4B1Vp+Gt4piU0WuKf9gtx
	 iqf5gAwVoK4y0BN3GakSr9ralPowoJ+BBvPqRH6jcONKVTwkTVwDeGJd3Co/9HrlQBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5iya5ZMYkFZCXErh9mcCUzaXfrkf3MQDS+ES+8g94MI=;
	b=HVqzu6w4qxERs2HddBfAcm8DkdW5ek2u1xEmG+tOFuJavN1R8YLi3OFgUkYKSt4oAl+C
	 nUxgAgEFv/XEkVVURkySOE2t4wQaw0azC0YMA3YQEgO8vq76Fm5MW6y7U+kTyjlmklBVW
	 kpQtzFpiHK+HLIbu4xoplVL8EpCU0ZwcWzB9++zlmUJLp/nI0aH+1s46Ny+PwUM4VEtcz
	 dzaRWt1KO/+Mr7kOdw19Y47UdAQXzuNzDCA0ugOKgfV5A8l+S5ymRCVBZxMhfsTer98Wv
	 f401NGxGTLd7fCU0vhKUSapzEjog4Tc8ytYDmP9MoTUP/BjYwn0aKydF5Y6Zrb5CG3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UD7nHiWD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15223606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UD7nHiWD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6462F1F0089F;
	Tue, 10 Nov 2026 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322901;
	bh=5iya5ZMYkFZCXErh9mcCUzaXfrkf3MQDS+ES+8g94MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UD7nHiWDLpckKR0/fM8zmvSLfSysqpUs871Rxh9WzDoqfYDQfb1X5eU2tYMuIiT2Q
	 eKMjJo2g9peFagOFMAZ21SIS1tNhzo6gVhuaUYzwIk97PUc/aPmzoZ/EBYHzvxaboy
	 31LnuyU+m0YZxt651cC8qdxhAWoogRiOamvIOvhYD4xFMqE8dqotixzzwKq/Ua2Yzc
	 Qwme8hNoTTfuUrJqU3CEnplf+uqmfOjw7N7diyqwLkeP4r3D+CxhR3M9UvQue7jK84
	 30NBny3B6fyFNmt868to1+Xv3V1gsW/ghtb4BITEq8dUe1ZI2P/GULOj67zfTESRmI
	 ZJTW+8WxXFodg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: zone: fix to avoid bio split on sequential zone
Date: Tue, 10 Nov 2026 10:01:40 -0500
Message-ID: <20261110150114.1980356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050412-failed-7.3-b9b036bd1e2c@kernel.org>
References: <20261107050412-failed-7.3-b9b036bd1e2c@kernel.org>
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

[ Upstream commit b9b036bd1e2cfbc189d5811d62d8711e216c40b3 ]

In the block layer, bio_split_to_limits() splits a bio if it exceeds
any underlying queue limits:
1. queue_max_sectors: Splits bios larger than the transfer limit. This
   limit is set by the device driver/DMA controller (max_hw_sectors) and
   device-mapper targets. When flushing dirty pages (governed by VFS
   writeback_chunk_size() and f2fs nr_pages_to_skip()), f2fs merges
   contiguous pages into bios up to 512KB (1024 sectors) or more without
   checking queue_max_sectors, which will be split if the device or DM
   target enforces a smaller limit.
2. queue_max_segments: Splits bios exceeding scatter-gather segment
   limits. f2fs allocates bios with up to 256 pages, exceeding the
   128-segment limit of DM targets (dm-default-key/dm-crypt) if pages
   are discontiguous.
3. chunk_sectors: Splits bios crossing chunk/zone boundaries. In f2fs,
   section_size strictly matches zone_size, and block allocation never
   spans across section boundaries, so bios never cross chunk_sectors.

Crucially, when bio_split_to_limits() splits a bio, bio_submit_split()
submits the tail half via submit_bio_noacct() before returning the head
half to the caller. On a sequential zoned device, this causes the tail
bio to arrive at the zone write plug before the head:

  dm-3: zone 7: prepare_bio wp mismatch: bio sector 30720 offset 2048
  != wp_offset 248, len 248

The write plug rejects the out-of-order tail with BLK_STS_IOERR, causing
f2fs_stop_checkpoint() and remounting the filesystem read-only:

2026-09-30T22:09:23.725678+08:00 localhost kernel: CPU: 9 UID: 0 PID: 243 Comm: kworker/9:1H Not tainted 6.12.81-gb3ef518fb26d #5
2026-09-30T22:09:23.725750+08:00 localhost kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
2026-09-30T22:09:23.725753+08:00 localhost kernel: Workqueue: dm-3_zwplugs blk_zone_wplug_bio_work
2026-09-30T22:09:23.725756+08:00 localhost kernel: Call Trace:
2026-09-30T22:09:23.725758+08:00 localhost kernel:  <TASK>
2026-09-30T22:09:23.725758+08:00 localhost kernel:  dump_stack_lvl+0x4d/0x70
2026-09-30T22:09:23.725759+08:00 localhost kernel:  f2fs_stop_checkpoint+0x1df/0x5d0
2026-09-30T22:09:23.725759+08:00 localhost kernel:  ? blk_zone_wplug_bio_work+0x4eb/0x740
2026-09-30T22:09:23.725760+08:00 localhost kernel:  f2fs_cache_write_end_io+0x545/0x6e0
2026-09-30T22:09:23.725761+08:00 localhost kernel:  blk_zone_wplug_bio_work+0x4eb/0x740
2026-09-30T22:09:23.725762+08:00 localhost kernel:  process_one_work+0x5c6/0xde0
2026-09-30T22:09:23.725764+08:00 localhost kernel:  ? assign_work+0x124/0x4e0
2026-09-30T22:09:23.725765+08:00 localhost kernel:  worker_thread+0x403/0xb70
2026-09-30T22:09:23.725765+08:00 localhost kernel:  ? __kthread_parkme+0x82/0x140
2026-09-30T22:09:23.725766+08:00 localhost kernel:  ? __pfx_worker_thread+0x10/0x10
2026-09-30T22:09:23.725766+08:00 localhost kernel:  kthread+0x235/0x2e0
2026-09-30T22:09:23.725767+08:00 localhost kernel:  ? recalc_sigpending+0x128/0x1d0
2026-09-30T22:09:23.725767+08:00 localhost kernel:  ? __pfx_kthread+0x10/0x10
2026-09-30T22:09:23.725769+08:00 localhost kernel:  ret_from_fork+0x2f/0x70
2026-09-30T22:09:23.725769+08:00 localhost kernel:  ? __pfx_kthread+0x10/0x10
2026-09-30T22:09:23.725770+08:00 localhost kernel:  ret_from_fork_asm+0x1a/0x30
2026-09-30T22:09:23.725771+08:00 localhost kernel:  </TASK>
2026-09-30T22:09:23.725771+08:00 localhost kernel: F2FS-fs (dm-0): Stopped filesystem due to reason: 3

To prevent write bios destined for sequential zones from being split:
1. In __bio_alloc(), bound npages to bdev_max_segments(bdev) for writes to
   sequential zone areas.
2. In page_is_mergeable(), check queue_max_segments() and queue_max_sectors()
   for sequential zone areas, so f2fs will not merge beyond the queue limits.

Fixes: 52763a4b7a21 ("f2fs: detect host-managed SMR by feature flag")
Fixes: 664ba972df9b ("f2fs: use BIO_MAX_PAGES for bio allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Changed F2FS_BLKSIZE(sbi) to F2FS_BLKSIZE to match the existing constant definition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cfd81bfc28a22..aa6e869d057ab 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -500,6 +500,10 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	struct bio *bio;
 
 	bdev = f2fs_target_device(sbi, fio->new_blkaddr, &sector);
+	/* avoid reversed IO if bio is split due to exceeding max_segments */
+	if (npages > 1 && !is_read_io(fio->op) &&
+	    f2fs_is_sequential_zone_area(sbi, fio->new_blkaddr))
+		npages = min_t(int, npages, bdev_max_segments(bdev));
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
@@ -790,7 +794,19 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 		return false;
 	if (last_blkaddr + 1 != cur_blkaddr)
 		return false;
-	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
+	if (bio->bi_bdev != f2fs_target_device(sbi, cur_blkaddr, NULL))
+		return false;
+	/* avoid reversed IO if bio is split due to exceeding max_segments/sectors */
+	if (f2fs_is_sequential_zone_area(sbi, cur_blkaddr)) {
+		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+
+		if (bio->bi_vcnt >= queue_max_segments(q))
+			return false;
+		if (bio_sectors(bio) + (F2FS_BLKSIZE >> SECTOR_SHIFT) >
+				queue_max_sectors(q))
+			return false;
+	}
+	return true;
 }
 
 static bool io_type_is_mergeable(struct f2fs_bio_info *io,
-- 
2.53.0

