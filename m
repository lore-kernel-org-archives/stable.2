Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445418;
	b=Wp3GG9qh7W5PRvvBVChYY9HuysLTDQUF13/tat+xisYlbBUjZ2VziyNhunEoMRuizxO9
	 Exn8uija1uxRb3H1lDxiQeQTuQ4D9OXaThurw2wamnwY7Pa+vgHk65j+l6jHOyxa72D1L
	 gjr0Y9pHJbcrzATCSVYYEqS64W8y4znSeD9zvOR7NyU7GxTMMgkuWwv+US4vWwthwF6DQ
	 OzCmLafoxpQaQFU6s0XQmgkSyB+FIwvnlGXQ7b1mZGVkvQH8Vao2KXJX9p126MV2m/7rt
	 pHBwtNbwxQ5UmhJ+l91SB6crjVF8bSX2dCnypYf+EHBa12A0lGN3LCuJefioiqcOOqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445418;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KmJxZZZJd+mPmCQy7IG3QMng24WFOCEFYE022Uozr4U=;
	b=eORPi7y5kh2gAfu7woXeHYCsFxoefPiAyFy1gFr5e6UbFTXROljgix/DoQFKA49WfvAT
	 B3mCfHD/YRAz9HbStbWEPlfJDRwNbsxJj4V52Sv6mDBHxqpmCBvLbPLZbELz1D+ftp536
	 r3m9/pj3WkQKAkz6JRbP5djnaXeb5XN11UFJ7/GF/Mesz1A+VOfAiy6qDV8KZO2kNIR/y
	 perhs80ZW0M6Aga1ucpAAGUXYHwJDjg19n9aWvJ+FVumRxrV4kDQNG8eYOtOjY0qw5JSH
	 OGV+1sLA2tiHruIfyE7F20Q064wYJhrrDYtmwa96NUqkvU/C6DaIlJcAvkTnrwtM01g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLZfYCnJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71C606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLZfYCnJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2653A1F00A07;
	Thu, 12 Nov 2026 01:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445418;
	bh=KmJxZZZJd+mPmCQy7IG3QMng24WFOCEFYE022Uozr4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kLZfYCnJBOfpDivkhc67nJb5nmExLneQZa4c7P40f7cm2i3Dbj82IhbIKPhr0WOQF
	 BlOnR7oPjjRU5tnrX0jLkgpZGTfnaNaqzKNrx+i0s2IrliT2WWrOog0q6661hW29qM
	 G57co6L1oO1q6FMnpRPr7Ws/QUTIbMS8WGXcfg2ri9usO/ScDJ47XdS3XxbpalvGIF
	 rOcblEIpaFU/PWMFvNhYSc6RxdhyMmqatMF0M+DkLeyGPkYXJ5tfU8ElgxTBzkpeQi
	 LEbP48+x9/znihHSKkxft60YA62VcuiDrQh0Eh4S+ZHndnQFmbWrFxiFypCdSli81R
	 8l0xNtYh4YDiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hwmon: chipcap2: disable device after hwmon teardown
Date: Wed, 11 Nov 2026 20:03:35 -0500
Message-ID: <20261112010329.1211633-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112010329.1211633-1-sashal@kernel.org>
References: <20261109200327-failed-6.18-4724ac5556ce@kernel.org>
 <20261112010329.1211633-1-sashal@kernel.org>
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

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit 4724ac5556ce63f01a3f5d61fc7fcc20f4ddef3f ]

cc2_remove() disables the device while the device-managed hwmon device is
still registered. A concurrent sysfs callback can then enable the device
after it has been disabled during removal.

Register a device-managed disable action before registering the hwmon
device, so devres unregisters the hwmon device before disabling the
physical device.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20261014-chipcap2_locks-v3-6-27ebfc2c5b9e@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/chipcap2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 8ba706ecd4012..6026514a763d1 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -167,6 +167,11 @@ static void cc2_disable(struct cc2_data *data)
 	data->regulator_enabled = false;
 }
 
+static void cc2_disable_action(void *data)
+{
+	cc2_disable(data);
+}
+
 static int cc2_cmd_response_diagnostic(struct device *dev, u8 status)
 {
 	int resp;
@@ -720,6 +725,10 @@ static int cc2_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get IRQs\n");
 
+	ret = devm_add_action_or_reset(dev, cc2_disable_action, data);
+	if (ret)
+		return ret;
+
 	ret = cc2_request_data_ready(data, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
@@ -754,13 +763,6 @@ static int cc2_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void cc2_remove(struct i2c_client *client)
-{
-	struct cc2_data *data = i2c_get_clientdata(client);
-
-	cc2_disable(data);
-}
-
 static const struct i2c_device_id cc2_id[] = {
 	{ "cc2d23" },
 	{ "cc2d23s" },
@@ -793,7 +795,6 @@ static struct i2c_driver cc2_driver = {
 		.of_match_table = cc2_of_match,
 	},
 	.probe		= cc2_probe,
-	.remove		= cc2_remove,
 	.id_table = cc2_id,
 };
 module_i2c_driver(cc2_driver);
-- 
2.53.0

