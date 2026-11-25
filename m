Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642361;
	b=aEI6wAAxxUlrwXZu1H1I5a963HvDPhcdSGAMyQplwUN0d251ZbUiMMZ9al8uQroS1wRD
	 BjicQalEiotR8nwO+pg2iYZpL0Xo9Yxfqjjsg/sE+Y3VJ5qEFxLqFwgyzHkfCR4C0r2eV
	 PI/cDTEfYQhX3oXZlfHFWigEVmy1JpMb3PWThqQzKhQj6W4C9M0ZQKIoNqJ7S/YAqPPk2
	 gZZ648oTpfJTuaIeU20S8TqypYsNHn8HmT/F8Lc4sPKLh51ZnP5bu3x2KXJBAQik2JCCv
	 IInQs3BIxPgW0b4o6uydFBLT40z/TJNqoL2GmhaPDKIQlVfFo3ww19QlfgfOuiud8mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642361;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=cVYCXOs6OdkAyHbMj1hWFzN8zuBOrd0Dekrr8/9Sxkc=;
	b=Ty4ol7Vdfme0voxa8JVT30i7iH6lC5ivtQmOaKMcXM8JjOV/dpatiRQIuP6+d1zqoiz3
	 sqh2yTCSgSAm0Tc+0oB1M1tox6A+kxnHouzJ0dWOdVklWez19S3z1p8jeAI5HruWqOf+i
	 KLSt64xA+lUnOWFv2AB3PipTy3iyFcq6kqFxpmj4WSaFGbvnpok3IAlge0Gwbw3wtyrj5
	 EEDF8JjR2GuC+LlUHS34KEVKNo8a6OXc93rS6ytN/T1Pd65cHnkR5jiBmLK9yc1w3l7rI
	 qXlNd4slVRzsiEtPjDCH5opWAzjvcQQa0pN6mANrJobb/neLyO99Lzz+gfjK3+nMz2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WdKFwxkJ;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197C606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C197C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WdKFwxkJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795642360; x=1827178360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cVYCXOs6OdkAyHbMj1hWFzN8zuBOrd0Dekrr8/9Sxkc=;
  b=WdKFwxkJbUCvORL1e+tDcokfiZuc/uUN55BbRqrm+ubVOZEm6ieNNQDf
   nWQaPXubQyvk7RGK6fp6Wg7JhomE8cPYxnxMWa78ztXT0X2vmTzbnzgiq
   cmyb59Eq02inQrY+OOW+oZ/SKFnCZsgVIjZYXoe6QYGZ7bmCbxcUaXRpC
   pTwYQ9I5fES12qGtM8Sfma1V39owc7/Y0se18x8spefNDxVQ2t/M8XS6E
   BM8uMNnWGw1Z+K7UvuAAWNx5rOZgkQZsMv71Ka8qZkfKYkXjMD+PuECX0
   cW9YGHh4fA34QOrAszWc6H5JSw4mcu+WhMdD5pUBMilJQAHSZqJA7aHbZ
   Q==;
X-CSE-ConnectionGUID: X+jkGYoeRsGzrWioAijoMw==
X-CSE-MsgGUID: GHBM89udRoe3Pj9u0CEU1g==
X-IronPort-AV: E=Sophos;i="6.27,233,1787011200"; 
   d="scan'208";a="34975119"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 21:32:40 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:9613]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.48:2525] with esmtp (Farcaster)
 id ece391bc-a054-4d4f-89ef-18ebf830a106; Wed, 25 Nov 2026 21:32:40 +0000 (UTC)
X-Farcaster-Flow-ID: ece391bc-a054-4d4f-89ef-18ebf830a106
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:32:39 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:32:39 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>, Mikulas Patocka <mpatocka@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 5.15.y] dm: fix infinite loop in dm_blk_do_report_zones()
Date: Wed, 25 Nov 2026 21:32:27 +0000
Message-ID: <20261125213227.1365228-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026112528-skyline-strongbox-22b3@gregkh>
References: <2026112528-skyline-strongbox-22b3@gregkh>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
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
index 6d82a34438c8..a1723036ca54 100644
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
 

base-commit: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
-- 
2.50.1

