Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807D39CCE3
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462778; cv=none; b=fKWOBmf+imu9R0AFXwN67CXu/eeugFN19gwERrHDOX2Cs+VFT0BNAB9WG1OJQxzKMdFhoKzVH5aE8NIJKMjCkvgoCiaR00zBXtRW8hrAOXkv58msmIhXNj0Ek/C2e04fqF07BOJqZWqGu2/YGJmHu8xnDQSY7IDBqv4FiPbVYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462778; c=relaxed/simple;
	bh=A0vcz/anUTqKA8U9nxe1W0s1MZUfEUEUs257tPocHx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrG3yHN5+CnZn62EmOHkuIjitEp19Wnj3BdeKMX4xHQe+r+gmKgtZw9AuvyIQVteXEXh6IaXG/Fxq+hMfN+GjcR9rg9rbnIo/U0t7WPqWwxTXLnx0ZjvjOJ8jkTjiDCUDCXEYFxbQhco9hMi/pYnNU3DzqoW7mE5Z0ZDgjuP6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=otM285Sr; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="otM285Sr"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260915085930d15d56755200020777
        for <stable@vger.kernel.org>;
        Tue, 15 Sep 2026 10:59:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xd4P+RrevLs4CoPLOVTqkeJlnxio5pegTJyDPNxyVAE=;
 b=otM285Sr/vohmqP25+aN/0LrV3PRtJquHPqrqYiaahBXuLeLvwNWfT/zNtaMBY/615kZ+E
 4ibekxdzHRINCjsvps3GvtMOQAOcAy6VLxZidd/0xqpgG32KvrtGQ54VC0re+YJMieokK+w2
 EkePLFX/5HnhnmuooVFIEFOwLZy5buZogX8mzZl3EBMD1vHfItJkybtmhrR8iJwZFuOgc3KJ
 jzG1TC9Ft0EOny/2/cAY9tOz7urrdbNEnVY1epfik6dUxKxWAK/kZ1qG2xTGJwcwTHPYF9KB
 VYauv6R8CYxxnEZtZLR/haNdGNTYs0tE6PP+xW41deGYcRWAMFQAHvPQ==;
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
Subject: [PATCH] net: phy: intel-xway: workaround 100BASE-TX Link-Up issue
Date: Tue, 15 Sep 2026 10:59:17 +0200
Message-ID: <20260915085921.1354706-1-alexander.sverdlin@siemens.com>
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
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
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

