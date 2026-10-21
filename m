Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616426;
	b=YOnhEjr7SKPxJ1i7+hxczZjxQ0ogW+9CGbyTQBNdy19CfsoaaXQVlntNHHSv2X4RFdqc
	 p/t1WaR7ivNCJBAorBdFqEsKSIK5jdcnPvpUtebp1AmsXYmhZJEfctb6pf421JQY/Qr6a
	 TZWjURmmxPtNrZgb1o3GktECLb1Xn88goWQN7uWkSlU/aRmCec9rVDBtVT06yLxmE36DL
	 qFj8HMhVVe55e3IRo3utU/fsDnYDH61AmG4+se+zqHwr9ES0oCcLhkxf5Pxfm6SjSyAqS
	 OnwNaV/eCCVzZnqz5FH6CAO2uHkdS6yC99cvTLqYM5QZv+hwX+on9Q78GF5sAm94cJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616426;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=KmKQiASgHHpPpvSVCiK2LSdfMBzEqABYMCvRYtwTfIw=;
	b=Cgiqwtcf/rAgWB5gTeO9PTkaI3thRYtzJWT1n1HI3IURdwSAhilJGwuAIvc0/O3feRp+
	 5Oxcl4+X/ue9OlglUDm0dupP27J6FEJjA8dbGsmVswYlh2ZeIjiUxyWLLf1j6l020sb9l
	 tUdkuGE4s1HLWJuuANkDnufRGuwaoscVhfIcf8x3sjiBxhcbhhFrndh5+9P1IB+BowwV3
	 8Vm/4h147moo/M3Ww4/Xc6jowARPbT7CLZEQwZya+Xv37SYhzvKPNOu+RMsFdcwCLZSt5
	 r6zN1qc5il8BL9RwTrP5mXR6t5xrUlYNa2lJUgDUlXcnuiKyZ9Iunm+/sJXjxehuArQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="qZnB/RAo";
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4286606A319;
	Wed, 21 Oct 2026 21:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4286606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=qZnB/RAo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792616425; x=1824152425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmKQiASgHHpPpvSVCiK2LSdfMBzEqABYMCvRYtwTfIw=;
  b=qZnB/RAo8GVXNejfEbqJahtf83qzOSqDTHtVKlOe9jvIrTLmFus3rMxi
   igljnKR/dFLtiFNWf1vE5EH3uSaVm8ColVCXwBIWFArRiOdmjnz5GOXj+
   rvWx0bT5KTeuh9qq5Bwxo4MBdqLEry9kytlpIqj9eAUQz0G5DqdVVb5rS
   Jr2A9594RLmHwabqzhprni83L+5OG0ZxBYMOgiyoWl8m95isoutrJw/w6
   3GD8fmvj//w3ztwXijjg8zH5Ih8NG7+SyhVS47E56Lud6qLLZ3XVm56Qt
   j0aYAG0RU/Uni2NZMloacpOEkCss0hMzOs+biOKJFmXsg/bYJzovAkqBG
   A==;
X-CSE-ConnectionGUID: cwGklPTASR6F0+v0f9L9oA==
X-CSE-MsgGUID: lpiPmw3+RnSbAWVyuTMyfQ==
X-IronPort-AV: E=Sophos;i="6.27,170,1787011200"; 
   d="scan'208";a="31940288"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 21:00:25 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:12534]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.5:2525] with esmtp (Farcaster)
 id d8ae2856-7a85-415a-be54-ff72d9aa0b5b; Wed, 21 Oct 2026 21:00:25 +0000 (UTC)
X-Farcaster-Flow-ID: d8ae2856-7a85-415a-be54-ff72d9aa0b5b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 21 Oct 2026 21:00:25 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Wed, 21 Oct 2026
 21:00:24 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/3] can: xilinx_can: enable NAPI before starting the controller
Date: Wed, 21 Oct 2026 20:59:23 +0000
Message-ID: <20261021205924.2538511-3-patrzhan@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261021205924.2538511-1-patrzhan@amazon.com>
References: <20261021205924.2538511-1-patrzhan@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

xcan_open() calls xcan_chip_start(), which writes XCAN_IER_OFFSET to
unmask the RX interrupts and then sets XCAN_SRR_CEN_MASK to enable the
controller, and only then calls napi_enable(). A frame that arrives in
that window raises the RX interrupt. xcan_interrupt() clears the RX
bits in XCAN_IER_OFFSET and calls napi_schedule(). NAPI is still
disabled, so napi_schedule_prep() finds NAPI_STATE_SCHED set and the
schedule is dropped. Only xcan_rx_poll() unmasks RX again, and it never
runs. The interface receives nothing until the next close. Transmit
still works and no rx_errors subcounter moves, so the stall is silent.
Every re-open (ip link down/up, a driver rebind) runs the same race
again.

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

This is the same race as in ctucanfd, fixed by the previous patch.

Tested on a Versal board.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Patrick Zhang <patrzhan@amazon.com>
---
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

