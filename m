Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685753;
	b=NUVBvmCCSW2FtcSsnKTeInpN5hsuR0hsRXW6D1jceC9l5ZC6AUaqYK9ghfNFrohZ3t6n
	 uH91gTvSACBWDOth9LOL+440p0udJESFIaPpWLbgQ+a6cT+oOFgLC+o3edm2xX3LRRhhR
	 qRX+cANzgSrhgVvY/1wGTYwZbc0UvlGvCkzhEv4nzFJ1K3J8NFaNg0QVzmWauGhnntmq0
	 PT8rqnIPzojBWJH94EOVrxjZ8shYiNvBsAZhcVzEd72ML49lc9pexEG4wOtZ/l8ZXa99u
	 peLoVBSdUuXVD2JY3lT1fxleFKscGuaUnyANWMxWlQUV9dlZnqdkNTwbS5xXvruMuuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dEg7zi+vxddqTxYiqnM9jUa7nhOfPILLzMR9Ir+JAOc=;
	b=SJajYQfdjiIM2MNdguQ7oH6VbwFHWL55aTzfluWdNIrSMIz6C+byUF8/b2dByoBHNUXd
	 kaj0EeeOoEUg4hTl2N0mBwe6cjlD0/FIsn1neMFmo4lG8T6fxsolcPk31JNlQXacIMBPR
	 hLPsFRl1jCj9yH00IzXjcxXjzp2PbZGbY59WnbrShOXyOoTchGKFyb4hE8HKoW+7yE4ps
	 XKWFInF2XGsPO94q29/XS1HxaIbhGD003EvLCYmmnB3w3BwWMyuQ2bPw5F5KlSs9g9zU/
	 UeDyXPXrLLgTwp0w0J95evm/c6t4JIrOXf396LR/5zgAVgNqi+Sp2Gk8cl9gycY6soQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXO5osIc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A490606A325
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXO5osIc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3594B1F01825;
	Thu, 22 Oct 2026 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685752;
	bh=dEg7zi+vxddqTxYiqnM9jUa7nhOfPILLzMR9Ir+JAOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oXO5osIcbuObzE6X+oRkrsMHHsMGdB7M1SL6QPNe+HCRva32FG4kk0K4fTuqh0ZRN
	 0eupvhd+e5oSZNIr0gLJ4zw+Nc+2IuOPq0SQMRmp4hYc3w1/bcQRh08Tf5VLH8KP8E
	 aNLNuLIXSe/64Xhqd5PX6nPfyefp0PM3UoUxc200IGRBXA3voxj9bkzx+tAgcY1TtA
	 nRZDGINjG7jfCcRbPidysqNomx3c4R96inv/KHgqp5/GhcJ8o06+b6Ast5kkBJH7aX
	 LA7BYRpeL+AvyZqFFbnQ3Relhn0LwMavYZ+sKwH5KIyEEgGg9CZICYvdUDBeISwoS4
	 PdYpWBSe2/Z0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Cheng <chencheng@fnnas.com>,
	Sun Yangkai <sunyangkai@fygo.io>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dm-integrity: require stable writes for internal hash modes
Date: Thu, 22 Oct 2026 12:15:49 -0400
Message-ID: <20261022161457.1673341-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102132-liver-overdraft-11ac@gregkh>
References: <2026102132-liver-overdraft-11ac@gregkh>
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

From: Chen Cheng <chencheng@fnnas.com>

[ Upstream commit b2fd92f016e9d692fd3c8c08d0ee014e9212279d ]

dm-integrity direct, bitmap and inline internal-hash modes compute
integrity tags from the pages carried by the write bio.  The lower data
write also uses those pages, so the tag and the data write depend on the
same memory contents staying unchanged while writeback is in flight.

Without stable writes, a buffered writer can modify a writeback folio
after dm-integrity has submitted the data bio and before the lower device
has consumed the data.  After a crash, this can leave data from the later
contents with a tag calculated from the earlier contents, causing
permanent checksum failures on read.

Set BLK_FEAT_STABLE_WRITES for internal-hash D, B and I modes so
filesystems wait for writeback folios to become stable before modifying
them again.  Journal mode is left unchanged because it copies data into
the journal before computing and persisting the tag.

Tested using dm-delay over a virtio-blk test disk, dm-integrity
internal_hash:crc32c and no-journal ext4.  The D and B reproducers both
failed with checksum errors before this change and completed with
READ_RC=0 and zero mismatches after it.

Fixes: 7eada909bfd7 ("dm: add integrity target")
Cc: stable@vger.kernel.org
Reported-by: Sun Yangkai <sunyangkai@fygo.io>
Link: https://github.com/chencheng-fnnas/reproducer/blob/main/dm-integrity-writeback-race.py
Signed-off-by: Chen Cheng <chencheng@fnnas.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ sashal: Replaced BLK_FEAT_STABLE_WRITES with a needs_stable_writes target bit propagated to QUEUE_FLAG_STABLE_WRITES. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c     | 3 +++
 drivers/md/dm-table.c         | 2 +-
 include/linux/device-mapper.h | 5 +++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index f552c402b3c17..4fcd7d821568f 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3503,6 +3503,9 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
 		limits->dma_alignment = limits->logical_block_size - 1;
 	}
+
+	if (ic->internal_hash && (ic->mode == 'D' || ic->mode == 'B'))
+		ti->needs_stable_writes = true;
 }
 
 static void calculate_journal_section_size(struct dm_integrity_c *ic)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 8e0b9783f3da3..214a7af330f89 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1941,7 +1941,7 @@ static int device_requires_stable_pages(struct dm_target *ti,
 					struct dm_dev *dev, sector_t start,
 					sector_t len, void *data)
 {
-	return bdev_stable_writes(dev->bdev);
+	return ti->needs_stable_writes || bdev_stable_writes(dev->bdev);
 }
 
 int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 9505674dc883d..bda8f373c91b6 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -357,6 +357,11 @@ struct dm_target {
 	 */
 	bool discards_supported:1;
 
+	/*
+	 * Set if this target requires stable data during writeback.
+	 */
+	bool needs_stable_writes:1;
+
 	/*
 	 * Set if we need to limit the number of in-flight bios when swapping.
 	 */
-- 
2.53.0

