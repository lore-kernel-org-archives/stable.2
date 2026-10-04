Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D93FFD
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791074188; cv=none; b=klNAxHP3uJdSkLmeS7tSb3y2QV9XdbzhaNCv8qJklHjYHBXZs7Y6KcbiV4zU6/yqOBehVCAxHUEIkXc1AyJ3EWGDvENmI+kzkCmPSCpeCaI2T2PFn02KHZm742HBzkddnOZtKk/npYYZ05XrIaW7i065Xl7pq9RfrDRZOkwP/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791074188; c=relaxed/simple;
	bh=rgWKkfvJ3BDbEu/Ul1lEPbSiwSdZpH5BZPJLmcm0ix8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSJOIP7HvhjKJf+Mx1mVIPdJJN5YkyCtWULH7Y7Jly6y6HhJF0sDkeZFzKeHKsGMBc24WWpocpvGC4EySYx2U1W6+agE91ny+9jfv+mpeMsFfJHiCf/YukPAa9pIK9YFPaTOuwXLUt0IndoAxkucjZbjdI3Q8K2y8KKwx5hAg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP2HmyJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP2HmyJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310851F0089B;
	Sun,  4 Oct 2026 00:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791074186;
	bh=5Mj7xGF2ZHuS+g2fE/7c7+JUpa4CQlQdDtCXC1miVdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JP2HmyJ9+RNvlPl0t27X8zYwaL58A9o7sZWbxNk1FvswBNInqre3XuoFkgH/DEMpo
	 FWu+4wfO5w3jdlt2F4F1Uzxq+vshY/aSgSRcxs9KwIYXXOWJzd+3KqH53QiHD3o0r+
	 RmLU9Rjo/D3PbgY2V0PGT4rBV71c2HSAFRLEafo6CWtIvcaDhWlr81YViVquXgBZf7
	 /lGR89kBb8LdTdpLBo10WHFZOay1UD7T1C4CrSPhOfFK12E4PKf7OudJrOAys9rAZ0
	 Lvlqu7ztc296GIIBP3DqpB8mxBw2wWOiN6cQ40uwmZBdzU66duh5n26hj4jm0P/CTp
	 yHNE9kK7m3F/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: phy: aquantia: fix system interface type not updated in forced mode
Date: Sat,  3 Oct 2026 20:36:15 -0400
Message-ID: <20261004003554.1238693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100345-aching-thousand-eb02@gregkh>
References: <2026100345-aching-thousand-eb02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 6e0022b5ae3dc5b833af0fcc1578dc20a1d6bc71 ]

aqr_gen1_read_status() decodes the MDIO_PHYXS_VEND_IF_STATUS register
to determine which SerDes interface the PHY is currently using on its
system side and stores the result in phydev->interface. phylink relies
on this value to configure the MAC.

The autoneg == AUTONEG_DISABLE check is not correct:
MDIO_PHYXS_VEND_IF_STATUS is set by the PHY firmware based on the
negotiated link speed, not based on whether autoneg was used to reach
it. When the link comes up at 1G in forced mode, the register correctly
reads SGMII, but the early return prevents phydev->interface from being
updated. It stays at whatever value it held before (typically 2500BASE-X
from the initial autoneg run), so phylink configures the MAC for the
wrong interface and the link cannot come up.

Remove the autoneg guard so that the system interface type is always
decoded when the link is up.

Cc: stable@vger.kernel.org
Fixes: 110a2432c520 ("net: phy: aquantia: add downshift support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260923-qcom-sa8255p-emac-v15-1-e82f33720737@oss.qualcomm.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: Adapted aqr_gen1_read_status() changes to aqr107_read_status() and its direct interface-assignment switch. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index c33a5ef34ba03..0bf54723e3a1d 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -339,7 +339,7 @@ static int aqr107_read_status(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
+	if (!phydev->link)
 		return 0;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS);
@@ -376,6 +376,9 @@ static int aqr107_read_status(struct phy_device *phydev)
 		break;
 	}
 
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return 0;
+
 	/* Read possibly downshifted rate from vendor register */
 	return aqr107_read_rate(phydev);
 }
-- 
2.53.0

