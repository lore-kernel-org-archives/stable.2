Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBB4BFE93
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004134; cv=none; b=EfS43Sc2FRq/J++WcC3/diaEXeUhEfEe2PGn0dDfwWN5jLuXOogaP6aF38sxh4mQ1xj5RwmejbEVzPVZpFVBETyaJfkGYy5Aj7b09iW+aXGnQuHjz5jAMRfsK/5Jewdv9wMyUVHJDUKZQdAowkZsFy+HBVP1qm7pZgAEBERc3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004134; c=relaxed/simple;
	bh=uKo7OnKINCud2RD1UPpw/QiHG8nzSuF85YGZt2IQ77o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7iDD2OTDuFDKmpf0LgaFjKI5S6VBsfzEm6kNaKVutvDAmvr8spsvM/UQa+R0wgTv/ohCW2E0ZJf4MFg1gZ4hQTjExKuHxpNcxiPGPb2zcm5UqbPHlACpxFTRWHJOjJ1KKlBT3K4CVhDYpHpSX5ShmA9u+VW9PYcYNz1mMQtJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXMap/0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXMap/0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA1F1F00898;
	Thu, 10 Sep 2026 01:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789004132;
	bh=CvOeE2KuKyUg/rqJhckIs3CfhtINJEly5vNjUJBjwls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXMap/0OiMFCKqhQJIztXb2tqBMuYjCb1jLm70AUIPapjT2tdVkg2FPblIibAvCib
	 XZcMesTnstr7Q5lGS9yn0KdBhlUkMU0SbyU7p0XvyJqV6h1Rw+kTUowXwt1JZUiMaM
	 0NCr3+77g+biL0+zVv+pub8mpkxXJIN6V0RbFKdjv0aE0r6c7pG1321qEfyvaL5K7S
	 JlCSTIamy3K+Sor3t6eoGFs6OYrNI4n+Q2SCaSx5QWXGBskLIuTqeOWx4ZLEcBsDtz
	 0csUwfywB1ykZIzuv5u0TyiXf2sMRTxPY2BIRYkSGBiEdcisIoazKulMpI8weV/GSV
	 YHrbpeoaGh0+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] wifi: rtw89: Hide some errors when the device is unplugged
Date: Wed,  9 Sep 2026 21:35:29 -0400
Message-ID: <20260910013530.3901662-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910013530.3901662-1-sashal@kernel.org>
References: <2026090433-armed-frequent-d9dc@gregkh>
 <20260910013530.3901662-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 0740c6beefae03066a562e3047959528d8893709 ]

A few unnecessary error messages are printed when the device is
unplugged. "read swsi busy" in particular can appear ~1000 times when
RTL8851BU is unplugged.

Add a new flag RTW89_FLAG_UNPLUGGED and print some error messages only
when this flag is not set. The new USB driver will set the flag when
the device is unplugged.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/cc18b739-6f38-4c1a-a681-1e2a0d4ed60d@gmail.com
Stable-dep-of: 667c12782aaf ("wifi: rtw89: pci: add .shutdown callback to stop rfkill polling on reboot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 13 ++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.c  |  3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6d9365332174b..0b48d2dfce4cc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4724,6 +4724,7 @@ enum rtw89_flags {
 	RTW89_FLAG_FORBIDDEN_TRACK_WROK,
 	RTW89_FLAG_CHANGING_INTERFACE,
 	RTW89_FLAG_HW_RFKILL_STATE,
+	RTW89_FLAG_UNPLUGGED,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 31465893f866d..9fb0a5cd0fb7e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -88,7 +88,7 @@ int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val)
 
 	ret = read_poll_timeout(rtw89_read8, lte_ctrl, (lte_ctrl & BIT(5)) != 0,
 				50, 50000, false, rtwdev, R_AX_LTE_CTRL + 3);
-	if (ret)
+	if (ret && !test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
 		rtw89_err(rtwdev, "[ERR]lte not ready(W)\n");
 
 	rtw89_write32(rtwdev, R_AX_LTE_WDATA, val);
@@ -104,7 +104,7 @@ int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val)
 
 	ret = read_poll_timeout(rtw89_read8, lte_ctrl, (lte_ctrl & BIT(5)) != 0,
 				50, 50000, false, rtwdev, R_AX_LTE_CTRL + 3);
-	if (ret)
+	if (ret && !test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
 		rtw89_err(rtwdev, "[ERR]lte not ready(W)\n");
 
 	rtw89_write32(rtwdev, R_AX_LTE_CTRL, 0x800F0000 | offset);
@@ -5666,13 +5666,15 @@ int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex
 
 	ret = rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_2, &val32);
 	if (ret) {
-		rtw89_err(rtwdev, "Read R_AX_LTE_SW_CFG_2 fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Read R_AX_LTE_SW_CFG_2 fail!\n");
 		return ret;
 	}
 	val32 = val32 & B_AX_WL_RX_CTRL;
 	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_2, val32);
 	if (ret) {
-		rtw89_err(rtwdev, "Write R_AX_LTE_SW_CFG_2 fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Write R_AX_LTE_SW_CFG_2 fail!\n");
 		return ret;
 	}
 
@@ -5796,7 +5798,8 @@ int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 
 	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_1, val);
 	if (ret) {
-		rtw89_err(rtwdev, "Write LTE fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Write LTE fail!\n");
 		return ret;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d544077ec2989..c957f88faeeeb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -881,7 +881,8 @@ static u32 rtw89_phy_read_rf_a(struct rtw89_dev *rtwdev,
 				       30, false, rtwdev, R_SWSI_V1,
 				       B_SWSI_R_DATA_DONE_V1);
 	if (ret) {
-		rtw89_err(rtwdev, "read swsi busy\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "read swsi busy\n");
 		return INV_RF_DATA;
 	}
 
-- 
2.53.0

