Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320972;
	b=LIfSgRlAQ5gGKKBMueX9yjOF9vacq6xIh9xM97CsoCt1rGNmWXHJ17YTp5++2HocBuXo
	 UFD8aZ0eu9KLYB5vMuBKmAfxO8zESK+uBFWq3DoB1lMg/pXM9cPNy0SfVl34Lqw2k0Ic8
	 mKuGnGUiP4Ticjf1q7k9yPtBpvcpiJlZJvfio8bA6eVdg6TTCzKwBzeW0LLjo7XD5upkx
	 3ybVBxBxADRmylanAvXt2zYlpU2bH8gxRi9SAiJzIh0XWeGMUxfLwBG//jvdXrs9pbSci
	 bce/aODn8vT1yd4eB60pFKgWjKsO+i3Zq8otX/c2OtaDQoO5xg+SQvtR64L1NBFS4CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320972;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZkKZeRF48q9OUNq+Z6HP4v6ObUvj1hg7SdSgLPVX094=;
	b=yNOT0wbRaYw63PFlRTG/0J1Uc4Kh3myCGBSoUsPShoighF+/tBxycHkLc7c83K8wAQf5
	 B0gWGlW0SUUh94h74jAOqoEeyEmEC0GXNAVThcmXLh9y57mSsBmQ03HwcP45Y67rbXVAO
	 L6AaqZj3L80KrIwa/TqI3/0AmAq/sTRqst4bBVHvvSZU22IYTBen7+jhc7YfUkoQdjcxw
	 ++jqKE1NdTcfYWEtQzclv515TxD9IuwC3fchYcAWbqOzAGxe2WvyIDIQblsE1uGzIkqYc
	 08LBHgBqmSEu0fh/NvJ/uI6PEDcNfK3n7thXopjucopVrYD192lbRp+unc0Sr+vvKnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaFpzRMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D575606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaFpzRMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EC71F0089F;
	Tue, 10 Nov 2026 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320972;
	bh=ZkKZeRF48q9OUNq+Z6HP4v6ObUvj1hg7SdSgLPVX094=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IaFpzRMdYPtn532TD1WTXXeQR8DnnczC71NRqKjH1MUt3iYZQagm5c393H0xJmgyt
	 YG9sZ0BgGFWYSUmgtudEV4Qidp6gEQTEE0o4MunbKdT7v4pms3nNN79vLT+FsYdV7U
	 vULrAIfbRmF95hJhOlROtAOd7Q1T3MPIMgzcjbJs95Ni46CiAfdjADzXh1KlYHDj5s
	 1M4/xXy3ovsxXXq7toUKHgnELpRzx+Kfpot5yIvSPNcckcx5n70eWaZ5vfnKcBerl3
	 Gpsu0CRKhnVgf1ekfdFIT0VE/N6pBIAlqAEyNF4NVF6PavO/L9O+ICHed8HQs4vdhE
	 Z7Un9zBLIa7+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()
Date: Tue, 10 Nov 2026 09:29:30 -0500
Message-ID: <20261110142914.1909895-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054412-failed-6.1-09a29213bf15@kernel.org>
References: <20261107054412-failed-6.1-09a29213bf15@kernel.org>
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
index 657305214d68d..9c18352f1adee 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -465,9 +465,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
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
@@ -478,6 +480,8 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		prescaler_exp = LTC2941_MAX_PRESCALER_EXP;
 	}
 
+	of_node_put(np);
+
 	if (info->id == LTC2943_ID) {
 		if (prescaler_exp > LTC2943_MAX_PRESCALER_EXP)
 			prescaler_exp = LTC2943_MAX_PRESCALER_EXP;
-- 
2.53.0

