Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B7241D217
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167973; cv=none; b=l33BbxpUkURYa8vz8UoAIE+Z6Q2kwEdxcXnhUK2+YT+17QO35G9LU4Dy86N5N7fcwlpYDEGkRY5W0VGm+AfyTqIgV6RVAP6stRzAla4tpxZ7HbQ0T2WJoMfxT8570Mqd5m8/nuIvdb6wja9iJq7vi095QxvCzOVZyrLIXT6hMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167973; c=relaxed/simple;
	bh=VLu7NiabdoD6B01491oUWB3h/xoUVOW8YDqut0LArLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ta0o3IL9juv5pXMXrHYs2th8Nim1rDsg8l/4cBkyk2qOP8YD1z4gc88h0/9YFhd9UlSZqP5aliHQXLwVd6X2KJ2GWwsp+C/CuJW0k8dEmg9/6bnhz7YRZRDuuJKPyEZ2vmzyhAmlYWeVTCk23xApvHW73IdE8O8nrWd16CJOQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITyaXuXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITyaXuXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0661F00A3A;
	Mon, 27 Jul 2026 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167971;
	bh=zy0mduEgNZI83u5h/PvieRN+IwN1SzT1oFSsit42RUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ITyaXuXOKn3nfcmW5CoKaW/XWaiOAobziHTsOgoRsS/QWyPauIN4XT67h0x/+QcTj
	 9ritCuszsrVsLDPRqHlPJDv/uoZ6CS7gJYm/qDcxbYExpvV9WL4R+uM1o8iK/y4MEG
	 PIfonQhrIU3/DLPrX//eTLt21O8TGSThzbc7yVAkcitZ33GT6Kwi4eqr61uazVn7JM
	 PKVT+D/PKOaRcgHGl/X7a2kxvtQgCG/87xrOCGNasdoQIa5PBkOS/vZqw9s7Iu46er
	 OhscD8mNohzNoRQ6Ki5kdCOx/UDuAK/MAs1gVjx1GG9m9OOJK3tW6eUVa8Qop3Oqma
	 psFFuPjKXzt2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Connor Williamson <connordw@amazon.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] block: remove redundant GD_NEED_PART_SCAN in add_disk_final()
Date: Mon, 27 Jul 2026 11:59:28 -0400
Message-ID: <20260727155928.1732187-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727155928.1732187-1-sashal@kernel.org>
References: <2026072021-refurnish-abdomen-0f40@gregkh>
 <20260727155928.1732187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Connor Williamson <connordw@amazon.com>

[ Upstream commit 181bb9c9eae4f69fe510a62a42c2932d0314a800 ]

add_disk_final() sets GD_NEED_PART_SCAN before calling bdev_add(),
then calls disk_scan_partitions() which sets the flag itself. The
early set is redundant and introduces a race.

Between bdev_add() and disk_scan_partitions(), concurrent openers
(multipathd, blkid, LVM) see the flag in blkdev_get_whole() and
trigger bdev_disk_changed(). When disk_scan_partitions() then runs,
it calls bdev_disk_changed() again, dropping the partitions the
concurrent opener already created before re-adding them, which can
result in transient partition disappearances.

The race is observable by inserting an msleep() between bdev_add()
and disk_scan_partitions() while running concurrent open() calls
during device bind. Without artificial delay, it manifests under
scheduling pressure during boot on systems with aggressive device
scanners (multipathd, systemd-udevd).

Therefore, do not set GD_NEED_PART_SCAN in add_disk_final(). Other
GD_NEED_PART_SCAN consumers (blkdev_get_whole(),
sd_need_revalidate()) should not be affected as the flag
is set internally by disk_scan_partitions().

The retry-on-next-open intention from commit e5cfefa97bcc
("block: fix scan partition for exclusively open device again")
should also not be affected as the early return paths in
disk_scan_partitions() should be unreachable at device registration
time (bd_holder is NULL and open_partitions is zero).

Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
Cc: stable@vger.kernel.org
Signed-off-by: Connor Williamson <connordw@amazon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260615130715.53693-1-connordw@amazon.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c6cf86d3e182c1..31e1539e6e6aa0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -387,10 +387,6 @@ static void add_disk_final(struct gendisk *disk)
 	struct device *ddev = disk_to_dev(disk);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
-		/* Make sure the first partition scan will be proceed */
-		if (get_capacity(disk) && disk_has_partscan(disk))
-			set_bit(GD_NEED_PART_SCAN, &disk->state);
-
 		bdev_add(disk->part0, ddev->devt);
 		if (get_capacity(disk))
 			disk_scan_partitions(disk, BLK_OPEN_READ);
-- 
2.53.0

