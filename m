Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438144;
	b=T/XNwGfI+Gy45KMEG3f2iGEv84Wa+w+PGhrk3pqNkF8MXu2vmpLo/rzhMtlY45u5/c4x
	 qYSeuA4gSFjowxDjJLHUusL5CL93jkFRhojh0O5JD+M53jI1+/kVN56lZPrpcrGPDtpDq
	 lXt86cX1N3LGLMJm3aJjX6XitiPi9AZY/Nj6q2JS50ZlvoSoGjzHhZkvkT6tIVOpdTD5M
	 HpnROGgE1LS76XRtKNnMBotjAAEsJry7MCzQRNKLUJyJOAna2H0O0F4rCooe6XFqmexxa
	 M0oYwjVjXqe6mq6rjj62gjpBw6pcHftdNvj479E4LfzmNAwEGNHnTNCXdpEQpRwrBYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438144;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=U/bRINIDQzD431k78GQB7GRewLOTJlawRJ+e1x3vg3c=;
	b=RnzS2t+JCXoS39EEVobQ6T9cPAljFN//HtnEwIidN/iOHtNi0lI0aB34iEomVLSUI+f6
	 osGfVu75j+FF5/XjiGwrl+kENkvxcOj5XgCQznFBYXqp3hYNYm7VsX2Ac/NRRtGsqk/5d
	 e5mG+6eFHHZeFWBA4GRYmZufleeIgbOR87b96P6nmZ4V6zrrck2NplU4iNLTsfTgOkpvi
	 5oFFlMs5Y8v+DhCuorFiakjAsZVQtkvkZlrgCw9Ft+2TfMnl7qKXAtpndbC3ryceG4Yak
	 7xaL6S8LVkT9WB0nAvbg6uYnZ3beCqJsulPQyHfmH7SoGKu0ZaPW/sofCvHiXB5LZTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=fDIxBXzP;
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB24606A319;
	Mon, 19 Oct 2026 19:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACB24606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=fDIxBXzP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792438143; x=1823974143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U/bRINIDQzD431k78GQB7GRewLOTJlawRJ+e1x3vg3c=;
  b=fDIxBXzPe+iOWcGhnPihh+wCaxAvZsKz7VYZzNCPq+KbvOcVOlsT3Y5A
   oKVNw+ndij1Y7wFiCcdhVUhfOYEz+UqJSyz2rVeNGRaAtSomN8gZbJda4
   R2wIxq+wmk2eQ9xh17VCgDzKYGS7mehE5vOESWPiD1iLVxxSoT1Nd1Z9k
   5Ld/6kNbI1lvdEz1SJixDdpI89fp0aH4qlAGdQ7U0r7Qy3KEtibjM5IOn
   mAHogBofHahzQJ7ZfmrotpiTYzZ6YrXt8juz/Zb4h45I5E9YudC3/Qrb7
   jh9936j8fhnLI0V0/YLjFOgKLW2sedZ6yWoEvKfj3g1ah0ZQMxtfCL6CX
   g==;
X-CSE-ConnectionGUID: JcB4rCh/QG2fiukXgN41hQ==
X-CSE-MsgGUID: u5bBUhXLT+aRMdNKeUKHsw==
X-IronPort-AV: E=Sophos;i="6.27,167,1787011200"; 
   d="scan'208";a="31447309"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 19:29:03 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:25501]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.38:2525] with esmtp (Farcaster)
 id 308ec05d-3c5a-4c35-a3af-d9ffdda9890d; Mon, 19 Oct 2026 19:29:02 +0000 (UTC)
X-Farcaster-Flow-ID: 308ec05d-3c5a-4c35-a3af-d9ffdda9890d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 19 Oct 2026 19:29:02 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Mon, 19 Oct 2026 19:29:02 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski
	<bmarzins@redhat.com>
CC: <dm-devel@lists.linux.dev>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Mark Bundschuh <mkbund@amazon.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] dm: fix infinite loop in dm_blk_do_report_zones()
Date: Mon, 19 Oct 2026 19:28:19 +0000
Message-ID: <20261019192819.3962873-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
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
---
 drivers/md/dm-zone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index f29acf64429a..ce4f94685a78 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -33,6 +33,8 @@ static int dm_blk_do_report_zones(struct mapped_device *md, struct dm_table *t,
 					      nr_zones - args->zone_idx);
 		if (ret < 0)
 			return ret;
+		if (!ret)
+			return -EIO;
 	} while (args->zone_idx < nr_zones &&
 		 args->next_sector < get_capacity(md->disk));
 
-- 
2.50.1

