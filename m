Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437D334692
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099521; cv=none; b=HEP+s8auUT+Q12vhZhVRDlhJhNGIWcFA9MMHt7fPx8Z4vc5XsG/I6mmTANu7CJLqIRBkaohEM6K3aTmtdwLOpijFcyFNE+9v/9hDuk6Kx9EqrDNpRh/stwrbxluWd051rzHsfbMS4NWYK7zqtfNvz6qhwwAmjAtWCs2GI1KPaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099521; c=relaxed/simple;
	bh=JjUhofgZK2oQyBwqTP6Op7ba9fSx0Zbzhetm5+HQ1O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMYeWmbJyXVdBVAU2j0K0xzln/yrK9cRDOkJsciRINp/P40s3uHi0O8NrHwfS7Dv+aNpJUYF5vrEeT/g0Chwg29P/c4V0vLyLmclWD27S2rGF+wBtaDYBncUyFku7UgyxEYtF0L4J+iDtv8UemWldQkBa7w9yZmuL/GBRESiKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEruQb9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEruQb9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1661F000FF;
	Sun,  4 Oct 2026 07:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099518;
	bh=XJAnwPwQexQeYknAY6Nq78dyOQ9vchAezvfLt3tCPQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mEruQb9ZHyIJp0d02Ki7MzeAzXTMD4mw2auHYy2BoEQWRIw+B9tL5BjKWVInvTzlG
	 DHFeFltntrwrbEDNJ7uHYW4FTsKDgGZbtxdDdqWOVBsfhxWVE/VMnE6C8qfQRx7aSf
	 mIcQu1d5z9rg1e4T2W5o0nMzVHm9y5HnunWFLu2s3YB2UNPj4w/ASX0Zx1uJxzS1XU
	 KUIGOL0fSADIgQRfMFsD3zvLH0WV+tJNwljVCeIYJi+OcXWSqNhJZrs5nfLrh78kLy
	 f4OO5UF6+dmOqmseSHL1Wb8LOSyXgu4E0AnXVR1bTVIe+kZM7S9BSLdx84u5HNv7a8
	 Aa4sZBb4vYHfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: phy: aquantia: fix system interface type not updated in forced mode
Date: Sun,  4 Oct 2026 03:38:35 -0400
Message-ID: <20261004073823.1373257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100347-battered-hesitant-c91f@gregkh>
References: <2026100347-battered-hesitant-c91f@gregkh>
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
[ sashal: Adapted the change to aqr107_read_status(), which assigns the interface directly. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/aquantia_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index 47a76df36b747..9b51f76652863 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -423,7 +423,7 @@ static int aqr107_read_status(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
+	if (!phydev->link)
 		return 0;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS);
@@ -460,6 +460,9 @@ static int aqr107_read_status(struct phy_device *phydev)
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

