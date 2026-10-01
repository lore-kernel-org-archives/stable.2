Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2CB4AE8DC
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844144; cv=none; b=mw4iOrDlRuLFw68880gN4aY4ox2hXZplTpDJRRXoN1AIOrqpQDhNb0TtSAc9Oia0dt2+wgxYpFZmHFiXTPQEpd5NWXbPotYsbd4MBBW5R6uI66QpceQNMqRkCMrQUkA+Vhn0Q8upxN+q5QBQGbfni1h6MehPN9EfYBjkNW8MKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844144; c=relaxed/simple;
	bh=06Ox9IKJfXy8MQZ0xbbIOMeArMq0Aj3o7lfzFRx0NOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqG1gLcHUG7gZ26R23vNqD6TGDcHo0IIVrDfqopf9puZmbvKHtx1qBTZGknwblZYIg8JBJQp31ublghh+buPqkxFCY9D0LgaWhfPiYCskqi9DS+51HsautnjYDEoHskRdodzeGOlPgY7zJOZnj3LCcZbsZIzGtro3KvQZslYfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SayuldGs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SayuldGs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so45958395e9.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790844140; x=1791448940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQPK/Y342DWum5zvJ87J6VdcruASwjM7cysQ73g4EIA=;
        b=SayuldGsM4Iy9hlC/nPdZs93lfx2KT3tBfSUx9eRfGB9RL3qqRdo+n6AqVbyIhwE3g
         QJMOeFQi7mOoMfpS4OaJ2abAsVQMddOwtlfm568hdbBSwG+95Izex1bLHmBBdjcxnZBu
         FsE6rFWNPO2FrwIOt+xYMlDAYYFaUuEAo+8CriN8Oy6dOmlxhoGPONbBdYdwezjAIjJu
         zrdT2xiZ4ozn/PR6az97n5clJt/GEqa5aAA8BubGJGzQBApITsvpAnaIFmcUznaO/I1V
         B7F5KS9MZvpXwja9zYZfDlbfdnPlMSPpiOq4BhpyztZ4jT/x68zG7K1OI6cxRsO5T/MX
         6DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790844140; x=1791448940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQPK/Y342DWum5zvJ87J6VdcruASwjM7cysQ73g4EIA=;
        b=aprslSsLRu6+IoMz7/0S7qlXTDHia+eNIQgiTD0pU7X9sHeqXORktrt0erA8ebCkY2
         R+7D+wiIAjEpNOLxQExCXUAK7kVhSV2qlyG+T9xKfZf+s8M7fljje5UBu2fKdTSz/UcF
         6RueKZ6eN+3HRx4+LgYXB5Cav3OUxzw+bgnpwQe7NehKKPihM6G9FwAyW4zSZfZ3JhB6
         pyWrK5F4Smix4fi3CjMmuaUk2Dvr/Ge1BJQahlr/KoM+BjS27yiHFPn0dczi9tRBSElj
         NQ665ZaAmzHh4yIfOrmZSvxpvG23BjaTbOpoS0xQKQGiKwJwOIAO1857YZu8jw5s/p09
         u5Jw==
X-Forwarded-Encrypted: i=1; AKwUvBw2lRzCrmHPuHCFXfIdMh/KiTfIu1MxA86XXZJdoZJE7YtJnXlObC2JYfmrxeo4j4M0xZnVijo=@vger.kernel.org
X-Gm-Message-State: AFuF++mPQJUFW7FfA2eSai+nHEokYUieFwe/pQsPkHZj1H0G/yx22HHK
	3q+ciglsnnoSw3CNMak1+wrb9ifbudIvPOxqlWJ8vqIXzCGv9acxfpD1
X-Gm-Gg: AYBFou1Ce6yfY1s0xZfpbrOqJq2AhjeW1UcQu4LTFwXk5v8OCoB1sAIXziur69QQVgC
	tijY1Gwk7/Eb4EuMFDdIGFKW8UGjJE5cVO/l9nLTiaIDwxc3qdGF9J4NzxzaYZsA0Rwg0CknMXk
	TxwQME6/QgqOedEipb1Ev5rv4wOrtkE4vJTTvKavIjaVubNW44kczWx9u4ZbauGHxZN5tszFxFF
	CSh6JxVzoKU4gm+yDogEIKlzN7VaAWrilLn48vZZ+ls8jBwFnRTEDDxhR3AnwSeJ41/f4Gfo4mm
	p14a7LPH85WPzUXgWFIgAJy6YQJM/0/IHGAQZfAf5MqWZvaQ8OAkBAY4+DaV5ylyJWQ0+MgSQwd
	DHz7ZMs0Qi7d50i+B1nWMMrRmwRjLYgiVg4aSGJxv6O6noDU2/ePaG7iMXegTAo6OekZFj4qLnN
	uB9UMEl5lnRll1x1L+KFKxjjx2eTZWnDMGDCWnh1sDqX4eaOsBZC6n3eizmAky30SlgQA3NF6GG
	XAnrx5YHg==
X-Received: by 2002:a05:600c:4f8e:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-4a01b00541bmr62101135e9.19.1790844140215;
        Thu, 01 Oct 2026 01:42:20 -0700 (PDT)
Received: from fedora ([213.55.185.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f98f72fsm47380385e9.11.2026.10.01.01.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 01:42:19 -0700 (PDT)
From: Michal Szpakowski <michi.szpakowski@gmail.com>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	Aditya Garg <gargaditya08@live.com>,
	Lukas Wunner <lukas@wunner.de>,
	stable@vger.kernel.org
Subject: [PATCH] Input: applespi - turn the keyboard backlight off across suspend
Date: Thu,  1 Oct 2026 10:41:54 +0200
Message-ID: <20261001084154.4703-1-michi.szpakowski@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The keyboard backlight of the SPI topcase stays lit through s2idle: the
driver's suspend handler only switches the caps-lock LED off, and the
backlight LED is registered without LED_CORE_SUSPENDRESUME, so the LED
core never gets to blank it. Under deep (S3) the rails go down anyway,
which is why it only shows on machines that default to s2idle.

Set the flag. The LED core then sets the brightness to 0 before the
device suspends and restores the previous level on resume; the LED is a
child of the SPI device, so the command goes out before applespi_suspend()
drains its writes and disables the GPE.

Tested on a MacBookPro13,1 (2016): 30 s of s2idle with the backlight at
200/255 leaves it lit on the stock kernel; with the flag it goes dark at
suspend and is back at 200 on wake.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Szpakowski <michi.szpakowski@gmail.com>
---
 drivers/input/keyboard/applespi.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1772,6 +1772,7 @@
 	applespi->backlight_info.name            = "spi::kbd_backlight";
 	applespi->backlight_info.default_trigger = "kbd-backlight";
 	applespi->backlight_info.brightness_set  = applespi_set_bl_level;
+	applespi->backlight_info.flags           = LED_CORE_SUSPENDRESUME;
 
 	sts = devm_led_classdev_register(&spi->dev, &applespi->backlight_info);
 	if (sts)
