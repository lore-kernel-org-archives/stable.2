Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627334E5352;
	Fri,  9 Oct 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553428; cv=pass; b=m1DyAzMrV0REyhcH6LmklKD9mMG9Ow9nQBrTTg1WA5TUTuAq+ZRf5qvLCGBV2kvCKCz2yxnUlxR0F+U/fsC5wWcrQ3wspvqdMDIsoSrA0JbzxqrPcC/lY5FkTsHi9JY/m0cF0KZsfI4pS0U2WyDN3qvHX++ru47t16o0cU9TIVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553428; c=relaxed/simple;
	bh=ZuTkF9uPk9LJH6KxdfsGDqatCbkNN/yOp4y5XxvAzoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lo63esFX68wQSFcZcsYTXX9Mx68Ylkrg4MAJMjf1l5/fg7qiF4cFysJXsbDiwYEfYj+v6b85T96LXiQO7Tcsh1vuJ+sgct4Op33JUwSynbuODTJoCzssYyu5idd6XXU6vg6/0LXLuJhrJKV8rWcyaEnbegRyTIKgcdEuaBl/OO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=WR4bu7ZN; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="WR4bu7ZN"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E68F5202626;
	Fri, 09 Oct 2026 15:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKvmJNaMDa5eLBBBUOhxQn1gFKNkFOfj6EK2Xcp2s6I=;
	b=WR4bu7ZN7gaBPMOQZG4RfUKDiS2KJ3cIO3REt/CFqGnAhcsUlywctLOWp235Kgit//h8bu
	1FxlFotVYiJ84AYo3NGT55Y1ai/rmr35uJ9+7WpFH49pYOVJdUhs3VwnJQDrCeER0HRaEZ
	roPVQ2mI2123HAhFz/6mFw9upL7cwppTNLa6rNGV+21U4m0/S0TKpY4IqywRhi6s1ZyEzr
	U7M++bgRPFDiQELNCO9Uyj9M7QDN6Lgj3bTxQELo5q+TR1QKLVPNkGokNRURQ17j1bN+Wh
	o7IKMwdLpUIqpyAC/Vva/2iV9D04oKBp6PG1D1uv259zi4jon5kOfW9nkoeW+g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553421; a=rsa-sha256;
	cv=none;
	b=IfLCwtvHGzsHuO+iwhEWybuuSMkiWwTRiWwM5W+gh925zJSOlf8IsAC+uNdiRHkmuww48X
	SsYkXAty/lTZixoY7H7XgKXUA0UyhW2tqvk8soWzwBOMSMy/EeCs3wuI1caii9yUB9xDzS
	uK1mZvgFbjQ0bSeFBNH1NWltYrjhu5npkaLnGbvkEgJ4DMh5ODTFblXdVR0gjY38S/k7IV
	5eLmM1kuHukIos2JnyKc1QMaVZ3JX+2H8Mx314FDWD1dS7Oig4qvB+4p7wAOaL78m29j0C
	QK9pWJkldPtMXs4MQ/VdvSKfi2ikI8SaYNh51iD4EDVY51fOGRtSFWlswfKYYg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKvmJNaMDa5eLBBBUOhxQn1gFKNkFOfj6EK2Xcp2s6I=;
	b=Nk/fFym0wKvpBmgyahT2tgYr1DMCr4Q41uPfjjOhx/ZecnJJY2J/2y1yMZBDxR5iYVxNcZ
	26W3iLcwpOtLmg5ErOOtrnw76dblfK+X15Bsa15Hi4j0E7ckL4YrSUjliHnt5xKnavknqP
	NyjpODkf2Z1a5unGKuIYc8tudhAK+NhTm4FllcfoukNfQbz1wWY6EXNxSOTD1eqnMxt0j2
	LiCb10emBbCUwIyJzUg9r0AVfi8NXFdTCWPmf6uWj+CPe0fmduEmOyA/FhT/X90XNqZICo
	CDsqG5l/1teZ9egyaixP2Z07tqoML7gKzPAM/VHj8gGxaptHL+zW+3h0yZOXgw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsv-0053Tk-2k;
	Fri, 09 Oct 2026 15:43:41 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6EBE85BD8FA;
	Fri, 09 Oct 2026 13:43:41 +0000 (UTC)
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
Date: Fri,  9 Oct 2026 15:28:07 +0200
Message-ID: <20261009134323.64064-36-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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

