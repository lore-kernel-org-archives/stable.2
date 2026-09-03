Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A834307AB;
	Thu,  3 Sep 2026 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435095; cv=none; b=AOHwzxZV77Lf2dIWBfyPLzZ1AGFGrLzDT+PmlYd7BxUr68X2aZREuQw1xw6MOQwLhKQHaHKed+Wr3tlf2UN/Ca6Bsi3n0Alh/+nEP8clQB3Bj2w+7if15JqWJo2mHUSvZUkr3zdCT33UJ77DtLoW4SbbDkHqIy3MxP2ZqL1zdjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435095; c=relaxed/simple;
	bh=OwYsUZYibmC7EBithBhSMyol2mYVr23d0vUrPml2wB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A79w6L9Egj+04j1vJaakFMIo0S2mknY1mjtningGsPtm91gbGTcZmDl5HilFTdGQMLOAIyU6I8lF/6cjKcFcY2UVSk3bvP/OU+z426+j6VQNQFY1bfVectR9yJi/pMcjva41J4DBRaIgsWyMaePeD620NWn+g8CgcGmXa5dBkKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AkjHiW62; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AkjHiW62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Wt
	9baLDDAUOcPkEms4NTHOAnTpdfjsgzL3naNfkD0jo=; b=AkjHiW62nlBfJLkgfe
	r7apkAg6Y4c7JMp97E5Qx4iYcJ8/ous9WQ3KZ8+hkMGou/WEi+/RRPPXmYSLV7xG
	CIIUR6/WfWp52MP2XDou+rZHRdQCaX0/5qRa9eBia+xNrZ5Tm28j0lHJ0IUKSaXb
	+HGv62pFY3U8vlyGtsc+nHlmA=
Received: from ubuntu.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAH6oFxWplqpx2zOQ--.25956S2;
	Thu, 03 Sep 2026 19:30:58 +0800 (CST)
From: huhai <15815827059@163.com>
To: kuba@kernel.org,
	andrew@lunn.ch,
	divya.koppera@microchip.com
Cc: netdev@vger.kernel.org,
	xuanqiang.luo@linux.dev,
	Divya.Koppera@microchip.com,
	Henry Hu <huhai@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: phy: microchip_t1: fix NULL pointer dereference in lan887x_phy_init()
Date: Thu,  3 Sep 2026 19:30:46 +0800
Message-Id: <20260903113046.163630-1-15815827059@163.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAH6oFxWplqpx2zOQ--.25956S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyUXF1kAr4kCr4kXw4DCFg_yoW5JF15pF
	4fZ34Fywn5Xr1rXw18Krs7Grn0vwsrtrW8uw4rGw4FgrW8AF1DJayxtFyj9F98JFWkXayS
	qw4qyFyUCF1DZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UppBhUUUUU=
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/xtbC8BOzOWqZWnMovQAA3m

From: Henry Hu <huhai@kylinos.cn>

The issue was discovered via smatch static analyzer:

  make CHECK="smatch -p=kernel"  C=2  drivers/net/phy/microchip_t1.o
    CHECK   scripts/mod/empty.c
    DESCEND objtool
    CHECK   drivers/net/phy/microchip_t1.c
  drivers/net/phy/microchip_t1.c:1295 lan887x_phy_init() warn: 'priv->clock' can also be NULL

mchp_rds_ptp_probe() returns NULL when CONFIG_MICROCHIP_PHY_RDS_PTP or
CONFIG_PTP_1588_CLOCK is disabled. However, lan887x_phy_init() only checks
for an error pointer before using the returned clock to configure the
periodic output pin, which can result in a NULL pointer dereference.

Handle the NULL return as PTP being unavailable and skip the event pin
configuration in that case. Smatch no longer reports the NULL dereference
warning after the change.

Fixes: 8541fc12edcd ("net: phy: microchip_t1: Enable pin out specific to lan887x phy for PEROUT signal")
Cc: stable@vger.kernel.org
Reviewed-by: Divya Koppera <Divya.Koppera@microchip.com>
Signed-off-by: Henry Hu <huhai@kylinos.cn>
---
Changes:
v2:
  - update commit message to include smatch warning
  - add Reviewed-by: Divya Koppera <Divya.Koppera@microchip.com>
  - add Cc: stable@vger.kernel.org

v1: https://lore.kernel.org/all/20260902083342.221050-1-15815827059@163.com/

 drivers/net/phy/microchip_t1.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 3292b2235c8f..e38d20bf6aa4 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -1285,14 +1285,16 @@ static int lan887x_phy_init(struct phy_device *phydev)
 		if (IS_ERR(priv->clock))
 			return PTR_ERR(priv->clock);
 
-		/* Enable pin mux for EVT */
-		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
-			       LAN887X_MX_CHIP_TOP_REG_CONTROL1,
-			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN,
-			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN);
-
-		/* Initialize pin numbers specific to PEROUT */
-		priv->clock->event_pin = 3;
+		if (priv->clock) {
+			/* Enable pin mux for EVT */
+			phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+				       LAN887X_MX_CHIP_TOP_REG_CONTROL1,
+				       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN,
+				       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN);
+
+			/* Initialize pin numbers specific to PEROUT */
+			priv->clock->event_pin = 3;
+		}
 
 		priv->init_done = true;
 	}
-- 
2.40.1

