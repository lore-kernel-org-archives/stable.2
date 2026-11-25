Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642378;
	b=bDdNShjvH97BFIES/OW/Aqj4V3a9rzXTxfcinmvWdw1tKjXN0mu7NUKpy025Ea75TYn1
	 duH8ollOrYVrkCp+9K1DcHYYTJ+32sAMDUZ3Vz0WptVAmPZk/vEpv0AhGNfcmCB/HVYHl
	 rLX6tWnErBPVIrQN+Mep1itonwGVK2NggEas0hv+YQ+45kojgXpmGPCtgsfp1zx5HnWNG
	 jmVkUIBwNHbdrOQVbX0SHEO46JKoRTrrohtnUUqHU3LU+xDneCFTMud0KK/QSx0eWhbbu
	 rEcjcWLFTDcH/ULOuB71hEfzGrT9AdQj2zkvld2DjNDvtXrNpq+BXhktHlj2QI8lKGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642378;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=a7+BjRN+OwM2aWHnIdQ7mz3M5LbLYTWsdbqNtP+Bp3g=;
	b=B4br0Kz2Xul6B9s7KiItoHj3lOFMceJ9ycIJJVBhdSpDzbXCsJ4IPTcbE124ZSgXhA9W
	 7x6EJRB49xEZab15riXmUTk88fQBBCb0Clxb8MzSY0YH3KEvfy3UwgToSb5F3RfHoTOTz
	 PAZ9ZHfB0WYUlXhZo4Q0V3bb4vEjvJuZxeXNETe8NK5XEtdVy2of961gENwNTIF0qoAA9
	 r2TPdRJFd0W4hXUNswn945AIzosfnMO7LgLEQ2j5X7pOc9HXHMxs7fTmj/kPaxqUI+gGQ
	 u3Xho26hkwjQr2Pe08IbCIZMq6C2ytkkgZG0vg6TfuoKw2vKi0ksAKLmnb36wRzkT9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=BTfCqddH;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36423606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36423606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=BTfCqddH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795642378; x=1827178378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a7+BjRN+OwM2aWHnIdQ7mz3M5LbLYTWsdbqNtP+Bp3g=;
  b=BTfCqddHgAqkmtbmQEALLQ37QS8hUoHuy5L5MQqD7Oky3ZNbcyw7zHlE
   v18+Uny7zCK8q+4KVbpyu0xaSd5mKnqL5ijeOHfHXCUT7nLnB4SFpN6AD
   sJodZnzJB/qU+0Sr+rH5bf+Q1jwMUPSKNsbQXODfFb4w/W48KZsF+D+CF
   C+69FV/vYO2cS9AlyXTrW6VnY5XTXJYKMSIVBIDTgZl3Abxlz5R/7kNXk
   0PVVYRsaIdZ63nKwyN76i/KO8/gz5Wb9Hx3Z2nP2NtLcvEsfdt4tD+mOd
   siIOTVBUf37Y6szaWrOKbI3gOq22x1eKIMy6DBuiE0ldwhkjmP8aFxzfx
   w==;
X-CSE-ConnectionGUID: qUYU2gi7R16o0fV4IYujzA==
X-CSE-MsgGUID: emXEBulYTZKRpDF7VYJUYA==
X-IronPort-AV: E=Sophos;i="6.27,233,1787011200"; 
   d="scan'208";a="35127793"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 21:32:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:30296]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.222:2525] with esmtp (Farcaster)
 id bb9d12e4-ff26-4b09-889a-8439708a51a1; Wed, 25 Nov 2026 21:32:57 +0000 (UTC)
X-Farcaster-Flow-ID: bb9d12e4-ff26-4b09-889a-8439708a51a1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:32:57 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:32:57 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>, Mikulas Patocka <mpatocka@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 5.10.y] dm: fix infinite loop in dm_blk_do_report_zones()
Date: Wed, 25 Nov 2026 21:32:45 +0000
Message-ID: <20261125213245.1369652-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026112529-pulsate-grass-2146@gregkh>
References: <2026112529-pulsate-grass-2146@gregkh>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

[ Upstream commit 648320de920b30ae1730bbf0e8b86c0df0fb490a ]

If the device underlying a zoned target is removed, its capacity is set
to 0 and blkdev_report_zones() returns 0 without reporting any zones.
The mapped device keeps its old capacity, so args->zone_idx and
args->next_sector never advance and dm_blk_do_report_zones() loops
forever. On non-preemptible kernels this causes soft lockups and RCU
stalls.

The following sequence of commands triggers the hang:

modprobe scsi_debug zbc=managed dev_size_mb=1024 zone_size_mb=64
udevadm settle
echo '0 2097152 linear /dev/sda 0' | dmsetup create lin
echo 1 > /sys/block/sda/device/delete
blkzone report -o 0 -c 1 /dev/mapper/lin

Fix this by returning -EIO when a target reports no zones. The target
always maps args->next_sector, so a zero return means the underlying
device no longer covers that sector.

Fixes: d41003513e61 ("block: rework zone reporting")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
[ - fdb9aed869f3 ("block: introduce disk_report_zone()") is not
    backported because it reworks the zone report API across 16 files of
    block and drivers, so the check goes into the local args struct loop
    of this branch.
  - bb37d77239af ("dm: introduce zone append emulation") is not
    backported because it adds zone append emulation and splits out the
    report loop, so the -EIO path uses goto out to drop the live table
    reference.
  - Context differs due to commit: 7fc18728482b ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 drivers/md/dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1a6bf13cea9b..a42b555633cc 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -459,6 +459,10 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 					      nr_zones - args.zone_idx);
 		if (ret < 0)
 			goto out;
+		if (!ret) {
+			ret = -EIO;
+			goto out;
+		}
 	} while (args.zone_idx < nr_zones &&
 		 args.next_sector < get_capacity(disk));
 

base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
-- 
2.50.1

