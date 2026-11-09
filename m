Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220239;
	b=IUKX+/rR33KCgfHEHpkcQv9pDzsDEkS/kwuPOrVNhcB42G+jFWv0fHtanlKSjmSJ9Ppb
	 h/f72FrnNTo2F7uMWUs2EzxtVaYHIq1fs/QRRrJunn/S0gH8Kdjz9MuJsSInB2j+xn2ON
	 QXXIMmk2vjUEBVy/e/8OuSwPgk5+CU7vYDJ789qyqcphEUg50d6B+ER3fURzAAEpQituv
	 9xYvlZd+mFSKLGGoure+Hz3klxr61ZjKvMBTsuYTHh/W4IhtMfnD7G55c1fODVoxIfmqf
	 5B4e3xgUbf4S9Gwahcxs9iVfERd+Eid3jKXav/DdegACs8kDh938AHp+4t/N/8RJqkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220239;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=N5fjvvMg5v+YqmRbm1DHrHR2Quq9Ia0pKK7R5BqyqzI=;
	b=ZW3bQBmpCp8t8rh5gcoM0d+Bj0HiwwuV0z8MfU5gfZazmpc3/xWv5GZZdeX4qifKRnVg
	 GHB+M/cZz2ZgV6PPS242HnVotiQfYMKK+InyPpAQJ+P9fpO0DWTB/FPGaooYJsmpaHqI+
	 xEMvNMGj8++DA+hNd8oe7U6nRwoLNwrbHwk/Y3mRjvuQEDkFKCsy96fs7zY/GEQwYiHZ0
	 wqYeHSFcaOC2hRJbAtvjecaEm6+fxR5QnPFh/NTzGcLDFQEXt0jV5xufs7VPN2HKhVNEJ
	 QHB6WFKaJbYBygDgRrd8czuv9R/xmUk0j3+s4FTW2jFnQlwPVFCNJ8toTIKhjwNQw5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=s+stk8VQ;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB9606A321;
	Mon,  9 Nov 2026 10:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBEB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=s+stk8VQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1794220234;
	bh=yTeRKXu9YZgUz+dbgWl4/sCZ4/3dKWKlHh3NLNjeWsw=;
	h=From:To:Cc:Subject:Date:From;
	b=s+stk8VQuKT1y1LGI3WuOadMU7yH2fUe6nkiErYHvrLwd3LGOavJshhugrWPx9UxA
	 gwRMPKsFlVk5boHImKOh8uKjdCUUm2E7nr1SO4FY1GTTI21JUtoVWeGTw0ILRJwI1x
	 qhsvUSta2xhEdJ35gzZeUwaAobiEnMLzx7S5mqwwNHkv9jF6MjnVb6DF0HlsvWxU6Z
	 cE+7esN6QeWj4gtkyiY+FFOsxmYfDoSJBiil3+lA4gdtNsSN95EOmbHuZ/+v5Hde4P
	 VboObL6l2m4nM/wnV3uRRtYHsTJtX+b8MMfgBgwKA6CN9eU4qvnLAEXgZ1YV0cLxcv
	 CyNzRdy03MaAg==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 532DB25549;
	Mon,  9 Nov 2026 13:30:34 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon,  9 Nov 2026 13:30:31 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.16.213])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jNQzC0xjXz2mqy;
	Mon, 09 Nov 2026 13:30:31 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] net: phy: clean the sfp upstream if phy probing fails
Date: Mon,  9 Nov 2026 13:30:23 +0300
Message-ID: <20261109103024.1413-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/09 09:26:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;patch.msgid.link:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207345 [Nov 09 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/09 08:07:00 #28826469
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/09 09:26:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

commit 48774e87bbaa0056819d4b52301e4692e50e3252 upstream.

Sashiko reported that we don't call sfp_bus_del_upstream() in the probe
failure path, so let's add it, otherwise the sfp-bus is left with a
dangling 'upstream' field, that may be used later on during SFP events.

This issue existed before the generic phylib sfp support, back when
drivers were calling phy_sfp_probe themselves.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260604092819.723505-2-maxime.chevallier@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[mdmitrichenko: Adjust the phy_probe() error-path context: 5.10/5.15
 register LED triggers only after probing succeeds.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-53232

 drivers/net/phy/phy_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 665952e64e9b0..2ba1f1833336d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1275,6 +1275,9 @@ int phy_sfp_probe(struct phy_device *phydev,
 
 		ret = sfp_bus_add_upstream(bus, phydev, ops);
 		sfp_bus_put(bus);
+
+		if (ret)
+			phydev->sfp_bus = NULL;
 	}
 	return ret;
 }
@@ -2903,6 +2906,9 @@ static int phy_probe(struct device *dev)
 	return 0;
 
 out:
+	sfp_bus_del_upstream(phydev->sfp_bus);
+	phydev->sfp_bus = NULL;
+
 	/* Re-assert the reset signal on error */
 	phy_device_reset(phydev, 1);
 
-- 
2.43.0

