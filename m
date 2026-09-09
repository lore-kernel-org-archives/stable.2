Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9C1F12F8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952584; cv=none; b=QpkyRoFxcYT7HmMwbc4TsfkJGhFMuv7E2zBwbrWdTzhgNyKdzeTFntYLOMBBH8PPzKNAztz297DxhaVSRpZnMctU1/qH6K3V0C/mzA7fE2z3ZsW23tOFymbqFDMx15xDknrl7HkhY38Xv4uxpdpkE3P7tbncLEaky1arFbpdaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952584; c=relaxed/simple;
	bh=6fYJxdc3uJZRsR7FBk1gBQWWlq4HXcYgRb2N1MKI5w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxB375OP0bpQi2ZEaDhRU1ajxUxUrEcjNDP7rHXKtCrulmHd4kOct755g+agYbgN+9J+CDg/6/xQ05h8b4+FR/IO59V3H1Dd+E9kKW/3DBwMEO4Ef3mBLFwlLcUvZurTruLJ3NlQZq9WYFFdPTpIvX8Srg3j0s/yTKxu1UWeaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvfYCEZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvfYCEZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60E41F00A3F;
	Wed,  9 Sep 2026 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952583;
	bh=+7fyQuDOwWDAeLgDh7l5qwkLNicmt3euc9koS4KS9Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JvfYCEZJ8oQ5TLw81U6pZwfyFHgKUU60LvauZVCcwpGOaQwk8JoJGUc6md4+Ielt1
	 soFH+FKcHmU1DxCEQherd48l8oYUL3mhExGE637aAPNnnKUm1dxKtHs76v8Dc6orU3
	 LrtfuIbYKEPViUVINQG21b5bCqgBKlNaYBHeNizqjF2PI6UBnaGLdgGvoPSdRb54Nu
	 OPw0wtNvRLtJHSqr1DJ7aCYuOg+a1nUggyv0zXWjjNR/6MGerhnhHvqqyGhFmA2RfY
	 PwApvhcuKZgs9/pyA2BBCuxOXV/8Aydl9iEJaj1G4oqEdAcVPGN3YPH4zxnytQM/Ah
	 1zmCrALmlP9Sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianing Li <m13940358460@163.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] power: supply: max17040: drop incorrect I2C functionality check
Date: Wed,  9 Sep 2026 07:16:18 -0400
Message-ID: <20260909111618.1798847-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909111618.1798847-1-sashal@kernel.org>
References: <2026090305-skinhead-nursing-7dcb@gregkh>
 <20260909111618.1798847-1-sashal@kernel.org>
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

