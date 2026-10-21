Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616403;
	b=a2sVoLRhxs+Y4qOgSXIJ4AL8IFf+1P1p0It814POGK4vztqAP8WAVByCUgAMjQvNRn45
	 jYggafu2SD52Di4BNhKBXo3xP944t81dJdAzhho1LoxWB2umi2EhKk32XMRxHcFQel8pI
	 9vAFB8TDhj/0EoRQ+PhHaRqmMSvugKY8tYv/SEj1IS8koeLy+pFjznWTnaspRM2YXhZi9
	 eFxpQk5TC5iOaHJ0KOb8JesOPphiUCG19NUxEqQcXZSyl/bmyyapof9QypIoqYJFudSQw
	 /OsAoVIJ6+TQ3xk/jDdebbZKUQ4rMGTL0Swf9d8p5O0Mj1rEEnJsR8VxqP2WVAiY3Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616403;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=1vskPYQTGSiRlfiG8NjtDrPBmdQ7Pt7Lx7mQfl+2YAU=;
	b=ntt32mzcUqiZiqRYL0Rvbgq6bV9fbGxD42YbSbCrIVw3J+B7vdkRg1FRjdVvW2xET9Ye
	 HGFozL5gqjAH+3bszUXHGNkuHIkPAkSeojS5ORJBo+wKiyid58Y/P4Rv6cA94BkJB985k
	 PQUCncAplvoG+hkmNpOy5kLU40jBZqvw0XLwVQ/4eBvtuguPWscSP9kyrnGCGg5AU2gP+
	 dNs3AldQAzUsdRG8CAPq/Jyku5/Yz7+a4vFA3EBA0W4H3K/mKBBGwgfntwDVhTauQpTnV
	 R/zPZFCfDw0s8pYa8LCW1RhYeH0SPX7iqWEE0JyXGG/JSxBWmyefSremGx4E4XQeqYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="XSX/CjyC";
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76910606A31A;
	Wed, 21 Oct 2026 21:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76910606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=XSX/CjyC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792616403; x=1824152403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1vskPYQTGSiRlfiG8NjtDrPBmdQ7Pt7Lx7mQfl+2YAU=;
  b=XSX/CjyCB/vkTfGLQIbwtwNArWf8peEbtJ5BzO9+oMuold8nRGRr/phn
   GHcn2Zz0I47LTeQTzk3n3tekobWWJRKXrS7WRkBhCM0EVhGgdurCvTKuv
   13uSSs81SQgyFKg3sw1KeNWe0fy9S2XUYNpESc9xDf0JskmjIDkl04Za2
   WvJBvpFCFyUD2+uTp/6RM23Ykl+HxLHxlFQ3esbd6GV67nBXMnrqqbqpw
   JQjClphEolMK4J1b6ZbG/CHuJ3Z7kShKpW/oHOxh2Bd2Qsy8RK50WvdM8
   D/rjfTRMmpMwNpHe1ENYxS0YhJyCY/zJl6hxhDGCHmQ2bYwHVmgmi6oqg
   w==;
X-CSE-ConnectionGUID: vLrZ2WaFR1aYiCQMpY5b0w==
X-CSE-MsgGUID: dQDwu3MKT3O/yvN3/BXiWw==
X-IronPort-AV: E=Sophos;i="6.27,170,1787011200"; 
   d="scan'208";a="31914416"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 21:00:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:30807]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.105:2525] with esmtp (Farcaster)
 id 2652e6fa-dded-4dcd-aa2f-370e1df2b89e; Wed, 21 Oct 2026 21:00:02 +0000 (UTC)
X-Farcaster-Flow-ID: 2652e6fa-dded-4dcd-aa2f-370e1df2b89e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 21 Oct 2026 21:00:02 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Wed, 21 Oct 2026
 21:00:02 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/3] can: ctucanfd: enable NAPI before starting the controller
Date: Wed, 21 Oct 2026 20:59:22 +0000
Message-ID: <20261021205924.2538511-2-patrzhan@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
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
---
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

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.50.1

