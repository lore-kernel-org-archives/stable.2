Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CD4FE2CB;
	Mon, 28 Sep 2026 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624010; cv=pass; b=b5Hm+eaNDxmULoGQbMRex0oIeUhuF4aW0itEmtqqfuv8rz2vywMBpdX13d+Q+a9HHobqQoX0sWeH8XfXai3Hz6rw0UORw+hRYege/d4Gs3skPi5i9mHIZHOdfYkx+Si4bcFALa4d/lB30ggTkNfXcGRLl/xoCnfFLg2V/29+sDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624010; c=relaxed/simple;
	bh=ZuTkF9uPk9LJH6KxdfsGDqatCbkNN/yOp4y5XxvAzoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLtn2FEyqNPYuMNZY8lkuHdOWS96Cem2N8YUtTFVaUD03scpqy9sQkGGR9fIJWgVr35kVzSF5WHOT/uc4SwiKgAmCxV6kOunty4PrDxQGZ4blc0pwRVff44IRlZNPHWD0sAvdD6cdUsZl5e4nXs4VT2ZvwjC+KCQ1fEf5f/EQwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=QGiHMIux; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="QGiHMIux"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6424B2020F8;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKvmJNaMDa5eLBBBUOhxQn1gFKNkFOfj6EK2Xcp2s6I=;
	b=QGiHMIux2YU+aJNKmeKEKomH/33jfPC6uHPOJaeL5zXn96WCrWIZaEFNY7aitix+ZUoP6c
	Eho9GfGvml9HX4eUwO3P3J7zg86CfrFUhQ2fqga4iH5M/6CvtI4wvbhOCNKZYg5zgO55IH
	bp8gScHkav5qY4idK8rmoIPsRdPszbMDhQTqw1sK+cpki+DW2Vx2w5A32PqlfTCGFTSzBe
	owlheY0Lat3ZJtKsOJfmU3sPGfJomgcHUKs897gACIMykV0z1TsoTqe1cwepwNDk2eYSK6
	g2MmJSUkSJuPoIsbY3cJ8nMRbGdFQqVq4fKxBXL1SQqNvFZBTjMa+vPUq/UPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKvmJNaMDa5eLBBBUOhxQn1gFKNkFOfj6EK2Xcp2s6I=;
	b=S3SMHQc0VDpPpOlZlTyZpTbcrW3YJpURIgw821tEM8tsLRB94WBppCy1CWqnBXH7JgaObV
	tlizZidF56Ue+KJtuZC43QUsggW8+e2NpbiV3K5VKxi2j7Dpm9FLFdo0N2iNNH+bsOjBsj
	phCtFGPpT/Ao+HMcokcivVqzHET2BULdv77EK+GQ9WHWDHqFTmUJIOGPY398DdJAvKpRgB
	IOag5hMppXwH7O9O+0nF/6CMIkBz/Z4dtJdXQNyunpuDCBDnsVHVrUojZJq0PhrgNQum52
	0k4Ubqbwg6/fKm9NrYPN2mMAhADjrpvyT9z08WAXyukoamE4kO3nI0SR31ywaQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=c/cGEtbPkeJSkyDe3OTSCobNdRJutcGqaQs36kHxAYUEZS2H4XPqsGEQKgOdFsJABrVI89
	cQiqn+exH9AtyY3R7TWfjc8LiX45rmFTuDdFfZmbvhntsUEJiGIyMqDk2gFVotJ9xAYct9
	vDBSLGLrnOpsohdI5ZhnPaWwqvrqaGfLvvqNym2gXiZ+UzCJz9butqb2QMhJ9csQoiaEu9
	qa18a6L0QB5/uelpVL0i36IQgLt8k58LtaULwDLuWLbI3DjspK3cmHdDAU2kYuBapqUTh3
	6Elc56t2EJ6aE+o4wjg0KV1FgSBhNwmIbYGrw+gGKzzIrM1ejFlw2DOR2d/kBA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6N-0i;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E8C2B5B1554;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 13/22] can: sun4i_can: sun4ican_probe(): fix clk leak
Date: Mon, 28 Sep 2026 20:45:20 +0200
Message-ID: <20260928193312.553632-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

In sun4ican_probe(), the clock is obtained with of_clk_get(), which returns
a reference that must be released with clk_put(). If platform_get_irq(),
devm_platform_ioremap_resource(), alloc_candev() or register_candev()
fails, the reference is never released, leaking the clock.

Fix this by adding an exit_put_clk label that releases the clock and
jumping to it from all error paths after the of_clk_get() call.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917104514.2147347-1-vulab@iscas.ac.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sun4i_can.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index af52285d5a4e..311526107ed8 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -854,13 +854,13 @@ static int sun4ican_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		err = -ENODEV;
-		goto exit;
+		goto exit_put_clk;
 	}
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
 		err = PTR_ERR(addr);
-		goto exit;
+		goto exit_put_clk;
 	}
 
 	dev = alloc_candev(sizeof(struct sun4ican_priv), 1);
@@ -868,7 +868,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"could not allocate memory for CAN device\n");
 		err = -ENOMEM;
-		goto exit;
+		goto exit_put_clk;
 	}
 
 	dev->netdev_ops = &sun4ican_netdev_ops;
@@ -908,6 +908,8 @@ static int sun4ican_probe(struct platform_device *pdev)
 
 exit_free:
 	free_candev(dev);
+exit_put_clk:
+	clk_put(clk);
 exit:
 	return err;
 }
-- 
2.53.0

