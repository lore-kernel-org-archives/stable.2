Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049327;
	b=ynvvSuq7nmfeozYHvvjR01iYQTQ7xLBDzPdD2Q8Z5UiLytBiszWudkiDyYY7USCMKTEk
	 OQ8kokfpZCqhAkfj6Y7fio8z8k+g+ggf/qU5LloO4YF/YoreK1qpPEhj6UsOIEiamxlaO
	 uSExRX688mYZGdIytnUB+nGD8SYzi0UDONVE4i7nDJeUzEaCeoUYTi+xwI/+BwEVJ7qxo
	 v7t9vibUArfiFf8irWak6SZL+wwTKtAGwK4EUD7fEKkOi5T+4INsmzVNXHY9nbTs9coXB
	 85X6K77UkkKcb4M1KD8WK7AMe7Cy+9e3mOZGKwzNwGr6zybxAnrR2g3Yk6sJD9ZVgdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049327;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XcrXzxWVlWcSiHmCT4FZCagOuKpeauIs0XE6zpK1tPg=;
	b=MkngsEm+EHcBMY8IqXjDJRu+czboVm9faQaiOFU4nNRA8MjTxEN/Su5zjfzcpow4C0s7
	 KXSXI5s63GO56/BE1+RDaFnbmDqPGhUrcbabuoul2USZjlrHGeOCU5rxRuNAnBbPtVafq
	 VRqtqEACjOBxKvm3knDO75plRGX9qicmy6GGRiPvkMSmB9A2Vq/Ab68uTKqMkyVe8LztB
	 E05Yj7H95eDw7rRZqBJkXYJnLUWx6qo3kLT1lXm3pvI6oBzgYwOQ9dtuNWkFEy83ny+An
	 XQiuiCmqBoVby7BqRhM2JbksAL+eWff80ghsEKSKV8J/ugj0r9KNMz1gctx2X5ady+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHeUFAbT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FB606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHeUFAbT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA591F0089F;
	Sat,  7 Nov 2026 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049327;
	bh=XcrXzxWVlWcSiHmCT4FZCagOuKpeauIs0XE6zpK1tPg=;
	h=From:To:Cc:Subject:Date;
	b=EHeUFAbT2YP/tccnl7pUCCUg7BESVlskYu2Q90AZ4xTgWGPLRhyRLIPzPUuPO12tD
	 NY4LPVCyDNZHqI0hKnp48IDNw6KvZwv1khTSKUdaV5f0GNVDzUZduhtW+LE8fF0rcI
	 AnlLbNM6bfmjwUR2hJXbbmQwyOOE+sBCOQ1HQylt9F1tPyMorw6Oj2Uw6qm0CRI3kq
	 nabLvLzWoUaINfsd/ZP4g1KPIpRPHhm7ULOaBae0KUn7xJ49Rlx+D4GyxTQzwaDjit
	 ld5wDc/1NSYiQ9yxL/JvCJlP6DYTiokkRmgyaRz484VVGbXkUjE7zlaKM1SI7l4c68
	 vYPHvWBP4AoJA==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:05 -0500
Message-ID: <20261107060205-failed-5.15-09a29213bf15@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 09a29213bf15630e85a375478832b074b2cfc5c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060205-failed-5.15-09a29213bf15@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




