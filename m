Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705872;
	b=qlNxVxqcFSnk2v3gxF0QyqbkcWd4ZK0RAx/rpoJfDzGMTaQf0kXNnprYb4likj1+Y5lw
	 iMtJBQd57NVsV3ZnZfkR+89wq296eXoTJcbxHFOFlBB0nYz3O/zyObUJNsRo2C5kALNVq
	 vcef3kUD4m7BlIYr7kBsIfgbZ80JN+xvsIRsupjqgfmDPRqvc+zeJHU73ZhSuiq5JyM7e
	 5G5xAp7jAGdOTni9LrFD7J0zYuwN3v2ne7oVDSyY8SjalilALCMOPgZRFWW+sDRRcPuGI
	 xPJxU4QvGRDJM7WfMDub7k0WsVJe7EIwqqf4CdbzEljtexeY3xN0fM2ffolHNJS2Isw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705872;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ulwjnJRnjwNrCU/sov7T7bXRrnC4TW8Pk3i9297Md4g=;
	b=oNaLUNSPmxzpDmZXZlEH7c4jWd/I9zxSRqJWMp9KS39pC56pMgBesnnvHH5V0lm90kIQ
	 sdWJdjIESGyUE0Xglx/Z0zLKCsDR86Q/hjus8u4orFoaN0pYcbfcWlLoYfWBJg/mBrsiL
	 TvbNJOslkntt/AXtDENR4+ZP7kuVSS5osjI/qE365UT1dgPqfT7+GbSvQky4/PTVwO2cA
	 wYg2wT83pE/5UeqzhCLWuKOtq2o2FjLhIVJl+Q/y8mQzEHuP/XyQnPbRwpaUOra/6o7k9
	 BK+YtuhIjAKyEI5wbYl13rxtyjF3S7hz5sa/2VmMKPVDseiRWg3hPDxWlrsOxo8QaHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfF6jD0p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A6606A332
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfF6jD0p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E32E1F000CA;
	Thu, 26 Nov 2026 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705872;
	bh=ulwjnJRnjwNrCU/sov7T7bXRrnC4TW8Pk3i9297Md4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfF6jD0pg2MQheVCzQdqi88HnyA20os/5HFk1B4EMbl0rW3LEpQ7259GmQYwn42Pw
	 ty8nf3RiZW6KQqaO5/Jm4av9N0lnsvMRkXPTuZsybx5K0f//fNFpkMEvNeDG0FZ5Uk
	 9sgEkJBhy0iSt+5gMQMwxFqUd1ScdG7LlaHbhrxicTqd86KrHOk5BDyTcY5ZjwRriU
	 P591Imm2NqpgZ17pMuQrJh+C7tTXKpVuMMnK1SmyVGYVJ4Ye3UnsROW7rWP49QyhwF
	 QBVGk0L46GA2rhrfp8etqwhZJmF9I0UoH4/j6Kq8qwzF5MsFHg3vlwbBc3Oz0IGOsj
	 DSSuS9p3WjNrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: wuyuehong <wuyuehong@cmss.chinamobile.com>,
	syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm snapshot: fix discard_granularity unit in snapshot_io_hints
Date: Thu, 26 Nov 2026 10:11:10 -0500
Message-ID: <20261126151050.2327528-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112507-backer-sinner-8bf6@gregkh>
References: <2026112507-backer-sinner-8bf6@gregkh>
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
[ sashal: Changed max_hw_discard_sectors to max_discard_sectors in the context line, because this tree uses the older field name; the discard_granularity shift is applied as upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-snap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 6f239a281e384..a283e8b2f0b01 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2449,7 +2449,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
 			snap = snap_src;
 
 		/* All discards are split on chunk_size boundary */
-		limits->discard_granularity = snap->store->chunk_size;
+		limits->discard_granularity = snap->store->chunk_size << SECTOR_SHIFT;
 		limits->max_discard_sectors = snap->store->chunk_size;
 
 		up_read(&_origins_lock);
-- 
2.53.0

