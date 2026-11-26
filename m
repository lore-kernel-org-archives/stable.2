Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705829;
	b=wHmlBVdhHmiZl+8U18h2tKpshmFyaveTQjN8FlI/6mxrcqlBoUEsDYDjM0pu3LgUcpzg
	 RsOSsYLjrdWq8gqyW6qM3Up9MIRhRss/0ZcXZiR/o7YybzX/yfIvV6qp59iwK8qkBRT76
	 JMo4vC1cOt5BpjInD14PD/cBfn3G+WQPH9T227jF1FV2JOExAn6u7TM0VaZax7HTF6ZrL
	 0VyRp39lJfC727gA+7wMtKbF+zThMIyYcQUj/y7+MvtgsO6x3WlE/QFi/cpZHxOA4JfSv
	 1SVMdEi7J2Bc4fvDQK8lTu69HzUZ3mnmrmpQ940uQqYv4dkL6cJu2knn6wxKmIZLDUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wmDIQo20uS6O1DnD+oq0Q5d1d/SJjeCFVriKtYROA4w=;
	b=ILZTy9InnhcwzKYaWXHo/frYkItZZ12EszUi7Tl3JMy3ESSCWp0M1jDcrZ8tioDr5bIW
	 KE8DonL1KFNtZ/1dT9CPEMotnaVKPsWUD0sxjQJ/f3MBXAOZ//rSA+L9/Wj73j6WoZnnM
	 2FR5SOwTXiFE2iNu4ZHX9pl5+aNlgc3b+BkyAoygoq9uZP+4VxJjQS6lgI7mgdJOg9tes
	 t0OQjRaI4fUoc9t8RmLQAKfgA8b2Q90yjUqnsYgMYNYQd2E0fQkx7/q9MdLb6v10kk9Az
	 Ch1bMieLCefywxanhAV922eFHMkQ6ymsVKTNbrMlntEzzTEuOAtnhXzrot1e2N5lvfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cs3ohIph;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB9606A691
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FCB9606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cs3ohIph
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso4091127a12.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795705829; x=1796310629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wmDIQo20uS6O1DnD+oq0Q5d1d/SJjeCFVriKtYROA4w=;
        b=Cs3ohIpheW2gSgLfy8Ct/Dp2Iugp1WNSOWui5en8x876oqTEtMEI4kUyJG6jIFRtOc
         Esf9cgmDLFmLq1Fa5fk2bH4qmfD0EarnJpza20JXNq2NCJvK+/1NMpx2DduvcjrKfZYY
         WEfR5dAkc4kyXsgBepPDcTqyZQdNGEM4Ex+zTW+1LOUlVXHXLWv6fEcitG2qAvnYKwSc
         +PzAVKdoYTDBggYkeCvz8hxxSfogBBJ0vmxdrWBMtfrtZ+Qhm8eX2YZUzNrtrV/DITci
         AQdoY7bSht5cs0tfknR79PKLbc+G1z2pkHskQdG5iV2gA2arIzYzcSjm3Irn6rgJ2DAu
         IwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705829; x=1796310629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmDIQo20uS6O1DnD+oq0Q5d1d/SJjeCFVriKtYROA4w=;
        b=rbDSPPiO9l1YWsVEbLjaUwptK54L6ATLoXY7FhyaFoVPkw3F7dx8LKl3cOsHl6MJXT
         K4hOyIMvLGyxHaPMBdFg0+GHPbTuEAeui7W1e0WgYQcWAdm++gMDZu0wnUp9sFE+Z1og
         MTaEL1j78lQACxHzUcGBNNRUXzt4zQ7OyNNwDeHOold6e2xvsPig8Qjqy3hprIfqdc/i
         mR4FxtJEdecXP80E7GNZ07jeN0CQrw9Hz4kdSjeGW8MLufQb8PYvnnjDHmtPmDikuoT1
         I7jTI7LB4YjX3gY0DfGSL+DHDYCgnkcnu5dmRa8ThCpyqVkO/UxzwWhomFkfnGZUFhXY
         khjw==
X-Forwarded-Encrypted: i=1; AL+hErED7COAl+KtCcXG9lxwG4Az5AEMhAYpycpv823LS6v1n1bcJfrhSB29ax5L4cDn/OHR3ZIE9bY=@vger.kernel.org
X-Gm-Message-State: APuU4Z80j6TNNtClJK8IyAj2VmG1DMhLAjpd7cgHqEpZQpWUSUycvA7a
	XPZ8nRG24MdJsXiwGN1hdOCbbXQGmnNf3hkscHIkH+kTL1Xks9iVl2Z6qtP1K3CB
X-Gm-Gg: AZFdTZdzqxebwPcjcUOKO9KYIhV/+wJtKQz8X3qTJ92hr3i+GtNNogfjFl+a0FG4Ery
	Q/0ziWPIfOZXljHgE627EO9NEMNL6cBwWcfjW6cuQ/q6pyiuWseKbB9Y3pVXrUWsP0NDF0D/77w
	22UVPfnyY7E3Wo23No6SwYwCrujzG3lhiw4yPmbYri/p/wQTwrEdKSRc3Px2LyBoBWOngFHY7Ca
	/wwxMOnNFDZ5pBwSpfVGO5f3FAjgoO5eVbf+YW6RvWacNyFaR/g1WpVnLvYqJ6Ev1rn/jhIsdNZ
	YvnS7DPybm1gyJg88HZTpNK7qlGSqOe0LVUiqQu+5+a6w4KHFT9JopgEzKr+E4Cgs99kFwbN7R4
	hgcw/nUn1QxBFuXlmsHdLkNejCl0AsIpm6BKzHXLg0GN1xy/WYNIUfTJZQ9WMW/Tuej/9tokPKZ
	rZ823GIVhS5YCEkrmzDetPrJFhpf2aabjSwf/+K8lMO5gvoeiR1AG1wxJEF9pClUqvvPDh6Ju3Y
	tR8bUdcQSu95Rk8aT5NfnX6kIP8RhnTptlohU6209k5A58eKC4qD0xVOdOuYDwGUjxwRQnMU2k3
	SWSLBF6FYqkkTBifIct6FRWSAQGs
X-Received: by 2002:a17:90a:d2cf:b0:3b4:d22:8600 with SMTP id 98e67ed59e1d1-3b41c8fe1e2mr18824415a91.18.1795705828955;
        Thu, 26 Nov 2026 07:10:28 -0800 (PST)
Received: from [127.0.1.1] ([150.117.174.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm11099923a12.8.2026.11.26.07.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:10:28 -0800 (PST)
From: Gary Wang <is0124@gmail.com>
Date: Thu, 26 Nov 2026 23:09:47 +0800
Subject: [PATCH v3 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
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
Message-Id: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-4-81d35c9ba246@gmail.com>
References: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
In-Reply-To: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
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

Set UPBOARD_PIN_MODE_FUNCTION to 1 to prevent a NULL pointer
dereference error on .modes[i] for any pin group using this setting.

Cc: stable@vger.kernel.org
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

