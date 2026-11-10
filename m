Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352235;
	b=d+2RIOmUQhG3shJuQG8SYkZmBSvL4CSj6jvDCV2Ic6zB+95+ZZ17TqUZmWAeQbJCM3Gs
	 AG05b5Jg6MRpx5sMiGr7yYNfmDeVD0/+xWdNHVLntgPQX8dSMkc1Av4ZtVpV3BFQOngsb
	 K13tjeUcC0iouxUWs8iA5oWVtDESpZaZfaDUU7Iis38xZnAyHFBdFH6YePd28PPeFO5d6
	 KwJJ+/fcyJOe5CEWNPzGBMXJRVVOXpwnFIZiQaztDWXwd3I1CFktzumL7eWE1w5pii33S
	 Nm+xdLOpOE08fJaTdsiqLwNGmaP151q0WwhGIEv5Bps7H8izg2Oyrfcx9lCGTCbOLUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352235;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4+a+Og4o+mpujsGxP8r4JtlowraCe/4JpgWFYigp+fA=;
	b=07zrT+PgX8SwJ30lRv2y5OrSXpT5Fe5q5xYK2ut4wf5hkWhiC8bmrvo02UN5Jfda4we0
	 Nvt7O8fSzMPRtUI/8z8xeSOIZRhJR8DkDV2rb3+jHk71f1EtyEKMEpLYBho1ub/gOogmG
	 WA2+q49p7EuvXjUd/jdfzNlLszUHdKAfzxkZnvpYkLVfxlxh+vGvWt8WMzWt1Z+KLHF3B
	 gQlFpdOuU1zC8lJlC5aEhvpKKxZ8+U7KH94qYZcdpO94TOcWB1dTrkzqgj9vPQInqrPDa
	 BdLqyLPOVON+gpERAbJ2yWqNc882wj+dcntG2vCruFUuZguFDH8pm/qfN77k7gIWlqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaEjJ2kr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaEjJ2kr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D291F0093E;
	Tue, 10 Nov 2026 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352234;
	bh=4+a+Og4o+mpujsGxP8r4JtlowraCe/4JpgWFYigp+fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AaEjJ2krNXYUZQ1G7PbwAac7pyjq74BYRuspjAAjKyWSks3k9Siy3Aq/oRl9G0HkQ
	 EgI41EY6KNF3gfh/ry+UXMcMXg88py6Gz5ob9nWnL0v5FTEtWcMTzRW1sYuG9lz80e
	 R6U6R9junVpY00xyUyRBP6ND9pnkxIM+lXmiJZsaBsgaWv5B1JNkgOdQZbOchcigCU
	 15dRv5YPgJ9yA2V9C1zrDo/SkL2jI5DfSmWOKc5eYKzlTRl+VdVYv9xZ5eRQBx5t7n
	 iB7QvoCkRyEo2m8LyyTto6zUrgH4OOtR77LRujs1/U+m8/w39LbKCImk6UxgmafZbe
	 ZSLXq/HVK9YyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/7] power: supply: generic-adc-battery: simplify read_channel logic
Date: Tue, 10 Nov 2026 18:10:28 -0500
Message-ID: <20261110231006.55369-5-sashal@kernel.org>
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

[ Upstream commit 9489d1bdb763a3dd954e61522043190a9fd1cb4c ]

Drop mostly useless gab_prop_to_chan() function by directly
supplying the correct enum value to read_channel().

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Stable-dep-of: 8ae5a3f40045 ("power: supply: generic-adc-battery: fix status with no supplier")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 35 ++++------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index d89247d647f8a..be22fe9ae90bf 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -86,31 +86,12 @@ static bool gab_charge_finished(struct gab *adc_bat)
 	return gpiod_get_value(adc_bat->charge_finished);
 }
 
-static enum gab_chan_type gab_prop_to_chan(enum power_supply_property psp)
-{
-	switch (psp) {
-	case POWER_SUPPLY_PROP_POWER_NOW:
-		return GAB_POWER;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		return GAB_VOLTAGE;
-	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		return GAB_CURRENT;
-	default:
-		WARN_ON(1);
-		break;
-	}
-	return GAB_POWER;
-}
-
-static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
+static int read_channel(struct gab *adc_bat, enum gab_chan_type channel,
 		int *result)
 {
 	int ret;
-	int chan_index;
 
-	chan_index = gab_prop_to_chan(psp);
-	ret = iio_read_channel_processed(adc_bat->channel[chan_index],
-			result);
+	ret = iio_read_channel_processed(adc_bat->channel[channel], result);
 	if (ret < 0)
 		pr_err("read channel error\n");
 	else
@@ -123,26 +104,20 @@ static int gab_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
 	struct gab *adc_bat = to_generic_bat(psy);
-	int result = 0;
-	int ret = 0;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = adc_bat->status;
 		return 0;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return read_channel(adc_bat, GAB_VOLTAGE, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return read_channel(adc_bat, GAB_CURRENT, &val->intval);
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		ret = read_channel(adc_bat, psp, &result);
-		if (ret < 0)
-			goto err;
-		val->intval = result;
-		break;
+		return read_channel(adc_bat, GAB_POWER, &val->intval);
 	default:
 		return -EINVAL;
 	}
-err:
-	return ret;
 }
 
 static void gab_work(struct work_struct *work)
-- 
2.53.0

