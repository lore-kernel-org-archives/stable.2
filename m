Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795805107;
	b=zMCBSMF6J5gojVDt73jNLmV/foyVKfndqpKn9ZxH17YauK4kaNka9t8O6sqlyC4WKeVu
	 +trcUWBDmuI5iaczVQiqklt2B2WrglpxI/f05LNhJ9H4t6aWZRpJZYeuKJlvlmKw9KnQJ
	 3OxeNFkKYc9W2Wnk7nKWz+dMZgj63zxXAuk8o49s+DbV8htv2tK13ADNVWWkMfi95vi8i
	 8FA4llOOBsPdqY5aGUlBV0zVLHjk5IHmg0aMsInVw50zPrm6xY3xMoKnDJA08lDHFxYZU
	 YG7Rf5iJRiMQPPL6dzmz1HNi+ikgPkjL6EauVkTovaYSM+ATbClFfHHUk1VoMtPNfZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805107;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oH95esIlVAY1btOFQI3/FDK8yF3SFAy93tWQcku0JF4=;
	b=J8lPR9qaftTZlkyjFrWvGsWMPXZHVjkjsqVTpJjgnHHroadhEowydx3Lj9nyoijQBZRD
	 zq6+TZZ/kYxkheh3qpuDUKS5znOeDnzW8owZ9kIqmkD3miKK6bbJ/fAvz3QJvgqpeGL1n
	 i+2l86VC9Zt3HBGDhc8n3lOHUndssNeGlbEWY5OnfMxtryz78ReRiqWMNDvdfDM2ANmzz
	 HQ9JCqkqrzfdvFqEiAjIUWS4SsznUwKwlHHSAFNoXsQSk6oeyc36GDCXwI/xSNqazp5Kr
	 7l74NOppJGx/Xp0R0rj+qCXYa8wHxGjG477IZvg9Ofpr7+ksMjlz7xDwx4TsBIFfw9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CozU2/NJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081A606A32D;
	Fri, 27 Nov 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CozU2/NJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795805106;
	b=D6UewTDHkIUiYRd6YJb7S/VRhG9bRasPWi8HCovPrKYJH7rh2hVDd/uZ8b7bwg/OTLoN
	 szRNjUjj7NR8ImNBcTSZCJwNq4I0c7tJg1tiopZDXRI5uZ8HyZ76SjZyZGXhte/RkVIyt
	 /wdKjtvL18g6UG1VPcbBLt9X+q03PAGan0ETwe12wd+IeQltmFzbm+d8/uhGGgOqS4tb3
	 bSs1GTWYrdR/nPL4SWuQ4U//wncoXGDj2/k06JdTkUNo0orq5WXthJYW/h+5G5RTyoKfy
	 +x+T9F6cnZhnqATIJtevxAR+9usmWTlT4hEUxvFI6oOdz4SVeODp0ZRXQUJfWkEFrEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795805106;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oH95esIlVAY1btOFQI3/FDK8yF3SFAy93tWQcku0JF4=;
	b=uq/XuKHQnlvWOZ2sE2/a1GLP3UjzM6MCWQYgtYHM5wChE6t5iL0gR+YP/QLfyDHeGGmG
	 8K3nJhDKm3Og3MWjRvDdGf3jll3Wud2sjbIbVyMhEkzZmG2t6r9Q6bFtF0Jv7dTNfcTvz
	 y4II0dJ8ZKLnU5PXEw0u7oryB88jI+srvY/iNH+AIORQBjBJbQgQ2nFdH8M2N6QbvpOHQ
	 oU2VV+rRT0TcgjjaTgp3QZLS4yhDG1mHdkWgwGIZ8dc3M+fU597lMqPBfHqAJ3UV2bkJH
	 ql5TROTbv5C0oK1FYkwjF9zwn/k8gHpUYGYr5cvTTbAAZkCeE7XclSnzWW7vShJ2DOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A99B81F0089A;
	Fri, 27 Nov 2026 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795805106;
	bh=oH95esIlVAY1btOFQI3/FDK8yF3SFAy93tWQcku0JF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CozU2/NJCwbiLDbobKWh30nwMnovYj/49SNawZ+gEWL1wT20PPVfor2hW0gypLvKc
	 +Or4AZ/7JnWke6Ku/af0MeRvsej4aIhu55FlT5tyTaZRACkpzgo88k28DmP5FXiMYp
	 9ZRMkGSW26QivNr/fT125pmJ6h4BpX2rXe5TS3WHUiW/C+fcG1EYRoIb18dOSK2u5A
	 v966XqDJp0N/uaG3P4xbyQI92XnfnadyeEVK0Pyc0UqMWXogDblKoEJKDrBgNKr/ji
	 wGhmyrxtruA9yfgfAWkrE2rAZqhzgwDytrKGL6MS0Xj6kYJVgey1jUF7k/T4VcshbN
	 rPNmPkrBF2D+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 34DC44DD3F;
	Fri, 27 Nov 2026 18:44:58 +0000 (UTC)
From: Willie Wiholm via B4 Relay <devnull+willie.wiholm.tritechsolutions.se@kernel.org>
Date: Fri, 27 Nov 2026 19:44:56 +0100
Subject: [PATCH RFC net 1/2] net: phy: dp83867: set INT_OE when enabling
 Wake-on-LAN
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-wol-net-v1-1-769a2aff91df@tritechsolutions.se>
References: <20261127-wol-net-v1-0-769a2aff91df@tritechsolutions.se>
In-Reply-To: <20261127-wol-net-v1-0-769a2aff91df@tritechsolutions.se>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Thomas Haemmerle <thomas.haemmerle@wolfvision.net>
Cc: netdev@vger.kernel.org, 
 Willie Wiholm <willie.wiholm@tritechsolutions.se>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795805097; l=2238;
 i=willie.wiholm@tritechsolutions.se; s=20261127;
 h=from:subject:message-id;
 bh=B87NcVtP8Gbvppa+UGSk6FssaUMl/qL287zqyqf5hJM=;
 b=897rzI3isKP0tS/ULgHWxEmbuqqUDUWhC52++aHyXiF+YZ8xEcDarLvBHO4C+CaV/Fw73uSCr
 KtGYGDnv8JMAV30Rr+Sqo11LEuY51msyXjLgkL4zdBSs5uLw/laNHai
X-Developer-Key: i=willie.wiholm@tritechsolutions.se; a=ed25519;
 pk=+cNLoL8211zFctWUX7P+l/TZm0pSVfYhLugt3NOecW8=
X-Endpoint-Received: by B4 Relay for
 willie.wiholm@tritechsolutions.se/20261127 with auth_id=1669
X-Original-From: Willie Wiholm <willie.wiholm@tritechsolutions.se>
Reply-To: willie.wiholm@tritechsolutions.se
Content-Transfer-Encoding: 7bit

From: Willie Wiholm <willie.wiholm@tritechsolutions.se>

dp83867_set_wol() enables the WoL interrupt in MICR, so a detected
magic packet is signalled on the INT/PWDN_N pin. That pin is only an
interrupt output when CFG3.INT_OE is set, and dp83867_config_init()
sets INT_OE only when the PHY has a valid IRQ. Otherwise the pin stays
a power-down input and the WoL event never leaves the PHY.

This happens on Intel Elkhart Lake boards with dwmac-intel, where the
PHY is polled (no PHY IRQ in Linux) and INT/PWDN_N is wired to the MAC,
which raises PME to wake the system.

The firmware on such a board (congatec conga-SA7) sets INT_OE, but the
global soft reset in dp83867_phy_reset() clears it on every attach. As
a result the first suspend after boot or after a link down/up never
wakes up. Later suspends do wake, because the firmware sets INT_OE
again on S3 resume, which makes the bug look intermittent.

Set INT_OE when WoL is enabled. When WoL is disabled, clear it again
if the PHY has no IRQ, restoring the reset default. PHYs with a valid
IRQ already have INT_OE set, so nothing changes for them.

Fixes: caabee5b53f5 ("net: phy: dp83867: support Wake on LAN")
Cc: stable@vger.kernel.org
Signed-off-by: Willie Wiholm <willie.wiholm@tritechsolutions.se>
---
 drivers/net/phy/dp83867.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index b4b4931c6f8c..e3617f01b5d9 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -233,6 +233,8 @@ static int dp83867_set_wol(struct phy_device *phydev,
 			    WAKE_BCAST)) {
 		val_rxcfg |= DP83867_WOL_ENH_MAC;
 		val_micr |= MII_DP83867_MICR_WOL_INT_EN;
+		/* WoL is signalled on INT/PWDN_N which must be an output */
+		phy_set_bits(phydev, DP83867_CFG3, DP83867_CFG3_INT_OE);
 
 		if (wol->wolopts & WAKE_MAGIC) {
 			mac = (const u8 *)ndev->dev_addr;
@@ -277,6 +279,8 @@ static int dp83867_set_wol(struct phy_device *phydev,
 	} else {
 		val_rxcfg &= ~DP83867_WOL_ENH_MAC;
 		val_micr &= ~MII_DP83867_MICR_WOL_INT_EN;
+		if (!phy_interrupt_is_valid(phydev))
+			phy_clear_bits(phydev, DP83867_CFG3, DP83867_CFG3_INT_OE);
 	}
 
 	phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RXFCFG, val_rxcfg);

-- 
2.43.0


