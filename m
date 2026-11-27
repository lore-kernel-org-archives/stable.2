Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795805110;
	b=MTbDmOsY+AkU1RkL438tq+3nFIf6vRMgeMLl3HKfIKAS12nvLbEpxPZHt/Ql50Ctq66N
	 u9opXV+JZqRgSqU63RYCbxciTmdHLDcHkc8A7aIsZETtNHRGTc2C8usyymTXhHsuZ672Z
	 YtKC6mJXwmim971sjTU0w6Maip5XfjI41VGiyvOELGGw4+ieOTqIfQJojxIy2R6NL9glr
	 mOOORHBIezYT7sANWF1ILOyyFzOROY7ygVZw5OlqJ29pg40JlPLMMQMy1RdKmtNOLy6by
	 1x8XAWJlVbsSFirAVP/CJ7A3uV0wHcwJHHcMBZu66WGjiVIHgUZE/Pbw9k2WYDwMsag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805110;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Vqm6kDq6SLnWsSXCALjlpHMEGWdLueHGFZDMxMHGmNo=;
	b=dGHDPIj/3fBBcyOMhc0MDfQe31/81EY3U6Eq4umKCeYGmA0LBLVZcd6pr1jbCkUAqr7F
	 Ra8vSJNjGI5ITgripMgBFLaV4N+8P6mzwz6ME3X5nx4BVZKyh19gnguskBdWsVjam06zH
	 bS3zdp6armJ47/AYEOwgusDlkB3hn39xJ0kFvDe/UYt4UEY//vXBrC1DRImOyDpEzebEJ
	 nzueTA6k956CIRMqpJv9f7XYmDhl0X8LdtOpYctZ9SJ323hZz4K8sKI9c90o6xYeWiDQv
	 6RbiEaL0A+65FKVPUtMT6EoRylfoW4bOsWheJeJsrmYA3oIa8QV5pJflffOKShy1pAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSPfhfNO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F69606A323;
	Fri, 27 Nov 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSPfhfNO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795805110;
	b=zqdz2EI/RG8JRRWNfSFMjr1WK46PV2hzb9Ou40RDPDebp+hseCVTfxWmjnEs5kbnrPoH
	 RLoC2sprDrlb0FgUCyHZ6B8etDjnDpsK0W+pXkIAggY3V9/F/FppPz7I/pyH8VZogLnNl
	 +ULscpebbrE2IERS2jQGFWwqdNuloEU52NK8qifM6aTWHgcJ+OXEUnRqjl+ET4857PHvi
	 sFLCf6JXTJFDG23yZmyDcADnuX/bp3bNcfZ3DUJkyCu0m99HLZBssfifEkxhO1YOKUfK2
	 ZODSeZB9/Su/ngv598xj0j5E80cXuOkCIGMYZ+oB3Aa3fNF/L0iFsDVhN9SNObqCvyA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795805110;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Vqm6kDq6SLnWsSXCALjlpHMEGWdLueHGFZDMxMHGmNo=;
	b=l2mH7hgbU4lsz1u792qxVjZHbrHDo1beMyq0Iv03q6JNnc1WGsPAD9T3caksYToG8b4z
	 Ym203AL/dt9PXRM2mNQHF8UNpZwjcJelrwQR90YIfkiG3bHxvJQ/7QjOpGEBpZtA/AwMp
	 VLAljjtSXcZSngUlxuBBQXS198eblECluw72K21uZf0K4a/HemVzm1IbdzacWi5t3bvIH
	 8cKfsT+3qp9BFFcmOR2Tw6DAMkpj0b4SWQCZ0QWDps04DmcBApBSC7cgoDhQNmACwF9ou
	 S7ICS2k3spgD46IVB3vl99Oh27XUe1lO/F8DrovVzkBzxcqw//Eb3C0qRX80Do26P4A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CBDD71F0089C;
	Fri, 27 Nov 2026 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795805110;
	bh=Vqm6kDq6SLnWsSXCALjlpHMEGWdLueHGFZDMxMHGmNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HSPfhfNO5kxm3dRLp0yCSUFY8bD1/P4mZl9Y/SZxaJKZL05qsRO9N+jnWyspNDtss
	 R5nSb32YsD5MKWYQ/GSMW/CmRs1M+PGF5XthopSpmue3zLZUHDw7F46xCgZ6+vAArR
	 fbS9fo4cQExrMfZNFD4rW0aCQ7Y4i2Ud/4sL27bBVUY7l1hBKweSXlB+vovPTlA6ha
	 e9DvkGEcvSGUliW7uYHklkftDUkp84lwI2vhFL0eeMsXDBNvftrtauZjXbmQbG02SZ
	 wgwSiAwcgUdrNj0jZk/fX/7kJ79qsFoGNATqmYJO7inVLL5gAPHP7l+F79D4aYrC/Z
	 ZlBsbFNijUO1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 546DA4DD3B;
	Fri, 27 Nov 2026 18:44:58 +0000 (UTC)
From: Willie Wiholm via B4 Relay <devnull+willie.wiholm.tritechsolutions.se@kernel.org>
Date: Fri, 27 Nov 2026 19:44:57 +0100
Subject: [PATCH RFC net 2/2] net: phy: dp83867: clear latched WoL interrupt
 before suspend
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
Message-Id: <20261127-wol-net-v1-2-769a2aff91df@tritechsolutions.se>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795805097; l=2183;
 i=willie.wiholm@tritechsolutions.se; s=20261127;
 h=from:subject:message-id;
 bh=OTu68TuDMbFEnIoadSFdiWgIpDYzTT9DBuTGVclx374=;
 b=K+6XR3DKmSbFx+H6GWP5nkkaPMLUcI58nSHrZYYxzLt9Y3KYkoqND/LRot5U4Zpc9a7/6tuXN
 gpnhZ5bODA+DDVYfEypo7h9VKIt0pahoY4PeJWGQw31j27vazdOMw/8
X-Developer-Key: i=willie.wiholm@tritechsolutions.se; a=ed25519;
 pk=+cNLoL8211zFctWUX7P+l/TZm0pSVfYhLugt3NOecW8=
X-Endpoint-Received: by B4 Relay for
 willie.wiholm@tritechsolutions.se/20261127 with auth_id=1669
X-Original-From: Willie Wiholm <willie.wiholm@tritechsolutions.se>
Reply-To: willie.wiholm@tritechsolutions.se
Content-Transfer-Encoding: 7bit

From: Willie Wiholm <willie.wiholm@tritechsolutions.se>

WOL_INT in ISR is latched until ISR is read. When the PHY has no IRQ,
nothing reads ISR, so a magic packet received while the system is
running leaves the WoL interrupt pending and INT/PWDN_N asserted. The
next suspend then does not wake up on a magic packet, as the pin is
already active.

With WoL enabled, phy_suspend() does not call the driver's suspend
callback, so the driver has no chance to clear the interrupt. Set
PHY_ALWAYS_CALL_SUSPEND and, when WoL is enabled, only read ISR in
dp83867_suspend(). ISR is only read when the PHY has no IRQ, so that
pending interrupts are not lost when it has one. Without WoL the
behaviour is unchanged.

bcm54xx_suspend() acknowledges the WoL interrupt before suspend in the
same way.

Fixes: caabee5b53f5 ("net: phy: dp83867: support Wake on LAN")
Cc: stable@vger.kernel.org
Signed-off-by: Willie Wiholm <willie.wiholm@tritechsolutions.se>
---
 drivers/net/phy/dp83867.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index e3617f01b5d9..d997e10cd5ef 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -712,6 +712,22 @@ static int dp83867_of_init(struct phy_device *phydev)
 
 static int dp83867_suspend(struct phy_device *phydev)
 {
+	int ret;
+
+	/* The PHY must stay powered up for WoL. Without a PHY IRQ nothing
+	 * reads ISR, so a WoL event latched while the system was running
+	 * keeps INT/PWDN_N asserted and the next magic packet does not
+	 * wake the system. Clear it before suspend.
+	 */
+	if (phydev->wol_enabled) {
+		if (!phy_interrupt_is_valid(phydev)) {
+			ret = phy_read(phydev, MII_DP83867_ISR);
+			if (ret < 0)
+				return ret;
+		}
+		return 0;
+	}
+
 	/* Disable PHY Interrupts */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->interrupts = PHY_INTERRUPT_DISABLED;
@@ -1274,6 +1290,7 @@ static struct phy_driver dp83867_driver[] = {
 		.phy_id_mask	= 0xfffffff0,
 		.name		= "TI DP83867",
 		/* PHY_GBIT_FEATURES */
+		.flags		= PHY_ALWAYS_CALL_SUSPEND,
 
 		.probe          = dp83867_probe,
 		.config_init	= dp83867_config_init,

-- 
2.43.0


