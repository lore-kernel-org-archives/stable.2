Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC8B134CF
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514944; cv=none; b=AwqT9A++HF6Os1CZqzasmJba+Uu4uZ4j0knhbsUpFEIfkmPf5sj/s/9ZFmCAltNjVwP189CLDeW9f8+iY4JRSAnKQqYTE5NHcDQl77pJH8O8ATJIc91bWHQvoxTZY2RVTuxlXB5v2MZ+QmsCRfjWBvKxb/aj0+xDIUWg3AjWj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514944; c=relaxed/simple;
	bh=Sc5zhxAXr3hDNmBUQsls0HuQLlMbbctXUe2umtEBzQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXChuBgI0ROiqJgwfv5oQBbIgk9dkv/vqglR9tmOH0z4RbOfaNERA9PRJZdGpRLtl9KxV1AAcoJUYVNBxTvtSu5S3DBxVIY1SbbGLQmcqwMqY1n2d3ubg/7DC7Z2fa1BWV2REBDzovkRnAqcc/Zs6tei+7W/aiasSOZRRGW2on0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5hs4jo9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5hs4jo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBBD1F00A3D;
	Mon, 20 Jul 2026 02:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514943;
	bh=9hiWVMsCRWbpWNvJN86m1z733NXJd68Jw/Ty1cPopNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5hs4jo95MCk3+1CczGlRESbIWjsDOUhKBY4H2P1k0cAjnvFbPHOGG1zEE/lAnxF6
	 DHmLPjjB4RFxwmy00W7cNkkS9py/h9LzkYFf9tx3Dh03ljjSVkTorseO5l70FUHZoo
	 4n6sMs6QhAownwS6NvUpOZdNY45/1Mq84s5w/AIA414Bo9e6fPX8epETzWSIRjs+BF
	 Kb6mLwCjDMjKhvrTuyikpEN19WvG/RUaZvpWBxHuZ4xhImtni7Q6mqlDsWWoJH+pO8
	 PWAZKL/BSJJDutwVVAIkUwxJvqPDsC1gM+8+df6XFy5J9qDaGK8b+zwKqLBr0oRTRz
	 N+AEttmXPnS6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Pavel Machek <pavel@ucw.cz>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] leds: lm3601x: Improve error reporting for problems during .remove()
Date: Sun, 19 Jul 2026 22:35:37 -0400
Message-ID: <20260720023539.2968115-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720023539.2968115-1-sashal@kernel.org>
References: <2026071423-employed-mankind-78ba@gregkh>
 <20260720023539.2968115-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 22a23436891886a66d21af3619f4a4e8809f0e0a ]

Returning an error value in an i2c remove callback results in a generic
error message being emitted by the i2c core, but otherwise it doesn't
make a difference. The device goes away anyhow and the devm cleanups are
called.

So instead of triggering the generic i2c error message, emit a more
helpful message if a problem occurs and return 0 to suppress the generic
message.

This patch is a preparation for making i2c remove callbacks return void.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 1f0bdc2884b6 ("usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lm3601x.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-lm3601x.c b/drivers/leds/leds-lm3601x.c
index 3d127274820173..37e1d6e6868777 100644
--- a/drivers/leds/leds-lm3601x.c
+++ b/drivers/leds/leds-lm3601x.c
@@ -443,10 +443,15 @@ static int lm3601x_probe(struct i2c_client *client)
 static int lm3601x_remove(struct i2c_client *client)
 {
 	struct lm3601x_led *led = i2c_get_clientdata(client);
+	int ret;
 
-	return regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
-			   LM3601X_ENABLE_MASK,
-			   LM3601X_MODE_STANDBY);
+	ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
+				 LM3601X_ENABLE_MASK, LM3601X_MODE_STANDBY);
+	if (ret)
+		dev_warn(&client->dev,
+			 "Failed to put into standby (%pe)\n", ERR_PTR(ret));
+
+	return 0;
 }
 
 static const struct i2c_device_id lm3601x_id[] = {
-- 
2.53.0

