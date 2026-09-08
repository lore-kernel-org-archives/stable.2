Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AAD57981A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885243; cv=none; b=OaKs/gREPNoAdSKGtYzlSfZWXJnLx8BZQXxvoAtlCUGzbBC6UmIRm3heb+N6WEo+HsFUC/nNhCOPHsKB2O001hiGvSWXQIt2WpSwNgXmyjx79hn17W1BV2JiLpyJai275UivkUsUkd5DGW8R2ecaVeUUZ4ei4/ouyHbJ7o4GhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885243; c=relaxed/simple;
	bh=YyFIg1NsOu0NtPYilkmK9kY41D3hnIge48BKVfmCSFk=;
	h=Mime-Version:Cc:From:Subject:Date:To:Message-Id:References:
	 Content-Type:In-Reply-To; b=DbmsoDJXF9HbRUu5iE15dq3H15b+6FN/ex940yrI+7aijTJ80Y6/8VqN3iCx/y0jERPxbjdG+XOzZIFXDCu0h86QBxxc8dqEYFtSTIKf7DnX5e/63en56xlng+rzLKA8divFa4akm5vIvCe0vFg473gWCfASXPI1y6oPO74syj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=KL56Ktev; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="KL56Ktev"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788885234; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HmJJWTtwKXJC2s3lconQn6RhpXL4dm6si2ig3DGVaD0=;
 b=KL56KtevjnYMnuT9JWwvK6IrTIICLZO/3AV/PujZEQoQbiPqAdIYiPpkD63ybyEBd3SL3G
 AZOb72dqiy8obOdzj2O1NlezfxnUR0kAY1OFgu8ue80ZYYvXELSapQeSLB195jeMcJS9w2
 PSyuQ1F3ARHL534lsYue07yCO3nOlFQifBYjeEhtA5JQfQdbyHRe6r/WO6nj0LW2F1xo2H
 f6rokY9dHydyrAWkQRimw3ucQ/JYrQoK2aEF0hHzdESnKcZnnx4nh0muxOzaYpRBi/krq6
 PZWAKAPQxCphq9nq0py2cyTH6hf/23oJazoOh3bCKC7KwOgkbzTRWNlNna1J5w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26aa038f0+287a16+vger.kernel.org+me@cherr.cc>
Cc: "Simon Horman" <horms@kernel.org>, "Phuc" <phucduc.bui@gmail.com>, 
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH net v3 2/2] net: fec: free the PPS interrupt before tearing down the PHC and netdev
Date: Wed, 09 Sep 2026 00:33:45 +0800
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
Content-Transfer-Encoding: 7bit
Received: from [192.168.9.107] ([111.42.148.75]) by smtp.feishu.cn with ESMTPS; Wed, 09 Sep 2026 00:33:51 +0800
Message-Id: <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
References: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Mailer: b4 0.16.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc>

The devm-managed PPS interrupt remains registered until after the
remove callback returns, outliving both the PHC and the netdev.
An in-flight handler can call ptp_clock_event() during PHC teardown,
and a later interrupt can dereference the freed netdev.

Use request_irq() and record the IRQ after a successful request,
then release it with free_irq() in fec_ptp_stop(), before
ptp_clock_unregister(). This removes the handler and waits for any
running instance to finish before the PHC and netdev are torn down.

Fixes: 4ad1ceec05e4 ("net: fec: Let fec_ptp have its own interrupt routine")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/net/ethernet/freescale/fec.h     |  1 +
 drivers/net/ethernet/freescale/fec_ptp.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

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
index 56801c2009d5..598cd8024123 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -778,6 +778,7 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	hrtimer_setup(&fep->perout_timer, fec_ptp_pps_perout_handler, CLOCK_REALTIME,
 		      HRTIMER_MODE_REL);
 
+	fep->pps_irq = -1;
 	irq = platform_get_irq_byname_optional(pdev, "pps");
 	if (irq < 0)
 		irq = platform_get_irq_optional(pdev, irq_idx);
@@ -785,11 +786,12 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	 * only the PTP_CLOCK_PPS clock events should stop
 	 */
 	if (irq >= 0) {
-		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
-				       0, pdev->name, ndev);
+		ret = request_irq(irq, fec_pps_interrupt, 0, pdev->name, ndev);
 		if (ret < 0)
 			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
 				 ret);
+		else
+			fep->pps_irq = irq;
 	}
 
 	fep->ptp_clock = ptp_clock_register(&fep->ptp_caps, &pdev->dev);
@@ -861,6 +863,12 @@ void fec_ptp_stop(struct platform_device *pdev)
 
 	cancel_delayed_work_sync(&fep->time_keep);
 	hrtimer_cancel(&fep->perout_timer);
+
+	if (fep->pps_irq >= 0) {
+		free_irq(fep->pps_irq, ndev);
+		fep->pps_irq = -1;
+	}
+
 	if (fep->ptp_clock)
 		ptp_clock_unregister(fep->ptp_clock);
 }

-- 
2.47.3
