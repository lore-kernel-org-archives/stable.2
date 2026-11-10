Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327397;
	b=pE1rcz5wozcW1RhmGkuvfep+h0h0ukRkhhEVgMYcjj2JiD0dDF2pxMkizOQJfQVisCMF
	 gxTnqW7ClV5X1bU4DfRb7kNGCeXEClAGRFsa/vZ1wFYlsWkO8/5rxi/sBAfErYOPTAMSS
	 lAMH0srk8MaV7i/3ibcMKi4Y5jZMQKqHJ38Y0/cF1w1csay/GzHPvl0GNtMOKvy7OvDtz
	 jUiVSxDGV4MSPZwPdRXWVxxVZ2GKGhRbRgkKPEB2fxoX0REW3suYsMtG0/rY3TnMq+YDT
	 Q3xSFXGmC5M9/sLortSoQsNBbEzWOz2gXfkQnLR/i2v385zF6cCNFYfLKwf6lwHgvkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327397;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z2wpI1Qzgb1ZuDnEoA7yuqSe2xaXYgZZxqQndM/jXEc=;
	b=Tc+M1CGmEuHNRdAE2onlJ01pfN+LGR2IdlzvHmz7OWAGaslScx6UIsTvLfixPyP6WzBw
	 dQpOY00cBBmtE+wrC+qh5j2XjWa6rEXhP/EtahozUdhh2KiKv6JnpEyqFNOvTRB7zKyvz
	 tkWRCeryavs+2guTAPR1uNvPbv0FTqsRgI/V7z4S7+K2vwGY1cz5sPytqO/DrVqZTwH7t
	 IOE8kxsyu3M0lF8Nzq462RU1s7rXD/IpvFFEP0RwKlhBxyDTWKVEdPwkItl8AYdnXcu4x
	 eQGBU90/At0fyfgjDDU2Uw9bEWVtw122VqxNOyPkDmP9FxXmQpSYsF3JzEgpcvTXZTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L7//U5LO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE843606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7//U5LO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA111F0089F;
	Tue, 10 Nov 2026 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327396;
	bh=z2wpI1Qzgb1ZuDnEoA7yuqSe2xaXYgZZxqQndM/jXEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7//U5LO11mmGnzEHpOLyEZI/VRn7UgOZllFrsSffvmU9fTQTPjdcG0cqm5xlIBPD
	 ON93Q70h9Tb71ZDt9oMZnPlSYeT7fAjJ+0laDZ6vJVkdOZ0l2tTek5Xk1ATtwFAV4F
	 p4B2KoODafetzB88gq2JIfWu07hyZmNkUYRH1P0JjNiWBIJan9a9SFDXHsYyVBH2hO
	 i415GXo9r8hBlr/t12RbVYZ5MIUGNQqG7eZBJcm4ZVlG+eeIH+1DhOauAYDDsdNUpM
	 Y3fw0qzCDK7FeWbjMPejndwXCkUCCHh22JEGv9e4dMDRHMieOQaXGAIavIck4NUf2t
	 dLsRtB/l4e0Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] mfd: twl-core: Unregister the auxiliary platform device on unbind
Date: Tue, 10 Nov 2026 11:16:33 -0500
Message-ID: <20261110161605.2449325-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161605.2449325-1-sashal@kernel.org>
References: <20261107061659-failed-5.10-3c5c55d979dd@kernel.org>
 <20261110161605.2449325-1-sashal@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 3c5c55d979ddcb0765ce531bc7ba173c87c8712a ]

twl_probe() registers a standalone platform device named "twl", but keeps
its pointer only in a local variable. Probe errors unregister the device,
while successful probe leaves no way for twl_remove() to release it. The
platform device therefore remains registered after the I2C driver unbinds.

Register a managed action on the I2C device immediately after adding the
platform device. This unregisters it on probe failure and driver unbind,
and also handles failure to register the action itself. Remove the manual
error-path unregister to avoid releasing the device twice.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: defa6be1c821 ("mfd: Fix compile for twl-core.c by removing cpu_is_omap usage")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260913205013.54777-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
[ sashal: omitted the devm_mfd_add_devices() error-path change because that code is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index d5e588c68c0c5..57f89771ae098 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -757,6 +757,11 @@ static struct of_dev_auxdata twl_auxdata_lookup[] = {
 	{ /* sentinel */ },
 };
 
+static void twl_unregister_device(void *data)
+{
+	platform_device_unregister(data);
+}
+
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
@@ -791,17 +796,22 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return status;
 	}
 
+	status = devm_add_action_or_reset(&client->dev, twl_unregister_device,
+					  pdev);
+	if (status)
+		return status;
+
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
-		goto free;
+		goto out;
 	}
 
 	twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
 				GFP_KERNEL);
 	if (!twl_priv) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	if ((id->driver_data) & TWL6030_CLASS) {
@@ -825,7 +835,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 					 GFP_KERNEL);
 	if (!twl_priv->twl_modules) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	for (i = 0; i < num_slaves; i++) {
@@ -912,10 +922,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 fail:
 	if (status < 0)
 		twl_remove(client);
-free:
-	if (status < 0)
-		platform_device_unregister(pdev);
-
+out:
 	return status;
 }
 
-- 
2.53.0

