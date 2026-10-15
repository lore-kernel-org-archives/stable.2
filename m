Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73453914F5;
	Thu, 15 Oct 2026 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029234; cv=pass; b=JtF8DZeEmUvtwQ7BPxhxn6otSJZOqCL8rwOuCTiOOU5zewGx3vzOn9L/i4Sc2GdoJuX4t73bwqNtS2uv8/GRqnRXwpmrmNSImkr26mRpQrtj5lBphZ+rWChFw0+HXISZlHdH0VoZ/OSp17VtlQbYM1FKhJzGVJjdHoIV/Qc2Zgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029234; c=relaxed/simple;
	bh=ya4HqDX4Pea6NM0g3mMaYiqbpeInS8nJsITAiYKW6HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2y/piNd80Nkx+1yProYhL1DWWKZJWGbxHewC7nG8qk2tNWA5XFnSiOB1IuraKJp+sO3wI+ofzmG+xy8poiPkpC7hjDKfydkxqvRjftDKWvOj9mrGLSvU+3y4rhMJO1fPgsrUyD1Cy/CeMXJIxo36a8ATxcQdeti2x5dByOksDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=QGXxlLH8; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="QGXxlLH8"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C40412027ED;
	Thu, 15 Oct 2026 03:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=natZoWvXEwM/+w/iTTXvTK4H4Piz5l6/7F0ADLZ9BlQ=;
	b=QGXxlLH8IvSetva1Nq++IgfA8XN9boHmF2r/Lc6F+1Zv+vvCTp1rKYgwAZmZV72NijZfYe
	EVJwNSGrWQDvAr7ifsI1VAfsnWMU/HUMBaY44DP13gjYPETIS4Xc/o0ybNTbHu1e1KRQdH
	GxjEVNmxvHAGven0WFYPWf8tDl/55ucD75uGCxVYMJHrjAhMwZ1vh4jyf7499je1jmXr3w
	8YdIWdFT0o6jHU9XNzX8ZEqBdMJ34w1YcFLWro39sMo9jfE66ElRWQ2B9XH7oNmIuNEPjn
	yn5N0iQYQCDtvSwzxgOa4PAtIswEdOuc3qVNfp079HG+xOMitx6EgZOsM2U05g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029222; a=rsa-sha256;
	cv=none;
	b=LsQmmlLh4SlNQTnjENn2KATr/6NJ7EFBeyKhkiA5OeNDuZmRk2tzHyGSqjVZGYW0LhGr3q
	4l190oIbLxQB5AVNWpf0jyhN71o9weT9zzsTnLS3OvaElbza2GiDtdn+JdECTdPFAxq/Ne
	Uzigsj675sSNaSkDVkDUJUVgmcEU/A4oquH7aeeniGTUGo4v3D0efm72MjR1Qys/GI5tx1
	o5pMoTNH1V4mqtzOaRJ1NeyEW+qYBp2Vy+M2I4+rYH4sugD5bODSt1inSFOGhnpdVtZkE3
	eaATH1V2KmtAHx2UGVxaUe4DlEbS88vzF1bXkkXxa0T1+bWyV1g6lhP6dg0HQA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=natZoWvXEwM/+w/iTTXvTK4H4Piz5l6/7F0ADLZ9BlQ=;
	b=ObkYRTftGMmGQLgjSJs8salRJhxJ6q/YocDQebOqqW98DoA5z9arrfzYR4BwrHZisJ5G1a
	nC8PoL4cVpLY5duIY2wY8UxobdPg0jTDzGqe4yqZgSJUASdiRFkvUv2is9Se5iLwvHQX9V
	U3qY742mbVvviMTOzjvAncVqBpoROOjL1JtBhA/UIrz/sjyEUehpnCpDmu6DgynSW8q9ch
	jAAkuc6eLEZPBUC9pA4SvlbhFe2+WhksEZU+GhvQHJgbU6AZmasbrBtv6L1X/agHfezG5J
	ZFYDhp8uUOU0ZLwiG9zmKNRlyJb6Sn20MMdBgPR78ZaBcMNhVvX8KRE1HOz51w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf8-005wrp-2I;
	Thu, 15 Oct 2026 03:53:42 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 730FB5C47BF;
	Thu, 15 Oct 2026 01:53:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 35/37] can: sun4i_can: sun4ican_probe(): fix clk leak
Date: Thu, 15 Oct 2026 03:40:33 +0200
Message-ID: <20261015015336.816543-36-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
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
[mkl: fix clk leak in sun4ican_remove()]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sun4i_can.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index af52285d5a4e..76db6d09d1e6 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -812,9 +812,12 @@ MODULE_DEVICE_TABLE(of, sun4ican_of_match);
 static void sun4ican_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
+	struct sun4ican_priv *priv = netdev_priv(dev);
+	struct clk *clk = priv->clk;
 
 	unregister_netdev(dev);
 	free_candev(dev);
+	clk_put(clk);
 }
 
 static int sun4ican_probe(struct platform_device *pdev)
@@ -854,13 +857,13 @@ static int sun4ican_probe(struct platform_device *pdev)
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
@@ -868,7 +871,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"could not allocate memory for CAN device\n");
 		err = -ENOMEM;
-		goto exit;
+		goto exit_put_clk;
 	}
 
 	dev->netdev_ops = &sun4ican_netdev_ops;
@@ -908,6 +911,8 @@ static int sun4ican_probe(struct platform_device *pdev)
 
 exit_free:
 	free_candev(dev);
+exit_put_clk:
+	clk_put(clk);
 exit:
 	return err;
 }
-- 
2.53.0

