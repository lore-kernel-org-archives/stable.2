Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789394;
	b=LvjGGDISy6avN5/GJxnTO+lOdu59S6I1oF4ekFvbAM2I0uyVp0elhOAGi/dJBpAYdvWt
	 yaAElCf3EeXxndId0uDQ1C42pbMmgFtANGdd/wqMEtTFfCdyn8kIDZ98bUt48nmH0I/MQ
	 UnpbrFE+fIWiR80sYJ5pMgpGbszbMXpNzZkhtNtQhQwDoF/vpSKdHVYjD5QY920AJll/y
	 R5/UUj6kHXAcnLqo2BRK8ifXtkVu6lO0Ljbd6lEBFelZCWqjoxdKQ+U1rY9m7X3TB92ni
	 sfB5qFHXggHyEY8qK35y/oGpgOXgzLAhOVFhCzTLiELxxXnC+Y42K6IUQVJy4rHOHXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789394;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=XXVbt2lZJPrbMuYhKg18MJou4D4reflAzqt8Nx+t96c=;
	b=O6MAxKBQfwsRcXzhodWcsUceJBX3rlhGM3XSV+eFjcwnAGqWfaNgBmUpG4PnJFPh3gsY
	 SJ3Ft5qr5ygSeC4cE5BBBcPrP/AXO9wqBEiiHBOJq5ujr1qBfhhLfn5uyAZ/zOtFslVZO
	 3Imv1PiczD2gIpF/DfhMvqx7Bx4nrBWdCocSeR7UGEmERDiKMfU3RdOMr2Ii3bNC/hugH
	 fzVijSe+62tD7Tw+LpugyoB4boJSmDejvATh4nV4z5TINJxw/IJxFv1cpAL3YPtH0b2KD
	 /W/2cFuQoy+ERuT/mVIcBeIXcarTfeVQMFwJVH1E7Qeo+3lrzxnZlRF3bm1BBCG5IGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=P79ZmFJk;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD03606A31C;
	Fri, 27 Nov 2026 14:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD03606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=P79ZmFJk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795789389; x=1827325389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XXVbt2lZJPrbMuYhKg18MJou4D4reflAzqt8Nx+t96c=;
  b=P79ZmFJkov6wpdFK/2ftI2DdzJEA+hJvh0RtR6tDuIvuH4gtm/CQBmX+
   mY6b65Aa3G2oUe70M8TvQYwYcg3tW9h0K7jDaYDm2hNVIOGWqYx6scJK5
   +Iy1fjJAqlfkjm7ZRGlhRxrmjSagHyqAMcvSE45Dh6/4d+t8x50uxr6hi
   BJrI17exWY55vUkyi/ncJ5GytS3pscajLxebgise+FG0XgtI50+Twrp7p
   Xvdn80AQX1VMbb2/T9bJmcwJWACDGUuJeKMn7WviD0ara0upq5EO7Iazl
   BuIXkkJppCxjQdDDHZ23ubKEl1KUyVGIOgSB1/aeReowTMVyZUGRFKD4X
   A==;
X-CSE-ConnectionGUID: 2XRNJa1qQ0GOy7neF2zocA==
X-CSE-MsgGUID: kML5ru2zRtqGI9YUY1QgPQ==
X-IronPort-AV: E=Sophos;i="6.27,237,1787011200"; 
   d="scan'208";a="35096891"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 14:23:01 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:1578]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.116:2525] with esmtp (Farcaster)
 id 81d18a74-bdcb-4d36-81c6-45082ffe4af5; Fri, 27 Nov 2026 14:23:01 +0000 (UTC)
X-Farcaster-Flow-ID: 81d18a74-bdcb-4d36-81c6-45082ffe4af5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Fri, 27 Nov 2026 14:23:01 +0000
Received: from dev-dsk-gyokhan-1a-87ab81cc.eu-west-1.amazon.com
 (10.253.85.128) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Fri, 27 Nov 2026
 14:23:00 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Alan Borzeszkowski
	<alan.borzeszkowski@linux.intel.com>, <linux-acpi@vger.kernel.org>
Subject: [STABLE REQUEST] ACPI: PM: Avoid initializing power management for absent devices
Date: Fri, 27 Nov 2026 14:22:38 +0000
Message-ID: <20261127142238.1260712-1-gyokhan@amazon.de>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi,

Please consider this mainline commit (v7.4-rc4) for the stable trees:

  b91ad39f29ce ("ACPI: PM: Avoid initializing power management for absent devices")
    Fixes: 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power() early")

All of the following trees have 2f4ddf2bd1ba but not the fix:
7.3.y 6.18.y 6.12.y 6.6.y 6.1.y. Without the fix, an absent device
with power resources can keep shared power resources referenced, so
other devices that share them never get powered down. The commit has
no Cc: stable, so it has not been picked up.

It cherry-picks cleanly onto v7.3.6, v6.18.65, v6.12.119, v6.6.163 and
v6.1.193. 5.15.y and 5.10.y do not have 2f4ddf2bd1ba and do not need
it.

We carry it on 6.18.65 in the Amazon Linux kernel, and
drivers/acpi/device_pm.o and glue.o build cleanly there.
The other trees are only checked for a clean cherry-pick, not
build-tested.

Thanks,
Gyokhan
