Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618091;
	b=aa2XEL5TuOmfs7I9XFVR4c4X86IqrgufvvxogGIwmmxrwYiFLjGDx0VPf1huoq0KtTh8
	 xSEaKNwQz9ICd8GbuxRhxAp5EfS7kCs95j+whIHkaLYnzLHc1WMWLcg8/cOlNZLpcHQxr
	 4xJGP4+fFxo5MbJ6GLjOg4hUBXXq/r7uKdZwoDxspgIap+DzQlYeI7f08/FLpuXRYlF2g
	 Q09GWY2UB3schCdXm9dZYYguBKICwz4kgNSOVljaGWqFcJzbwwEuNn6Jec3bnpFQBJwIM
	 MCOfV9J6rfJsSEC3eh47eWbftf8ezX3egJDsJIF6igo7DvoSn3jCoQGOh4x68YAUGQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618091;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=LrVJ5bUTeXelwjzPn1QiWJn3910qYox79VQxI4uhKq8=;
	b=TCCmqy050sv6XxGqmP4fa+YOePX8UAepZZT75QRkm40xCbwHB/aKpl90eEOyDZd0rZu9
	 JOf/nX8zet445dqx6nyosmIIGtO4+xFaXUbiJxIr/UtvoPGcgqU8hKrwU/nX/xUlE7FN9
	 5sg/ksd8HyGlBiIODWhIQvHej2RHsxSBOu9amVTfMWcns1vJma4jePm/DQJ/B5A4xpuxn
	 3uCESwPeLtnLIskdJM1brfoTXFhl1vZlV2Agm46zzTRuhfO2L/FSCNFX31rOHPl2wk5yp
	 99yFnEi4kr6Rr58FgLjI9nkbSzDWdijE3k0P5xhzJZhoY0RnTx+tJvKi5MrfmkxHjpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=Ru43vj7n;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E196606A32D;
	Mon,  2 Nov 2026 11:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E196606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=Ru43vj7n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793618088;
	bh=gfnrYB9JtB2e/a9IuzBgQBQCCj0qqnxxJiDT5JEvrww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ru43vj7neDq5DvMIv385vkPGgdt0WkyQyf4RywiCQ+8Jtl/tedU905tEiV9yDaSLt
	 c57OAt3dni7VCGFGkd/NmTfSNZKO1nuruDUODI90ogBLDaI5n9/N+RPqqaD4m+gMo6
	 TRpBnhJW0tOVIgHcrV1qeOq0mrcFCcIEGaK3KVqySFGAgsxWln+rD0n22We6dzaqke
	 ZTgb26q83+eE1v4pUq/REXdCI1ssr9LrvNHRwJJiVlyf1G5wvvvP/KFqDDa+Uowexu
	 Cs9bMttnclC+2x+fuTmzpS+5npKN1oEgn43aRxIfEmuzNYq4Zt0AlpZUHXc7VMIRbx
	 8punPWQYW+/0w==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 59BA325AC8;
	Mon,  2 Nov 2026 14:14:48 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon,  2 Nov 2026 14:14:46 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.164])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jJ8Fy1xNMz3lJS;
	Mon, 02 Nov 2026 14:13:26 +0300 (MSK)
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
Subject: [PATCH 5.10/5.15 2/2] power: supply: core: fix supplied_from allocations
Date: Mon,  2 Nov 2026 14:12:32 +0300
Message-ID: <20261102111233.383-3-mdmitrichenko@astralinux.ru>
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/02 09:49:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207173 [Nov 02 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/02 08:04:00 #28779785
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/02 09:49:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Lucas Tsai <lucas_tsai@richtek.com>

commit ba61aed9a34671222d1149acfc2f0179a9ce7e80 upstream.

If dts property power-supplies has multiple values, then accessing to
psy->supplied_from[i-1] in __power_supply_populate_supplied_from will
overrun supplied_from array.

Fixes: f6e0b081fb30 ("power_supply: Populate supplied_from hierarchy from the device tree")
Signed-off-by: Lucas Tsai <lucas_tsai@richtek.com>
Link: https://patch.msgid.link/20260609114403.3896073-1-lucas_tsai@richtek.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-74271

 drivers/power/supply/power_supply_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d63cd225d4d4..b6ade977d63c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -260,18 +260,13 @@ static int power_supply_check_supplies(struct power_supply *psy)
 	if (cnt == 1)
 		return 0;
 
-	/* All supplies found, allocate char ** array for filling */
-	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(*psy->supplied_from),
+	/* All supplies found, allocate char * array for filling */
+	psy->supplied_from = devm_kcalloc(&psy->dev,
+					  cnt - 1, sizeof(*psy->supplied_from),
 					  GFP_KERNEL);
 	if (!psy->supplied_from)
 		return -ENOMEM;
 
-	*psy->supplied_from = devm_kcalloc(&psy->dev,
-					   cnt - 1, sizeof(**psy->supplied_from),
-					   GFP_KERNEL);
-	if (!*psy->supplied_from)
-		return -ENOMEM;
-
 	return power_supply_populate_supplied_from(psy);
 }
 #else
-- 
2.43.0

