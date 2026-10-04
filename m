Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153862D3A93
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791077061; cv=none; b=sbrvdU/jBeYM8JY/IJVt6kEmxO6EghP0ifN9O57yXhMNXDlmw8K1McMNWDHGac0VPvqpesY8NXh0X1tj1obBkAtu3zzaeeJYYfk+x85/Csl7arUVCriZtvr/LE54G0GdtBG98gqqFvPFLRlSpq7XKWqyKmrPYKxgWGnlYJG3hwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791077061; c=relaxed/simple;
	bh=wD2Elhv2O/isKS2UwvJZDHPoIPczUOMoFxM4T2kL4oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPNTyH1etSvMAIef91x0JlN2YaCetg3YR8o+TzPbX1Y5iQO2IWHVjiNViTsOT3Jgj054laSgxPg2rWMtAFR/NgDGwwO90InKAMTFJPQgVIHGMDbcghNwiGqfcV1qqBNOHao8FTo4TZ3sa1MYYv8ZcIkErnUj/1oP+CwqJeuzK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvTIe5Cf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvTIe5Cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0CB1F0089B;
	Sun,  4 Oct 2026 01:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791077059;
	bh=VXBb/ms2/n2LvLpWmjx9dwqglGoamFmN1GbbksLsUfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvTIe5CfCURg2gMKyRXUa18tJYStrOelv6H68V73W2QWxLOVZmAuoi4PEP24M1urR
	 5EVamSB8z6Xnk17QXMwu5Be4Li27VHpW5zlnQOfmba4q0bu7/g2ZXsqw4T1g8YhfK1
	 7xWLyuaERsQcMkfD+MCSYE/kq0c3aO+JO8pxrtkvF+w5n/dgHUhGd/h/T/Jv3dcPOg
	 /OkSNrxsLriq7TNyDL3yBnG2AQbNwoTThiKCcNKMiZ5GjsO5c5jMza25lQDzXCp1yR
	 N/H+l+JyIGLHs/2OMzbEDwfMNwa6GkcQ3OGKizkRP35AT2Ci3CZkD7/I8/y1hlmyGp
	 Mguwi8ahLlPrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: phy: aquantia: fix system interface type not updated in forced mode
Date: Sat,  3 Oct 2026 21:24:03 -0400
Message-ID: <20261004012327.1305943-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100346-voice-evacuate-1d32@gregkh>
References: <2026100346-voice-evacuate-1d32@gregkh>
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
[ sashal: adapted aqr_gen1_read_status() changes to aqr107_read_status() with inline interface decoding ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 334a6904ca5a3..017fe2b75e7e2 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -425,7 +425,7 @@ static int aqr107_read_status(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
+	if (!phydev->link)
 		return 0;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS);
@@ -462,6 +462,9 @@ static int aqr107_read_status(struct phy_device *phydev)
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

