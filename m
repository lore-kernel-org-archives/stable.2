Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FCF2264A7
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514943; cv=none; b=do3wtqrPUof8pck7Cjt+rGr8XzlwA0xjw8p46Gcb08+C9+rVnFJ0Ap2uFEdIdti3A5jERaR05vEU+5EVqpBVBq+3gpR/e9iYL7KjVoGe25zCYgJen5bldUvFF6F1kfakRiuZq9Olf3CvaO4hC08SH81Mw2maJnXhV5jM/Rgb+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514943; c=relaxed/simple;
	bh=DdZhBJ8W1LtMU023KxE5Hele8J2gb6rsf6k9mFbCsTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b93MobkUf4bvk4bYMzQrHjiORTHeMFRfGReenhI8tRrDbpel6gJ4VLwMCLdhFn0bylUPHq0RTQDionafhvdLlogCEbs7O7eITHeE1KCjZBG+RRxPxCwcxMUFoUw3yOceTBLyBXes3vKcCUK2FHfa7/rfsl5tSV3iyb19ga9i10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL54Sqq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL54Sqq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCF51F000E9;
	Mon, 20 Jul 2026 02:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514941;
	bh=mhc8pVPTq1UDju9bkrFFlfw57TTLWhSxsuOq7z7SdrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CL54Sqq0JFeSIvmJsDk5mKjmrTJ0B6MiVwNicBTC8afRaAZ0zKQQiyHL618FpfwQT
	 aOn+nWQhE/bBlSPn85KPsUYVHvfiIhrkWaADRSoGUxGofCwuY49/DKKw4nnGzGInwL
	 T+dcpPYdiNllHhKyqK5WUkZ0gJ+hIDWvAaQRo0gO/hUiVEc3uAtSi7IDe+7ZmNn6W2
	 wJoHuitQW+pgno5k3BlQ9cKVDcqQcoD5OejP+CqfFSzkGEAPRaqJyLSGENsDAnvEg7
	 jr1nKSh8IUeg1qIRG26vdombA0sozf5GC7S+0IIFfPwX0SUIE/IRCjZ/0lMH1dmzB0
	 XG9szVfcgrCDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] drm/i2c/sil164: Drop no-op remove function
Date: Sun, 19 Jul 2026 22:35:35 -0400
Message-ID: <20260720023539.2968115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071423-employed-mankind-78ba@gregkh>
References: <2026071423-employed-mankind-78ba@gregkh>
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

