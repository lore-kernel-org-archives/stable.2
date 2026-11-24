Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540282;
	b=e0EBTh66J/y0eerfZ0bGPg+xtQsTKyI+Vi6kmotSftBBkndjy9yQNg2hacGjx9fYBlc8
	 fn1Sg0GaAgsCpPuq90vRKTVKUWKq6qX1TLPbY0vs6azsjYrfU8wJGrD9beyAvm/C57Ix+
	 T575gvNrMC3+/cnnOJL7VfHviHzruKBjbNx29qtndzL/XqSLhY7TbzA1VCWL8BxMGr076
	 7i9znMyzeSkWb2yGYHg1MLYHqpo89v05CTmolLA6sTakpuavAZOFDQWFgFi5/WSkYdrAw
	 ioFmLsD4cEGLGt9W7Yd2aNVhQ5L/rAIbUHsKp6+O6on/SWbTBIGDCTO82jv4IEz7cVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ihyCWaQSe8/33b641CrQpm2QKnFFCoRtHpVnDp2/vYU=;
	b=SsccoFmawnGsN+DKcWxH9PYaMBVY1Tfrkvtcf+0euOWtQpyqATnJuVDioHb8/anvwTGz
	 LA4j9bVQzPdbduMmxaXr/clHO9377bk5zSmFr6s3bLjrFLAHRly8uVHT9JwxDUSYkspU9
	 Us1dFuB4JCv3dhXCSuokgXJwrCx22IjlNp3Ty8XBIctoXZF9lzCDZpAU1G5FXw7ZAdhyd
	 1dQaGXrdMy49uZcEuCAkBMULOze90vsQtlynygwZA0qzwu2Nf0aypYZ/heg+1+Fydo4P5
	 gj+UQAWvPbzEvlfLLN5x/V31PmEd4ZsfH5JQ/rQrJK1hnCz/Hp5/KJqCVByMDVKFJcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBDdQ4yK;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DE606E171
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 705DE606E171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBDdQ4yK
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-844a8bf7e25so2573653a34.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795540281; x=1796145081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ihyCWaQSe8/33b641CrQpm2QKnFFCoRtHpVnDp2/vYU=;
        b=BBDdQ4yKiLrdEPoB2VIEm+j5xGV+HluV5UB68gIn4K71QRvfEsiffrRLn+oaI2uqHV
         ZDCLZkw3lCe35+bDvylrY02CWuEE/Xth0fSoD9yCWHUwh/TTr0I+liEAX2gF0OS3/LKh
         qdIA4VDFDC0AlcuvFXZ3Xht63Lz9hkLeAeN/mdKW8CjZa41TE4zJn91no7s2rQNU75MW
         7RB+be4tLJqNry9t8pDKmtVOAVYpjTim/DS16KBe3aBPg8R1kc8FI9vFuIrH177YLSDm
         hPMXLHP440qxmAYOWGdZ0iqDaP2jFkid/lPxVxNt8ZeYyjQ/y+fzP0ewFed3Q8mkhXnm
         kFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540281; x=1796145081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihyCWaQSe8/33b641CrQpm2QKnFFCoRtHpVnDp2/vYU=;
        b=PYYkh6l4JW9CtXbE1gmNzjhXgajNJDSi7emV5WGGaZ0cZPpm5133+0M8EIKsTuCvhY
         VhkWGp6Na+QVQIekyjef3EEY4mHkEVroj3+Xz5M1UsZTeDmc4fUMq0A4r9yf+zn9N4/u
         GHT23cRIMZvzKtm92lG0jVmoUQ4Sf4ousRsmSgqBg04y9Kn7uGOmiZKLTykVJdZNxwSI
         6Rbty5PIkSSWuns2kBcbKy/2s1K+SNbLdQ0k7nsKnjmh+Q3oyxGG8h7cmx8cVSS4EPUc
         F5kCZs5bW2OegFyu/BTC+O+lhm/9TsPhV3FQ6z8zFLx496AuHO/wOOnE+Du8sNF+JcYS
         1tUQ==
X-Forwarded-Encrypted: i=1; AL+hErF1p3gg5OD1sWHXX0OMQylcR+WZolvnXi+QKmLTpnq7UJ/HlEsQr2dc/eW4RawMoPhPkIBY+r0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wBO08ow1hJkmYCOZeCsjcZxgX1Uv0W0YVYJvtXm+Xi/d41iDV
	3LfiHmb5UKPjJXSpK3E6Ql63Co8H7Uk+pciAWxzHY61ZQMxwIgeRddep
X-Gm-Gg: AZFdTZdKPmBNfb/2rq4sCY5X37NCCqN+sIC9A7yEcMD024fKMOm97gHzJRHFFoeghbK
	rU2y8VShwHNF1GOrEvtYYoSBI4KxyjSKJBWjrvoiQS4s5ecn703MJna9KmXUn5f41nqhFLjjpcP
	1MnBhhBooGp/WLLw2UUvPSg50ZnAxAF+4B4x6KU5Zqkd88SjR1A70zz5gH+kkZu3LI6voWa9dgS
	O7S+oraHGR9fg/Mw/KeF34YOVNA1M6PdbHWs2L0/4JLHTbV/rEpqXuzxOiHELdltr0iK63JWn89
	Hhty6Rs/JGgbW1r618YTj3isi3+5i8PmdAXv8Q4qJ1SYcvTCJ5iYq/ggOaTkei5QIMf3HQ9jxcl
	jaNjjxISQoYd9JQ6SN0cubrk5pemL4XZims06/wx7uIRJ/ce4e7kIu5iJDARHhVgNTfFcP2oHWV
	u1AyKYR7AsRBP1XNDm08XfZpW+zzat2r5sJGUpSxditqsI9hCN6Hq69T2WYmh5CCuvFODYneCnC
	j2zFgt/ByKAmYT1RMGILIDp2H4G2Pl9h5vI6vzPXuk3UMyzsgbHUSDANwNFbiUVbHuac6RwNFQ5
	nt925R39d5Tyj/NOBzKfeZKoI5nPLA==
X-Received: by 2002:a05:6830:903:b0:862:a48e:24c8 with SMTP id 46e09a7af769-86315944a86mr23180037a34.14.1795540281281;
        Tue, 24 Nov 2026 09:11:21 -0800 (PST)
Received: from [127.0.1.1] ([150.117.174.129])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6besm11131021a34.11.2026.11.24.09.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:11:20 -0800 (PST)
From: Gary Wang <is0124@gmail.com>
Date: Wed, 25 Nov 2026 01:10:38 +0800
Subject: [PATCH v2 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
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
Message-Id: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-4-c8079f8f569f@gmail.com>
References: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
In-Reply-To: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
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

CC: stable@vger.kernel.org
Fixes: dca2f73cf19f ("pinctrl: Add pin controller driver for AAEON UP boards")

Signed-off-by: Gary Wang <is0124@gmail.com>
---
 drivers/pinctrl/pinctrl-upboard.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-upboard.c b/drivers/pinctrl/pinctrl-upboard.c
index b9af6dd93c34..090316349331 100644
--- a/drivers/pinctrl/pinctrl-upboard.c
+++ b/drivers/pinctrl/pinctrl-upboard.c
@@ -33,7 +33,7 @@
 #include "pinmux.h"
 
 enum upboard_pin_mode {
-	UPBOARD_PIN_MODE_FUNCTION,
+	UPBOARD_PIN_MODE_FUNCTION = 1,
 	UPBOARD_PIN_MODE_GPIO_IN,
 	UPBOARD_PIN_MODE_GPIO_OUT,
 	UPBOARD_PIN_MODE_DISABLED,
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

-- 
2.43.0

