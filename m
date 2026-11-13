Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581281;
	b=Q55kw5dUL/iW4BcHEhYfcNtkwPmW2BEkfCklCLmKjis0ZaWlVy+KDp8ORlhbwaJCScXe
	 7qCJ2KEpQc5x9NSzcNMAfzd2TDWKIJPbOqPvDAO3uqH6SckOSiHqqRmvSdscGpKHbWCIs
	 QG2nNjQwSKiJorNBO6SZdu+TyfLTfrWCJyqypTkuLbcFXhv/RHMTWNXnCfrw0gaYf9Is6
	 kLAk7vOz6CeWLA2v16Dx/yIwvVhaj2hNQuNTm5S2PBqSs4hbrbu51lVz3qdhv2jeDpv9C
	 VzHjsROlYtO/0s0IdNmIiFUP/7ymu+fnZu6dDmKjnXcpWXsS9HcaZE1c9LtoixRpRVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tPdqDYFYIcO2cV7tO+02fBLKfFmizAs9+1fw879BFac=;
	b=D8Mqzt0bnUu/ao9RkmDXmqmoEeCjdh7P2G1++t+yBlaeS/Gl5KgW5/t07D9IsUhblkGV
	 2M7eC2gkCV32p7j+RZpr2RU9wCal8hNhZJiCHOZfz1cSXaMCOpNZgEMedrnc6mpMGzzhv
	 IdbbHLutuQc7av8t00aPZnwZauLnI9vOWFAUUlzMau3gf9/U3UvIVasN5qnLa0oATlOh9
	 DeBFeZwo/jq4VpEERq7neeCAHV6z8lQDiAqtMqBF1eEqPBaQe6l6C91hy/XJW5AP7bqEY
	 LdO0jNvXR1c0nG65FKDOeYHebSqvRulWYC/eZ9Iy8nr14/uK8txlYZY9nv10trN41fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMMDnc1M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8EF606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMMDnc1M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DA11F000C4;
	Fri, 13 Nov 2026 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581281;
	bh=tPdqDYFYIcO2cV7tO+02fBLKfFmizAs9+1fw879BFac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HMMDnc1MhwYnSfBh5QODqFHObGtmDLxQRLltNT/Anl/z7tvZeRpdrsdPr5bQehVKl
	 4kOiRqr7ERQFPeQ7wzi5MkU6kJy+C/fegUoXQKVDzz6QdfIZo93FKY5DWqAtw0QYl1
	 rSzbhRhD4B+vMrvSWZ50nyr6IfkaeAxoYhyeGg2RgUJp20/tZlcOF7StFnSOVMXR+2
	 CcFmeg7Z20j065uUP0KKMbUbDS1Vos89JniPQZ5eEqlt/B0ETtdxM4uFF87w+2x0Ot
	 KImObjmLvlqZAwJYIXMaWSd2HGnOeE8o7xhdTDgD0qD1TYUaFDUcedu11q+8rwhjZe
	 49ongNejZXLFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] hwmon: (chipcap2) Drop unnecessary include files
Date: Fri, 13 Nov 2026 09:47:58 -0500
Message-ID: <20261113135622.1498116-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200332-failed-6.18-bed5f0c075eb@kernel.org>
References: <20261109200332-failed-6.18-bed5f0c075eb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 4c8d758d4ebff3780d09599f2c8db5d6af3ca2af ]

The driver does not perform any locking, does not execute or use any sleep
related functionality, and does not allocate memory. Drop the unnecessary
include files.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: bed5f0c075eb ("hwmon: chipcap2: serialize access to the alarm indicators")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/chipcap2.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 5f4b0fd535af8..a3d5d99bd57ea 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -82,7 +82,6 @@ struct cc2_data {
 	struct completion complete;
 	struct device *hwmon;
 	struct i2c_client *client;
-	struct mutex dev_access_lock; /* device access lock */
 	struct regulator *regulator;
 	const char *name;
 	int irq_ready;
@@ -570,8 +569,6 @@ static int cc2_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 {
 	struct cc2_data *data = dev_get_drvdata(dev);
 
-	guard(mutex)(&data->dev_access_lock);
-
 	switch (type) {
 	case hwmon_temp:
 		return cc2_measurement(data, type, val);
@@ -612,8 +609,6 @@ static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	if (val < 0 || val > CC2_RH_MAX)
 		return -EINVAL;
 
-	guard(mutex)(&data->dev_access_lock);
-
 	switch (attr) {
 	case hwmon_humidity_min:
 		cmd = CC2_W_ALARM_L_ON;
@@ -726,8 +721,6 @@ static int cc2_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, data);
 
-	mutex_init(&data->dev_access_lock);
-
 	data->client = client;
 
 	data->regulator = devm_regulator_get_exclusive(dev, "vdd");
-- 
2.53.0

