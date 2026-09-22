Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D45476E4
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088245; cv=none; b=g+tY0h/7mXUtIS0kAaWb9XR1PyP70+u6VoxNyARS2USN63lq1hnND+JW4sUHIGXCGXRwi/SH2J6gAuyuje0JiAicyVJPViOgoJe4MD8yxwIIzzEv22wk3mIEldC5fYJ8o3erL2TWfgqePXhwVbNr/PUSh7/akdZcGPXK2BrLYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088245; c=relaxed/simple;
	bh=oYSCaJWTjpIMjBSxmSsb7GAow7ONIXA2eTKkImNfxpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buelvqKYIxy56XdZUfvhM5l/Du2j3QtMYl3OqEzvc//vYxhBAGnX5mtNeJ/dKwpVtQnn0p6V9wQX6IWzjzgjCgQefBvonO1jsdkXtSb1o/G0lqxxWIKlKCqx71nfetOcmFU3jW/eh5OA3Xnec/0X4uLjTYDTpVrIf7BAyhfu3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEwdu2Ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEwdu2Ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A2B1F000FF;
	Tue, 22 Sep 2026 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088244;
	bh=7KI+fbL9p43/r57EVzLJbQ5ZTqMVFvgtgVJYTn60lB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEwdu2JimhuioDY31DREdRGUMxjbBw8k8jnCHrCdWegSRYKVCsbTmcguiI/vxoOzZ
	 HJ5Ds8sZSL2ZQ8jee+TCn4bxOPdOddkQUyTPNnWlNUpWKx4ipKio6P14dWRpGfcEVd
	 /zpPKCtAfJgNheycmT4rByVdvSHDjHxh/w2P/QneGYult7j6mC5o8G7BmvICJ2p3FW
	 PF7d+A9vRhERRl4c9In3ddu0tIWHrhMfuCj2JwvomYbNGusY/g9tlcVunhSYKVRQiL
	 iZor3YTNEivKioBe9sAWZYdfixQrQmP+PawncOyOKSDpnK1iqBTeEsaGU66u4CVXqo
	 FqRXD1y6Pbgyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ahmed Naseef <naseefkm@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: phy: mediatek: do not report link and per-speed LED rules together
Date: Tue, 22 Sep 2026 10:44:01 -0400
Message-ID: <20260922144401.2671743-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092202-coastal-version-cfe0@gregkh>
References: <2026092202-coastal-version-cfe0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Naseef <naseefkm@gmail.com>

[ Upstream commit bde5212360bd44506edec073ebbd6d0c72f75820 ]

mtk_phy_led_hw_ctrl_get() reports TRIGGER_NETDEV_LINK whenever any of the
speed bits in on_set is on, and in addition reports every individual
TRIGGER_NETDEV_LINK_* bit that is set. The netdev trigger refuses that
combination: netdev_led_attr_store() rejects TRIGGER_NETDEV_LINK together
with any per-speed rule, and it validates the whole resulting mode rather
than just the bit being written. Once the hardware has any link bit
programmed, every write to the trigger attributes of that LED therefore
fails with -EINVAL and the LED can no longer be configured.

The rules are also fed back into the hardware: the trigger stores what is
read back, and a later write of device_name programs it again, expanding
TRIGGER_NETDEV_LINK to every speed in on_set. An LED configured for a
single speed is thereby silently widened to "on at any link speed".

Both are easy to see on the EcoNet EN7528, whose four PHYs share one LED
block. The first LED programs the block correctly, the second reads those
rules back and rewrites them widened, and the remaining two then read the
widened value, so an LED configured for "link_10 link_100" ends up lit on a
1000 Mbps link.

on_set holds every speed the LED can indicate and is exactly what
mtk_phy_led_hw_ctrl_set() programs for TRIGGER_NETDEV_LINK, so report the
speed independent rule only when all of them are on, and the individual
speeds otherwise. The mapping is then the inverse of the one used when
programming the LED and round trips without changing the register.

Fixes: c66937b0f8db ("net: phy: mediatek-ge-soc: support PHY LEDs")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20260912134306.3544329-1-naseefkm@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted the LED helper changes to the existing gigabit-only implementation in mtk-ge-soc.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 4b2a9a5444c57..ac356937a501d 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1276,17 +1276,24 @@ static int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
 	if (!rules)
 		return 0;
 
-	if (on & MTK_PHY_LED_ON_LINK)
+	/* TRIGGER_NETDEV_LINK must not be reported together with any of the
+	 * per-speed rules, the netdev trigger rejects that combination.
+	 * MTK_PHY_LED_ON_LINK holds every speed this LED can indicate and is what
+	 * mt798x_phy_led_hw_control_set() programs for TRIGGER_NETDEV_LINK, so
+	 * report the speed independent rule only when they are all on.
+	 */
+	if ((on & MTK_PHY_LED_ON_LINK) == MTK_PHY_LED_ON_LINK) {
 		*rules |= BIT(TRIGGER_NETDEV_LINK);
+	} else {
+		if (on & MTK_PHY_LED_ON_LINK10)
+			*rules |= BIT(TRIGGER_NETDEV_LINK_10);
 
-	if (on & MTK_PHY_LED_ON_LINK10)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
-
-	if (on & MTK_PHY_LED_ON_LINK100)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
+		if (on & MTK_PHY_LED_ON_LINK100)
+			*rules |= BIT(TRIGGER_NETDEV_LINK_100);
 
-	if (on & MTK_PHY_LED_ON_LINK1000)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
+		if (on & MTK_PHY_LED_ON_LINK1000)
+			*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
+	}
 
 	if (on & MTK_PHY_LED_ON_FDX)
 		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
-- 
2.53.0

