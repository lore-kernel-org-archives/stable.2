Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA953164C5
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114192; cv=none; b=BMM+G0YqGw5KObFZIMzTt4BFl6b1X269DzzGfYYDQJoJjV1ZwLxNiGbLyYUocLaqvMU/lid8bQ8728YpVi5KU7F9DqN2a04ZJT82bQQZ89oAhF+JExqGquE/kYFPKBtDSz6JFU8N3b1AuDa48it/Ppfd7XV5cZYVVLD5R4PQyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114192; c=relaxed/simple;
	bh=XLfh/FBhHF/OYz9DQliv2Hs9fmM7ipT+Pvw+N5c0HMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRM7dJs1qIIQbCw0Qx0oMdFZftcEua+6LffUU3J5l8w+FO8WlGmGauYeT5Xl3qCffZ9vPCV/Hw4ARXi7Ip/lbNc6hhp6NK1BMSswhr5bwduYomlUqVfPiOXFMYpXLLZP82QUnQE93JFiCXhY12FqsoJSkZ7SG5csL0DBEShukCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNqyoI73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNqyoI73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5067B1F00A3E;
	Wed, 15 Jul 2026 11:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114190;
	bh=pBglpQGgm0Q5ar4BZbu0DInF2kVVWzd0wFv6aV5Gi7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fNqyoI73IyaADVRInf80Vp9UgOGoqciGg51XRTUJtpxJJOz5Tdv3AGHIzEu91BqGJ
	 j9AFSZpTxvrCwGYEwKTuZSFEGep4AgsEWrIljYTju+HYNnWYGmWvQwtGNwgj7rw2kw
	 +hyVSGLwt/+MKe93by7hMyv6Bqoq+rFtSj0TjovE86juRt24fMdDPEBSFQQvVyBN8E
	 kuRj++nEcDn1MIftc152ynQNQ8iRgDfWtIxTb4lON9f8Yl5us9iDxKcIaHec6JFsZ9
	 Run6Q5knoLIBDpNeQBbU7nfV+5lqKacOQ84EPQoevNLXm12WamPWiWK3u+6PtvjTWi
	 GzhFGVWQa8QDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 05/10] staging: rtl8723bs: remove rf type branching (fourth patch)
Date: Wed, 15 Jul 2026 07:16:20 -0400
Message-ID: <20260715111625.647536-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715111625.647536-1-sashal@kernel.org>
References: <2026071300-length-drainable-3f8e@gregkh>
 <20260715111625.647536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 24e65aac94578765c8796511e769c08219d52ed9 ]

remove all function calls to rtw_get_hw_reg made to
read HW_VAR_RF_TYPE and get value of rt_type, which
is always 1T1R. Clean up code on removal sites,
keeping 1T1R code unconditionally.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/8ca2f788c42d81b9cb4dbc46e23c7549dc27d081.1628329348.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  8 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 28 +++----
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 73 +++++--------------
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    | 12 +--
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 50 ++-----------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 48 ++----------
 drivers/staging/rtl8723bs/hal/hal_com.c       |  8 +-
 drivers/staging/rtl8723bs/include/ieee80211.h |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 33 ++-------
 9 files changed, 51 insertions(+), 211 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index ce52093122ebde..e32db840f4fffa 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1179,7 +1179,6 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
-		u8 rf_type = 0;
 		u8 max_rx_ampdu_factor = 0;
 		struct rtw_ieee80211_ht_cap *pht_cap = (struct rtw_ieee80211_ht_cap *)(p + 2);
 
@@ -1225,11 +1224,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 			IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
 		); /* set  Max Rx AMPDU size  to 64K */
 
-		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-		if (rf_type == RF_1T1R) {
-			pht_cap->supp_mcs_set[0] = 0xff;
-			pht_cap->supp_mcs_set[1] = 0x0;
-		}
+		pht_cap->supp_mcs_set[0] = 0xff;
+		pht_cap->supp_mcs_set[1] = 0x0;
 
 		memcpy(&pmlmepriv->htpriv.ht_cap, p + 2, ie_len);
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index c48a8b80af4c14..baf6b445f2f011 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -107,28 +107,18 @@ void bb_reg_dump(void *sel, struct adapter *adapter)
 
 void rf_reg_dump(void *sel, struct adapter *adapter)
 {
-	int i, j = 1, path;
+	int i, j = 1, path = 0;
 	u32 value;
-	u8 rf_type = 0;
-	u8 path_nums = 0;
-
-	rtw_hal_get_hwreg(adapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-	if ((RF_1T2R == rf_type) || (RF_1T1R == rf_type))
-		path_nums = 1;
-	else
-		path_nums = 2;
 
 	DBG_871X_SEL_NL(sel, "======= RF REG =======\n");
 
-	for (path = 0; path < path_nums; path++) {
-		DBG_871X_SEL_NL(sel, "RF_Path(%x)\n", path);
-		for (i = 0; i < 0x100; i++) {
-			value = rtw_hal_read_rfreg(adapter, path, i, 0xffffffff);
-			if (j%4 == 1)
-				DBG_871X_SEL_NL(sel, "0x%02x ", i);
-			DBG_871X_SEL(sel, " 0x%08x ", value);
-			if ((j++)%4 == 0)
-				DBG_871X_SEL(sel, "\n");
-		}
+	DBG_871X_SEL_NL(sel, "RF_Path(%x)\n", path);
+	for (i = 0; i < 0x100; i++) {
+		value = rtw_hal_read_rfreg(adapter, path, i, 0xffffffff);
+		if (j%4 == 1)
+			DBG_871X_SEL_NL(sel, "0x%02x ", i);
+		DBG_871X_SEL(sel, " 0x%08x ", value);
+		if ((j++)%4 == 0)
+			DBG_871X_SEL(sel, "\n");
 	}
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index a81e77e5f9444b..d00d7233c298cc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1234,64 +1234,27 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 }
 
 /* show MCS rate, unit: 100Kbps */
-u16 rtw_mcs_rate(u8 rf_type, u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate)
+u16 rtw_mcs_rate(u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate)
 {
 	u16 max_rate = 0;
 
-	if (rf_type == RF_1T1R) {
-		if (MCS_rate[0] & BIT(7))
-			max_rate = (bw_40MHz) ? ((short_GI)?1500:1350):((short_GI)?722:650);
-		else if (MCS_rate[0] & BIT(6))
-			max_rate = (bw_40MHz) ? ((short_GI)?1350:1215):((short_GI)?650:585);
-		else if (MCS_rate[0] & BIT(5))
-			max_rate = (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520);
-		else if (MCS_rate[0] & BIT(4))
-			max_rate = (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
-		else if (MCS_rate[0] & BIT(3))
-			max_rate = (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
-		else if (MCS_rate[0] & BIT(2))
-			max_rate = (bw_40MHz) ? ((short_GI)?450:405):((short_GI)?217:195);
-		else if (MCS_rate[0] & BIT(1))
-			max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
-		else if (MCS_rate[0] & BIT(0))
-			max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
-	} else {
-		if (MCS_rate[1]) {
-			if (MCS_rate[1] & BIT(7))
-				max_rate = (bw_40MHz) ? ((short_GI)?3000:2700):((short_GI)?1444:1300);
-			else if (MCS_rate[1] & BIT(6))
-				max_rate = (bw_40MHz) ? ((short_GI)?2700:2430):((short_GI)?1300:1170);
-			else if (MCS_rate[1] & BIT(5))
-				max_rate = (bw_40MHz) ? ((short_GI)?2400:2160):((short_GI)?1156:1040);
-			else if (MCS_rate[1] & BIT(4))
-				max_rate = (bw_40MHz) ? ((short_GI)?1800:1620):((short_GI)?867:780);
-			else if (MCS_rate[1] & BIT(3))
-				max_rate = (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520);
-			else if (MCS_rate[1] & BIT(2))
-				max_rate = (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
-			else if (MCS_rate[1] & BIT(1))
-				max_rate = (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
-			else if (MCS_rate[1] & BIT(0))
-				max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
-		} else {
-			if (MCS_rate[0] & BIT(7))
-				max_rate = (bw_40MHz) ? ((short_GI)?1500:1350):((short_GI)?722:650);
-			else if (MCS_rate[0] & BIT(6))
-				max_rate = (bw_40MHz) ? ((short_GI)?1350:1215):((short_GI)?650:585);
-			else if (MCS_rate[0] & BIT(5))
-				max_rate = (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520);
-			else if (MCS_rate[0] & BIT(4))
-				max_rate = (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
-			else if (MCS_rate[0] & BIT(3))
-				max_rate = (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
-			else if (MCS_rate[0] & BIT(2))
-				max_rate = (bw_40MHz) ? ((short_GI)?450:405):((short_GI)?217:195);
-			else if (MCS_rate[0] & BIT(1))
-				max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
-			else if (MCS_rate[0] & BIT(0))
-				max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
-		}
-	}
+	if (MCS_rate[0] & BIT(7))
+		max_rate = (bw_40MHz) ? ((short_GI)?1500:1350):((short_GI)?722:650);
+	else if (MCS_rate[0] & BIT(6))
+		max_rate = (bw_40MHz) ? ((short_GI)?1350:1215):((short_GI)?650:585);
+	else if (MCS_rate[0] & BIT(5))
+		max_rate = (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520);
+	else if (MCS_rate[0] & BIT(4))
+		max_rate = (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
+	else if (MCS_rate[0] & BIT(3))
+		max_rate = (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
+	else if (MCS_rate[0] & BIT(2))
+		max_rate = (bw_40MHz) ? ((short_GI)?450:405):((short_GI)?217:195);
+	else if (MCS_rate[0] & BIT(1))
+		max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
+	else if (MCS_rate[0] & BIT(0))
+		max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
+
 	return max_rate;
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 1f60e8572e6843..6e1d2f0e713161 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -642,7 +642,6 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	struct wlan_bssid_ex	*pcur_bss = &pmlmepriv->cur_network.network;
 	struct sta_info *psta = NULL;
 	u8 short_GI = 0;
-	u8 rf_type = 0;
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) != true)
 		&& (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) != true))
@@ -655,14 +654,9 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	short_GI = query_ra_short_GI(psta);
 
 	if (IsSupportedHT(psta->wireless_mode)) {
-		rtw_hal_get_hwreg(adapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-
-		max_rate = rtw_mcs_rate(
-			rf_type,
-			((psta->bw_mode == CHANNEL_WIDTH_40)?1:0),
-			short_GI,
-			psta->htpriv.ht_cap.supp_mcs_set
-		);
+		max_rate = rtw_mcs_rate(psta->bw_mode == CHANNEL_WIDTH_40 ? 1 : 0,
+					short_GI,
+					psta->htpriv.ht_cap.supp_mcs_set);
 	} else {
 		while ((pcur_bss->supported_rates[i] != 0) && (pcur_bss->supported_rates[i] != 0xFF)) {
 			rate = pcur_bss->supported_rates[i]&0x7F;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 81b775b8accfe0..b5b0900f494146 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2591,7 +2591,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	enum HT_CAP_AMPDU_FACTOR max_rx_ampdu_factor;
 	unsigned char *p, *pframe;
 	struct rtw_ieee80211_ht_cap ht_capie;
-	u8 cbw40_enable = 0, stbc_rx_enable = 0, rf_type = 0, operation_bw = 0;
+	u8 cbw40_enable = 0, stbc_rx_enable = 0, operation_bw = 0;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
@@ -2671,32 +2671,10 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	memcpy(ht_capie.supp_mcs_set, pmlmeext->default_supported_mcs_set, 16);
 
 	/* update default supported_mcs_set */
-	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
+	if (stbc_rx_enable)
+		ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_1R);/* RX STBC One spatial stream */
 
-	switch (rf_type) {
-	case RF_1T1R:
-		if (stbc_rx_enable)
-			ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_1R);/* RX STBC One spatial stream */
-
-		set_mcs_rate_by_mask(ht_capie.supp_mcs_set, MCS_RATE_1R);
-		break;
-
-	case RF_2T2R:
-	case RF_1T2R:
-	default:
-		if (stbc_rx_enable)
-			ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_2R);/* RX STBC two spatial stream */
-
-		#ifdef CONFIG_DISABLE_MCS13TO15
-		if (((cbw40_enable == 1) && (operation_bw == CHANNEL_WIDTH_40)) && (pregistrypriv->wifi_spec != 1))
-				set_mcs_rate_by_mask(ht_capie.supp_mcs_set, MCS_RATE_2R_13TO15_OFF);
-		else
-				set_mcs_rate_by_mask(ht_capie.supp_mcs_set, MCS_RATE_2R);
-		#else /* CONFIG_DISABLE_MCS13TO15 */
-			set_mcs_rate_by_mask(ht_capie.supp_mcs_set, MCS_RATE_2R);
-		#endif /* CONFIG_DISABLE_MCS13TO15 */
-		break;
-	}
+	set_mcs_rate_by_mask(ht_capie.supp_mcs_set, MCS_RATE_1R);
 
 	{
 		u32 rx_packet_offset, max_recvbuf_sz;
@@ -2800,31 +2778,13 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	    (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) &
 	      BIT(1)) && (pmlmeinfo->HT_info.infos[0] & BIT(2))) {
 		int i;
-		u8 rf_type;
-
-		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 		/* update the MCS set */
 		for (i = 0; i < 16; i++)
 			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= pmlmeext->default_supported_mcs_set[i];
 
 		/* update the MCS rates */
-		switch (rf_type) {
-		case RF_1T1R:
-		case RF_1T2R:
-			set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
-			break;
-		case RF_2T2R:
-		default:
-#ifdef CONFIG_DISABLE_MCS13TO15
-			if (pmlmeext->cur_bwmode == CHANNEL_WIDTH_40 && pregistrypriv->wifi_spec != 1)
-				set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R_13TO15_OFF);
-			else
-				set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-#else /* CONFIG_DISABLE_MCS13TO15 */
-			set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-#endif /* CONFIG_DISABLE_MCS13TO15 */
-		}
+		set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
 
 		/* switch to the 40M Hz mode according to the AP */
 		/* pmlmeext->cur_bwmode = CHANNEL_WIDTH_40; */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 24b5a7e7942dff..09e4d8d740f18a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -56,19 +56,7 @@ static u8 rtw_basic_rate_ofdm[3] = {
 
 u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
 {
-	u8 raid, cur_rf_type, rf_type = RF_1T1R;
-
-	rtw_hal_get_hwreg(adapter, HW_VAR_RF_TYPE, (u8 *)(&cur_rf_type));
-
-	if (cur_rf_type == RF_1T1R) {
-		rf_type = RF_1T1R;
-	} else if (IsSupportedVHT(psta->wireless_mode)) {
-		if (psta->ra_mask & 0xffc00000)
-			rf_type = RF_2T2R;
-	} else if (IsSupportedHT(psta->wireless_mode)) {
-		if (psta->ra_mask & 0xfff00000)
-			rf_type = RF_2T2R;
-	}
+	u8 raid;
 
 	switch (psta->wireless_mode) {
 	case WIRELESS_11B:
@@ -85,23 +73,14 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
 	case WIRELESS_11_5N:
 	case WIRELESS_11A_5N:
 	case WIRELESS_11G_24N:
-		if (rf_type == RF_2T2R)
-			raid = RATEID_IDX_GN_N2SS;
-		else
-			raid = RATEID_IDX_GN_N1SS;
+		raid = RATEID_IDX_GN_N1SS;
 		break;
 	case WIRELESS_11B_24N:
 	case WIRELESS_11BG_24N:
 		if (psta->bw_mode == CHANNEL_WIDTH_20) {
-			if (rf_type == RF_2T2R)
-				raid = RATEID_IDX_BGN_20M_2SS_BN;
-			else
-				raid = RATEID_IDX_BGN_20M_1SS_BN;
+			raid = RATEID_IDX_BGN_20M_1SS_BN;
 		} else {
-			if (rf_type == RF_2T2R)
-				raid = RATEID_IDX_BGN_40M_2SS;
-			else
-				raid = RATEID_IDX_BGN_40M_1SS;
+			raid = RATEID_IDX_BGN_40M_1SS;
 		}
 		break;
 	default:
@@ -1016,7 +995,6 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 {
 	unsigned int	i;
-	u8 rf_type;
 	u8 max_AMPDU_len, min_MPDU_spacing;
 	u8 cur_ldpc_cap = 0, cur_stbc_cap = 0;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -1052,29 +1030,13 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 			pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para = max_AMPDU_len | min_MPDU_spacing;
 		}
 	}
-	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 	/* update the MCS set */
 	for (i = 0; i < 16; i++)
 		pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= pmlmeext->default_supported_mcs_set[i];
 
 	/* update the MCS rates */
-	switch (rf_type) {
-	case RF_1T1R:
-	case RF_1T2R:
-		set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
-		break;
-	case RF_2T2R:
-	default:
-#ifdef CONFIG_DISABLE_MCS13TO15
-		if (pmlmeext->cur_bwmode == CHANNEL_WIDTH_40 && pregistrypriv->wifi_spec != 1)
-			set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R_13TO15_OFF);
-		else
-			set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-#else /* CONFIG_DISABLE_MCS13TO15 */
-		set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-#endif /* CONFIG_DISABLE_MCS13TO15 */
-	}
+	set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		/*  Config STBC setting */
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 175954924d2c01..85d2f8bc6182b0 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -966,7 +966,7 @@ u8 rtw_get_mgntframe_raid(struct adapter *adapter, unsigned char network_type)
 
 void rtw_hal_update_sta_rate_mask(struct adapter *padapter, struct sta_info *psta)
 {
-	u8 i, rf_type, limit;
+	u8 i, limit;
 	u32 tx_ra_bitmap;
 
 	if (!psta)
@@ -982,11 +982,7 @@ void rtw_hal_update_sta_rate_mask(struct adapter *padapter, struct sta_info *pst
 
 	/* n mode ra_bitmap */
 	if (psta->htpriv.ht_option) {
-		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-		if (rf_type == RF_2T2R)
-			limit = 16; /*  2R */
-		else
-			limit = 8; /*   1R */
+		limit = 8; /*   1R */
 
 		for (i = 0; i < limit; i++) {
 			if (psta->htpriv.ht_cap.supp_mcs_set[i/8] & BIT(i%8))
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index b7c4b1cf204e1f..6a4347f7bf3bbd 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -1171,7 +1171,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork);
 
 void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr);
 
-u16 rtw_mcs_rate(u8 rf_type, u8 bw_40MHz, u8 short_GI, unsigned char * MCS_rate);
+u16 rtw_mcs_rate(u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate);
 
 int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u8 *action);
 const char *action_public_str(u8 action);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 42978ac860e9fa..e1ff68621a5367 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -3196,7 +3196,7 @@ static int cfg80211_rtw_sched_scan_stop(struct wiphy *wiphy,
 }
 #endif /* CONFIG_PNO_SUPPORT */
 
-static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum nl80211_band band, u8 rf_type)
+static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum nl80211_band band)
 {
 
 #define MAX_BIT_RATE_40MHZ_MCS15	300	/* Mbps */
@@ -3229,44 +3229,23 @@ static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum
 	 *if BW_40 rx_mask[4]= 0x01;
 	 *highest supported RX rate
 	 */
-	if (rf_type == RF_1T1R)
-	{
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0x00;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-
-		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS7);
-	}
-	else if ((rf_type == RF_1T2R) || (rf_type == RF_2T2R))
-	{
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0xFF;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-
-		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS15);
-	}
-	else
-	{
-		DBG_8192C("%s, error rf_type =%d\n", __func__, rf_type);
-	}
+	ht_cap->mcs.rx_mask[0] = 0xFF;
+	ht_cap->mcs.rx_mask[1] = 0x00;
+	ht_cap->mcs.rx_mask[4] = 0x01;
 
+	ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS7);
 }
 
 void rtw_cfg80211_init_wiphy(struct adapter *padapter)
 {
-	u8 rf_type;
 	struct ieee80211_supported_band *bands;
 	struct wireless_dev *pwdev = padapter->rtw_wdev;
 	struct wiphy *wiphy = pwdev->wiphy;
 
-	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-
-	DBG_8192C("%s:rf_type =%d\n", __func__, rf_type);
-
 	{
 		bands = wiphy->bands[NL80211_BAND_2GHZ];
 		if (bands)
-			rtw_cfg80211_init_ht_capab(&bands->ht_cap, NL80211_BAND_2GHZ, rf_type);
+			rtw_cfg80211_init_ht_capab(&bands->ht_cap, NL80211_BAND_2GHZ);
 	}
 
 	/* init regulary domain */
-- 
2.53.0

