Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321919;
	b=5seufsElTWXHJBjpkTIDi8S7BCh76NrVX6NUSDIcUVojfzYzuT9LDPXWVqUB6z7fD2ZL
	 vXROftT0C/DKHiruwoQuo5byBFW2cgLgD7YWecnn30jR6SjzjyijZArmYqgr7PDR5PIA8
	 x+MWKUzKnWIBMNRsVm1oERtaDtJjCbvk3eFZv4tUHFwZ86vS/OAeWerBc+dCa65ZI85ES
	 AHuy4Q+5MyVMidYmlb1p46cQqyc9gTnXc3y7RUrBdMHypZioCZ56/mBfrMw89YYvivUdJ
	 sKtJEOGKmrB2/X0Ey5rfyLRKnFu86CKcA8RUpJGAVkXniLfpexVSfnqQZmdNJGYB4qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Giu5qebiG7zQTwgDMe9FAH4iaVHLV5eD8QXgAY4cvB8=;
	b=2lM6YGaiY5t10XeYwEwL9Vgkm2nWxLlv5b+0CIIVfjAUTiBdNnLnKU9s7x2vJ5K9SLuh
	 0XhPRTOXX27Aw1+yFVaYSybjr+duTtsfKA5hfpVqybZ/y31kLpCEmyI0tzqBkDkoQY+F7
	 rPGUwIwBQgAWPh61+3fuJeZ/kbn69HToT/QBMR7derPjYtYG/kmD3i9C1NMlAim5zGuGJ
	 ixOm0WWw95AnvJP2SVWNBG2yiTQyjdg5cpT/L2Cm0mgAtB11ZHqnR6baOGgKVXBRlqki5
	 kwkA99NAL7nBzQf10lqEUFyFTKHKgVxJwATxS7Z4Xy+UXNMf2fGQO5JXKGqMAXgoBuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyncTYcU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A73606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyncTYcU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBF81F0089F;
	Tue, 10 Nov 2026 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321918;
	bh=Giu5qebiG7zQTwgDMe9FAH4iaVHLV5eD8QXgAY4cvB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OyncTYcUmx+V0vhj8BFT2cvTjnCV82MHiuEjmJH6VV6VHXkzj8Wfvc5Wz30MZpOoa
	 GTZfJgZGZUvB4MZkPTM5KNbYBLfilhgmHoicfy5omoaK/zjOYgNAbshlsXPaIwElB2
	 k2yqFQLJT0u8FsjiLWrtBmklbPGFwAqs55AJsubh/wrO7jyDWcSW86+2bvjgwiFUQU
	 2uMfzRwdit/ZU7ogqhy53ARDEE8KDClM9Fo9ykbPzqEp22oZcZTjlovolmGfeRp4pJ
	 qgOdn8IqRjCg/Z4yHHQkIQJKsUT7uKRE8Hz1BWQyHHtPuWR0mBcJYK6Rtw42DVoP79
	 AKWzrTxJeR9Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()
Date: Tue, 10 Nov 2026 09:45:16 -0500
Message-ID: <20261110144459.1980655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061849-failed-5.10-09a29213bf15@kernel.org>
References: <20261107061849-failed-5.10-09a29213bf15@kernel.org>
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
[ sashal: adjusted error-path context for dev_err() with a separate return instead of dev_err_probe() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 10cd617516ec2..7a0028c1480a1 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -481,6 +481,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	 * instead of the sense-. This results in reversed measurements. */
 	ret = of_property_read_u32(np, "lltc,resistor-sense", &r_sense);
 	if (ret < 0) {
+		of_node_put(np);
 		dev_err(&client->dev,
 			"Could not find lltc,resistor-sense in devicetree\n");
 		return ret;
@@ -495,6 +496,8 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		prescaler_exp = LTC2941_MAX_PRESCALER_EXP;
 	}
 
+	of_node_put(np);
+
 	if (info->id == LTC2943_ID) {
 		if (prescaler_exp > LTC2943_MAX_PRESCALER_EXP)
 			prescaler_exp = LTC2943_MAX_PRESCALER_EXP;
-- 
2.53.0

