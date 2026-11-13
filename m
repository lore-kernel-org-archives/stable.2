Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582558;
	b=s6PfnpvmKIHFQxCSN0Qgn/Y5/YGxXHcRsy6Zr88eVJdPJpi8emrD/yXy/yVfnqDkS65u
	 YL+lJvkH+I8mw6NU3JI18SURk9lhRJ6M/CORmMNiUfY0xSRT04dDLsYJfw3oi+KFgogIU
	 S0e+aYV11ZSy9F2H8xJWNxseF7p4WqzbI2vn2Dg+juD79aS0QUFiAU2CXw4H8ev2MgOKP
	 R4kvsrXlwYA15xEGutFF/+a3W/BwlUNKHofhVGpbiaVFr461zUZ5INcAOU5BhFolEsZVR
	 wlJLRthidWqq0vLgQXMf4SQo7jocpQCyfybHjFagLFShjh7DnLBxe6Fwk0EryAi0ulw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xItLxvauvIJtdqmhpxXwYqqf5RzpHs/lxunoq6amVSc=;
	b=2VEzPwJxppk6OeUl41Z9jNEGvEBfcoIBqYHFDvOLNFLyeSuC8UnxAZMDByXBSI+qJHYR
	 FNNeiovME/QefFE+4Aji31QqwOlJwJ42N9xffhIYq3IT0cRymG7FDi2PQY9+XsjAzEDID
	 MIkGCg+Z0eCUaTTtH2CgVLUjWNJ25KwrLP13xKk5E97jl/dvOLzXnGxAR7IUS5r17yroE
	 9o0ugEIdZ6VrbuxHwI+s6TTQh507gYjE+ssiqixAkrRRbB9gzHGWctjODmOuNCsJHOJtr
	 TS4ZBV/07Sjrvgc8flOt4dg6b8lem5aYl6bAxm4zNc6HN2VRAWr9LivLW31FUHhVVEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsm959sN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0921606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsm959sN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E701F000C5;
	Fri, 13 Nov 2026 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582558;
	bh=xItLxvauvIJtdqmhpxXwYqqf5RzpHs/lxunoq6amVSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsm959sNKod+PUmIF2Tk5Hj5Zh76RQagWRftD1BbAtsUUc/+0uelK5IlUcWSvuPAJ
	 FXOQ5KEPbEDEEUdnTnK4uJqk3zZ043sGGixTMftj7F+yRrZWcwFLNrFG+oInwoQOZ/
	 XIxY6LrbBmcjhfpCPS7pVMTu3bcd+/4Zm21go9BrhmV/HoHQUE3ghivQK5LULTID+K
	 lygRK1uLNQNEI7teHt+yZigcC9ivKb3CMDogj1nin1PEPaxRqHOKK9nVQYLPXqAKWQ
	 N+oZS6JDXNDcqNWV8p6n4Dum0cSu+rLuPYM9biGhdP+6N9sPNapQ04eaKcG6TwZpbg
	 jB6rp86I5Nw3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare I3C support
Date: Fri, 13 Nov 2026 10:09:14 -0500
Message-ID: <20261113150545.1865145-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200723-failed-6.12-7cd60538073e@kernel.org>
References: <20261109200723-failed-6.12-7cd60538073e@kernel.org>
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
Stable-dep-of: 7cd60538073e ("hwmon: (tmp108) Fix initial conversion delay and wait until ready")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp108.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 18e7c9d9bcbb8..d95957d808e1b 100644
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

