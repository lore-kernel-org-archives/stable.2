Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278988;
	b=DyzVeWXjKutGugDAafoLbm1FKArAwtpbznfRvAtE/O2A6GDSR022UD7J8YJ+Ktag2pG1
	 DJ2v1lY8fs/CwkmWzrD6CMbbc6wF06aa4rPZSLgD5tJ1splA0noPs3S4FMcwwFa40lp4L
	 qyP+2ghJx1oWrY/RDPJv26rfwLmZBFWlthf38QKVO9LeNyIrhCdiuZztZ6BHpiymPyqnQ
	 GSrVRe77QRtlsGCcxSlK8InFP206MLUaPbJSpB5oCpxAHZIyRHJKhjwYDfoN7FoMFK7Uo
	 eKvmsAu7PTwIzJ9CwxcQSe2uN0D/lldff+lMvs9bVxkieA8x8BwsnvNc0hZtzCgmRvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SUKJS/Mx5GbDeC9Ai1/9xqR55z4suhQLdwC54ble/dk=;
	b=OfbBLH4jCYbzczskVkJ3p7l+ufq97pyiv4PwUy/ZANmwmUGgP/wV7FTyRG6XVjHWKrPb
	 sQJ3D8TcvGt4ZN+h19CxyEGz7YMDbpcgHRgIEqLNoZe0gpzy5j5aTbliA8r5sTko9ZM07
	 H5A1BTJbxGhCln7S7Y8OWt0peJc3eIuhd0Dl45zIaDk+phFMd/dkkRCdqVvG8DaSeiTgz
	 fDPqkM/CexWJURhbX48nKqUBHpa3KWJYBMC28YSuPu5xmSvMhhqQZhyegOkh3iFH5a3uD
	 9CaWPT3Htvztg3vMvMaSWqzZQPaue15wuVUOC5QmPWmjBrRMxAojQFBYZMusJqWW9Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2LJiRE2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FF606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2LJiRE2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6569F1F008A2;
	Tue, 10 Nov 2026 02:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278988;
	bh=SUKJS/Mx5GbDeC9Ai1/9xqR55z4suhQLdwC54ble/dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C2LJiRE2IRKfUGFLYGMr3fKoC6Rjtrdu/6d/fdu5/w7UZC7hcUgsHwF6yDassCBrQ
	 UR/DHWmY+6ueAIXHUx1KMFIXC3Ka3/YyN1h9erdX+/Z9+eNIYtozcMMIbko+PU1rpK
	 dDsqSsKjOv77iYLtooyMHp5iSVeAQJg9AUcSPiNU1HkcUmci+BNnkxS3hWfDqVpsRk
	 lbjCnklYDPpAuOy7VilY0aU97liwz1DBO1N9/jaSnV10tG0Hfewq4pf23RmrVXOHKn
	 YQ2a7Kpy1l0SArM3CKgeqQTOL3rIV1FWDl/v6sYI+mvKLCbSzau8VAHMF0uMQPsKaV
	 6VRQbO1qn8ljQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] media: meson-ir-tx: Simplify and improve using dev_err_probe()
Date: Mon,  9 Nov 2026 21:49:44 -0500
Message-ID: <20261110024931.3828324-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110024931.3828324-1-sashal@kernel.org>
References: <20261107052820-failed-6.6-32999b8a9d5c@kernel.org>
 <20261110024931.3828324-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 9af7c980f3ea3e85418beb25dc4d34939183e436 ]

With dev_err_probe() the error paths can be implemented in a more
condensed way with the added benefit that the error code is added to the
error messages by name.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 32999b8a9d5c ("media: meson-ir-tx: Ensure rc_free_device() is called on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/meson-ir-tx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index be353d22bbd7f..94208f76bb33a 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -337,20 +337,17 @@ static int __init meson_irtx_probe(struct platform_device *pdev)
 	spin_lock_init(&ir->lock);
 
 	ret = meson_irtx_mod_clock_probe(ir, &clk_nr);
-	if (ret) {
-		dev_err(dev, "modulator clock setup failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "modulator clock setup failed\n");
+
 	meson_irtx_setup(ir, clk_nr);
 
 	ret = devm_request_irq(dev, irq,
 			       meson_irtx_irqhandler,
 			       IRQF_TRIGGER_RISING,
 			       DRIVER_NAME, ir);
-	if (ret) {
-		dev_err(dev, "irq request failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "irq request failed\n");
 
 	rc = rc_allocate_device(RC_DRIVER_IR_RAW_TX);
 	if (!rc)
@@ -366,9 +363,8 @@ static int __init meson_irtx_probe(struct platform_device *pdev)
 
 	ret = devm_rc_register_device(dev, rc);
 	if (ret < 0) {
-		dev_err(dev, "rc_dev registration failed\n");
 		rc_free_device(rc);
-		return ret;
+		return dev_err_probe(dev, ret, "rc_dev registration failed\n");
 	}
 
 	return 0;
-- 
2.53.0

