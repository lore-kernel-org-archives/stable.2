Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208210;
	b=NFj1vVHLAM908qVSpQwdH1PJe9V44NRLGAA5Ws3YFlW6IYwspn1GZsMxpu4lNm923EUt
	 yIoW7qvve/cEAiIQ1PpxRco7BN/MlIQDgNRL7V818iTmBvCHi2SO/1beLplxNeKGiRZ3r
	 fOH+108ndQF+SMD3dkueqBldLv3C0DniAL6QWpQEhgP4bWIBJrs2mGgHQpheKBSK1Eb/V
	 977N7z8oGKbkPN9oPiJM1YD8BjFVjxd0UVGIyfeceaDC3v2hw6dxdLwzmrGNPc3cuGeC3
	 rk7nPUooyHVQzclNgR6GeS7aPKLvFHkumbQnhSus2J/a12SWlB1Q1xSXm5IA9lS8MYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208210;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JJ6qe9zMkWxzn6wlq5kkCPAnah3XYdAanji2PhYWtHE=;
	b=z8JayuO4UYZ0lqC6KUS3ggXbhiveyNhDIVSGjTBWCmy9NmDDEDviskH60r0r4JATuLPM
	 h93JPsgBKp7HOcpEkxPQY2KaFkJqkic7/NUFGhSz3rkyHpgUcaOMWz+DBU02rosASgUb9
	 hoDc/0I285O+Yy7cKAQAGHzWEk5yk+6Nxc7SobttTTy8FNoKdwaPMXMv1d2ahJ6S6PM/r
	 N+O0sEn32PzVUMm3At1cAzImceRAirpwtDS2EDrGXhj42ebs/n2Y0gMtbaRXcu/hiEruc
	 3PCXumFFOzdzZs2eO0ySyvjfhf0YyHXRiE5MmNiuG11BrBzyXh8HooLP5tgUyYYEj/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=nROh6Ens;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED238606A321;
	Mon,  9 Nov 2026 07:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED238606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=nROh6Ens
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=nROh6EnszJPw4NICV8O+0pSR6JIyPLtdaMlWOOENGKAyfu08ooNsxXsF/Edte180E6T06hsKdqrf+
	 inwZANXSoTRKbvbNbrQFY3QfVQS9DTN+UnZ5C/Bns49dUpJWKrjZ5TAlmyPNQl8G2HptQ0F2mQk71K
	 RH8lNsIvQFLXZ/dE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af171cd467-c76f3;
	Mon, 09 Nov 2026 15:10:06 +0800 (CST)
X-RM-TRANSID:2ee96af171cd467-c76f3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af171cccca-85742;
	Mon, 09 Nov 2026 15:10:06 +0800 (CST)
X-RM-TRANSID:2eea6af171cccca-85742
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] watchdog: npcm: fix clock prepare leak when setting timeout on a running watchdog
Date: Mon,  9 Nov 2026 15:10:03 +0800
Message-ID: <20261109071004.1506-1-zhaofeng2@cmss.chinamobile.com>
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
---
Verified against current upstream master.  Not runtime-tested (no
Nuvoton NPCM hardware).

Note: this overlaps textually with Triet Hoang's pending
error-propagation patch
(https://marc.info/?l=linux-kernel&m=178955112320092)
but fixes a different bug; whichever lands second will need a
trivial rebase.

 drivers/watchdog/npcm_wdt.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -148,10 +148,8 @@
-static int npcm_wdt_start(struct watchdog_device *wdd)
+static void __npcm_wdt_start(struct watchdog_device *wdd)
 {
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
 	u32 val;
 
-	clk_prepare_enable(wdt->clk);
-
 	if (wdd->timeout < 2)
 		val = 0x800;
 	else if (wdd->timeout < 3)
@@ -176,10 +174,19 @@
 	val |= NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
 
 	writel(val, wdt->reg);
-
-	return 0;
 }
 
+static int npcm_wdt_start(struct watchdog_device *wdd)
+{
+	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
+
+	clk_prepare_enable(wdt->clk);
+
+	__npcm_wdt_start(wdd);
+
+	return 0;
+}
+
 static int npcm_wdt_stop(struct watchdog_device *wdd)
 {
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
@@ -216,7 +223,7 @@
 		wdd->timeout = 2750;
 
 	if (watchdog_active(wdd))
-		npcm_wdt_start(wdd);
+		__npcm_wdt_start(wdd);
 
 	return 0;
 }
-- 
2.39.2



