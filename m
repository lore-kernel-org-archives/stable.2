Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293990;
	b=HvqhyR7u6cGvTsFZVSnRMakn2V0ruZAQNMOFvibAcRaChNi163U84saN6OVdLm37Eh9k
	 K73D7Ks9yE7v5aUcgk0t80t4kW5hW7ehMNsHvZFMwGHonir0Ag3ZMujPApNXEOUoVE3Ux
	 vOP5pDYImIrls/HLuHSV9FPapvgZcHUL7potuTNfy0FF0xx2b9vh39Sx25eteArSdYV+b
	 8uW+0jTlsEdpskkTvPHXTTNha0eCXjIl9Fikj1Mohs6CSKYcJIgc+Ms/cmtc4C09bUNcY
	 x1AGuq5PoJkhrwYhkyWBpDfitYKnuV3VRWYc4aFyH+JyV37Oua70WMB4/BORnMqnl7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3dROjGZCNE551sXOSnZVVsDb5S4//gNDdIiMvX1YD/E=;
	b=b7qBA+/kkDriLHREqInKjQ50jy3R7quYYz/Op6/42IgwkfTRp78ozq8PEYOVgG/58Xe7
	 7sT6xu32Y79w+JSfoMkyUtFQVVFZ340QVTpW1w2ctyt/1ExSw24qY6LnFbzVZ+LV8lkD6
	 rViTSosXxCfxwKq0HVYuJUC+9TrVQk0ziCeM4V5PT8YcnzPsppCcK4Pv9HPh9aGZI5k1Y
	 LeoE+cF1l0BXdTQyyFiqkULSSAkNVajcVFK8zsI3dAMN7uU4tqXz3K4kfRJ3pvxAYPGW3
	 e2lDqLb255dCz72bpN0X4Vys2qasqDGtG8wa+nH0y8tA4kQ1GJg9iE/QDEV2PUUW12w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cm3NRQ+h;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D69606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 20:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D69606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cm3NRQ+h
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so722505b3a.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293989; x=1795898789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3dROjGZCNE551sXOSnZVVsDb5S4//gNDdIiMvX1YD/E=;
        b=Cm3NRQ+himgMCRSGF7x3bxAvLJEDq7eK3ClrL11yur+/cYppSjoErValcHG54qVL8q
         KeHUdt3EryIdsjU5vCq+shBOEHWjIByKj5RJn9Riq1/5gX+HSpeaLcl/Izx224bLV9Wu
         x0v6JbKInmHgTxiAwCBsCD7tG4zKR+ZphSvkGUYId3DrHCJ5N8HkP0ZCiDB9f19HsvfR
         krcSoGGZbhHKwgh2xSs+BwgfCC0OsCNMxN0gOjHJvppy/hnIHq2TnQw/wRw6pPEX0s1D
         r8cBbUzeCgNYuX0fqYV6Qkn0HlkfmU4UbtL+/nLKNmnURTYWCWcj/17sbxgV1bjO32oT
         LzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293989; x=1795898789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3dROjGZCNE551sXOSnZVVsDb5S4//gNDdIiMvX1YD/E=;
        b=veSOPL77rrm2uF9NTZlcTHGu4UGQrSlq2F+3sibqJMBrftTh0k/iO/jP4yr3fDE10t
         FDsSnXDi4lwV48nE/nA7TqT17ZPReK82wHlw5jCmHkpaoA15F2aunqVxbtA6N1kFdSjZ
         w3GJ/SAhrlUr1s0Uj5DGczUI9HoG+zgUBIQv05AMdWGiW8ZSywsrG3CI1jjAPqRu7Ajl
         BFXQBmUTwyS9CZ8EOvrh+3Un1F8mrkPLHBqHDHA9YRcqcVpcmMozdzLD6GTmZiR/Zmtg
         3X+GpUbTCyKA2lBrM2oDNa/uFWvARFqEIyCsHnY7HaNIXixgH/BeMIYBfkHvq0sJPp1Q
         qOBQ==
X-Forwarded-Encrypted: i=1; AL+hErHjvvr64b/liGEXJ9jZ2d8SzjcVBXRV/Zg4+N003e3dILXjft5AS9sjoGRDBOFHFnGfxQBKdOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iDE8ydZyfh2X6sLuUZjxrcwtUM95OvCFLzf6+obV1gwbeOy+9
	WImxaEwkhCa0OMJ2IJg9I6sedRTGW8mme25l+x/2nQZFUrzHnzorirIrUyjYTpFHGaY=
X-Gm-Gg: AZFdTZc2rBZh9jeUeZO1hqV1q/kAlT2d9OOHHZkst3VOcV5PIk0ciFkjrcCVmYp9uJa
	0mrAYR1niHNScJxkTQ4rAbNND5eX+ZHNxnEkmOyT+A2S0zV0XsQecda5fhAMc8SPKtjwAtv25sk
	yD/sM1cWwEUmpt5ZJTVunKZGq2VjOhtrhp5XX5rNbjh1YxgW/hgzq3otQ8OcUJAV/Q8TLhBA+w6
	hPVsQKxntCSK5xeSpAckXIInpx73hyAMiMQybcG/619SmSZuXq2dFwHY9r5IcLq2qNKtHmyiCmL
	JkQhTeNiRutmCGMGFnz09RGtNhJp0xzIq1xfBlH6uX4OU1jIsJie9QeIHvgxqfCLUYVG9hh1hMN
	DAgBU66+dVHdkAAcqExuaMvZrDQ4LXaung5xxaifC4oC+AIxY2nPZ/v94raM+FGGjnOoij0cLJ9
	4VH8hBeRR9XwFwsgb+2C3kvWHJgsXNfqU7ernctigynGf6aHWZ/IiW4FNBd1Zgyf2oPdTyhJDWr
	ktXUhzl+LKuHZQgmXacgTEJ9CwaIU8hXQg1rRL8HMSKr0ljYl1G6yXffaBsVRzBrbfDWWUFVtdA
	T1/QFC6N/vPSgDBlteyyLXWeZx/QGwdtGh4ZbRBpFxU0nw9kiMxG
X-Received: by 2002:a05:6a00:2ea5:b0:873:e3b4:5d4 with SMTP id d2e1a72fcca58-8c8793b8d04mr6434190b3a.2.1795293989190;
        Sat, 21 Nov 2026 12:46:29 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6213:28::4:379])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c263sm3091141b3a.11.2026.11.21.12.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:46:28 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	stable@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jongsung Kim <neidhard.kim@lge.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: sp805: re-enable the clock in the restart handler
Date: Sun, 22 Nov 2026 04:45:25 +0800
Message-ID: <20261121204528.2435533-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wdt_restart() fail to reboot the system if the watchdog counter clock
was previously disabled: If userspace cleanly stops the watchdog, the
core calls wdt_disable() which disables wdt->clk. No reset comes.

Re-enable the clock in it as in npcm_wdt. The watchdog .restart()
callback runs in atomic context: get the clock with
devm_clk_get_optional_prepared() at probe time and keep it prepared for
the lifetime of the driver, so the restart handler only needs
clk_enable(), which is safe in atomic context.

Link: https://lore.kernel.org/r/20260911031916.A8E051F000FF@smtp.kernel.org
Fixes: 6c5c0d48b686 ("watchdog: sp805: add restart handler")
Cc: stable@vger.kernel.org
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2:
 - include a Fixes tag
 - use clk_enable() in the restart handler
v1: https://lore.kernel.org/r/20261120201029.1685193-1-mmyangfl@gmail.com
 drivers/watchdog/sp805_wdt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index a14ff7ac0db4..4e4febc52853 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -138,6 +138,13 @@ wdt_restart(struct watchdog_device *wdd, unsigned long mode, void *cmd)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 
+	/*
+	 * For reset, we start the WDT clock and leave it running.
+	 * The clock was prepared at probe time; only clk_enable() is
+	 * safe in this atomic (restart notifier) context.
+	 */
+	clk_enable(wdt->clk);
+
 	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
 	writel_relaxed(0, wdt->base + WDTCONTROL);
 	writel_relaxed(0, wdt->base + WDTLOAD);
@@ -156,7 +163,7 @@ static int wdt_config(struct watchdog_device *wdd, bool ping)
 
 	if (!ping) {
 
-		ret = clk_prepare_enable(wdt->clk);
+		ret = clk_enable(wdt->clk);
 		if (ret) {
 			dev_err(&wdt->adev->dev, "clock enable fail");
 			return ret;
@@ -208,7 +215,7 @@ static int wdt_disable(struct watchdog_device *wdd)
 	readl_relaxed(wdt->base + WDTLOCK);
 	spin_unlock(&wdt->lock);
 
-	clk_disable_unprepare(wdt->clk);
+	clk_disable(wdt->clk);
 
 	return 0;
 }
@@ -253,7 +260,11 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	 */
 	device_property_read_u64(&adev->dev, "clock-frequency", &rate);
 
-	wdt->clk = devm_clk_get_optional(&adev->dev, NULL);
+	/*
+	 * Keep the clock prepared for the lifetime of the driver:
+	 * wdt_restart() runs in atomic context and may only call clk_enable().
+	 */
+	wdt->clk = devm_clk_get_optional_prepared(&adev->dev, NULL);
 	if (IS_ERR(wdt->clk))
 		return dev_err_probe(&adev->dev, PTR_ERR(wdt->clk), "Clock not found\n");
 
-- 
2.53.0

