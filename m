Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641982;
	b=D5KEJJ79gZDwTzb1k4BygVx9StZrvgWrgLYR4Udxmw9ewHl8mChx9YU+9ZT3BgXXBw8Y
	 Nfdal/99deWXiVmBSEf9Z00zJNYO1nt2Hsiz9CMtqppchdnx6IlJqnrir6VcoJ2Ssn8Nf
	 DUCNwmHiO2wOiDGqfQ/yUQjU+XyL1DVKiywj+hegohXr5Kf5N5Gd08M18Fevd2euVw+z1
	 OmL6ptSsX/cwXzVm0zpOMa64qwGqVCj1FwkOdu2UZVCH0mltO9ThJdXoLfdouQoeOwjzp
	 Oz9fl3i3pBlvyhZvExEjfqsgS+mHoJ5WELfog5GcTVWvamLYvDfBuGwMgYoy2yImjCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641982;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=FZCkABtY/FsFKa9QHIfV/JpFP1d2Ro7SIkT3NNflMMY=;
	b=NhWYnKTOzjgXcRGcjFS77ZpeRtbXvZ58PuA7AEf8sFu4hya98MchU8m1jL5XLgFXKoT/
	 v2C3Gudixj3clIFzQHT02SCq8YkoaUIP4uKxeVTwmFwC3H9RB6701ojQdKaJhs9OsMK1t
	 QuZNfBPQsfeLXHdDS6YguJXJOVr0/zO1l3jY8K8jDEnK+1GdFoYPgMWMsq0/k+84/3GzI
	 QQzauTqNKtd3ry7tQ8B5OjCxUHnhMHcA3bAFUcVsx7xIUTJy+5BCXPM4rc2djvL1+51GY
	 Ayf2WkyGgrzUtmeO72oQGDvVptTy9yxszslxE0wo0oPOwN1W3T/F6N5Irz4PEQm+zbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HFJmGQcH;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A0E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HFJmGQcH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795641982; x=1827177982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FZCkABtY/FsFKa9QHIfV/JpFP1d2Ro7SIkT3NNflMMY=;
  b=HFJmGQcHgx7JUjFPk3Bz8m+JiCuoZViWKi2s7d/yL5bpm8hzoqTU04gw
   yrvy0Fy89A2Ig0xpK/n9lSxKkxjO6hg8buqZgJXH69ppnlq0ollwLTDsS
   wWQsKScuVgTEKdqegg1h11BGb1XkuvJqlPZCaqgg1q9txuyPb3sB5szD0
   DVUqz5xaZpZinjMULVVRyWC3lZ4suJsAp9UwXG2BR1H2ku+ZLwKeD9h47
   JGyaEzNJsLLiquVAlodB/Nm33mL5D7xiW3IZC6c9g0aLgMussadFkJfZl
   aHI/wOz1SufA7dNf6D1BzpqSqlEZE8lV9RBZ9u/+50qqNmlAk6CKJC/I9
   g==;
X-CSE-ConnectionGUID: fEbWBRTrSAGNi1OxCR/Now==
X-CSE-MsgGUID: VAB51TcERhemHVTO967TnA==
X-IronPort-AV: E=Sophos;i="6.27,233,1787011200"; 
   d="scan'208";a="34954126"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 21:26:22 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:9060]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.86:2525] with esmtp (Farcaster)
 id 3f16b227-e23b-4615-911a-908160d7dca8; Wed, 25 Nov 2026 21:26:21 +0000 (UTC)
X-Farcaster-Flow-ID: 3f16b227-e23b-4615-911a-908160d7dca8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:26:21 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:26:21 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>, Mikulas Patocka <mpatocka@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.12.y] dm: fix infinite loop in dm_blk_do_report_zones()
Date: Wed, 25 Nov 2026 21:26:02 +0000
Message-ID: <20261125212602.1324983-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026112527-unequal-wilt-0a1c@gregkh>
References: <2026112527-unequal-wilt-0a1c@gregkh>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
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
index 85777d875cc0..00c3b35ed290 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -40,6 +40,8 @@ static int dm_blk_do_report_zones(struct mapped_device *md, struct dm_table *t,
 					      nr_zones - args.zone_idx);
 		if (ret < 0)
 			return ret;
+		if (!ret)
+			return -EIO;
 	} while (args.zone_idx < nr_zones &&
 		 args.next_sector < get_capacity(disk));
 

base-commit: b869a5313cbfe7102873d3de318ddb68675146d0
-- 
2.50.1

