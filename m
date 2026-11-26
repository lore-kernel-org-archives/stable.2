Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705808;
	b=T/zLLeEToRZZidg+4QhGoU7oiJ0NATdPpCQP/IF+sxhU4zDSbUUd0U0XOc0HJdUSVI3v
	 4bCPKQmmEv1iq+8JMcJt6bCgsOkEHbm2O23N0rBnaAq28rPN6pPSStUGnKgYOqdDCN7Sv
	 QWCzlc/nvQBUpE8I3DrZhC2o0cZIlSbB7lILgAY18InPz1dWMGwMuMoK6RQKUCRHeIBC8
	 rmmcjsHbsMXo3ysFymbvkSo+AcoL9GXmQYjx3vACI6Fx0wNAQfxv4QgAl6e2U/ms39Pks
	 8v5qhQ9WsxCglO8o1KiO40I6R32w6nkFlXyLKYkcc6+B9iH4CChjwUBN1tfoKvol+VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=qF8Gq3/DvfR9bgvTJhpHtUh60h1rATqchUrrPkWfF34=;
	b=JoQ5L4tKWoCzwphvBV97DdP2wHnOsM4BVOHpJuYFBvVFb+98iTt/mQq19TqqKKxk1rkD
	 ANH98j69naIVp/sptLbwTTjO8Vz8gegrrr8s/w0VcV0PrhC1Y9H870J8UOELuZ1r6qDfU
	 /NnPfXak9K5F8jJ7HYLYxNSBL1i8HXYa6v3nnovKF6nfWkXDYHomu5gi8VNa1B99ivSee
	 K01aj0rjSNWxvCAjksmixQQDkU/qr48aG0xBiY/aPEDf1caS5j8GxnLFB7rOWRR13mLxG
	 Y9dR4LNMgoM+3Rh8MGign3G2bMLQG/rKgtuuI07kJLQl68UwLI+ZdimE5+D8bmiK1YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sVWrWfsL;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE13606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE13606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sVWrWfsL
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdddc79a4afso2995895a12.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795705807; x=1796310607; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qF8Gq3/DvfR9bgvTJhpHtUh60h1rATqchUrrPkWfF34=;
        b=sVWrWfsLGRp0Isn5pPucJMuYuU5jEAa9H0Jd6Y8Aq6x1hJ2zyQri+N0tmaqKNDZtlE
         yaZN0C69i/lUA7Gpbf7QDqoUun0daKC6C4cd2qgAH9hxTpG2bXIM4ciVwDh+CqB9ikEF
         eSK+mF4mZErFJtJTULr0JCYSLe6e2dwIw8cxgG9Zr86tWy4vjBt8IrEY/NPbPf97xcY9
         /M5VhyD7npJdqdvWvZTi2c9SG76qdq5mUb3aWCFXwSK4V3bRJ4JWP7z0lUNc6dsXmRC4
         wDiUgdNxJaZrN+VtIqhVE2pigKCphnr2mqS9jrENXl1p+WNsI2tt3Re4OvkhAsXNsYgt
         RTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705807; x=1796310607;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qF8Gq3/DvfR9bgvTJhpHtUh60h1rATqchUrrPkWfF34=;
        b=Lx0gKFMwZa0vqK42h5AWDqLY7DefsEoDUIpCzSEtwBNw+NGXFGVsIzjL6Yre1MTp9W
         QtAzJiAF+AXxwy26+G3KpWqU4wd7UYpD/Fv88c8ottFqksrpg4vZxJW7fLlFhiZKyEk1
         2x1msjGBye16ZKVZm+nArsQfljvs7oDzvyjm9cp0VlxH9jropPPxOM3O199myRnRckHr
         20k1DcFmLRhqBPmJ32BNBo829P9O5Gf5BdLgi2jFE88UxykgCnxaqJVlyg1kFpl0PLvz
         3ZuQ/wOmt8EGeWCHuygfcUxOGhMCRUVbGcf0c3USF7bhKD5l/s1V/Aq3EU8v8qc5Ydta
         vR5g==
X-Forwarded-Encrypted: i=1; AL+hErFtCBXn9MmD+nznrl9gUG31Rwpo+PMZQ8fkCIJH1EAF8hEMvlRTAzRKK7zKiGqvz4N0HcFazQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/B0gR6CfzqeYjVun9HttV1QFS34fJ4TlaH1jxtUtr8FadpMlrf
	KLgLbjB0+ej7344KiGCTNL9f7E7ae+U5RWQHCNwxvpzLsOTR+Q8cP7Efhv0Hy5A1
X-Gm-Gg: AZFdTZc6DeYvunVx7Vg96Fy9Fr1ChLi1hv5jU6YyMS5kig47g13X1zCzcChmcEiQjBU
	SwERGyYTE/jRXsIkXL8AKDZ72L68zu9VqzrEpTCiC+hIRX5r2K81xt9bMtWZmqZ+Y3s6MEZo0Vn
	WqoqBuIAVdSdnMH4tvgsnNA3QY8c8gT4U7RGtDGmRkbEw7j8cor497w9F/qhzHGxr9esRTiKnp2
	E2fmnS1XkYGtoR5wqv5sWr3quiz5NXPKwFug3Uii8evBkBtIyVRt12No/GecyrzO+azD+nspV6p
	aozWUPC/SomJDaK+hDjvDbKh8P0x3gFJy85toHqyEgn2psy5tYbSjhZoIh5B9rKr+KhJ1ozWgau
	muM8PHZQn8TQueUY39vWTeW3GJK4mQ+3w/fJDooSZdyHjoATp3VNv3tAqqMZYWbBSteXfh/+yrh
	b+epAuQz6IFv3Cs67veMe57qVj2PY/BlJk29PsUYMGEak2SKwRw4a+tJn9M8Lj70fpUSUoHDsBL
	F5nEJbpGWSWljGJN3uO0TArLZLmIvLNG3IrSyz9HJhJ9l+Q+b+wSKlaeo/X7IU2q8IHzFPDtfTg
	e8/RpF4A2WlyVfzrxLTJEaMSPZF2fQojujTZSiuwD6HmxC5Jwg==
X-Received: by 2002:a05:6a20:3d1a:b0:3eb:37a7:12a2 with SMTP id adf61e73a8af0-4014cf57a08mr21001490637.33.1795705807164;
        Thu, 26 Nov 2026 07:10:07 -0800 (PST)
Received: from [127.0.1.1] ([150.117.174.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm11099923a12.8.2026.11.26.07.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:10:06 -0800 (PST)
From: Gary Wang <is0124@gmail.com>
Subject: [PATCH v3 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
Date: Thu, 26 Nov 2026 23:09:43 +0800
Message-Id: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIALdLCGsC/5WNyw6CMBBFf8V07Zh2gAKu/A/jovYBkwBtWiAaw
 r+LJiZs2d1zF+csLNlINrHraWHRzpTIDxtk5xPTrRoaC2Q2ZshRCoE5TOHpVTQQaNBj7EAZAzS
 MWvCi/A8LaQrBxxFsVT5zbkUmi5xtzhCto9evd39s3FIafXz/8rP4vv9SdrA0C0BwmCGqWshKm
 lvTK+ou2vfsW5pxby+O2hE46IqXtatcIWu3t6/r+gGAY3p8SAEAAA==
To: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniele Cleri <danielecleri@aaeon.eu>, 
 JunYingLai <junyinglai@aaeon.com.tw>, Louis Chen <louischen@aaeon.com.tw>, 
 BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gary Wang <is0124@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Add support for "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
"UP Squared i12","UP 7000" and missing groups and functions data for 
INTC1055 & INTC1057 & INTC105E.

Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
on the AANT0F04.

There are no compile-time dependencies for each file, all pin groups 
functions data will forward to set default when pinctrl upboard probe.
It shows an error when run-time dependencies are not mapping to right
groups and functions.

The pinctrl-upboard is provide additional driving power and pin mux 
function through native SOC pins->FPGA/CPLD->hat pins for flexible board
level applications. it's probe from ACPI device id AANT0F01 & AANT0F04.

Signed-off-by: Gary Wang <is0124@gmail.com>
---
Changes in v3:
- Update detailed description in the cover letter.
- Update fixes patch detailed commit messgae.
- Correct the I2C group mapping names for the UP Squared Pro 7000.
- Link to v2: https://lore.kernel.org/r/20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com

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

