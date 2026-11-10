Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320656;
	b=OKXZypQ9jb1hxfddIDJfCVyv50cc6udLLAhv/Pmv5arxSH1GJhPUN6eIor8lyZmlHGuA
	 IM69CyjvpDIh7nUDrcNViLWUn0jv4m7Kvkudvb6ftP3WziDsmpZshPT6AaaH6z6PT209v
	 6DSaVWO45Q2eXsnYnwtjsMchIh2qWUkYVvTD85K7bnSpu0pPfNChRHjgzTzmilGmt26TF
	 ZU9rgVUnYUd64tOTn7vwxlZz01mtj2pI6KtdTcO98aUkcCvzOgDdNpS24FjAuE93HmqO9
	 xHZd+6/gVsJzl61/qo3EiSON+8n2C5pk70FHWzoXtqN5e9+j0XjimoPznpLmdnEO0aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QYX0h1W2E+oATJFxY2iCvY7pa9wXstnmyxb9Xo05WjE=;
	b=WEIP10zySWzkrna8pQ+F5LpHr1jl7SNK/UD1tXghBSRqUPGwbBGFIY7JLxSLgapsRhti
	 AVqYvkG/yoNMqy7MNmgNwe4WUifhXbvnmg4pBQhtVTFDI8ruj33MinKdQgtCEBb00dMu5
	 vBaa1hiHhUp6r4FH78N+4EIeYPBGWxJ4yDHDe2xBzhrS42AwKzjrYBkrv4Jxaep2+FKm6
	 HlL0QeyFgFSrGACI/Alfr7CVl9mNZUYSVS7TVpzV2HbNQTXMfG7OuozLyw6hv70W2keE6
	 D5VJNJgCZX8fqjS8eEMx1VducPYivFBfe2dhWVad61wdQyZwWN+/xIw9Mm36FmLI+cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBPekDbM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2960A2612
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBPekDbM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A7C1F008A1;
	Tue, 10 Nov 2026 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320656;
	bh=QYX0h1W2E+oATJFxY2iCvY7pa9wXstnmyxb9Xo05WjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBPekDbMR033AUsLKvrvCebL/CrqTVNJVre9YJnPfTBMCjE6OCVFFIqTjYrB65iF7
	 jOhp0OkvguWovi+bgtG/3N7Q3DLTx0nukxMzlANN3iF1bWwr8zFZAcL+bZVJcsaNHD
	 n7bttnxfm0rPhL2IKT/FUeEMlAtjsl3agJe8wpz7SlVENE6RVCpzDSUnugbYSmaGR6
	 prJ4NAsWPlEkLsMsL30yDiLybez7HedMivEzGIV3m1ud/aFYa30EjCDBJ1Lq9tzIrL
	 nF2HYLABl4ZPo7nEmWicfRHiQZRVvNj/4gdsasI8ILCghXREVGExnCHaGy1PR80T4L
	 BXFCs32rPcJyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()
Date: Tue, 10 Nov 2026 09:24:14 -0500
Message-ID: <20261110142351.1890442-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053134-failed-6.6-09a29213bf15@kernel.org>
References: <20261107053134-failed-6.6-09a29213bf15@kernel.org>
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

