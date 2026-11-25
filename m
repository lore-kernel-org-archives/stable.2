Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626420;
	b=xKmKemyWWoEZChoyO8AgLrL3GTJZPX8gIU561MhE/N4tH928ZZUj+gv+zePnqW38a3dC
	 rSCPif/JmNOkygVZ5u0KHsHQQtFnfW3kp0KSomIcBDzop60D+1EtfYAkHjN5Jl6NHcdYS
	 RZqyQUvINgNDM0xsK55hy9h0ByKMyQEXX/Pm6w/UqyGhzaU+Dochmw/BDezgzNW6f0BdO
	 GvNH0R6fltoV2ZRs1S5NMB41I2FiX1hg5xEaP0bIFHvQj+AiR0DW6Eiq59Hx5giKy3jez
	 lZsSNJy0UvLuhbSibtzMH3WsiTOtXsnoK9o9hFYLMxIEdrL8AAAEI2qkIMsKvP6E/Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ag3gpna2IK1CT6z9J/WrksIYkU0A7mGWJS4oAZohEg4=;
	b=lPtl8rL72wOWUT8UAqMWD4/xCpZlN1iMi3JdiAFm/1KUCd8HS3RpV5A9i0Sbrxlvkww8
	 NNjlmacwI2fROyb8e8o6dWRrmGje6+m2TAFYUUO5ZjtA58PkifNySdWkIrpP1ot4KwXc2
	 DQ0RsTM4QGWobNVhU0OWP109xJDHNsJt/kiR4WeM3yjUQ/CVtmnfMnmSOdqgS7mmHH7HA
	 r2cbyAAdK4q6DdXiKw7NCQJOX/2f1zS7PYvW7wjAAEHc+r/36ZaakDR+KzeJQvocxOjMC
	 20TX15pvWBagNxouXb+Tsb+SajZp01FSL5eDCz35ZgYyY1MJ543k+4W1xREuCVEPreQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UW9vcOvy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFED606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UW9vcOvy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162751F000C0;
	Wed, 25 Nov 2026 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626420;
	bh=ag3gpna2IK1CT6z9J/WrksIYkU0A7mGWJS4oAZohEg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UW9vcOvy40MhnVqonHMrOEKC0uDXV2xEGk+Cf/q5j0cux/2HvznoDrd0Hi5CK67Ay
	 3I3AjLDxtUiBUKLP6AeOWBkdqovim2C5sVwR8lnHS79F4TzZwvzs6h93muAqb3JitY
	 zg2X+GGocXIsaXIPfxXYSrupjihqk8yXGTtZ/Ua4VhQu4e8l7oSPN8CrmKW12yI/Ue
	 x4XhQxta2zoSjVvGyZmkMtCY7nlcB76an/XSzrkPOqIRH7FagF5yNrlyW/QXvIdpF8
	 jchivHJZwKOFeA+aG0qIbqgxWQvtizh0DrgABeyNpvMQNik4+LT9sZ74ardGcc2OLS
	 2H7LiemNNnDQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] watchdog: npcm: fix clock prepare leak when setting timeout on a running watchdog
Date: Wed, 25 Nov 2026 12:06:57 -0500
Message-ID: <20261125170651.922997-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125170651.922997-1-sashal@kernel.org>
References: <2026112521-cartel-refresh-660a@gregkh>
 <20261125170651.922997-1-sashal@kernel.org>
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

[ Upstream commit 57c7cbe21acc77291ec0fbdd4bd72aa259cf4986 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/npcm_wdt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index e62ea054bc618..aff1ea1e6b62d 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -63,13 +63,11 @@ static int npcm_wdt_ping(struct watchdog_device *wdd)
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
@@ -94,6 +92,15 @@ static int npcm_wdt_start(struct watchdog_device *wdd)
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
@@ -134,7 +141,7 @@ static int npcm_wdt_set_timeout(struct watchdog_device *wdd,
 		wdd->timeout = 2750;
 
 	if (watchdog_active(wdd))
-		npcm_wdt_start(wdd);
+		__npcm_wdt_start(wdd);
 
 	return 0;
 }
-- 
2.53.0

