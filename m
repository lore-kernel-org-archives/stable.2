Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627085;
	b=i7Xr4qHOAdjDcVc0lG0AI9fmvM6LPTRPf4skseWib5rSLY/lrlitVWxcRWmtRGc3C6wf
	 Y1SNBX9tK/gejzgUetWGSZIT7XuB4cR0C4xS5ccaTdI7EbfU5Mc/vlkgnQK5LpTihElKf
	 caRM+6j6bUZYamhkVtz9hiUBNp7ORPdKK77inQEpCoBCxQUnrTalee0GMuJrQP2t/p/xZ
	 EZc97mBqT/xWWG8asbyDc0E1TKOPKMJHnmv5pcV34vccwNVTkvVSOJz9m4Rl8ReH49PTO
	 j/UAANqRfDG2wti7cCPv90+HwkSBBiHeOZcWlrBYqQzXu0izUNUulZhuqLCPihkAbew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627085;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OXq4QeH496KxN/3PUTaOk/W24i54lVWNaBos6pdsNcc=;
	b=sQk8matPRDprDUlLTWWoNINpuwRJHbJr7PX34JvRvsAgOkuS8qwwzuW47hSCq9GPKXiA
	 E1Po0X9t3mI6KG93WbrvbaYiucwDWWpsjdlZBGJtn5Ti8Gs0qXx1IfEQvzai+XSGoqjEx
	 z/tOPS3W8Zx8iVwesma3O12PZE49s/Zs6RPYIqY1/9KvAJXkCt4j0G+h5wXvvnW1KOYbG
	 eepwgUnj5YK0FpOZZKSU3lEiZvcbvLzJN/HHHutpCKchcL3o76ilDh1rHAOO/2RwgO+Vj
	 +sSi0rdZo4+AQE3bFeGk9oC9wcfYwvzUYeBrLiI6ywopeq80aXDu9iT1dy6/W9ZlKbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHpLnPwI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D32606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHpLnPwI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4834F1F000C0;
	Wed, 25 Nov 2026 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627084;
	bh=OXq4QeH496KxN/3PUTaOk/W24i54lVWNaBos6pdsNcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RHpLnPwIqD1T4vB63XWXWcxa1qeTKsVnx+TECfOBgjNTx6YYxyJi+XaE+oZpyTeyD
	 aRitgYpWCOyrHbxW00u+IqJn1F8GOfUjZKNnIn4gsbKJsjHNBDSZ/wT9yq5uR9xxkA
	 gLt6ecoFkcNCsQnaZMWFGj5my9sRdQOXIQSNTY7xxnb4DixkOal4CmVFfhb2wLfrr5
	 S/eWo9a4HCOBco/eV+gET+NbJLcgdqQu8152YHdXZlhOVJ1vIDjKmcD/OO8PttT7l0
	 flj8MDYESZxWeX0scwINcGD68szSb79t0iNVHRDeFnC0DK1hRAqgRQvyUc1/2vRZj/
	 OowxmAvSI3n+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] watchdog: npcm: Remove unnecessary NULL check before clk_prepare_enable/clk_disable_unprepare
Date: Wed, 25 Nov 2026 12:18:01 -0500
Message-ID: <20261125171756.959278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112522-venus-heritage-0a34@gregkh>
References: <2026112522-venus-heritage-0a34@gregkh>
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

