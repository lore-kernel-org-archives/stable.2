Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278988;
	b=B0CsycEPmYq1fY4VKdxO7nyB6XgJb7UTLQSWs7vi508rSGTwiNrBYWDOBcZdUgKUpq/t
	 YCLaqJa3vVFLOthoJoEeN+hFtEVMAUwPJWUO/WDbdvtZ8nAbRNPIBvECRh6iIixACUcgV
	 LEe6G6Jr1zNolAyTyOCPWWrhEpwy8wPAh6si9rWOTi6tOhRSjnGn0nbxlaTT/LIYqYoPb
	 AnMeU2ZLp7kYrEJtHtyFDEpzorb3bu1lBITMVU35BSe2yPn49MgbA1HcftCtzpP2V1PuJ
	 5BHGMcSMaXtLo9hbE5aDa0kbjsNHcrAwy9hRpHBxt08MXVkP0bzAXNeS/jlfK4CH+kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VECrxY45UuJ5trG8tbos4F3MU/+Myg/2p+7JwyJbLhI=;
	b=i1UUoWOkPe9MqthwcU9nmyFUTgCQrwAIyiV4Lopw96Rdfxq+eG9HwekGMoEScYpT+dzo
	 HhCUArzCtaZMRiTzYTOpzd+dXkM8HB8IehZgJqSMQLNZqzupDuIttOLTQLaHjpabOz8nW
	 Sbuv2TanX7HVS9hhiA9gnH23A9mzLoGeOmWxUX/ZosgOvdXtcA8kDOjNqlLRutmpvsPli
	 j2WxHy86RqiLz6rV8gWiZLb1bzJuChM/OMFOoP2VcbflUnXro4+rodyeeJjr/W4FDRO3i
	 o17D7tLc2/VET7Op451x2r/+v62YgTqLsKeiBRJa6HHjeS7puG5zvTMHwmh8TAFD6/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWPK62CI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AC3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWPK62CI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E0B1F0089F;
	Tue, 10 Nov 2026 02:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278987;
	bh=VECrxY45UuJ5trG8tbos4F3MU/+Myg/2p+7JwyJbLhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NWPK62CI/3Jk1HxAfGwN4a6LVwTZKSYDkJZg6O9oPE2B+6U5+1pamCsKfyTfrF8qF
	 4dxYrQ0GM2aFwL7aITC8Qw5Zzhnx/DsauxO/E+l/MX+XCxS0iaKD1CE/2wY0xIStTp
	 wYtTqMJnPLXiVUypq0HWuX6tjttUAmQDOGndXKqp0NVYcC7LX/y8GBy3MuYUbdJ2xv
	 fCZSH2Z1DdTz5v0rbmSS8mqlrTZblvdVRg/Q2+P7SLX4pOLJPkoqnVEInMSsde+il2
	 C3yaBYqWmDxGZ7NN6zMZVs6OLq8YSbDq3/DNIDPtf+x8LqDGJHLAmvLWv3hVcH9tTq
	 /Pyev/fVfzTNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] media: meson-ir-tx: Convert to use devm_rc_register_device()
Date: Mon,  9 Nov 2026 21:49:43 -0500
Message-ID: <20261110024931.3828324-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052820-failed-6.6-32999b8a9d5c@kernel.org>
References: <20261107052820-failed-6.6-32999b8a9d5c@kernel.org>
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

[ Upstream commit 12be815fbfd4c31aae4b23491b6dcf88a1e69299 ]

With that the remove callback can go away and also setting driver data
becomes superfluous.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 32999b8a9d5c ("media: meson-ir-tx: Ensure rc_free_device() is called on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/meson-ir-tx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index 437d2f119262b..be353d22bbd7f 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -364,25 +364,16 @@ static int __init meson_irtx_probe(struct platform_device *pdev)
 	rc->s_tx_carrier = meson_irtx_set_carrier;
 	rc->s_tx_duty_cycle = meson_irtx_set_duty_cycle;
 
-	ret = rc_register_device(rc);
+	ret = devm_rc_register_device(dev, rc);
 	if (ret < 0) {
 		dev_err(dev, "rc_dev registration failed\n");
 		rc_free_device(rc);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, rc);
-
 	return 0;
 }
 
-static void meson_irtx_remove(struct platform_device *pdev)
-{
-	struct rc_dev *rc = platform_get_drvdata(pdev);
-
-	rc_unregister_device(rc);
-}
-
 static const struct of_device_id meson_irtx_dt_match[] = {
 	{
 		.compatible = "amlogic,meson-g12a-ir-tx",
@@ -392,7 +383,6 @@ static const struct of_device_id meson_irtx_dt_match[] = {
 MODULE_DEVICE_TABLE(of, meson_irtx_dt_match);
 
 static struct platform_driver meson_irtx_pd = {
-	.remove_new = meson_irtx_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = meson_irtx_dt_match,
-- 
2.53.0

