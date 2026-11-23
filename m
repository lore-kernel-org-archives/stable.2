Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446995;
	b=lfSHVPwlkR7B1/rmS0957sErVZQZWyT9nTOgxLP+ES9pKS1nIzHF79kr/8lXXyY2yg/p
	 mBPPigd2uX5wTiaFfzkkp8xUOH3pvFoyU4jE4ZFryG+Dv8IsMjL0BsLLERNXUz8VkKNZv
	 EyKtX+pPqZR86aN6R5+ej0Q4+ChTdSWY9ptHU55tq45reJKbt5JjvjtFK969PieIowwM3
	 +BppuXt7ihtOmnMkG6NBhIauEST/iuVgnKHqy2hyrkTnuxUkqpO4cIrg59tdWnULazyS5
	 8sp5/UgqgYax71yXs0H9Jy+YhfSKopG6a5sD4mPojtlRipe2b45VmXGU+Lx3xbLddLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=UfQmc2c/VBqjJpzYZJV/mvR5pLjgufyNtaYeJb3a0XA=;
	b=AnTvwpLhEJ7LpzzOuOvAaULNO5NzBnBKwbaSN9Qpn88bX04aA81yLrFEHVuVP+YRwmsE
	 PjHU/36J7QFjle74qpHzmpubvXLnkRe5uiZMXnYhzOGghLupnEI/mL9bQXLgnqII8uxIY
	 i8Vt5J29ZggAZ5617OwJ4BMymcCZny2WD7cMfd3ZG8Q74KkuYS6jx4/kJ4uNIKVxj4D/+
	 2aw2SkYld+6knilIzpBjrqiqPxeWr4ah4XA/8tHe29/0HCe3crGl1jjD3L333AvL/Hfm6
	 CUXMxyHSe1IwTm1RMl47BlH7tEpYhsfmkEgpVhw0bbNPsHo/JeiIYeDJz3rPwEyoQ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mw4m1gfp;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DD606A331
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C44DD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mw4m1gfp
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1433458a91.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446994; x=1796051794; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UfQmc2c/VBqjJpzYZJV/mvR5pLjgufyNtaYeJb3a0XA=;
        b=mw4m1gfpUrv2FreNB1ZNFYzNad9WSMfE2DUOWTxfu1Js/8bHT/D3Nb3OHw9uGeIhLD
         yW7CNvkhOKWcTfFvvMZts8R2aR6t6AR0cHwm8pZD705K4Tqbf7Xz2x+0BymycsMY4xPV
         tLu7++89hUi8MRiMUa3u+4QcVY4op8HfQtdfE3iX8fg2y/LVLiCIUPe53HdFEIg9H94M
         IBcdG6op9YsSCfqQyKfdzHrxG5N6VP7mGesC4g1GzO7EpdpbcWrdFaUO+8C41JQtVxDI
         p/Y13atkvC1BHSqzbKx+glAXQt9AEf8vgZy1Zx3RmDhis4kCCd8a8c41g8/I2SCq/c+n
         0zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446994; x=1796051794;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UfQmc2c/VBqjJpzYZJV/mvR5pLjgufyNtaYeJb3a0XA=;
        b=rSR24eFevtUyHRCPjvAHCCua5cO9oGGg2Qz2s/YqZ8JLfCPW96emNdBfkfn5h7+HCq
         HgB198N/rYWCTuZHLKL2jwQr3orTqUsNKNCgrs4D+j6+RT5n/tNo+DcYvpGL2K3jydQc
         AHGJDWfOQxFf+jbRIsq+CKSdEWoBOXWCZTv3dcDs6gg93QQiZYOxex3+1vJWzT/1pMDN
         mEP1d3lsN/FT06qn0STvweDNxxAqaoIJ+LhN4jNlutGNf6vaXltKUNCpaOWUuDQRy+jh
         TsqXxcnX/G2qahkqWzFtBPvEUTtnOkNEAFjs2LwCYBeQ3DNg9RyTZZzF30Q7hwQfmC1q
         nnhQ==
X-Forwarded-Encrypted: i=1; AL+hErHk016j1kJnFPTsnro8+vLrqQzJK8i1uhmX1+7w3v/Bso1S6ufc7NiUkDUZDBpg5KuetLim5jI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4wBB+4sPtZGOHPotULajEMpALe5fJlqgYsRXCC034NKb7Mcdj
	rQUL4gCh8YBED0kefMaYBCGsQsACQiDjP7ZVUwoLZg+G7hR8632C6+mz
X-Gm-Gg: AZFdTZfASU7cNs6ZGi6BbzXfs8rF1xVq5ja4+oEO7KIl/6ce6KPMRlRcBtCRe6vVMf3
	6yERbRRfaeBdvXVfjBi91akWpTaPZny23kESEKTlHHyLJdv7R3ItDvFennyPAn656GILKwCFSOU
	azGwJHA7cN9qpFOJFeWSrhrrSdce8cEsu6lyVULspXRA4RL9pVVjzJWGcDZx+5g+71rccGPzQa3
	RM8ugwqeHzkZfwd00iDi8lLhSXF4aCw9xNbX1CnKDvTPoBfRMPWdhI02DnvQjau2xBHvvJsziqx
	8K3Wx5TV98vIx/GnDtlxV85/oZJHORlMaTUcV/PajYyQt0a+R8jSrUq2b1XDAgGLlyYT8YCwXKz
	RoQ2ajQyfOU542LkQOeXC7fJFVwXRaKHTQiw9c46hponEGCNwLTm2REKSo00OwodrdjJldgCl1m
	Vkejhh9y9tk9PoXjBgsHDjFAdQZOanimHTMzsiGqjZ5U09SZWyTDk+ukGRV5g4wLa7UAQgKijRX
	HjWcVcf46vdBF3fL/qdH+O2N+BfaPD8SicSwsVjIs3VoKnWnz1F8/waE/lWNIe6UotWI53UQzr/
	XefJONCOV3aIr4H252OSFDLeBPRkmw==
X-Received: by 2002:a17:90b:3d8d:b0:3b3:b750:d2ed with SMTP id 98e67ed59e1d1-3b41c7b56c9mr10763673a91.8.1795446994016;
        Mon, 23 Nov 2026 07:16:34 -0800 (PST)
Received: from [127.0.1.1] ([150.117.174.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm20067482a91.5.2026.11.23.07.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:33 -0800 (PST)
From: Gary Wang <is0124@gmail.com>
Subject: [PATCH 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
Date: Mon, 23 Nov 2026 23:16:13 +0800
Message-Id: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-0-f2322a91686d@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAL1YBGsC/zWNQQrCMBAAv1L27EK20lT8inhIN1tdkCRsUhFK/
 24QvM1cZnaoYioVrsMOJm+tmlMXOg3Az5Aeghq7w+hGT0Qet7LkYBGLJm72whAjampMbpr/IFi
 3UrI1dMTnmdfgL9MCvVlMVv38frf7cXwBCl4bkX8AAAA=
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

Add missing groups and functions in Tigerlake & Alderlake & Meteorlake
for INTC1055 & INTC1057 & INTC105E.
Add support "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
"UP Squared i12","UP 7000".
Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
on the AANT0F04.

The pinctrl-upboard is provide additional driving power & pin mux function
through native SOC pins->FPGA/CPLD->hat pins for flexable board level
applications. it's probe from ACPI device id AANT0F01 & AANT0F04.

Signed-off-by: Gary Wang <is0124@gmail.com>
---
Gary Wang (5):
      pinctrl: tigerlake: add ish_uart groups and functions for INTC1055
      pinctrl: alderlake: add some groups and functions for INTC1057
      pinctrl: meteorlake: add some groups and functions for INTC105E
      pinctrl: upboard: fix I2C pinmux-select set CPLD GPIO OUT not function mode
      pinctrl: upboard: add device id INTC1055 & INTC1057 & INTC105E based UP boards support

 drivers/pinctrl/intel/pinctrl-alderlake.c  |  40 ++++++++++
 drivers/pinctrl/intel/pinctrl-meteorlake.c |  32 ++++++++
 drivers/pinctrl/intel/pinctrl-tigerlake.c  |   4 +
 drivers/pinctrl/pinctrl-upboard.c          | 116 +++++++++++++++++++++++++++--
 4 files changed, 185 insertions(+), 7 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261116-upboard-pinctrl-add-intc1057-intc105e-support-01c37cfa685b

Best regards,
-- 
Gary Wang <is0124@gmail.com>

