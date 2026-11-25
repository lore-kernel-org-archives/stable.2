Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626720;
	b=T3XXm6/s4kgR291hrhGho3MX1D4XNIx+7cvRBWmzoNT21vCT5UfdV2qB0vtywlkO/Uq7
	 AgfipNLxwy+FoXCw1hQtDVfbzE5fTLM/U2wltV+hMeM2dEJXEyMXkott6Le4AN7ojRyxe
	 YyOI4KwwrBMkMFuFAUv9ctOS8ycUooH7o4sL+98VPt+wB0WSGctpBtzARIm+2mqchor74
	 /9C4HLZRShvDFpfd7OMeUEMLnxf/NUW610zASgjgU/GU2kBhF4+C/rKyBvt2CYkS/uzlb
	 cvEQVM2Hc0jrymD04GKmoyXI9Qc9lt+3marFOxH85yZtQ+htEWr87t8KkFuLeJju+ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626720;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ag3gpna2IK1CT6z9J/WrksIYkU0A7mGWJS4oAZohEg4=;
	b=Hmbpaj8NcNsmOeaLa9NJ1+x+0s9utYGL+mpB8yyc56cVLpZCMAw9U22nChfyZ36KUcp0
	 394fMii+A2NkAWTMcS8nJWXQ9+2fdMDWy4FNvuCUothOfuvQOXt2E9QR5bfkFKyHNjiir
	 lGzhyz6xgnCQdcZkJCi0CVw2bMKxl9M8Q9C/kAS8VT9/whTC9S7COjSd4Qj7raXjur4yq
	 Px2f32FoJo8ONRCmurUhuBCMJVd+slTSBr/a/jDhsMb8DKb5HrXeGRHbLD/3R1Q/s9fZG
	 NgwcPQMifUIz0OAOOwXz+eEFP+r4lq5AwTs6Bq0ZVEvDpCcNjoGBRrcg5texSA90d6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrKt5ibN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B48606A6A5
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrKt5ibN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9D51F01572;
	Wed, 25 Nov 2026 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626719;
	bh=ag3gpna2IK1CT6z9J/WrksIYkU0A7mGWJS4oAZohEg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrKt5ibNGL+zCd/aT+FB23Mdn+aYN5CFqE2V65L0v+iNozUT+i08JhQ1VcmQMOG0R
	 HNOvOnvJovfP+eiC0TyKrQEU0xnmbeVAXV9UaHfFUUQh/co6qUeR6Wc9evcyvEdRGK
	 IcSPHe+66twJsyQAB5JyusPlQG21kCx2fc8mfWaLV8o3+HVN2Z2RkbKSUcoWwvOo62
	 g7Kjn72sOlbk4vVqPss0zSyDTAuh/Un1q0MiHRVB3w/OAsutnk56u+1Hiot8PLHld8
	 gq/F3HuObYbL6ULKzOyGM6nYZb5tXd1sldDa8yq4PVqNk4c7ZuPs4NQwO8eLL4ZKqx
	 VpqkzLXO+3L5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] watchdog: npcm: fix clock prepare leak when setting timeout on a running watchdog
Date: Wed, 25 Nov 2026 12:11:56 -0500
Message-ID: <20261125171149.936763-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125171149.936763-1-sashal@kernel.org>
References: <2026112522-ocean-schilling-8a8f@gregkh>
 <20261125171149.936763-1-sashal@kernel.org>
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

