Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351479;
	b=xWpJY26OGaVYAsi//LyU8+9ax33H10CGqYVzD7uMYaET6F2jNpeTBob74FXYBLegmq1n
	 1xpR3lybJTps4Cq23DHY2Sw/tdpiLzdkq6ao4elbqNL+/NZjhtL85uAsaI8iFq1/OZcvG
	 hlXUvpCv7W2BSI7up0/gKK6q73E+99r13z5jHzgMe/FEJxU8ZhN6919AMvsgYed1iOle+
	 fGiUYdLj3HMLb2iJBhjvTmzajOmzjM0GRp5E8X3RoAhV43oSIYJ+zzkxFIv5gH+HrESH+
	 XSxFmTJ08uR2w1ulBhA/29KxhHPRBHmR7+sPyEc0ErMoVqCTVL+mEDb44CremvgLNhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351479;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4+a+Og4o+mpujsGxP8r4JtlowraCe/4JpgWFYigp+fA=;
	b=oIydOvYZ1obs7uAAcKrz3HmMvLbanA/36kZr1nASANqDoQr+/nDItlWM679tAFb9oDO9
	 VHDhrQIJP4sWzV2vxegQ8g2mGJCRnWkwB9ZeFEWa6zPalbwxrWj1UeB4LW13Zpyet5Pzy
	 yvMpSFoPYbLMU6BM11kU0tQCRHyVNXJeIvzIQp9jwcLvDbWkomDkAwKoi0fxiI3VsegXt
	 e5c0NVi0jhHn21p4DJEiOyOWfMV/TxL1vIRzqTM2MtCV0TWer7sK0kqHkU/Kuou/91YEz
	 dEmJ/bggDlc3g5N8vGKJhoWTmoq4FeMh7Yt5A3QwdMuk/xFwu4GfdXQFwJT6idcjuzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQzqkRZS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DD606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQzqkRZS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B67A1F0093E;
	Tue, 10 Nov 2026 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351479;
	bh=4+a+Og4o+mpujsGxP8r4JtlowraCe/4JpgWFYigp+fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gQzqkRZSjknYumxvODA+Qb2Qa6MM3lh9sJXJSKhTAff+31SSLhJHdSJ7e/k20YH2Y
	 CHfWRKg6P6LRJZVytGLZ59tusbSTo50XM4P9DlMGUMKcJ0xg0JhXdn+kAjqea7EIB0
	 RK2VdNwnhSbpOMQFF/ptf26nreG2JSiDOxP7hl14UbEiZTcY0eEIi2euCjdIpE5s3J
	 xk78WJENJRb1RFrfBsdxBgv2HzqvC7tA2fuHCRjRWonvrgYavj81AyaZectUhWjvUb
	 KKiw8Fi8fNUu1G4eose7hPKhY/FLMcSIEI3mDc7KN53nZMQ6rRBwbrKY2NyYxjx57J
	 LeW1LWLIaazmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/7] power: supply: generic-adc-battery: simplify read_channel logic
Date: Tue, 10 Nov 2026 17:57:51 -0500
Message-ID: <20261110225738.4066560-5-sashal@kernel.org>
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

