Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320427;
	b=WK6Cl9ASOOahl2yBO6ikxPHA3nKUdaDPUTwwf0NJlxBY9fAHHds1QCazIhU9LHpUx4VW
	 NX3sIqpeeR6UsWbmo/zt9s2xuhvXPxP1f9wzdUJtfB2YKZTebz3dXfpzaKWRG3OYXYbSP
	 NEXozRywVqoc8aGGUBR+gMbgnTGr6trZP+2hHevNunZpe5wu6+BHeEXZwHUohAGUk33+e
	 Rorn4zs53+n2hx7DEihef3T1lJNmvUa9qmOByYo7N5VgrU7pI9eReojIxhy7HisYFFaJ/
	 K0ZPU4u9+ZlyH6AI0Ym8sQXmDGVX+ddaqMRDxotw55GxB9KFOvUcuM4w17WSONHbMPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320427;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QYX0h1W2E+oATJFxY2iCvY7pa9wXstnmyxb9Xo05WjE=;
	b=UV0wXYFnVYue+vppzEWI4z0AfKQpPtl4PTUnoheNo7QcEVlM1ijxpZvkNQqLpzV8SPUI
	 pf+rzAT7yfJEX67Qty281E2+7UF6LmX1wAVnBdeIq9glXc+pjGdU8bFncS2w/rVE+mvC0
	 lO5Q1GUB3D7Vd+ZY1fpXvgKAuVny2DQu5e3pIKrZ+dzLJ6ghwJIGorqJX9bRRg2bavE8q
	 zRMsmJCBjMeFbTMIeGOGAJakHtxYx9kMQZobv/w4UcvVxvLtH3gR15UPQAVg6zoxpLjEj
	 GhmkSL4eP1u0mh6R2I5OElHM5L7j90t3m4C7AJ24zX+XxqZVZ9evxcwG/mKjrj7FKtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4Er4ikq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164D60A3811
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4Er4ikq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB4E1F008A1;
	Tue, 10 Nov 2026 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320427;
	bh=QYX0h1W2E+oATJFxY2iCvY7pa9wXstnmyxb9Xo05WjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P4Er4ikqwcCFKSUspatspHEg1OtZwllGyp7tasn/Fgz91D/Bd+vi1/yXefWUX/LlU
	 BPO8Wuyf5z9zAl7pZWSUpLkRsi4G0MmDxKr1wzBY1esvgFMcR1RVnQZw97AryUSIJ+
	 RXlqnpNDiIAdZXvEaPeHFJvbDhLDf5bh7SKO1/Um4qKFXtpgm4nJjxzXsVubbTZ0el
	 t98XUajJWhGgYC167dd3vsH4v9bdOZg5Cx4CkTp/5lcqZggEuMg1p7Slf5fOpAwXH9
	 oW2M85+unJch1jYiSsWSDjMzrwY6rOGRnwJPJwjXTccmVth15OjS7eBkRYxLNwXgzs
	 Q8fJ/qVmJ57tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()
Date: Tue, 10 Nov 2026 09:20:25 -0500
Message-ID: <20261110142009.1874987-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051900-failed-6.12-09a29213bf15@kernel.org>
References: <20261107051900-failed-6.12-09a29213bf15@kernel.org>
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
[ sashal: adjusted context for of_property_read_u32() instead of of_property_read_s32() ]
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

