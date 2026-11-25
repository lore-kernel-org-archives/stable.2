Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626420;
	b=NbGtpr18ijaBkIv237oIvY3RIw/d2AUAtSRjesFCBI9bwDvBd3xcnWcsg5Dpbwu9DxOT
	 gTyJhjmap3r4zaxIrgKOzkBKx6GB3iZOvPxXiOcNe36ISmMZmaTPqAUlkoRdHsFEqwPva
	 9S6xuryvIG7bzdnyJnpgv7ADIRCu2hO4M1SURyZUjf/otnGNoTrkaMP9WduYULJes8bd+
	 zMuekbUCpTaWlAALP9rtFzF8a/pQyNnztWPJyM3oKyp1to5/g7mrs4ztA5OWW25GsaPcL
	 lta+B6b/f5IpJ06oTKgCv2MyKjqEb2FJnGweuNLzEmRgp8Gg4U7FKSjbEScIAkQEczg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OXq4QeH496KxN/3PUTaOk/W24i54lVWNaBos6pdsNcc=;
	b=MkJXtDvIyS0Hc3OInQvJXq2TWJRHoyN0kL5yZWhw3fN0NH0FJU4gFmecqllerrZlMCX3
	 O+aeBLpbQVeaxvOeZCELVgzLl5YlLqp9q8Vd28I7DIoJgwJX8QvE5sku10EZDMY4UvEsT
	 pTvNajVTqFq0k0a2qxuiFLDBU6uBZJ5cpKkFDUFrSk3H58fkvbmqQ54jlfdPWvU54fIT6
	 ON1LN613giZdvCpDiDTbY+krRLAt13ZyMGFbU5BEcE7RcBDaxGFKB++g7dNuqS1sJMgrY
	 FvB1OyX9xFbal6U9Wwmiznk/BOGXwFTfMLFgREshDwdbKdHSAxyjFUPfbOgX/4yIL7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmcQHNTo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD32606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmcQHNTo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6FE1F000C4;
	Wed, 25 Nov 2026 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626419;
	bh=OXq4QeH496KxN/3PUTaOk/W24i54lVWNaBos6pdsNcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FmcQHNToOy3oZzv/EmYuBdFdDK+BXjFEqQp1VvxpKyBj86uBTgqwfYuYTvFfyd50w
	 lztGqfXzvUNOS8lrPzUb/bBoq0dcpHKKrVCG5jns7NWNqdhv9xS3qYjFRFOhuSG2Rq
	 IWrgoJFpJV4H0d40pY90JUFqDhS3t4irw1MlaAden/MB5+bsnaoKZ2ZBayq02AWPCb
	 FHWRm8MRTEWiGu6SoSaupbEIjm2fobXv0YbXb/XjYvsap2rj0cEDEyZtFbXlXOGPX+
	 SleItuz3zwyCBIsQ4MLxC+Uecbr2ZXmp1Ktp63JZUir7L+15rINPXHFGnWc8t5Ke88
	 9M5xHFbXF6PlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] watchdog: npcm: Remove unnecessary NULL check before clk_prepare_enable/clk_disable_unprepare
Date: Wed, 25 Nov 2026 12:06:56 -0500
Message-ID: <20261125170651.922997-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

