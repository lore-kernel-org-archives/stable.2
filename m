Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660662;
	b=IQ3MvO+QRYenluSF5NBSJ5qC1frrE0VO3Ang1POkdfZqueLiX3nVA0a56gwxBM+hAjOs
	 awhUCG+yyhluHayZo8g04u1KZOtSWtp9IeiTygpjQsccvVfUxKMk9xYZTUiCcTaYK1YSi
	 ypXX6RVlj3P0zcxAROifSgrZ3Tm/kI8ehCQ1h0i342AEwkVOD/2eX6HUgZ0PhO+Xit7XQ
	 fBJAGzec5NFrlEIQuDGunS2t6pIguNut0RWAVE/53uqidskMH9UtpzpJHBGgfBdeA2rvg
	 G8+0xN7zl2qQjmQMoNJVCUO1KgKl0GZCZVlXXWCMOkUycZ0C6aeQabIKRn32r5wFjuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660662;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=AnOl++XGrdWHG5T6LBt29eHxVsH0BxA9ok8+byYHbrY=;
	b=eNnqPYZf12bfqKzzKq/9Y8jj6zNBPw+fDg0Q+Bf48Lps0Q3AAEy+bw9e+TZPYXKf6imL
	 D0IYIWPyeXzjuKAzksmITF6GzhU+RHYbOf/etE7MVjnTfgXDuZWr0uwDPdlA+RMmEMPas
	 PtrnIriLsjrv/kqash2ikQg7qRqIEyw03iOZIH/yI/u1ZAIf5Ie19dpfKcdTx7gbWG0mK
	 XdG4DELLzLzfF+XHy391RraszRkvodnVdD7bKpAEBVOHRdccVXe25r6h+Coh3mlxTB68h
	 0bmTC6LGodnrXHEaGoEDCA5uRD6+32aP6rMZFnZA50FqD30gAcnCN/ESpM1wlIhbcAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=fCZI+g4Y;
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78180606A326;
	Mon,  2 Nov 2026 23:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78180606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=fCZI+g4Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793660662; x=1825196662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AnOl++XGrdWHG5T6LBt29eHxVsH0BxA9ok8+byYHbrY=;
  b=fCZI+g4Ycq7tHAUqgzPFkT1p8XbWaO5qEOie3BBnTM9B6jLV3xv+8Z6a
   AbgShyIygtsIdqvzbwRH0whj6XHMH/d7od14Q6g+lvtZg4i7pWhw27CbJ
   +tBvpWnlfeqYjzZ+FCQCssFP/djdTbrZwhieQxmzhoKVoWZ2FXAqOY5CN
   JbYEkqRgzFIZFk7e8j6wQCyooTjmqOzEroCgfoVcJ/VuAkZ6Eh2pKwOJo
   gUJSSOmjOEVvJNQ1lhnCMkZyjd3C0KRIiHMzRbX8F2rfx9yz+CjLLbEyZ
   1FXRLV1/oSmM0cMGvf5z5hMyUjaiNZi/48rnjC8wZBeHTT39MtuR3Wy4Z
   A==;
X-CSE-ConnectionGUID: /xd83QwYRWGrNFOnUFiD+w==
X-CSE-MsgGUID: tVifs0t9RHO222qg8TJ2eg==
X-IronPort-AV: E=Sophos;i="6.27,192,1787011200"; 
   d="scan'208";a="32925610"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 23:04:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:1680]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.155:2525] with esmtp (Farcaster)
 id c87944cf-4a11-4645-8027-9de34d9693a1; Mon, 2 Nov 2026 23:04:21 +0000 (UTC)
X-Farcaster-Flow-ID: c87944cf-4a11-4645-8027-9de34d9693a1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 2 Nov 2026 23:04:21 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 2 Nov 2026
 23:04:21 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Pavel Pisa <pisa@fel.cvut.cz>
Subject: [PATCH v3 1/2] can: ctucanfd: enable NAPI before starting the controller
Date: Mon, 2 Nov 2026 23:03:38 +0000
Message-ID: <20261102230339.1260288-2-patrzhan@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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
    v3:
    - No changes
    - v2: https://lore.kernel.org/r/20261030233330.3483988-2-patrzhan@amazon.com
    
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
-- 
2.50.1

