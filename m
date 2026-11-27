Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810197;
	b=Vpoquk6dZ/xSw6P89oZGnoSVtEZ2LFfMqK/5BcRrv7jwSpmD08sUq+0zyeoHjlyEuPp+
	 JbZfa5HMTCfZwPoH+ur5ZDY7KQEPfEUp1RHIty2r22ZoaPz9hzPQPXL/bkyZGBCJnFiFA
	 /bHdGDQonBrskOtCtB5vOY1sP17E56BvjJhA2Yl8fj1kiUl0cN9pbM30ylg2ZVkNlQgDo
	 WdSW5ZBU5ADYIvhH3/M3moviGqE56aMtpLW79geY8yicDdjhXeJLzjouECWQ5wjPuaqdA
	 OtRAu7x0bc+dYDgOMpx8MTvHw7a6EbLgESmKP1rxbvvjN0JuoaV13Z1ybSalXdoFLLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=JIsYAG/w26E6FxvUJAJzo1Ty0QYQDvImmexX9oITg8g=;
	b=s9+UyipLBx+N6Lpz0DKb2Haon5sHvS6Oyk9wLv+zsotQ/Xy4Dz1vOnYjp9gHftAXbpPP
	 zO65oQFME+a04/SmK6ucKZt5ri8/Nim6txhUsBCAxETVrQ8K7vk8D+vYDUacdSCpXX7B8
	 bGMAioWU6T3xfluBYO68gqsOQKRu4QembcoaphOrDmv9kKVm1dyW9518EcVIhOC269Gru
	 Wq47Qjw/z0oEG00lPymtLswPdLTkChrusxyFsQ5/tq+Bjtds4qxu7xcjFtXmgwIWsODEQ
	 OwkbmNDpwSQIskN7rO+r4rOZUfBwxMQN0ECYeF+IPrA7SGQT+VVHEcBYovU8ImPYuqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QU81oq6f;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730ED606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 730ED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QU81oq6f
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6d68de53053so6228924eaf.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795810195; x=1796414995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIsYAG/w26E6FxvUJAJzo1Ty0QYQDvImmexX9oITg8g=;
        b=QU81oq6fTlpFdk3vUjuTftMB0IYJFT5KFeOmyR+gqnr7I+8ZRuMtV8mAft0y+pqHb+
         x9vUCYwZqszqFmfc6/QW/3xExMCe4qZtn3kU6B+bLzNvREYf+F+vHJrB0y4kEf3MHYA9
         OHSO6qkLLm7BS2vG3/eVJoBTKVgNMSNObZGQ6lNiUs4wVwRiBTksIDSzODEhEBKRUlgN
         mAtX03HCjDZFUeIIr22sE5p9CbD+t/EmouZ9qf9iBPrBWXGaAkAYY9nj+nrQx1NP0KE2
         WHzpHvxYspLKPIZFg5biPJxHaoMzOrW8uZBtjH6Qr+xxM5eXyy1DTeza4+M215KD+C4D
         iyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795810195; x=1796414995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JIsYAG/w26E6FxvUJAJzo1Ty0QYQDvImmexX9oITg8g=;
        b=rUZZP4VTKjaxQwWFCHs8SQmlM3ZRy9LjOrqU23RtdH3e/ljBgQCggJHbqvGsOn5EEO
         qLxpJGVLZLNoA+mMWHGEf4Wc7cEaabBVnTqlZ92du2KXWVpsPSCLXMKAMAD5hNq1oZYr
         BTq2yOIjfQBBFoQEOv7ryqsxj5UJfAu5BsQfa3wdz9FTr2OZcFTQ5OlKU93pizhWRiv6
         i/MR1925zgtER4MKjuUuw6zmy7/f2WaL4oEKZ/Y9PaTqug1Ct4DkTGMWpW9uUvtO8xtp
         kqGfLA3XjT4Xr7lyctlMJk0qfZFtqc+v34/spS0bC5ox49N21nufFuzge0sttBaYFN8b
         i6bA==
X-Forwarded-Encrypted: i=1; AL+hErEZ7vZCC0+h/GKmxM6ZSoI05LbLzM8QijrMbtJ3Dy/ndFQPaknVUNrlQc5FpL1llzncqctEQLo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HXOkg7TdEX4jydBzfw25S5DEeiWYtEF1uTFmxslAKH+lW55Hh
	UhayLL6sKg8EzX1gKVRnD57Ps1TdoMT10U8L/DXQeFV+9+gvin2u8IwT
X-Gm-Gg: AZFdTZfu2mStmACK/+QtQyITWsfr+tAvBqbH57S/9kih5pkbZsZ9yl7VS2YRVQypQu1
	0C7vGBwOgRAE97gsg/ZYGiFJDp+Mh4fG3QiaXbexz6tDzOW4W5oACgGxjCxtp0NFp3L47urSPkE
	bcxJdLFhy626E1njZUKUPZquuLpdri/cB3/NQUbxB2gq13uEGbvptJspjSh0yrXGH+JcUdlOEd6
	9fsvNzD/ZfcNFfhBAp3jvvFBpcyF/uIgD+NhhEur19R+PgP6ICV1Qray038+ySIyBItO+DNOk4j
	ELDHdB7ByKADgI2CHsrOdRWD65W64Qrqw96+doSxLsgmYTJfAOPQ25ErQaC9V3uV5TBBUPrf3ME
	Kzg10B5lThCh+outbqd2M+md176bsidntw92bexFJ2Zhz55Q7K7ZMaZlC7YYPxbmGilJRxS8m50
	QINHZZXWohjq2HgsTyj4bKM0+AnQyZmUFU/o9a1eHWZENEoLhSbp8XRdDLYoUqyAdfhdqjDimp6
	GzK180FLJ0kD4bFPhAObeEazGd1N0/ih3dAYRMcM6qoP97c1g0o9uXmbPArZ7QOZ3W3a5iMgNBE
	P9D8rAZVpCFaO94x13yni4zVzEhusA==
X-Received: by 2002:a05:6820:c30f:b0:71a:ecfc:442c with SMTP id 006d021491bc7-71b3955e035mr16217300eaf.71.1795810195459;
        Fri, 27 Nov 2026 12:09:55 -0800 (PST)
Received: from [127.0.1.1] ([150.117.174.129])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b8590ba0fsm4834662eaf.2.2026.11.27.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:09:54 -0800 (PST)
From: Gary Wang <is0124@gmail.com>
Date: Sat, 28 Nov 2026 04:08:33 +0800
Subject: [PATCH v4 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
 GPIO OUT not function mode
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261128-upboard-pinctrl-add-intc1057-intc105e-support-v4-4-029071f417d5@gmail.com>
References: <20261128-upboard-pinctrl-add-intc1057-intc105e-support-v4-0-029071f417d5@gmail.com>
In-Reply-To: <20261128-upboard-pinctrl-add-intc1057-intc105e-support-v4-0-029071f417d5@gmail.com>
To: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniele Cleri <danielecleri@aaeon.eu>, 
 JunYingLai <junyinglai@aaeon.com.tw>, Louis Chen <louischen@aaeon.com.tw>, 
 BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gary Wang <is0124@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

The CPLD I2C pin mode setting through pinmux-select is not correct.
Should be set UPBOARD_PIN_MODE_FUNCTION on AANT0F04 devices.

Change UPBOARD_PIN_MODE_GPIO_OUT to UPBOARD_PIN_MODE_FUNCTION for both
i2c0_grp and i2c1_grp. Additionally, replace the check variable `mode`
with `modes` to prevent the value of `mode` from being 0.

Cc: stable@vger.kernel.org
Fixes: dca2f73cf19f ("pinctrl: Add pin controller driver for AAEON UP boards")
Signed-off-by: Gary Wang <is0124@gmail.com>
---
 drivers/pinctrl/pinctrl-upboard.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-upboard.c b/drivers/pinctrl/pinctrl-upboard.c
index b9af6dd93c34..bcd2dae9969f 100644
--- a/drivers/pinctrl/pinctrl-upboard.c
+++ b/drivers/pinctrl/pinctrl-upboard.c
@@ -289,8 +289,8 @@ static const unsigned int upboard_up_adc0_pins[] = {
 
 static const struct upboard_pingroup upboard_up_pin_groups[] = {
 	UPBOARD_PINGROUP("uart1_grp", upboard_up_uart1_pins, &upboard_up_uart1_modes[0]),
-	UPBOARD_PINGROUP("i2c0_grp", upboard_up_i2c0_pins, UPBOARD_PIN_MODE_GPIO_OUT),
-	UPBOARD_PINGROUP("i2c1_grp", upboard_up_i2c1_pins, UPBOARD_PIN_MODE_GPIO_OUT),
+	UPBOARD_PINGROUP("i2c0_grp", upboard_up_i2c0_pins, UPBOARD_PIN_MODE_FUNCTION),
+	UPBOARD_PINGROUP("i2c1_grp", upboard_up_i2c1_pins, UPBOARD_PIN_MODE_FUNCTION),
 	UPBOARD_PINGROUP("spi2_grp", upboard_up_spi2_pins, &upboard_up_spi2_modes[0]),
 	UPBOARD_PINGROUP("i2s0_grp", upboard_up_i2s0_pins, &upboard_up_i2s0_modes[0]),
 	UPBOARD_PINGROUP("pwm0_grp", upboard_up_pwm0_pins, UPBOARD_PIN_MODE_GPIO_OUT),
@@ -710,7 +710,8 @@ static int upboard_pinctrl_set_mux(struct pinctrl_dev *pctldev, unsigned int fun
 		return -EINVAL;
 
 	for (i = 0; i < grp->grp.npins; i++) {
-		mode = upgroups[group_selector].mode ?: upgroups[group_selector].modes[i];
+		mode = upgroups[group_selector].modes ? upgroups[group_selector].modes[i] :
+		upgroups[group_selector].mode;
 		if (mode == UPBOARD_PIN_MODE_FUNCTION) {
 			ret = upboard_pinctrl_set_function(pctldev, grp->grp.pins[i]);
 			if (ret)

-- 
2.43.0

