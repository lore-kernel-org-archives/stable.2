Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049371;
	b=KHDdE/H+knzf6iIlsI9s+KVxfWW+x442u5TKr0Q712GMgNREFqX+4HVo0C5Tr/i88BW0
	 /3Dcncht32uaZnv//7wXygVTrXVw+WJfJ5wtiSHq4yLq1xZHfqX0wTKe5qB8r9yS2XCKZ
	 oyJniUFZYL0ebhAONfvfRCa00/1j4WDEtSx0bhJufSP0ziHp4n08v0eJFZpAQOXPa43P5
	 SoJt3QRg3NIBI/BmqU9ebncBzs2Rrq4CjRssGb5S1cJKQLwxM5kKr4TLW6+EIHptb8AyM
	 LOGYCtt+BUNFTDfJrAlQNJxh1UEuAMkOrhG24xpqYgdRrYycC2NGSb7jou4KGN/sctQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049371;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AB3nj4zRT/Zr1OUxRu7PvzTcE9TtrvbgPPpaC4V8En8=;
	b=ZREvAwVj2JbmzM1Lo7+ANTSA7Z5fNiq7WsP5D977PwL5w1FTfgTY1z3IBzDyf2W1yWoG
	 5iKSfJRUuJO8c6qkygY+vczZBUupA2PQ36/oLlBHMnoooUSjwFKofIBCtq2LI401rd4WH
	 3CKvs8qG3NBpkTvqDJ2YMvifhEo7IwY/CcozpvaXtdL3Q9U5PU1qYtyyN2XfI6IYCp19m
	 WFq6ocYeVfrcURbF7GYN22znO0diyuy1PsZlNQuzm6QQSY1jlk2k0LzX0rwPQhnI9ScaZ
	 Z3O6XjzC/VAsDKGN0hwvSogmBAJ0IV2sk2Y3hvLcXRCEsTHQeKJZV14sku1a1XWykbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RV5chgp/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E683606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV5chgp/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F33C1F0089F;
	Sat,  7 Nov 2026 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049370;
	bh=AB3nj4zRT/Zr1OUxRu7PvzTcE9TtrvbgPPpaC4V8En8=;
	h=From:To:Cc:Subject:Date;
	b=RV5chgp/voeDaPx5DZZBPEpKnI5aKo5fjQK2HJzItMrCM7yZgXSS6rVeNFloGpGMs
	 IqiZSYD5ThAyKflUuDcmfxLLSTO9WTzP9NAXn/vr49ndvAsGvskC3UjEd04JvgziTA
	 7Dxldw+4OOFxuC2lxMJu5vXbPZ0L4EL9p5iIGOdewMpSkGfa9dswYjgqBSSBUTekpG
	 eXc3jy6GaayPOp+iswlKLZtOBKfaQx9W0J0W1b3G8g8DCyo3iKcANRTHrGEUxEfes6
	 p5YDbRgHaZYQ0gnqG1IiCTU2Rq1MNsdmj7/YDscoviQ6tA/aL8NBeMSfm2YwPp6Nxr
	 wZjE12QyQT7qg==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: zone: fix to avoid bio split on sequential zone" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:49 -0500
Message-ID: <20261107060249-failed-5.15-b9b036bd1e2c@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b9b036bd1e2cfbc189d5811d62d8711e216c40b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060249-failed-5.15-b9b036bd1e2c@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b9b036bd1e2cfbc189d5811d62d8711e216c40b3 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Wed, 7 Oct 2026 10:18:12 +0000
Subject: [PATCH] f2fs: zone: fix to avoid bio split on sequential zone

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
---
 fs/f2fs/data.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4bfa301a5df63..15c6af8515f30 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -536,6 +536,10 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	struct bio *bio;
 
 	bdev = f2fs_target_device(sbi, fio->new_blkaddr, &sector);
+	/* avoid reversed IO if bio is split due to exceeding max_segments */
+	if (npages > 1 && !is_read_io(fio->op) &&
+	    f2fs_is_sequential_zone_area(sbi, fio->new_blkaddr))
+		npages = min_t(int, npages, bdev_max_segments(bdev));
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
@@ -892,7 +896,19 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
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
+		if (bio_sectors(bio) + (F2FS_BLKSIZE(sbi) >> SECTOR_SHIFT) >
+				queue_max_sectors(q))
+			return false;
+	}
+	return true;
 }
 
 static bool io_type_is_mergeable(struct f2fs_bio_info *io,
-- 
2.53.0




