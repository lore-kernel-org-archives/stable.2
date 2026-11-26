Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705684;
	b=nCs9oupTA0J2zQ4/hu6+1tJ21Df3ZGgTnWV7+DqOAj8gO62Gu/QoxdydsdokDPbpQe7C
	 dHwdAnk2yhbLPH53cPDy1CdifVMjyWiu4JaKFXhOP+JB3E5dEfMq0RP5Df7Fgo6bxH572
	 E9lDn8ZhGfZg8+zQBjve+ow/5qoWTveQAY+vgcWbVwUnu9xG0T3x7nl6fsaQoA1+ACLwG
	 2KxGCzVlczieXIArXw2RsbZF3B7neeiUlpcHF9XLbidvNSa69TCQOsqU4OyLWYQj3mF2n
	 l9472+LQQucVXJZ3ilxkofrtcHGkTFj48sPWN5Qf1uVifIyH3ZEtNoAlFITaeRumPjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705684;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0B6sH6AwS7KHAEysrE0ghFTT8nF+QcltrMVdvvLl5ag=;
	b=yG7PO7q3mntshnKEvpSo3P0qU3iKfriXpRip88vWC7hsTRiGr89Ez8QX6JKJfvN50Sel
	 xxXY9wVBTTjpoRnuWjZsIJBFd0ut0zwKLJgZ7mU63YrTNdw6bV4mZmopYnC2BdjEiG/6V
	 AxqhF3CSJZ2heFP0uaC6y0meGzPWgeNk84WI5I9K2aquxf1zBcualn1IBfCBhS0oBbR/5
	 zxcsyDtd/iJ1vRsIllRvkkYb+amxBgJDvo/nM2yefvdr54ebbeKZZ0TIF+FmW5lAS/m0n
	 K/pOsp1f7adZC0qlvPlBLO3vDUieP1Gi9cZNH6bKQZvBpS4daGHgvYyXDgokP7Gic5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtPrlvBu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCFB606A32A
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtPrlvBu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA3A1F000D0;
	Thu, 26 Nov 2026 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705684;
	bh=0B6sH6AwS7KHAEysrE0ghFTT8nF+QcltrMVdvvLl5ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XtPrlvBu0gGHSaScsUzQdJ9UhyuevS64a5CkwGwCLbwaFN/149SK67cc/JycZaTx6
	 LRlsrw5c3DYk/hcrtzDvi6SKccE1uuYfEdsqHMHmBBsZFS+go9uymNG/r89hR+sGUH
	 vZ2x/0NDYz5QbVsZiYuJTIJC3wt2TEdPqA8S0NeaO6cUqhlvBddqPCH/7KmkaJM+BN
	 jbLnOndbPv+ApvwN7A0i58lQwXA8+sfdOvAkSNiJ0cou/6nXZ1lUZr42rwgWJwd7Fu
	 2h164e+Icg2LMhZntekiBDZbgyGlKXXkT31S5h1rc8dp91RxFtDpYtC/aO97eK5FI5
	 U1RRU2Oz9rcvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: wuyuehong <wuyuehong@cmss.chinamobile.com>,
	syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dm snapshot: fix discard_granularity unit in snapshot_io_hints
Date: Thu, 26 Nov 2026 10:08:01 -0500
Message-ID: <20261126150737.2238290-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112507-headed-parade-2f77@gregkh>
References: <2026112507-headed-parade-2f77@gregkh>
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

From: wuyuehong <wuyuehong@cmss.chinamobile.com>

[ Upstream commit d7216d7be2bbfdf3312695b6e41a4fc7c5e22902 ]

snapshot_io_hints() copies the snapshot store's chunk_size, which is
in 512-byte sectors, into queue_limits.discard_granularity, which, like
all other members of struct queue_limits, is in bytes.

For snapshots with a chunk size smaller than 512 sectors, e.g. the
16 KiB (32-sector) chunks created by the syzkaller reproducer, the
resulting granularity is smaller than a single sector.  When
dm_calculate_queue_limits() then stacks the target limits into the
table limits:

	blk_stack_limits(limits, &ti_limits, 0)

queue_limit_discard_alignment() truncates that granularity to zero
sectors and sector_div() divides by zero:

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:queue_limit_discard_alignment block/blk-settings.c:645 [inline]
  RIP: 0010:blk_stack_limits+0x1105/0x2d00 block/blk-settings.c:916
  Call Trace:
   dm_calculate_queue_limits+0x70c/0x1510 drivers/md/dm-table.c:1823
   dm_setup_md_queue+0x199/0x4f0 drivers/md/dm.c:2618
   table_load+0x4fd/0x8a0 drivers/md/dm-ioctl.c:1661

The divide fault itself only became reachable when commit e924da7d6622
("block: Drop granularity check in queue_limit_discard_alignment()")
removed the check for a sub-sector granularity in v6.13.  Kernels
before that returned a zero discard alignment instead of faulting, but
they still advertised a granularity 512 times too small.

Use the same chunk_size << SECTOR_SHIFT conversion that
io_overlaps_chunk() already applies to turn chunk_size into bytes.

Fixes: 2e6023850e17 ("dm snapshot: add optional discard support features")
Reported-by: syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1288484b13bf6af3620d
Cc: stable@vger.kernel.org
Signed-off-by: wuyuehong <wuyuehong@cmss.chinamobile.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ sashal: adjusted context: kept the old max_discard_sectors line in place of upstream's max_hw_discard_sectors, since that rename is absent here; the discard_granularity change itself is identical. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-snap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 1422dcde989a4..78c3dc10a826e 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2428,7 +2428,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
 			snap = snap_src;
 
 		/* All discards are split on chunk_size boundary */
-		limits->discard_granularity = snap->store->chunk_size;
+		limits->discard_granularity = snap->store->chunk_size << SECTOR_SHIFT;
 		limits->max_discard_sectors = snap->store->chunk_size;
 
 		up_read(&_origins_lock);
-- 
2.53.0

