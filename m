Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84229BD9A
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365992; cv=none; b=IJgGNeX2xGtjJDl7Pb7uCm/rEgFyk2BbsVtyp76EQlMgdXtsnouDVJLkdZPMYTFnJgrod83XrFG0n+H0NHA9FmZvzxWKEMOg8FqGeS2a5HUTNmm5iFRw5Me9uXvk1eJdxzrLtn7FKOsmqzKxNeUSdwfqsYK/kkfL/57OtKWxw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365992; c=relaxed/simple;
	bh=tANICv2jg4YBX5qq90HhSr71mk5fwEJOpKDmFLV8hv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpYk1F/VtazpRZzctEgszBWCZBiMVuoSc3E8eoMWurp/XvGhPfeGVYrBFLr+0JWVWcOL91tTYdRgGX7biIvWBrOidV3bXju/recRCPaHoZVrlGueJ1KiG1BwsGP3n8i234wdHHXbV55OD9vMevl3sCpOULQxSt5hl9eQlx2Q2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILCdNWHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILCdNWHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4951F00893;
	Tue,  2 Jun 2026 02:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365991;
	bh=82JkpuLiTKvG4D9tOYYoL7JiFDlUD8g3gXEuzHhelQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILCdNWHZcYkFRXFbY7xC+QJ4YvdiMKgVQX3LUeeh8jYu6X/CxftwiYyJ1nSmbhKYG
	 92tmfCojY8LS5PCN9N0F9pLvqXHWzgQOGvE99sqZDeXKAIJSS/l3CNL4n4EaLDczmk
	 HVz6AVbmCswN4gsE27kmX8UtiBfyRdkA4XxHfZ8eXV1BV40rl1+TInuuuWkAHKiPG6
	 MY1JS5icKBJzESvfTVJZ+5yJWK0UO3Z5Kbx3thJeuGf6+prvWrbNWrqtaXyfHflQdK
	 K6m1e2dRzZ7O4be2vahnbplfoufr+5JCbjThc5LUOJ2HowepK/cGYg7/89yotpAS3h
	 c45I9y/Xvh2kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock
Date: Mon,  1 Jun 2026 22:06:29 -0400
Message-ID: <20260602020629.613997-1-sashal@kernel.org>
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
[ open-coded `guard(pmbus_lock)()` as explicit `pmbus_lock_interruptible()`/`pmbus_unlock()` ]
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

