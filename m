Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315174;
	b=N6zrLDr7n3JyxhNRFIr4A9yB+EPx0lMGzjSh7ewfDzSZM9PdNcl4uYU826L73FkYUdu2
	 txHKmocq7U7Nx24KR0By86HOCiQU6POJZxcAo0cECX4qbBQBQ73L349gFMOirfjKGa/+Z
	 sd1GAIBBXf+W7WnY7iSgESYtZd1ex+xL0ZMCTrgOfOiicMfScI7O+OX6UCRlvIAlPFjcB
	 Ur/IaTXuZ5MD36XCPDWDnEwZBp408JlaPoQRtyYABavA4uMPn4quSG7nL4figQo+EuzEn
	 Tof4UbX+aWwe0a+tyiaXkA5Fk67uLktmFRGwjVdgw8MRg7UiJLY3gFZRSH5vB+Q2Q8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315174;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qIvS41o3C40bk4RNCZxibV2DMQ0dRz+t0a4aTAA1Nu8=;
	b=lkMOWuP8fuMOoz+bhT6b957DOEP+EH+E1kNFF3UQWIWyIYSh3MGGcw9hvJB2tp3gCynJ
	 qjMKNxBjCa3liuJVUu+MhVar7LZ8kPigiLDHTvu0RZjUmMtNidLbldu36B+sw1B9ew3X2
	 0HYaJ3wW9JqdjmxkFKQtYtBb9xmqFOKl1teFnE75MurHdWPev4diewBF4yq1cZexz7y7q
	 2DGZ6SUM4YHJUwtJzRNR8HtthXfidSG3SGkGxE5sCGT1EpILuxKMJUbthBBu2JIzjqsl8
	 Ggb1OL++Sgx4PK5dme1+bXPRy50cqPw9tL66YvXBGLqGN7/+z743xGtY0aS+AjFjMbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dz0GfGBK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F3606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dz0GfGBK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADD61F0089F;
	Tue, 10 Nov 2026 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315173;
	bh=qIvS41o3C40bk4RNCZxibV2DMQ0dRz+t0a4aTAA1Nu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dz0GfGBKpwtWuBaGqr/BaAxOHRR9MMV/++4BlDrwM6A3WrgmFuQfRXSYqbW39U+G9
	 BPaNxXVi+VR34fgLv0lxv8fjo35RRbYM119p9YT9DOJBt8FOcpUE6rEkvsN8zQMf7g
	 k50jcpL6vo8ua4MF1NOCjdb4FbnyYLnQPE0eR6zRErk+SCazp4mJBVuTC75GPDMWss
	 CMjABjWDb89VTM1i85A6kR51ZbtO7xGlA/eJpYrUgcI9ujcmxZ/RxsQZhUlnpFl52W
	 sKMDW8rSm88ZwYxVlmkuHTKYvBWsN8nJ3k9WorNASHefkuT7l34LbUnG4L/avTchaG
	 BT5mUkOqdfWUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare I3C support
Date: Tue, 10 Nov 2026 07:52:50 -0500
Message-ID: <20261110125207.1400304-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051751-failed-6.12-6b8b1d1d7bc7@kernel.org>
References: <20261107051751-failed-6.12-6b8b1d1d7bc7@kernel.org>
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

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 700f3250198d51093884254220a96777a922dd47 ]

Add help function tmp108_common_probe() to pave road to support i3c for
P3T1085(NXP) chip.

Use dev_err_probe() to simplify the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241112-p3t1085-v4-1-a1334314b1e6@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 6b8b1d1d7bc7 ("hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index a82bbc959eb15..e86bedb31189f 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -323,33 +323,19 @@ static const struct regmap_config tmp108_regmap_config = {
 	.use_single_write = true,
 };
 
-static int tmp108_probe(struct i2c_client *client)
+static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *name)
 {
-	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct tmp108 *tmp108;
-	int err;
 	u32 config;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(dev,
-			"adapter doesn't support SMBus word transactions\n");
-		return -ENODEV;
-	}
+	int err;
 
 	tmp108 = devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, tmp108);
-
-	tmp108->regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
-	if (IS_ERR(tmp108->regmap)) {
-		err = PTR_ERR(tmp108->regmap);
-		dev_err(dev, "regmap init failed: %d", err);
-		return err;
-	}
+	tmp108->regmap = regmap;
 
 	err = regmap_read(tmp108->regmap, TMP108_REG_CONF, &config);
 	if (err < 0) {
@@ -383,13 +369,30 @@ static int tmp108_probe(struct i2c_client *client)
 		return err;
 	}
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, name,
 							 tmp108,
 							 &tmp108_chip_info,
 							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+static int tmp108_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return dev_err_probe(dev, -ENODEV,
+				     "adapter doesn't support SMBus word transactions\n");
+
+	regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return tmp108_common_probe(dev, regmap, client->name);
+}
+
 static int tmp108_suspend(struct device *dev)
 {
 	struct tmp108 *tmp108 = dev_get_drvdata(dev);
-- 
2.53.0

