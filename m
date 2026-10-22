Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695441;
	b=rNSBhwAa1yJIJ3gPP/A3/Po87W0znj2FngXCaR8BOXHcKBhsacaUK/J7/d0eGbs2s1Xd
	 v9V/phgGG/MfjZ62pZn4tW3dht46Nv99fHAChGaVsCMaEYwYidjHmq28Bxll0h3kRIQOh
	 Z6PsdgJm5d0obMYqf6zvt/KUKkI6PLtZjq16pPDLRygoJnGyHVpzaPns1QIdIdynOe+og
	 XqUd5kS/oU+XIciEOZ9pw+56zV2EfhDkg9IxlG/hITzsSTRp2IA+z34SFXM3Tpld1sQnu
	 bvwBnZROWsRxMViDoL/vB/e75Uq3TDkylRXv54/DFs21uVrrnl3h07GLX0lwV6oyFtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=O1kXH2tQA49Ltlx5LN5QeX0va2Kp+8DB68xbor4uCoo=;
	b=ZWYKRB/eN//J6LgCKpe7lkzBvHu99YaS1XeI1IRVb3hS+JLj+xwTj64xY+MGQ/ElOJvJ
	 kai1vME1+DfeQmHbanfN4tF6kWkq2xkX7/EL5bWHGfJ8xEaL2t9lUuT1k//TFSR5qsiaD
	 1QuQ8DiiBHuewunf1t+2tWkcRwTRNk/zJdG2cGqyDTPOG6fLyTmMYfi2tRL0Cphov/g0T
	 MtqRQnnseqQ4xGjsM4NPsJUzHUyi0vmi27YAM2AsyxS1ByUfJZL8G0VprbHW7BuWcNFne
	 XMvfFgvQjQCeYQpHgr5GG5AC2fspjC38M3DwTL3LHVwOsiHLzlLqC3QFHTxVIe8+cSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NEy1i9bx;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E78606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 18:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6E78606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NEy1i9bx
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so843055e9.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695439; x=1793300239; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O1kXH2tQA49Ltlx5LN5QeX0va2Kp+8DB68xbor4uCoo=;
        b=NEy1i9bxq4Qoc26+QqLZwcdLs7pIY2CXzMsUhr82UBF/r+i8at+WWXMuL5TgGWiQj7
         Z5grun+t4bk6YFlbgHhVXWgd7hJisuvUc8pLHaLlXlgvuE7elR8/iWrbJmWxfFp3l8pg
         Aj63p4lcg2sx0XnnJ6ze0lI3Em4UDq5RMJd/88yE+xxcRZIKKbBUhWFsdGkNh5HGMteF
         WIchuV9dmUSLe2Q3YE5PFJmT/gkxeW1x82hmzT3Jrr7MwQTLHqou79KbBnAwkDMuS+Ed
         Wu/1uFoOrEZke4UMsSSflLCw7U1DIdZtLrqWjlgXz8UUdTlThPvuWVSOEgvrQztwn/o3
         LWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695439; x=1793300239;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O1kXH2tQA49Ltlx5LN5QeX0va2Kp+8DB68xbor4uCoo=;
        b=OosSmkxiTVXkk8hGxFqnCmxNTo7nNRPvxO1UdovdlncxAg3TZIjcgybRvgYh9kOMxX
         Ip+We2xvft99h9avGuQVFC1hctWp5V7nago2IFVpPrD8ZTYdtsYc/J66V2TJcN0vpVuA
         iOSgBo2hRmB3xQ6naRPxzDv50sCncag9oXJ2RwhEUlcHd/rPOe8brBG2m1cgTicwRXKb
         0smxZyKMynvOWYB+EdxdC+BlBti7snYNZqhMAoVZ45/EcUOcqsiPSZVWdcCNUC2wfdat
         BCtqGilrS93SWhItS2flXP/DHYO/+wH9SEun2c7HVK8SDYif+tGX8cL6nvkRs5WjJHYi
         Nu+g==
X-Forwarded-Encrypted: i=1; AKwUvBykQlDsLyb+BHGB581MrCI/XNYOhZie7xP+evNPgDJ8nSTyHphoY9iPJck8iszX+B8aG87Qb2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJc8AJhYK8DMA1fZ/HtI8tlnGDlRkDPHPBuGurMPMyanBtbN4D3
	ksL0UzJMYlbyFMzEVysjBFaD+uVDDHvd5U/BdsvOb34eA0Fmwi3fRrQl
X-Gm-Gg: AYBFou3VTWxd7beHcNe2IbjVuSCYrBwLVey6fYy+D0cMsyM7XKISY9dw2i+NPAcFb0x
	G59FbzwBiHHozZkz3WVoLLK1RQVUCN7uTbzY1r5XWTmhAqAYHv17i+EoS1NmhWYeItbSwOOS4Pr
	z2xxvS0+7sUeeXcvuBjeqYv8OvRETs8hxPDLDNDs54xgYiX/Bsj+LMeCQda0gJbW4K/6yQrAKLL
	JdzO62NZPplZATYwteK/nppmr/IdKPCQ3GhVnHqZPf41pKoIwgyAl3BIh3xteiLr6QDPN6F1/py
	s0MAZfrcAWS4pnMF7T2e2kjVMd4fQO4cYSZZhvxLlVm2vQo9Hga0i2UdizmytOEPb5UmvH85DFI
	4Oo4ZM9extK0ay6IlclmW6PY12Gi03pDS6Jbg+AXQvy2exbbTkWzLUiYg4L8TuzDgr2o1z/vpqu
	cYjrBEM4PKpP6yu6CtMQOXqciWhvSuCSiAVQ/yhs1O4vPAQ/p8Y3KFXis4ge74ByGTAAtC9+K6S
	vIkPLaXFVIOIbqYLLV5LBeOuJna2JRBlRcCPq5ygmoRrGUG5hit1g==
X-Received: by 2002:a05:600d:4443:20b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4a2001aa3f1mr83811875e9.6.1792695438824;
        Thu, 22 Oct 2026 11:57:18 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d900:ff27:14a1:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e379f4993sm154745f8f.42.2026.10.22.11.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:57:18 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Subject: [PATCH v4 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Date: Thu, 22 Oct 2026 20:56:39 +0200
Message-Id: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOyw6CMBBFf4V0bUkZHlpX/IdxUUqBUaCkrY2E8
 O8WSIxmVie599xZiFUGlSXXaCFGebSoxwDZKSKyE2OrKNaBCTAoEpZktEFjHZ2Ekx2FlHEuC8a
 gFiQ0JqMafO+22/1g+6oeSrpNsSU6tE6beZ/zsOW+5nBFzmLIOQdOEypRPL3oy3YQ2MdSD2RT+
 vSnBPD3jk8po9WZg7pwkQEX5TBLoxs34FgfhnVdP5XOrUvzAAAA
X-Change-ID: 20261014-first-patch-23099c6002da
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Remes <jan.remes@mycroftmind.com>, Jonathan Cameron <jic23@kernel.org>, 
 stable@vger.kernel.org, Martin Triska <martin.triska@mycroftmind.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0

This series fixes several issues found while using the TSL2591 in
company products (Raspberry Pi CM5) and when testing (x86_64 laptops
with MCP2221 USB-I2C bridge).

The original field report found that the illumination value has always
been 0.0 (caused by division by zero on ARM).

Patch 1 fixes divisions by zero in the lux calculation, which occur with
LOW gain and short integration times, or in darkness when CH0 = 0.

Patch 2 adds an i2c_device_id table so the driver can be matched by name
(e.g. via sysfs new_device) on kernels without CONFIG_OF.

Patch 3 makes the driver return an error instead of a bogus value when the
sensor is saturated.

Patch 4 improves the formula for calculating lux values to make the
returned value more accurate.

Patches 3 and 4 change existing behavior, I am OK with splitting the
series into two, if that makes things better.

AI assistance: Claude Code (Claude Opus 5.5) was used for research on
sensor behavior, datasheets and Adafruit library, to compare results
produced by old and new formula, to draft some code for patches 1 and 4.
I reviewed all of it and tested it on x86_64.

---
Changes in v4:
- no changes in the code
- drop "Assisted-by: LLM" tags (Andy)
- Patch 2: make commit message more to the point (Andy)
- Link to v3: https://patch.msgid.link/20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com

Changes in v3:
- Patch 2: Fix commit message, OF-only drivers can still be enumerated via
  DT or ACPI (PRP0001), only matching by name needs the I2C ID table (Andy)
- Patch 2: Drop Andy's Reviewed-by
- Rebase on current iio/testing
- Link to v2: https://patch.msgid.link/20261014141650.259929-1-ciakval@gmail.com

Changes in v2 (thanks to Andy Shevchenko for review):
- Patch 2: Use C99 initializers
- Patch 4: Keep variables in reversed xmas tree order
- Link to v1: https://lore.kernel.org/r/20261013143943.436816-1-ciakval@gmail.com/

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Joe Sandom <joe.g.sandom@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>

---
Jan Remes (4):
      iio: light: tsl2591: don't divide by zero
      iio: light: tsl2591: add I2C device ID table
      iio: light: tsl2591: report saturation
      iio: light: tsl2591: improve lux calculation precision

 drivers/iio/light/tsl2591.c | 58 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 16 deletions(-)
---
base-commit: 87e28db23d0384f3995c43ecc5ae2118b371edb5
change-id: 20261014-first-patch-23099c6002da

Best regards,
--  
Jan Remes <jan.remes@mycroftmind.com>

