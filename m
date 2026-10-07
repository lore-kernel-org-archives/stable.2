Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C923CDBB1;
	Wed,  7 Oct 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368307; cv=none; b=JHqVBkHSFMxFLZQZtQ8klEWGHDOolfx8zaxadV6wK/S7bz+lVlQ3jpSEagYbCD+JyGs1et1PV2GHUt7CrX343wQzTg9owqwMkuX1nI6p1tH0GjpGMRgE4Uf0IkJxtA/SiSIGJkWOHACaMkB8nNpTLmg15QfayrLTHorDkulfGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368307; c=relaxed/simple;
	bh=fmWtLviZNIW+qMbJn6rdp4dXagZ9rYsEjMtPSmHTyyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBRCsVxqRstjRDrhLmR5iDH/CmJqv0/5AjySzWXLmrQGoj/WkIGaty+EWsbKLrRfa6MI24TOGxhBC+kAbi3Qb2y2v8ElR8M30lsxOc98tqpdzwAE1r448nB/lF7KUDXOVqPWQrJd2I1fN+iNbAQdKUKE9cWCLdTi5PUr7iwN5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD3zrkMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD3zrkMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6861F0089B;
	Wed,  7 Oct 2026 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368296;
	bh=8j7tiOc7jQFSptVfi+4uGv4apzCx288nGLyqEctpiJ0=;
	h=From:To:Cc:Subject:Date;
	b=lD3zrkMulro5KNP8c655lTxTYZRFMXsiVv4Lz1lwj9qaudCHhtM6XzHjgIjMjOBFl
	 a8LS3Nrekr652Vq0UxPDYgSNQjZCALCN0behnWNG6bQgrmgY8PhVBrdnvNMPwNTgUl
	 VVvnkZcTM3MWvr2KOrvaL1WzPXoZU6cqIdBImKDyR8jG0L/UZ5Kmz8fEXX5s/xxCDO
	 56v0S4+jjXBZNogvbdpfkxORvv3/2rOL53lSNbaswEePo+82NFwmrSzEtQraG4UbQg
	 X//0R7JAoKylGEEQejPTBXejhT+Qn5/mJTiNjkZy66lfdtRDJK3vNORhCzFYYsCytD
	 xp+7ICxFknmLA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: zone: fix to avoid bio split on sequential zone
Date: Wed,  7 Oct 2026 10:18:12 +0000
Message-ID: <20261007101812.2348510-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

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
---
 fs/f2fs/data.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4bfa301a5df6..15c6af8515f3 100644
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
2.49.0

