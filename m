Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447019;
	b=RYo5KqpR1GdNp9PTLGV/Tt0wM5JIkC3D5dDdrgh+Ib/v3Lrmc64K1CN7Lflvu7TnxY1d
	 9VFWNg6gYtn8rBdpMYxb5SG1KKjOkEYOVjndeW3gdpo6VDjt/0r92y4nEnsa1wUZNyO/N
	 3HR8/YvZ/AZbgKN/uHFaN0NHS3i0Ol/hPG1+qyKZUMYlHvlofMcWq+zNI+l/sCbY4rgwp
	 MF9OhM+nRlT9w62QPPbVWjbsJhC/YzXUmBbJEfCTB4jYyl2dZR0gQ0wFVgvyh8KFSajTd
	 AqFfl2mCe6lHeV4B5tPK3tcpPTVRijmGQxs1Zv3jLlaBTk8hYLw4VyzJOuG+mUV7cIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tSXne0eFSt3J93YlYm+5HBbf8tEO/NOSC0O1Mc/J9n0=;
	b=EpUOfUKCXpTtBz+2SDeQ7wvGtEsKCrHOXQOx812yyQwsdpeiIkYqSXN0SCSjPJjhQGw/
	 J4IT4gW60CvKeGIYHj/+JvVAUswQoxnQYaGArgBuz8/v8ofd0OPmxLK3nm0qkt57ov001
	 Md6FQWNVo0yWe6Gj6u3RODHNL1Fir4ykuEd1rw8i1XgmLggLypdtCxU9buCDDrOPGVXci
	 PGAsFwD1xxnCvR+5qDxR82qJ4du2gsISoogh9iT5CQK4O3aSx1rlCfuXRPKqZoSciWXYB
	 w4Z4BGV3zperBh1r96kPxVUyug0ziaw+9Bhy5wtGSuj0SWD1ZjNfeIHwhBT/1Upr6Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DxCvjj8Z;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56227606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56227606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DxCvjj8Z
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1626019a91.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795447018; x=1796051818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSXne0eFSt3J93YlYm+5HBbf8tEO/NOSC0O1Mc/J9n0=;
        b=DxCvjj8Zy05C/UG/Gosszmux+ROyuvE93znej2tokQMY1UAJ3+kguZ508V6luN55Al
         yaKj2zvKa9jlVvjarByCANCpUh+gqq/zwnvFfqFZJjSkarc0bpxjDlHdyqUGpN3gBGsw
         uL+YdSfiUNF+uezoBDZrgna9xHCbgiPCQ/ZUZ8zVIkzcc6b2UaZDK5EQ6pNU7fX0XVxY
         qcAJelmxa2k64GqMwlZy4+HXhAGlPi5xDFxfuh8WCZs0zSuNrTj23wIHrO56EiMlTbTf
         7ERxDdm0yVaIO20pN44TlXipI8IN3ixMfJZ/SCDUnAogeRt7bCFF84UnCuYFhs0xYvT3
         2MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447018; x=1796051818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSXne0eFSt3J93YlYm+5HBbf8tEO/NOSC0O1Mc/J9n0=;
        b=s5QXw5qMKf9RyOZ0fLIJhS0mIGV342h1ZrHN09gqy1oBRFPJKmVlVhzMmpWlVKk+ao
         +CBUNCsNUQ0Yi9COlwMDZgj7aG5YuF4bd4ls+iVk3h+zH4kRuHUDpuwLXx/BeuuOcgpw
         IS8gaV6FDvgMrrmz6FnMCJ4eBkEOz41mnsKc7k11z2sI4htOfh01yytcmCBKPLib7n38
         TEz1cqimG4B72NlWWddZTQSL1Qk+p+ZtauswqDdeYqzV4hzI8SIoCpiem3PLzMBgJnCg
         ON03ApUhVLWjHGNUDeFH0CDeswQQBpbaUkFtB9/bjt8WF4YEQRbzmZA5VSncDF1etdKu
         QGfA==
X-Forwarded-Encrypted: i=1; AL+hErEnsbI7pZ8DRC9/6Km5hJENIlMJ10rvhLHYCIH3FkFe09tKOS3D4YicntEsdlyYJbpPGr0kZeA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GnuZNLmErMKbHeAht4JHryCfW3Epxph2MW+YmQEggTkFExeT0
	AwJ/6IVvIUYpO1L1/XuZVGSWBejP7qhLOhnh4742ePfztNYGW1XNHbGh
X-Gm-Gg: AZFdTZdTy9cLSLvKwb0jRPu9gmuOphAB6nf91RYqiN24Oa1MoqmOTcV50OXAz6MBvNr
	NXkZeBtNdwsxWkQ/Ff+/6zhHQxzWRpjqQdz/SuNsxhbySyhN9Co08tVteioBs1HnpIPLWHRRnXo
	wtBODRfM5MwiKCr5Ugg2/f+EKiTiGe9KlaoNAP9xETb9veKiCNViDyceS+5aQQrgBaEtenyu/Xw
	okZbaJzYr+WmQwmLilb2p5I7cPSCa67mw3+5J4sw7l4la0SywlvWV8fu04D4DDvrFRcrvR1H6ul
	eczE9+m5sWCmx/CeIzV2XMPG52dfDcIqp242QyEVEhoUTtJgmcTeScC03SgfSKagnMmt/1C1ohU
	i+/+YQxQOgbgjWMMWbtnBG39FVhkgeuEg+MVoH7iQxBEAg+5Y3q89FNNgdMKqfn6huC/BjE9heY
	D+/f46FSa7nDEYxTD7gl1T4OkMK3GJu3LBPtq5mk7YZSy1/k9Nu7zrZX0ztV864LOq0slakBMsB
	N7PQz/ZHOcO++mpUnyBU5SZ/pgIqnJpEt72wqVdaR2b9DF8SMR8ZZ0r+pc//obm8HJz5Sm3QYRc
	BksYI/6MuslM1g8S0UOK3Jss45vjww==
X-Received: by 2002:a17:90b:2fd0:b0:3a4:e735:b39d with SMTP id 98e67ed59e1d1-3b41c982d97mr10577101a91.64.1795447017561;
        Mon, 23 Nov 2026 07:16:57 -0800 (PST)
Received: from [127.0.1.1] ([150.117.174.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm20067482a91.5.2026.11.23.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:57 -0800 (PST)
From: Gary Wang <is0124@gmail.com>
Date: Mon, 23 Nov 2026 23:16:17 +0800
Subject: [PATCH 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD GPIO
 OUT not function mode
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
Message-Id: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-4-f2322a91686d@gmail.com>
References: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-0-f2322a91686d@gmail.com>
In-Reply-To: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-0-f2322a91686d@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniele Cleri <danielecleri@aaeon.eu>, 
 JunYingLai <junyinglai@aaeon.com.tw>, Louis Chen <louischen@aaeon.com.tw>, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 BillyChou <BillyChou@aaeon.com.tw>, Gary Wang <is0124@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

The CPLD I2C pin mode setting following uart & spi used modes array
on device AANT0F04.

CC: stable@vger.kernel.org
Fixes: dca2f73cf19f ("pinctrl: Add pin controller driver for AAEON UP boards")
---
 drivers/pinctrl/pinctrl-upboard.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-upboard.c b/drivers/pinctrl/pinctrl-upboard.c
index b9af6dd93c34..66c1c3e3bfe0 100644
--- a/drivers/pinctrl/pinctrl-upboard.c
+++ b/drivers/pinctrl/pinctrl-upboard.c
@@ -225,11 +225,21 @@ static const unsigned int upboard_up_i2c0_pins[] = {
 	UPBOARD_UP_BIT_TO_PIN(I2C0_SDA),
 };
 
+static const enum upboard_pin_mode upboard_up_i2c0_modes[] = {
+	UPBOARD_PIN_MODE_FUNCTION,
+	UPBOARD_PIN_MODE_FUNCTION,
+};
+
 static const unsigned int upboard_up_i2c1_pins[] = {
 	UPBOARD_UP_BIT_TO_PIN(I2C1_SCL),
 	UPBOARD_UP_BIT_TO_PIN(I2C1_SDA),
 };
 
+static const enum upboard_pin_mode upboard_up_i2c1_modes[] = {
+	UPBOARD_PIN_MODE_FUNCTION,
+	UPBOARD_PIN_MODE_FUNCTION,
+};
+
 static const unsigned int upboard_up_spi2_pins[] = {
 	UPBOARD_UP_BIT_TO_PIN(SPI_MOSI),
 	UPBOARD_UP_BIT_TO_PIN(SPI_MISO),
@@ -289,8 +299,8 @@ static const unsigned int upboard_up_adc0_pins[] = {
 
 static const struct upboard_pingroup upboard_up_pin_groups[] = {
 	UPBOARD_PINGROUP("uart1_grp", upboard_up_uart1_pins, &upboard_up_uart1_modes[0]),
-	UPBOARD_PINGROUP("i2c0_grp", upboard_up_i2c0_pins, UPBOARD_PIN_MODE_GPIO_OUT),
-	UPBOARD_PINGROUP("i2c1_grp", upboard_up_i2c1_pins, UPBOARD_PIN_MODE_GPIO_OUT),
+	UPBOARD_PINGROUP("i2c0_grp", upboard_up_i2c0_pins, &upboard_up_i2c0_modes[0]),
+	UPBOARD_PINGROUP("i2c1_grp", upboard_up_i2c1_pins, &upboard_up_i2c1_modes[0]),
 	UPBOARD_PINGROUP("spi2_grp", upboard_up_spi2_pins, &upboard_up_spi2_modes[0]),
 	UPBOARD_PINGROUP("i2s0_grp", upboard_up_i2s0_pins, &upboard_up_i2s0_modes[0]),
 	UPBOARD_PINGROUP("pwm0_grp", upboard_up_pwm0_pins, UPBOARD_PIN_MODE_GPIO_OUT),

-- 
2.43.0

