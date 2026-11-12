Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446082;
	b=3RZQ6lbL52GkxJWHWX4UCGa0aON1rrXkgr5ZVeZd0C8WaYVaxHVxESYBICVQsJQIz0jS
	 OnrKXFD/a8v9pfaEwIZreyVBX1UIhzhUu/9dRDYrs5gJ8Zv45iNiChZ1P1oLTX8yUo++J
	 nv5y4mDZEFSbx8g9SeyR53r9qyDtn1r9IE7M/DBbL8vMrkOpkW9lD4lGo9Iik7eF/W3ul
	 nidV1znKMmBUHC/aI96gSiC3KZlztm4GYhyTws/PwCH95C9bZbXWyhDXCf+4ntBCKDumS
	 0hIeiyHeT3L2uhg+TZg7Z3pACtgGTclz6bCKs2yj1LxccuLdv/3vW2dG7es4Cz36FFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Vu5AlPnyrnNsIcqUHMsWKv8/J79A1BXRvAte3fbwqSQ=;
	b=DxEa0Reed2YgbqDYEnzh4N6v6wNzmUOUa5WBvyhyKfo0nxMdyjIWW+5A60r2ywj8mS8k
	 N0l5GhKfV9C+lTrcAWt3yDycoUMYrvkro5aIPZ2YkBN8kMCtCYWO/bZBNkqRu7ITNBM63
	 n2RY04Q/KAmOtldzZyaMzh+IgyWDUSCSALCaCQYQPH24mb4bkJXN/0U2WsL87CgR5sJN9
	 9N4XziQsYWR+ccsQjGtWgnNGdIrGsQMSXyCSA/olbYOGV5HBwasQSJ3m6kM55Y1MIHAFe
	 IwGatAwXmbQecUcH8qAlB4wG9DJu2Didgktb/nYNdqJCIEvDAalGw3ajudfjdwEFIkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4pY4XvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4B606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4pY4XvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2D01F00A07;
	Thu, 12 Nov 2026 01:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446082;
	bh=Vu5AlPnyrnNsIcqUHMsWKv8/J79A1BXRvAte3fbwqSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4pY4XvOjOiGuEGxaa/gYeXzURVkx0/hCn1db08mbnoPGKSoOKKXMKrsd3jhYZhNb
	 wFbjODi0jCP5FJ6rXyDGTVY9SoX1umuBQ51kc6binhPxiPKIJk3t6XRMx2A0kmcHYK
	 NnZc9PMLNy8jYW08qL62ntFFmx8go7AqfSHU3BLd7rSTMS+1/FkueH9jEItvLgmeKz
	 6odpf0epTcv07XWSNLXip07NSAv7THBIGrn4xhQFzhJ/WVF+A+TY+edj+sddf+66vm
	 qChJbeIMIWa5ni1SgMytaAjTi8/AYtHlcd3cbsMzIJxi0q7Rz02kwlPvflcNuEa1y3
	 oqRcbKlSstyRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] hwmon: chipcap2: disable device after hwmon teardown
Date: Wed, 11 Nov 2026 20:14:39 -0500
Message-ID: <20261112011432.1219934-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112011432.1219934-1-sashal@kernel.org>
References: <20261109200717-failed-6.12-4724ac5556ce@kernel.org>
 <20261112011432.1219934-1-sashal@kernel.org>
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
index 0f7711ca6feb7..6a69c7699594b 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -166,6 +166,11 @@ static void cc2_disable(struct cc2_data *data)
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
@@ -747,6 +752,10 @@ static int cc2_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get IRQs\n");
 
+	ret = devm_add_action_or_reset(dev, cc2_disable_action, data);
+	if (ret)
+		return ret;
+
 	ret = cc2_request_data_ready(data, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
@@ -781,13 +790,6 @@ static int cc2_probe(struct i2c_client *client)
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
@@ -820,7 +822,6 @@ static struct i2c_driver cc2_driver = {
 		.of_match_table = cc2_of_match,
 	},
 	.probe		= cc2_probe,
-	.remove		= cc2_remove,
 	.id_table = cc2_id,
 };
 module_i2c_driver(cc2_driver);
-- 
2.53.0

