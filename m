Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352232;
	b=0LDV78lpLEqB7MnO06QGcbB1N7V+6RfxOePNNhTznBs4/DjF/xAiLit/JjdgunaeA0yQ
	 H3QHnFnpqyO8lR+b/RfHacYJyTNyesotLLbA5P6a7RvMDrCzhVSxej9CCNErGkjW+xBi0
	 cSN/1XsXk0Fm6oeuGeZD8vZdpzG/gCB4461otWbWYqfjlqKBPVbLveYXZX3dAdChJP7/3
	 IJfTiMcJgp5iR0+OPSgrDZC5Zj7UEutIAEM4zGQUwPriQ0SS/qTkXTcbU3dxiDptOhdCW
	 +u1DTP7NCQ4F5sGfEHi4UolfCboTGcoLSU7YKJOjgvT6gx3TDR3eKz34TbqqXblqWQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QjEXXGi0cnyHSn0Vmlkr43DRMSa9IcIn46/K7rv9Kus=;
	b=yrgUqzTDHvFrMVmt4QaD8QdiqPJtoN28LCbuB4MQWynLJzn1jjIP6DDpXcRTpnXztL7X
	 S6ol+f2NL3ymI3nAGP+UATCfL4kZAPH9gCXcr9hfXz00P+TYCYyPGBDMF8+hrv1SZQ4bc
	 2tG002cJ7aTanJm4VX9/I0MwYpwaNCxZFkE7Xq8KmW9CDchRTDZ8cWrL6fjQvZHiukTzf
	 WpWd4SCW5f2+1h25pAh5oVWljuu/jiWgnd8vTX8TPXBsqa4hcdzJ+POBuL6hODf6JefA4
	 y07IOoEujL/K/kOqVZWhPBAJ68KzNPl2aK1oFavZbB+al+y5Zd7dJfOGD6opqkV7Esw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEwGu9JZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED0606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEwGu9JZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAE41F00A00;
	Tue, 10 Nov 2026 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352232;
	bh=QjEXXGi0cnyHSn0Vmlkr43DRMSa9IcIn46/K7rv9Kus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bEwGu9JZtGtEnzBFZS8wqAZBTyFIXFwKfcM5harEd/KjZFVeavF0ZVukG4eOwiJnD
	 kjSOZuGxzzQFzDU5K6EBhw1wLJYAAVwUD7P5y4hfW7syusM74K0VkoQmi0ZV3Cvs/B
	 dMb/K1TCFLnXF1v1mn4RBAtF4HvIaQmwR5tDNLfb835PUyrdjbBhqF+ly8rPKhBW7I
	 qA+WyfCYR/4cNHG2J4+5PUyK17NFgGYYuyPwuAWUTuyhIbr87ucpC7rUrYauBtZ3JQ
	 yPdlNqx7DMEPXcfgSNiVcPLF6gYNeW17n/DnSbczwqubsfUfRNKdkbHL9W9Ylx4Ioe
	 90o7GHAK02oTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/7] power: supply: generic-adc-battery: drop jitter delay support
Date: Tue, 10 Nov 2026 18:10:25 -0500
Message-ID: <20261110231006.55369-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231006.55369-1-sashal@kernel.org>
References: <20261107060802-failed-5.15-8ae5a3f40045@kernel.org>
 <20261110231006.55369-1-sashal@kernel.org>
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

From: Sebastian Reichel <sre@kernel.org>

[ Upstream commit c8f573f312f36861db8e40d9953b6d4b84f1321b ]

Drop support for configuring IRQ jitter delay by using big
enough fixed value.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Stable-dep-of: 8ae5a3f40045 ("power: supply: generic-adc-battery: fix status with no supplier")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 13 ++++---------
 include/linux/power/generic-adc-battery.h  |  3 ---
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 535972a332b32..e20894460d7fb 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -227,12 +227,10 @@ static void gab_work(struct work_struct *work)
 static irqreturn_t gab_charged(int irq, void *dev_id)
 {
 	struct gab *adc_bat = dev_id;
-	struct gab_platform_data *pdata = adc_bat->pdata;
-	int delay;
 
-	delay = pdata->jitter_delay ? pdata->jitter_delay : JITTER_DEFAULT;
 	schedule_delayed_work(&adc_bat->bat_work,
-			msecs_to_jiffies(delay));
+			      msecs_to_jiffies(JITTER_DEFAULT));
+
 	return IRQ_HANDLED;
 }
 
@@ -358,14 +356,11 @@ static int __maybe_unused gab_suspend(struct device *dev)
 static int __maybe_unused gab_resume(struct device *dev)
 {
 	struct gab *adc_bat = dev_get_drvdata(dev);
-	struct gab_platform_data *pdata = adc_bat->pdata;
-	int delay;
-
-	delay = pdata->jitter_delay ? pdata->jitter_delay : JITTER_DEFAULT;
 
 	/* Schedule timer to check current status */
 	schedule_delayed_work(&adc_bat->bat_work,
-			msecs_to_jiffies(delay));
+			      msecs_to_jiffies(JITTER_DEFAULT));
+
 	return 0;
 }
 
diff --git a/include/linux/power/generic-adc-battery.h b/include/linux/power/generic-adc-battery.h
index c68cbf34cd342..50eb4bf28286b 100644
--- a/include/linux/power/generic-adc-battery.h
+++ b/include/linux/power/generic-adc-battery.h
@@ -11,13 +11,10 @@
  * @battery_info:         recommended structure to specify static power supply
  *			   parameters
  * @cal_charge:           calculate charge level.
- * @jitter_delay:         delay required after the interrupt to check battery
- *			  status.Default set is 10ms.
  */
 struct gab_platform_data {
 	struct power_supply_info battery_info;
 	int	(*cal_charge)(long value);
-	int     jitter_delay;
 };
 
 #endif /* GENERIC_ADC_BATTERY_H */
-- 
2.53.0

