Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706454;
	b=ndOr9PyRY8KRiuG0QNtMAHbSLVW5KEBk2dC7ZoiQv7DqO+q1uNE+nWhONVJemCzii8iX
	 jqaRXqtrwH+mEdqbR3n1ATUqVuNaJ2n8wwj2H1a9ilhdjV5VKSGk9hn81eJY4XJ+KfASS
	 oExsv7ULCrr0apAJu1VUwMDmJ4zHlTaQ0lGQUGZYEv7YYU3ChmCuxLzdukAjwGIvM8Yer
	 xJTMQVqaqhvpZtRyM+PPNp/zhUv0D6OVUYp+AwevWck1FnXOA4AzdxMyUfU7QapOiLFS5
	 cKx/w7fyWh0bXtFUUAkYrXxYnxSYHIMTbY0kTX51r8VWT2xhWRLbjHI5NVDj1Z+5sow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S7PCbsuXLBA3nPe/mPgDBcxfqsO0WxGoW9h8zHQZgJY=;
	b=viTHwnqSu4Dc/YoLNKzLjiY0mya2hZNc+FVOpTFz0NkpyxAjiffCTB1FsoC92Im/gis3
	 2q4t4UoeME9Vou8STBEkv7pzIrlpyj4WrjbMImCPuoqUB580xuwzI4HBMFkKA23iFPlJK
	 FWsiABSHt8sTZ5/f+qDBCYB9WoVDpRM4vixQCmQZeIlH78E2gViNjgSOQtcrlqTXqyM94
	 j/vESbe049NF4rK6iAdfNkM/4FV6I6X9RM2wUMu6vIUR9KWwWyIU8LV7VLjL78Wy4O9+l
	 sf8Ad43NaBDij4hfhYU6ugPeWSq4hymBehSdRDBsbVyF7QNO/0EkXZpmc3yRfm2obEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPAPWKMe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50670606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPAPWKMe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F381F000C0;
	Thu, 26 Nov 2026 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706453;
	bh=S7PCbsuXLBA3nPe/mPgDBcxfqsO0WxGoW9h8zHQZgJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZPAPWKMeHvli4mYfxenRBImztIV6KSs5xhQiJQE3HIjd/GsimrCzJ2IaJuElAgsiF
	 Xpo7IOX+mg3UAbLURqfjwruaDM8h8OuF9PxARdZMgQOy1ySkDFRIrDdVtcF8yl7kRb
	 aVKYkaq3nStdfn6dPDSFP7JZ24Ns4Wd175WEilHEaEjSStvpMNjNH6PSe4KkPzdn/6
	 VzCKwE2AZYxeRRc2iNO1dxali0N/LF8luIgq75htU1UDfm0fYBAR2aYaQe96E14rAU
	 EXB/Yorr+IqpbeTB7pBBycHtm3D42La8wXUHN4CgzepeX/zQUsjGswGi8QWbQB+xXs
	 rVWdMxgbOh2zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: wuyuehong <wuyuehong@cmss.chinamobile.com>,
	syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm snapshot: fix discard_granularity unit in snapshot_io_hints
Date: Thu, 26 Nov 2026 10:20:51 -0500
Message-ID: <20261126151428.2358784-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112508-swooned-spherical-c717@gregkh>
References: <2026112508-swooned-spherical-c717@gregkh>
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
[ sashal: Changed max_hw_discard_sectors to max_discard_sectors to match the older queue_limits field name, while keeping the discard_granularity shift fix. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-snap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 9c3e0b22691ee..77f8123497e31 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2438,7 +2438,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
 			snap = snap_src;
 
 		/* All discards are split on chunk_size boundary */
-		limits->discard_granularity = snap->store->chunk_size;
+		limits->discard_granularity = snap->store->chunk_size << SECTOR_SHIFT;
 		limits->max_discard_sectors = snap->store->chunk_size;
 
 		up_read(&_origins_lock);
-- 
2.53.0

