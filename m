Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326320;
	b=xXAh/1BTcvUhBQ2Kew7rOBc+l/rkA0osAoDsgGBg7C3r9zdckpxOYGGSHxZ05JUNGbYZ
	 vuDrubUV8vnVQyXh4ogbuotn9OQ6aTQsYYgIH6bSejsOdyhMiXCi3eZmivBX0oAoanc+y
	 ttvP8AHTsiI7VqIszubJoTPOuEuO9ZBcPDhrHVlRk6bxjxNibzJp0Jw2R11ve9EXYduFx
	 CYO0wQ+YXV7LoiJDw2ArDgAea9cCwIdJtWjuBz8TRhkxCYGfneyTX6lTXoh1/j02SFKN6
	 Zykyze0W0O3EHAbetlmXL1PrffMJ7CsMHSDuZWtZV8PszDyLPhmMwj8/5D/WX0TD16w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iKMmpxQ1cuoq8xeSZCWkQSFArv40RWBciFpTZuRDtZE=;
	b=G2UCnXmTRPRwFMju3JJTg3xk2sw2bQ7gvk1actzfuThh85JkGp30evBPlQQYHs1bWGm/
	 Zy6ICRuu81yhqigLyUDF7FhZPV2wVttGVrjyqUl1doVXGJprKFYNvc/ufhGRtgcahw49K
	 D4hu2mSjKZo+5pyjcvTGMSmMttJZZgsoOTTp2AGKNvAzqPZ4QAxL7ix1g8wScBs7RvuMo
	 1+SB164PCRScmIN5jDJJE3Q55M4S0EiPa32yf57zEiDfd03fFXpuLdzZDgH3KMKjplC7u
	 xXVBHHjgO3wCDwGFOnrzlPQAQoulxh5tlZONotvCRXohLqFymL/VY0lglkUfNGR+n3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiJXRe1i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC862606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiJXRe1i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6351F008A1;
	Tue, 10 Nov 2026 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326319;
	bh=iKMmpxQ1cuoq8xeSZCWkQSFArv40RWBciFpTZuRDtZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eiJXRe1isv/jFRK1qnBzyX6TO3uZghVssdgoQlFpOIpM5h3z+C6MWt+Y9SOKNm+8f
	 XrxZsTu38seyyJo2QHWN+8NRBUfQMZ8CGwSkZI4co5HZHtL2tUTbkZHGki/mCybES3
	 qaQ4i3MZ8Ob6zuKkDAEQkDPpj4ZaXznAd8ahNUF1K+utV01MBsF/j2b9tUHmicTG5o
	 aPzuBYfIjNhfrmH9p7h2LQ/Vs0cAXkEJuFP1WQm59kgE76IZmHsL8uSlOGE5fei4nb
	 5+OB6ETbkltL4V5anfzuEpS+Ux+vx0xpHNcXoaWDI8xICXfY8vBW8oMp4GQBrg2k7C
	 p68+WJ8GZyVtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mfd: twl-core: Unregister the auxiliary platform device on unbind
Date: Tue, 10 Nov 2026 10:58:36 -0500
Message-ID: <20261110155817.2340846-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110155817.2340846-1-sashal@kernel.org>
References: <20261107053012-failed-6.6-3c5c55d979dd@kernel.org>
 <20261110155817.2340846-1-sashal@kernel.org>
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
[ sashal: Omitted the goto free to goto out change in the absent clock-device registration block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 352a1fb88f08c..a9f5af0d54dce 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -690,6 +690,11 @@ static struct of_dev_auxdata twl_auxdata_lookup[] = {
 	{ /* sentinel */ },
 };
 
+static void twl_unregister_device(void *data)
+{
+	platform_device_unregister(data);
+}
+
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int
 twl_probe(struct i2c_client *client)
@@ -725,17 +730,22 @@ twl_probe(struct i2c_client *client)
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
@@ -755,7 +765,7 @@ twl_probe(struct i2c_client *client)
 					 GFP_KERNEL);
 	if (!twl_priv->twl_modules) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	for (i = 0; i < num_slaves; i++) {
@@ -842,10 +852,7 @@ twl_probe(struct i2c_client *client)
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

