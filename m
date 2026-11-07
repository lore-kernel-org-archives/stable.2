Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046102;
	b=ZrRN66RAy2C8aLJcYgQobJ0Gx0alEaPVwkDoHGkOym84YrNn4R8wCytFnmaejIvNXhg5
	 zy3wPo4Xpg2HMS6ekNONedXx0DAo4PpwrDDa7G3QtyJman/j8xH1ibYyQ8Kc02NzNuZ+q
	 xsthmUGFyVNNUPHIP6ov0X8aB3wzWyeY2dINRz/vuOlSsJgosxeq6XouO+UbHilnXJeUQ
	 dKzuyPqcNl7dDiFTaC9tT0YXeFhah8mLm8VVl+LQ1LIJkTVtzwzkKwSAZaML85UBX37n8
	 1ZRUh6iOymiPIfLMZBCHL+E2Zt0q9q/CXq7+Ywg6d/hhAzUnK6OpMJeg8cd6yLLsYuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vZpa3jipsETssm8enTBX6DKZjqI12LlsqhKfHJ7pFxY=;
	b=RadDSicLBVkfoywL3Owltq0SFQDPXODay21DDEXnI94kdstcY2fiISxI73spVzD5VYK/
	 N9aSKOdzL7ZqLB+ECcObuiwnkr3P4NlDDiFF5Z0iPIGUkVJafxdpCekHZUXLLf6rcdhlA
	 EkoyyZf9UsQbKNLR1PGjRRHK95tyXvJKpj67oCoZxdFke1i/86020IjSgomLkbBfgoU7a
	 NEf7gLLkK9len3DXXDGMMYoNOOZWXUMVzHirYb44eEfR5xK802Rb0FroLfeWonYFHOBci
	 gY0YKPzlC/H+JpCMjif4GBX61QxGH1ZuvWPMg+2yrzAJ+PUXbB9lLYpqmP1JFj1jH8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/1i8ZYo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01724606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/1i8ZYo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723DB1F0089F;
	Sat,  7 Nov 2026 10:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046101;
	bh=vZpa3jipsETssm8enTBX6DKZjqI12LlsqhKfHJ7pFxY=;
	h=From:To:Cc:Subject:Date;
	b=m/1i8ZYoP4XLVWR2nTuZAeev5rtt0ZtWBSNt8HyC4AUTkj7Qe1cpe+fZnFknEZPD7
	 9Q+IgrAUWaGNxFgveeByiwlFz13Wdmk+bnGFH38U5JODXHmcU22fQf/t7y0gIDXjON
	 XhztEP6HTBrt8JvqgAaDyJ2+vZGCdh8dpU7mxVfXb3rt1V0l4laRmIxdl+4+DXBz5B
	 VWm71S6Ws3W0zCUrUdDZk5MvbjKplydWSK26m71vftAQ5joVD9UOa8FxOPZp58DVLe
	 YUejT5Ey4aN/Nhn6Xc8yI+knKWAWm3nGvajp+juMnE4Yt+YjIMMuPA06Jd4lmfpKAy
	 GtIJW06zjmLgQ==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:20 -0500
Message-ID: <20261107050820-failed-6.18-09a29213bf15@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 09a29213bf15630e85a375478832b074b2cfc5c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050820-failed-6.18-09a29213bf15@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




