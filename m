Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351476;
	b=Cn7KgFCoWXGbi+xtIfgeFScB8QnRoHfItX/odTpi++0iSUlsF7thVM/gIuWFOmvgPoCW
	 xnNOrTk+TB4W5sacIfk1ywmaa9p9BJdrbM/xmwEOrzOOZm0xcPBD0TER19mgmYgng+xCx
	 4Z0P66rqsxpyp2rlkbqOW1NeIciILazhJtTkNxO9sP+Jzt2MnqaGmeeIRv/EEqqedi5eO
	 X88Ij2s+djNCnnsa2slebnEtMV2jhUF5zS579+86302b4tHNMHSug91A+nB/Qu36Hj1NQ
	 ZhdUf/Vy8ZbjjqcX9T/oIYJJ9HbokVMse0fHzea8TQCSfXo0+ycA5wuRR55I91OzcYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QjEXXGi0cnyHSn0Vmlkr43DRMSa9IcIn46/K7rv9Kus=;
	b=YQoT7AUqxcHygO7IXNwTNcnirF4yZt8mCorGmzgKBdiN8xkPDlM7JvAzXUiKRsvHJNrk
	 99EemKLTRse2nVK678uPFQl3pymPGnHvFFE8aE2STIK6SovWeVK04Srdn6z3L3cgdOq6B
	 FEKAJZTjalzuu0xM3/a8XVRPnxjBHA1QRd9y/QMDkc9uZ8xEX3aWpVOLxCAVOD0MRtEzO
	 zbJyxgal3aMWoOQQ7uQzsN24RiB4IjvxqmAwrMTZrinWtJnn5rrg2+AmXRWO9G9Z63Odw
	 zHeK9lLzTuj6fE2lwIcwWdvHDeebDhA//Sj/8rZJIac30nYqLS3jH5U2eudgFUV1GoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYYaRsR8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C8606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYYaRsR8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E292B1F0093D;
	Tue, 10 Nov 2026 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351476;
	bh=QjEXXGi0cnyHSn0Vmlkr43DRMSa9IcIn46/K7rv9Kus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HYYaRsR8CrYechCMMb3O0FIl9oMehgbfcIRiY+Q+4PEYgrDxlkfG8T8577nduX7pM
	 bS1Zn2gLaYsxtqogG4E+D2TrrcynWbQXzGg7hsyr9yaodaJC893R16+OH/SqDpmb5t
	 BI5c74dOjy/qRZYfy8J6z0nF9yvjTsjSSTEH7zVRALsrzyJHXV56hBOnXyquD6Ux2O
	 /8ZFgYQZQA+1yl6PyDbeM+HAcb8T+cT3YxePuVKSW8NO30VvXFLXHH3QQD2pbOq1qn
	 lIZwXg/HzNMm8uOeEUz/Lu8iCWK810+Mv872HrComdAMjF7Pcim2ieoVV1r30abU4+
	 DYKPJvsVqhdKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/7] power: supply: generic-adc-battery: drop jitter delay support
Date: Tue, 10 Nov 2026 17:57:48 -0500
Message-ID: <20261110225738.4066560-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110225738.4066560-1-sashal@kernel.org>
References: <20261107055053-failed-6.1-8ae5a3f40045@kernel.org>
 <20261110225738.4066560-1-sashal@kernel.org>
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

