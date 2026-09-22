Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894652122E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063599; cv=none; b=pbEai7ufAAa2qXPsWcAhq5amWmB6ofnZRaK0z1svix/paOkYgEu5VWR7skJ1HTmwM0FDYtH4Vx7p3+X3IE2no7rDuBtnDNvCuWImQkounq0H226hoRwbAchIZ1ponTmBfUt3a2ENE/+428M1/l7BkEepH6wiDrYeYoj7E2CHexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063599; c=relaxed/simple;
	bh=m5EoRua0q9A2AIEu5UEySzNXUjtv5J9RR+mgTqZVnTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWsUG/7dr2HVK/RkdDRNmP69oxt8laPjtgh4qkRvdNhrKqpPJsHtACACsA7QDqlO9ieMT3dz6qz9kZUTY2QmPZgSM/M73YEhXLJ2euzqIo1g4slBFIp0D3RMZOmRGGNJUP5N7NnStrd5yn6VwZRtAllpMW1KkIqtmCKd/PcBQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=KUZSIUrX; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="KUZSIUrX"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026092207525432e8870c0600020721
        for <stable@vger.kernel.org>;
        Tue, 22 Sep 2026 09:52:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=5SshI8N4ivJLLkeBdfLpv1CjXhh2GgUQgsKDnILaqkg=;
 b=KUZSIUrXUhFpgCNQ644uND8V0eOC3R4jjQfW3wzpmpiRJfRR/NwDwedlMwxy96G4Btq/lx
 ZLV7+6KH8c0F+nAleoD351nfJlR45QFq04QqUg2xzgF0ILmNqt+r/4GttXhRxufz6iqWgWkV
 EYaGhh+0tJhhjwMTzfCni2bz/OQhrqoCVuATp50HDiM7M3Xnoq1fiHuSG+fJfl+8FQinhFET
 mDUkMko3zEqroujh+2mltR6RsIqQwRIXtRMMhoX1HlPVqTh3Ss/B1uhNKE0il9SDIBlVEczw
 rGZU/unDJCY5hx0qDxxg69mIgvJPOSFAFMMvgRgG4zEbPZfXE52g+Wyw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	"Aleksander Jan Bajkowski" <olek2@wp.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	John Crispin <john@phrozen.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: phy: intel-xway: workaround 100BASE-TX Link-Up issue
Date: Tue, 22 Sep 2026 09:52:46 +0200
Message-ID: <20260922075251.23386-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

MaxLinear GSW12x/GSW14x Ethernet Switch Errata Sheet states:
"An issue has been sporadically observed after device power-on on the first
link-up attempt in 100BASE-TX mode resulting in either the link-up taking a
long time, or failing to link-up altogether...

Workaround:
After power-on, enable Cable Diagnostic Mode for all ports and disable
it..."

Implement the proposed workaround unconditionally in the Intel XWAY driver
(MaxLinear GSW1xx switches incorporate Intel XWAY PHYs) because the
diagnostic bits have the same meaning even in older integral PHYs such as
GPY111/PEF7071/PHY11G. So it's not clear how to distinguish the affected
newer integrated PHYs, but the workaround should not hurt the older PHYs.

Cc: stable@vger.kernel.org
Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2:
- added "Fixes:" tag (refers GSW1xx introduction commit, because it's the
  first known silicon to contain affected IP, kernels w/o GSW1xx support
  do not need XWAY PHY workaround)
v1:
- https://lore.kernel.org/all/20260915085921.1354706-1-alexander.sverdlin@siemens.com/

 drivers/net/phy/intel-xway.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index afbcec7117443..3cee31bb931f2 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -16,6 +16,11 @@
 #define XWAY_MDIO_ISTAT			0x1A	/* interrupt status */
 #define XWAY_MDIO_LED			0x1B	/* led control */
 
+#define XWAY_MDIO_GCTRL_TM_MASK		GENMASK(15, 13)
+#define XWAY_MDIO_GCTRL_TM(mode)	FIELD_PREP(XWAY_MDIO_GCTRL_TM_MASK, (mode))
+#define XWAY_MDIO_GCTRL_TM_NOP		XWAY_MDIO_GCTRL_TM(0)	/* Normal operation */
+#define XWAY_MDIO_GCTRL_TM_CDIAG	XWAY_MDIO_GCTRL_TM(6)	/* Cable diagnostics */
+
 #define XWAY_MDIO_ERRCNT_SEL		GENMASK(11, 8)
 #define XWAY_MDIO_ERRCNT_COUNT		GENMASK(7, 0)
 #define XWAY_MDIO_ERRCNT_SEL_RXERR	0
@@ -326,6 +331,28 @@ static int xway_gphy_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int xway_11g_int_config_init(struct phy_device *phydev)
+{
+	int err;
+
+	/* An issue has been sporadically observed after device power-on on the
+	 * first link-up attempt in 100BASE-TX mode resulting in either the
+	 * link-up taking a long time, or failing to link-up altogether.
+	 *
+	 * Workaround:
+	 * After power-on, enable Cable Diagnostic Mode for all ports and
+	 * disable it.
+	 */
+	err = phy_modify(phydev, MII_CTRL1000, XWAY_MDIO_GCTRL_TM_MASK, XWAY_MDIO_GCTRL_TM_CDIAG);
+	if (err)
+		return err;
+	err = phy_modify(phydev, MII_CTRL1000, XWAY_MDIO_GCTRL_TM_MASK, XWAY_MDIO_GCTRL_TM_NOP);
+	if (err)
+		return err;
+
+	return xway_gphy_config_init(phydev);
+}
+
 static int xway_gphy14_config_aneg(struct phy_device *phydev)
 {
 	int reg, err;
@@ -735,7 +762,7 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (xRX v1.2 integrated)",
 		/* PHY_GBIT_FEATURES */
-		.config_init	= xway_gphy_config_init,
+		.config_init	= xway_11g_int_config_init,
 		.probe		= xway_gphy_probe,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
-- 
2.55.0

