Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705429;
	b=avMBigxa60k9pY4EQWl9sDPNj1wwl+aIn6x43bdcSLkBrTNaCejNfgoEFVVKkDfrxPHM
	 aFGTdbch8YHtqa6CY4BrdFKpxJigSYvhR4wEnpmAS4CtaCDyHc30vjVq+r+KaKPxU9NYq
	 6iCzWenuNQS/c/WODb06rCCLLHEzwRIW34lm8cDevc4DuJTXzrWisiKIoFrrvQvNsI40r
	 3xgHdr/BOJsK98bcDpY9OJcp9AXjOdFnUP+ZBMDhHf0Gy+QK85wJT/LwwuYDGL+v/+YJL
	 TCDIAqvVFoVn0aG6cNL5j9Bp+2UidqMf7qWLLDQE+okwsjzq7IstYZu9cbyImEsncgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JOFXatYNDHn2ZXlKFP6zW4LT5k22LlD6klYuVCGv6tU=;
	b=Ryk2Z9ioXOCZK2dzSuza5ENgTlksgyDbEKdfvbLLN4AgEvqsmw6OPridKamG1o80FVFm
	 TJmZazLd+8lk2lTLZmvS4Cr4IhGzjLzMfT0ltbv/9jIWHPo9+ALIR2ZU4knkSJAw51oeO
	 FKiD5BSxRUaiQo4Dn3q90b5Y5vh79Dh1a9+Dj4VZ6JXHQCnKdneZdc6W2EDe9UKBc/bm4
	 eSkDhAHzgsFPakRf0HcFaXuNpfd5PIDisi3YssqTNAZMrn0dTl0Jmwef+a+tGoftnHVVt
	 /A10vqFWabPLyS++MIyIxwfyyz+WNGZ283m7YLEJ6d9swGKKjIT2txrFk+50X3g4GuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEimAHtx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B9606A33B
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEimAHtx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCECB1F000D1;
	Thu, 26 Nov 2026 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705429;
	bh=JOFXatYNDHn2ZXlKFP6zW4LT5k22LlD6klYuVCGv6tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lEimAHtxty0owvNVcfx2QlYBhYjmQqvJJ4A5AFCFqkdPlMAupHtsTm51u5HYISaWv
	 H/E4gKkXfJigUmPP4C7taYHwPkIhQBA4g6L66UNdsDKkM12uaoF+9owbsflCnih+YZ
	 GoBR4qX3qFJrnhedesQxoqZMzhPiGuvQM7Gab1bFMUk3SMT7iFU/UqG6vKsWyI/nd7
	 YL/GCE9TNmpMzcXlYzPOioFP5ig3k875KX8t6gBd/x+m5pUH8UjXJtS0GJZPLgW4YN
	 NqYa2P0OiqzbEFNtxE9sZJuKKLWMvm5vdABTn2jVHWdnKNTptUG8V4dQAA2+l2LqYg
	 yz9krjossaEmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: wuyuehong <wuyuehong@cmss.chinamobile.com>,
	syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] dm snapshot: fix discard_granularity unit in snapshot_io_hints
Date: Thu, 26 Nov 2026 10:03:46 -0500
Message-ID: <20261126150336.2214049-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126150336.2214049-1-sashal@kernel.org>
References: <2026112506-afraid-flogging-8ebf@gregkh>
 <20261126150336.2214049-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-snap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 4649fb5f73732..b44d9d10b1427 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2424,7 +2424,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
 			snap = snap_src;
 
 		/* All discards are split on chunk_size boundary */
-		limits->discard_granularity = snap->store->chunk_size;
+		limits->discard_granularity = snap->store->chunk_size << SECTOR_SHIFT;
 		limits->max_hw_discard_sectors = snap->store->chunk_size;
 
 		up_read(&_origins_lock);
-- 
2.53.0

