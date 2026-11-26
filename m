Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669400;
	b=HhznNaIbHXpkBb1TuGavNln1nOTVtBdlSmJL9lE/4IJzx0KSXbujm/Qyp/Vn5aEIy1nZ
	 +EFjsxLc/aSsZNzVuq2ItPgW+F7Jdiz7PGLNfWoxi/Vfbl5UQ8aSNt1wj77jMnDoKtvWr
	 +HXIFetsL15cjHHmeF5rmupoXFOvBHiUvuFTD9ZUF2eP4LoFCJAsvGyXS4dGiEcYK8h3B
	 +jV9F8gx0mfDpb0FOQpxMYsE7EEoK6EgAaVBwklhws6DuIBR+i7fxJWO9+kb07LHFogth
	 OY+ABODqbZPEZVZR3lzZWWBBg1D1eDrXKrryr0HnZkF8iNx8A9W9arf/x2fhA0RTywg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=heVfl1ICaDOXETcrmo77E/BYreHEA7qFtxE4qriVI1Y=;
	b=TwGtzwLCfnr0Mdw4uqxhGijXkpxDwE36unE0P9dzhCBgsx1oWLTJKiNkmMZhDERXfq3L
	 9MzEuKHJBGSyA9Z8OauSF+UFHi9tD0/lSPDmAg9t9+c+8fz0kLTvptsZhwLCJx0xKtXhA
	 QEyNcIttIS8HHsfpUwgKmS0/G7WmGJK0DkDa66btvwrhQ2vcTgTw1TiZTKSiWD3y5mvs5
	 sU6difkEfFE7K+tCk50JSWrUr5ezDX9FmYkIQctTigFLr+iV4CDnsrw0x/ngMMhjHs2wC
	 4ml9N3Nf/AGpi77vwDsJaP0O2qgFguMKvMrNQtLJ0fnMVpKsl0HGtQUHC49rwGN6EFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqeTY02Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD41606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqeTY02Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBD21F000C4;
	Thu, 26 Nov 2026 05:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669399;
	bh=heVfl1ICaDOXETcrmo77E/BYreHEA7qFtxE4qriVI1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lqeTY02ZsFv+DIvxXlHXjm0qhqRYPGrCBPKNY6Ub+9vDnuLQmyO7xylMKZNq6NIwE
	 A7N30Ks+E7cCf0oHzPyumZBfLUHLX4X09S10uX3w3V8kcWvlR6fYJlZc9SmvUd0hdd
	 kLrYLOzO7NrZVSX4gTHaB22vamZKgI426jDfgSvspi3ddhZ6vE9qxZwUtkoE/dIieG
	 uO1FrJULQGzqhVn3Li53MTGbeQoy060y9kK2+VJWm/XZLqunD9bKNqMStIvxOcQBsV
	 k32kapE9HXmSy6Fj6mCAHFnyk8/k+4ygjmDGwQu6sdvxQrHzUZI9ErybaRmjH8Arc9
	 xneJ8XiF6ntvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] dm: optimize REQ_PREFLUSH with data when using the linear target
Date: Thu, 26 Nov 2026 00:03:17 -0500
Message-ID: <20261126045401.2029286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112516-prude-hurried-f333@gregkh>
References: <2026112516-prude-hurried-f333@gregkh>
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

[ Upstream commit 2b1c6d7a890aeaeabfeabd1cef5a4808043dc1a4 ]

If the table has only linear targets and there is just one underlying
device, we can optimize REQ_PREFLUSH with data - we don't have to split
it to two bios - a flush and a write. We can pass it to the linear target
directly.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Tested-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Stable-dep-of: e92cd41e8e5e ("dm: fail a REQ_PREFLUSH bio with data when its preflush fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-core.h |  1 +
 drivers/md/dm.c      | 32 ++++++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 391c1df19a764..9f3250d596d85 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -295,6 +295,7 @@ struct dm_io {
 	struct dm_io *next;
 	struct dm_stats_aux stats_aux;
 	blk_status_t status;
+	bool requeue_flush_with_data;
 	atomic_t io_count;
 	struct mapped_device *md;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1df8a808d279e..755d8fd6760c7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -488,18 +488,13 @@ u64 dm_start_time_ns_from_clone(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(dm_start_time_ns_from_clone);
 
-static inline bool bio_is_flush_with_data(struct bio *bio)
-{
-	return ((bio->bi_opf & REQ_PREFLUSH) && bio->bi_iter.bi_size);
-}
-
 static inline unsigned int dm_io_sectors(struct dm_io *io, struct bio *bio)
 {
 	/*
 	 * If REQ_PREFLUSH set, don't account payload, it will be
 	 * submitted (and accounted) after this flush completes.
 	 */
-	if (bio_is_flush_with_data(bio))
+	if (io->requeue_flush_with_data)
 		return 0;
 	if (unlikely(dm_io_flagged(io, DM_IO_WAS_SPLIT)))
 		return io->sectors;
@@ -588,6 +583,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio, gfp_t g
 	io = container_of(tio, struct dm_io, tio);
 	io->magic = DM_IO_MAGIC;
 	io->status = BLK_STS_OK;
+	io->requeue_flush_with_data = false;
 
 	/* one ref is for submission, the other is for completion */
 	atomic_set(&io->io_count, 2);
@@ -955,6 +951,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 	struct mapped_device *md = io->md;
 	blk_status_t io_error;
 	bool requeued;
+	bool requeue_flush_with_data;
 
 	requeued = dm_handle_requeue(io, first_stage);
 	if (requeued && first_stage)
@@ -971,6 +968,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 		__dm_start_io_acct(io);
 		dm_end_io_acct(io);
 	}
+	requeue_flush_with_data = io->requeue_flush_with_data;
 	free_io(io);
 	smp_wmb();
 	this_cpu_dec(*md->pending_io);
@@ -983,7 +981,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 	if (requeued)
 		return;
 
-	if (bio_is_flush_with_data(bio)) {
+	if (unlikely(requeue_flush_with_data)) {
 		/*
 		 * Preflush done for flush with data, reissue
 		 * without REQ_PREFLUSH.
@@ -2022,12 +2020,30 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	}
 	init_clone_info(&ci, io, map, bio, is_abnormal);
 
-	if (bio->bi_opf & REQ_PREFLUSH) {
+	if (unlikely((bio->bi_opf & REQ_PREFLUSH) != 0)) {
+		/*
+		 * The "flush_bypasses_map" is set on targets where it is safe
+		 * to skip the map function and submit bios directly to the
+		 * underlying block devices - currently, it is set for dm-linear
+		 * and dm-stripe.
+		 *
+		 * If we have just one underlying device (i.e. there is one
+		 * linear target or multiple linear targets pointing to the same
+		 * device), we can send the flush with data directly to it.
+		 */
+		if (map->flush_bypasses_map) {
+			struct list_head *devices = dm_table_get_devices(map);
+			if (devices->next == devices->prev)
+				goto send_preflush_with_data;
+		}
+		if (bio->bi_iter.bi_size)
+			io->requeue_flush_with_data = true;
 		__send_empty_flush(&ci);
 		/* dm_io_complete submits any data associated with flush */
 		goto out;
 	}
 
+send_preflush_with_data:
 	if (static_branch_unlikely(&zoned_enabled) &&
 	    (bio_op(bio) == REQ_OP_ZONE_RESET_ALL)) {
 		error = __send_zone_reset_all(&ci);
-- 
2.53.0

