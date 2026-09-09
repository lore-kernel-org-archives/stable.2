Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC554EEC3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955097; cv=none; b=DSQQK1hlNj6v4xLjh3qVc6S9auiL/AYqc1vbuH4FyjzEkyOCfRSp8u0XNgx975vYvQN+ipxhp19LwK7Um6ZAQrAw/tWMOwI7jnon4HFWxz1SVt35c/y88Vq0svWkyVwHWxDgD3TFoalv7pd8lm+u7kVUiKNtRz3a2RqUgwiQNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955097; c=relaxed/simple;
	bh=RaNW03XewhgQqwjYUJvGQyazxDqzuuL+lbUx8YsOVPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjK3WFHxBpp35C5K1CmxWZhGNt5bSx32GiRlEB4IFH+ZlIwzv+VurPXUNfRdeFewPLB1FIARbAuEfRP6WF1SXb6dyFtl3zmBhWALmVbtRfwt4Tl3EVgwykMg2wqrIb44qHqNgR+hxptOa+pZuGM/fIigGlUIrZr8YFiPCsXsrX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKQmoUJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKQmoUJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555171F00A3A;
	Wed,  9 Sep 2026 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955095;
	bh=1IzlGD9PJwK5cr5YuxvGSotKCX8YMZKUH9nSv/1fUPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aKQmoUJ9FXRrN7xqInAvG4yw0UjDkYMEWLBu9qQNkOaeCQxXGNkSUo8xz8xgFHxXc
	 ODcSFov6jCdeXKxvuz8syZLB4h1YSPKsMJzZPkOMzB3FeFEDOX3a6nMfCQcKEhySkk
	 XH3WiMGvuAXBYRbdd1JTSWYdzLOXTzuCKS6prZAxgoXY2MkccPEDKQKQhEz63HjUp1
	 xlopKNmmQrMRqdhQ2PO7xz9A0KNlSHO6giYbqPx/3zulvXN4dzyuA0zkK91j6nbuPY
	 ZBfwU9hQ/npnI4crzULSk1eaqK3TDZ9CAv657QyUbwG6w348UHC8h7c+9kuJ1x2fHl
	 Ya4SjnCLwUJkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] power: supply: max17040: remove non-working POWER_SUPPLY_PROP_STATUS
Date: Wed,  9 Sep 2026 07:58:10 -0400
Message-ID: <20260909115813.2181976-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-handyman-delegate-c138@gregkh>
References: <2026090352-handyman-delegate-c138@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

[ Upstream commit c603bec359aece14c5e74a4aa174822692fba7d6 ]

The driver was reporting POWER_SUPPLY_PROP_STATUS via platform data
functions.  Without platform data, the max17040_get_status() functions
returns early with POWER_SUPPLY_STATUS_UNKNOWN.  Since there are no
platforms using the driver with platform data (no board files with the
driver), the status property was always unknown.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 659cc3d8d5ef ("power: supply: max17040: propagate register read errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 32 +++----------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index b6b29ec3d93ec..8b2f0726ef0c0 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -147,8 +147,6 @@ struct max17040_chip {
 
 	/* battery capacity */
 	int soc;
-	/* State Of Charge */
-	int status;
 	/* Low alert threshold from 32% to 1% of the State of Charge */
 	u32 low_soc_alert;
 	/* some devices return twice the capacity */
@@ -225,24 +223,6 @@ static int max17040_get_online(struct max17040_chip *chip)
 		chip->pdata->battery_online() : 1;
 }
 
-static int max17040_get_status(struct max17040_chip *chip)
-{
-	if (!chip->pdata || !chip->pdata->charger_online
-			|| !chip->pdata->charger_enable)
-		return POWER_SUPPLY_STATUS_UNKNOWN;
-
-	if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
-		return POWER_SUPPLY_STATUS_FULL;
-
-	if (chip->pdata->charger_online())
-		if (chip->pdata->charger_enable())
-			return POWER_SUPPLY_STATUS_CHARGING;
-		else
-			return POWER_SUPPLY_STATUS_NOT_CHARGING;
-	else
-		return POWER_SUPPLY_STATUS_DISCHARGING;
-}
-
 static int max17040_get_of_data(struct max17040_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
@@ -284,7 +264,6 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 static void max17040_check_changes(struct max17040_chip *chip)
 {
 	chip->soc = max17040_get_soc(chip);
-	chip->status = max17040_get_status(chip);
 }
 
 static void max17040_queue_work(struct max17040_chip *chip)
@@ -303,17 +282,16 @@ static void max17040_stop_work(void *data)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
-	int last_soc, last_status;
+	int last_soc;
 
 	chip = container_of(work, struct max17040_chip, work.work);
 
-	/* store SOC and status to check changes */
+	/* store SOC to check changes */
 	last_soc = chip->soc;
-	last_status = chip->status;
 	max17040_check_changes(chip);
 
 	/* check changes and send uevent */
-	if (last_soc != chip->soc || last_status != chip->status)
+	if (last_soc != chip->soc)
 		power_supply_changed(chip->battery);
 
 	max17040_queue_work(chip);
@@ -416,9 +394,6 @@ static int max17040_get_property(struct power_supply *psy,
 	struct max17040_chip *chip = power_supply_get_drvdata(psy);
 
 	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = max17040_get_status(chip);
-		break;
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = max17040_get_online(chip);
 		break;
@@ -445,7 +420,6 @@ static const struct regmap_config max17040_regmap = {
 };
 
 static enum power_supply_property max17040_battery_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
-- 
2.53.0

