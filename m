Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696241;
	b=Uue6Bz5YAOkruigLktYYV3UydF/L2VuoWleX3r29/nLI6dfB+bGVfo50A4fb1LAUu8og
	 2RCyMmW4k5ztk3JFyB/AfG5CIGoaWzjkn6aKPaoAIq8UfLeG3OY8RMDwNByT4xYFe5+H0
	 55UQ2Dg8quUkK4xRvjRD6Q0747slAewM23l0Z7g7Re6Lf0Z5HNX8a/Lg0F22naV+vVUXX
	 SoNSZBWuHPzQKvRi0PjP2M8HpFGgevIuT8gP/P2K8DyA/9MJPW9vJBm4lb6j1LxlJNq9E
	 jQ4y0B6delIJhtFKhaNDp8xMqQ7ble8QG+riWNnWUUOu55sUmmVLGxUXYyng2Y8O+BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696241;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8NfgQtcjv8pFU3J0tAYhKimA+pFmhoMcXL9r3SHXtXI=;
	b=F/SQSzvim74tdr4CH69vY2ddhLgbykKGcONHssjHwfD7BedutptAKXoMVTPnO1h5FLlV
	 nQNjRXwopIYxw6DJiMin89WUzDeodaJuAqanmQkHphrqFtIgChkVc+lYMIiv3KvwpjqAk
	 JUMQO1ToKhCzpep3RQTccRJLLKHT/4sKUgay1zdCHtrDXFv8aH3CWqz5fkD/eIPHHCUMR
	 XgF/b2rhxuYz4XX6+6b/veUGVxquJSUDk70gMbZYH1P1aALdWLjO59SCRL1b8YpwrrVBv
	 i/g8hQ/etsfCrHQVGf7ROe2q/rCwf2zzQCfRhZXdcEboby6DfiRoQLBMBFfTBtBwkIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sfki/SF1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD07606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sfki/SF1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465501F01825;
	Thu, 22 Oct 2026 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696241;
	bh=8NfgQtcjv8pFU3J0tAYhKimA+pFmhoMcXL9r3SHXtXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sfki/SF1d8JRKWGawx6fgYdH/L6yGVW+9ZZQM5jvVE8RMC9eIJrIJpaKoh7iBGra4
	 ZN6EEBgCi2H+cjbOUHT+F05ANrJb0azbjYPJn0lB4HmxJtravGYv6t2/5QaHbgrnYx
	 uI47ZT34iTLVDbRvh7hNaYwYozPF+N8a3tLGdyzNMnW883pMwp+reDHMOrRh0TJZzb
	 JF7JcNXwhI86jrfOWiJRvY/Fu07hZmdfGgm6VwxQfGt99q5ESjWs/NpsQWYKei74bd
	 5kceBQyPpuecYi0b1I9a2I4NmMMbDOQ1WNHhWR/ZRdr07TxBoXAb3QxXL8RVVCYP5+
	 2WEZO7SiDsa7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Cheng <chencheng@fnnas.com>,
	Sun Yangkai <sunyangkai@fygo.io>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm-integrity: require stable writes for internal hash modes
Date: Thu, 22 Oct 2026 15:10:38 -0400
Message-ID: <20261022190948.1747823-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102132-emperor-geiger-a973@gregkh>
References: <2026102132-emperor-geiger-a973@gregkh>
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
[ sashal: Adapted BLK_FEAT_STABLE_WRITES to QUEUE_FLAG_STABLE_WRITES through a new target flag. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c     | 3 +++
 drivers/md/dm-table.c         | 2 +-
 include/linux/device-mapper.h | 5 +++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index cebffb0b5a1af..7e8b5361c64c6 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3360,6 +3360,9 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		limits->physical_block_size = ic->sectors_per_block << SECTOR_SHIFT;
 		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
 	}
+
+	if (ic->internal_hash && (ic->mode == 'D' || ic->mode == 'B'))
+		ti->needs_stable_writes = true;
 }
 
 static void calculate_journal_section_size(struct dm_integrity_c *ic)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0f815bcf751f1..b9fe92337b36f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1974,7 +1974,7 @@ static int device_requires_stable_pages(struct dm_target *ti,
 {
 	struct request_queue *q = bdev_get_queue(dev->bdev);
 
-	return blk_queue_stable_writes(q);
+	return ti->needs_stable_writes || blk_queue_stable_writes(q);
 }
 
 int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 114553b487ef4..3cd473e166a81 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -356,6 +356,11 @@ struct dm_target {
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

