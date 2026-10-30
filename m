Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403250;
	b=v+SqvDBItSUR6ST7osRIWAxrswSVJokn20WzX503/8N4P4DwDu6c2sdXDL2VZXf7SXD3
	 vsbsh762XaDDvUrm4XFaXxDVo9+qLP70gYQkFbpeSliP78Y0Zge9qV2Y8Q2xuswCVK/uf
	 mAeTgCwdwUxe3tGr+YWbANfWMO3s5++uFplEGeUHVfqEIojHAmR1io8CC5FhIYapGfBVn
	 JOcjnvMpuo74txBb0ceF/5jW2Gz9WDj3lk8gYcGtHGKDSo2wLn8iyu43jWqRM4t6G/UFe
	 TrKpCflfTNgntG23Crr45gtv4O8MErCnKs5RGWfDRN0tlCDmu8sfA83/213ra/5mZJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Yn9j7vUlhcxAGQT50RXOzf3wg2yIgoItjzp21EXuhh8=;
	b=WmlF/dTEvWBj2WoChRbyJohY8ULGkGoOVUjXDvsQmGwd4Nlhr2Sc5STKqRzH0DCbcGKc
	 2gzn5qUN8+4zgP2R9rlLj0rGLhBX4eIlx0EM+tDwxMEQlKBYPFsyaX8rX08kE0g21kDcZ
	 BblhZUHi33GINN+4MfT63GfkY6kSHSIPYmEx9JhhH+5eVANN9g8TY0kborMFIJV6To1dK
	 h80SU6xwgGA5VsGuQwIOHQab4jmzZqOZ+CUAjD3iTU5J9mfrPLEmEw7NQd9fxhgDRvlvw
	 htxOAelSpaJUXav6bBd3CjUJaFgEQ3HT6QZlgHiyPmi8OdDV3FRPGPwrKxRZSoqSodA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=nor2YBre;
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985C606A31C;
	Fri, 30 Oct 2026 23:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4985C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=nor2YBre
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793403250; x=1824939250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yn9j7vUlhcxAGQT50RXOzf3wg2yIgoItjzp21EXuhh8=;
  b=nor2YBreYxWd+CoHBY8yFBj+/i4yUnqGevX91OQKfYgoe/qjKr9bePyf
   PH8LY8bmLs76CsaaejeR3OcdLSEbqTod0uPgaWAC5DzTTQxded7LPbuYw
   RQMKrf1m+367bqOxnwNhKtGSiXFyIxVtJkzDHs0CnxhPKcWHglMocY/Km
   la7q8Udd+T8eqOEv4dAKWs8fcAtjW/UWMq7zpiGruYgoKM73QSABhpyPt
   kMO1E86yP6YLWYC7+RPCM8UTiZdd4ZC0uok02NlLEu1dieGIkDHnMcj4c
   JIn3WBnkq8xY+dYDwQqg/nJ+/IiWIkt3ekUtGIEKdmf4D7joPunbziLpD
   g==;
X-CSE-ConnectionGUID: IhQQFLBSS2WHEQMM0+NiMA==
X-CSE-MsgGUID: hwDMeOTkRWasKIhMvRLjqQ==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32520689"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 23:34:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:7733]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.46:2525] with esmtp (Farcaster)
 id cd801b92-c482-49b3-bfc2-0184af85a7b9; Fri, 30 Oct 2026 23:34:09 +0000 (UTC)
X-Farcaster-Flow-ID: cd801b92-c482-49b3-bfc2-0184af85a7b9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 23:34:09 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 30 Oct 2026
 23:34:08 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Pavel Pisa <pisa@fel.cvut.cz>
Subject: [PATCH v2 1/3] can: ctucanfd: enable NAPI before starting the controller
Date: Fri, 30 Oct 2026 23:33:28 +0000
Message-ID: <20261030233330.3483988-2-patrzhan@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030233330.3483988-1-patrzhan@amazon.com>
References: <20261030233330.3483988-1-patrzhan@amazon.com>
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

ctucan_open() starts the controller and unmasks RBNEI in
ctucan_chip_start(), prints "ctu_can_fd device registered", and only
then calls napi_enable(). A frame that arrives in that window raises
RBNEI. ctucan_interrupt() masks RBNEI and calls napi_schedule(). NAPI is
still disabled, so napi_schedule_prep() finds NAPI_STATE_SCHED set and
the schedule is dropped. napi_enable() then clears SCHED without
scheduling anything. Only ctucan_rx_poll() unmasks RBNEI again, and it
never runs. The interface receives nothing until the next close.
Transmit still works. The RX FIFO fills up and the core sets DOR, but
the overrun is only accounted in ctucan_rx_poll(), so rx_errors and
rx_over_errors stay at zero and nothing is logged. Every re-open (ip
link down/up, a driver rebind) runs the same race again.

The netdev_info() in the window makes it much wider on a slow console.
This can be reproduced by sending continuous traffic with cangen from
another node and repeating "ip link set down/up" on the test device.

Enable NAPI before the controller starts, so that an early RX interrupt
can schedule the poll. NAPI can be enabled while the controller is in
reset, because nothing schedules it until an interrupt arrives. If
ctucan_chip_start() fails, disable NAPI again. Otherwise the next open
would call napi_enable() on an already enabled instance and trip the
BUG_ON() in napi_enable_locked().

Tested on QEMU with the ctucan_pci device.

Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Patrick Zhang <patrzhan@amazon.com>
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
---

Notes:
    v2:
    - Add Acked-by and Tested-by from Pavel
    - v1: https://lore.kernel.org/r/20261021205924.2538511-2-patrzhan@amazon.com

 drivers/net/can/ctucanfd/ctucanfd_base.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 07d4aa43c..82bf6c645 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -1231,6 +1231,10 @@ static int ctucan_open(struct net_device *ndev)
 		goto err_irq;
 	}
 
+	/* Keep before ctucan_chip_start(): the ISR masks RBNEI and only the
+	 * poll unmasks it.
+	 */
+	napi_enable(&priv->napi);
 	ret = ctucan_chip_start(ndev);
 	if (ret < 0) {
 		netdev_err(ndev, "ctucan_chip_start failed!\n");
@@ -1238,12 +1242,12 @@ static int ctucan_open(struct net_device *ndev)
 	}
 
 	netdev_info(ndev, "ctu_can_fd device registered\n");
-	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
 
 	return 0;
 
 err_chip_start:
+	napi_disable(&priv->napi);
 	free_irq(ndev->irq, ndev);
 err_irq:
 	close_candev(ndev);

base-commit: abeacca61eea4f6803df4a595b656ea45c2d3249
-- 
2.50.1

