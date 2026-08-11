Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A0439F60;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491013; cv=none; b=WqQlZ1EqtTY+QeOz/C1xBqoUHcxY01mBmc7DLFBWHFR2ZWbRHJwJnG0zwAyHA5ulOYMQYrIc2BBSIpK/ZA/T8AK5E1a6T8fh0BiATUlX7B5fKjZWgXKBwNh/RP7XnKCsk07n02zADeUc1B1p0TVbE6ifsPaO1ue68IlwyfeSvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491013; c=relaxed/simple;
	bh=4YHjAlEOEgbG+Gqd1X4ikqkRekgCBCEWcpaJ66iXyEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgdhdHqYNvy68b9hD1g21nh/IoInWmMSIUpSKi5UFf7RzCHz8pgPooytkp3xd86zNvEiCMoDAugQNN6ZKCOZ1mWstuqC1d4Q8gBas+/O0qptp0FmkswgYQzDhxw0IjdfbS1u+zDjjEif2T8CGiCnZNbkjc5B+WQfaVGH+OYxn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUA0CTwE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUA0CTwE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42FA6C2BCFB;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786491013;
	bh=4YHjAlEOEgbG+Gqd1X4ikqkRekgCBCEWcpaJ66iXyEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eUA0CTwEoMy0N++9yZ3pzgmHfIKfxHnZCIVgUHm9AuEUx2dGcQ6ATwF8VvbdytxLY
	 YraDNMU3hO+IZdpUh+HsuBMPy4axcGRLwtSL07grT49+YKxH8kLzxq00pRC9Q4ExsR
	 SZC5voNVEQMRMTWp9NdPyx1IxH/NRyHULP1mPAlwWTtdzQlghTrXqugbv3w+CAqXM9
	 efUBs35xmLei7ab4o8rFbXX5D57yhNV4464OuSwmuIBtx1HvpWbb0FrX4wRTpdpc/M
	 KN4bCj++hBJF0o6WRJI9bZwosHbgIQH0gh5WiUAFa8Uaa80aLr5eTXbVF7KjPU/WDy
	 EU2zVQctql2KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32972C5CFEB;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Date: Wed, 12 Aug 2026 01:30:02 +0200
Subject: [PATCH 5/5] power: supply: qcom_smbx: notify battery overvoltage
 recovery
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-qcom-smbx-fixes-v1-5-eb48246be599@snyders.xyz>
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
In-Reply-To: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786491008; l=1644;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=U5NNbxKVGqkekK9ViQGXFAmK/qusgcI2nUh+9IqA1SU=;
 b=jtO6+0+lZixYfh8+WaM38GISaisUrZaUD5Z+Re84+d+Gs8/4CMMAjTQGDS84TFFC4Z7Mhw1qe
 jBEMqh+Oyy8B9Lk6G1oXfEjJJd4kgNC9UH4dEXykmrZXevoo6jU/tyO
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

From: Robin Snyders <robin@snyders.xyz>

The battery-overvoltage IRQ is configured for both edges, but its handler
only notifies the power-supply core while the fault bit is asserted. The
falling edge therefore does not publish the recovered health and status.
The handler also ignores register-read failures before testing status.

Handle read errors, log only an asserted fault, and notify the
power-supply core after every successful edge read.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
 drivers/power/supply/qcom_smbx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 55ffe9857e494..f5557b8cc92ae 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -722,16 +722,22 @@ static irqreturn_t smb_handle_batt_overvoltage(int irq, void *data)
 {
 	struct smb_chip *chip = data;
 	unsigned int status;
+	int rc;
 
-	regmap_read(chip->regmap, chip->base + BATTERY_CHARGER_STATUS_2,
-		    &status);
+	rc = regmap_read(chip->regmap,
+			 chip->base + BATTERY_CHARGER_STATUS_2, &status);
+	if (rc < 0) {
+		dev_err(chip->dev, "Couldn't read charger status: %d\n", rc);
+		return IRQ_HANDLED;
+	}
 
 	if (status & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
 		/* The hardware stops charging automatically */
 		dev_err(chip->dev, "battery overvoltage detected\n");
-		power_supply_changed(chip->chg_psy);
 	}
 
+	power_supply_changed(chip->chg_psy);
+
 	return IRQ_HANDLED;
 }
 

-- 
2.54.0


