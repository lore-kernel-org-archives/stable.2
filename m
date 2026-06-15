Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CE353EC0;
	Mon, 15 Jun 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528848; cv=none; b=LfPtG2ZfRe5t8Ye8hJPFBZXsslXnACgLTwwaFo9QMFP63K8JZ/9Guzr0cnCWHiRJT7PbO18nPRWpHvv5oEsd12CbfoT4Ws2bG4PZDhr+tsls9xZ+pG67LajPAxWgYxN5Rgr0k5U/2byjTDgDAIY1n1V6V7x4uegHzGbFIDnzfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528848; c=relaxed/simple;
	bh=OEZiHIIE9ZX02seRqu2Yy/X8d5oWjiuZLrGCD33SD/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdQDcVzVCsrzTzGkMA33F3mPng/lvUZNkoPfouVzJGnxX/b4bqnwOPRpibrx9jQDo3nNw2WMLEnVuIR5rXBt2ePIwojepBDB31bDluYt62w9yQiFt9cI6gHm90DBjVQjd0MlYy/j70C++E9nHWxOAll7dlcrpbGfj7NlKil8k28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=aFqQbDpM; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="aFqQbDpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781528847; x=1813064847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nhr6SuT2FEDobG6OCE/2kYZvgYlb8rGVuwF+ofYdc2A=;
  b=aFqQbDpM9c7VTGXdsJc1bBniyS9ExJ27qpt3kKgR3At6p8jf7USFcMwL
   oWk9w4xzqh47T/WdG1IAtjemJQLKkMjH+Fx+k8kxMXJnOl+aCNBjY40Rb
   ULu4kRX90G1Z+l6kimW8YFy3wV9CUpWEFZFI4lAsAvO/dK/N6f0K4yJ29
   JA4r5p9a3GXjxTLKwcNQNZMnvEWPg1swM37l0XNSBYKpA/PhLAFRBo2Hs
   vjbDKyNFeq9tXFYMWSqc3q0QNxyu4exA+i2Jp8diprX6OjbdFac6j6hqx
   pcFKu0TerLjKYjITeYxAaJIYxRP0ZdjlWCckoDP2Q1PIFqPeZD5RDatf5
   Q==;
X-CSE-ConnectionGUID: FOOgvbopSX6M9m77WNzVzg==
X-CSE-MsgGUID: ZtFaur2iRae9EEkxMPDqjA==
X-IronPort-AV: E=Sophos;i="6.24,206,1774310400"; 
   d="scan'208";a="21547809"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 13:07:24 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:15341]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.234:2525] with esmtp (Farcaster)
 id 2d1f6771-3b89-456b-9a62-54bab84b91af; Mon, 15 Jun 2026 13:07:23 +0000 (UTC)
X-Farcaster-Flow-ID: 2d1f6771-3b89-456b-9a62-54bab84b91af
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 15 Jun 2026 13:07:23 +0000
Received: from dev-dsk-connordw-1a-43da851f.eu-west-1.amazon.com
 (172.19.98.255) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 15 Jun 2026
 13:07:21 +0000
From: Connor Williamson <connordw@amazon.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <yukuai3@huawei.com>, <hch@lst.de>, <jack@suse.cz>,
	<nh-open-source@amazon.com>, <connordw@amazon.com>
Subject: [PATCH] block: remove redundant GD_NEED_PART_SCAN in add_disk_final()
Date: Mon, 15 Jun 2026 13:07:15 +0000
Message-ID: <20260615130715.53693-1-connordw@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

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
---
 block/genhd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7d6854fd28e95..0da6cdf3d5fb0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -407,10 +407,6 @@ static void add_disk_final(struct gendisk *disk)
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
2.47.3

