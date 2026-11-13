Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582358;
	b=uyL6E1yyzaxMq6f3eVvot61qAQRFEM3q8txDBxdvin1BBNcwnUMj9bZWBFSljBt/kdV4
	 QdnnW2Nn7jc0y4uZ3sjOGwIS54rAB1OHH7kF9O97Wl+/q/FsVhV/d2A3aMssF/crzVq/D
	 PdEvbHd8bW2vVXqOsB/j7hUXwLd96e5fK8BGVSB18aF2fP0zx0cMw8ub88OFGpJl75h4e
	 hWwy3fQbDCj1mJ2jWcot7qzs3VBWA0JJcaqSyyQ9k0wEGr/tY58YiQkavgVMMY9c5d6to
	 gcJcKsMUB++s0Y/Xptj6SJpFCrW2Dca0GcBu+LD0/K/2n2Gx6vN0Bi/0JtaEYCL4deg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tPdqDYFYIcO2cV7tO+02fBLKfFmizAs9+1fw879BFac=;
	b=Lj3ZEZypQJePNaYx3LVykxdwUzgbSbIcPG86if3nep/2CLTqPQxeoXTXV3f8n7JZ7sx/
	 o851mpj1j5EM/+A7P750O9UvGi9+Zm72d60F7XjWGQmiOZXeYcArOIXFks3Gqd8dTJeWO
	 z/ENzD526gsCk5zikx7nTcw2VkTah3uxljrCyNEwpehDh1ORAAgfybwQ9d5bRDWXNVcUt
	 vKYFVrqIl+mVOkkKYbEp1o+96aHb5S3d1Gsv5VEb2hrJDCM8KYV6zgNeH4MFEBCRq1Jwn
	 SY1QNKwpcgcWpv8z3msk6Xc/jQ9lcgdMbFn7iN+TxyWYDKajnLt40mqcNWAJgldb9ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+wVnq9n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E8606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+wVnq9n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF11F000C6;
	Fri, 13 Nov 2026 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582358;
	bh=tPdqDYFYIcO2cV7tO+02fBLKfFmizAs9+1fw879BFac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+wVnq9n/a0ZVwqCXOs//pOego2xufH2JMlmUvO6d69oEo+AXvctFR/weorBUKUxH
	 UD9QLsIF0sNAUAgYMvLsd1KtwpolpjiQ4Z20OWsg1/Em5kMa60CJBOUXgu+QUxHG1s
	 6HDi/U307iK+MIGBwYdjfdqi88kq5SN/eYcu8Xd89HcRiXIWXqNjNLrvWwlO42CyWZ
	 e+dJFdkZb+9wxPqSyvc+BT+JDmTnm0Q5afLAA/+9zyoXQKRjcwLU3FOjSwpurbLSQ9
	 EUEi0eE22CYVvhSivTZXiG38mLyECF0QUW9VGxSfpg7tpyWUBX96rNMQMdELhFXj4k
	 qt4T37z1HQazw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] hwmon: (chipcap2) Drop unnecessary include files
Date: Fri, 13 Nov 2026 10:05:55 -0500
Message-ID: <20261113150539.1843706-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113150539.1843706-1-sashal@kernel.org>
References: <20261109200719-failed-6.12-bed5f0c075eb@kernel.org>
 <20261113150539.1843706-1-sashal@kernel.org>
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

