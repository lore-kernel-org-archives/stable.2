Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126297;
	b=rGtmax85Yke9xf+nzuTmWx8SojbOjg5Woy+J3YeMSqhrxtivR2cX3Q66r6mVN50Le2Mv
	 t3WqFjYYWiHyjbdE0OmiuMLbX55+1WUPTrULfnNBiN6NE1KTKnA/nw3V62DGp7RID1ZAP
	 ef9GFq4FkvfjPhWgToTUvgKXN7PR/Q7IPKIkz25hipC3vJ+4MDY1rF19m4PbQyKiF/vCH
	 IWYE7NmGRtdeBmwE4Cf6CFCk7VRbWxMOfRabxAyzhu8/cT4uFmZzqkxLJbYxiHh1T2G0b
	 L+GhQBENl+ZBDf9DesHqYhYqV7Z/7KnhB9ouwZpfSj7xuGxXhNI/vyU/VQDvqseAdzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126297;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BmJh/8mVuuIOG26rB82SSPlLs8B3gPKtQkodZyFnqFE=;
	b=i/i8y/W4MVJPmiD3/XrVeOxAzDSwDQAu9mpFlE/jUw0mDvGR7aXxi2ODP4emS0+6chsM
	 yVfCVSxlGBfjfOTBYVMQZOprNq3CdQLZqI9ewNQYRDh5+8vYhedY7/V6O5uH/TmaNF2Ph
	 jlUqkmgH7EOL+iGJT9O4pq/b8Tnga0Ci/4/ah4UVp27FMasfNoDm+aHwRwvqsVufUPB1/
	 08COfN8IU4CRyUGUNdXLQ1+Z8aYPvruT4QADG3tjUrtVMKYRruM2CrOFMZx7OLNVMpXfw
	 plGyqp/KdfFiRX5cqCvH1xz90dON53ppD1RKf+N0smjEO0nsPwn1PbewxcwYVxGCe6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="ZUj//F+b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9A60A2614;
	Thu, 19 Nov 2026 22:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26C9A60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZUj//F+b
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3C3E1205B36;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmJh/8mVuuIOG26rB82SSPlLs8B3gPKtQkodZyFnqFE=;
	b=ZUj//F+bBeqLqyuNjpsDo8kRxrznDGpjqALELff5BkFQZriRsutolGyL9BCKKpeJli06uN
	3Ar9QLvdoohX6xK44B8Kmt90xeiAwQRkD0VhSRBo+k2OAi6LSvb4kV26QhsuDjUE9fnsqN
	40qUEfc5qh0v81ArBWCfzCjY+NLhdlpf/ADsBBibTiTH7FC2eatV1fRIgJMGmkuQfdtu+o
	2Ha5ZWlgiSV3OtwSRuRVWitPgq6MVEUy18oDBEBLSANq6ULbEB8Rb6U4uLfe/Ep85BgDOF
	0mUVE+FhDT56ddwayMOv6e1OG10c3HYTTt8CYdDIdNWmI0Nne7MjiPcWuzrIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmJh/8mVuuIOG26rB82SSPlLs8B3gPKtQkodZyFnqFE=;
	b=ZQFXQwJ1Ya4hKKQ8tdqeZJW4WZJZz6IQ87au+G/udUJaP8JTB/v1khbuM0p2S8B+qyDLDR
	iQHDQ7pdgpHpStZLq4n98LY4gE9wdzu9J5Un6XT+FduuB9eWRTmbqkEjB45gxq4BmxqXNv
	Y6j3QvYL0/qNxY2aEdc51g9c4Y2Ua/G4IPPq8rdOOU/B5ofy+E6c/ulKfUlRfjH2Hou0kV
	v1C114/lR5gh909iqgwD3KsrCyWOrnekt1hhgrTDVYV/NikmCSEWy97F/omqpJ7WFep1yB
	R2xsEPoJQAq5dOFnU4uZco/nBGRzJbdCmS2FM/bqOjxURz1LNa8CyGk/tqG+yw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=E1CeLr8m+HVLpE+eyGorsaCkDn8snwkG5AjxIWJW5X7Ednc6heqc1i/Cm5PvqYgyB9lBf6
	BHjXCmPcWg5HwnYAHZ7rDJlJ3pgWBKdblLLTLc2HBE8+bs135IKuk6HjL0xxCYa0wrtihA
	CEsvfd5n3NkdCPRZi+L1+OJ8iODJ9k7zPCYnwGDucchIDEK3w43jWEfqSliokHjJKtzK8T
	skEETVT+3/U7meivRwyg+Azw+0i0PcPTTIlPs8rz+vw3y4dkctusVzcRkdQ2hxIdF0LnDy
	jKu2BiGplz0s7sgAOMSgL/UkLbjV4U50A4fS7YTEk+II4uiiCRH12NBmojMCgw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z6A-1q;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D0EAE5F0998;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/13] can: sun4i_can: sun4ican_probe(): fix clk leak on unbound
Date: Thu, 19 Nov 2026 22:58:41 +0100
Message-ID: <20261119220936.155728-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119220936.155728-1-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
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

From: Wentao Liang <vulab@iscas.ac.cn>

sun4ican_probe() obtains the CAN clock with of_clk_get(), but neither the
probe error paths nor sun4ican_remove() ever call clk_put(), so the clock
reference is leaked both when probing fails and when the driver is unbound.

Use devm_clk_get() so that the reference is released with the device. While
there add support for EPROBE_DEFER to the error handling.

This patch has been generated with LLM assistance.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20261103100520.1309743-1-vulab@iscas.ac.cn
[mkl: add EPROBE_DEFER handling, convert Assisted-by tag into prose]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sun4i_can.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index af52285d5a4e..2a169dbf7813 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -819,7 +819,6 @@ static void sun4ican_remove(struct platform_device *pdev)
 
 static int sun4ican_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct clk *clk;
 	struct reset_control *reset = NULL;
 	void __iomem *addr;
@@ -844,10 +843,10 @@ static int sun4ican_probe(struct platform_device *pdev)
 		}
 	}
 
-	clk = of_clk_get(np, 0);
+	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "unable to request clock\n");
-		err = -ENODEV;
+		err = PTR_ERR(clk);
+		dev_err_probe(&pdev->dev, err, "unable to request clock\n");
 		goto exit;
 	}
 
-- 
2.53.0

