Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663514;
	b=VMHvvWf0p9qci4iqpUCDLLJrB4ydTm7RBupcZRsmPv/DQ9Yth49xRpvtiIB9KlzUTUD4
	 VGS+r7aBZmmy0cH18SIrOlAdqiKX35yH+YE1Pvsxp1QdT07iOSeGP42i+yrN+aTsX9dJA
	 G/9QYjND9t/+WyKbVhY/n05lJuvy6G4Ch3bBpzIqHwZW3kKkWKt/JcArX6gsUnuae74R/
	 vZkVmNGKOgrxr+7ugzoYgbmbbQMs/IBZLwnZcMX5f2A/QMHefIDRd2rNeMfGcxOpv6F78
	 3omIenc8m4wYSURU515O1J5ko0p4t/9stR3lWWMnfw/4kvYNLiKHvJ2NoLLZTDMBF8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663514;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AZUsrq291ioXtIFLJBp+mfWr4CexSy+VwYbhvQRqUfw=;
	b=Lz2pAHQSqB1eklcAn3CO5rsqSBRQbAgWglmCB1dFT2tTugZX2+tTZoFcg4JeDKzvDV9f
	 uJ1vnh1yW5z4P/gIqittUO1zNYJxicCKT05pPnwLoA2fiv4Ww1AoFcAmijN+cwBaf+n6O
	 CMboavQASlGHocCFR7jeRNcZ0Pe7w3izYbJG48ZKS21Y4gQVsrwA/40EX9PgqJWfxnUDu
	 6a2j3l2E+yJts+SCZHfI+IiRilHbIjtFIp5iTUVF9iV7JRsNOdTk4FGuiVZdPSzr3uEKX
	 S0hm8GL/pKWHd1+tR9WF3A877MTR4QyCA8gqaM3VuWHWzzybgDqIrUTs9nkfWMU7cZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=psWHWB0Z;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CE8606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CE8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=psWHWB0Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=psWHWB0Zhyn83oTsLULif69/LWeVAMFzs9vIqVwDReX1gQ04rVHArrJgoQWujkmCQVnLMVmhvx1VE
	 xE5v7IawyTYGwvcF3bQJ4UdhL/SVmuTDz4ujmx9W8Frt9riOh52cTfc4SUFF/fYBf1gHlwiJRAVanZ
	 CR8TUXFVuJr2lBEA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86b07a696ca7-f770b;
	Thu, 26 Nov 2026 11:25:10 +0800 (CST)
X-RM-TRANSID:2ee86b07a696ca7-f770b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16b07a69384d-5afce;
	Thu, 26 Nov 2026 11:25:10 +0800 (CST)
X-RM-TRANSID:2ee16b07a69384d-5afce
From: zhaofeng2@cmss.chinamobile.com
To: stable@vger.kernel.org
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.12.y] watchdog: npcm: fix clock prepare leak when setting timeout on a running watchdog
Date: Thu, 26 Nov 2026 11:25:06 +0800
Message-ID: <20261126032506.1227-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <2026112521-cartel-refresh-660a@gregkh>
References: <2026112521-cartel-refresh-660a@gregkh>
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

From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

commit 57c7cbe21acc77291ec0fbdd4bd72aa259cf4986 upstream.

npcm_wdt_start() unconditionally prepares and enables the watchdog
clock, and npcm_wdt_stop() is the only place that disables it.
npcm_wdt_set_timeout() calls npcm_wdt_start() again whenever the
watchdog is already active, so every WDIOC_SETTIMEOUT ioctl issued
while the watchdog is running takes one extra clock prepare/enable
reference that is never dropped.

Split the register programming out of npcm_wdt_start() into a
__npcm_wdt_start() helper that assumes the clock is already running,
and call the helper from npcm_wdt_set_timeout() instead; only the
watchdog .start callback (and the restart path, which intentionally
keeps the clock) now acquires the clock.

Fixes: af084fdccfaf ("watchdog: npcm: Enable clock if provided")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 6.12.y backport: 6.12 retains the `if (wdt->clk)` NULL check which
 upstream removed before this fix.  The backport keeps the NULL check
 in the new npcm_wdt_start() wrapper and is otherwise identical.

 drivers/watchdog/npcm_wdt.c | 24 ++++++++++++++++++++-----
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -63,13 +63,10 @@
 	return 0;
 }
 
-static int npcm_wdt_start(struct watchdog_device *wdd)
+static void __npcm_wdt_start(struct watchdog_device *wdd)
 {
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
 	u32 val;
-
-	if (wdt->clk)
-		clk_prepare_enable(wdt->clk);
 
 	if (wdd->timeout < 2)
 		val = 0x800;
@@ -95,6 +92,16 @@
 	val |= NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
 
 	writel(val, wdt->reg);
+}
+
+static int npcm_wdt_start(struct watchdog_device *wdd)
+{
+	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
+
+	if (wdt->clk)
+		clk_prepare_enable(wdt->clk);
+
+	__npcm_wdt_start(wdd);
 
 	return 0;
 }
@@ -136,7 +143,7 @@
 		wdd->timeout = 2750;
 
 	if (watchdog_active(wdd))
-		npcm_wdt_start(wdd);
+		__npcm_wdt_start(wdd);
 
 	return 0;
 }


