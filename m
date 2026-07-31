Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8653C8700;
	Fri, 31 Jul 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487448; cv=none; b=g8+KCUYJY9H66jtoGJSPecT43kJd2x/MjguyOpCXfKKKfuwvAKmeqGJmDwg4K4LdfIGUHs26lDyyIlh0hUWwg3mtz3PFYJJYtRDAKFKBD9oEUBy0wyjOUe95UyiF7ZN4i5rULdgg2OBvrFUwo9dSynVNQFyAAsqklpAOdaiEsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487448; c=relaxed/simple;
	bh=rR3bx8bTKOdbLvBlwiFTDxDkxVPMurUGXLng7YD3Xz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UP4KO2MidJbT4I/OKx4/F3mwGiwSIWcLLnfFp6gD1g7bvJCKL5pkGOBJ7362qnkXdVKEwSmA0jGT2Gmxps6Ceu94gVXfr162s6c/pWXSWQZGy5uaK6O4MrkwHOHZulTgQq2/QfSVqCFtiBQontt4cVxznj5Szzz2lQh8B5ChdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IkodWosq; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IkodWosq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ch
	nRK+f+QN2xrkbOGk6dgBwvq7tejnNWZlvbVTRSm54=; b=IkodWosqUZFCPOpK71
	HVQvuqlPx0iYUNR32jPRLzWieN1llnHqVwfCKgdxMwrPhPl5uA1gxSDxnGv4Cxka
	Ou2sjHe135dOGsIL12KqJ9Em7HBNpTJties+ZT5Hyj57ZDNmcyFY0YmIEX7FAZrz
	yAURd9yZzVOPD0KqR86GRkto4=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnJIkbYGxq6spFNA--.56958S2;
	Fri, 31 Jul 2026 16:43:10 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: max17040: drop incorrect I2C functionality check
Date: Fri, 31 Jul 2026 16:42:59 +0800
Message-Id: <20260731084259.916-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnJIkbYGxq6spFNA--.56958S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr43Jr4xtr4xXrW7Kr4Uurg_yoW8ArWxpa
	n8GrnxKrWjqr4q93yDtw4UAFy5GayrArW3KFyvy3sI9anrJrW0yF98trW2kFW7Jr93ZanF
	vrZ7ta45CrsxC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRFzuQUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC+x7UD2psYB5M+gAA3w

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

Fixes: c6f4a42de60b ("Add MAX17040 Fuel Gauge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/power/supply/max17040_battery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 98d34d5f3c80..b641d7387311 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -470,16 +470,12 @@ static const struct power_supply_desc max17040_battery_desc = {
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
2.50.1

