Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050332;
	b=zZvAvAUqQzyeUYwCQNYzQf5bdLEHtEPZKypIP3LBBK0xZEyX/VOsvjALQKm8rN7+rMc6
	 5YMg7ShCzIIs8Z862djYHEahksawSMzSpdAC70256Gm3S6qC5OBP8MmVkxrIquxLyxZGF
	 TL1jxSDHTU36IYGOH31ninW/Bcx2f/ZpNXyCiD+76G7tic0TVRrQTLXlnQ6WakGSVxFVo
	 kegS6eshZ5MbZs099OpBsBaaolk2Q5tfuiLtl3t4Yjuc+vTdHDg7x6rnEyIYzFNC3x3ws
	 eWzPIQTN+rox9DP9fXLv6MrHwsu0A0+AWPojBuKNoj1lN35ykoDpAyeSqlpqxf7SvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050332;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1bXNnKNTvIJfSIX/pjyidvz99JhCV5Fl1keNwdURmZs=;
	b=d2a4TCLDl+los0XL+z2JEhPCDMT7X4Kw/5dlaPJi3nR7LS50uwTGWxuxwvmUHcs5zuD+
	 bg8OgBJdNO9lFJqRNQsXVfUahi527GxytWbuNcwe/ZBpYNr2cUyjwYcoSXCVJ9o6epyjk
	 rQf5u9Gqjqs8MY4oNyIAMjoN2qHfytbQp+j8LhCJ7KPs1RL4FeivFFqoGL3EGmloD5VTD
	 xF+V24XGs7Hvw40NN6yVrNB72HM0xSM7v0guxH9Ftguv6L6Rw5446iDTCu6wqQYbwOTdl
	 8J8HYivwVCYsYifhKgiSCOvJOG3OgQKH+pVY2cZ/26BW/eWG2/PybxtbGl2G6Dms3ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZgI3cZB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA21606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZgI3cZB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653A31F0089F;
	Sat,  7 Nov 2026 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050331;
	bh=1bXNnKNTvIJfSIX/pjyidvz99JhCV5Fl1keNwdURmZs=;
	h=From:To:Cc:Subject:Date;
	b=AZgI3cZBE56wMacM8630acQy9oC2m8kdVrE9YorOzojo6RRk/HRqwHlKr8aEfLZan
	 8OczkisohQLVUFy2Yxen5EwXRZyUrPa6C8gDNO2gaeozPeFRQ2U5YRQXPATld/8e9e
	 kpzSivdEhPkG5bxfJUHi/uEMX61ryAFVz9uju6LGCobEFDm6yMID0oK0MeEZhaM4s3
	 Z2FGOGKgv92qqH3rBkKRO0Eq8zwcWWtRhys6rF/+wsPGtdjPGvNo92L5Vp0yUB9cJh
	 8NgNc34MfAYjHM3rBw0Qq9kkFTXaiLiuNjh0zgm+tys+Hj+BmEbn3SzLHKdRo2WWpp
	 mMXy8ctYXQ/2w==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:50 -0500
Message-ID: <20261107061849-failed-5.10-09a29213bf15@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 09a29213bf15630e85a375478832b074b2cfc5c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061849-failed-5.10-09a29213bf15@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 09a29213bf15630e85a375478832b074b2cfc5c8 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 14:21:27 +0000
Subject: [PATCH] power: supply: ltc2941: Fix of_node reference leak in
 ltc294x_i2c_probe()

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
---
 drivers/power/supply/ltc2941-battery-gauge.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index d1be314f36a09..6ebb555f203d3 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -464,9 +464,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 	/* r_sense can be negative, when sense+ is connected to the battery
 	 * instead of the sense-. This results in reversed measurements. */
 	ret = of_property_read_s32(np, "lltc,resistor-sense", &r_sense);
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




