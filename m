Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEEC23A561
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514944; cv=none; b=cEXiSu+VPeP9r3YCCi2hRVOxc9kOSsHLpYau7QeDc1jW7LuvsGjDsqRQF3FxbMInPtvRNr4EGeTka1mE4NFSWZIIp+qkRh7hJlGjEaQaEy1ccUKZLgamKYzOAu0Pmg1pZNh8j39b4T68yQnuX3eOjx1EwSKvSgBcPuB8KpTQUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514944; c=relaxed/simple;
	bh=fdx7yLp4ajRbYniCdDtkKSUAc8TX3qIS+laBlAuscmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9imcFJVkrrj9p3geD29amFMUb7+xQN0DOk2PCIYcIHS5pQI9K96f7QWhyIAjH+WqPY64s5EN2ZVHoUhJ4ERFRF/+aa9Tz2Hyp7ARTVFwNWD9UgNuZs/zEChmT9TNn3sahOHU83F6qCOM6RvhirDPgMcf7aXOuHs49kTMAa/rM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejbtgyqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejbtgyqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B001F00A3A;
	Mon, 20 Jul 2026 02:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514942;
	bh=/jQQWmHs8pY6yRauueRhWwkYeDwdvEjsauP1IQAQ6/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejbtgyqQ2RgMgFaFyiMR2RZ3oDxI+l+GtljKmZcvmaQlIrlKfy7FYx1v5nLRgx/rS
	 UorcHgCYvW4Es2K9ctTdWPJe5hDOompcbKm43OwQj+pNGF9yWOXzUMc5Hq9nal+1aT
	 Cxp4EuN3U17zuRY8U0hslTZyz4qgX2lc8RvAc5Xdv0ACkUqCgNki36ThXR2rbY1ycb
	 Pk1tTIKeCvxcBei6zgF4FgveNHDcCAV0ooQh/JMSba9yzGa2PyEFy5uR1mAm8XqVZC
	 HYrXa8SqoI8beJQ6WQluRZc5uzt1tWr0Ki2x60tGzMGfej7zWE2y2M1daocB5c75Gw
	 tYMn81w9EvrmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Pavel Machek <pavel@ucw.cz>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] leds: lm3697: Remove duplicated error reporting in .remove()
Date: Sun, 19 Jul 2026 22:35:36 -0400
Message-ID: <20260720023539.2968115-2-sashal@kernel.org>
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

[ Upstream commit af89fa11fae1cee4e07453f780e6e5573ef0f477 ]

Returning an error value from an i2c remove callback results in an error
message being emitted by the i2c core, but otherwise it doesn't make a
difference. The device goes away anyhow and the devm cleanups are
called.

As lm3697_remove() already emits an error message on failure and the
additional error message by the i2c core doesn't add any useful
information, don't pass the error value up the stack. Instead continue
to clean up and return 0.

This patch is a preparation for making i2c remove callbacks return void.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 1f0bdc2884b6 ("usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lm3697.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/leds/leds-lm3697.c b/drivers/leds/leds-lm3697.c
index 912e8bb22a9953..e0c7fb8a684dfc 100644
--- a/drivers/leds/leds-lm3697.c
+++ b/drivers/leds/leds-lm3697.c
@@ -337,10 +337,8 @@ static int lm3697_remove(struct i2c_client *client)
 
 	ret = regmap_update_bits(led->regmap, LM3697_CTRL_ENABLE,
 				 LM3697_CTRL_A_B_EN, 0);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "Failed to disable the device\n");
-		return ret;
-	}
 
 	if (led->enable_gpio)
 		gpiod_direction_output(led->enable_gpio, 0);
-- 
2.53.0

