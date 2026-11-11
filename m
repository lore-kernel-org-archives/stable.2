Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379318;
	b=XnG6/TTm2NK6kblL1w8N7ofr/gt5tYFhUao/pO7JlqvA+IN38AHH2zh9cL7OS8DCJ4Er
	 9FLY6mlyptmbVjS1SyWcLJujtrKj39F9lzOaxMm+6pTmoZcCtk9/64NXGHJGqsWHqeBm5
	 /aZ3rrvxq5xJfU7vnKBcc6bnWOWCw+XUElNQrKp9n/zd029sx9Yhp6SAYi6fjtNohN3Rv
	 1Z3h0KCba8HA0bFxDoMi4Aaadp8W4vYVK5lX3UcE2ALwyEXSWTKwh2bu7VJae2kT9pu5i
	 KOt+lgOLvV+c3Muw9NACxpLKyO0hAqibNo1rArNHDNnW9hyLkAJWqAoAxX31Qftnx1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379318;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n6L2l3CuvEy/oi/ujRg0yiSm7fAxM689ENfz+9X+Hhk=;
	b=wgaxmT2q2ANKIimzAhOGM7UPLk3/mXLqvcPhoEp/IhkUHCCoJCI8Hh7S1WDgZ+BdVWPN
	 WXt3eyeuGpIFUooyKrVzmNIaHkl99BPX0w1QJ7mBSomAOjKxutvukgebEzRwTL3lmDuer
	 rODpnXCT4yjmE+nsLYsO+Yxx3v4ZjmGezt4D0+Z+7uDRbh8juG3+B52Bo0ZEeFJiavJGq
	 l1Ot3YiIORENk0f/zk4qLPnCXa2O0+TrOxPpldGIZ6EGHE64rD8vvxYwH++44jYzoeAgD
	 03VtjLPsDW15GARSET5W+ugcQHPoOaKBdVpBr51Si1dFvj4HVrB71KxJnZbv23JftOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KFLjowCu;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6629E606A31C;
	Wed, 11 Nov 2026 06:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6629E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KFLjowCu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=KFLjowCu/hzn+sfXP3lMolyjBpgw48zDbByGpKclhzb5jPL6ZJpWoKOSKPuFk96ewJz3fYQxbQNFa
	 E50FAw8h9wy9ZgTdr71BsanfrDHlaVCKSqzspRq3+9+MilaQBmWt0iKhKi++lvFrvDtmJO2xntqUW0
	 1jw1CJq9AeZL9R0A=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af40e31bb6-a13ff;
	Wed, 11 Nov 2026 14:41:53 +0800 (CST)
X-RM-TRANSID:2ee36af40e31bb6-a13ff
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af40e2dbb1-d1caa;
	Wed, 11 Nov 2026 14:41:53 +0800 (CST)
X-RM-TRANSID:2ee16af40e2dbb1-d1caa
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
Subject: [PATCH] watchdog: npcm: fix sleeping clock call in restart handler
Date: Wed, 11 Nov 2026 14:41:49 +0800
Message-ID: <20261111064150.260-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

Prepare the clock once at probe time and keep it prepared for the
lifetime of the driver (balanced by a devm action), so the restart
handler only needs clk_enable(), which is safe in atomic context.
clk_prepare()/clk_unprepare() accept a NULL clock, so the
optional-clock case is unaffected.

Fixes: af084fdccfaf ("watchdog: npcm: Enable clock if provided")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Issue reported by Sashiko's review of Triet Hoang's pending
error-propagation patch; maintainer confirmed the problem in
https://lore.kernel.org/linux-kernel/19258f94-ec01-48f4-9d04-22e5ecb5cac2@roeck-us.net/

Based on linux-next, which already carries
"watchdog: npcm: fix clock prepare leak when setting timeout on a
running watchdog".

Verified against linux-next.  Not runtime-tested (no Nuvoton NPCM
hardware).

 drivers/watchdog/npcm_wdt.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
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
@@ -393,6 +397,11 @@
 	.restart = npcm_wdt_restart,
 };
 
+static void npcm_clk_unprepare(void *data)
+{
+	clk_unprepare(data);
+}
+
 static int npcm_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -421,6 +430,20 @@
 	if (IS_ERR(wdt->clk))
 		return PTR_ERR(wdt->clk);
 
+	/*
+	 * Prepare the clock once and keep it prepared for the lifetime
+	 * of the driver: npcm_wdt_restart() runs in atomic context and
+	 * may only call clk_enable().
+	 */
+	ret = clk_prepare(wdt->clk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, npcm_clk_unprepare,
+				       wdt->clk);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;


