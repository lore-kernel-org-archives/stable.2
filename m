Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321665;
	b=SYSj0Xv+tSEIlCKsx/RDia5HnmlHtHOHg33tilphiVmcmr8F52Xzg8vy+kU3pDBoUUdd
	 L0H2E+nnLAWelhd0q0eb4LYlmyu6zlbfiqIifUkiEnUNxxuxWMfKn2CKIG5ngHJKdBXSh
	 DoNIlSu65sO6lZLW7B0t84NVgtSMCPjBLVu5XlCgjKoRKyn9DAoW0o3H0ryESt3/XH5r/
	 P+3vvm0uncrbCF+KoGZyxAATUaZGiOL5f0YhDH4BrXNpfgGcx7MsCdK4oU2xK3xwMQxPY
	 3VAMhYyfyVlq5XewKhL+dt3o493t7GIlDz6VxVC3JvWm9rbp/N+djHsWqgvNNQ2W/ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=enl5Zhk9yTdDEtXIEkRqSmlQhxGw988VNSXW1+1PXt4=;
	b=w0iOoDzPLbfMeOG/oCb7r+STLmw0poG74WxJM5w8Ps11Bu7equbqMCFKdRRKXYm9HDwa
	 My48YwwFLoYI68aAOQGEK9lfPaFbexZD6CQMl/7Csioyu/prahgfJ34UJExS4fSXZYeWI
	 /Nad63rM1BdcqYrB7mQsFeRh02XlgC7ehS0dLux+C3ajQBvZp8X2T7cITJ+Ap+1P+DW+j
	 rxAJxzepDjryiWrXU8IJaTGgAFCrKq9ALqi25X4hcPzMQggC125c/ZyTVKFl+WfdY9D1C
	 cQUNan24Wpna9mhHXerEnj4TXmWuOlNLQ3swuuYZy9nEcboXttFhPCRSS8ZT2x9pPLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InuMYEfE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8660A2607
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InuMYEfE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA371F00907;
	Tue, 10 Nov 2026 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321664;
	bh=enl5Zhk9yTdDEtXIEkRqSmlQhxGw988VNSXW1+1PXt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=InuMYEfEdfVxP6RznXLqCbhlRKUT0Gb3yNSTX6wf0nSTWblOB+U3PxdXSipOTIAle
	 1V/u2W3QlIGafWL9UCQ/IHf6/6oqqt8xBaBaaP5Ae85ZK44kxaGWz1gN3LjGcq5Evb
	 YGUD5xgZmCukMmTztJ6tFU5Li1oKjba05YGn0q98GhuCjmnG6q3X1QQfGuQb9Uek/J
	 A8wbuZVyBuYHcMz4QvgcT3iZk9dreP3e6XPP47feNGIVD/fzUV7wQ1Tyeibe9BFIOm
	 2IrBJJDrfa+9iPNrUTw3+UlZU53yc97twOPIu9bCPanHltaNQhPGwWA5h8b6NRFlOj
	 bxLF8rX5ZLoXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()
Date: Tue, 10 Nov 2026 09:41:03 -0500
Message-ID: <20261110144038.1926381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060205-failed-5.15-09a29213bf15@kernel.org>
References: <20261107060205-failed-5.15-09a29213bf15@kernel.org>
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
[ sashal: Adjusted context to retain of_property_read_u32() and separate dev_err() logging and return statements. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 09f3e78af4e01..5df89557456aa 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -473,6 +473,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	 * instead of the sense-. This results in reversed measurements. */
 	ret = of_property_read_u32(np, "lltc,resistor-sense", &r_sense);
 	if (ret < 0) {
+		of_node_put(np);
 		dev_err(&client->dev,
 			"Could not find lltc,resistor-sense in devicetree\n");
 		return ret;
@@ -487,6 +488,8 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		prescaler_exp = LTC2941_MAX_PRESCALER_EXP;
 	}
 
+	of_node_put(np);
+
 	if (info->id == LTC2943_ID) {
 		if (prescaler_exp > LTC2943_MAX_PRESCALER_EXP)
 			prescaler_exp = LTC2943_MAX_PRESCALER_EXP;
-- 
2.53.0

