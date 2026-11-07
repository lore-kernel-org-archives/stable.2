Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047560;
	b=3hUze7SF1u2f9EbKspm9PJsZBPDjwWSCX8j84W0bLcXln6BEm8fMOYizVD7fcTVp3V1k
	 YC590GeLuqn6UgY2ijUEL3pmV7VwNFfSfQ6GJJrx/9zLxG0yjcxbeE/1BOclfsOn9E3+h
	 273NeXwZpSd3SlrW0l02TYSS4ZeeyBHWNBthY0dTBQ8jk3Z7cahWeRagUrY6R/E2K8llV
	 gMqrj43kxakh/SxUME0UtuoStrWET0AmGtqRhyHdBur48TomjprUczq86N/YRrX7hYYJP
	 NIFvoByms6BTlLWMLYvfc5UCfRDO28mVJFKQXAeLB7Q0BLhsHQWQRdXqaOlEknAcJVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FFMOe/ewyiO1O4w0Y+10PS41yIHQCsYjLFjp/zdlLUE=;
	b=bCNDAmqvEgaMuQvQgeMCXdHcyBjtxQLcYo/f/FuokzGU7QurYMTW1QVhZDSDUC/SYrAX
	 i0T7MMbIySkipICEIZn+z5hE+GuDZECc7h2y8HuQiHCTit1jSOx3otCZXEi5pKf59cz+Q
	 hz8BTgTqv1EqDTqlaDy1nNMkCBcF/1c42mK/mDR/sBOcQnxkYmHkXtpniua2d5FiyU7eL
	 GlHfesSLzzrQuXPQgsyxtoPOr8WB+qMQGzlCXT10VCJnVlHA4C8hIuIoler1wUMVIl0EC
	 W/I2B679mIGxm2S++zU+3BR45NiyJ3aPM4IF9HVaMtGXcK6HiVdrasNedVgMVHw++sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCXilsWy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFA606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCXilsWy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ABC1F0089F;
	Sat,  7 Nov 2026 10:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047559;
	bh=FFMOe/ewyiO1O4w0Y+10PS41yIHQCsYjLFjp/zdlLUE=;
	h=From:To:Cc:Subject:Date;
	b=ZCXilsWyO/cc7GqeA+qX4H+fVsh1b8+2ROz/BDyMzfnYdvSVejLPOQpqcRrIlam0B
	 2Qq5gTVnelpcBGyEDtnaBOC+C1h5CL9LqBaG26GiOSQfK/yofRHU6d7GTPIo67kHar
	 nFpf0g1psUxuiOyL3ydp6xeOrmxkvBnRYnzzxIMzNQye9D4mu3RmD4lUDYslV8WIcn
	 Pal1PHo1cwOwsMfl1TXanZeMu2Ti9fV99CSJnh9vzR2h+vcR7cYIBwxxTNxebjefv5
	 N1i+J75TF1g4n9/nSV3UzPCZN4aJXT/Xy2Bfx59hRYd+Z6NYP3W81jzzYgnypKRr1H
	 65izktLaIVQ9g==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: zone: fix to avoid bio split on sequential zone" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:38 -0500
Message-ID: <20261107053238-failed-6.6-b9b036bd1e2c@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b9b036bd1e2cfbc189d5811d62d8711e216c40b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053238-failed-6.6-b9b036bd1e2c@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




