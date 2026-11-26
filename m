Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705428;
	b=GEV4H4mK59ZFXe3zlUvYfTCHpsKq0FLNWM5pN9Weez7OOPMhbrnT2L1T7P6rlT6gAbqS
	 MjE8rb8KmXOIjmC2MdnlKEt6TCl4qUqLCxH/2UQHm+uFqtqBD5oerrqFVdsTHWa8+nQtM
	 Y5jb+DcKvtXYkePIK1QAZzCEMrmZ/yiatP/rA0/tnfhQoN2+bL8xoJu3+xVA6f9nS170q
	 htTis57F96wvXo4Dr4WtFHlcPkaMlOKbYPMlkH/xZHJo/yDz8Gp6t4vg5/gQzdi2VEo4X
	 XhYVVGEyHnWew/u4zXw3cZ3CGRD6PsW2Pn/lJMfTzcjtBgKQf/QhG9efLHRnIjyadeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=deV8IMAsyw51Rw+TUjvLMKqxvFIwG6Vs7midrRazpgQ=;
	b=uoeuffjxFWJANsdcS+8FL0P6k4yFIg3MFjNAd/Wx/Pnv6Qitw8M/9JnQADkLKqMiBWC1
	 NCBV493u8pdupJxm/8ETz76LzVbmz+P0riwvDG1aO0VxzTxw6nQRHKa+Yc40ZvnK4oqLd
	 3k7kCoVhCozVoL9FYk3JKy9xjPokKExjcw922irh9n2VIgoHBoYpqp2c+mg8xuVJQq6TX
	 zHXZt1QvXlXR3r7+f3+gZruAgec8lRklitgydu6uKKYaKHopeXB8/ZLri0I7kNTqRb77r
	 8bGQraZN0nsOOEUFshiJ+21uN6Ky0F7lSFPZtJEOl1W6vmBkHfS/1zxy87XqRSO3cdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zj5e+cHP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7B606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zj5e+cHP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78C91F000CA;
	Thu, 26 Nov 2026 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705428;
	bh=deV8IMAsyw51Rw+TUjvLMKqxvFIwG6Vs7midrRazpgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zj5e+cHPLUAXV/vlOcfnuV4yJ+AW0c8DWX8NHLUrH4jHCP6Mpr86pEzhx9KMrd+Te
	 6n2A5N+ZlJXftm0L5b4nvUoGK7VpHppJcRin1knvMvcNZ1LZIeNQp8hL67BUoWYBsc
	 66zd3eQD90RJXkHdThE8hCN5t+0veQ/nUsGyrJ7lstNjVaN/z9N5Xwg8BDbwdWBtOF
	 fOuRCq04rXat+ak6jldM5ns+TMzyA85qvaJdDZIBX2+5oyxcGiNipg6fJiaTjNKTQI
	 vu9Hc/BUw+wsj+Y2GOt/z+zOLW1SjssrdSoa3IY00Hp3LPkXvoS+0L17E+xqcwFSq2
	 gPuKWRTuD9TXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] dm: always manage discard support in terms of max_hw_discard_sectors
Date: Thu, 26 Nov 2026 10:03:45 -0500
Message-ID: <20261126150336.2214049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112506-afraid-flogging-8ebf@gregkh>
References: <2026112506-afraid-flogging-8ebf@gregkh>
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

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit 825d8bbd2f32cb229c3b6653bd454832c3c20acb ]

Commit 4f563a64732d ("block: add a max_user_discard_sectors queue
limit") changed block core to set max_discard_sectors to:
 min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors)

Since commit 1c0e720228ad ("dm: use queue_limits_set") it was reported
dm-thinp was failing in a few fstests (generic/347 and generic/405)
with the first WARN_ON_ONCE in dm_cell_key_has_valid_range() being
reported, e.g.:
WARNING: CPU: 1 PID: 30 at drivers/md/dm-bio-prison-v1.c:128 dm_cell_key_has_valid_range+0x3d/0x50

blk_set_stacking_limits() sets max_user_discard_sectors to UINT_MAX,
so given how block core now sets max_discard_sectors (detailed above)
it follows that blk_stack_limits() stacks up the underlying device's
max_hw_discard_sectors and max_discard_sectors is set to match it. If
max_hw_discard_sectors exceeds dm's BIO_PRISON_MAX_RANGE, then
dm_cell_key_has_valid_range() will trigger the warning with:
WARN_ON_ONCE(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE)

Aside from this warning, the discard will fail.  Fix this and other DM
issues by governing discard support in terms of max_hw_discard_sectors
instead of max_discard_sectors.

Reported-by: Theodore Ts'o <tytso@mit.edu>
Fixes: 1c0e720228ad ("dm: use queue_limits_set")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Stable-dep-of: d7216d7be2bb ("dm snapshot: fix discard_granularity unit in snapshot_io_hints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-target.c | 5 ++---
 drivers/md/dm-clone-target.c | 4 ++--
 drivers/md/dm-log-writes.c   | 2 +-
 drivers/md/dm-snap.c         | 2 +-
 drivers/md/dm-target.c       | 1 -
 drivers/md/dm-thin.c         | 4 ++--
 drivers/md/dm-zero.c         | 1 -
 drivers/md/dm-zoned-target.c | 1 -
 drivers/md/dm.c              | 2 +-
 9 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 79b4eec0ce8de..b85db4c3c3ffd 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3515,8 +3515,8 @@ static void set_discard_limits(struct cache *cache, struct queue_limits *limits)
 
 	if (!cache->features.discard_passdown) {
 		/* No passdown is done so setting own virtual limits */
-		limits->max_discard_sectors = min_t(sector_t, cache->discard_block_size * 1024,
-						    cache->origin_sectors);
+		limits->max_hw_discard_sectors = min_t(sector_t, cache->discard_block_size * 1024,
+						       cache->origin_sectors);
 		limits->discard_granularity = cache->discard_block_size << SECTOR_SHIFT;
 		return;
 	}
@@ -3525,7 +3525,6 @@ static void set_discard_limits(struct cache *cache, struct queue_limits *limits)
 	 * cache_iterate_devices() is stacking both origin and fast device limits
 	 * but discards aren't passed to fast device, so inherit origin's limits.
 	 */
-	limits->max_discard_sectors = origin_limits->max_discard_sectors;
 	limits->max_hw_discard_sectors = origin_limits->max_hw_discard_sectors;
 	limits->discard_granularity = origin_limits->discard_granularity;
 	limits->discard_alignment = origin_limits->discard_alignment;
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index 56e9a4911d968..780dc1a36d150 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -2050,7 +2050,8 @@ static void set_discard_limits(struct clone *clone, struct queue_limits *limits)
 	if (!test_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags)) {
 		/* No passdown is done so we set our own virtual limits */
 		limits->discard_granularity = clone->region_size << SECTOR_SHIFT;
-		limits->max_discard_sectors = round_down(UINT_MAX >> SECTOR_SHIFT, clone->region_size);
+		limits->max_hw_discard_sectors = round_down(UINT_MAX >> SECTOR_SHIFT,
+							    clone->region_size);
 		return;
 	}
 
@@ -2059,7 +2060,6 @@ static void set_discard_limits(struct clone *clone, struct queue_limits *limits)
 	 * device limits but discards aren't passed to the source device, so
 	 * inherit destination's limits.
 	 */
-	limits->max_discard_sectors = dest_limits->max_discard_sectors;
 	limits->max_hw_discard_sectors = dest_limits->max_hw_discard_sectors;
 	limits->discard_granularity = dest_limits->discard_granularity;
 	limits->discard_alignment = dest_limits->discard_alignment;
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index dabfc856443a9..6272c77184200 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -872,7 +872,7 @@ static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limit
 	if (!bdev_max_discard_sectors(lc->dev->bdev)) {
 		lc->device_supports_discard = false;
 		limits->discard_granularity = lc->sectorsize;
-		limits->max_discard_sectors = (UINT_MAX >> SECTOR_SHIFT);
+		limits->max_hw_discard_sectors = (UINT_MAX >> SECTOR_SHIFT);
 	}
 	limits->logical_block_size = bdev_logical_block_size(lc->dev->bdev);
 	limits->physical_block_size = bdev_physical_block_size(lc->dev->bdev);
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index b2a0460affa68..4649fb5f73732 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2425,7 +2425,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 		/* All discards are split on chunk_size boundary */
 		limits->discard_granularity = snap->store->chunk_size;
-		limits->max_discard_sectors = snap->store->chunk_size;
+		limits->max_hw_discard_sectors = snap->store->chunk_size;
 
 		up_read(&_origins_lock);
 	}
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 4d1f04b40653f..87bf0a2886fcd 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -151,7 +151,6 @@ static void io_err_release_clone_rq(struct request *clone,
 
 static void io_err_io_hints(struct dm_target *ti, struct queue_limits *limits)
 {
-	limits->max_discard_sectors = UINT_MAX;
 	limits->max_hw_discard_sectors = UINT_MAX;
 	limits->discard_granularity = 512;
 }
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index e19aa30e43567..f75b0b4c63740 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -4099,7 +4099,7 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	if (pt->adjusted_pf.discard_enabled) {
 		disable_discard_passdown_if_not_supported(pt);
 		if (!pt->adjusted_pf.discard_passdown)
-			limits->max_discard_sectors = 0;
+			limits->max_hw_discard_sectors = 0;
 		/*
 		 * The pool uses the same discard limits as the underlying data
 		 * device.  DM core has already set this up.
@@ -4496,7 +4496,7 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	if (pool->pf.discard_enabled) {
 		limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
-		limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
+		limits->max_hw_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
 	}
 }
 
diff --git a/drivers/md/dm-zero.c b/drivers/md/dm-zero.c
index 3b13e6eb1aa47..9a0bb623e823f 100644
--- a/drivers/md/dm-zero.c
+++ b/drivers/md/dm-zero.c
@@ -61,7 +61,6 @@ static int zero_map(struct dm_target *ti, struct bio *bio)
 
 static void zero_io_hints(struct dm_target *ti, struct queue_limits *limits)
 {
-	limits->max_discard_sectors = UINT_MAX;
 	limits->max_hw_discard_sectors = UINT_MAX;
 	limits->discard_granularity = 512;
 }
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index b57f7259f999d..3a9510e756214 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -1001,7 +1001,6 @@ static void dmz_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	limits->discard_alignment = 0;
 	limits->discard_granularity = DMZ_BLOCK_SIZE;
-	limits->max_discard_sectors = chunk_sectors;
 	limits->max_hw_discard_sectors = chunk_sectors;
 	limits->max_write_zeroes_sectors = chunk_sectors;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e4ebdd3d56d47..cb44dc3a4dad5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1073,7 +1073,7 @@ void disable_discard(struct mapped_device *md)
 	struct queue_limits *limits = dm_get_queue_limits(md);
 
 	/* device doesn't really support DISCARD, disable it */
-	limits->max_discard_sectors = 0;
+	limits->max_hw_discard_sectors = 0;
 }
 
 void disable_write_zeroes(struct mapped_device *md)
-- 
2.53.0

