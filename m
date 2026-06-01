Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF52340401
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780345693; cv=none; b=sIfOQBWaLW1cDk2AyhewOOHI74a6J5a5X9oSDGoOlOLHwud8Dpw/u1bgMCJWco1C6tCQpD26rxGH+qLtKy5llJFPRuuKYQIofoYUKYFKfGKKcOVf2UwbOC2Jci05xsHn81Uc7KqVWki/tLSdG/WJ67eFlKELU1gjCFziF7yQTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780345693; c=relaxed/simple;
	bh=YbfO77u0eMTZ8g5bQasy59CzfR2/RE2K62uEC6ChEHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnoFEUBOo+qKR6K/0ORjfo3doI3S51UHu53pqd4JzVbqVP5P4e955yBx+zq7zeP7CGA+WWaJMBL+4wbLWFp4zpF2D91SwQc6Ul9gm1TpWWZJxigH+8Q0WrsawiWxK+53jXGPMeLT6imHAbn2+WFhUyAtGz4xqPdNoOGOVDybORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8W7xHl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8W7xHl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC2E1F00893;
	Mon,  1 Jun 2026 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780345691;
	bh=TgYRNp0WFluaR11aHrV6frzMOxEHo4s+EYD2ju0cSkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8W7xHl044nHludjMH3GsED/OJ2xnFjMYfs8pRKEt1XJUpbyizNz91vg71+rx8Ym2
	 BgL0d9uNIK0wC/lqbLCfgX4o3lxRKn0z2/OOQt0lUZYQyh9cooCRYDB32foOXlRbwV
	 BTiJqkA+8i8XU88Zsktqi/AVxxPH9cEXGMQP1SaVowCv6GQTDPiVVy0MSTItSp8Gxm
	 Rjzi+RvxAlIauynGUOJy7HQVKRdsRjSRsrAxdXDmp/akKzdbRKFycZsD6GaNjxkpb1
	 +/M1LQcxCab1Vvky/yABE9tZhYY0Px7ZtH315NMud5mfkSeNWd4/lhHamVhBKXePyL
	 h5SEh8ucVNpQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock
Date: Mon,  1 Jun 2026 16:28:09 -0400
Message-ID: <20260601202809.1258189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052831-abreast-slurp-dabc@gregkh>
References: <2026052831-abreast-slurp-dabc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

[ Upstream commit bab8c6fb5af8df7e753d196c1262cb78e92ca872 ]

adm1266_gpio_get(), adm1266_gpio_get_multiple(), and
adm1266_gpio_dbg_show() all issue PMBus reads against the device but
none of them take pmbus_lock.  The pmbus_core framework holds
pmbus_lock around its own multi-transaction sequences (notably the
"set PAGE, then read paged register" pattern used by hwmon
attributes), so an unlocked GPIO accessor can land between a PAGE
write and the subsequent paged read in another thread and corrupt
either side's view of the device state machine.

Take pmbus_lock at the top of each of the three accessors via the
scope-based guard().  The lock is uncontended in the common case and
adds only a single mutex round-trip per call.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-6-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ open-coded each `guard(pmbus_lock)(data->client)` as explicit `pmbus_lock_interruptible()`/`pmbus_unlock()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 40 +++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index a8690d6c9b9cb0..518eaf07a123de 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -173,7 +173,12 @@ static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		pmbus_cmd = ADM1266_PDIO_STATUS;
 
+	ret = pmbus_lock_interruptible(data->client);
+	if (ret)
+		return ret;
+
 	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
+	pmbus_unlock(data->client);
 	if (ret < 0)
 		return ret;
 	if (ret < 2)
@@ -195,11 +200,19 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	unsigned int gpio_nr;
 	int ret;
 
+	ret = pmbus_lock_interruptible(data->client);
+	if (ret)
+		return ret;
+
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
-	if (ret < 0)
+	if (ret < 0) {
+		pmbus_unlock(data->client);
 		return ret;
-	if (ret < 2)
+	}
+	if (ret < 2) {
+		pmbus_unlock(data->client);
 		return -EIO;
+	}
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
@@ -210,10 +223,14 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	}
 
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS, read_buf);
-	if (ret < 0)
+	if (ret < 0) {
+		pmbus_unlock(data->client);
 		return ret;
-	if (ret < 2)
+	}
+	if (ret < 2) {
+		pmbus_unlock(data->client);
 		return -EIO;
+	}
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
@@ -222,6 +239,8 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 			set_bit(gpio_nr, bits);
 	}
 
+	pmbus_unlock(data->client);
+
 	return 0;
 }
 
@@ -236,11 +255,16 @@ static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	int ret;
 	int i;
 
+	if (pmbus_lock_interruptible(data->client))
+		return;
+
 	for (i = 0; i < ADM1266_GPIO_NR; i++) {
 		write_cmd = adm1266_gpio_mapping[i][1];
 		ret = adm1266_pmbus_block_xfer(data, ADM1266_GPIO_CONFIG, 1, &write_cmd, read_buf);
-		if (ret != 2)
+		if (ret != 2) {
+			pmbus_unlock(data->client);
 			return;
+		}
 
 		gpio_config = read_buf[0];
 		seq_puts(s, adm1266_names[i]);
@@ -262,8 +286,10 @@ static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 
 	write_cmd = 0xFF;
 	ret = adm1266_pmbus_block_xfer(data, ADM1266_PDIO_CONFIG, 1, &write_cmd, read_buf);
-	if (ret != 32)
+	if (ret != 32) {
+		pmbus_unlock(data->client);
 		return;
+	}
 
 	for (i = 0; i < ADM1266_PDIO_NR; i++) {
 		seq_puts(s, adm1266_names[ADM1266_GPIO_NR + i]);
@@ -286,6 +312,8 @@ static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 
 		seq_puts(s, ")\n");
 	}
+
+	pmbus_unlock(data->client);
 }
 
 static int adm1266_config_gpio(struct adm1266_data *data)
-- 
2.53.0

