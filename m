Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627086;
	b=sQ6zSEjak/UXPz8e4JvwR/Z7Ey2gx4cAbYgdcJZVuzv6yq/cIBKTEicUYc+udNR6d/X3
	 lCocO7ZuT5bfOwtlmfsO7RUVGLkS5i4Sbxls7/kBf3uacFb3DwOLM907j93ety7g+xKi4
	 vK4zMhRh7pyuK5na7ysJfAUkOeeYxr0DsBSd4X3Rx0a5pJmEEsxL90apRPdKsdgrp8PIh
	 sGfA224XlozcRjmJzr3DL96axXJO03WUh8SxIbOxmEh4HkC7XFN+RNwa9ms6gKSrSjVa5
	 BkGt04/CYvFL7UXdkA65y86Gx4RnpIm/SG7OSdUF0x7rkVmGE0FLhpaz2K4BGvB2QUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ag3gpna2IK1CT6z9J/WrksIYkU0A7mGWJS4oAZohEg4=;
	b=yHCOMUeBrT5Sc9JEebJkjYK6h3gOlGbM3gllC91f30qwltcuHaLMtPe3MQfu6A0s6Smf
	 XU/+qyV/g6SBKQZXt9BpNFx1ZzMDJmTguqjjwRe0DV5d4axe0gtGG7WKPAGSCToRXjRHO
	 CYjImvOgtQAjtNTnc4jLwhZyvQlVPKR03Wkro8xvtVCTxa9HO2NCoozmId65AThbp4xvt
	 1+U/f4+s4A+nAe8Xb3C2iqQIrvqdudesi2u26LC+97Kq3AcGoQkuQSe9bmh7vBsZ7mcOX
	 /QzCqCkexHNW10DM4/HZ2TISTC/mjSKDTd7yi5LBvKpX1QELdO0eEICGR4YmKpVF2WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alyVePcT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623D606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alyVePcT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF70C1F000C0;
	Wed, 25 Nov 2026 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627086;
	bh=ag3gpna2IK1CT6z9J/WrksIYkU0A7mGWJS4oAZohEg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=alyVePcTWs8w+V90lSPUNSCRXg4RUR/T8UgdFRB4QrqpaQ/8OFKBuuk1+wcQE8/uq
	 2j1Vcd/1SYAq6bNwsr6hupX3D6FKm6LWiOiwg+tg5gs9ERus30uED88TzOyjDUMpVj
	 1eTaNUNSzgm+CuWN4Wh0OIxTZgOFp0Wk9/RXZTV7fVIC+BS3V7DzhWsiKXj9FEuPEA
	 DM5JfO6fOFu6Qo5I24ZwzZKWsVDr7sRlSWpDaHmmCxoq7ymDWtc+5sitd3tFV57xgl
	 e9i+W5MtYCTpczy+lh2SWQEA5vX7kaVYgKH7f3hw7B3MrXASA9MUq4izk8CRzvzwX1
	 P4AW77VjxYVPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] watchdog: npcm: fix clock prepare leak when setting timeout on a running watchdog
Date: Wed, 25 Nov 2026 12:18:02 -0500
Message-ID: <20261125171756.959278-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125171756.959278-1-sashal@kernel.org>
References: <2026112522-venus-heritage-0a34@gregkh>
 <20261125171756.959278-1-sashal@kernel.org>
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

