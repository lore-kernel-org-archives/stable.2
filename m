Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618013;
	b=4I4Pmz3M56P8K2gmZt5f4H6lK0IbciRBxS6yRLZjZ4xecIfeO1A/jYEk5lDIypFHC2ZJ
	 vgms84r8vhF6RIYy4FDhW05GM36kPcOvQ9fDj3QjAzzY7WkmPcMo7ECMZ5A/3VWAoSdki
	 npL86PtWYBNwEuJ2tHbMAnhm3EzqumfTb8LF3K5kgmLus57tPYkaIGQmLRX53N1g+5Ts5
	 PQxq9WDG4ljvt5GKgmNmXMp5iSlCDthZEBaCIqS7mI1m4KBs0fwuZyGUYVXb6TZej2pjt
	 xkgp9U1ybV1kM0qbveJfRAfDD9kyLNfBna0jPCEJk0hrR+vCKcRp76kwJB5PDB6noyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618013;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=fPxLKzQngSmhpGEmpcPmqT3xaAjPpmWlj2vLzbTbrtY=;
	b=iGlq+0zDJss3CaN0q4rGEOwaFj6uWMkaUwEls9LqwbDi68PB/DiGA0osY9TDfBwwfjD6
	 p8Awdm3fSZYwH1tuBvWJry0j4f1pgYqBqfu1f/u3n7M0vkf3HvDXOHphAOqDni/LV8pzB
	 pwS3EGtWRYsvuEF8nE8OW+MDIkw3T9XdqrgQGBj6K5NmXy/38zCtuFB6s3ExzEm/u1y9P
	 9ejoJYPAgMomszIWvj5hNwzFaox+vthLXBHtPwCKSW3d2H8qomYdZ4X4+jj7X/CidEZmq
	 9deEGJR/+D1agemR0AalQmRKcys6Mzh9I/Ri/E12Cl1cmYfLmrwe9eaNPw4SD2rF/Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=fHfXdDJd;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE9606A326;
	Mon,  2 Nov 2026 11:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98AE9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=fHfXdDJd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793618007;
	bh=IJd6X2hDY53ZrwhoBYD/jo7S7Y82woCMWb/aScTRUmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHfXdDJdF1gyljcVxbGlkellmCTHdXCjc5x0n0FQ+H/XO/LX/Ap6yedYK0sVIjlTX
	 BC38wVm4B6zjqCpUaWiwLmIBxqRdVjhPiSFLiqaD/pAF4s9ux1QnZaUKBWDMWsBEjd
	 GJxy1vhF9xjuujRKXDPEr8IMovM/PL0FrRhqm43UQXwXYyv4LGudkDASz+KiEfnHSD
	 PSkEQWlnJyCCCQdDEhwzgxTQwZSVhdWwwpDLf4MA+jk3FimM47FeRyuQzyYhql9l1y
	 5WiSxLtWUpjhNHnlJUyd71hzK3DQKOSWWkOZzTyQiD817/EfYXxkzwjkmcTW8zA0oT
	 2FcUMR5z+JU/A==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id BFAC12550C;
	Mon,  2 Nov 2026 14:13:27 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon,  2 Nov 2026 14:13:25 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.164])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jJ8Fw4lrZz3lJR;
	Mon, 02 Nov 2026 14:13:24 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Schspa Shi <schspa@gmail.com>,
	Lucas Tsai <lucas_tsai@richtek.com>,
	Sebastian Reichel <sre@kernel.org>,
	Rhyland Klein <rklein@nvidia.com>,
	Anton Vorontsov <anton@enomsg.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.10/5.15 1/2] power: supply: Fix typo in power_supply_check_supplies
Date: Mon,  2 Nov 2026 14:12:31 +0300
Message-ID: <20261102111233.383-2-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20261102111233.383-1-mdmitrichenko@astralinux.ru>
References: <20261102111233.383-1-mdmitrichenko@astralinux.ru>
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
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207173 [Nov 02 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/02 08:04:00 #28779785
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Schspa Shi <schspa@gmail.com>

commit 966f6551173ac46183db6621451702a7e4a3d4b5 upstream.

It seems to be a typo, there is no actual BUG, but it's better to
fix it to avoid any possible BUG after we change the type of
supplied_from.

Signed-off-by: Schspa Shi <schspa@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: ba61aed9a346 ("power: supply: core: fix supplied_from allocations")
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Prerequisite for the CVE-2026-74271 fix.

 drivers/power/supply/power_supply_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 61ba2b343b93..d63cd225d4d4 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -261,13 +261,13 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		return 0;
 
 	/* All supplies found, allocate char ** array for filling */
-	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(psy->supplied_from),
+	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(*psy->supplied_from),
 					  GFP_KERNEL);
 	if (!psy->supplied_from)
 		return -ENOMEM;
 
 	*psy->supplied_from = devm_kcalloc(&psy->dev,
-					   cnt - 1, sizeof(char *),
+					   cnt - 1, sizeof(**psy->supplied_from),
 					   GFP_KERNEL);
 	if (!*psy->supplied_from)
 		return -ENOMEM;
-- 
2.43.0

