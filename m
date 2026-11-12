Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443645;
	b=NGC2ygSVtuPWtzTkZMfFDXB5mZj4Fyj0t3Vhmup3rvqwwhCac0oL21X56MrmIvt6yzy1
	 szYHaX4bCALx4ZGWHopIfZKawI8A4hPxryvb08v9SOQJmtyr085uDnIHGF4Dvix6yy+Ns
	 vNZUG+s21Bl/cOW519VlcZaW3l9ljQrsBo3yuqsabixOzXFeK7WEkS4rUT3ibOvNmMZwY
	 xQZ487OClY/gfIO6CjqEKOTfq7qNHnL2Grj56yanRBh7wia/MwRg8xsJ6CFZh9GR8ioZi
	 xAGbtlovWd+odvEgxk/7ACOwKSaqkeJJyW9xX8sxHWWCZSIcCVNUtIRM7ZcFWBaiWEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443645;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vGqzueVGz9mslqqCNOdFpgnGuacxoKSna0rcJ3p/p+Q=;
	b=oStVrivI0QNH1fVAhxPbus5FqCUneEO1LlTTWr1R/KFclfzPUbBdcF5TqQJ3cY22/jyL
	 iuqdh4p5aB8hjqwfClLhDquJcsBaFestS6q381V1E+bkpydUnpWVB1D1jAJhQgslSPS0g
	 G9oOWW7SRO2l/pX3GyaI3cD3zsd33Jxb9GaA9OLpaOvG5Z/1QqhpLxGTiVVqop/vcjWk5
	 Xy/wUVXXcGu54cP9nxZUDJOZpji/I6BdpzlYUiUqNQfxCDlZ4oUK0y+zpBRLwaqW1fV/9
	 C3vne748BCyueRsXX6G2NczBQh8tWmuB+8eG4NJ5SN8Q8ocFw9/nczyVQjFFCb5SVdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtXlQvsg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC0606A326
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtXlQvsg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A0A1F00A05;
	Thu, 12 Nov 2026 00:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443645;
	bh=vGqzueVGz9mslqqCNOdFpgnGuacxoKSna0rcJ3p/p+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RtXlQvsgCmcbOX60CKFSYTbF2EtwNyCh8+rQR4UvAMb6/MGUxhZmlpYCzHJe1EJc7
	 gg4X1tac4wpWSJzi6ejP+rAt/+WTwjsgFW3eBETVnC49w86Bjv5LE1Z4slgC1jD6//
	 fq0x6kjQdSChwSc3Dx6kxpA2rvbeISNvrxQBQK0vKqf9hz0/YaAk2ghDeWbZCKuAl4
	 HGLhMUnhuHxT2sYD9Zkl9R0R9WgLvxCK6Ir5bbXPMAcYN8W28XPOIiI7poNWdTHfSm
	 gOKyRB3NoLAG+2ntP7C3kXYkc5U6yv2Pg2kDAZrz5XPzYxXWj7/oCY/yveQSNRAeBz
	 G6Dkfg11CzHMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pan Chuang <panchuang@vivo.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] hwmon: (sht15) Remove redundant dev_err()
Date: Wed, 11 Nov 2026 19:34:02 -0500
Message-ID: <20261112003357.1182045-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200712-failed-6.12-5eab1e7f7ed1@kernel.org>
References: <20261109200712-failed-6.12-5eab1e7f7ed1@kernel.org>
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

From: Pan Chuang <panchuang@vivo.com>

[ Upstream commit b8ffbb950dffbcf810ba41e776516cf3438bbe25 ]

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs detailed
error messages on failure. Remove the now-redundant driver-specific
dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Link: https://lore.kernel.org/r/20260720063745.309331-7-panchuang@vivo.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 5eab1e7f7ed1 ("hwmon: (sht15) Stop deferred work before releasing its resources")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sht15.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 3d55047e9baf9..48bcd362c4808 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -981,10 +981,8 @@ static int sht15_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_FALLING,
 			       "sht15 data",
 			       data);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to get irq for data line\n");
+	if (ret)
 		goto err_release_reg;
-	}
 	disable_irq_nosync(gpiod_to_irq(data->data));
 	ret = sht15_connection_reset(data);
 	if (ret)
-- 
2.53.0

