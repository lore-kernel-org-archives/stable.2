Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6F2DB7BD;
	Sat, 13 Jun 2026 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781361187; cv=none; b=gO5yALV0yTJsPFa33FW6SkeYD/9+/43YVJVwT0uHzjtIrLPL6CaQUtJ2JL7YZkPVgSezN+L4mgSAZ1h7Ob/nlzD+79qbp81Nkfp3C3bo2OidggcEvJMWt7XwERPn1r07smgmDpoT4R+QLKQpUxxGVt38+z2ZJqxfu4xbDfOzYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781361187; c=relaxed/simple;
	bh=cKT2V39sibq7BBel9+6cqGHYCp/vctmYLYjWTx6XOX4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e9ShNFhRcBGR/tgEXMHYySPF+MfwTzPAQ4roxlp8/7ZzQJt9BPY10CBznchO/gezPk/GQC/t/zX5Wkd+oh2JIhAWA/MV3N1hqtHTZXQ/p5/R3Hs1u5TG2gJ1rx/pDDpwKOFD2XtB6laZu59xU/+MjmyOyyFKJX6Ci2QwPQXTw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZMyDIElr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dCske0KG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZMyDIElr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dCske0KG"
Date: Sat, 13 Jun 2026 14:33:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781361184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BB/EroULliXHgeVE8n5RhivSFf75axtaoX3gn6BuPxk=;
	b=ZMyDIElri5WBrURnpWI0Qr7lE6jTlTu7RNFJtIeZ9QR17K55qMaX/a+bG4hsiNrne3vCjO
	/rpGrpPxh+xx6HIvTsBZPppvY2+6d0oKXeRTVs4dnGXSwkVJ7kbFVsAHCYncYzEyEMaYJK
	bHlDtacEWphuwSpPlWO+/jFoCcbsWZ8ZQHik5n+sInA75nQl/v7mrZOuWnbz0v7VaxiILd
	LqbpZqLciDoyn8/zmhSx8bYyHLmA0c1tWAF1DdYqpAnF+3538HCuK0OxOlZGNrMKLvotRh
	0KlvKrj5mAWGK2fFPLzPtAtsPOTVpIr+96VnsGZArWcHo57LnEWi/qiWPjyN7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781361184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BB/EroULliXHgeVE8n5RhivSFf75axtaoX3gn6BuPxk=;
	b=dCske0KGXlmm8o3s2Ef8iascQlzvc/oGhi760/BwwW9MjT1rt8lI3Bt3m4rDHN7DSREV7z
	P/IFyM6fbPRwaGCQ==
From: "tip-bot2 for Kartik Rajput" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186: Fix
 support for multiple watchdog instances
Cc: stable@vger.kernel.org, Kartik Rajput <kkartik@nvidia.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260507154557.2082697-2-kkartik@nvidia.com>
References: <20260507154557.2082697-2-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178136118320.1650852.10754830901767426383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     ca57bf46e7a94f8c53d05c376df9fcfdcb482100
Gitweb:        https://git.kernel.org/tip/ca57bf46e7a94f8c53d05c376df9fcfdcb4=
82100
Author:        Kartik Rajput <kkartik@nvidia.com>
AuthorDate:    Thu, 07 May 2026 21:15:54 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 10 Jun 2026 07:25:08 +02:00

clocksource/drivers/timer-tegra186: Fix support for multiple watchdog instanc=
es

Tegra SoCs support multiple watchdogs; currently only one (WDT0) is
used. When multiple watchdogs are registered, tegra186_wdt_enable()
overwrites the TKEIE(x) register, discarding any existing watchdog
interrupt enable bits. As a result, enabling one watchdog inadvertently
disables interrupts for the others.

Fix this by preserving the existing TKEIE(x) value and updating it
using a read-modify-write sequence.

Fixes: 42cee19a9f83 ("clocksource: Add Tegra186 timers support")
Cc: stable@vger.kernel.org
Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20260507154557.2082697-2-kkartik@nvidia.com
---
 drivers/clocksource/timer-tegra186.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index 3555588..bfe16d2 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -149,7 +149,8 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 	u32 value;
=20
 	/* unmask hardware IRQ, this may have been lost across powergate */
-	value =3D TKEIE_WDT_MASK(wdt->index, 1);
+	value =3D readl(tegra->regs + TKEIE(wdt->tmr->hwirq));
+	value |=3D TKEIE_WDT_MASK(wdt->index, 1);
 	writel(value, tegra->regs + TKEIE(wdt->tmr->hwirq));
=20
 	/* clear interrupt */
