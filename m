Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862495;
	b=3KdaP7/ePLGkxNHux+UyOxbTjvyBwUh+CmAqgBlPkT/RK9BaC1/6777RafyMTX6k4Hfd
	 cnnZgaDvWVBovCZBOaZgAV3d1eYWNn2aJZjIxspYfGdjWiYJPS4tyWcPFXCz+55DPjAxx
	 o1yqEQsXll27GAD0tKoodSvcOJSBXv3tTwiqVDrNyF28gSNrUJPjH8iZeV69/9wSIP4Uh
	 gbjeXpvlvjLPGQo2kIpVPRhF9DmQhM6YjivTVOS7Z8T+DDLDqp7wycegCQKFlDsIOHJlR
	 mLQEd0oGqRhLShmYMHmLdKJsdX47tOJ851B9UN2/8LDhVznUf2kuVr/SAyU+fRzCxUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862495;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=UAG6ybXWhgd9D/xMXlE5TO4WMq8Qm8ocklmlYGwsIOo=;
	b=ZaCKiMDVK9k0tbdwEGBpl0OyaSF1g3200/Re9Gqq19ng9C04tnsuCu1XhTiXXYZlC3tf
	 9877cMwm/3W3uTxPQBK3YE0rAL1HGb+mbUCcV4L0uqGg29iVl2nPEh8idtPXuSS14O8jA
	 qaJ/vMVzdabRC1vXRdZ134Df8Hf6RQCWJo4OeE0nXtJ6cSNUbhqwpn6m6zmVY5xxdoZdt
	 V6uWY5DYPrIOAzQFkB3bmNCIjq+gGzKWHbBxi4iYw81bPaSKuEHtbJpNlJF9v+F2UML78
	 SccBXfqIgT+/hRWhdreDvHcKQO+9nHAD+5mKBpR8fOb/mE9AdIk9y3C/R9gLUOrwWOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Et2ZYoFY;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5D606A322;
	Mon, 16 Nov 2026 20:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC5D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Et2ZYoFY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794862495; x=1826398495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UAG6ybXWhgd9D/xMXlE5TO4WMq8Qm8ocklmlYGwsIOo=;
  b=Et2ZYoFYABwQm7Je6xGMxPOh8BU5mA6c8UjfTBpMJuBPSOW/XvO7Jw7x
   /f3gmAuz/piuEqd/5xZGMgOIAfjcD5qH0GrT8ePw1wPQrzMQ7v+R+hSvg
   vtusABMsv+pK/2LLC5GY7PP4cCv+28Dm5qGs6O9Ng+BuqwxY7JHm0dqwz
   u4Jz7dvG8V5rbOx05B4JSqHu8pAOsQU8bSnSYKnHpF/r3XtFBQ99IRhjw
   otp+ngFxXKbNZU5yJv9tFadS3q/Z4G9yHkT+OgLZvUGSYOOrWEBj0uuED
   JNrYzkmrxyBj9eP9A7GnCWHBXR6rXCMKk+9r3lmq2wx83r4Zp4YJnUkGi
   g==;
X-CSE-ConnectionGUID: 8XwXTjfrTo6CcMYkgV2Zgw==
X-CSE-MsgGUID: tXoOGXwOS1uP+4QVietCjw==
X-IronPort-AV: E=Sophos;i="6.27,217,1787011200"; 
   d="scan'208";a="34339671"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 20:54:55 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:8311]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id b7c41268-69a0-46a3-be2e-c11ff2b8e151; Mon, 16 Nov 2026 20:54:54 +0000 (UTC)
X-Farcaster-Flow-ID: b7c41268-69a0-46a3-be2e-c11ff2b8e151
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 20:54:54 +0000
Received: from 80a9970eed1e.amazon.com (10.106.101.27) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 20:54:53 +0000
From: Justinien Bouron <jbouron@amazon.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, "Martin K . Petersen"
	<mkp@kernel.org>, John Garry <john.garry@linux.dev>, Hannes Reinecke
	<hare@suse.de>, Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Justinien Bouron <jbouron@amazon.com>, Gunnar Kudrjavets
	<gunnarku@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8
Date: Mon, 16 Nov 2026 12:54:30 -0800
Message-ID: <20261116205430.44305-1-jbouron@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

INTEL SSDSCKKB240G8 with firmware version XC311102 runs into FPDMA
timeout errors when queue/max_sectors_kb is set to
BLK_DEF_MAX_SECTORS_CAP = 4096KiB / 8192 sectors. Similar to model
SSDSC2KG480G8, the issue disappears when setting this max size to 8191
sectors, thus apply the same quirk.

Firmware version X5A1ME59 for SSDSCKKB240G8 is un-affected by this bug
thus keep the quirk specific to firmware XC311102.

Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
Signed-off-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5ff45a5cbfe4a..2a5ca1b9ee5c0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4204,6 +4204,7 @@ static const struct ata_dev_quirk_value __ata_dev_max_sec_quirks[] = {
 	{ "LITEON EP1-*",		NULL,		1024 },
 	{ "DELLBOSS VD",		"MV.R00-0",	8191 },
 	{ "INTEL SSDSC2KG480G8",	"XCV10120",	8191 },
+	{ "INTEL SSDSCKKB240G8",	"XC311102",	8191 },
 	{ },
 };
 
@@ -4474,6 +4475,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 						ATA_QUIRK_MAX_SEC },
 	{ "INTEL*SSDSC2CT*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_NO_FUA },
+	{ "INTEL SSDSCKKB240G8", "XC311102",	ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_MAX_SEC },
 	{ "INTEL*SSD*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "SSD*INTEL*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "Samsung*SSD*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
-- 
2.47.3

