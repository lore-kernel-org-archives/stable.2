Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19425B0B5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514340; cv=none; b=tTYPhJzFOMR+XDokRGevACSrOjrKikaXWS9P3vnujMAJ6AfPEZFzkry3bQ1cMQ/BCRSoDP6b7yHU67/F+cQtfbhDdaGQmk6YtVP5+4LfQXvMPXUVgDlJ2RuiAM5t+IlHbZTIpoEXipIhQylwpzdywDunpYzzIZfYSjstuW2LcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514340; c=relaxed/simple;
	bh=DdZhBJ8W1LtMU023KxE5Hele8J2gb6rsf6k9mFbCsTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9lznrRAGsuX5t2JhOMoN0DC7i+9GY4ekwGRghXozf1t340aqyEEVGkCBUQBZSQEOro8GkyKo3jxF8Qn/Mxe2cx2qXQt6GvpgNEBYvMAwlWXTAV5jpzubQExnVmCwh4kPFxqP70QACLts8hU8WtmbFH9y7TZFQJE2oBnyapek+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC77GAGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC77GAGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175041F000E9;
	Mon, 20 Jul 2026 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514339;
	bh=mhc8pVPTq1UDju9bkrFFlfw57TTLWhSxsuOq7z7SdrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AC77GAGmwNE8422Czv1Y89oqCyNOUAezlb9B4lzhMJUFLGREpj0odvi6kvb/dt5o9
	 42HGVWE03mnuOczao+/aFj1egoc+78lHUQ7Bs/+remuPmwvPzVi1bG0JznpiPEI5Y5
	 IAghl2AXlIp9e2iNpjmUMoradwIbCFP5Oi2C3PssPs0y/48mUQPtkWQo8XJm2y5bOX
	 BetVT/TXjH86/oz7ZFZSQt6COT4eQKByU11VaU+mTpd01AWPpq91q8KUYIq9cELA6C
	 QwdlX/s67BVnOoeaCkqvVXt4/Vy82eC37mI/XNhghZCQyMu1BdCZp4Ep9jsDX//1/X
	 ELY1TA18PjLUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] drm/i2c/sil164: Drop no-op remove function
Date: Sun, 19 Jul 2026 22:25:33 -0400
Message-ID: <20260720022537.2927284-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071422-comment-stardust-654c@gregkh>
References: <2026071422-comment-stardust-654c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit eb09882d64807c24228ed1d005dbbae70860ca3f ]

A remove callback that just returns 0 is equivalent to no callback at all
as can be seen in i2c_device_remove(). So simplify accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 1f0bdc2884b6 ("usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i2c/sil164_drv.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/i2c/sil164_drv.c b/drivers/gpu/drm/i2c/sil164_drv.c
index 741886b5441973..1bc0b5de44995d 100644
--- a/drivers/gpu/drm/i2c/sil164_drv.c
+++ b/drivers/gpu/drm/i2c/sil164_drv.c
@@ -370,12 +370,6 @@ sil164_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return 0;
 }
 
-static int
-sil164_remove(struct i2c_client *client)
-{
-	return 0;
-}
-
 static struct i2c_client *
 sil164_detect_slave(struct i2c_client *client)
 {
@@ -427,7 +421,6 @@ MODULE_DEVICE_TABLE(i2c, sil164_ids);
 static struct drm_i2c_encoder_driver sil164_driver = {
 	.i2c_driver = {
 		.probe = sil164_probe,
-		.remove = sil164_remove,
 		.driver = {
 			.name = "sil164",
 		},
-- 
2.53.0

