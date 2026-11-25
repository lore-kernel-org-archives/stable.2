Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602860;
	b=vbE/rofxg171O3l6PPUOAradiEZSF7/mjb8Iu1CzLbnkYlN+M8UJ/r4v9/nNGrD9Y+RJ
	 Pk7+dSj2T2RJlgMRQE+lEYuz8CsotBHHQeTYbaNkibfN+n9GOIcyBK5CWFVD/hNahLt4v
	 SecQb0DY7U7Fe6ky8MwlXo+hHXvCcstlpHov941H9gS81ltvFyjdsVIfOP9EvTJe++2zc
	 oLGnOD2Zbc84OqK5NcyxajR3CsYHYX7rhwnvrfrcHaiEoMXegfms8QXiGDIqAL4fanAWv
	 DJLIknUULfhg7QFZ//hz+ME3LNRfSi/2SAamgheQJczKvicCh87HspbYk+wZnaRW4Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602860;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QTTC7qeWkG/PewkvHcKVJoc6BRuWBDyjHygo6uiOcQw=;
	b=trwtepXi8uDummyxwtTkjeMkvMTFacaTkrO06vbAMOk48KTdrVcgBdmnZbBARfbYagk9
	 VwFb56nK71SgzpjCApZQOhrRLXCm0szNY75ef6WSXokdv5BdqE1l9oYqyuITnIMaODXzS
	 3OXif3F4G7zP0g3xdJ+MgzuvTipH1sX0fZozQgv/Hn/xy0xMDban7+lGCUjWnZuskPGO7
	 /LZxivV+7YnNYi12vK1j/SzNAimGIIdpAmuq4OaFQ0n7E+pp9cGQEp+H6TKgKtSQq51S1
	 eCznisT1Nz93ic+ipCfH38EmcLRh3uqhDTJg9Nb+qhpjEMhQskU2bpIFEtur02RQ98A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jchN9Pic;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F4606A339
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jchN9Pic
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92AC1F000D0;
	Wed, 25 Nov 2026 10:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602860;
	bh=QTTC7qeWkG/PewkvHcKVJoc6BRuWBDyjHygo6uiOcQw=;
	h=Subject:To:Cc:From:Date;
	b=jchN9PicLR8JX1mcUYz3HDI/7CwNTfoI+HywOeBxrh/wnGvORKMFUxjRf89UyBKOo
	 bS05FH+632NP/JZwY5tWoGA7vAS7aLgm7ZH4ngtiQR2oXj/LeVOozF2TNhZkDWiud7
	 3J8Y4JBLxDfkgZdhACAWtzkxOHJVdwVmJHifBo4E=
Subject: FAILED: patch "[PATCH] watchdog: npcm: fix clock prepare leak when setting timeout" failed to apply to 6.1-stable tree
To: zhaofeng2@cmss.chinamobile.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:15:22 +0100
Message-ID: <2026112522-venus-heritage-0a34@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 57c7cbe21acc77291ec0fbdd4bd72aa259cf4986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112522-venus-heritage-0a34@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57c7cbe21acc77291ec0fbdd4bd72aa259cf4986 Mon Sep 17 00:00:00 2001
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Date: Mon, 9 Nov 2026 15:10:03 +0800
Subject: [PATCH] watchdog: npcm: fix clock prepare leak when setting timeout
 on a running watchdog

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
Link: https://patch.msgid.link/20261109071004.1506-1-zhaofeng2@cmss.chinamobile.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 4d8f21287144..07ea810fb8c9 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -145,13 +145,11 @@ static int npcm_wdt_ping(struct watchdog_device *wdd)
 	return 0;
 }
 
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
@@ -176,6 +174,15 @@ static int npcm_wdt_start(struct watchdog_device *wdd)
 	val |= NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
 
 	writel(val, wdt->reg);
+}
+
+static int npcm_wdt_start(struct watchdog_device *wdd)
+{
+	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
+
+	clk_prepare_enable(wdt->clk);
+
+	__npcm_wdt_start(wdd);
 
 	return 0;
 }
@@ -216,7 +223,7 @@ static int npcm_wdt_set_timeout(struct watchdog_device *wdd,
 		wdd->timeout = 2750;
 
 	if (watchdog_active(wdd))
-		npcm_wdt_start(wdd);
+		__npcm_wdt_start(wdd);
 
 	return 0;
 }

