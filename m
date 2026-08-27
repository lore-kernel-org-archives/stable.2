Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBC3CBE74
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874193; cv=none; b=Ae96vog5qVs6Te+iuYHzTPsvPJv08ti/TW0BjF+CF6EEo4RCls79Ij3MBUDGMc/TKDcqdPUj2gr3eWFkHioLmmvrbtbfEp3RCF0ZMOqc3x0S3Bshj2bppZZ5eccHMrtvbLABbzDdCN+1ARQy3NQznO2ru93Rzsi+JW7pDPdBQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874193; c=relaxed/simple;
	bh=seGeJVUaBY4csPp307lVbWcygAp1HQ7VLHvAmGqgjqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EpeIFdgoNH9simBQ0/gszUAMsWSgaeVZ0TSXUXnrP112w+6+J6Ylm+qclTME+i8gLkJglzlHXixYJqGq7wq2ORLPP39A+33FMPONahCXGOSYPs8trlJtJmesSkYxTjifglWhlUhIicNhdoiu6WwG9a81bqRbxJmBIjWtJTpojfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPSUEmyi; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPSUEmyi"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4563ac048f4so618932fac.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874190; x=1788478990; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zVdJjWb3UpbdKuHlq3/PIvwY2V+KiCYJBGO2pCIZorA=;
        b=lPSUEmyioWixJqw5SNKGhsnHC6EX8ahzI/se4rXMRGiIZ+3lFRGrgbqioGeSuujjHI
         UflpVKFv/iA4riekGlQbrkZzy72Yq8ygl/1OI3TXpp8bG9VZFPKJ0akAz0g6WdDYF417
         B0KB9nGFO2ku5uTpWIvsEFTflXJSl3YqUMoRzHKLlKldKvMCWU5Ho0XNwWcjtxYpiHxm
         E2b0p69ceR++scazCRojMnDdziHUvKeWwfCycVBh+fgdZeTn9s9NeESHhe7nUXIH3/GE
         eJE8rB3pkkrrUtxCcE+OtQAQHraxGZ8T9g5hUFVyGafprPaQurvh2lUGvIie4YVanqJ+
         woDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874190; x=1788478990;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zVdJjWb3UpbdKuHlq3/PIvwY2V+KiCYJBGO2pCIZorA=;
        b=JUq3iSYF3OpQmHQhlLDtiTQU6g9TZ83i5kun4N4GIbx1l/4+qIIMiMiyF2ZfscApdX
         MCvJS3Asc2bkx/VkdKUJ7UhL2EP7u9qaJML06n9z8+xuYQ0a9/JceDCirYqSrkKCRxt5
         XF2AndEoFbGncstb7K4iuGo6wsGUZZFqNp1Bspg1plYLuhT9QQWVAchlJqtXzepgjDXX
         I1D1CU2RyjB1zxUw3es6HcTqm87JMqDrQcU/Ho7jBYGhCxFlkHY7PlSdR6ruSPw4+xFm
         JD6VqefVbTsRELnx3wQB3IRiBX06C+Z9vJete1gkBa3Jafjzihk3ZYC8DHjQ6ST1acXg
         L07Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp6WhdqvcmWK/Kk8SBX1vu7rpGFRBcu7S1DG8Mzz6PC0A9zq7O5qLsUQKlROVHF72eN9v1ZJs4=@vger.kernel.org
X-Gm-Message-State: AFuF++kijblTw0g8n6vWzhlLU+lyt03D3oJnSVn9HBgsNj8S+/ee13T3
	EyNqWIXFw/psDPmrB3Qy+anU53e2eZSNqiUor3OxQ5CiYcZrGNVpRHjN
X-Gm-Gg: AR+sD12NSFRIfTSXA0fOSHjHYTB0R1em7hVvSwCaE7BlSHQGCuFE0O0J67kWweI59EV
	AJmhz3FJ1H1uwFonFfqk5nHZykzFhG0ZgUbuLvxAr7biDRLSUOYuCAKYU1NpALpflwPyPH96d10
	RuZ55yb1CumwRGPj5nyCrj3XcjcU0jvXlNwyer/1OeVOGLjv6yNXMRz+cOSV4Xa7DW6ga6CcNsL
	lPDjUHMcU1fsvIuxJfvuQcI6OLv62MOjrfMhsiWuzRz6WU7fnh8D0apXG4KQQ7MD2VggiHbBEZi
	mQje7N/h72N66ECvlkD3dg/NffAxMaAcDdIZTr00YQNu8o8AKiQKz2vmffa39hEhl27B6iP9ow0
	lOamCUo/8fwKk2XBqV6EDBlBQiEf8IBEIwUiC29AwQYZ+wyCcqsecqri4/4aFdwV2Zsqd0k9NEd
	clIYFycs7HPe1VhsznOEd+LMeYEyMKK79Xsx0ToUg0NtaNjh6WVVkm5WSJbrkHYQSaui2kP+kT1
	ZaQ67Bf4z5mgwLHFySQULP+ea+Bag3DZLZEDjFnrYtWNACV2U2a0CgnvmM+GvjqWUx304E/U5Bg
	1qx6Y4WY15Ng6sx1bX+AQEosMEu0lR7HlVTQF7CKXaoDslXGTvTmgonQucPua/k53ivRAg4nloF
	MbqGgg7FikWSJ4LansA==
X-Received: by 2002:a05:6808:1308:b0:4b2:21e2:82d5 with SMTP id 5614622812f47-4b3981256e5mr3096321b6e.10.1787874190443;
        Thu, 27 Aug 2026 16:43:10 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b36abbdb56sm5279979b6e.17.2026.08.27.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:43:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 27 Aug 2026 17:42:51 -0600
Subject: [PATCH] watchdog: sunxi_wdt: preserve boot-enabled watchdog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-submit-sunxi-wdt-boot-enabled-v1-v1-1-d16f934cc809@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBCF4auQWTsJNIrVqxgWtDPIEG1NW5GEc
 HdHWb18m/+tkDkJZ7hWKySeJUsMiuZQgR/7cGcUUoOpTVtbc8b8dk8pOmER/FBBF2NBDr17MOH
 c4OXoqXVs7YkMaOaVeJDlf3HrdmtjYl9+Xdi2L4+MHriEAAAA
X-Change-ID: 20260827-submit-sunxi-wdt-boot-enabled-v1-94cd6be885d2
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Carlo Caione <carlo.caione@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

sunxi_wdt_probe() unconditionally stops the watchdog even when firmware
left it running. This opens an unprotected interval during boot and
prevents CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED from taking over the active
watchdog.

Detect an enabled watchdog and decode its programmed interval. Preserve
that timeout while setting the Linux reset mode and pinging the watchdog;
use the configured timeout only when the hardware interval cannot be
represented. The enable bit remains set throughout. Mark it as
hardware-running before registration so the watchdog core services it
until userspace takes control. Keep the existing stop operation when the
watchdog was disabled.

Fixes: d00680ed0026 ("watchdog: sunxi: New watchdog driver for Allwinner A10/A13")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/watchdog/sunxi_wdt.c | 47 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index b6c761acc3de..1f3da1d47fa5 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -128,6 +128,38 @@ static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static bool sunxi_wdt_is_running(struct watchdog_device *wdt_dev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
+	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
+
+	return readl(sunxi_wdt->wdt_base + regs->wdt_mode) & WDT_MODE_EN;
+}
+
+static unsigned int sunxi_wdt_get_timeout(struct watchdog_device *wdt_dev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
+	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
+	unsigned int timeout;
+	u32 interval;
+
+	interval = readl(sunxi_wdt->wdt_base + regs->wdt_mode);
+	interval >>= regs->wdt_timeout_shift;
+	interval &= WDT_TIMEOUT_MASK;
+	/* The 0.5-second interval cannot be represented by wdt_dev->timeout. */
+	if (!interval)
+		return 0;
+
+	for (timeout = WDT_MIN_TIMEOUT;
+	     timeout < ARRAY_SIZE(wdt_timeout_map); timeout++) {
+		if (wdt_timeout_map[timeout] == interval)
+			return timeout;
+	}
+
+	/* Reserved interval encoding. */
+	return 0;
+}
+
 static int sunxi_wdt_set_timeout(struct watchdog_device *wdt_dev,
 		unsigned int timeout)
 {
@@ -259,6 +291,7 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sunxi_wdt_dev *sunxi_wdt;
+	unsigned int running_timeout;
 	int err;
 
 	sunxi_wdt = devm_kzalloc(dev, sizeof(*sunxi_wdt), GFP_KERNEL);
@@ -286,7 +319,19 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, sunxi_wdt);
 
-	sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
+	if (sunxi_wdt_is_running(&sunxi_wdt->wdt_dev)) {
+		running_timeout = sunxi_wdt_get_timeout(&sunxi_wdt->wdt_dev);
+		if (running_timeout)
+			sunxi_wdt->wdt_dev.timeout = running_timeout;
+
+		err = sunxi_wdt_start(&sunxi_wdt->wdt_dev);
+		if (err)
+			return err;
+
+		set_bit(WDOG_HW_RUNNING, &sunxi_wdt->wdt_dev.status);
+	} else {
+		sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
+	}
 
 	watchdog_stop_on_reboot(&sunxi_wdt->wdt_dev);
 	err = devm_watchdog_register_device(dev, &sunxi_wdt->wdt_dev);

---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260827-submit-sunxi-wdt-boot-enabled-v1-94cd6be885d2

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

