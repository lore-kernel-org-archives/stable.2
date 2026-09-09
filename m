Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5888474271
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952893; cv=none; b=aLMdpaMM9WHE4IyGfix9gJRHjYwn5aZl/zGDd/nDB2lJDn0PEUbxs8JYX30z5vOT55bSp/3y3uh6fWB9KviTvL0eFZ+DDLksx5gdP8v8g1j7aHrpOI+B3poBh88MtHjpAKbSSZyO3iPXSGaHeCa7NsacvNJbksbroYSn+ObQY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952893; c=relaxed/simple;
	bh=6fYJxdc3uJZRsR7FBk1gBQWWlq4HXcYgRb2N1MKI5w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv7QcWSXZf0PWvP4mtEU0oVFSnNF9n4jGjJODBodclIK1/QRtqcZEgiP2mL8omNGWza+5zankPMaIbn1F5OxgR4/oLKmr3965328jIv+4bK8XoR0XmhQ0dKNUOZO3etYjSU3ddYwwY/7Zfb9gMJntiqIuJ09LNgyMsyXGKGG7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lagFfFMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lagFfFMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2778A1F00A3F;
	Wed,  9 Sep 2026 11:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952892;
	bh=+7fyQuDOwWDAeLgDh7l5qwkLNicmt3euc9koS4KS9Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lagFfFMfvfnib838pbpWqq5NiI9hVuIxUU6Zj2IIyp4DZkO7Us6DgtbRWKhTEvy+2
	 S/g0NsbX46M/cRx4NbY3zQrhQPxq3XDegG9EaBmwWnqGhkrHpF+FL+TtZlDrBtnsLO
	 aeAreG3mugtYkS9dGOlSzNcWPdxEdvdUeF6jwC/JFKyy0lKzADUBEpKOPReeul7elO
	 uwkaoFwR3Es7UapF4QzAh+3sNN9dcdVMfsViaSFT/stWx0Kqxd1oA+YNZBgqU5WB6L
	 XNtiCcHiBbT9cf/tjpIQ5uQpyb5F3SJeUspauFEZYhRa3RwzaL3H4+f3p9T4SmHwJ/
	 HITz7gBIUEg7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianing Li <m13940358460@163.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] power: supply: max17040: drop incorrect I2C functionality check
Date: Wed,  9 Sep 2026 07:21:28 -0400
Message-ID: <20260909112128.1815387-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112128.1815387-1-sashal@kernel.org>
References: <2026090305-streak-absinthe-62ae@gregkh>
 <20260909112128.1815387-1-sashal@kernel.org>
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
index d1075959dd466..29684d922893c 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -433,16 +433,12 @@ static const struct power_supply_desc max17040_battery_desc = {
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

