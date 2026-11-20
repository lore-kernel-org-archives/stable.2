Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795133258;
	b=la4j6ck8ouZhgUGpNPxaFAFDLimwJXmVlpZip/CawLVIUOTqdU5pe5jN90Et2c6rFSZS
	 n/0xAaHS3NfOMtVs+jpO4tQypKuUyXsveDy0MQqlLFk4qRq21bxdKJKTL81ntyUigA50Q
	 rROadY84vzexKL+53rEZubKW/3toCakC06TocmKDbY1McMJ/H4M/i3GIwpplr6C/Ifwg7
	 Onx0z/VnXMb8FZGSO1PHEGdO5ks0PPKzlj9qZolg+z9c1NxD+iIu6B6+Y0zgcG9qHuYFL
	 n1LzgrhCc5OBrerWPmGF+3Uqna0KnRitvO2M6pM1b4f1VgyvMrRkXSIKBFn8JeoEAhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133258;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kp6fkKnIImemnGcCbeJTUu/75Q8NuYHmcxO2NQ7WfyU=;
	b=UcxpdlqCJxnBZ4ehDg+Xetvg2OOaoJGlOt8lXo9HdZSIyLQDhijuzTR8zPToOq8BRUzw
	 dHgBs6bzKO+Gkd1jDXP7laltAK7vhbBOywNcdewF/DsgXwfJ4QCDTBbowMZKUJa1nLFZL
	 be8n6+2G/ODWIOBu2FKziEZseDkGvTBpHntFK9aJKnRcl00GbWeEmDXAD+0O7GfUEm828
	 +tQp94YOl/chLAI9/cHLS8b4ccZ+qW439prSmMb17rsXXi0vRDw0W6pkxZVkb4dCjFw5h
	 lnnld+FqxUKD3EXtRrdS1aFNnU4uV0zO/GVIAb1cS/WFIpMP/vd+op8x4SWSZoayOSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWA2C4NE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D7606A325;
	Fri, 20 Nov 2026 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWA2C4NE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795133257;
	b=dRF6pSxdxc2Odeyqrzc81G+J2x3cClSK4QhpA4awztwsvu0x5Rmi7x97EdlWJkVZa3I8
	 tolINWwm75FJDlL1CxyUVSy+SVlTbdw1DodW05Am72lDzXt60Me8ExGMzg+fHhS6U9kGU
	 Baf/ihiIfQVjJVtAqHtn6uwiyDzAd1LYGbrfZYIKDOFb35xEeb28aXRQQjlabszb24WE6
	 GmwmJB5GUOUVyqiBRN0OMizQ/UJH35ql5b9oaZ2RiaM3z3XebScasuywkDJmskskUwEjE
	 D/r2MFCneo9pwVeBQikWau+wsj0g1sK1xaY4zq55hK6XtwWUr1oum6fqXIpgf6tI87w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795133257;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kp6fkKnIImemnGcCbeJTUu/75Q8NuYHmcxO2NQ7WfyU=;
	b=gqfiSCWKHTT4YR8xztkDxd/kc6cplkQzFW/dKzG+UB9nnvSSI4dMDuUfHTuBueXK5P14
	 uBZ9x15jp2vIpQ4dl8hD1iKIUdqT8BmbDOu/KPvCUomDDa/ZPr0HaKr9xwZsbF0xgLngA
	 YIx5rcfte1Hr2nf2TjtjG8hDijBjBZpthVolzys29br6FHsPloIdvVD0RAdtEQ04lvMrO
	 KrIJ0CV1i+ATRocd2745v63faCIBU5w2RGENAsff73YoIcUytvQzkZc+JoN71Cw1PfMiU
	 JOpYkiJMLE8x74XN+WgYVuj0yUC4IJ2un4IEBB/Sgn0uLFiTF+0CZlumcMjS7mEY1CQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0836F1F000CA;
	Fri, 20 Nov 2026 00:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795133257;
	bh=kp6fkKnIImemnGcCbeJTUu/75Q8NuYHmcxO2NQ7WfyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FWA2C4NEUVDmhrwTvFZB/VTf02pzDsye4w3VMXOBc90et2+CQJ55YtGAFmlMRDkBL
	 TFkMJJcCCaqaEq4k8NhUwDT1FylemTJpx/O1vKDG3ELTzumowjEBql6fkfRE7a9mJs
	 QJwIzOamcbqeLcp2iVlRJwrlUMz8X7b0hvMF0f7l6tETHlONR53KSUg0QZXRH+xskK
	 qJiiRRce/41oPj3Kzx6YAr+xHQLHGKPy8b/Rgur+mFK5JPX8EcAyMu/pv0lgf3G66q
	 Gkwugo94zZPuJSF4nEsIZcMiYAZ8kdpm+amz3l92luMsTWFcOT+9NgedkuFytq5pZr
	 +iWEvJpvF3X/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 89F56424DC;
	Fri, 20 Nov 2026 00:07:35 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Thu, 19 Nov 2026 19:07:24 -0500
Subject: [PATCH v3 02/11] leds: rgb: ktd202x: Fix an out-of-bounds read
 with unused channels
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-ktd202x-et6326-v3-2-98b836b1cddc@telaak.dev>
References: <20261119-ktd202x-et6326-v3-0-98b836b1cddc@telaak.dev>
In-Reply-To: <20261119-ktd202x-et6326-v3-0-98b836b1cddc@telaak.dev>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795133254; l=1981;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=Q+4DpaSvY1AxhEa3mUDe02kBvFBM51CNN8lmDli4tPM=;
 b=ca/I6iY8wF50z9SzInW1G9cmH6hrhhaStUcyFzSzdJ3FD7Yfa6a9VN8dcZIUFO57fA2SzgJKd
 Z0jZWSWY004CwCEq3N4cp5O/x3p0WeEo8dpZbqxD3aUv+mRFujKwN1m
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

The LED array is allocated for the number of child nodes, but
ktd202x_chip_in_use() walks it up to num_leds, the number of channels of
the chip. With fewer LEDs in the device tree than channels, for example
two LEDs on a KTD2026, it reads past the end of the allocation and the
__counted_by() annotation hides that from the bounds checkers.

Allocate one entry per channel.

Fixes: 0ebdb7210943 ("leds: Add ktd202x driver")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/leds/rgb/leds-ktd202x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 539cf425cdb7..e7e44d5612a7 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -537,6 +537,7 @@ static int ktd202x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct ktd202x *chip;
+	unsigned long num_leds;
 	int count;
 	int ret;
 
@@ -544,10 +545,14 @@ static int ktd202x_probe(struct i2c_client *client)
 	if (!count || count > KTD202X_MAX_LEDS)
 		return dev_err_probe(dev, -EINVAL, "Incorrect number of leds (%d)", count);
 
-	chip = devm_kzalloc(dev, struct_size(chip, leds, count), GFP_KERNEL);
+	num_leds = (unsigned long)i2c_get_match_data(client);
+
+	/* Loops over the LEDs go up to the number of channels, not of child nodes */
+	chip = devm_kzalloc(dev, struct_size(chip, leds, num_leds), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
+	chip->num_leds = num_leds;
 	chip->dev = dev;
 	i2c_set_clientdata(client, chip);
 
@@ -562,8 +567,6 @@ static int ktd202x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	chip->num_leds = (unsigned long)i2c_get_match_data(client);
-
 	chip->regulators[0].supply = "vin";
 	chip->regulators[1].supply = "vio";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(chip->regulators), chip->regulators);

-- 
Git-155)


