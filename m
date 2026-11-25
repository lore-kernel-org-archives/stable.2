Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642338;
	b=VmQZ0EImiw6w3tO8pnmbc9jAf7fzoyuoRTVU2gW3p+OfhDGN32M4zATCP8SaoZIGiHjb
	 EU08cvwP+IsigBfo2u583c064ejvqO1WBc+qY3F4ozeEFZpOTbZmWRjNs1y4K0OK1JbCL
	 q9gSRRiMwNV2QsSOfvPeK7iGzrst2Yy+7jZwBJL/6Dy/tEpVYGazPIsYTrdqWKONVzSlc
	 Xs5/qm74j7nlNvPMTPN83kjUN7yp5Sem9IrawQZ4vA2RfZ9Uq05Gb72xrTgqxtPbBOeQE
	 cXwe8hfJglftnmgqJFUI/lodQmQwk77k+ByMsFNpKqOVCt8DIsPNyiH3SZqIXqlACyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642338;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=66tlmzwQiin6/1zTd9X5emJzeiUp2bshYtjx8X/UNDc=;
	b=x24IPow2eXycI5iT2TQ+vnB+IX9pHEgcTVayvqlOiaoB5sjDWZUvEjCxxOgaMiXYVdU7
	 Ytlx5GJMRs2y2hJR1W3zHt1NxBzrs/MjyOWFNwMLragPI7QzD0cYh7T98rmUSKaVMYTyT
	 5yIkBUBCQQKK3HbSqqjhmV/QIsU9uZcIAgYBLxLtV2RwyfEbSDzwhDPBjrw3e+8XHNDHD
	 VDfmcQ4YHXwzKCOEFKtyHxqA5MfnzjO/+J7nmn2SxpIZF66m17A+zCEjPsKeUkKThf86X
	 xAJC33JtwtvQic+ug8z5ghU7/RLB7PM1I3JKT3CRiM/UMyK3wirdb7Cj1kDrQLCiyZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=XRbYMbnO;
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F749606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F749606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=XRbYMbnO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795642338; x=1827178338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=66tlmzwQiin6/1zTd9X5emJzeiUp2bshYtjx8X/UNDc=;
  b=XRbYMbnOEZunNwgJlLuwkY+rjx9b8ZbWyTWspvTownygv520wSVMIgrc
   2W1e1zdRnkMYq0uVN0fVy2RPtluOMyaRrjboHmyP/I4wqdiGXSqHm+IvG
   PawYsHBuJfI3otmYNiC824cJiHYoRBUyNZBAGigUVok4ed8cBfgW7MqKS
   T4q4kPvNOiI4XKFBqjNFnbAsg4OlMgBvccQM9X9h7yuTifyaV+vpFNZlR
   5QFdP/ybCtLMuwMIwlPMNHdxEKaSNc0F4+JVKxGlqGrU0c8W6bIMolU4x
   Zfw5Gk0xf0S4bz9xLuZDiyQezSww4vfhFLH0+7gKGF8EqkY9fTWJfdXw4
   Q==;
X-CSE-ConnectionGUID: a7tTuBfuQV+uD8RTiuLHPg==
X-CSE-MsgGUID: c8Jm0KL1RTG1gVaaTaPUcw==
X-IronPort-AV: E=Sophos;i="6.27,233,1787011200"; 
   d="scan'208";a="34868612"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 21:32:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:23175]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.177:2525] with esmtp (Farcaster)
 id a6dd08fe-0634-4107-b4cb-565c63ef3610; Wed, 25 Nov 2026 21:32:17 +0000 (UTC)
X-Farcaster-Flow-ID: a6dd08fe-0634-4107-b4cb-565c63ef3610
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:32:17 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:32:17 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>, Mikulas Patocka <mpatocka@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.1.y] dm: fix infinite loop in dm_blk_do_report_zones()
Date: Wed, 25 Nov 2026 21:32:05 +0000
Message-ID: <20261125213205.1362831-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026112528-skipper-aware-9168@gregkh>
References: <2026112528-skipper-aware-9168@gregkh>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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
[ Context differs due to commit: fdb9aed869f3 ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 drivers/md/dm-zone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3dafc0e8b7a9..354987f9e3ff 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -41,6 +41,8 @@ static int dm_blk_do_report_zones(struct mapped_device *md, struct dm_table *t,
 					      nr_zones - args.zone_idx);
 		if (ret < 0)
 			return ret;
+		if (!ret)
+			return -EIO;
 	} while (args.zone_idx < nr_zones &&
 		 args.next_sector < get_capacity(disk));
 

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.50.1

