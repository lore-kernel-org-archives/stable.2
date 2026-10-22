Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680567;
	b=5smpKpFuF/NrbSvYpVupw7qgcT4bng06DR+pUADgtfvQrV1NBJzYLXc2zHVN6ckwgD1w
	 Gtuz/6QdwWaySaMhQjh4C8AvLHZ+NjKfp0i/3q8Nbj/YR8pxJ/HD3RXJNw1giczXZmINN
	 1rcAfvz7bW419+Ds6ihdI2dQN6StnlrCVzP7gWAbpcFLGasObOZSJaesYQDYJsKmVqfBh
	 pPxY3H1mzLxT614TJ7If0JM/02UNpsiHoJxY3/gam3xGpvNV2MLbRDH2SqlP7YfJZFmFy
	 E9wPJDJ68qAVVZ/SJD/OrScXhfiwBDPz4bdVQ2FqFbks83aEwMtmafPWfks7qX0Hf8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sEzQZiJoxeCTlrlV3Z1uO4h4G4KuAplPfjjRlWGMGrY=;
	b=HZne5987qPdCqf4G6b5uLRF2/pizjhOZw6aM49yndJb0Ey1psXbN5oVOARutZz867b5G
	 e8CWSYC4yNaPg3JGlpC53Qu9VwNpzJIXWhadpm0nrYmYuMLX993Brn7GOoo+ia3ctmZVy
	 M6eu8WoNR8/ytJBEerIA7IeWm6Ls+uls7YHarPZd6DPbZwU3nL2P/SGsCFiiKc0FcBcfE
	 Mtt8wkkpTsONeyQlQo3z8Qul16ZUAkoFkMgEZG8m1ArUgCSnv5R8Nbp7iRNWG3mONDJ8M
	 +T1XZ844zI4q40PLO724grFUXQP6ApJUFXKZueM8Us0pUlMPbIkDnhQjlJcaXXmjsZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/rXgimu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5A60A4AC1
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/rXgimu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E271F000C1;
	Thu, 22 Oct 2026 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680566;
	bh=sEzQZiJoxeCTlrlV3Z1uO4h4G4KuAplPfjjRlWGMGrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/rXgimu5Mf7MWGVzE8PxO/goePCbhFsqrqKrUD4onmGqaMdLUcQeRc7/+GVGeEP0
	 o2jVOw+VnXv+n8KRZ7MnKRSJZ6jHXibLD+R1DzegY1FiDHKGB0olGjpCKZYgef1UxB
	 3ZAwGx/jTUEv7CnTp8eJpvY1LIilsX+/Z//ZN3abllB2ubZ/rHsnP6yqFfbbIKedBt
	 4uazJtULtoPzxF7hJcclTpikAD9HDMXV7BHQbdnu+kkvB/ZTSkrdGjxZGBO94H2I4C
	 gWdnaqwpya4tXx5B/BARRLryL0aSJ5iVsGV2LhAIeGrtFx/rfnF7Tt85IsIA8hmKy1
	 z3lgJMwBJOghA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Cheng <chencheng@fnnas.com>,
	Sun Yangkai <sunyangkai@fygo.io>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm-integrity: require stable writes for internal hash modes
Date: Thu, 22 Oct 2026 10:49:24 -0400
Message-ID: <20261022144857.1586944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102131-plutonium-matriarch-1617@gregkh>
References: <2026102131-plutonium-matriarch-1617@gregkh>
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
[ sashal: adapted BLK_FEAT_STABLE_WRITES to QUEUE_FLAG_STABLE_WRITES using a new needs_stable_writes target bit. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c     | 3 +++
 drivers/md/dm-table.c         | 2 +-
 include/linux/device-mapper.h | 5 +++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index aa6f3e71c4fa2..d66eb4e36811a 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3515,6 +3515,9 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		limits->io_min = ic->sectors_per_block << SECTOR_SHIFT;
 		limits->dma_alignment = limits->logical_block_size - 1;
 	}
+
+	if (ic->internal_hash && (ic->mode == 'D' || ic->mode == 'B'))
+		ti->needs_stable_writes = true;
 }
 
 static void calculate_journal_section_size(struct dm_integrity_c *ic)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ed0a5e91968df..6d4ce9790a564 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1944,7 +1944,7 @@ static int device_requires_stable_pages(struct dm_target *ti,
 					struct dm_dev *dev, sector_t start,
 					sector_t len, void *data)
 {
-	return bdev_stable_writes(dev->bdev);
+	return ti->needs_stable_writes || bdev_stable_writes(dev->bdev);
 }
 
 int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 69d0435c7ebb0..f61daeeecee69 100644
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
 	 * Set if this target requires that discards be split on
 	 * 'max_discard_sectors' boundaries.
-- 
2.53.0

