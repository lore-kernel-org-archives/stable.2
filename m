Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5123B4EBD
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848631; cv=none; b=EbhVzUylYUdyXi16ClIS/izMoWR/9OcCxqJBdwR8W/t+9ZZLMA+AH+H7QdyYknMBd+Lw9R5hs6FWe9ERYt3coZCmQ76p1KAXJntPJyCGM/DqDSbDAoVODUuyXvjya8EW+od/DiGjyIlVQXKEtZbLoPyj3QMJthRVCdcsyEBwazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848631; c=relaxed/simple;
	bh=C2eBZXTj7z4JargxfKoe48rn4iOm6Qbo6aOlsrmLXyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT4gC+B+zrDOpPJ9hTZFSoGueubNQj9ez4Qia7zYT9/6libWQbwl44rs6mPTr5bZhjNNu9gFifZP0pqrTYtESCXMqbQUtkWqI9gnrWWdaUR2NnZBB0uff62MktOumJrMEu8076JnAeXhY2gNC5/GOV+TAID1QwrpZV8ETdAXtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0MVjWAZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0MVjWAZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so38804275e9.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790848626; x=1791453426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzZubT1XUHSGbDZM1zvSP0sHOYv28Uuy2JZcRRHm8fc=;
        b=m0MVjWAZYekfTNHpYDmSS91S/p9gd9tkwNst2XbJe4+jSWJPFor0zO3jgeqoAVHFEL
         pTL8tEpXB5njnNDs/SkpWcO5UanmvMRidArD2dYkMK85fXifRmVuiapKQwBbJSfzT7T3
         t+L5e8mu+pa+Xyqd7B0+QvErC7H1KEX2NwtXviixpBUbib3VvTrQcgDjZ2vw1DbN+wsu
         4ZncLN68cRp1ctv3Q5sInN3BP2iXsnZ/EPPmYdWrJx6wgaltbWjHYCTd8JaiTmXPWAh9
         dzMsvG+UAuCjoXvX/TcXTZ0QWrsK/HaZyVuUz+DMuuR9WWX3kwN99fVvOOU9LptOEm+q
         EJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848626; x=1791453426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzZubT1XUHSGbDZM1zvSP0sHOYv28Uuy2JZcRRHm8fc=;
        b=aH6wCogIiwhvdk5bO3H0BLHjFRy3g3ZhDjRyNxHoNvPb0EgVgSsOtu6yiFf19v1aRY
         u7Ed/bQ/0ZPMWWpS0bom3TJ2vEYhzfKd2mYxay+7vT1Xc9rWgxlnehmv2cQ69rEnCvHE
         v52SkfB7lTxryox9WRl6gIXnr8xXa0pXgsWhcc7/uNyg1A7nwYj5JMqLa6rpLASKG24L
         9TSY8uQx/4+h7D2OWMVN+JFLzsZ7qkSsZZTgz58PSHCTtiyZeGP83Qp7hXyeuWnT0kXn
         rVJsBQ+6CaBQEFrhXF1Remz2oJQaqVMPdW5SiNcKjOnxjk/LQtlKnTspEFLKkRyfLM1y
         PDZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAW9JgTAYu1gu7tSKrQeggUKp/zmf8+0VHTnXsXugSnK7TcCzAEscTBhXIXLF8bM7X5sovTRk=@vger.kernel.org
X-Gm-Message-State: AFuF++mdXvCbu+awpGeO7knHZmMAOTMh1rCvRF2hF6fQT1+YqmQTPbHH
	NLfu9tQFXEHiBx+pgyMtmrxCSbNh+Oa/BgvKWu9BL8hxASFK/KlUmGfs
X-Gm-Gg: AYBFou3OQZYeTuBy3J6ZUq3VaXgRx0F/TnnZJZc2pIc9V31EVoqWNV2vohOHZHXZIrP
	74yWmGj7GS3ivI2Fyl0xnnvlqvxwKRG/OGdRtigzd8wBF3K7TAoHimHLAQiHjTh4lBSQ1X/r30L
	ecCHqd+xWYyO8PfTROpifDqLfRZMrgTo7tPFnHPClEPaK8s51tu5JL30sduTDOWWYoC5L9RjBwO
	gcusVkemH/P8X27t+P8N0/D+zXc7vh5PUBuyB/vbQ7LeKQt63pNxp9yW3MW/92ohOZ+dJAvhtRn
	ZJWo5xOSsmfAVIXvKOojdnloduKYiz8SS9EC7axnJ0EstgZHKKRvhHRY2c6arz6kVO9PKk50L14
	C0RD0YAUsu/MdVGKRF6rYE4xniZKW5sHd2hOr6nOW9TCvdYOJ7lJTzfDvFTCAynU8/Z+K9T5cIl
	6Z5U4d07nsyuNuQJIWKz7BMjOlK/aiHJO0irkJO4aCa4ZPMf1/E8mO2Bln//q/UrfbwuZIyXYtq
	0Hh8NFhYnepYJx5dSFTtEuE
X-Received: by 2002:a05:600c:19cb:b0:4a0:1c17:4fb2 with SMTP id 5b1f17b1804b1-4a01c175025mr58235685e9.31.1790848625739;
        Thu, 01 Oct 2026 02:57:05 -0700 (PDT)
Received: from fedora.tail922d40.ts.net ([213.55.185.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f99a332sm105855845e9.12.2026.10.01.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:57:05 -0700 (PDT)
From: Michal Szpakowski <michi.szpakowski@gmail.com>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	Aditya Garg <gargaditya08@live.com>,
	Lukas Wunner <lukas@wunner.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: applespi - turn the keyboard backlight off across suspend
Date: Thu,  1 Oct 2026 11:56:58 +0200
Message-ID: <20261001095658.5821-1-michi.szpakowski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001084154.4703-1-michi.szpakowski@gmail.com>
References: <20261001084154.4703-1-michi.szpakowski@gmail.com>
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

Set the flag, and deal with the two things that follow from the LED
core now sending a command of its own right before applespi_suspend():

- The LED is a child of the SPI device, so its "off" command is queued
  just before applespi_suspend() runs. The driver keeps one command in
  flight, so the caps-lock command was skipped while that one was still
  out, and then dropped by the drain. Wait for the write to finish first;
  the completion now wakes the drain queue unconditionally so that this
  wait has something to wake it.

- The level the LED core blanks to would be what poweroff_late and
  shutdown save to EFI for the next boot. Keep the last level the user
  asked for in its own field, updated only while the LED is not
  suspended, and save that instead.

Tested on a MacBookPro13,1 (2016): 30 s of s2idle with the backlight at
200/255 leaves it lit on the stock kernel; with this patch it goes dark
at suspend and is back at 200 on wake, and a caps-lock LED that was on
at suspend is off during the sleep and on again afterwards. A
hibernation with the backlight at 200 leaves the level for 200 in the
EFI variable instead of the blanked minimum.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Szpakowski <michi.szpakowski@gmail.com>
---
v2: address the two points from the automated review on v1 - the
    caps-lock command racing the LED core's backlight command at
    suspend, and the blanked level being saved to EFI at power-off.

 drivers/input/keyboard/applespi.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -407,6 +407,7 @@
 	bool				have_cl_led_on;
 	unsigned int			want_bl_level;
 	unsigned int			have_bl_level;
+	unsigned int			bl_level_persist;
 	unsigned int			cmd_msg_cntr;
 	/* lock to protect the above parameters and flags below */
 	spinlock_t			cmd_msg_lock;
@@ -724,7 +725,7 @@
 	if (is_write_msg)
 		applespi->write_active = false;
 
-	if (applespi->drain && !applespi->write_active)
+	if (!applespi->write_active)
 		wake_up_all(&applespi->drain_complete);
 
 	if (is_write_msg) {
@@ -923,6 +924,14 @@
 			 KBD_BL_LEVEL_MIN);
 	}
 
+	/*
+	 * The LED core blanks the backlight around suspend; that level is
+	 * not what the user wants restored after a power-off, so keep the
+	 * last one they asked for separately.
+	 */
+	if (!(led_cdev->flags & LED_SUSPENDED))
+		applespi->bl_level_persist = applespi->want_bl_level;
+
 	applespi_send_cmd_msg(applespi);
 }
 
@@ -1772,6 +1781,7 @@
 	applespi->backlight_info.name            = "spi::kbd_backlight";
 	applespi->backlight_info.default_trigger = "kbd-backlight";
 	applespi->backlight_info.brightness_set  = applespi_set_bl_level;
+	applespi->backlight_info.flags           = LED_CORE_SUSPENDRESUME;
 
 	sts = devm_led_classdev_register(&spi->dev, &applespi->backlight_info);
 	if (sts)
@@ -1791,6 +1801,14 @@
 	return 0;
 }
 
+static void applespi_wait_for_write(struct applespi_data *applespi)
+{
+	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
+
+	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
+			    applespi->cmd_msg_lock);
+}
+
 static void applespi_drain_writes(struct applespi_data *applespi)
 {
 	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
@@ -1829,7 +1847,7 @@
 {
 	struct applespi_data *applespi = spi_get_drvdata(spi);
 
-	applespi_save_bl_level(applespi, applespi->have_bl_level);
+	applespi_save_bl_level(applespi, applespi->bl_level_persist);
 }
 
 static int applespi_poweroff_late(struct device *dev)
@@ -1837,7 +1855,7 @@
 	struct spi_device *spi = to_spi_device(dev);
 	struct applespi_data *applespi = spi_get_drvdata(spi);
 
-	applespi_save_bl_level(applespi, applespi->have_bl_level);
+	applespi_save_bl_level(applespi, applespi->bl_level_persist);
 
 	return 0;
 }
@@ -1849,6 +1867,14 @@
 	acpi_status acpi_sts;
 	int sts;
 
+	/*
+	 * The backlight LED is a child of this device, so the LED core has
+	 * just sent its "off" command; wait for it, or the caps-lock command
+	 * is skipped (one command in flight at a time) and then dropped by the
+	 * drain below.
+	 */
+	applespi_wait_for_write(applespi);
+
 	/* turn off caps-lock - it'll stay on otherwise */
 	sts = applespi_set_capsl_led(applespi, false);
 	if (sts)
