Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626719;
	b=SCcZXRMD02Sxya1SroEELOvg46XZuWBK6Vff5Ryj69gnDZPIKI726TkqzwpHTEPt6oWR
	 TfApa4w2KSNk/hp+n+82eVk5llNSVqwVvcTJIFCrmxAxSNo/bGqpJVExUR3TtguwDV6Th
	 L105ASvGT5kN5XI7auG0w/aMPQk+nwuhLU/g2LbwfxCpvsEvxtEMd9W348PhNEhSJaT66
	 IqXg7h/nFNlZcm6wcPAC6/cXCaCYt7QlmhFk02vEfd6Kphni7iM/O3jERYaoAP/GDd0RT
	 Tsttmy2lR3jvrpCQxhKKt+G5CwpgFRco2SL1BVothJc9xzJLl5h2F1nAgx166oN0Mwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626719;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OXq4QeH496KxN/3PUTaOk/W24i54lVWNaBos6pdsNcc=;
	b=nJYjHGEMVG4R3hrO1Kui0GnY8LLZ/zDARcezhmOEL00VRpzlV2mS77n9UkRwqXlVj/bX
	 5i41jQGhPhHeNh83xb5NBhGzTU6YxM+1EsTrAvRtWaFl7NQS4z9NIx7TiXHBS7EzBte3W
	 6WU8Xu/6yLHzYVIBlD3jmc1+IFiRIUEgpnCtHzd65MjCGHGTqNsgKNppaWvZpc9aykrJ5
	 7emqyEvyupiVCbdnl3ycvkLMwTRzM78c8TehQT6/YwVsUVCW6n3dMhyAx/ZwtS+rNhwfC
	 290qyxU00ysBlbdeV14AHijE9iQmWeSnKf9eCpVtX7/lxr4Fgl6SuKKgV/B9zgPtiHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqeaH4pu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D27606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqeaH4pu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25D71F01570;
	Wed, 25 Nov 2026 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626718;
	bh=OXq4QeH496KxN/3PUTaOk/W24i54lVWNaBos6pdsNcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RqeaH4puakdxjBcwcWkMlq70ljvrIDR+Sv1c7H2w+n9GYFjU/AnJr4bSsfKlWTN7b
	 zFVoyiuidUPF34uzhybKCPKCsbACOgUxwOkA26w7WiXUE3PRquGrvq9GXmdZU4mVFw
	 QR5kxbh2YmMq4Jzpp7HY5z6nEHN9msV2viZen9Lcde+xgYwW9TCcGNEklKLCNg/XpC
	 M9gYGh3y5odfGng5c8vcFB6Kw6mlGZabqF8oKKnnJVMZCiXRyerLUmcfezcujwsmQM
	 UXKkmSJF5qGfdGXvC8A9WhwBDat9Ao3ST3foZCCqvY7vX8VAwgP3Rvw4p8YzBQO09o
	 wd+oz9KHRGlbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] watchdog: npcm: Remove unnecessary NULL check before clk_prepare_enable/clk_disable_unprepare
Date: Wed, 25 Nov 2026 12:11:55 -0500
Message-ID: <20261125171149.936763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit ad3746700ae238a96a9a4244d02a2e8eb00f157e ]

clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter.Remove unneeded NULL check for clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20250313084420.2481763-1-nichen@iscas.ac.cn
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Stable-dep-of: 57c7cbe21acc ("watchdog: npcm: fix clock prepare leak when setting timeout on a running watchdog")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/npcm_wdt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index a5dd1c2301374..e62ea054bc618 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -68,8 +68,7 @@ static int npcm_wdt_start(struct watchdog_device *wdd)
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
 	u32 val;
 
-	if (wdt->clk)
-		clk_prepare_enable(wdt->clk);
+	clk_prepare_enable(wdt->clk);
 
 	if (wdd->timeout < 2)
 		val = 0x800;
@@ -105,8 +104,7 @@ static int npcm_wdt_stop(struct watchdog_device *wdd)
 
 	writel(0, wdt->reg);
 
-	if (wdt->clk)
-		clk_disable_unprepare(wdt->clk);
+	clk_disable_unprepare(wdt->clk);
 
 	return 0;
 }
@@ -156,8 +154,7 @@ static int npcm_wdt_restart(struct watchdog_device *wdd,
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
 
 	/* For reset, we start the WDT clock and leave it running. */
-	if (wdt->clk)
-		clk_prepare_enable(wdt->clk);
+	clk_prepare_enable(wdt->clk);
 
 	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
 	udelay(1000);
-- 
2.53.0

