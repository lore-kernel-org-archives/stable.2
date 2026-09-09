Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CE5437E6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953310; cv=none; b=mjoPHfHOOUExoVl+L8Fb5V0I/VEQvga38u4zK6NPW++U+x6TwJxaoToalB/+NJ1ZAUutXZjhainnny62nFGBDBtpxFwhUb30ixEX9PoDB3sPBoGEUSmDK5jleTPyiVMWP9DpYkNOWRQs7+ZMqKiGYi5b8W5LJHBRm2k9Ml7/DvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953310; c=relaxed/simple;
	bh=8sjh3VBm0Pxsrgiy/+OuWrVxsD5whYcsW8x4QCHrMbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuZYT5MdyIBrGqzoyHHEiv7YAAQ4vUXSos3Al1Y3C+NjcPrFORvqLqjJRjbPc4TPdR76BjpcHIhNmkdlnyJmbumInhNAzqUcNfWQTYDwWbQPeDnJbmQRzU6PJLWkDllFL0cAFs2VXp7Hfbl6Q6XWOmXgelCPP09UtQgudGk7l0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0f0CvBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0f0CvBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F991F00AC4;
	Wed,  9 Sep 2026 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953308;
	bh=bKTFegKfjCkW3QvHswwxg102Hoxi4RwS96MuTZ0e9R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0f0CvBCwLCD6KQWuaBEzvK0hDtFzTjn7rbfKcQT8mgq/okYDnYq34MildhY3wKAX
	 /2b+AoIZizNnn/ZNVXZR6tTPZsFB2fPAGXBmt5sef/1OT2PEIUgsxAhZeWls9tjbGN
	 +q/+PxrDBe0KbGu5YnV4ue5hhqpB8kwMlRsNgNDnW9gYLD45r0aHWGRb3udbOLylo+
	 URboyO76d3gWqZ+bSqCup6FeAwBM/Z7i12wTIbJJhDCTVRhZIBCqkdLZTri2qV2JLm
	 0+We2u6KHqg1yHqDgLIOD/wAIyawEypA9OuaUOTSlDQgBYCqkygo0T93uG8Hkiep7H
	 HNhz4SEiwDCXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianing Li <m13940358460@163.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] power: supply: max17040: drop incorrect I2C functionality check
Date: Wed,  9 Sep 2026 07:28:24 -0400
Message-ID: <20260909112824.1848482-3-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Jianing Li <m13940358460@163.com>

[ Upstream commit 4e4b9f5ce9dfb8ed4b8d1262a504b8043ac09d87 ]

max17040_probe() rejects adapters that do not advertise
I2C_FUNC_SMBUS_BYTE. The driver does not issue SMBus byte transactions,
however. Its regmap has 8-bit registers and 16-bit big-endian values, for
which regmap-i2c supports either raw I2C transfers or SMBus word-data
transactions.

Consequently, an adapter providing raw I2C transfers or SMBus word data
but not SMBus byte transactions is rejected even though regmap can access
the device. Conversely, the current check can pass an adapter that regmap
cannot use.

Drop the stale check and let devm_regmap_init_i2c() validate and select
the supported transfer method.

Fixes: 6455a8a84bdfd ("power: supply: max17040: Use regmap i2c")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
Link: https://patch.msgid.link/20260731084259.916-1-m13940358460@163.com
[Fixed Fixes tag, so that it points to the regmap introduction instead of the initial driver addition]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 4f2420fe9d3d8..f1f5e965bc550 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -465,16 +465,12 @@ static const struct power_supply_desc max17040_battery_desc = {
 static int max17040_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
-	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
 	enum chip_id chip_id;
 	bool enable_irq = false;
 	int ret;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
-		return -EIO;
-
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
-- 
2.53.0

