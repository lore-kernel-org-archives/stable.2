Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4A296BA9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514342; cv=none; b=GaJPVdKVHjMX+03YtvFlxURmWlOSZb263OrqrG7sKu+nb13IjpM37JUPu8egUEP9VWBUm4McHYul6uOPHm5QWSqZ5rNJgGlcCCGs9J8eHj/Fkm4gX99JAaqSzvIPeO+EEKJ5jc2/nX5R+SS+Snn94nffrR5W9Giz1CNWQI5YTOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514342; c=relaxed/simple;
	bh=Ji68eWHcE31KBShV4M2K3NfBELMZjMTxH6PVDrwR6u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxR1n2i8GcsfAOqFRptIP4R42cxpHb9u9zXUik6RvZlzS8pK4CWIZe3zG9Gb3wnySQEetQ8FYd5HvZBOScSRP6OdkLCjR2XQh4ww40Tn5vJE63LyLIXzprz/8zQjvFSX5Sn+3pG53uqdUeQMGQpq2V7qRd3OiBSnmvF/CtYrZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo957ySh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo957ySh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57441F00A3E;
	Mon, 20 Jul 2026 02:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514341;
	bh=4uY3GXODpLVkp7ZCMQSeyNiQvcCYCDPNt3Uy7IuLvek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xo957yShj/37cv/X4cuiITLFR4HDLrGOT5s0NMLNWMeF5vgkG4Oul/Uhh8QJxieDJ
	 eEN7Kf/KjviIL2h1dz4He/mPyOu8frWCG8ZPq0yG1upuZ405TQRMvG6n62pOw/hIax
	 wxEsSJ16nazqDZ1m/8yDC/ZyZa0n/cLSdIayIu8SgSJOo9Oa0AXIfI54uKBAnZGM3Y
	 IHVYtMB2JOHKpd1hRhqcoOQCE5T77f1g8hoV63poAfaPRh9lZbqr5sereuscXuXYvS
	 vSbPuNEIThwgU3U2yT+dlhv4qpsOIbjh7soViHGNjLcuE2YWdPewtGW/AVl81D+6vI
	 qnNeTQXbAIWew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Pavel Machek <pavel@ucw.cz>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] leds: lm3601x: Improve error reporting for problems during .remove()
Date: Sun, 19 Jul 2026 22:25:35 -0400
Message-ID: <20260720022537.2927284-3-sashal@kernel.org>
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
 drivers/leds/flash/leds-lm3601x.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/flash/leds-lm3601x.c b/drivers/leds/flash/leds-lm3601x.c
index 3d127274820173..37e1d6e6868777 100644
--- a/drivers/leds/flash/leds-lm3601x.c
+++ b/drivers/leds/flash/leds-lm3601x.c
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

