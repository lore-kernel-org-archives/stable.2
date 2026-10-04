Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF93F6C55
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102247; cv=none; b=WmwyhB2NTEJxJI/+px757cvXRd5KnwRWonSxMQVxQi8Jos+h/of6Z1lxFXiIMrFemzvgO/0xS0fGIwTULnmJW6e+fJMi8aWm1XiwPe6ZGXurhQsDoFTilJZBbxgNP7lx2gKSH4o0PfBWKfStWT20XHWu36aC49JJdcWCI+A2sSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102247; c=relaxed/simple;
	bh=IlOaNbd/hg0nSvptWArewV3FCVWLiII0tR9BwTTqKG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7zvsp+NrXW4OuAVE11ZnIaLpOoXJzQlcHfgtRcyMTwbVlPPaBb8fWUaJA5D00YFGd4OlENWFjYnBLpJybXvOnUSiPKdxgwa1zmqsGGXVgw6DBy+KDIiQKJJzEtLq1f6JWAqj0gDO6JQKzBEBPYYC2zduesDyj786VqisIORKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f06+ebrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f06+ebrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5CE1F000FF;
	Sun,  4 Oct 2026 08:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791102246;
	bh=FeI5dtb0m8VzPiHbPCUWWWt59oUG3J5TFdFRdYHfxIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f06+ebrqbHnUECYGXnEwsdOFt31wUjHcnkDU3Ci9u8JB2lg3Hmhg3+sDapFDP8esH
	 tWq7xqoOY8EsWwVn1zBt0IMQL6yYlsY53e+8/60QVQe8E7yxDDb97PjWcmOerA3iXq
	 0X6GJsZt8E3nPo8Rc7rZtVmtOECVMhTXYahVVAORfr6eDr/LdUvF9/AS9sQAN4fMjP
	 D6yd5yKG0sCRs/46sg1KA1+EiCtH05CczJ0OTrBTvW7gwCIZkJjaEjH0dT6Dv98qoJ
	 8z70vs/bg+46B3wWYE82wrhMJYsjbviPHRJDjEjENiSp0KZg4LB2vXlqpxTOmg1dDF
	 ATD3EKlMJQIIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: phy: aquantia: fix system interface type not updated in forced mode
Date: Sun,  4 Oct 2026 04:24:02 -0400
Message-ID: <20261004082324.1385326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100347-subside-retiree-87ef@gregkh>
References: <2026100347-subside-retiree-87ef@gregkh>
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
[ sashal: adapted aqr_gen1_read_status() changes to the existing aqr107_read_status() implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/aquantia_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index 2f2765d7f84c8..00495c87b778b 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -389,7 +389,7 @@ static int aqr107_read_status(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
+	if (!phydev->link)
 		return 0;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS);
@@ -417,6 +417,9 @@ static int aqr107_read_status(struct phy_device *phydev)
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

