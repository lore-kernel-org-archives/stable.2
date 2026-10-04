Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1DD352C34
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791106110; cv=none; b=pyKEFMTR+HgrTDWlBkOpTCpR2WFkeHQwClIJIqpaY75WrocrNEKt3kyiP67mQg83J7LheFFJECqh2/bv1n+0BqWNnrpzgMhsW1KwlUm9vzgetwSZq+4NiMN9eUe401F7I0Nou80yaqUurK3zZPsfPQU+1JiE3r+0/7uxq8dSeKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791106110; c=relaxed/simple;
	bh=g5UUSagIiH4612BmRdYRp8MGY/BMUR03SkZ9xRgddHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQ0WtPs98UAVYJsKL7+8FubKxU9g/WyVBIAOaiS6Vhdr9Npkegw6UVSJiEbXWsqbAK2mI45s65T8gwtofoVwqR0HQR+Xbq4O7lZqofpZOPnFE0szXG+64bDhUMefUxXEnhbtzAb5vQtv9/VUBt8QQwQMOtURGNgZn3Pa6c/v2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvU7LYPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvU7LYPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B130E1F000FF;
	Sun,  4 Oct 2026 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791106108;
	bh=J9hyPl0tcym+z34MSkdCFlItHBhp6kacWNUe6ygAYqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvU7LYPeEY0gaewfwwisoWWi3sMn4+0KiXezTgU/8yYa4v0mRtw0eXse+isEE6VLP
	 LP3rRBv6ttU4e9pjLia1c9CNTMe6FTMHHXqI3PYzbAh+S7Py77vfnTGRrtpXewFcTD
	 Of+EfvTgrW17h5fq63QxUBqJqPySP+1l/QB5zxS3ySGgbAlNfNuv6m+SdbQ8lnCvV3
	 CMg9MJB7PA5H9v6mwsmURw9ptqvGwy2xc8UqedhNEbSceatz0jxN/RyTUYpVyz4r3B
	 QJUW4Vmqy6VPKz08gIk7kzgUs+8cXx1ZWjiI9RqcFM0/CIc3S2XJ7/emY4wdtiEBDu
	 iXOJXo+vB4/5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: phy: aquantia: fix system interface type not updated in forced mode
Date: Sun,  4 Oct 2026 05:28:24 -0400
Message-ID: <20261004092807.1398565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100348-tanned-afloat-e007@gregkh>
References: <2026100348-tanned-afloat-e007@gregkh>
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
[ sashal: Adapted the changes to aqr107_read_status() instead of aqr_gen1_read_status(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/aquantia_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index 7045595f8d7d1..cbc01a4036ecf 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -360,7 +360,7 @@ static int aqr107_read_status(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
+	if (!phydev->link)
 		return 0;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS);
@@ -388,6 +388,9 @@ static int aqr107_read_status(struct phy_device *phydev)
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

