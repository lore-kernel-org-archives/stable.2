Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6E542816
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953309; cv=none; b=KsQLhoXd6ox8YnsRVlp9KkItNqlVF237ebRQi3db+ipXiBkk4oqf7+d+QepotxypC/Dol2HlUUcnrNnf4+dtl1y00udhl1dZMyqEWhnegCkPBTP1ltbGYS0/foTARco1B8Pwtn2l8CkwTqOWaZffe5WWP+4Hko660YA8kEv/UzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953309; c=relaxed/simple;
	bh=ljQSTJXzUX99naSndjZ8kr6ulCd5dIrzqFF/H9P/V+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5/576cPLtRl8H1ZSM9w+suQNgOdXJfllz9s+HP2t087FeL9tY6/3vtNzLOY1ML9AJEURkhiix9uxwXoGaTzrkor/TidcYnUKFs1WaKkC7REPVPpnc3DuSQTw9nDFwvJ7jnBYR+GGej3BRtyaddhOv8KPlTVW26UeZCyQ4csrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+/ppK8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+/ppK8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905BE1F00A3F;
	Wed,  9 Sep 2026 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953308;
	bh=sddC+6Ffwq08/sGpd+A67NHdX+njafkICoMcsgLua6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+/ppK8mFygRh92A20sqzLucNBUzrCLFhGpyUZq4GF0uZ8Z6iTcOBHm4hferNPYgA
	 369XFyWc/EFbg3BkAmf/pg4B0+w7pnpjBEVwUReunb0UfEIyItop4l819AsglEWKNR
	 YO2s/X7iQP+j2I7eAVyMwSx2ylI/FeAiCXOhh7HpqSPtJInx9qu15sGh4s6nnJar4S
	 wMEgZ/zAs0KMMnYhMfWHdehSnfT3EGl9QM8jhK6bshiTr50aI/CwXCGYP54S9Vum9w
	 WP0e9yAGhLuEDG1ZR/qGGLU3oXYejADqOcsYDQ1XPJTYVtqTgGBhMgUjwRTyjAHHkx
	 RoT0Yo2ovXzEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] power: supply: max17040: Convert to i2c's .probe_new()
Date: Wed,  9 Sep 2026 07:28:23 -0400
Message-ID: <20260909112824.1848482-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112824.1848482-1-sashal@kernel.org>
References: <2026090306-rabid-rug-adb0@gregkh>
 <20260909112824.1848482-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit a07fca69378c26ea034826feb0011256e25ad237 ]

.probe_new() doesn't get the i2c_device_id * parameter, so determine
that explicitly in the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 4e4b9f5ce9df ("power: supply: max17040: drop incorrect I2C functionality check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index b6b29ec3d93ec..4f2420fe9d3d8 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -462,9 +462,9 @@ static const struct power_supply_desc max17040_battery_desc = {
 	.num_properties		= ARRAY_SIZE(max17040_battery_props),
 };
 
-static int max17040_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int max17040_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
@@ -633,7 +633,7 @@ static struct i2c_driver max17040_i2c_driver = {
 		.of_match_table = max17040_of_match,
 		.pm	= MAX17040_PM_OPS,
 	},
-	.probe		= max17040_probe,
+	.probe_new	= max17040_probe,
 	.id_table	= max17040_id,
 };
 module_i2c_driver(max17040_i2c_driver);
-- 
2.53.0

