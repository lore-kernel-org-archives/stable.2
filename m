Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320222;
	b=0dNaAs5xKM1TUVE2Om5BPItKbagRefntbxAbiuHzuUCcBTb6Brf7vPnJ+B2fJoIArkf2
	 3yVCwn3TG6Vihw1G65JlVallPApDSVWN4EgAiOe6O9FMfviHxXcN9JLW88zwotcQBptfG
	 Ben5AdcJ4yrZB2Cn6wWT0aHQn7121texKmCfjEmz+qkdFA6N5GwEhQ5jcwrp1sxqeC/eD
	 v310ifVQ2aMrunP/g1dTe7W9twhHhIIew6QAdhNk1usTq3b9cJKb6/26eAQWeLTjwyZBs
	 2NSrDBE/HP/Sounx8xrhi73CGhR8Ff2HanQxVOLa6eGNz6KeYgVVVa++Rm0PG2IxYtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320222;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qa/29eEaQlWfX5Ek35AMdbd2KJlpCgUiy2Mrnh1cZF0=;
	b=YvgMXiA9nlglnpbCeuVyYTWIs9xjs0UF2/d517qy0c9k7VMfFawcNyo9FneR8AD9CtTE
	 w/wCixdQrvHWrBiVq3yaPP4joOkajak+Ax4Bkk/xoKcRxnQls8wSS10dZkOkJl/de0ZGs
	 CKFtxNvfQumcO57P9mPKo6JuY1v2rvDb6SriCXsInOt9ZkUB1vVPxFv01aLshFIprnAy1
	 wpv1Z+b+psRilbR3KO8MYfjRRpYCAV/guElvF2F9WYJzBAuf2klR1/K9YutKLhS5DhFXU
	 rJuEe3CccoQVM9xnMbypl2gqvW7UAjxBKk1QX+ic1URUObqZr23nLjwKAXfKM8aNatw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2EkxB9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B2606A33A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2EkxB9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87641F0089F;
	Tue, 10 Nov 2026 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320222;
	bh=qa/29eEaQlWfX5Ek35AMdbd2KJlpCgUiy2Mrnh1cZF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L2EkxB9CGu5MCrcALe2ZGSQfYpVKV/oWO2obAI4fGUs5PHnY4G4wRC+OaC44juUPs
	 iVQqrNoUj242cMMFZalamHglbTnmDxVS2PkhBvc8/Alk/I8Mgp9encK5BSclyyLdXS
	 eic42VNmYJSmsZaPXI7+cetJPL2yF7F/L+d4k66DcblL5vwGUxeW2cdHhDSG1ns+J3
	 5ZgAqVk00GF1XXeLt+BYyghcNYr/zq7xvFx8n4v7brAJjHoDS4U1PAqPuOWKqQJqZV
	 OZHdwVB8eJxLaEJn5zDsioM772EM1dmwXTxyte0JJdtihXWa4njSH0m4QNDaNGitmq
	 xwX5llVKirniQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()
Date: Tue, 10 Nov 2026 09:17:00 -0500
Message-ID: <20261110141610.1852904-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050820-failed-6.18-09a29213bf15@kernel.org>
References: <20261107050820-failed-6.18-09a29213bf15@kernel.org>
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

[ Upstream commit 09a29213bf15630e85a375478832b074b2cfc5c8 ]

ltc294x_i2c_probe() takes a reference on the device node with
of_node_get(), but never drops it, so the reference leaks on every
return path, including the success path.

The node is only used to read the battery properties and to set
info->supply_desc.name, so release it after its last use and also on
the lltc,resistor-sense error path.

Fixes: 085bc24d1553 ("Add LTC2941/LTC2943 Battery Gauge Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917142127.2156568-1-vulab@iscas.ac.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
[ sashal: adjusted context to preserve of_property_read_u32() instead of upstream's of_property_read_s32() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index a1ddc4b060ce4..bf0b268b10bfb 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -464,9 +464,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 	/* r_sense can be negative, when sense+ is connected to the battery
 	 * instead of the sense-. This results in reversed measurements. */
 	ret = of_property_read_u32(np, "lltc,resistor-sense", &r_sense);
-	if (ret < 0)
+	if (ret < 0) {
+		of_node_put(np);
 		return dev_err_probe(&client->dev, ret,
 			"Could not find lltc,resistor-sense in devicetree\n");
+	}
 	info->r_sense = r_sense;
 
 	ret = of_property_read_u32(np, "lltc,prescaler-exponent",
@@ -477,6 +479,8 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 		prescaler_exp = LTC2941_MAX_PRESCALER_EXP;
 	}
 
+	of_node_put(np);
+
 	if (info->id == LTC2943_ID) {
 		if (prescaler_exp > LTC2943_MAX_PRESCALER_EXP)
 			prescaler_exp = LTC2943_MAX_PRESCALER_EXP;
-- 
2.53.0

