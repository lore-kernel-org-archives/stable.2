Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403284;
	b=IkWnx5QL6OtF9E1dORR7EIkx4TPoxE6OBB55iWCMAkIqQACTOXQqsxOKYirIDQEy9Kdv
	 NYwa57cdg0QVG/pMxY0f8eiAO+XVm8Sj62/Hw087N1myfjeHNgrA4jDUcf0Jn+EG3413G
	 SLjIxmKSYyG7k9X2ZhNcL9Wk2GGypgvNMW3aPtnyMstMJVMhODsYiJVHV8n1WKvNl8gtb
	 jspbHSYCVUqya36ztXkTIOzFQY7rTZp7hTgOJm/Ss7DSH+eIJPUJVL6+rnlmLADmnFqYO
	 0n4Uwej6w2pLMmnsHJmJbDEa4aXbZ9iazWaap3brtLGX0rrx7yggVqxjfpHQdAu6h2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403284;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=UgsuAaqC4mZioJp/qMefWvyxtbVtIVGewUrp4BJ3Akc=;
	b=SlVlYz9dUmQRKM1jUAuLzjcdBYwk8i2QINEuafvpVnidNog7UZPT6YslmTHb8s2el8i+
	 EMqcGfeFplwK1kczumb4sEWLPcDHtE/3LqWekezzD4/8abmx1HGxl9oYoq8n3s8WK0CFq
	 Cd3+79U9LVC9mplAbHjq1wWt5PzgElEq7Wowvz11l7XbCs2XF4JmmLyvYiUBreyfRbuOk
	 FAg0L9lqtu64S/uyq6/U1n/ASywCKW0Zrsh5Vy7Bmw5CePeOchxPmeKtT3ku2Os+8cX7V
	 DYBVbEjfzd+EuTmsEQOaVloQFxOJhyXDZgMPgGiv1MhTHdshc6fWTR/BshNtnzSnJ8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="DD3/Meuy";
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BA606A323;
	Fri, 30 Oct 2026 23:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C2BA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=DD3/Meuy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793403284; x=1824939284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UgsuAaqC4mZioJp/qMefWvyxtbVtIVGewUrp4BJ3Akc=;
  b=DD3/Meuy7rRBLHXEMGDKa70gg8GW0pysDrQqWARpgAP48/XaO/b6A7Ql
   EA3kpN3vQ5+gzb6Rdk6f9Pa0GaZRSKINYluzysBUSCHWurGFx5NldQoeE
   0f1vb5sXlIeehHJ3NhPE+NG5kPyVynhuBAw9OxQQtpiePM8yafdy7MZYl
   LMQ9BLuUdJm4KCoydizVzerZS0xtaIo0NNCFiMpAL8Klm3zaT8L0knwtC
   6me7vhO32lMc/alWtjXTYhRpxaJRqJEY4ENAGYgqRndtnA6ZcfQKIjOur
   ytgLylMjqdmRFvBbpGgSxPyvNpQGQO+1xn9a4FPe8XL8VbPjQQ3eOqleF
   w==;
X-CSE-ConnectionGUID: hWh706vGSHCTQmH9TSqIeQ==
X-CSE-MsgGUID: TIrsSjpQQc2xztvm6Ratng==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32495273"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 23:34:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:1110]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.65:2525] with esmtp (Farcaster)
 id 2f8f6925-7c7c-4ecc-bdcc-6516bd209c8f; Fri, 30 Oct 2026 23:34:43 +0000 (UTC)
X-Farcaster-Flow-ID: 2f8f6925-7c7c-4ecc-bdcc-6516bd209c8f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 23:34:43 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 30 Oct 2026
 23:34:43 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 2/3] can: xilinx_can: enable NAPI before starting the controller
Date: Fri, 30 Oct 2026 23:33:29 +0000
Message-ID: <20261030233330.3483988-3-patrzhan@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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
---

Notes:
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

