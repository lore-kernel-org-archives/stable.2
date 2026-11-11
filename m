Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385962;
	b=idpLoroYd9z5NATG3LLTdp9pklzeToFVJ2zQFqSLAA8Ov71fNsBDOjETQnjUY38C5Ywg
	 mriQxRbd3GabNgw0BumjTNFx3DARGzEPyZ3yYCYp1F1uTeOE0EwQr1MFkK9pD+OrCmOXh
	 p/Bq0/hdQpExmxkl3d+Pnl6gTeVrTv6GNhkZG7XysQhXUAQ28yfnoYct3/opE0gwp+HeE
	 GLJniTtsEN2KaFXuDRHzqPjIF0SUalO8I3jU0KsE+QIDYYqSr7SuHz8kY8s2In+v58uSh
	 Tn5rmGXPUy0/+ElVvKdTlUEbRZb+mr0J5DsFItODOiKUwFlNPcy1okpJ1puFz3UOf5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385962;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IdseeLTQQDTkakepBjNOAJi36H/YdlBN+5sOfWMWeRA=;
	b=FslPtiBzv61JGM6J33Id76zH7N2m41soiN9zRZYhPtkpHVp6slVvXIbQeK0ByYZvQ9M5
	 x+ElOTX3i3/n+Q9LCu81TqYEz7oclLNzch4HKjidBanA7854kZLWUjnbm4HLAjhYB8fTr
	 Bp7iHqu8Ap/jvd+2uX9vYmFHuv78Q9ifSwo2xOughaQ3opSL2YoRDoYzv9w/iCU8mpLEc
	 i5RNbnrSF5L2O/6gSIl5E7A3umArKkMk6XTRDy+QdroD8cKlZg0WJ1fq1odwvBCowBhxm
	 b5AalPx3Mw35rasYr+JGwzAbDpKxqlDhTqrmpD7peaH1bkhEdZQHt4VDTXMxDGjLMvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fq8WwDdG;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB19606A31C;
	Wed, 11 Nov 2026 08:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fq8WwDdG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=fq8WwDdGz1U/mNG5i0J205QPQSBj3AV89yVcuQL9Wf6IPZDz9bXKsUc2O9DaRQcamQW3KIjex8mC6
	 2otI72KUw8vPa5Lljx02l6shK4h5zuDeA58lQ0l4V0AMTJwuXdSG4mZ3U/UBDXPxgy3FgUXpwZtskO
	 AvKB5S+g3Ud8m3cQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af42826c7c-d428f;
	Wed, 11 Nov 2026 16:32:39 +0800 (CST)
X-RM-TRANSID:2ee56af42826c7c-d428f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af4282460a-d5748;
	Wed, 11 Nov 2026 16:32:39 +0800 (CST)
X-RM-TRANSID:2ee16af4282460a-d5748
From: zhaofeng2@cmss.chinamobile.com
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	j.neuschaefer@gmx.net,
	Triet Hoang <triet.hoang.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] watchdog: npcm: fix sleeping clock call in restart handler
Date: Wed, 11 Nov 2026 16:32:36 +0800
Message-ID: <20261111083236.248-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261111064150.260-1-zhaofeng2@cmss.chinamobile.com>
References: <20261111064150.260-1-zhaofeng2@cmss.chinamobile.com>
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

The watchdog .restart callback runs in atomic context: it is invoked
from the restart handler chain via atomic_notifier_call_chain(), under
an RCU read-side critical section, on every reboot or restart.  Since
commit af084fdccfaf ("watchdog: npcm: Enable clock if provided"),
npcm_wdt_restart() calls clk_prepare_enable(), and clk_prepare()
takes a mutex unconditionally, so kernels built with
CONFIG_DEBUG_ATOMIC_SLEEP=y report

  BUG: sleeping function called from invalid context

on every reboot.  Worse, a panic-time restart can block on
prepare_lock and never issue the reset at all.

Get the clock with devm_clk_get_optional_prepared() at probe time and
keep it prepared for the lifetime of the driver, so the restart
handler only needs clk_enable(), which is safe in atomic context.
With the clock permanently prepared, npcm_wdt_start() and
npcm_wdt_stop() are simplified to clk_enable()/clk_disable() as well.

Fixes: af084fdccfaf ("watchdog: npcm: Enable clock if provided")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
v2: use devm_clk_get_optional_prepared() instead of open-coding
    clk_prepare() + devm_add_action_or_reset(), and simplify
    start/stop to clk_enable()/clk_disable(), per Sashiko's review.

Issue reported by Sashiko's review of Triet Hoang's pending
error-propagation patch; maintainer confirmed the problem in
https://lore.kernel.org/linux-kernel/19258f94-ec01-48f4-9d04-22e5ecb5cac2@roeck-us.net/

Based on linux-next, which already carries
"watchdog: npcm: fix clock prepare leak when setting timeout on a
running watchdog".

Verified against linux-next.  Not runtime-tested (no Nuvoton NPCM
hardware).

 drivers/watchdog/npcm_wdt.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -180,7 +180,7 @@
 {
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
 
-	clk_prepare_enable(wdt->clk);
+	clk_enable(wdt->clk);
 
 	__npcm_wdt_start(wdd);
 
@@ -193,7 +193,7 @@
 
 	writel(0, wdt->reg);
 
-	clk_disable_unprepare(wdt->clk);
+	clk_disable(wdt->clk);
 
 	return 0;
 }
@@ -242,8 +242,12 @@
 {
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
 
-	/* For reset, we start the WDT clock and leave it running. */
-	clk_prepare_enable(wdt->clk);
+	/*
+	 * For reset, we start the WDT clock and leave it running.
+	 * The clock was prepared at probe time; only clk_enable() is
+	 * safe in this atomic (restart notifier) context.
+	 */
+	clk_enable(wdt->clk);
 
 	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
 	udelay(1000);
@@ -417,7 +421,12 @@
 
 	start = res->start;
 
-	wdt->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	/*
+	 * Keep the clock prepared for the lifetime of the driver:
+	 * npcm_wdt_restart() runs in atomic context and may only call
+	 * clk_enable().
+	 */
+	wdt->clk = devm_clk_get_optional_prepared(&pdev->dev, NULL);
 	if (IS_ERR(wdt->clk))
 		return PTR_ERR(wdt->clk);
 


