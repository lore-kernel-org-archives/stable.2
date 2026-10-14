Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F956854D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999269; cv=none; b=OCnSonfvfP7h8czPk99+OEUDwUsOgfIe6SNh3RLefE2SKjuD/30VCOwIPX6BGCSUgnuHNFageA9sArp6GomB3EjuNJxr2LGJOrY6VtoS1/F71EGvJSCSavELFL9e/h6MbmKxf2ehw5S+8iI7fXlbZL81PcCg4jAz/r/LE6Yczjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999269; c=relaxed/simple;
	bh=tEaYoaokfTDeC+YTWR3V+2BkXiRgjSARyNOHEZYlDSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+c5ip81LybPMpYX4I0wpW9P+IxW41nv2iyfhXNthkFFk3+0jRAgch0Ocy622JUjxXbG7E/Mi/HgjgkbQZfTn4sxPriw+2JIMttud1jH9CLMlnFggNTezDwrVNvJwaT9HUkhC1ozgMV1ya1fX2KY12eusn1hEE0uazXts5Weu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTr/V+Sb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTr/V+Sb"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e6df2742cso681929666b.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999263; x=1792604063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4o314AkdT/hGMbAfrRQAXUHtm0eSAGgqeibTH2FdEkQ=;
        b=kTr/V+SbgjAUKvRfsrnQ5vhDid2r9OpinKSRPvLTq+WTha/2X+8BT1ItxSN4POf5nk
         Y2HWWhSdO/3JP8S8ktee9XFHXo4RHBubEZJK6ON60cK6iz8QpleKHpniuwJbVbrCWASO
         QgkFJ/CND7QJBHFSEP9Teuffmd75T6Utl/s+aBSd2n0qUUuHBs3kHd2wWWTRixyLp0Yn
         wUohuTW1KXLaqygx7bQmM1f2Bv59yoUfz0hcUhbB+0+bdnLVd17NoURLgkG9ZNyzTKOV
         2wdqu6Sa26o79Va8fNGyL833xN0BnrnzLUlbln7OZsxU/mtfZQbFK47I2aX4l9i72DTz
         h3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999263; x=1792604063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4o314AkdT/hGMbAfrRQAXUHtm0eSAGgqeibTH2FdEkQ=;
        b=feESy8D/1z0dxeMK9Q9savkMix5eawSl8264khSbnd15XLjwsg+3XSLaz90EMCCzzD
         tL4C1zbq6wQaLIRYL3zistsdu+8JTcBYCaPo8IhSqaS+qLDoWhNBSFHxvBNwHzV/1Vck
         KH3HvZB3K6gcnfUOBJs4sywVDrNisBxKI7+hy/2hyP26QA4Yh03VWQdiHhKlL3ARyalW
         UlSyoMH59BofuIsXt1u2idfItcSbC9315qIbiQe2uZJ8Dq0GdrakWctv+B1UAK8wtSqH
         9x8UHy59ulNEgTIx4PHpHqxmY2XFMIUIw48wvFdKaaGjxUEMzdskqqE6jpdZQLu4Ayvu
         7K7w==
X-Forwarded-Encrypted: i=1; AKwUvBwT82nHzlus76NRGiOvffaaoYN7OsGWgIBz3g0gtWy7CnSq4UeMrKDy8uQQeL2b4TCZCs9LOo8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqH8IptFR+tSptHbw4sNbBiUQovME8zNKI4y6Bc7/kcy2Kfk31
	cp+L+A2LE+cuiZGlDtM9SOJlQyr+OjAtPMg44Z1MPE8figaABop3zcEi
X-Gm-Gg: AYBFou33G0fQ7kTzOrfZd8EtFnCyXPdcfaHhm/nXwelASwNJMY/cVCKj1IEJXyqmtl9
	XEPGcPcgVXxhh0lb98h8XWRoWxi/aj5JlLz7Hd08gdWRPd391vF/O6G1a2oQ+32RnNQZID3p6fp
	GChH8vTJzMEKG5aWl6+iSnpg1P7SVF7tHr7E5a1E+Kcebt70AIjZ385kLZhWM8lFGxqAxOnjnxV
	huWbj/ehrPCbQuATIV5ZIwD+Jp+7O0t9DXJdC2aMId1FZkvltM+oDjvROfPxjBN+RH/XIooy7IF
	iXvHKSNo1NBHwFpIJa5sfemqZ0VLOr2B7wsRz/zrwBxqKlgnQkh/FFoEBITNIIqFlfdfAjZr/S4
	W+4s9spLgYhx+5Npt3SdNsI5kLQGxCULBRz1OzxnJ+TX0d/4+5m3Fozr+pxw86OhdXFh8eVRGfj
	/L+rpL7jHgPBe5czErXNey70K4pk1KU2NHNzNjmx5fkAJi/X0MeQQtSjFvJQRn6CFifKk0m4aJT
	aMXYHMVsnLPzBIT
X-Received: by 2002:a17:907:3d4a:b0:c26:22ae:b66b with SMTP id a640c23a62f3a-c31a9fa1d4amr1618151866b.15.1791999263151;
        Wed, 14 Oct 2026 10:34:23 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:f08c:65a8:f8e5:f310:5a71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963cecesm9381366b.21.2026.10.14.10.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:22 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:05 +0200
Subject: [PATCH v3 06/11] hwmon: chipcap2: disable device after hwmon
 teardown
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-chipcap2_locks-v3-6-27ebfc2c5b9e@gmail.com>
References: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
In-Reply-To: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791999252; l=1970;
 i=javier.carrasco.cruz@gmail.com; s=20260924; h=from:subject:message-id;
 bh=tEaYoaokfTDeC+YTWR3V+2BkXiRgjSARyNOHEZYlDSM=;
 b=DU00AsHpqm60m8y8hn5WeCDWjaGzKIjb8MGXi6ooaNx0rRcHilmSsoGZ7KWf9UAzL0l6yheJ/
 A7xJ9vTetJfDZJb90s6FWyJegpqVQY+TFNRvSerHuL7jvfKy2eo0DYh
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=VV+hcMoOj1Sx6xSiY0W/FZNAskGZe2AagSMVj0PsmAs=

cc2_remove() disables the device while the device-managed hwmon device is
still registered. A concurrent sysfs callback can then enable the device
after it has been disabled during removal.

Register a device-managed disable action before registering the hwmon
device, so devres unregisters the hwmon device before disabling the
physical device.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 21dc6db27c40..654f6420da7a 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -152,6 +152,11 @@ static void cc2_disable(struct cc2_data *data)
 	}
 }
 
+static void cc2_disable_action(void *data)
+{
+	cc2_disable(data);
+}
+
 static int cc2_cmd_response_diagnostic(struct device *dev, u8 status)
 {
 	int resp;
@@ -744,6 +749,10 @@ static int cc2_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get IRQs\n");
 
+	ret = devm_add_action_or_reset(dev, cc2_disable_action, data);
+	if (ret)
+		return ret;
+
 	ret = cc2_request_data_ready(data, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
@@ -762,13 +771,6 @@ static int cc2_probe(struct i2c_client *client)
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
 	{ .name = "cc2d23" },
 	{ .name = "cc2d23s" },
@@ -801,7 +803,6 @@ static struct i2c_driver cc2_driver = {
 		.of_match_table = cc2_of_match,
 	},
 	.probe		= cc2_probe,
-	.remove		= cc2_remove,
 	.id_table = cc2_id,
 };
 module_i2c_driver(cc2_driver);

-- 
2.43.0

