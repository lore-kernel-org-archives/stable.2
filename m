Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E108493628
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067336; cv=none; b=OL5KkSEGAbpGUXsYKDZ2bXNOFed3jRvqa6ElJNBxo1MsxuSHt2KJydDWscUw718OHcjvb2og/wJzg6RkpvsRy4vqalDm14b+MUEjqyWUAXfsQlQM0f6MSd0jbImJAHNyddIDhLu/pwE3xZc3V0S2O5OcaSloOLSugEdiHNHqqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067336; c=relaxed/simple;
	bh=xEETmcSeoWeLwDY6CaxH9M5e69yeGVvuTxAW68tXLqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYV33LR6I87/dIkB/NJk1xvWpTAvxI3tC54CCjepNp05hlsiGr3AWLlx+6jrntfNbIQqsxY5PQ02pVOC23KCrE99DKqQdoaEWtWAVOpEniFoSW6LvoF0LJm6yCA2sTaTGH0XNLgc0bPlfWQYJsGG3wuWqCpT4ZalVEl4Nyu+7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/z8f7z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/z8f7z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E431F000FF;
	Thu, 10 Sep 2026 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067334;
	bh=w/5q/z4sKGelOAe1hKfHUw1iW3kRV7Y24JzBvXfAjTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/z8f7z9r+SFG01dqunJcx7B/DJxT6yl1aZL0/tPJIJtH8nHHAipY4dTe848MLxi/
	 sJgwUjOSeW+r+x8CdWkwaHaYMfaJ9y3FP+Eg9Gec5cQUjyLzUS5xBR7O/kIeOgFVRH
	 IrqGG+rMRWWeTXmlSb3G+sqStS+JMz8ICDq7gX2C711OXqYLnPpML0CaDnGGQZOWAX
	 Dxt29//OhKRmy7NtHi1KYgEXGjLgPXJOrtm2JE1Wi+FbqjZLTcpRY0bYlMk1SGErIx
	 TtLqMt2g9oC1zxgWqJoA/NFVNnCsAU8SC+HNTi6yy1ssVxfauT5G61QwZ27P+7nYZV
	 nl34mhx0fH0UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 7/7] block: flag zoned disks with GENHD_FL_NO_PART
Date: Thu, 10 Sep 2026 15:08:46 -0400
Message-ID: <20260910190846.1453814-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190846.1453814-1-sashal@kernel.org>
References: <2026090834-voyage-donut-60bd@gregkh>
 <20260910190846.1453814-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 3f9c7a108c0e8f14425384912017071b71341e3b ]

Zoned block devices do not support partitions. However, the partition
table is nevertheless still inspected, and any partition found ignored
with a warning in add_partition(). While this is generally not a problem,
and in fact beneficial to the user as it indicates an invalid use of a
zoned block device, scanning for a partition table on the device may
result in issuing read operations to offline zones (e.g. after a disk head
is depopulated for disks that support head management operations).

Since partitions are ignored anyway, completely disable partition scanning
for zoned gendisks by setting the flag GENHD_FL_NO_PART in __add_disk().
The existing check in add_partition() is left as-is to ensure that we
still get a warning if for whatever reason, despite GENHD_FL_NO_PART, we
still endup trying to add partitions.

Flagging zoned disks with GENHD_FL_NO_PART also has the benefit to expose
through sysfs the ext_range attribute with the value of 1 instead of the
default DISK_MAX_PARTS, thus correctly advertizing the fact that zoned
disks do not support partitions.

Fixes: 5eac3eb30c9a ("block: Remove partition support for zoned block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://patch.msgid.link/20260831025050.667758-1-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index ea81203f6a036..976d2d77a1e0f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -721,6 +721,13 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	if (register_queue)
 		elevator_init_mq(disk->queue);
 
+	/*
+	 * We do not support partitions with zoned block devices, so do not try
+	 * to scan the partitions table.
+	 */
+	if (blk_queue_is_zoned(disk->queue))
+		disk->flags |= GENHD_FL_NO_PART;
+
 	/*
 	 * If the driver provides an explicit major number it also must provide
 	 * the number of minors numbers supported, and those will be used to
-- 
2.53.0

