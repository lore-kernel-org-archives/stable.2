Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDD19049B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514341; cv=none; b=mIH71/eENJ9UzV8xGsUBFU0lY6MpU4s5AODt7hfveQ99kVQdz61eOj+vv2XHFiOl8t6GFFj/zCxEpgigjFdONOa7f2XzK+uxWxcrtcKGI2MzbCwrwJU7DxadR5pevkQ2wyo5iGsGkkGFOezqfDq0cEDCvi7ZDGXkiQH+MelQMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514341; c=relaxed/simple;
	bh=NjyvRVhUWRHjdLeubg5ZelPL9PFLLQ+XZi2wE4sPoW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omX13xm2he904IqahijHVRoqLm2qGuY8wpRMPq/Inft8XTp9NKmrU29eiBtAeuViwn7Ah/Vdk5hzQBawRMizbsdZLZgralSN8MuVtHyTuBrZ5ZvCU6WjPOJdLvukKYMs5ZxtXKh17Q3U2hT5nsTk4W25FYWTvJt9VtWv6w8uqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIfD9rX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIfD9rX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6301F00A3D;
	Mon, 20 Jul 2026 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514340;
	bh=E5NUlOI3+BXU6WfLc1iww4l7GfHyIBby1QkyOPSc5dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIfD9rX2Qyvhlz+QtGqJ8vnkhw5R/uJo0gJ/CP+HwmMwqnyhz9e0Te7HO1Sou81rD
	 K0IIVlLxk6KlQYf7+4USUgsheU/jWt3KZd4imAwxd3fbs30j7W7Q9JyPHk/IEo/NP/
	 FL4J6p1MEtSQSrCsmF9axtLeLe2L5nQN9IkAdjjukS2RWLCdHuJcQxCxSg+lJsXcL8
	 2YR3iA0imwsF6gAsWsAEhEd3engvOOgQtKdhUiegNveu+CnOwR5Gl8RuUvkR6mbDCm
	 BqqGoGHraRwh5OD5ZR8Xz+xx5D3XGzTOnky80wqsw98XUhEVxMEEtK4cJ6l5VbpnAS
	 qALzsySeqvjWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Pavel Machek <pavel@ucw.cz>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] leds: lm3697: Remove duplicated error reporting in .remove()
Date: Sun, 19 Jul 2026 22:25:34 -0400
Message-ID: <20260720022537.2927284-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720022537.2927284-1-sashal@kernel.org>
References: <2026071422-comment-stardust-654c@gregkh>
 <20260720022537.2927284-1-sashal@kernel.org>
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
index a8c9322558cc51..3ecf90fbc06c09 100644
--- a/drivers/leds/leds-lm3697.c
+++ b/drivers/leds/leds-lm3697.c
@@ -345,10 +345,8 @@ static int lm3697_remove(struct i2c_client *client)
 
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

