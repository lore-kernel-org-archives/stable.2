Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664329;
	b=u9ZdlbrbwB3GBKzj7yUrQa7Re8ShOHyPtfQVo6thQZzCzqgQiLNJ1Gjd+L15vfDaVdAk
	 32T5W8T2HsV+/sB7f0L26JDHWVBdP5hA246WKbj5V6VDqe6LbdRps++KOA+G57qCi5iRs
	 HJ1Gs5djopLkWgTvRglzOZpSLYYF2JD3LWPALV1Obw/4j8vTgkG8L7RPnpEQ2jYpOKyB3
	 1DEEb8ABFuq+/U3juO6p5xTogbeiSJTy+pVabqDek6xmVpUxO2/IWSzB0zam0lUAv6JIc
	 gGay7+x17pRExHr7UXHvY2TFKF1PQ/C13l5W+tjG89iykPSId/aG1QkZKk/xnL6JWCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664329;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mTUlETHuSm0YqcSHu31oUUSTmk9XZSa43KC6KZbErz8=;
	b=l/ar4njR/qrtUsJZok7cZob03kdsCPdABWEO8tbUPLs5eIQD8cUbX1KSL1MxRGlnQ2Gy
	 /8mIkx/5ZyQGla1VBOi1e375kpn66vKj7umQ9STyOlX3mdfQW/iQQq+xejr1s71d02Okq
	 8hLL1saE2IYwOvPfo+GjzRAwSa91qtn3DNLkMaqEKqX1w/bnl+IO9lr5ECtH8PbSak1JU
	 V8TP6JJ7iG825sxhzMza1RLFkSMycDlBpZAKhm9Vcdo+XdzkLX6XwikwcCkA2EK9t1l7f
	 h8u97riMbiFT/4taJzuRYQmXAebqby+2u1s4CI8fnoLImDmyhjlTnlhRQpReQ0EQvzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=R6IZBDG6;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8932606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8932606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=R6IZBDG6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=R6IZBDG6apj2HMP98rr+UkGSe5wIDXKi7gY647btmwj+SwcCiHwCctOhcFF39tCHh7NFAoUzGqFDM
	 1f6ctwKEe28xj/yWZg2WZGEX8ggB+KHf5iHMJDvBsX/w5mWRHF9BTC4+VdnU/c5lfS8J2eAH5RjC1b
	 xx/WFs5f+OeQJ2lw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36b07a9c0359-23662;
	Thu, 26 Nov 2026 11:38:45 +0800 (CST)
X-RM-TRANSID:2ee36b07a9c0359-23662
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66b07a9c3fbb-5b8aa;
	Thu, 26 Nov 2026 11:38:45 +0800 (CST)
X-RM-TRANSID:2ee66b07a9c3fbb-5b8aa
From: zhaofeng2@cmss.chinamobile.com
To: stable@vger.kernel.org
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.6.y] watchdog: npcm: fix clock prepare leak when setting timeout on a running watchdog
Date: Thu, 26 Nov 2026 11:38:42 +0800
Message-ID: <20261126033843.939-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <2026112522-ocean-schilling-8a8f@gregkh>
References: <2026112522-ocean-schilling-8a8f@gregkh>
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
Same backport as for 6.12.y: 6.6 retains the NULL check which
upstream removed, so the backport keeps it in the wrapper.

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


