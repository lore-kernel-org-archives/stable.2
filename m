Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706623;
	b=MyUGeWr98S/4KM6xX9qlsxS8H0/OdlDI71Vd/4uP7vm6fJ103ar1kfQBs6brxqwZrZof
	 j2+jVyC6j9aBLB9dUHwi9WHvuK3Hgh51jKYydca4BeihhEv89gvmtM0G2ioN3Yo8SWrIz
	 NCgKlW5it+wuKF6KL3pO3kVhalv662FEcKCsShOO7eDxg3wW4jFgC/tmpvQ+s3anqgJgr
	 qHvB6YwIHEhXqn1x+OmrX+XFJAOUeWLyQX0Ls06UhYp0qzHv/N83GeO1SNamTWoVg6B/S
	 yEVoXeUZfDS8avndeLePWhUuapDdLjomMMFB4CmZ6vdzVrxKmEiUj2oqZjyj1yEq0HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1S6R8LSmeWOqvKVa270AtH5Yi4ch6wmru1fxTCrkosM=;
	b=Qj2zWEO7c9/mAtqv8lEPzCpHEF6M0ZpEa9daMH4pGW7WC3NvBcIb+UaLmVKXiifotkN9
	 Fo7f5D5uIxlYFKoZ7q5R0/aPOmKcqBoWPle8De/+zM6xPS+7fyCw6gvLzhFLOkRvS4KB7
	 4FWr0dtsoZ8rVbKYG7jEH1WIafIsheSLTOXvk5rT9ILC0NUVrQEbE+F9oas/NeCUO6Gd1
	 xyIgxA1pKF6Cy0dHP0cGdx6Iayp2zqKTH0LCyvbIGgRjOsHzE9HdxSoCcGzY6wRgmTmxv
	 kDVEoekT3wXUfCdHQEmQQadm29Y6oIzduZZAj0G8ctbiQfLcCflie3hzWjbxOMthdxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr+5IufZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56D606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr+5IufZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6277E1F01825;
	Thu, 22 Oct 2026 22:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706622;
	bh=1S6R8LSmeWOqvKVa270AtH5Yi4ch6wmru1fxTCrkosM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jr+5IufZTbLSCAANpQOp3hqvS6xi9+/5U0Qrv/4YZalPIIw5cpVyzgeYMiAylhjE2
	 CfnOUf0y0oJw+WFq3N/yjNTmYGILtRAFnvggBErEJ5tm2tx4g/68PSP2JlrVoWRNOh
	 bsru9hW8jQhB1j1akG4lAugv9TlDBidncnTV3shvLusT1jJrCY6ki/qNToeioFJblr
	 EAr7ogThLWnXGmCfulqJ2qucq3KyRDjZylcwIk1QKnQa9cN+lQk0bnlJJ09FKzxh+h
	 5SG9yR8k3VCP1EVPul9rKcO9/uVR4j6SotQQIMURnOw/O9/N7gP59hAFBPNSDO/Nk9
	 8Kmcq9x4ObjVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Cheng <chencheng@fnnas.com>,
	Sun Yangkai <sunyangkai@fygo.io>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm-integrity: require stable writes for internal hash modes
Date: Thu, 22 Oct 2026 18:03:39 -0400
Message-ID: <20261022220232.1914378-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102133-blunderer-mothball-bd53@gregkh>
References: <2026102133-blunderer-mothball-bd53@gregkh>
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
[ sashal: Replaced BLK_FEAT_STABLE_WRITES with a per-target needs_stable_writes bit propagated through the existing queue-flag machinery. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c     | 3 +++
 drivers/md/dm-table.c         | 2 +-
 include/linux/device-mapper.h | 5 +++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index eb13b98ba0a9c..c889457c3b330 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3219,6 +3219,9 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		limits->physical_block_size = ic->sectors_per_block << SECTOR_SHIFT;
 		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
 	}
+
+	if (ic->internal_hash && (ic->mode == 'D' || ic->mode == 'B'))
+		ti->needs_stable_writes = true;
 }
 
 static void calculate_journal_section_size(struct dm_integrity_c *ic)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 4351de47fa775..f78979cc5baec 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1799,7 +1799,7 @@ static int device_requires_stable_pages(struct dm_target *ti,
 {
 	struct request_queue *q = bdev_get_queue(dev->bdev);
 
-	return q && blk_queue_stable_writes(q);
+	return ti->needs_stable_writes || (q && blk_queue_stable_writes(q));
 }
 
 void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 50cc070cb1f7c..bb50f631b0e91 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -339,6 +339,11 @@ struct dm_target {
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

