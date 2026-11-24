Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540251;
	b=S419XW3vE4Jriptl5t48lRNpqmio9JFpCTlFYq0UQTmin92RBlrB9JgAcAXrYLRXfOaP
	 xaih8PpLprHfYNNx4axPx6OwS58pVOy+r6W4ReUqPX8dCV31J3/GF/6Xnr+mxi2VDKzCq
	 bTx5QFXKgyKWRAQU+RPXnUZ8ex5A2tARtn8o0mKlBaOQUCDlukmg56gNi5BfV+GPdW3Eq
	 Ehp3BO8kbQ+/W0r+rHTBUgLhrVtG0qtK+Ol93FoS+/vU3OB2OuoUyyYfHLss9mQjB05WD
	 ms5kJmjDXbFyADX98sSiEWCKs1J90+H93OnNw7/mzY7Lrq2EdivwI+nrusUzyDRkxTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=u8kv2zYNDRxVVHOiDhvZgUHGX0zKQbtOrLo9540hpuo=;
	b=pedGYy0vlvCYXvpuIwcUKl7Gl4oGzBvg/I+4zHHzie66P/oJyRrM2xJtf9hw6ysF7lT0
	 WPWDpBgLRrt6One0+8MbcQTd82Jwpv3ObvzdiFP7LTFRc5xIOL6ikx6nYWkAITDVsgbia
	 xUFWbC0Gdd5r91Oh1bKI3py8AMqeOIx0AAkGQsvpJJTjcIq1ro5Coj9HF4mXBIzLmbnT+
	 WdV2Ral4gr1IPO5q6FzqwhmJSsOJeqMCri/Q5h8p0aghBncuzWV4iM1sXQiF9TPr16q1o
	 53D+vev5lUy0kKGHAHcabpQUS4P63MwZhxgI0Vm4bXk9l5OH4Qwh9aFLajuVSpDE4ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ESCI8Weh;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99A606A335
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC99A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ESCI8Weh
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-833e671ee9fso4413135a34.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795540249; x=1796145049; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u8kv2zYNDRxVVHOiDhvZgUHGX0zKQbtOrLo9540hpuo=;
        b=ESCI8Wehg58uJN9SHkEiE+nEdgJUZDkWTjGDxOa+lqjLHEH89QsNf9J6d5OM+7eVdF
         IHuj9QNzXnI9dRKVMjaHDnDUID7et+aws4Nhglh33DnRaW+UIHzVLqiKWGh8H7MBz7GP
         +z8+4O8/xRbljkGGIe3JWjKOGes8xdiX3gqIeva2m+PnbI6QhQg2FvtmBcQdkuOAJy/f
         QLDXB8NaaS1Bd9HukZy8yWzx4YnWjiwzNuIdR2BpfwdKZYHREEM19K5fxzIc+Y9TXINb
         xK2/o78SgOxzGjcPoCKnlzM9vvpt2ZQK6inEam5eSUIaMQhZddsQL35LukCAcpXwz7xe
         8nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540249; x=1796145049;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u8kv2zYNDRxVVHOiDhvZgUHGX0zKQbtOrLo9540hpuo=;
        b=cG03ppXq+RFkoPuSF+2mgV2j0K5LyObi8N7erZNpFNv4S0sLm8TadAzcsPsxBfnXpb
         2py7iY3t9R3TNdD+3yULEJDUcyLcJPZRJTzI0T7rQSDnuWYJZcEsmN82GFnc7fr4GqSt
         a+ZFKzNL8JIiBiTrxjUDJ8ubzY7+N93CuS7TbSr0LOElxqpgaNaEkqFDVqHBEgIOqfnN
         UcSBgzJ4nTTZ1UDONlPuX3UNSBFtiezsu3q7CYneeV0ARc+M7/7o5sQpD7FFVrfRVUmK
         YFulO4AYWimEowNkp3ndxeq3x+fVWcd1XF3RSPmyl9kwrbV9pKV9vzP7NpK8FfHSDa7Z
         m+4g==
X-Forwarded-Encrypted: i=1; AL+hErGAIOK9XL2eTYksahqzBCMQrLjKp/JDTElkyKHqKGKrZdR6bV4krnlYdQx0OwPzYKjR6dqY310=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jZgYwSm4N98r+TySehv2drBwJsDL1v8x9gs7UZEvP32VVaUR0
	42g+5ZZZDou8m1DRMqg1U+Bfxwr7hjFHUMQ0knsin/yFDagmUryUSd0h
X-Gm-Gg: AZFdTZcj9rrgnW3ytVkMxW7RHOSkzChwjsffyUofjxON1Y7WV7fxuTWZZFplPkwtV+7
	AZFiQXPf0uZMx53SFFR6eZOAeWQQmkuw6pyQWxtscXFRsSsBHawLqq1OE1b4pGXMjYJpeRlTBx6
	MHTE+mphB6oXxU1DF+o9ZZeaJLemkUt9iEcztwg0IZf8JFgD9hXpMoa25n4gvUsXH/HJKLpL8/F
	LHKUBvO6isJDH7hrF+KqSw903hcZOwEjmYvgeqrBR1T+eZCZIB6gnhvamAxNL5t5a7UVczfDSEk
	r7CMdrCWe7zD9mKWGyq7GNsKK0ZxM//+2MFg2gfOocJeokdrD+DyKMwwpPuYlgu2e8b32807XQH
	+ASLCyspGgHxDCoxd8Jj61+TCPG04joioxShZjOT+6oojS0xUOThXhqOt3/HWtO+GmitlWv2IfN
	6L2zD+HfYgr9aWlM87ftdewyfWvgeZ4GANgeKIVqpMBhGIvNCCYPEwkJGGPK43W1TmKqi27h4cp
	oQhUTiKmBtkDUimRp01l9s1yJ89qLQIuXqaqoeI2WaHhshjiqJqLvEa8PKXIqY4C8pd7da1Bafy
	Q0p3hrbf9/61+Pw=
X-Received: by 2002:a05:6830:6411:b0:81f:8a6d:7b52 with SMTP id 46e09a7af769-8631593a1cdmr16409262a34.24.1795540249576;
        Tue, 24 Nov 2026 09:10:49 -0800 (PST)
Received: from [127.0.1.1] ([150.117.174.129])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6besm11131021a34.11.2026.11.24.09.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:10:49 -0800 (PST)
From: Gary Wang <is0124@gmail.com>
Subject: [PATCH v2 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
Date: Wed, 25 Nov 2026 01:10:34 +0800
Message-Id: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAArFBWsC/5XNQQ6DIBCF4as0rDuNoKLtqvdoXCCMOokKATRtj
 HcvNfEA3c0/i/dtLKAnDOxx2ZjHlQLZOYW4Xpge1NwjkEnNRCYk56KAxbVWeQOOZh39CMoYoDl
 qnpXVeSCExTnrI2BdtUWGPJdlwdKm89jR+/BeTeqBQrT+c/Ar/31PKf9TWjkI6EQuhLpzWUvz7
 CdF403biTX7vn8BM5i6TuoAAAA=
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

Add missing groups and functions in Tigerlake & Alderlake & Meteorlake
for INTC1055 & INTC1057 & INTC105E.
Add support "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
"UP Squared i12","UP 7000".
Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
on the AANT0F04.

The pinctrl-upboard is provide additional driving power & pin mux function
through native SOC pins->FPGA/CPLD->hat pins for flexable board level
applications. it's probe from ACPI device id AANT0F01 & AANT0F04.

To: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andy@kernel.org>
To: Linus Walleij <linusw@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniele Cleri <danielecleri@aaeon.eu>
Cc: JunYingLai <junyinglai@aaeon.com.tw>
Cc: Louis Chen <louischen@aaeon.com.tw>
Cc: BillyChou <BillyChou@aaeon.com.tw>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Gary Wang <is0124@gmail.com>

Changes in v2:
- Add missing SoB.
- Fix CPLD I2C pinmux-select by good method and update commit message.
- Link to v1: https://lore.kernel.org/r/20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-2-f2322a91686d@gmail.com

---
Gary Wang (5):
      pinctrl: tigerlake: add ish_uart groups and functions for INTC1055
      pinctrl: alderlake: add some groups and functions for INTC1057
      pinctrl: meteorlake: add some groups and functions for INTC105E
      pinctrl: upboard: fix I2C pinmux-select set CPLD GPIO OUT not function mode
      pinctrl: upboard: add device id INTC1055 & INTC1057 & INTC105E based UP boards support

 drivers/pinctrl/intel/pinctrl-alderlake.c  |  40 +++++++++++
 drivers/pinctrl/intel/pinctrl-meteorlake.c |  32 +++++++++
 drivers/pinctrl/intel/pinctrl-tigerlake.c  |   4 ++
 drivers/pinctrl/pinctrl-upboard.c          | 108 ++++++++++++++++++++++++++---
 4 files changed, 176 insertions(+), 8 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261124-upboard-pinctrl-add-intc1057-intc105e-support-e87b40e13654

Best regards,
-- 
Gary Wang <is0124@gmail.com>

