Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627024;
	b=t6FzobszgXHmwfsh8L/Lpz2rkbF0x/o1tj8AO2CW1+IYdXzfVcoPrJz9IF52u7xcQQ+I
	 yjsvaJNn8lOM9kydRQ5WM5biBkW3UJZ9H7FcWHVQrptLj0LmcwUuk+9ODehyZ2SlBtTXp
	 vRMqwDn91pVBQ4/wMjdEpvz7/vDhunKztbPXsE2bAHTQTBpRHCGaY4XUxtR0wZMDwoDfb
	 zKc9j2juU7MwogxE6G1gJDKJk7J+I/viZRI8sjD/vul9b70PvxMYxds6S5qughU74Shh4
	 9J9dvMXNUsygfCJF/CcmF4MwGFvcuDHujAZTjtVgOVkJnFBEBmVyQmygkslPkCUtoRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627024;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NEezloxu3BKJpHEwEDxoAVZlc4svB1WwrzlqJPWzJA4=;
	b=DT1VXxKR8C9/dGh1NTJ2Y96uOXx4jEFVRfOZakO6OzlJZvt4fDe1qm2tEmoOEo+XWD05
	 wmbQwwE38vYXp7jhW91/pGQK6SIMhnhUPDCK+zS6dqEls9EEoEaLD8TEAMALcLVuYhfgE
	 2JMUcCeyPOUDBhs1x4vdFc/lnFXP7AAcQhZpvxIB6zX7I1VFH3S1CgCF2wbqeAiMWXETe
	 HL0gu03gVjY9js16AQTbHwIdU2BfaXqnEXcAgU48D3fW6308VsRCXaXqKWeD7uREXls9S
	 xfUbwgNFb7MD29ovEjVC/gttBWsJwRfFs4BXywwrEQwkfES7WGwQuMz/He4PhWAsUCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCgIkb+3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801B606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCgIkb+3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2F31F000C4;
	Wed, 25 Nov 2026 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627023;
	bh=NEezloxu3BKJpHEwEDxoAVZlc4svB1WwrzlqJPWzJA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NCgIkb+3/RgUmGv5FdSLVCGcSu5g6Q460MSVH0uwqdhci/jQPYi7o4JcWhu3ok+Nf
	 ChHSJQET1SL+iZqmQ+X+CXDM++hRVnwnjF9nSdXA+7YBY++swZGWwXzaf1PFTn/OXk
	 g6v9c0URwAsQiI4KZfJSorHPial/XkiEUlo0gXu2wzcDDxz4odD7qYLo0vRVAP7t/p
	 iCmOzsXalxljGB5EGTHz+2xvuNIPM/5BPdTtPK/EHQnRLddv2HqEbUq7oLxdNjoQAM
	 0phPm+aM3DfP/eQoL/coqS3uXjpRBQsKJtuvk8e0SVI0cPA+O4ATh58V8l8zwg8FI4
	 eHT1YsLK/OHSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] watchdog: rzv2h: Use pm_runtime_put_sync()
Date: Wed, 25 Nov 2026 12:17:00 -0500
Message-ID: <20261125171644.939435-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125171644.939435-1-sashal@kernel.org>
References: <2026112533-wand-debit-0e45@gregkh>
 <20261125171644.939435-1-sashal@kernel.org>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit ca800e625d18a9f5b19f94ab837ceb3fccdca22f ]

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

Fixes: f6febd0a30b6e ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20261001165201.763882-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: Replaced pm_runtime_put() with pm_runtime_put_sync() only in rzv2h_wdt_stop(), dropping the RZ/T2H-only hunk and its context lines because that support is absent here. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rzv2h_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 2342e29962d23..1ad1c326084fb 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -140,7 +140,7 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (ret)
 		return ret;
 
-	pm_runtime_put(wdev->parent);
+	pm_runtime_put_sync(wdev->parent);
 
 	return 0;
 }
-- 
2.53.0

