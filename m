Received: from sg-2-5.ptr.blmpb.com (sg-2-5.ptr.blmpb.com [71.18.227.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD133CEA8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835105; cv=none; b=ZVoqJx0/62JzL+RWxUlhmAGZ7RHjHNIXOAQpWdD7l8rzET8Rl9+XD7NCGcuInOdm2VDWAUw4xVnFni/Oidzoq/+z54BobUiCPkZv53QjsUSggV0cYXqEHz9REOWnZnUj4F8wNpHnGs69In4vHICyX9StsnT0zRligbSd5yOn6cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835105; c=relaxed/simple;
	bh=pxlOfexWygBPVSw286Nocjn0c3g8NEXXEojlLnb2oyY=;
	h=From:To:Message-Id:References:Cc:Subject:Date:Mime-Version:
	 In-Reply-To:Content-Type; b=H7pmmuCQg5jOyCs9a6oRs5GukVILMsB2AbIoMco+qALZSblqiH9mwUduRma5GdqyES9ER6SMyKGswnCVyKHDOuKdoYpIqtNzdNlN/rT04I4dTolMGY7U1U01of0Gne4b7kE2gauB9O15C6JayTIevVHlUcyJjmCIAFI1DOMQcJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=wRt6i5N8; arc=none smtp.client-ip=71.18.227.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="wRt6i5N8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788835091; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6beIM0Su1eFg259xHdu6aLppSM3IuAgqBeGAf0Hsje0=;
 b=wRt6i5N84pMAv5jbhtS3bwDkDQb0VMZ5rXTihYcFUeTJodotCoZ7hoaQQBNgwPlT0spHYm
 KHAlqRZvd2Ca+BiUB6dlDh1JpmEGx7lDQPDDHBN/78J8neD44NOZvqo9+FxRks6uRep6Zp
 /U+oZ9K1ahRJeydRbSW4KDxh8ANMNjit/yaGg49NmGEhkbCOM3vrpeEvGUZ2HVduvd22q7
 uuIRBvBHTWLwu0KKKUS6pyOjqh8L0IufEDm4ohgsckf5R47kSTIpfOOOj6wwEWTTetQX82
 CfmK6nS5FtGoKKvkJiMyb1IaT5X1kfoFsqGcseGT/AMeCdKcLTeR1vAKWppMhw==
From: "Shengzhuo Wei" <me@cherr.cc>
Received: from [192.168.9.107] ([111.42.148.30]) by smtp.feishu.cn with ESMTPS; Tue, 08 Sep 2026 10:38:08 +0800
To: "Wei Fang" <wei.fang@nxp.com>, "Frank Li" <frank.li@nxp.com>, 
	"Shenwei Wang" <shenwei.wang@nxp.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Richard Cochran" <richardcochran@gmail.com>, 
	"Troy Kisky" <troy.kisky@boundarydevices.com>, 
	"Fugang Duan" <fugang.duan@nxp.com>, 
	"Lucas Stach" <l.stach@pengutronix.de>
Message-Id: <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc>
References: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc>
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 7bit
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Cc: "Simon Horman" <horms@kernel.org>, "Phuc" <phucduc.bui@gmail.com>, 
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH net v2 2/2] net: fec: free the PPS interrupt before tearing down the PHC and netdev
Date: Tue, 08 Sep 2026 10:37:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a9f7511+5029b6+vger.kernel.org+me@cherr.cc>
In-Reply-To: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc>
Content-Type: text/plain; charset=UTF-8

The devm-managed PPS interrupt remains registered until after the
remove callback returns, outliving both the PHC and the netdev.
An in-flight handler can call ptp_clock_event() during PHC teardown,
and a later interrupt can dereference the freed netdev.

Record the IRQ after a successful request and release it with
devm_free_irq() in fec_ptp_stop(), before ptp_clock_unregister().
This removes the handler and waits for any running instance to
finish before the PHC and netdev are torn down.

Fixes: 4ad1ceec05e4 ("net: fec: Let fec_ptp have its own interrupt routine")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/net/ethernet/freescale/fec.h     |  1 +
 drivers/net/ethernet/freescale/fec_ptp.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 7176803146f3..960b9f01c531 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -670,6 +670,7 @@ struct fec_enet_private {
 
 	/* pps  */
 	int pps_channel;
+	int pps_irq;
 	unsigned int reload_period;
 	int pps_enable;
 	unsigned int next_counter;
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..567ea2a46117 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -778,6 +778,7 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	hrtimer_setup(&fep->perout_timer, fec_ptp_pps_perout_handler, CLOCK_REALTIME,
 		      HRTIMER_MODE_REL);
 
+	fep->pps_irq = -1;
 	irq = platform_get_irq_byname_optional(pdev, "pps");
 	if (irq < 0)
 		irq = platform_get_irq_optional(pdev, irq_idx);
@@ -787,9 +788,12 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	if (irq >= 0) {
 		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
 				       0, pdev->name, ndev);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
 				 ret);
+		} else {
+			fep->pps_irq = irq;
+		}
 	}
 
 	fep->ptp_clock = ptp_clock_register(&fep->ptp_caps, &pdev->dev);
@@ -861,6 +865,12 @@ void fec_ptp_stop(struct platform_device *pdev)
 
 	cancel_delayed_work_sync(&fep->time_keep);
 	hrtimer_cancel(&fep->perout_timer);
+
+	if (fep->pps_irq >= 0) {
+		devm_free_irq(&pdev->dev, fep->pps_irq, ndev);
+		fep->pps_irq = -1;
+	}
+
 	if (fep->ptp_clock)
 		ptp_clock_unregister(fep->ptp_clock);
 }

-- 
2.47.3
