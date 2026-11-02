Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660687;
	b=S94P6UNVf1uJG5SX9kvRT6mjyCvZhqsbPNYTFaTvAaIxcQOBERC6TJStAH4f7klCWS32
	 vbZPEOS31Z8Kk7q5QnsJfNLDc4djVOg+p8pBDl7/fblQDGrmAxMsdZPguN2ZbOApMMTTb
	 7tIQZAz7w6PD31CMs9WqWnR0KQH93bxS8SY3y8SP4g70SCj85R+UShOkUg/tq+EFTAyGM
	 M6MXjKX4kE2TD6PvrR6LrbOAON4SsGqh/uxBHoPpGv4FWSwfr5JS8yRkse66cSJd2d6fv
	 XPgpEkivEkOr0+Jw9efYm1bbhplmdDru9/LyGbCa4W4GleGDjLPBBXsa8JOxfwTwaxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=XQwmMGo6QxiVGI7PkR9uzdzIsrnhm9x0tfacxXI/5Zw=;
	b=3TPMPf1FwiMctYHwiU/6t1VIeyhbLdjFiv/QVGKakebAi/8EQkbyy0LU7ueGS+WY7za6
	 lEIBKqrfmPgdzODUg6eS0Daw9XvpVrlflEtR6tRBXjvaeIs6PoIYRqp9Go9P7wbBUOstt
	 jtWxn5cMalNYbezoYzX/A77ekEAfgWYGN/8h14CQM5YqTb8dsiAlUezAZg1QXWw9fmdt6
	 BH8YHGIwgyWOC5TWAgXilQDFjewmMOTMZ3IrcLPTExpJAQVZ42zk0TzJoZ0daQu8/hQEo
	 heRdDCaQOKLMhTmHI9HwiyJ4DLN0khCc0GhnZV000DyTtoZGsTWgt31RgFrEXLEryfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Y60JwxRo;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CD606A326;
	Mon,  2 Nov 2026 23:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C03CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Y60JwxRo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793660686; x=1825196686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XQwmMGo6QxiVGI7PkR9uzdzIsrnhm9x0tfacxXI/5Zw=;
  b=Y60JwxRoxX7u2X/ysWe8DEh0tc73JD/Sb893vZhHIl8OmFDhYOXTi08z
   sXQ5v1RfqaAZHSHy9bjy8LhFM0zjBP7FxSQy8w3DOvh68wMZkTmTZnca5
   WxN6uWguL78TA3/+5y/q18QvKfROdd3ARuIFgxjwum81kXCXmBGO+HKOb
   5615iZuyEvw0WopD2+8wDIzimP/wZZx9sLI/GCho7VdcoJ1v/CiV1Do2p
   9wIoHtveC7tC93YB2EMhfC2cr0EGu2PoiTjuUgiTpRgMvQVhUklYEg2K1
   LvH27L2RU1PBR165vnt+diVXZIvPHm38MLtfP5qgSJrQqu1/kMKbsorsu
   w==;
X-CSE-ConnectionGUID: UvCHpBAnQGanjYMLbQxFKA==
X-CSE-MsgGUID: 63+Uxh43R/qOlB8fgnQ0OQ==
X-IronPort-AV: E=Sophos;i="6.27,192,1787011200"; 
   d="scan'208";a="32901025"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 23:04:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:4186]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.149:2525] with esmtp (Farcaster)
 id b1a9aaf3-301d-46ee-9a86-6cdc76e1aa68; Mon, 2 Nov 2026 23:04:45 +0000 (UTC)
X-Farcaster-Flow-ID: b1a9aaf3-301d-46ee-9a86-6cdc76e1aa68
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 2 Nov 2026 23:04:45 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 2 Nov 2026
 23:04:45 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 2/2] can: xilinx_can: enable NAPI before starting the controller
Date: Mon, 2 Nov 2026 23:03:39 +0000
Message-ID: <20261102230339.1260288-3-patrzhan@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261102230339.1260288-1-patrzhan@amazon.com>
References: <20261102230339.1260288-1-patrzhan@amazon.com>
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

xcan_open() calls xcan_chip_start(), which writes XCAN_IER_OFFSET to
unmask the RX interrupts and then sets XCAN_SRR_CEN_MASK to enable the
controller, and only then calls napi_enable(). A frame that arrives in
that window raises the RX interrupt. xcan_interrupt() clears the RX
bits in XCAN_IER_OFFSET and calls napi_schedule(). NAPI is still
disabled, so napi_schedule_prep() finds NAPI_STATE_SCHED set and the
schedule is dropped. Only xcan_rx_poll() unmasks RX again, and it never
runs. The interface receives no data frames until the next close.
Transmit still works. The RX overflow interrupt stays enabled, so once
the RX FIFO fills, xcan_err_interrupt() counts rx_over_errors and
reports overflow error frames, but nothing reads the FIFO. Every
re-open (ip link down/up, a driver rebind) runs the same race again.

The window is only the tail of xcan_chip_start(), so the failure is
rare. Adding an mdelay(50) at the end of xcan_chip_start() makes it
reproducible with continuous traffic from another node and a single
"ip link set down/up" on the test device.

Enable NAPI before the controller starts, so that an early RX interrupt
can schedule the poll. NAPI can be enabled while the controller is in
reset, because nothing schedules it until an interrupt arrives. If
xcan_chip_start() fails, disable NAPI again. Otherwise the next open
would call napi_enable() on an already enabled instance and trip the
BUG_ON() in napi_enable_locked().

This is the same race as in "can: ctucanfd: enable NAPI before starting
the controller".

Tested on a Versal board.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Patrick Zhang <patrzhan@amazon.com>
Reviewed-by: Harini T <harini.t@amd.com>
---

Notes:
    v3:
    - Add Reviewed-by from Harini
    - v2: https://lore.kernel.org/r/20261030233330.3483988-3-patrzhan@amazon.com
    
    v2:
    - Correct the commit message: the RX overflow interrupt stays enabled
      during the stall, so rx_over_errors is counted once the FIFO fills
    - Name the ctucanfd fix by subject instead of "the previous patch"
    - v1: https://lore.kernel.org/r/20261021205924.2538511-3-patrzhan@amazon.com

 drivers/net/can/xilinx_can.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 43d7f2282..5c2412bf9 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1570,18 +1570,22 @@ static int xcan_open(struct net_device *ndev)
 	if (ret)
 		goto err_irq;
 
+	/* Keep before xcan_chip_start(): the ISR masks RX interrupts and only
+	 * the poll unmasks them.
+	 */
+	napi_enable(&priv->napi);
 	ret = xcan_chip_start(ndev);
 	if (ret < 0) {
 		netdev_err(ndev, "xcan_chip_start failed!\n");
 		goto err_candev;
 	}
 
-	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
 
 	return 0;
 
 err_candev:
+	napi_disable(&priv->napi);
 	close_candev(ndev);
 err_irq:
 	free_irq(ndev->irq, ndev);
-- 
2.50.1

