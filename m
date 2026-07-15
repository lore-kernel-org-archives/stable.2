Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D441DDEF
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114196; cv=none; b=jhCyIG62GGm9nshAA2Iteh/ECsbRO0ir2srNaK1YIUAzqgPM7scuhTYoKhkbo/DNiJxtMcyH3OPEqggUWRuDdKIREZO8H3RinQTETWOOAvPZTNusE560OUUl/4MaFMBUj+Ee1PymE7CP8AnG5YMDUKDPEU1q63/KwVmJu1VmXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114196; c=relaxed/simple;
	bh=XPEqwR4sVWa6I2cMXOseB5xOF2Ai0HJnG/ICfG5K2EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pySJbam4Gtjd7bjqIi4PkjtQcdSmgqr3qk828sDpoHOGDRAU1O06ZX9qZX4rmKdc1ahf9LpoZhYuPD9T3CWFWpPFYjsqSnQeODIP7jhoaR8CR//MxL6VFSjwjMgxOa5UMlAXaerDV5I/No4pi6kfSgjrNXHh7ziXj8VS14yDo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndM1k0/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndM1k0/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFA71F00A3A;
	Wed, 15 Jul 2026 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114189;
	bh=WzhmlHBdWPr69lnlM8uer1Kqhv1/TGvp0H9lbC3EKDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ndM1k0/5q4KzpgexD7tOxtcXtaWqRy9T9DdB6ieKhSsXTHaCsjZHobTlA1RoDABVE
	 l4pggHDgQ8KqabMlDoVo5QnFTJKnFVv21jhvgnoJfbSxUypL476kn7C/Asd63T9W5a
	 u9AI1wbFo4b2Ws6dOXfsUpx/Z0v8Iuae3xBgiIGSFO7VjBbj9+Hkm7czzksX3UsDza
	 KP299F6MhzMcu9vfbc15tTomE0+TuUXWyi7fdFLxW/IOwjDK9Wl+zbHTyplpT44oH9
	 wEE0YhmxIQND7JzETjKy1Ja/qhEzgbgd5EJhaR+KqD6Yeo4sJNERmREgCbVxJ4/UM1
	 Hjp7C3s8yQexQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 03/10] staging: rtl8723bs: fix camel case in struct wlan_bssid_ex
Date: Wed, 15 Jul 2026 07:16:18 -0400
Message-ID: <20260715111625.647536-3-sashal@kernel.org>
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

[ Upstream commit d3fcee1b78a533c256077f1300dd236801397cf7 ]

fix camel case in struct wlan_bssid_ex.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/561065e95ff38f0dbedf030c3acf0498396a1759.1626874164.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 126 ++++----
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  50 +--
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  58 ++--
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  14 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 290 +++++++++---------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 268 ++++++++--------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  66 ++--
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       |   2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  54 ++--
 drivers/staging/rtl8723bs/include/rtw_mlme.h  |   6 +-
 .../staging/rtl8723bs/include/wlan_bssdef.h   |  30 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  74 ++---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 126 ++++----
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  12 +-
 15 files changed, 589 insertions(+), 589 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 4f270d509ad303..ce52093122ebde 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -61,7 +61,7 @@ static void update_BCNTIM(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
-	unsigned char *pie = pnetwork_mlmeext->IEs;
+	unsigned char *pie = pnetwork_mlmeext->ies;
 
 	/* DBG_871X("%s\n", __func__); */
 
@@ -78,7 +78,7 @@ static void update_BCNTIM(struct adapter *padapter)
 			pie + _FIXED_IE_LENGTH_,
 			_TIM_IE_,
 			&tim_ielen,
-			pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_
+			pnetwork_mlmeext->ie_length - _FIXED_IE_LENGTH_
 		);
 		if (p != NULL && tim_ielen > 0) {
 			tim_ielen += 2;
@@ -87,7 +87,7 @@ static void update_BCNTIM(struct adapter *padapter)
 
 			tim_ie_offset = (sint)(p - pie);
 
-			remainder_ielen = pnetwork_mlmeext->IELength - tim_ie_offset - tim_ielen;
+			remainder_ielen = pnetwork_mlmeext->ie_length - tim_ie_offset - tim_ielen;
 
 			/* append TIM IE from dst_ie offset */
 			dst_ie = p;
@@ -102,7 +102,7 @@ static void update_BCNTIM(struct adapter *padapter)
 				pie + _BEACON_IE_OFFSET_,
 				_SSID_IE_,
 				&tmp_len,
-				(pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
+				(pnetwork_mlmeext->ie_length - _BEACON_IE_OFFSET_)
 			);
 			if (p != NULL)
 				offset += tmp_len + 2;
@@ -111,7 +111,7 @@ static void update_BCNTIM(struct adapter *padapter)
 			p = rtw_get_ie(
 				pie + _BEACON_IE_OFFSET_,
 				_SUPPORTEDRATES_IE_, &tmp_len,
-				(pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
+				(pnetwork_mlmeext->ie_length - _BEACON_IE_OFFSET_)
 			);
 			if (p !=  NULL)
 				offset += tmp_len + 2;
@@ -121,7 +121,7 @@ static void update_BCNTIM(struct adapter *padapter)
 
 			premainder_ie = pie + offset;
 
-			remainder_ielen = pnetwork_mlmeext->IELength - offset - tim_ielen;
+			remainder_ielen = pnetwork_mlmeext->ie_length - offset - tim_ielen;
 
 			/* append TIM IE from offset */
 			dst_ie = pie + offset;
@@ -173,7 +173,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		}
 
 		offset =  (uint)(dst_ie - pie);
-		pnetwork_mlmeext->IELength = offset + remainder_ielen;
+		pnetwork_mlmeext->ie_length = offset + remainder_ielen;
 	}
 }
 
@@ -426,7 +426,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 	shortGIrate = query_ra_short_GI(psta);
 
-	if (pcur_network->Configuration.DSConfig > 14) {
+	if (pcur_network->configuration.DSConfig > 14) {
 		if (tx_ra_bitmap & 0xffff000)
 			sta_band |= WIRELESS_11_5N;
 
@@ -492,17 +492,17 @@ void update_bmc_sta(struct adapter *padapter)
 		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
 
 		/* prepare for add_RATid */
-		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->SupportedRates);
+		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
 		network_type = rtw_check_network_type(
-			(u8 *)&pcur_network->SupportedRates,
+			(u8 *)&pcur_network->supported_rates,
 			supportRateNum,
-			pcur_network->Configuration.DSConfig
+			pcur_network->configuration.DSConfig
 		);
 		if (IsSupportedTxCCK(network_type)) {
 			network_type = WIRELESS_11B;
 		} else if (network_type == WIRELESS_INVALID) { /*  error handling */
 
-			if (pcur_network->Configuration.DSConfig > 14)
+			if (pcur_network->configuration.DSConfig > 14)
 				network_type = WIRELESS_11A;
 			else
 				network_type = WIRELESS_11B;
@@ -679,8 +679,8 @@ static void update_ap_info(struct adapter *padapter, struct sta_info *psta)
 
 	psta->wireless_mode = pmlmeext->cur_wireless_mode;
 
-	psta->bssratelen = rtw_get_rateset_len(pnetwork->SupportedRates);
-	memcpy(psta->bssrateset, pnetwork->SupportedRates, psta->bssratelen);
+	psta->bssratelen = rtw_get_rateset_len(pnetwork->supported_rates);
+	memcpy(psta->bssrateset, pnetwork->supported_rates, psta->bssratelen);
 
 	/* HT related cap */
 	if (phtpriv_ap->ht_option) {
@@ -775,16 +775,16 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 
 	/* DBG_871X("%s\n", __func__); */
 
-	bcn_interval = (u16)pnetwork->Configuration.BeaconPeriod;
-	cur_channel = pnetwork->Configuration.DSConfig;
+	bcn_interval = (u16)pnetwork->configuration.BeaconPeriod;
+	cur_channel = pnetwork->configuration.DSConfig;
 	cur_bwmode = CHANNEL_WIDTH_20;
 	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	/* check if there is wps ie, */
 	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
 	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
-	if (!rtw_get_wps_ie(pnetwork->IEs + _FIXED_IE_LENGTH_,
-			    pnetwork->IELength - _FIXED_IE_LENGTH_, NULL, NULL))
+	if (!rtw_get_wps_ie(pnetwork->ies + _FIXED_IE_LENGTH_,
+			    pnetwork->ie_length - _FIXED_IE_LENGTH_, NULL, NULL))
 		pmlmeext->bstart_bss = true;
 
 	/* todo: update wmm, ht cap */
@@ -815,7 +815,7 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	Set_MSR(padapter, _HW_STATE_AP_);
 
 	/* Set BSSID REG */
-	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pnetwork->MacAddress);
+	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pnetwork->mac_address);
 
 	/* Set EDCA param reg */
 	acparm = 0x002F3217; /*  VO */
@@ -856,10 +856,10 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 
 	/* set channel, bwmode */
 	p = rtw_get_ie(
-		(pnetwork->IEs + sizeof(struct ndis_802_11_fix_ie)),
+		(pnetwork->ies + sizeof(struct ndis_802_11_fix_ie)),
 		_HT_ADD_INFO_IE_,
 		&ie_len,
-		(pnetwork->IELength - sizeof(struct ndis_802_11_fix_ie))
+		(pnetwork->ie_length - sizeof(struct ndis_802_11_fix_ie))
 	);
 	if (p && ie_len) {
 		pht_info = (struct HT_info_element *)(p + 2);
@@ -908,14 +908,14 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	pmlmeext->cur_wireless_mode = pmlmepriv->cur_network.network_type;
 
 	/* let pnetwork_mlmeext == pnetwork_mlme. */
-	memcpy(pnetwork_mlmeext, pnetwork, pnetwork->Length);
+	memcpy(pnetwork_mlmeext, pnetwork, pnetwork->length);
 
 	/* update cur_wireless_mode */
 	update_wireless_mode(padapter);
 
 	/* update RRSR after set channel and bandwidth */
-	UpdateBrateTbl(padapter, pnetwork->SupportedRates);
-	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->SupportedRates);
+	UpdateBrateTbl(padapter, pnetwork->supported_rates);
+	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->supported_rates);
 
 	/* update capability after cur_wireless_mode updated */
 	update_capinfo(
@@ -959,7 +959,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex
 		*pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
-	u8 *ie = pbss_network->IEs;
+	u8 *ie = pbss_network->ies;
 
 	/* SSID */
 	/* Supported rates */
@@ -980,23 +980,23 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	if (len < 0 || len > MAX_IE_SZ)
 		return _FAIL;
 
-	pbss_network->IELength = len;
+	pbss_network->ie_length = len;
 
 	memset(ie, 0, MAX_IE_SZ);
 
-	memcpy(ie, pbuf, pbss_network->IELength);
+	memcpy(ie, pbuf, pbss_network->ie_length);
 
-	if (pbss_network->InfrastructureMode != Ndis802_11APMode)
+	if (pbss_network->infrastructure_mode != Ndis802_11APMode)
 		return _FAIL;
 
-	pbss_network->Rssi = 0;
+	pbss_network->rssi = 0;
 
-	memcpy(pbss_network->MacAddress, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pbss_network->mac_address, myid(&(padapter->eeprompriv)), ETH_ALEN);
 
 	/* beacon interval */
 	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
-	/* pbss_network->Configuration.BeaconPeriod = le16_to_cpu(*(unsigned short*)p); */
-	pbss_network->Configuration.BeaconPeriod = get_unaligned_le16(p);
+	/* pbss_network->configuration.BeaconPeriod = le16_to_cpu(*(unsigned short*)p); */
+	pbss_network->configuration.BeaconPeriod = get_unaligned_le16(p);
 
 	/* capability */
 	/* cap = *(unsigned short *)rtw_get_capability_from_ie(ie); */
@@ -1008,26 +1008,26 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		_SSID_IE_,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
-		memset(&pbss_network->Ssid, 0, sizeof(struct ndis_802_11_ssid));
-		memcpy(pbss_network->Ssid.Ssid, (p + 2), ie_len);
-		pbss_network->Ssid.SsidLength = ie_len;
+		memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
+		memcpy(pbss_network->ssid.Ssid, (p + 2), ie_len);
+		pbss_network->ssid.SsidLength = ie_len;
 	}
 
 	/* channel */
 	channel = 0;
-	pbss_network->Configuration.Length = 0;
+	pbss_network->configuration.Length = 0;
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
 		_DSSET_IE_, &ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		channel = *(p + 2);
 
-	pbss_network->Configuration.DSConfig = channel;
+	pbss_network->configuration.DSConfig = channel;
 
 	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
 	/*  get supported rates */
@@ -1035,7 +1035,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		_SUPPORTEDRATES_IE_,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p !=  NULL) {
 		memcpy(supportRate, p + 2, ie_len);
@@ -1047,7 +1047,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		_EXT_SUPPORTEDRATES_IE_,
 		&ie_len,
-		pbss_network->IELength - _BEACON_IE_OFFSET_
+		pbss_network->ie_length - _BEACON_IE_OFFSET_
 	);
 	if (p !=  NULL) {
 		memcpy(supportRate + supportRateNum, p + 2, ie_len);
@@ -1056,23 +1056,23 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
 
-	rtw_set_supported_rate(pbss_network->SupportedRates, network_type);
+	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
 
 	/* parsing ERP_IE */
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
 		_ERPINFO_IE_,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		ERP_IE_handler(padapter, (struct ndis_80211_var_ie *)p);
 
 	/* update privacy/security */
 	if (cap & BIT(4))
-		pbss_network->Privacy = 1;
+		pbss_network->privacy = 1;
 	else
-		pbss_network->Privacy = 0;
+		pbss_network->privacy = 0;
 
 	psecuritypriv->wpa_psk = 0;
 
@@ -1084,7 +1084,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		_RSN_IE_2_,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
 		if (rtw_parse_wpa2_ie(
@@ -1114,7 +1114,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 			p,
 			_SSN_IE_1_,
 			&ie_len,
-			(pbss_network->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2))
+			(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
 		);
 		if ((p) && (!memcmp(p + 2, OUI1, 4))) {
 			if (rtw_parse_wpa_ie(
@@ -1150,7 +1150,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 				p,
 				_VENDOR_SPECIFIC_IE_,
 				&ie_len,
-				(pbss_network->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2))
+				(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
 			);
 			if ((p) && !memcmp(p + 2, WMM_PARA_IE, 6)) {
 				pmlmepriv->qospriv.qos_option = 1;
@@ -1176,7 +1176,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		_HT_CAPABILITY_IE_,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
 		u8 rf_type = 0;
@@ -1239,26 +1239,26 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		ie + _BEACON_IE_OFFSET_,
 		_HT_ADD_INFO_IE_,
 		&ie_len,
-		(pbss_network->IELength - _BEACON_IE_OFFSET_)
+		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		pHT_info_ie = p;
 
 	switch (network_type) {
 	case WIRELESS_11B:
-		pbss_network->NetworkTypeInUse = Ndis802_11DS;
+		pbss_network->network_type_in_use = Ndis802_11DS;
 		break;
 	case WIRELESS_11G:
 	case WIRELESS_11BG:
 	case WIRELESS_11G_24N:
 	case WIRELESS_11BG_24N:
-		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
+		pbss_network->network_type_in_use = Ndis802_11OFDM24;
 		break;
 	case WIRELESS_11A:
-		pbss_network->NetworkTypeInUse = Ndis802_11OFDM5;
+		pbss_network->network_type_in_use = Ndis802_11OFDM5;
 		break;
 	default:
-		pbss_network->NetworkTypeInUse = Ndis802_11OFDM24;
+		pbss_network->network_type_in_use = Ndis802_11OFDM24;
 		break;
 	}
 
@@ -1285,7 +1285,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		HT_info_handler(padapter, (struct ndis_80211_var_ie *)pHT_info_ie);
 	}
 
-	pbss_network->Length = get_wlan_bssid_ex_sz(
+	pbss_network->length = get_wlan_bssid_ex_sz(
 		(struct wlan_bssid_ex  *)pbss_network
 	);
 
@@ -1294,9 +1294,9 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	rtw_startbss_cmd(padapter, RTW_CMDF_WAIT_ACK);
 
 	/* alloc sta_info for ap itself */
-	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->MacAddress);
+	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->mac_address);
 	if (!psta) {
-		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->MacAddress);
+		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->mac_address);
 		if (psta == NULL)
 			return _FAIL;
 	}
@@ -1586,7 +1586,7 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
-	unsigned char *p, *ie = pnetwork->IEs;
+	unsigned char *p, *ie = pnetwork->ies;
 	u32 len = 0;
 
 	DBG_871X("%s, ERP_enable =%d\n", __func__, pmlmeinfo->ERP_enable);
@@ -1599,7 +1599,7 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 		ie + _BEACON_IE_OFFSET_,
 		_ERPINFO_IE_,
 		&len,
-		(pnetwork->IELength - _BEACON_IE_OFFSET_)
+		(pnetwork->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && len > 0) {
 		struct ndis_80211_var_ie *pIE = (struct ndis_80211_var_ie *)p;
@@ -1657,8 +1657,8 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
-	unsigned char *ie = pnetwork->IEs;
-	u32 ielen = pnetwork->IELength;
+	unsigned char *ie = pnetwork->ies;
+	u32 ielen = pnetwork->ie_length;
 
 	DBG_871X("%s\n", __func__);
 
@@ -1696,8 +1696,8 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
 
-		/* update IELength */
-		pnetwork->IELength = wps_offset + (wps_ielen + 2) + remainder_ielen;
+		/* update ie_length */
+		pnetwork->ie_length = wps_offset + (wps_ielen + 2) + remainder_ielen;
 	}
 
 	kfree(pbackup_remainder_ie);
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index cee05385f87279..64f13ef15d990a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -695,7 +695,7 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 	pcmd->rsp = NULL;
 	pcmd->rspsz = 0;
 
-	pdev_network->Length = pcmd->cmdsz;
+	pdev_network->length = pcmd->cmdsz;
 
 	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
 
@@ -761,7 +761,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct ht_priv 		*phtpriv = &pmlmepriv->htpriv;
-	enum NDIS_802_11_NETWORK_INFRASTRUCTURE ndis_network_mode = pnetwork->network.InfrastructureMode;
+	enum NDIS_802_11_NETWORK_INFRASTRUCTURE ndis_network_mode = pnetwork->network.infrastructure_mode;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u32 tmp_len;
@@ -779,7 +779,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd: memory allocate for cmd_obj fail!!!\n"));
 		goto exit;
 	}
-	/* for IEs is fix buf size */
+	/* for ies is fix buf size */
 	t_len = sizeof(struct wlan_bssid_ex);
 
 
@@ -808,34 +808,34 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	memcpy(psecnetwork, &pnetwork->network, get_wlan_bssid_ex_sz(&pnetwork->network));
 
-	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->IELength;
+	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->ie_length;
 
-	if ((psecnetwork->IELength-12) < (256-1)) {
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], psecnetwork->IELength-12);
+	if ((psecnetwork->ie_length-12) < (256-1)) {
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], psecnetwork->ie_length-12);
 	} else {
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], (256-1));
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], (256-1));
 	}
 
-	psecnetwork->IELength = 0;
+	psecnetwork->ie_length = 0;
 	/*  Added by Albert 2009/02/18 */
 	/*  If the driver wants to use the bssid to create the connection. */
 	/*  If not,  we have to copy the connecting AP's MAC address to it so that */
 	/*  the driver just has the bssid information for PMKIDList searching. */
 
 	if (pmlmepriv->assoc_by_bssid == false) {
-		memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.MacAddress[0], ETH_ALEN);
+		memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.mac_address[0], ETH_ALEN);
 	}
 
-	psecnetwork->IELength = rtw_restruct_sec_ie(padapter, &pnetwork->network.IEs[0], &psecnetwork->IEs[0], pnetwork->network.IELength);
+	psecnetwork->ie_length = rtw_restruct_sec_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.ie_length);
 
 
 	pqospriv->qos_option = 0;
 
 	if (pregistrypriv->wmm_enable) {
-		tmp_len = rtw_restruct_wmm_ie(padapter, &pnetwork->network.IEs[0], &psecnetwork->IEs[0], pnetwork->network.IELength, psecnetwork->IELength);
+		tmp_len = rtw_restruct_wmm_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.ie_length, psecnetwork->ie_length);
 
-		if (psecnetwork->IELength != tmp_len) {
-			psecnetwork->IELength = tmp_len;
+		if (psecnetwork->ie_length != tmp_len) {
+			psecnetwork->ie_length = tmp_len;
 			pqospriv->qos_option = 1; /* There is WMM IE in this corresp. beacon */
 		} else {
 			pqospriv->qos_option = 0;/* There is no WMM IE in this corresp. beacon */
@@ -843,7 +843,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	}
 
 	phtpriv->ht_option = false;
-	ptmp = rtw_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_, &tmp_len, pnetwork->network.IELength-12);
+	ptmp = rtw_get_ie(&pnetwork->network.ies[12], _HT_CAPABILITY_IE_, &tmp_len, pnetwork->network.ie_length-12);
 	if (pregistrypriv->ht_enable && ptmp && tmp_len > 0) {
 		/* 	Added by Albert 2010/06/23 */
 		/* 	For the WEP mode, we will use the bg mode to do the connection to avoid some IOT issue. */
@@ -853,18 +853,18 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 			(padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
 			rtw_ht_use_default_setting(padapter);
 
-			rtw_build_wmm_ie_ht(padapter, &psecnetwork->IEs[12], &psecnetwork->IELength);
+			rtw_build_wmm_ie_ht(padapter, &psecnetwork->ies[12], &psecnetwork->ie_length);
 
 			/* rtw_restructure_ht_ie */
-			rtw_restructure_ht_ie(padapter, &pnetwork->network.IEs[12], &psecnetwork->IEs[0],
-									pnetwork->network.IELength-12, &psecnetwork->IELength,
-									pnetwork->network.Configuration.DSConfig);
+			rtw_restructure_ht_ie(padapter, &pnetwork->network.ies[12], &psecnetwork->ies[0],
+									pnetwork->network.ie_length-12, &psecnetwork->ie_length,
+									pnetwork->network.configuration.DSConfig);
 		}
 	}
 
-	rtw_append_exented_cap(padapter, &psecnetwork->IEs[0], &psecnetwork->IELength);
+	rtw_append_exented_cap(padapter, &psecnetwork->ies[0], &psecnetwork->ie_length);
 
-	pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->network.IEs, pnetwork->network.IELength);
+	pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->network.ies, pnetwork->network.ie_length);
 
 	pcmd->cmdsz = get_wlan_bssid_ex_sz(psecnetwork);/* get cmdsz before endian conversion */
 
@@ -2050,9 +2050,9 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
+		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->mac_address);
 		if (!psta) {
-			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
+			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->mac_address);
 			if (psta == NULL) {
 				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nCan't alloc sta_info when createbss_cmd_callback\n"));
 				goto createbss_cmd_fail;
@@ -2075,8 +2075,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 			list_add_tail(&(pwlan->list), &pmlmepriv->scanned_queue.queue);
 		}
 
-		pnetwork->Length = get_wlan_bssid_ex_sz(pnetwork);
-		memcpy(&(pwlan->network), pnetwork, pnetwork->Length);
+		pnetwork->length = get_wlan_bssid_ex_sz(pnetwork);
+		memcpy(&(pwlan->network), pnetwork, pnetwork->length);
 		/* pwlan->fixed = true; */
 
 		/* list_add_tail(&(pwlan->list), &pmlmepriv->scanned_queue.queue); */
@@ -2085,7 +2085,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		memcpy(&tgt_network->network, pnetwork, (get_wlan_bssid_ex_sz(pnetwork)));
 
 		/*  reset DSConfig */
-		/* tgt_network->network.Configuration.DSConfig = (u32)rtw_ch2freq(pnetwork->Configuration.DSConfig); */
+		/* tgt_network->network.configuration.DSConfig = (u32)rtw_ch2freq(pnetwork->configuration.DSConfig); */
 
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index ac6e947214cbe0..a194e81688624f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -265,13 +265,13 @@ int rtw_ies_remove_ie(u8 *ies, uint *ies_len, uint offset, u8 eid, u8 *oui, u8 o
 	return ret;
 }
 
-void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
+void rtw_set_supported_rate(u8 *supported_rates, uint mode)
 {
-	memset(SupportedRates, 0, NDIS_802_11_LENGTH_RATES_EX);
+	memset(supported_rates, 0, NDIS_802_11_LENGTH_RATES_EX);
 
 	switch (mode) {
 	case WIRELESS_11B:
-		memcpy(SupportedRates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
+		memcpy(supported_rates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
 		break;
 
 	case WIRELESS_11G:
@@ -279,15 +279,15 @@ void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
 	case WIRELESS_11_5N:
 	case WIRELESS_11A_5N:/* Todo: no basic rate for ofdm ? */
 	case WIRELESS_11_5AC:
-		memcpy(SupportedRates, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
+		memcpy(supported_rates, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
 		break;
 
 	case WIRELESS_11BG:
 	case WIRELESS_11G_24N:
 	case WIRELESS_11_24N:
 	case WIRELESS_11BG_24N:
-		memcpy(SupportedRates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
-		memcpy(SupportedRates + IEEE80211_CCK_RATE_LEN, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
+		memcpy(supported_rates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
+		memcpy(supported_rates + IEEE80211_CCK_RATE_LEN, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
 		break;
 	}
 }
@@ -307,14 +307,14 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	u8 wireless_mode;
 	int	sz = 0, rateLen;
 	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
-	u8 *ie = pdev_network->IEs;
+	u8 *ie = pdev_network->ies;
 
 	/* timestamp will be inserted by hardware */
 	sz += 8;
 	ie += sz;
 
 	/* beacon interval : 2bytes */
-	*(__le16 *)ie = cpu_to_le16((u16)pdev_network->Configuration.BeaconPeriod);/* BCN_INTERVAL; */
+	*(__le16 *)ie = cpu_to_le16((u16)pdev_network->configuration.BeaconPeriod);/* BCN_INTERVAL; */
 	sz += 2;
 	ie += 2;
 
@@ -326,18 +326,18 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	if (pregistrypriv->preamble == PREAMBLE_SHORT)
 		*(__le16 *)ie |= cpu_to_le16(cap_ShortPremble);
 
-	if (pdev_network->Privacy)
+	if (pdev_network->privacy)
 		*(__le16 *)ie |= cpu_to_le16(cap_Privacy);
 
 	sz += 2;
 	ie += 2;
 
 	/* SSID */
-	ie = rtw_set_ie(ie, _SSID_IE_, pdev_network->Ssid.SsidLength, pdev_network->Ssid.Ssid, &sz);
+	ie = rtw_set_ie(ie, _SSID_IE_, pdev_network->ssid.SsidLength, pdev_network->ssid.Ssid, &sz);
 
 	/* supported rates */
 	if (pregistrypriv->wireless_mode == WIRELESS_11ABGN) {
-		if (pdev_network->Configuration.DSConfig > 14)
+		if (pdev_network->configuration.DSConfig > 14)
 			wireless_mode = WIRELESS_11A_5N;
 		else
 			wireless_mode = WIRELESS_11BG_24N;
@@ -345,26 +345,26 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 		wireless_mode = pregistrypriv->wireless_mode;
 	}
 
-	rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);
+	rtw_set_supported_rate(pdev_network->supported_rates, wireless_mode);
 
-	rateLen = rtw_get_rateset_len(pdev_network->SupportedRates);
+	rateLen = rtw_get_rateset_len(pdev_network->supported_rates);
 
 	if (rateLen > 8) {
-		ie = rtw_set_ie(ie, _SUPPORTEDRATES_IE_, 8, pdev_network->SupportedRates, &sz);
-		/* ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz); */
+		ie = rtw_set_ie(ie, _SUPPORTEDRATES_IE_, 8, pdev_network->supported_rates, &sz);
+		/* ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (pdev_network->supported_rates + 8), &sz); */
 	} else {
-		ie = rtw_set_ie(ie, _SUPPORTEDRATES_IE_, rateLen, pdev_network->SupportedRates, &sz);
+		ie = rtw_set_ie(ie, _SUPPORTEDRATES_IE_, rateLen, pdev_network->supported_rates, &sz);
 	}
 
 	/* DS parameter set */
-	ie = rtw_set_ie(ie, _DSSET_IE_, 1, (u8 *)&(pdev_network->Configuration.DSConfig), &sz);
+	ie = rtw_set_ie(ie, _DSSET_IE_, 1, (u8 *)&(pdev_network->configuration.DSConfig), &sz);
 
 	/* IBSS Parameter Set */
 
-	ie = rtw_set_ie(ie, _IBSS_PARA_IE_, 2, (u8 *)&(pdev_network->Configuration.ATIMWindow), &sz);
+	ie = rtw_set_ie(ie, _IBSS_PARA_IE_, 2, (u8 *)&(pdev_network->configuration.ATIMWindow), &sz);
 
 	if (rateLen > 8) {
-		ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz);
+		ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (pdev_network->supported_rates + 8), &sz);
 	}
 
 	/* HT Cap. */
@@ -373,7 +373,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 		/* todo: */
 	}
 
-	/* pdev_network->IELength =  sz; update IELength */
+	/* pdev_network->ie_length =  sz; update ie_length */
 
 	/* return _SUCCESS; */
 
@@ -1141,7 +1141,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	int group_cipher = 0, pairwise_cipher = 0, is8021x = 0;
 	int ret = _FAIL;
 
-	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+	pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 
 	if (pbuf && (wpa_ielen > 0)) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_cipher_info: wpa_ielen: %d", wpa_ielen));
@@ -1154,7 +1154,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 			ret = _SUCCESS;
 		}
 	} else {
-		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+		pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 
 		if (pbuf && (wpa_ielen > 0)) {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE\n"));
@@ -1186,18 +1186,18 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	unsigned char 	*p;
 	__le16 le_cap;
 
-	memcpy((u8 *)&le_cap, rtw_get_capability_from_ie(pnetwork->network.IEs), 2);
+	memcpy((u8 *)&le_cap, rtw_get_capability_from_ie(pnetwork->network.ies), 2);
 	cap = le16_to_cpu(le_cap);
 	if (cap & WLAN_CAPABILITY_PRIVACY) {
 		bencrypt = 1;
-		pnetwork->network.Privacy = 1;
+		pnetwork->network.privacy = 1;
 	} else {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
-	rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
+	rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, NULL, &rsn_len, NULL, &wpa_len);
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.ssid.Ssid));
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.ssid.Ssid));
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 	if (rsn_len > 0) {
@@ -1216,7 +1216,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 
 	/* get bwmode and ch_offset */
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 			pnetwork->BcnInfo.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
@@ -1224,7 +1224,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 			pnetwork->BcnInfo.ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_info = (struct HT_info_element *)(p + 2);
 			pnetwork->BcnInfo.ht_info_infos_0 = pht_info->infos[0];
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 8b5f6a66bfb8df..1f60e8572e6843 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -110,9 +110,9 @@ u8 rtw_do_join(struct adapter *padapter)
 
 				pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
-				pibss = padapter->registrypriv.dev_network.MacAddress;
+				pibss = padapter->registrypriv.dev_network.mac_address;
 
-				memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+				memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 				rtw_update_registrypriv_dev_network(padapter);
 
@@ -184,13 +184,13 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
 
-		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
+		if (!memcmp(&pmlmepriv->cur_network.network.mac_address, bssid, ETH_ALEN)) {
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
 				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
 		} else {
 			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set BSSID not the same bssid\n"));
 			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid ="MAC_FMT"\n", MAC_ARG(bssid)));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("cur_bssid ="MAC_FMT"\n", MAC_ARG(pmlmepriv->cur_network.network.MacAddress)));
+			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("cur_bssid ="MAC_FMT"\n", MAC_ARG(pmlmepriv->cur_network.network.mac_address)));
 
 			rtw_disassoc_cmd(padapter, 0, true);
 
@@ -411,7 +411,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct	wlan_network	*cur_network = &pmlmepriv->cur_network;
-	enum NDIS_802_11_NETWORK_INFRASTRUCTURE *pold_state = &(cur_network->network.InfrastructureMode);
+	enum NDIS_802_11_NETWORK_INFRASTRUCTURE *pold_state = &(cur_network->network.infrastructure_mode);
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
 		 ("+rtw_set_802_11_infrastructure_mode: old =%d new =%d fw_state = 0x%08x\n",
@@ -664,8 +664,8 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 			psta->htpriv.ht_cap.supp_mcs_set
 		);
 	} else {
-		while ((pcur_bss->SupportedRates[i] != 0) && (pcur_bss->SupportedRates[i] != 0xFF)) {
-			rate = pcur_bss->SupportedRates[i]&0x7F;
+		while ((pcur_bss->supported_rates[i] != 0) && (pcur_bss->supported_rates[i] != 0xFF)) {
+			rate = pcur_bss->supported_rates[i]&0x7F;
 			if (rate > max_rate)
 				max_rate = rate;
 			i++;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 7cc3a0e4e08934..81b775b8accfe0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -27,7 +27,7 @@ int	rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = WIFI_STATION_STATE; /*  Must sync with rtw_wdev_alloc() */
 	/*  wdev->iftype = NL80211_IFTYPE_STATION */
-	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
+	pmlmepriv->cur_network.network.infrastructure_mode = Ndis802_11AutoUnknown;
 	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
 
 	spin_lock_init(&pmlmepriv->lock);
@@ -208,7 +208,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 
 	pmlmepriv->num_of_scanned--;
 
-	/* DBG_871X("_rtw_free_network:SSID =%s\n", pnetwork->network.Ssid.Ssid); */
+	/* DBG_871X("_rtw_free_network:SSID =%s\n", pnetwork->network.ssid.Ssid); */
 
 	spin_unlock_bh(&free_queue->lock);
 }
@@ -259,7 +259,7 @@ struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 	while (plist != phead) {
 		pnetwork = LIST_CONTAINOR(plist, struct wlan_network, list);
 
-		if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
+		if (!memcmp(addr, pnetwork->network.mac_address, ETH_ALEN))
 			break;
 
 		plist = get_next(plist);
@@ -333,7 +333,7 @@ u16 rtw_get_capability(struct wlan_bssid_ex *bss)
 {
 	__le16	val;
 
-	memcpy((u8 *)&val, rtw_get_capability_from_ie(bss->IEs), 2);
+	memcpy((u8 *)&val, rtw_get_capability_from_ie(bss->ies), 2);
 
 	return le16_to_cpu(val);
 }
@@ -362,7 +362,7 @@ static struct	wlan_network *rtw_dequeue_network(struct __queue *queue)
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork);
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork)
 {
-	/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_network ==> ssid = %s\n\n" , pnetwork->network.Ssid.Ssid)); */
+	/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_network ==> ssid = %s\n\n" , pnetwork->network.ssid.Ssid)); */
 	_rtw_free_network_nolock(&(padapter->mlmepriv), pnetwork);
 	rtw_cfg80211_unlink_bss(padapter, pnetwork);
 }
@@ -385,10 +385,10 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	if ((psecuritypriv->dot11PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == 0))
+		    (pnetwork->network.privacy == 0))
 		ret = false;
 	else if ((psecuritypriv->dot11PrivacyAlgrthm == _NO_PRIVACY_) &&
-		 (pnetwork->network.Privacy == 1))
+		 (pnetwork->network.privacy == 1))
 		ret = false;
 	else
 		ret = true;
@@ -400,9 +400,9 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 {
 	/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("(%s,%d)(%s,%d)\n", */
-	/* 		a->Ssid.Ssid, a->Ssid.SsidLength, b->Ssid.Ssid, b->Ssid.SsidLength)); */
-	return (a->Ssid.SsidLength == b->Ssid.SsidLength)
-		&&  !memcmp(a->Ssid.Ssid, b->Ssid.Ssid, a->Ssid.SsidLength);
+	/* 		a->ssid.Ssid, a->ssid.SsidLength, b->ssid.Ssid, b->ssid.SsidLength)); */
+	return (a->ssid.SsidLength == b->ssid.SsidLength)
+		&&  !memcmp(a->ssid.Ssid, b->ssid.Ssid, a->ssid.SsidLength);
 }
 
 int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 feature)
@@ -413,16 +413,16 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 	if (rtw_bug_check(dst, src, &s_cap, &d_cap) == false)
 			return false;
 
-	memcpy((u8 *)&tmps, rtw_get_capability_from_ie(src->IEs), 2);
-	memcpy((u8 *)&tmpd, rtw_get_capability_from_ie(dst->IEs), 2);
+	memcpy((u8 *)&tmps, rtw_get_capability_from_ie(src->ies), 2);
+	memcpy((u8 *)&tmpd, rtw_get_capability_from_ie(dst->ies), 2);
 
 	s_cap = le16_to_cpu(tmps);
 	d_cap = le16_to_cpu(tmpd);
 
-	return (src->Ssid.SsidLength == dst->Ssid.SsidLength) &&
-		/* 	(src->Configuration.DSConfig == dst->Configuration.DSConfig) && */
-			((!memcmp(src->MacAddress, dst->MacAddress, ETH_ALEN))) &&
-			((!memcmp(src->Ssid.Ssid, dst->Ssid.Ssid, src->Ssid.SsidLength))) &&
+	return (src->ssid.SsidLength == dst->ssid.SsidLength) &&
+		/* 	(src->configuration.DSConfig == dst->configuration.DSConfig) && */
+			((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
+			((!memcmp(src->ssid.Ssid, dst->ssid.Ssid, src->ssid.SsidLength))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
 			(d_cap & WLAN_CAPABILITY_IBSS)) &&
 			((s_cap & WLAN_CAPABILITY_BSS) ==
@@ -485,19 +485,19 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	struct adapter *padapter, bool update_ie)
 {
-	long rssi_ori = dst->Rssi;
+	long rssi_ori = dst->rssi;
 
-	u8 sq_smp = src->PhyInfo.SignalQuality;
+	u8 sq_smp = src->phy_info.SignalQuality;
 
 	u8 ss_final;
 	u8 sq_final;
 	long rssi_final;
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
-	if (strcmp(dst->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
+	if (strcmp(dst->ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
 		DBG_871X(FUNC_ADPT_FMT" %s("MAC_FMT", ch%u) ss_ori:%3u, sq_ori:%3u, rssi_ori:%3ld, ss_smp:%3u, sq_smp:%3u, rssi_smp:%3ld\n"
 			, FUNC_ADPT_ARG(padapter)
-			, src->Ssid.Ssid, MAC_ARG(src->MacAddress), src->Configuration.DSConfig
+			, src->ssid.Ssid, MAC_ARG(src->mac_address), src->configuration.DSConfig
 			, ss_ori, sq_ori, rssi_ori
 			, ss_smp, sq_smp, rssi_smp
 		);
@@ -511,19 +511,19 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 		sq_final = padapter->recvpriv.signal_qual;
 		/* the rssi value here is undecorated, and will be used for antenna diversity */
 		if (sq_smp != 101) /* from the right channel */
-			rssi_final = (src->Rssi+dst->Rssi*4)/5;
+			rssi_final = (src->rssi+dst->rssi*4)/5;
 		else
 			rssi_final = rssi_ori;
 	} else {
 		if (sq_smp != 101) { /* from the right channel */
-			ss_final = ((u32)(src->PhyInfo.SignalStrength)+(u32)(dst->PhyInfo.SignalStrength)*4)/5;
-			sq_final = ((u32)(src->PhyInfo.SignalQuality)+(u32)(dst->PhyInfo.SignalQuality)*4)/5;
-			rssi_final = (src->Rssi+dst->Rssi*4)/5;
+			ss_final = ((u32)(src->phy_info.SignalStrength)+(u32)(dst->phy_info.SignalStrength)*4)/5;
+			sq_final = ((u32)(src->phy_info.SignalQuality)+(u32)(dst->phy_info.SignalQuality)*4)/5;
+			rssi_final = (src->rssi+dst->rssi*4)/5;
 		} else {
 			/* bss info not receiving from the right channel, use the original RX signal infos */
-			ss_final = dst->PhyInfo.SignalStrength;
-			sq_final = dst->PhyInfo.SignalQuality;
-			rssi_final = dst->Rssi;
+			ss_final = dst->phy_info.SignalStrength;
+			sq_final = dst->phy_info.SignalQuality;
+			rssi_final = dst->rssi;
 		}
 
 	}
@@ -534,15 +534,15 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 		memcpy((u8 *)dst, (u8 *)src, get_wlan_bssid_ex_sz(src));
 	}
 
-	dst->PhyInfo.SignalStrength = ss_final;
-	dst->PhyInfo.SignalQuality = sq_final;
-	dst->Rssi = rssi_final;
+	dst->phy_info.SignalStrength = ss_final;
+	dst->phy_info.SignalQuality = sq_final;
+	dst->rssi = rssi_final;
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
-	if (strcmp(dst->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
+	if (strcmp(dst->ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
 		DBG_871X(FUNC_ADPT_FMT" %s("MAC_FMT"), SignalStrength:%u, SignalQuality:%u, RawRSSI:%ld\n"
 			, FUNC_ADPT_ARG(padapter)
-			, dst->Ssid.Ssid, MAC_ARG(dst->MacAddress), dst->PhyInfo.SignalStrength, dst->PhyInfo.SignalQuality, dst->Rssi);
+			, dst->ssid.Ssid, MAC_ARG(dst->mac_address), dst->phy_info.SignalStrength, dst->phy_info.SignalQuality, dst->rssi);
 	}
 	#endif
 }
@@ -559,11 +559,11 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&(pmlmepriv->cur_network.network), pnetwork, 0))) {
 		/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,"Same Network\n"); */
 
-		/* if (pmlmepriv->cur_network.network.IELength<= pnetwork->IELength) */
+		/* if (pmlmepriv->cur_network.network.ie_length<= pnetwork->ie_length) */
 		{
 			update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
-			rtw_update_protection(adapter, (pmlmepriv->cur_network.network.IEs) + sizeof(struct ndis_802_11_fix_ie),
-									pmlmepriv->cur_network.network.IELength);
+			rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
+									pmlmepriv->cur_network.network.ie_length);
 		}
 	}
 }
@@ -632,8 +632,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			pnetwork->join_res = 0;
 
 			/* bss info not receiving from the right channel */
-			if (pnetwork->network.PhyInfo.SignalQuality == 101)
-				pnetwork->network.PhyInfo.SignalQuality = 0;
+			if (pnetwork->network.phy_info.SignalQuality == 101)
+				pnetwork->network.phy_info.SignalQuality = 0;
 		} else {
 			/* Otherwise just pull from the free list */
 
@@ -645,14 +645,14 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			}
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
-			target->Length = bssid_ex_sz;
+			target->length = bssid_ex_sz;
 			memcpy(&(pnetwork->network), target, bssid_ex_sz);
 
 			pnetwork->last_scanned = jiffies;
 
 			/* bss info not receiving from the right channel */
-			if (pnetwork->network.PhyInfo.SignalQuality == 101)
-				pnetwork->network.PhyInfo.SignalQuality = 0;
+			if (pnetwork->network.phy_info.SignalQuality == 101)
+				pnetwork->network.phy_info.SignalQuality = 0;
 
 			list_add_tail(&(pnetwork->list), &(queue->queue));
 
@@ -667,7 +667,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 		pnetwork->last_scanned = jiffies;
 
 		/* target.Reserved[0]== 1, means that scanned network is a bcn frame. */
-		if ((pnetwork->network.IELength > target->IELength) && (target->Reserved[0] == 1))
+		if ((pnetwork->network.ie_length > target->ie_length) && (target->Reserved[0] == 1))
 			update_ie = false;
 
 		/*  probe resp(3) > beacon(1) > probe req(2) */
@@ -720,10 +720,10 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	int bselected = true;
 
 	desired_encmode = psecuritypriv->ndisencryptstatus;
-	privacy = pnetwork->network.Privacy;
+	privacy = pnetwork->network.privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
+		if (rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -737,7 +737,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	    bselected = false;
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
-			p = rtw_get_ie(pnetwork->network.IEs + _BEACON_IE_OFFSET_, _RSN_IE_2_, &ie_len, (pnetwork->network.IELength - _BEACON_IE_OFFSET_));
+			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, _RSN_IE_2_, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
 			if (p && ie_len > 0)
 				bselected = true;
 			else
@@ -751,7 +751,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
-		if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
+		if (pnetwork->network.infrastructure_mode != pmlmepriv->cur_network.network.infrastructure_mode)
 			bselected = false;
 	}
 
@@ -772,7 +772,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_survey_event_callback, ssid =%s\n",  pnetwork->Ssid.Ssid));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_survey_event_callback, ssid =%s\n",  pnetwork->ssid.Ssid));
 
 	len = get_wlan_bssid_ex_sz(pnetwork);
 	if (len > (sizeof(struct wlan_bssid_ex))) {
@@ -785,14 +785,14 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 	/*  update IBSS_network 's timestamp */
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
 		/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,"rtw_survey_event_callback : WIFI_ADHOC_MASTER_STATE\n\n"); */
-		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress), pnetwork->MacAddress, ETH_ALEN)) {
+		if (!memcmp(&(pmlmepriv->cur_network.network.mac_address), pnetwork->mac_address, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
-			memcpy(pmlmepriv->cur_network.network.IEs, pnetwork->IEs, 8);
+			memcpy(pmlmepriv->cur_network.network.ies, pnetwork->ies, 8);
 			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
-			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->MacAddress);
+			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->mac_address);
 			if (ibss_wlan) {
-				memcpy(ibss_wlan->network.IEs, pnetwork->IEs, 8);
+				memcpy(ibss_wlan->network.ies, pnetwork->ies, 8);
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto exit;
 			}
@@ -802,8 +802,8 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  lock pmlmepriv->lock when you accessing network_q */
 	if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == false) {
-		if (pnetwork->Ssid.Ssid[0] == 0)
-			pnetwork->Ssid.SsidLength = 0;
+		if (pnetwork->ssid.Ssid[0] == 0)
+			pnetwork->ssid.SsidLength = 0;
 		rtw_add_network(adapter, pnetwork);
 	}
 
@@ -846,14 +846,14 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 				} else {
 					struct wlan_bssid_ex    *pdev_network = &(adapter->registrypriv.dev_network);
-					u8 *pibss = adapter->registrypriv.dev_network.MacAddress;
+					u8 *pibss = adapter->registrypriv.dev_network.mac_address;
 
 					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;because don't set assoc_timer */
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("switching to adhoc master\n"));
 
-					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+					memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 					rtw_update_registrypriv_dev_network(adapter);
 					rtw_generate_random_ibss(pibss);
@@ -900,7 +900,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
 				&& check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (rtw_select_roaming_candidate(pmlmepriv) == _SUCCESS) {
-					receive_disconnect(adapter, pmlmepriv->cur_network.network.MacAddress
+					receive_disconnect(adapter, pmlmepriv->cur_network.network.mac_address
 						, WLAN_REASON_ACTIVE_ROAM);
 				}
 			}
@@ -966,7 +966,7 @@ static void find_network(struct adapter *adapter)
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
-	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
+	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
 	if (!pwlan) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources : pwlan == NULL\n\n"));
 		return;
@@ -991,13 +991,13 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("tgt_network->network.MacAddress ="MAC_FMT" ssid =%s\n",
-		MAC_ARG(tgt_network->network.MacAddress), tgt_network->network.Ssid.Ssid));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("tgt_network->network.mac_address ="MAC_FMT" ssid =%s\n",
+		MAC_ARG(tgt_network->network.mac_address), tgt_network->network.ssid.Ssid));
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
-		psta = rtw_get_stainfo(&adapter->stapriv, tgt_network->network.MacAddress);
+		psta = rtw_get_stainfo(&adapter->stapriv, tgt_network->network.mac_address);
 		spin_lock_bh(&(pstapriv->sta_hash_lock));
 		rtw_free_stainfo(adapter,  psta);
 
@@ -1129,9 +1129,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
-	psta = rtw_get_stainfo(pstapriv, pnetwork->network.MacAddress);
+	psta = rtw_get_stainfo(pstapriv, pnetwork->network.mac_address);
 	if (!psta)
-		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.MacAddress);
+		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.mac_address);
 
 	if (psta) { /* update ptarget_sta */
 
@@ -1142,8 +1142,8 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		update_sta_info(padapter, psta);
 
 		/* update station supportRate */
-		psta->bssratelen = rtw_get_rateset_len(pnetwork->network.SupportedRates);
-		memcpy(psta->bssrateset, pnetwork->network.SupportedRates, psta->bssratelen);
+		psta->bssratelen = rtw_get_rateset_len(pnetwork->network.supported_rates);
+		memcpy(psta->bssrateset, pnetwork->network.supported_rates, psta->bssratelen);
 		rtw_hal_update_sta_rate_mask(padapter, psta);
 
 		psta->wireless_mode = pmlmeext->cur_wireless_mode;
@@ -1227,22 +1227,22 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	DBG_871X("%s\n", __func__);
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\nfw_state:%x, BSSID:"MAC_FMT"\n"
-		, get_fwstate(pmlmepriv), MAC_ARG(pnetwork->network.MacAddress)));
+		, get_fwstate(pmlmepriv), MAC_ARG(pnetwork->network.mac_address)));
 
 	/*  why not use ptarget_wlan?? */
-	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
-	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
-	cur_network->network.IELength = ptarget_wlan->network.IELength;
-	memcpy(&cur_network->network.IEs[0], &ptarget_wlan->network.IEs[0], MAX_IE_SZ);
+	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.length);
+	/*  some ies in pnetwork is wrong, so we should use ptarget_wlan ies */
+	cur_network->network.ie_length = ptarget_wlan->network.ie_length;
+	memcpy(&cur_network->network.ies[0], &ptarget_wlan->network.ies[0], MAX_IE_SZ);
 
 	cur_network->aid = pnetwork->join_res;
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-	padapter->recvpriv.signal_strength = ptarget_wlan->network.PhyInfo.SignalStrength;
-	padapter->recvpriv.signal_qual = ptarget_wlan->network.PhyInfo.SignalQuality;
-	/* the ptarget_wlan->network.Rssi is raw data, we use ptarget_wlan->network.PhyInfo.SignalStrength instead (has scaled) */
-	padapter->recvpriv.rssi = translate_percentage_to_dbm(ptarget_wlan->network.PhyInfo.SignalStrength);
+	padapter->recvpriv.signal_strength = ptarget_wlan->network.phy_info.SignalStrength;
+	padapter->recvpriv.signal_qual = ptarget_wlan->network.phy_info.SignalQuality;
+	/* the ptarget_wlan->network.rssi is raw data, we use ptarget_wlan->network.phy_info.SignalStrength instead (has scaled) */
+	padapter->recvpriv.rssi = translate_percentage_to_dbm(ptarget_wlan->network.phy_info.SignalStrength);
 	#if defined(DBG_RX_SIGNAL_DISPLAY_PROCESSING) && 1
 		DBG_871X(FUNC_ADPT_FMT" signal_strength:%3u, rssi:%3d, signal_qual:%3u"
 			"\n"
@@ -1256,7 +1256,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
 	/* update fw_state will clr _FW_UNDER_LINKING here indirectly */
-	switch (pnetwork->network.InfrastructureMode) {
+	switch (pnetwork->network.infrastructure_mode) {
 	case Ndis802_11Infrastructure:
 
 			if (pmlmepriv->fw_state&WIFI_UNDER_WPS)
@@ -1274,10 +1274,10 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	}
 
-	rtw_update_protection(padapter, (cur_network->network.IEs) + sizeof(struct ndis_802_11_fix_ie),
-									(cur_network->network.IELength));
+	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
+									(cur_network->network.ie_length));
 
-	rtw_update_ht_cap(padapter, cur_network->network.IEs, cur_network->network.IELength, (u8) cur_network->network.Configuration.DSConfig);
+	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.DSConfig);
 }
 
 /* Notes: the function could be > passive_level (the same context as Rx tasklet) */
@@ -1308,10 +1308,10 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	else
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   rtw_joinbss_event_callback for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
 
-	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
+	the_same_macaddr = !memcmp(pnetwork->network.mac_address, cur_network->network.mac_address, ETH_ALEN);
 
-	pnetwork->network.Length = get_wlan_bssid_ex_sz(&pnetwork->network);
-	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex)) {
+	pnetwork->network.length = get_wlan_bssid_ex_sz(&pnetwork->network);
+	if (pnetwork->network.length > sizeof(struct wlan_bssid_ex)) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n ***joinbss_evt_callback return a wrong bss ***\n\n"));
 		return;
 	}
@@ -1330,17 +1330,17 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			/* s1. find ptarget_wlan */
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (the_same_macaddr) {
-					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.MacAddress);
+					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
 				} else {
-					pcur_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.MacAddress);
+					pcur_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
 					if (pcur_wlan)
 						pcur_wlan->fixed = false;
 
-					pcur_sta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
+					pcur_sta = rtw_get_stainfo(pstapriv, cur_network->network.mac_address);
 					if (pcur_sta)
 						rtw_free_stainfo(adapter,  pcur_sta);
 
-					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.MacAddress);
+					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
 					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 						if (ptarget_wlan)
 							ptarget_wlan->fixed = true;
@@ -1549,7 +1549,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		if (adapter->stapriv.asoc_sta_count == 2) {
 			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
-			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.MacAddress);
+			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
 			pmlmepriv->cur_network_scanned = ptarget_wlan;
 			if (ptarget_wlan)
 				ptarget_wlan->fixed = true;
@@ -1630,7 +1630,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 		/*  remove the network entry in scanned_queue */
-		pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
+		pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
 		if (pwlan) {
 			pwlan->fixed = false;
 			rtw_free_network_nolock(adapter, pwlan);
@@ -1650,7 +1650,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 			/* free old ibss network */
 			/* pwlan = rtw_find_network(&pmlmepriv->scanned_queue, pstadel->macaddr); */
-			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
+			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
 			if (pwlan) {
 				pwlan->fixed = false;
 				rtw_free_network_nolock(adapter, pwlan);
@@ -1658,11 +1658,11 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 			/* re-create ibss */
 			pdev_network = &(adapter->registrypriv.dev_network);
-			pibss = adapter->registrypriv.dev_network.MacAddress;
+			pibss = adapter->registrypriv.dev_network.mac_address;
 
 			memcpy(pdev_network, &tgt_network->network, get_wlan_bssid_ex_sz(&tgt_network->network));
 
-			memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+			memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 			rtw_update_registrypriv_dev_network(adapter);
 
@@ -1896,16 +1896,16 @@ static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 
 	DBG_871X("roam candidate:%s %s("MAC_FMT", ch%3u) rssi:%d, age:%5d\n",
 		(competitor == mlme->cur_network_scanned)?"*":" ",
-		competitor->network.Ssid.Ssid,
-		MAC_ARG(competitor->network.MacAddress),
-		competitor->network.Configuration.DSConfig,
-		(int)competitor->network.Rssi,
+		competitor->network.ssid.Ssid,
+		MAC_ARG(competitor->network.mac_address),
+		competitor->network.configuration.DSConfig,
+		(int)competitor->network.rssi,
 		jiffies_to_msecs(jiffies - competitor->last_scanned)
 	);
 
 	/* got specific addr to roam */
 	if (!is_zero_mac_addr(mlme->roam_tgt_addr)) {
-		if (!memcmp(mlme->roam_tgt_addr, competitor->network.MacAddress, ETH_ALEN))
+		if (!memcmp(mlme->roam_tgt_addr, competitor->network.mac_address, ETH_ALEN))
 			goto update;
 		else
 			goto exit;
@@ -1913,10 +1913,10 @@ static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	if (jiffies_to_msecs(jiffies - competitor->last_scanned) >= mlme->roam_scanr_exp_ms)
 		goto exit;
 
-	if (competitor->network.Rssi - mlme->cur_network_scanned->network.Rssi < mlme->roam_rssi_diff_th)
+	if (competitor->network.rssi - mlme->cur_network_scanned->network.rssi < mlme->roam_rssi_diff_th)
 		goto exit;
 
-	if (*candidate != NULL && (*candidate)->network.Rssi >= competitor->network.Rssi)
+	if (*candidate != NULL && (*candidate)->network.rssi >= competitor->network.rssi)
 		goto exit;
 
 update:
@@ -1957,10 +1957,10 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 		mlme->pscanned = get_next(mlme->pscanned);
 
 		DBG_871X("%s("MAC_FMT", ch%u) rssi:%d\n"
-			, pnetwork->network.Ssid.Ssid
-			, MAC_ARG(pnetwork->network.MacAddress)
-			, pnetwork->network.Configuration.DSConfig
-			, (int)pnetwork->network.Rssi);
+			, pnetwork->network.ssid.Ssid
+			, MAC_ARG(pnetwork->network.mac_address)
+			, pnetwork->network.configuration.DSConfig
+			, (int)pnetwork->network.rssi);
 
 		rtw_check_roaming_candidate(mlme, &candidate, pnetwork);
 
@@ -1972,12 +1972,12 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 		goto exit;
 	} else {
 		DBG_871X("%s: candidate: %s("MAC_FMT", ch:%u)\n", __func__,
-			candidate->network.Ssid.Ssid, MAC_ARG(candidate->network.MacAddress),
-			candidate->network.Configuration.DSConfig);
+			candidate->network.ssid.Ssid, MAC_ARG(candidate->network.mac_address),
+			candidate->network.configuration.DSConfig);
 
 		mlme->roam_network = candidate;
 
-		if (!memcmp(candidate->network.MacAddress, mlme->roam_tgt_addr, ETH_ALEN))
+		if (!memcmp(candidate->network.mac_address, mlme->roam_tgt_addr, ETH_ALEN))
 			eth_zero_addr(mlme->roam_tgt_addr);
 	}
 
@@ -2001,14 +2001,14 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 
 	/* check bssid, if needed */
 	if (mlme->assoc_by_bssid) {
-		if (memcmp(competitor->network.MacAddress, mlme->assoc_bssid, ETH_ALEN))
+		if (memcmp(competitor->network.mac_address, mlme->assoc_bssid, ETH_ALEN))
 			goto exit;
 	}
 
 	/* check ssid, if needed */
 	if (mlme->assoc_ssid.Ssid[0] && mlme->assoc_ssid.SsidLength) {
-		if (competitor->network.Ssid.SsidLength != mlme->assoc_ssid.SsidLength
-			|| memcmp(competitor->network.Ssid.Ssid, mlme->assoc_ssid.Ssid, mlme->assoc_ssid.SsidLength)
+		if (competitor->network.ssid.SsidLength != mlme->assoc_ssid.SsidLength
+			|| memcmp(competitor->network.ssid.Ssid, mlme->assoc_ssid.Ssid, mlme->assoc_ssid.SsidLength)
 		)
 			goto exit;
 	}
@@ -2023,7 +2023,7 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 			goto exit;
 	}
 
-	if (*candidate == NULL || (*candidate)->network.Rssi < competitor->network.Rssi) {
+	if (*candidate == NULL || (*candidate)->network.rssi < competitor->network.rssi) {
 		*candidate = competitor;
 		updated = true;
 	}
@@ -2035,10 +2035,10 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 			mlme->assoc_by_bssid,
 			mlme->assoc_ssid.Ssid,
 			rtw_to_roam(adapter),
-			(*candidate)->network.Ssid.Ssid,
-			MAC_ARG((*candidate)->network.MacAddress),
-			(*candidate)->network.Configuration.DSConfig,
-			(int)(*candidate)->network.Rssi
+			(*candidate)->network.ssid.Ssid,
+			MAC_ARG((*candidate)->network.mac_address),
+			(*candidate)->network.configuration.DSConfig,
+			(int)(*candidate)->network.rssi
 		);
 	}
 
@@ -2087,10 +2087,10 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		pmlmepriv->pscanned = get_next(pmlmepriv->pscanned);
 
 		DBG_871X("%s("MAC_FMT", ch%u) rssi:%d\n"
-			, pnetwork->network.Ssid.Ssid
-			, MAC_ARG(pnetwork->network.MacAddress)
-			, pnetwork->network.Configuration.DSConfig
-			, (int)pnetwork->network.Rssi);
+			, pnetwork->network.ssid.Ssid
+			, MAC_ARG(pnetwork->network.mac_address)
+			, pnetwork->network.configuration.DSConfig
+			, (int)pnetwork->network.rssi);
 
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 
@@ -2105,8 +2105,8 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		goto exit;
 	} else {
 		DBG_871X("%s: candidate: %s("MAC_FMT", ch:%u)\n", __func__,
-			candidate->network.Ssid.Ssid, MAC_ARG(candidate->network.MacAddress),
-			candidate->network.Configuration.DSConfig);
+			candidate->network.ssid.Ssid, MAC_ARG(candidate->network.mac_address),
+			candidate->network.configuration.DSConfig);
 		goto candidate_exist;
 	}
 
@@ -2249,7 +2249,7 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
 	return res;
 }
 
-/* adjust IEs for rtw_joinbss_cmd in WMM */
+/* adjust ies for rtw_joinbss_cmd in WMM */
 int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_len, uint initial_out_len)
 {
 	unsigned	int ielength = 0;
@@ -2402,16 +2402,16 @@ void rtw_init_registrypriv_dev_network(struct adapter *adapter)
 	struct wlan_bssid_ex    *pdev_network = &pregistrypriv->dev_network;
 	u8 *myhwaddr = myid(peepriv);
 
-	memcpy(pdev_network->MacAddress, myhwaddr, ETH_ALEN);
+	memcpy(pdev_network->mac_address, myhwaddr, ETH_ALEN);
 
-	memcpy(&pdev_network->Ssid, &pregistrypriv->ssid, sizeof(struct ndis_802_11_ssid));
+	memcpy(&pdev_network->ssid, &pregistrypriv->ssid, sizeof(struct ndis_802_11_ssid));
 
-	pdev_network->Configuration.Length = sizeof(struct ndis_802_11_conf);
-	pdev_network->Configuration.BeaconPeriod = 100;
-	pdev_network->Configuration.FHConfig.Length = 0;
-	pdev_network->Configuration.FHConfig.HopPattern = 0;
-	pdev_network->Configuration.FHConfig.HopSet = 0;
-	pdev_network->Configuration.FHConfig.DwellTime = 0;
+	pdev_network->configuration.Length = sizeof(struct ndis_802_11_conf);
+	pdev_network->configuration.BeaconPeriod = 100;
+	pdev_network->configuration.FHConfig.Length = 0;
+	pdev_network->configuration.FHConfig.HopPattern = 0;
+	pdev_network->configuration.FHConfig.HopSet = 0;
+	pdev_network->configuration.FHConfig.DwellTime = 0;
 }
 
 void rtw_update_registrypriv_dev_network(struct adapter *adapter)
@@ -2423,56 +2423,56 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 	/* struct	xmit_priv *pxmitpriv = &adapter->xmitpriv; */
 
-	pdev_network->Privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
+	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
 
-	pdev_network->Rssi = 0;
+	pdev_network->rssi = 0;
 
 	switch (pregistrypriv->wireless_mode) {
 	case WIRELESS_11B:
-		pdev_network->NetworkTypeInUse = (Ndis802_11DS);
+		pdev_network->network_type_in_use = (Ndis802_11DS);
 		break;
 	case WIRELESS_11G:
 	case WIRELESS_11BG:
 	case WIRELESS_11_24N:
 	case WIRELESS_11G_24N:
 	case WIRELESS_11BG_24N:
-		pdev_network->NetworkTypeInUse = (Ndis802_11OFDM24);
+		pdev_network->network_type_in_use = (Ndis802_11OFDM24);
 		break;
 	case WIRELESS_11A:
 	case WIRELESS_11A_5N:
-		pdev_network->NetworkTypeInUse = (Ndis802_11OFDM5);
+		pdev_network->network_type_in_use = (Ndis802_11OFDM5);
 		break;
 	case WIRELESS_11ABGN:
 		if (pregistrypriv->channel > 14)
-			pdev_network->NetworkTypeInUse = (Ndis802_11OFDM5);
+			pdev_network->network_type_in_use = (Ndis802_11OFDM5);
 		else
-			pdev_network->NetworkTypeInUse = (Ndis802_11OFDM24);
+			pdev_network->network_type_in_use = (Ndis802_11OFDM24);
 		break;
 	default:
 		/*  TODO */
 		break;
 	}
 
-	pdev_network->Configuration.DSConfig = (pregistrypriv->channel);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("pregistrypriv->channel =%d, pdev_network->Configuration.DSConfig = 0x%x\n", pregistrypriv->channel, pdev_network->Configuration.DSConfig));
+	pdev_network->configuration.DSConfig = (pregistrypriv->channel);
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("pregistrypriv->channel =%d, pdev_network->configuration.DSConfig = 0x%x\n", pregistrypriv->channel, pdev_network->configuration.DSConfig));
 
-	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
-		pdev_network->Configuration.ATIMWindow = (0);
+	if (cur_network->network.infrastructure_mode == Ndis802_11IBSS)
+		pdev_network->configuration.ATIMWindow = (0);
 
-	pdev_network->InfrastructureMode = (cur_network->network.InfrastructureMode);
+	pdev_network->infrastructure_mode = (cur_network->network.infrastructure_mode);
 
 	/*  1. Supported rates */
 	/*  2. IE */
 
-	/* rtw_set_supported_rate(pdev_network->SupportedRates, pregistrypriv->wireless_mode) ;  will be called in rtw_generate_ie */
+	/* rtw_set_supported_rate(pdev_network->supported_rates, pregistrypriv->wireless_mode) ;  will be called in rtw_generate_ie */
 	sz = rtw_generate_ie(pregistrypriv);
 
-	pdev_network->IELength = sz;
+	pdev_network->ie_length = sz;
 
-	pdev_network->Length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pdev_network);
+	pdev_network->length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pdev_network);
 
-	/* notes: translate IELength & Length after assign the Length to cmdsz in createbss_cmd(); */
-	/* pdev_network->IELength = cpu_to_le32(sz); */
+	/* notes: translate ie_length & length after assign the length to cmdsz in createbss_cmd(); */
+	/* pdev_network->ie_length = cpu_to_le32(sz); */
 }
 
 void rtw_get_encrypt_decrypt_from_registrypriv(struct adapter *adapter)
@@ -2950,9 +2950,9 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 
 	if (0 < rtw_to_roam(padapter)) {
 		DBG_871X("roaming from %s("MAC_FMT"), length:%d\n",
-				cur_network->network.Ssid.Ssid, MAC_ARG(cur_network->network.MacAddress),
-				cur_network->network.Ssid.SsidLength);
-		memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.Ssid, sizeof(struct ndis_802_11_ssid));
+				cur_network->network.ssid.Ssid, MAC_ARG(cur_network->network.mac_address),
+				cur_network->network.ssid.SsidLength);
+		memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index af3b14b1de7a9d..a9e00cb31ce320 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -737,7 +737,7 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 		if (is_valid_p2p_probereq)
 			goto _issue_probersp;
 
-		if ((ielen != 0 && false == !memcmp((void *)(p+2), (void *)cur->Ssid.Ssid, cur->Ssid.SsidLength))
+		if ((ielen != 0 && false == !memcmp((void *)(p+2), (void *)cur->ssid.Ssid, cur->ssid.SsidLength))
 			|| (ielen == 0 && pmlmeinfo->hidden_ssid_mode)
 		)
 			return _SUCCESS;
@@ -835,7 +835,7 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
 						DBG_871X_LEVEL(_drv_always_, "ap has changed, disconnect now\n ");
-						receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);
+						receive_disconnect(padapter, pmlmeinfo->network.mac_address, 0);
 						return _SUCCESS;
 				}
 				/* update WMM, ERP in the beacon */
@@ -1260,10 +1260,10 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		goto OnAssocReqFail;
 	} else {
 		/*  check if ssid match */
-		if (memcmp((void *)(p+2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
+		if (memcmp((void *)(p+2), cur->ssid.Ssid, cur->ssid.SsidLength))
 			status = _STATS_FAILURE_;
 
-		if (ie_len != cur->Ssid.SsidLength)
+		if (ie_len != cur->ssid.SsidLength)
 			status = _STATS_FAILURE_;
 	}
 
@@ -1723,7 +1723,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	pmlmeinfo->state |= WIFI_FW_ASSOC_SUCCESS;
 
 	/* Update Basic Rate Table for spec, 2010-12-28 , by thomas */
-	UpdateBrateTbl(padapter, pmlmeinfo->network.SupportedRates);
+	UpdateBrateTbl(padapter, pmlmeinfo->network.supported_rates);
 
 report_assoc_result:
 	if (res > 0) {
@@ -2486,18 +2486,18 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
-		/* DBG_871X("ie len =%d\n", cur_network->IELength); */
+		/* DBG_871X("ie len =%d\n", cur_network->ie_length); */
 		{
 			int len_diff;
 
-			memcpy(pframe, cur_network->IEs, cur_network->IELength);
+			memcpy(pframe, cur_network->ies, cur_network->ie_length);
 			len_diff = update_hidden_ssid(
 				pframe+_BEACON_IE_OFFSET_
-				, cur_network->IELength-_BEACON_IE_OFFSET_
+				, cur_network->ie_length-_BEACON_IE_OFFSET_
 				, pmlmeinfo->hidden_ssid_mode
 			);
-			pframe += (cur_network->IELength+len_diff);
-			pattrib->pktlen += (cur_network->IELength+len_diff);
+			pframe += (cur_network->ie_length+len_diff);
+			pattrib->pktlen += (cur_network->ie_length+len_diff);
 		}
 
 		{
@@ -2528,34 +2528,34 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	/*  beacon interval: 2 bytes */
 
-	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pattrib->pktlen += 2;
 
 	/*  capability info: 2 bytes */
 
-	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pattrib->pktlen += 2;
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->ssid.SsidLength, cur_network->ssid.Ssid, &pattrib->pktlen);
 
 	/*  supported rates... */
-	rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
-	pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pattrib->pktlen);
+	rate_len = rtw_get_rateset_len(cur_network->supported_rates);
+	pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->supported_rates, &pattrib->pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->configuration.DSConfig), &pattrib->pktlen);
 
 	/* if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) */
 	{
 		u8 erpinfo = 0;
 		u32 ATIMWindow;
 		/*  IBSS Parameter Set... */
-		/* ATIMWindow = cur->Configuration.ATIMWindow; */
+		/* ATIMWindow = cur->configuration.ATIMWindow; */
 		ATIMWindow = 0;
 		pframe = rtw_set_ie(pframe, _IBSS_PARA_IE_, 2, (unsigned char *)(&ATIMWindow), &pattrib->pktlen);
 
@@ -2566,7 +2566,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	/*  EXTERNDED SUPPORTED RATE */
 	if (rate_len > 8) {
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->SupportedRates + 8), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->supported_rates + 8), &pattrib->pktlen);
 	}
 
 
@@ -2633,7 +2633,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	mac = myid(&(padapter->eeprompriv));
-	bssid = cur_network->MacAddress;
+	bssid = cur_network->mac_address;
 
 	fctrl = &(pwlanhdr->frame_control);
 	*(fctrl) = 0;
@@ -2650,24 +2650,24 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	pframe += pattrib->hdrlen;
 
 
-	if (cur_network->IELength > MAX_IE_SZ)
+	if (cur_network->ie_length > MAX_IE_SZ)
 		return;
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
-		pwps_ie = rtw_get_wps_ie(cur_network->IEs+_FIXED_IE_LENGTH_, cur_network->IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
+		pwps_ie = rtw_get_wps_ie(cur_network->ies+_FIXED_IE_LENGTH_, cur_network->ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 		/* inerset & update wps_probe_resp_ie */
 		if ((pmlmepriv->wps_probe_resp_ie != NULL) && pwps_ie && (wps_ielen > 0)) {
 			uint wps_offset, remainder_ielen;
 			u8 *premainder_ie;
 
-			wps_offset = (uint)(pwps_ie - cur_network->IEs);
+			wps_offset = (uint)(pwps_ie - cur_network->ies);
 
 			premainder_ie = pwps_ie + wps_ielen;
 
-			remainder_ielen = cur_network->IELength - wps_offset - wps_ielen;
+			remainder_ielen = cur_network->ie_length - wps_offset - wps_ielen;
 
-			memcpy(pframe, cur_network->IEs, wps_offset);
+			memcpy(pframe, cur_network->ies, wps_offset);
 			pframe += wps_offset;
 			pattrib->pktlen += wps_offset;
 
@@ -2684,12 +2684,12 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 				pattrib->pktlen += remainder_ielen;
 			}
 		} else {
-			memcpy(pframe, cur_network->IEs, cur_network->IELength);
-			pframe += cur_network->IELength;
-			pattrib->pktlen += cur_network->IELength;
+			memcpy(pframe, cur_network->ies, cur_network->ie_length);
+			pframe += cur_network->ie_length;
+			pattrib->pktlen += cur_network->ie_length;
 		}
 
-		/* retrieve SSID IE from cur_network->Ssid */
+		/* retrieve SSID IE from cur_network->ssid */
 		{
 			u8 *ssid_ie;
 			sint ssid_ielen;
@@ -2700,9 +2700,9 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 			ssid_ie = rtw_get_ie(ies+_FIXED_IE_LENGTH_, _SSID_IE_, &ssid_ielen,
 				(pframe-ies)-_FIXED_IE_LENGTH_);
 
-			ssid_ielen_diff = cur_network->Ssid.SsidLength - ssid_ielen;
+			ssid_ielen_diff = cur_network->ssid.SsidLength - ssid_ielen;
 
-			if (ssid_ie &&  cur_network->Ssid.SsidLength) {
+			if (ssid_ie &&  cur_network->ssid.SsidLength) {
 				uint remainder_ielen;
 				u8 *remainder_ie;
 
@@ -2716,8 +2716,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 				memcpy(buf, remainder_ie, remainder_ielen);
 				memcpy(remainder_ie+ssid_ielen_diff, buf, remainder_ielen);
-				*(ssid_ie+1) = cur_network->Ssid.SsidLength;
-				memcpy(ssid_ie+2, cur_network->Ssid.Ssid, cur_network->Ssid.SsidLength);
+				*(ssid_ie+1) = cur_network->ssid.SsidLength;
+				memcpy(ssid_ie+2, cur_network->ssid.Ssid, cur_network->ssid.SsidLength);
 
 				pframe += ssid_ielen_diff;
 				pattrib->pktlen += ssid_ielen_diff;
@@ -2730,14 +2730,14 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 		/*  beacon interval: 2 bytes */
 
-		memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+		memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->ies)), 2);
 
 		pframe += 2;
 		pattrib->pktlen += 2;
 
 		/*  capability info: 2 bytes */
 
-		memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+		memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->ies)), 2);
 
 		pframe += 2;
 		pattrib->pktlen += 2;
@@ -2745,20 +2745,20 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		/* below for ad-hoc mode */
 
 		/*  SSID */
-		pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->ssid.SsidLength, cur_network->ssid.Ssid, &pattrib->pktlen);
 
 		/*  supported rates... */
-		rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pattrib->pktlen);
+		rate_len = rtw_get_rateset_len(cur_network->supported_rates);
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->supported_rates, &pattrib->pktlen);
 
 		/*  DS parameter set */
-		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->configuration.DSConfig), &pattrib->pktlen);
 
 		if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 			u8 erpinfo = 0;
 			u32 ATIMWindow;
 			/*  IBSS Parameter Set... */
-			/* ATIMWindow = cur->Configuration.ATIMWindow; */
+			/* ATIMWindow = cur->configuration.ATIMWindow; */
 			ATIMWindow = 0;
 			pframe = rtw_set_ie(pframe, _IBSS_PARA_IE_, 2, (unsigned char *)(&ATIMWindow), &pattrib->pktlen);
 
@@ -2769,7 +2769,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 		/*  EXTERNDED SUPPORTED RATE */
 		if (rate_len > 8) {
-			pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->SupportedRates + 8), &pattrib->pktlen);
+			pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->supported_rates + 8), &pattrib->pktlen);
 		}
 
 
@@ -2790,7 +2790,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		u8 RC_OUI[4] = {0x00, 0xE0, 0x4C, 0x0A};
 		u8 RC_INFO[14] = {0};
 		/* EID[1] + EID_LEN[1] + RC_OUI[4] + MAC[6] + PairingID[2] + ChannelNum[2] */
-		u16 cu_ch = (u16)cur_network->Configuration.DSConfig;
+		u16 cu_ch = (u16)cur_network->configuration.DSConfig;
 
 		DBG_871X("%s, reply rc(pid = 0x%x) device "MAC_FMT" in ch =%d\n", __func__,
 			psta->pid, MAC_ARG(psta->hwaddr), cu_ch);
@@ -3108,7 +3108,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
-	u8 *ie = pnetwork->IEs;
+	u8 *ie = pnetwork->ies;
 	__le16 lestatus, le_tmp;
 
 	DBG_871X("%s\n", __func__);
@@ -3169,7 +3169,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 
 		/* FILL HT CAP INFO IE */
 		/* p = hostapd_eid_ht_capabilities_info(hapd, p); */
-		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _HT_CAPABILITY_IE_, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_));
+		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _HT_CAPABILITY_IE_, &ie_len, (pnetwork->ie_length - _BEACON_IE_OFFSET_));
 		if (pbuf && ie_len > 0) {
 			memcpy(pframe, pbuf, ie_len+2);
 			pframe += (ie_len+2);
@@ -3178,7 +3178,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 
 		/* FILL HT ADD INFO IE */
 		/* p = hostapd_eid_ht_operation(hapd, p); */
-		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _HT_ADD_INFO_IE_, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_));
+		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _HT_ADD_INFO_IE_, &ie_len, (pnetwork->ie_length - _BEACON_IE_OFFSET_));
 		if (pbuf && ie_len > 0) {
 			memcpy(pframe, pbuf, ie_len+2);
 			pframe += (ie_len+2);
@@ -3193,7 +3193,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 		unsigned char WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
 		for (pbuf = ie + _BEACON_IE_OFFSET_; ; pbuf += (ie_len + 2)) {
-			pbuf = rtw_get_ie(pbuf, _VENDOR_SPECIFIC_IE_, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_ - (ie_len + 2)));
+			pbuf = rtw_get_ie(pbuf, _VENDOR_SPECIFIC_IE_, &ie_len, (pnetwork->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2)));
 			if (pbuf && !memcmp(pbuf+2, WMM_PARA_IE, 6)) {
 				memcpy(pframe, pbuf, ie_len+2);
 				pframe += (ie_len+2);
@@ -3272,7 +3272,7 @@ void issue_assocreq(struct adapter *padapter)
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	/* caps */
-	memcpy(pframe, rtw_get_capability_from_ie(pmlmeinfo->network.IEs), 2);
+	memcpy(pframe, rtw_get_capability_from_ie(pmlmeinfo->network.ies), 2);
 
 	pframe += 2;
 	pattrib->pktlen += 2;
@@ -3285,7 +3285,7 @@ void issue_assocreq(struct adapter *padapter)
 	pattrib->pktlen += 2;
 
 	/* SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_,  pmlmeinfo->network.Ssid.SsidLength, pmlmeinfo->network.Ssid.Ssid, &(pattrib->pktlen));
+	pframe = rtw_set_ie(pframe, _SSID_IE_,  pmlmeinfo->network.ssid.SsidLength, pmlmeinfo->network.ssid.Ssid, &(pattrib->pktlen));
 
 	/* supported rate & extended supported rate */
 
@@ -3302,35 +3302,35 @@ void issue_assocreq(struct adapter *padapter)
 	/*  */
 
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
-		if (pmlmeinfo->network.SupportedRates[i] == 0)
+		if (pmlmeinfo->network.supported_rates[i] == 0)
 			break;
-		DBG_871X("network.SupportedRates[%d]=%02X\n", i, pmlmeinfo->network.SupportedRates[i]);
+		DBG_871X("network.supported_rates[%d]=%02X\n", i, pmlmeinfo->network.supported_rates[i]);
 	}
 
 
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
-		if (pmlmeinfo->network.SupportedRates[i] == 0)
+		if (pmlmeinfo->network.supported_rates[i] == 0)
 			break;
 
 
 		/*  Check if the AP's supported rates are also supported by STA. */
 		for (j = 0; j < sta_bssrate_len; j++) {
 			 /*  Avoid the proprietary data rate (22Mbps) of Handlink WSG-4000 AP */
-			if ((pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK)
+			if ((pmlmeinfo->network.supported_rates[i]|IEEE80211_BASIC_RATE_MASK)
 					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK)) {
 				/* DBG_871X("match i = %d, j =%d\n", i, j); */
 				break;
 			} else {
-				/* DBG_871X("not match: %02X != %02X\n", (pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK), (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK)); */
+				/* DBG_871X("not match: %02X != %02X\n", (pmlmeinfo->network.supported_rates[i]|IEEE80211_BASIC_RATE_MASK), (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK)); */
 			}
 		}
 
 		if (j == sta_bssrate_len) {
 			/*  the rate is not supported by STA */
-			DBG_871X("%s(): the rate[%d]=%02X is not supported by STA!\n", __func__, i, pmlmeinfo->network.SupportedRates[i]);
+			DBG_871X("%s(): the rate[%d]=%02X is not supported by STA!\n", __func__, i, pmlmeinfo->network.supported_rates[i]);
 		} else {
 			/*  the rate is supported by STA */
-			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
+			bssrate[index++] = pmlmeinfo->network.supported_rates[i];
 		}
 	}
 
@@ -3351,8 +3351,8 @@ void issue_assocreq(struct adapter *padapter)
 		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &(pattrib->pktlen));
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
-	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.IELength;) {
-		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.IEs + i);
+	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
 		switch (pIE->ElementID) {
 		case _VENDOR_SPECIFIC_IE_:
@@ -3959,7 +3959,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			le_tmp = cpu_to_le16(BA_timeout_value);
 			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(le_tmp)), &(pattrib->pktlen));
 
-			/* if ((psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.MacAddress)) != NULL) */
+			/* if ((psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.mac_address)) != NULL) */
 			psta = rtw_get_stainfo(pstapriv, raddr);
 			if (psta != NULL) {
 				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07]&0xfff) + 1;
@@ -4130,13 +4130,13 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 			pbss_network = (struct wlan_bssid_ex *)&pnetwork->network;
 
-			p = rtw_get_ie(pbss_network->IEs + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pbss_network->IELength - _FIXED_IE_LENGTH_);
+			p = rtw_get_ie(pbss_network->ies + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pbss_network->ie_length - _FIXED_IE_LENGTH_);
 			if ((p == NULL) || (len == 0)) {/* non-HT */
 
-				if (pbss_network->Configuration.DSConfig <= 0)
+				if (pbss_network->configuration.DSConfig <= 0)
 					continue;
 
-				ICS[0][pbss_network->Configuration.DSConfig] = 1;
+				ICS[0][pbss_network->configuration.DSConfig] = 1;
 
 				if (ICS[0][0] == 0)
 					ICS[0][0] = 1;
@@ -4457,19 +4457,19 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		}
 	}
 
-	bssid->Length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
+	bssid->length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
 
 	/* below is to copy the information element */
-	bssid->IELength = len;
-	memcpy(bssid->IEs, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
+	bssid->ie_length = len;
+	memcpy(bssid->ies, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->ie_length);
 
 	/* get the signal strength */
-	bssid->Rssi = precv_frame->u.hdr.attrib.phy_info.RecvSignalPower; /*  in dBM.raw data */
-	bssid->PhyInfo.SignalQuality = precv_frame->u.hdr.attrib.phy_info.SignalQuality;/* in percentage */
-	bssid->PhyInfo.SignalStrength = precv_frame->u.hdr.attrib.phy_info.SignalStrength;/* in percentage */
+	bssid->rssi = precv_frame->u.hdr.attrib.phy_info.RecvSignalPower; /*  in dBM.raw data */
+	bssid->phy_info.SignalQuality = precv_frame->u.hdr.attrib.phy_info.SignalQuality;/* in percentage */
+	bssid->phy_info.SignalStrength = precv_frame->u.hdr.attrib.phy_info.SignalStrength;/* in percentage */
 
 	/*  checking SSID */
-	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, _SSID_IE_, &len, bssid->ie_length - ie_offset);
 	if (p == NULL) {
 		DBG_871X("marc: cannot find SSID for survey event\n");
 		return _FAIL;
@@ -4480,85 +4480,85 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 			DBG_871X("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
 		}
-		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
-		bssid->Ssid.SsidLength = *(p + 1);
+		memcpy(bssid->ssid.Ssid, (p + 2), *(p + 1));
+		bssid->ssid.SsidLength = *(p + 1);
 	} else
-		bssid->Ssid.SsidLength = 0;
+		bssid->ssid.SsidLength = 0;
 
-	memset(bssid->SupportedRates, 0, NDIS_802_11_LENGTH_RATES_EX);
+	memset(bssid->supported_rates, 0, NDIS_802_11_LENGTH_RATES_EX);
 
 	/* checking rate info... */
 	i = 0;
-	p = rtw_get_ie(bssid->IEs + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->ie_length - ie_offset);
 	if (p != NULL) {
 		if (len > NDIS_802_11_LENGTH_RATES_EX) {
 			DBG_871X("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
 		}
-		memcpy(bssid->SupportedRates, (p + 2), len);
+		memcpy(bssid->supported_rates, (p + 2), len);
 		i = len;
 	}
 
-	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->ie_length - ie_offset);
 	if (p != NULL) {
 		if (len > (NDIS_802_11_LENGTH_RATES_EX-i)) {
 			DBG_871X("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
 		}
-		memcpy(bssid->SupportedRates + i, (p + 2), len);
+		memcpy(bssid->supported_rates + i, (p + 2), len);
 	}
 
-	bssid->NetworkTypeInUse = Ndis802_11OFDM24;
+	bssid->network_type_in_use = Ndis802_11OFDM24;
 
-	if (bssid->IELength < 12)
+	if (bssid->ie_length < 12)
 		return _FAIL;
 
 	/*  Checking for DSConfig */
-	p = rtw_get_ie(bssid->IEs + ie_offset, _DSSET_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, _DSSET_IE_, &len, bssid->ie_length - ie_offset);
 
-	bssid->Configuration.DSConfig = 0;
-	bssid->Configuration.Length = 0;
+	bssid->configuration.DSConfig = 0;
+	bssid->configuration.Length = 0;
 
 	if (p) {
-		bssid->Configuration.DSConfig = *(p + 2);
+		bssid->configuration.DSConfig = *(p + 2);
 	} else {
 		/*  In 5G, some ap do not have DSSET IE */
 		/*  checking HT info for channel */
-		p = rtw_get_ie(bssid->IEs + ie_offset, _HT_ADD_INFO_IE_, &len, bssid->IELength - ie_offset);
+		p = rtw_get_ie(bssid->ies + ie_offset, _HT_ADD_INFO_IE_, &len, bssid->ie_length - ie_offset);
 		if (p) {
 			struct HT_info_element *HT_info = (struct HT_info_element *)(p + 2);
 
-			bssid->Configuration.DSConfig = HT_info->primary_channel;
+			bssid->configuration.DSConfig = HT_info->primary_channel;
 		} else { /*  use current channel */
-			bssid->Configuration.DSConfig = rtw_get_oper_ch(padapter);
+			bssid->configuration.DSConfig = rtw_get_oper_ch(padapter);
 		}
 	}
 
-	memcpy(&le32_tmp, rtw_get_beacon_interval_from_ie(bssid->IEs), 2);
-	bssid->Configuration.BeaconPeriod = le32_to_cpu(le32_tmp);
+	memcpy(&le32_tmp, rtw_get_beacon_interval_from_ie(bssid->ies), 2);
+	bssid->configuration.BeaconPeriod = le32_to_cpu(le32_tmp);
 
 	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
 
 	if (val16 & BIT(0)) {
-		bssid->InfrastructureMode = Ndis802_11Infrastructure;
-		memcpy(bssid->MacAddress, GetAddr2Ptr(pframe), ETH_ALEN);
+		bssid->infrastructure_mode = Ndis802_11Infrastructure;
+		memcpy(bssid->mac_address, GetAddr2Ptr(pframe), ETH_ALEN);
 	} else {
-		bssid->InfrastructureMode = Ndis802_11IBSS;
-		memcpy(bssid->MacAddress, GetAddr3Ptr(pframe), ETH_ALEN);
+		bssid->infrastructure_mode = Ndis802_11IBSS;
+		memcpy(bssid->mac_address, GetAddr3Ptr(pframe), ETH_ALEN);
 	}
 
 	if (val16 & BIT(4))
-		bssid->Privacy = 1;
+		bssid->privacy = 1;
 	else
-		bssid->Privacy = 0;
+		bssid->privacy = 0;
 
-	bssid->Configuration.ATIMWindow = 0;
+	bssid->configuration.ATIMWindow = 0;
 
 	/* 20/40 BSS Coexistence check */
 	if ((pregistrypriv->wifi_spec == 1) && (false == pmlmeinfo->bwmode_updated)) {
 		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-		p = rtw_get_ie(bssid->IEs + ie_offset, _HT_CAPABILITY_IE_, &len, bssid->IELength - ie_offset);
+		p = rtw_get_ie(bssid->ies + ie_offset, _HT_CAPABILITY_IE_, &len, bssid->ie_length - ie_offset);
 		if (p && len > 0) {
 			struct HT_caps_element	*pHT_caps;
 
@@ -4571,18 +4571,18 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	}
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) & 1
-	if (strcmp(bssid->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
+	if (strcmp(bssid->ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
 		DBG_871X("Receiving %s("MAC_FMT", DSConfig:%u) from ch%u with ss:%3u, sq:%3u, RawRSSI:%3ld\n"
-			, bssid->Ssid.Ssid, MAC_ARG(bssid->MacAddress), bssid->Configuration.DSConfig
+			, bssid->ssid.Ssid, MAC_ARG(bssid->mac_address), bssid->configuration.DSConfig
 			, rtw_get_oper_ch(padapter)
-			, bssid->PhyInfo.SignalStrength, bssid->PhyInfo.SignalQuality, bssid->Rssi
+			, bssid->phy_info.SignalStrength, bssid->phy_info.SignalQuality, bssid->rssi
 		);
 	}
 	#endif
 
 	/*  mark bss info receiving from nearby channel as SignalQuality 101 */
-	if (bssid->Configuration.DSConfig != rtw_get_oper_ch(padapter))
-		bssid->PhyInfo.SignalQuality = 101;
+	if (bssid->configuration.DSConfig != rtw_get_oper_ch(padapter))
+		bssid->phy_info.SignalQuality = 101;
 
 	return _SUCCESS;
 }
@@ -4596,7 +4596,7 @@ void start_create_ibss(struct adapter *padapter)
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 
-	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
+	pmlmeext->cur_channel = (u8)pnetwork->configuration.DSConfig;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
 
 	/* update wireless mode */
@@ -4628,7 +4628,7 @@ void start_create_ibss(struct adapter *padapter)
 			report_join_res(padapter, -1);
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		} else {
-			rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, padapter->registrypriv.dev_network.MacAddress);
+			rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, padapter->registrypriv.dev_network.mac_address);
 			join_type = 0;
 			rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
@@ -4675,7 +4675,7 @@ void start_clnt_join(struct adapter *padapter)
 		/* 	For the Win8 P2P connection, it will be hard to have a successful connection if this Wi-Fi doesn't connect to it. */
 		{
 				/* To avoid connecting to AP fail during resume process, change retry count from 5 to 1 */
-				issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
+				issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
 		}
 
 		/* here wait for receiving the beacon to start auth */
@@ -4793,7 +4793,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		u8 noc; /*  number of channel */
 		u8 j, k;
 
-		ie = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _COUNTRY_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+		ie = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _COUNTRY_IE_, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 		if (!ie)
 			return;
 		if (len < 6)
@@ -4828,7 +4828,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 
 #ifdef DEBUG_RTL871X
 		i = 0;
-		DBG_871X("%s: AP[%s] channel plan {", __func__, bssid->Ssid.Ssid);
+		DBG_871X("%s: AP[%s] channel plan {", __func__, bssid->ssid.Ssid);
 		while ((i < chplan_ap.Len) && (chplan_ap.Channel[i] != 0)) {
 			DBG_8192C("%02d,", chplan_ap.Channel[i]);
 			i++;
@@ -4986,7 +4986,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 	}
 
 	/*  If channel is used by AP, set channel scan type to active */
-	channel = bssid->Configuration.DSConfig;
+	channel = bssid->configuration.DSConfig;
 	chplan_new = pmlmeext->channel_set;
 	i = 0;
 	while ((i < MAX_CHANNEL_NUM) && (chplan_new[i].ChannelNum != 0)) {
@@ -5458,7 +5458,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	/*  update IOT-related issue */
 	update_IOT_info(padapter);
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, cur_network->SupportedRates);
+	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, cur_network->supported_rates);
 
 	/* BCN interval */
 	rtw_hal_set_hwreg(padapter, HW_VAR_BEACON_INTERVAL, (u8 *)(&pmlmeinfo->bcn_interval));
@@ -5475,7 +5475,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	/* Set cur_channel&cur_bwmode&cur_ch_offset */
 	set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
 
-	psta = rtw_get_stainfo(pstapriv, cur_network->MacAddress);
+	psta = rtw_get_stainfo(pstapriv, cur_network->mac_address);
 	if (psta) { /* only for infra. mode */
 
 		pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
@@ -5595,7 +5595,7 @@ void _linked_info_dump(struct adapter *padapter)
 			rtw_hal_get_def_var(padapter, HAL_DEF_UNDERCORATEDSMOOTHEDPWDB, &UndecoratedSmoothedPWDB);
 
 			DBG_871X("AP[" MAC_FMT "] - UndecoratedSmoothedPWDB:%d\n",
-				MAC_ARG(padapter->mlmepriv.cur_network.network.MacAddress), UndecoratedSmoothedPWDB);
+				MAC_ARG(padapter->mlmepriv.cur_network.network.mac_address), UndecoratedSmoothedPWDB);
 		} else if ((pmlmeinfo->state&0x03) == _HW_STATE_AP_) {
 			struct list_head	*phead, *plist;
 
@@ -5696,7 +5696,7 @@ void linked_status_chk(struct adapter *padapter)
 		/*  Marked by Kurt 20130715 */
 		/*  For WiDi 3.5 and latered on, they don't ask WiDi sink to do roaming, so we could not check rx limit that strictly. */
 		/*  todo: To check why we under miracast session, rx_chk would be false */
-		psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.MacAddress);
+		psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.mac_address);
 		if (psta != NULL) {
 			if (chk_ap_is_alive(padapter, psta) == false)
 				rx_chk = _FAIL;
@@ -5710,9 +5710,9 @@ void linked_status_chk(struct adapter *padapter)
 						#ifdef DBG_EXPIRATION_CHK
 						DBG_871X("issue_probereq to trigger probersp, retry =%d\n", pmlmeext->retry);
 						#endif
-						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
-						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
-						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
+						issue_probereq_ex(padapter, &pmlmeinfo->network.ssid, pmlmeinfo->network.mac_address, 0, 0, 0, 0);
+						issue_probereq_ex(padapter, &pmlmeinfo->network.ssid, pmlmeinfo->network.mac_address, 0, 0, 0, 0);
+						issue_probereq_ex(padapter, &pmlmeinfo->network.ssid, pmlmeinfo->network.mac_address, 0, 0, 0, 0);
 					}
 				}
 
@@ -5729,7 +5729,7 @@ void linked_status_chk(struct adapter *padapter)
 				if (pmlmeext->retry > rx_chk_limit) {
 					DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" disconnect or roaming\n",
 						FUNC_ADPT_ARG(padapter));
-					receive_disconnect(padapter, pmlmeinfo->network.MacAddress
+					receive_disconnect(padapter, pmlmeinfo->network.mac_address
 						, WLAN_REASON_EXPIRATION_CHK);
 					return;
 				}
@@ -5744,7 +5744,7 @@ void linked_status_chk(struct adapter *padapter)
 				pmlmeinfo->link_count = 0;
 			}
 
-		} /* end of if ((psta = rtw_get_stainfo(pstapriv, passoc_res->network.MacAddress)) != NULL) */
+		} /* end of if ((psta = rtw_get_stainfo(pstapriv, passoc_res->network.mac_address)) != NULL) */
 	} else if (is_client_associated_to_ibss(padapter)) {
 		/* linked IBSS mode */
 		/* for each assoc list entry to check the rx pkt counter */
@@ -6067,7 +6067,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 	}
 
 	/* below is for ad-hoc master */
-	if (pparm->network.InfrastructureMode == Ndis802_11IBSS) {
+	if (pparm->network.infrastructure_mode == Ndis802_11IBSS) {
 		rtw_joinbss_reset(padapter);
 
 		pmlmeext->cur_bwmode = CHANNEL_WIDTH_20;
@@ -6094,13 +6094,13 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 		/* clear CAM */
 		flush_all_cam_entry(padapter);
 
-		memcpy(pnetwork, pbuf, FIELD_OFFSET(struct wlan_bssid_ex, IELength));
-		pnetwork->IELength = ((struct wlan_bssid_ex *)pbuf)->IELength;
+		memcpy(pnetwork, pbuf, FIELD_OFFSET(struct wlan_bssid_ex, ie_length));
+		pnetwork->ie_length = ((struct wlan_bssid_ex *)pbuf)->ie_length;
 
-		if (pnetwork->IELength > MAX_IE_SZ)/* Check pbuf->IELength */
+		if (pnetwork->ie_length > MAX_IE_SZ)/* Check pbuf->ie_length */
 			return H2C_PARAMETERS_ERROR;
 
-		memcpy(pnetwork->IEs, ((struct wlan_bssid_ex *)pbuf)->IEs, pnetwork->IELength);
+		memcpy(pnetwork->ies, ((struct wlan_bssid_ex *)pbuf)->ies, pnetwork->ie_length);
 
 		start_create_ibss(padapter);
 
@@ -6127,7 +6127,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	/* check already connecting to AP or not */
 	if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
 		if (pmlmeinfo->state & WIFI_FW_STATION_STATE) {
-			issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
+			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
 		}
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 
@@ -6159,23 +6159,23 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	/* pmlmeinfo->assoc_AP_vendor = HT_IOT_PEER_MAX; */
 	pmlmeinfo->VHT_enable = 0;
 
-	memcpy(pnetwork, pbuf, FIELD_OFFSET(struct wlan_bssid_ex, IELength));
-	pnetwork->IELength = ((struct wlan_bssid_ex *)pbuf)->IELength;
+	memcpy(pnetwork, pbuf, FIELD_OFFSET(struct wlan_bssid_ex, ie_length));
+	pnetwork->ie_length = ((struct wlan_bssid_ex *)pbuf)->ie_length;
 
-	if (pnetwork->IELength > MAX_IE_SZ)/* Check pbuf->IELength */
+	if (pnetwork->ie_length > MAX_IE_SZ)/* Check pbuf->ie_length */
 		return H2C_PARAMETERS_ERROR;
 
-	memcpy(pnetwork->IEs, ((struct wlan_bssid_ex *)pbuf)->IEs, pnetwork->IELength);
+	memcpy(pnetwork->ies, ((struct wlan_bssid_ex *)pbuf)->ies, pnetwork->ie_length);
 
-	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
+	pmlmeext->cur_channel = (u8)pnetwork->configuration.DSConfig;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
 
 	/* Check AP vendor to move rtw_joinbss_cmd() */
-	/* pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->IEs, pnetwork->IELength); */
+	/* pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->ies, pnetwork->ie_length); */
 
 	/* sizeof(struct ndis_802_11_fix_ie) */
-	for (i = _FIXED_IE_LENGTH_; i < pnetwork->IELength;) {
-		pIE = (struct ndis_80211_var_ie *)(pnetwork->IEs + i);
+	for (i = _FIXED_IE_LENGTH_; i < pnetwork->ie_length;) {
+		pIE = (struct ndis_80211_var_ie *)(pnetwork->ies + i);
 
 		switch (pIE->ElementID) {
 		case _VENDOR_SPECIFIC_IE_:/* Get WMM IE. */
@@ -6194,7 +6194,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			{
 				struct HT_info_element *pht_info = (struct HT_info_element *)(pIE->data);
 
-				if (pnetwork->Configuration.DSConfig <= 14) {
+				if (pnetwork->configuration.DSConfig <= 14) {
 					if ((pregpriv->bw_mode & 0x0f) > CHANNEL_WIDTH_20)
 						cbw40_enable = 1;
 				}
@@ -6241,7 +6241,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	/* initialgain = 0x1E; */
 	/* rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain)); */
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pmlmeinfo->network.MacAddress);
+	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pmlmeinfo->network.mac_address);
 	join_type = 0;
 	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 	rtw_hal_set_hwreg(padapter, HW_VAR_DO_IQK, NULL);
@@ -6266,7 +6266,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	u8 val8;
 
 	if (is_client_associated_to_ap(padapter)) {
-			issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
+			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
 	}
 
 	if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
@@ -6586,11 +6586,11 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	memcpy(&(ptxBeacon_parm->network), &(pmlmeinfo->network), sizeof(struct wlan_bssid_ex));
 
 	len_diff = update_hidden_ssid(
-		ptxBeacon_parm->network.IEs+_BEACON_IE_OFFSET_
-		, ptxBeacon_parm->network.IELength-_BEACON_IE_OFFSET_
+		ptxBeacon_parm->network.ies+_BEACON_IE_OFFSET_
+		, ptxBeacon_parm->network.ie_length-_BEACON_IE_OFFSET_
 		, pmlmeinfo->hidden_ssid_mode
 	);
-	ptxBeacon_parm->network.IELength += len_diff;
+	ptxBeacon_parm->network.ie_length += len_diff;
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, ptxBeacon_parm, GEN_CMD_CODE(_TX_Beacon));
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 372ce17c3569b8..a14fdef29b7150 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -414,13 +414,13 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 
 inline u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork)
 {
-	return pnetwork->MacAddress;
+	return pnetwork->mac_address;
 }
 
 u16 get_beacon_interval(struct wlan_bssid_ex *bss)
 {
 	__le16 val;
-	memcpy((unsigned char *)&val, rtw_get_beacon_interval_from_ie(bss->IEs), 2);
+	memcpy((unsigned char *)&val, rtw_get_beacon_interval_from_ie(bss->ies), 2);
 
 	return le16_to_cpu(val);
 }
@@ -995,7 +995,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 		/* set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode); */
 
 		/* update ap's stainfo */
-		psta = rtw_get_stainfo(pstapriv, cur_network->MacAddress);
+		psta = rtw_get_stainfo(pstapriv, cur_network->mac_address);
 		if (psta) {
 			struct ht_priv *phtpriv_sta = &psta->htpriv;
 
@@ -1250,9 +1250,9 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		return _FAIL;
 	}
 
-	if (memcmp(cur_network->network.MacAddress, pbssid, 6)) {
+	if (memcmp(cur_network->network.mac_address, pbssid, 6)) {
 		DBG_871X("Oops: rtw_check_network_encrypt linked but recv other bssid bcn\n" MAC_FMT MAC_FMT,
-				MAC_ARG(pbssid), MAC_ARG(cur_network->network.MacAddress));
+				MAC_ARG(pbssid), MAC_ARG(cur_network->network.mac_address));
 		return true;
 	}
 
@@ -1272,15 +1272,15 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	if (subtype == WIFI_BEACON)
 		bssid->Reserved[0] = 1;
 
-	bssid->Length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
+	bssid->length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
 
 	/* below is to copy the information element */
-	bssid->IELength = len;
-	memcpy(bssid->IEs, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
+	bssid->ie_length = len;
+	memcpy(bssid->ies, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->ie_length);
 
 	/* check bw and channel offset */
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_cap = (struct rtw_ieee80211_ht_cap *)(p + 2);
 			ht_cap_info = le16_to_cpu(pht_cap->cap_info);
@@ -1288,7 +1288,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 			ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_info = (struct HT_info_element *)(p + 2);
 			ht_info_infos_0 = pht_info->infos[0];
@@ -1312,11 +1312,11 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	/* Checking for channel */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _DSSET_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _DSSET_IE_, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 	if (p) {
 			bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
-			rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+			rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 			if (pht_info) {
 					bcn_channel = pht_info->primary_channel;
 			} else { /* we don't find channel IE, so don't check it */
@@ -1332,23 +1332,23 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 
 	/* checking SSID */
 	ssid_len = 0;
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
 	if (p) {
 		ssid_len = *(p + 1);
 		if (ssid_len > NDIS_802_11_LENGTH_SSID)
 			ssid_len = 0;
 	}
-	memcpy(bssid->Ssid.Ssid, (p + 2), ssid_len);
-	bssid->Ssid.SsidLength = ssid_len;
+	memcpy(bssid->ssid.Ssid, (p + 2), ssid_len);
+	bssid->ssid.SsidLength = ssid_len;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s bssid.Ssid.Ssid:%s bssid.Ssid.SsidLength:%d "
-				"cur_network->network.Ssid.Ssid:%s len:%d\n", __func__, bssid->Ssid.Ssid,
-				bssid->Ssid.SsidLength, cur_network->network.Ssid.Ssid,
-				cur_network->network.Ssid.SsidLength));
+				"cur_network->network.ssid.Ssid:%s len:%d\n", __func__, bssid->ssid.Ssid,
+				bssid->ssid.SsidLength, cur_network->network.ssid.Ssid,
+				cur_network->network.ssid.SsidLength));
 
-	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
-			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
-		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
+	if (memcmp(bssid->ssid.Ssid, cur_network->network.ssid.Ssid, 32) ||
+			bssid->ssid.SsidLength != cur_network->network.ssid.SsidLength) {
+		if (bssid->ssid.Ssid[0] != '\0' && bssid->ssid.SsidLength != 0) { /* not hidden ssid */
 			DBG_871X("%s(), SSID is not match\n", __func__);
 			goto _mismatch;
 		}
@@ -1358,26 +1358,26 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
 
 	if (val16 & BIT(4))
-		bssid->Privacy = 1;
+		bssid->privacy = 1;
 	else
-		bssid->Privacy = 0;
+		bssid->privacy = 0;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-			("%s(): cur_network->network.Privacy is %d, bssid.Privacy is %d\n",
-			 __func__, cur_network->network.Privacy, bssid->Privacy));
-	if (cur_network->network.Privacy != bssid->Privacy) {
+			("%s(): cur_network->network.privacy is %d, bssid.privacy is %d\n",
+			 __func__, cur_network->network.privacy, bssid->privacy));
+	if (cur_network->network.privacy != bssid->privacy) {
 		DBG_871X("%s(), privacy is not match\n", __func__);
 		goto _mismatch;
 	}
 
-	rtw_get_sec_ie(bssid->IEs, bssid->IELength, NULL, &rsn_len, NULL, &wpa_len);
+	rtw_get_sec_ie(bssid->ies, bssid->ie_length, NULL, &rsn_len, NULL, &wpa_len);
 
 	if (rsn_len > 0) {
 		encryp_protocol = ENCRYP_PROTOCOL_WPA2;
 	} else if (wpa_len > 0) {
 		encryp_protocol = ENCRYP_PROTOCOL_WPA;
 	} else {
-		if (bssid->Privacy)
+		if (bssid->privacy)
 			encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
 
@@ -1387,7 +1387,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
-		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
+		pbuf = rtw_get_wpa_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length-12);
 		if (pbuf && (wpa_ielen > 0)) {
 			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
@@ -1395,7 +1395,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 						 pairwise_cipher, group_cipher, is_8021x));
 			}
 		} else {
-			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
+			pbuf = rtw_get_wpa2_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length-12);
 
 			if (pbuf && (wpa_ielen > 0)) {
 				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
@@ -1492,8 +1492,8 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
 
 	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
-		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.IELength;) {
-			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.IEs + i);
+		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
 			switch (pIE->ElementID) {
 			case _VENDOR_SPECIFIC_IE_:
@@ -1719,7 +1719,7 @@ void update_wireless_mode(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
-	unsigned char 		*rate = cur_network->SupportedRates;
+	unsigned char 		*rate = cur_network->supported_rates;
 
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable))
 		pmlmeinfo->HT_enable = 1;
diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 3705a60a054621..99178c20f4dab6 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -614,7 +614,7 @@ static u8 halbtcoutsrc_Set(void *pBtcContext, u8 setType, void *pInBuf)
 			struct wlan_bssid_ex *cur_network;
 
 			cur_network = &padapter->mlmeextpriv.mlmext_info.network;
-			psta = rtw_get_stainfo(&padapter->stapriv, cur_network->MacAddress);
+			psta = rtw_get_stainfo(&padapter->stapriv, cur_network->mac_address);
 			rtw_hal_update_ra_mask(psta, 0);
 		}
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 02676da5c166a5..175954924d2c01 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1213,7 +1213,7 @@ u8 GetHalDefVar(
 
 			pmlmepriv = &adapter->mlmepriv;
 			pstapriv = &adapter->stapriv;
-			psta = rtw_get_stainfo(pstapriv, pmlmepriv->cur_network.network.MacAddress);
+			psta = rtw_get_stainfo(pstapriv, pmlmepriv->cur_network.network.mac_address);
 			if (psta)
 				*((int *)value) = psta->rssi_stat.UndecoratedSmoothedPWDB;
 		}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index fd2b74003faf07..9ca2e0861733c2 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -153,21 +153,21 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	pktlen += 8;
 
 	/*  beacon interval: 2 bytes */
-	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pktlen += 2;
 
 	/*  capability info: 2 bytes */
-	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pktlen += 2;
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
-		/* DBG_871X("ie len =%d\n", cur_network->IELength); */
-		pktlen += cur_network->IELength - sizeof(struct ndis_802_11_fix_ie);
-		memcpy(pframe, cur_network->IEs+sizeof(struct ndis_802_11_fix_ie), pktlen);
+		/* DBG_871X("ie len =%d\n", cur_network->ie_length); */
+		pktlen += cur_network->ie_length - sizeof(struct ndis_802_11_fix_ie);
+		memcpy(pframe, cur_network->ies+sizeof(struct ndis_802_11_fix_ie), pktlen);
 
 		goto _ConstructBeacon;
 	}
@@ -175,19 +175,19 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	/* below for ad-hoc mode */
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pktlen);
+	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->ssid.SsidLength, cur_network->ssid.Ssid, &pktlen);
 
 	/*  supported rates... */
-	rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
-	pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pktlen);
+	rate_len = rtw_get_rateset_len(cur_network->supported_rates);
+	pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->supported_rates, &pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pktlen);
+	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->configuration.DSConfig), &pktlen);
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 		u32 ATIMWindow;
 		/*  IBSS Parameter Set... */
-		/* ATIMWindow = cur->Configuration.ATIMWindow; */
+		/* ATIMWindow = cur->configuration.ATIMWindow; */
 		ATIMWindow = 0;
 		pframe = rtw_set_ie(pframe, _IBSS_PARA_IE_, 2, (unsigned char *)(&ATIMWindow), &pktlen);
 	}
@@ -198,7 +198,7 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 
 	/*  EXTERNDED SUPPORTED RATE */
 	if (rate_len > 8)
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->SupportedRates + 8), &pktlen);
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->supported_rates + 8), &pktlen);
 
 
 	/* todo:HT for adhoc */
@@ -274,7 +274,7 @@ static void ConstructNullFunctionData(
 	if (bForcePowerSave)
 		SetPwrMgt(fctrl);
 
-	switch (cur_network->network.InfrastructureMode) {
+	switch (cur_network->network.infrastructure_mode) {
 	case Ndis802_11Infrastructure:
 		SetToDs(fctrl);
 		memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
@@ -729,7 +729,7 @@ static void ConstructProbeRsp(struct adapter *padapter, u8 *pframe, u32 *pLength
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	mac = myid(&(padapter->eeprompriv));
-	bssid = cur_network->MacAddress;
+	bssid = cur_network->mac_address;
 
 	fctrl = &(pwlanhdr->frame_control);
 	*(fctrl) = 0;
@@ -746,24 +746,24 @@ static void ConstructProbeRsp(struct adapter *padapter, u8 *pframe, u32 *pLength
 	pktlen = sizeof(struct ieee80211_hdr_3addr);
 	pframe += pktlen;
 
-	if (cur_network->IELength > MAX_IE_SZ)
+	if (cur_network->ie_length > MAX_IE_SZ)
 		return;
 
-	pwps_ie = rtw_get_wps_ie(cur_network->IEs+_FIXED_IE_LENGTH_,
-			cur_network->IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
+	pwps_ie = rtw_get_wps_ie(cur_network->ies+_FIXED_IE_LENGTH_,
+			cur_network->ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 	/* inerset & update wps_probe_resp_ie */
 	if (pmlmepriv->wps_probe_resp_ie && pwps_ie && (wps_ielen > 0)) {
 		uint wps_offset, remainder_ielen;
 		u8 *premainder_ie;
 
-		wps_offset = (uint)(pwps_ie - cur_network->IEs);
+		wps_offset = (uint)(pwps_ie - cur_network->ies);
 
 		premainder_ie = pwps_ie + wps_ielen;
 
-		remainder_ielen = cur_network->IELength - wps_offset - wps_ielen;
+		remainder_ielen = cur_network->ie_length - wps_offset - wps_ielen;
 
-		memcpy(pframe, cur_network->IEs, wps_offset);
+		memcpy(pframe, cur_network->ies, wps_offset);
 		pframe += wps_offset;
 		pktlen += wps_offset;
 
@@ -780,12 +780,12 @@ static void ConstructProbeRsp(struct adapter *padapter, u8 *pframe, u32 *pLength
 			pktlen += remainder_ielen;
 		}
 	} else {
-		memcpy(pframe, cur_network->IEs, cur_network->IELength);
-		pframe += cur_network->IELength;
-		pktlen += cur_network->IELength;
+		memcpy(pframe, cur_network->ies, cur_network->ie_length);
+		pframe += cur_network->ie_length;
+		pktlen += cur_network->ie_length;
 	}
 
-	/* retrieve SSID IE from cur_network->Ssid */
+	/* retrieve SSID IE from cur_network->ssid */
 	{
 		u8 *ssid_ie;
 		sint ssid_ielen;
@@ -796,9 +796,9 @@ static void ConstructProbeRsp(struct adapter *padapter, u8 *pframe, u32 *pLength
 		ssid_ie = rtw_get_ie(ies+_FIXED_IE_LENGTH_, _SSID_IE_, &ssid_ielen,
 					(pframe-ies)-_FIXED_IE_LENGTH_);
 
-		ssid_ielen_diff = cur_network->Ssid.SsidLength - ssid_ielen;
+		ssid_ielen_diff = cur_network->ssid.SsidLength - ssid_ielen;
 
-		if (ssid_ie &&	cur_network->Ssid.SsidLength) {
+		if (ssid_ie &&	cur_network->ssid.SsidLength) {
 			uint remainder_ielen;
 			u8 *remainder_ie;
 			remainder_ie = ssid_ie+2;
@@ -811,8 +811,8 @@ static void ConstructProbeRsp(struct adapter *padapter, u8 *pframe, u32 *pLength
 
 			memcpy(buf, remainder_ie, remainder_ielen);
 			memcpy(remainder_ie+ssid_ielen_diff, buf, remainder_ielen);
-			*(ssid_ie+1) = cur_network->Ssid.SsidLength;
-			memcpy(ssid_ie+2, cur_network->Ssid.Ssid, cur_network->Ssid.SsidLength);
+			*(ssid_ie+1) = cur_network->ssid.SsidLength;
+			memcpy(ssid_ie+2, cur_network->ssid.Ssid, cur_network->ssid.SsidLength);
 			pframe += ssid_ielen_diff;
 			pktlen += ssid_ielen_diff;
 		}
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index cd98efccb32176..37a114d7302466 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -495,9 +495,9 @@ extern sint rtw_set_key(struct adapter *adapter, struct security_priv *psecurity
 extern sint rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv);
 
 static inline u8 *get_bssid(struct mlme_priv *pmlmepriv)
-{	/* if sta_mode:pmlmepriv->cur_network.network.MacAddress => bssid */
-	/*  if adhoc_mode:pmlmepriv->cur_network.network.MacAddress => ibss mac address */
-	return pmlmepriv->cur_network.network.MacAddress;
+{	/* if sta_mode:pmlmepriv->cur_network.network.mac_address => bssid */
+	/*  if adhoc_mode:pmlmepriv->cur_network.network.mac_address => ibss mac address */
+	return pmlmepriv->cur_network.network.mac_address;
 }
 
 static inline sint check_fwstate(struct mlme_priv *pmlmepriv, sint state)
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index ea370b2bb8db35..39163773b56027 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -75,9 +75,9 @@ struct ndis_80211_var_ie {
  * sizeof (NDIS_802_11_MAC_ADDRESS) + 2 +
  * sizeof (struct ndis_802_11_ssid) + sizeof (u32) +
  * sizeof (long) + sizeof (enum NDIS_802_11_NETWORK_TYPE) +
- * sizeof (struct ndis_802_11_conf) + sizeof (NDIS_802_11_RATES_EX) + IELength
+ * sizeof (struct ndis_802_11_conf) + sizeof (NDIS_802_11_RATES_EX) + ie_length
  *
- * Except for IELength, all other fields are fixed length. Therefore, we can
+ * Except for ie_length, all other fields are fixed length. Therefore, we can
  * define a macro to present the partial sum.
  */
 enum NDIS_802_11_AUTHENTICATION_MODE {
@@ -205,24 +205,24 @@ struct wlan_bcn_info {
 *   struct wlan_bssid_ex and get_wlan_bssid_ex_sz()
 */
 struct wlan_bssid_ex {
-	u32  Length;
-	NDIS_802_11_MAC_ADDRESS  MacAddress;
+	u32  length;
+	NDIS_802_11_MAC_ADDRESS  mac_address;
 	u8  Reserved[2];/* 0]: IS beacon frame */
-	struct ndis_802_11_ssid  Ssid;
-	u32  Privacy;
-	long  Rssi;/* in dBM, raw data , get from PHY) */
-	enum NDIS_802_11_NETWORK_TYPE  NetworkTypeInUse;
-	struct ndis_802_11_conf  Configuration;
-	enum NDIS_802_11_NETWORK_INFRASTRUCTURE  InfrastructureMode;
-	NDIS_802_11_RATES_EX  SupportedRates;
-	struct wlan_phy_info PhyInfo;
-	u32  IELength;
-	u8  IEs[MAX_IE_SZ];	/* timestamp, beacon interval, and capability information) */
+	struct ndis_802_11_ssid  ssid;
+	u32  privacy;
+	long  rssi;/* in dBM, raw data , get from PHY) */
+	enum NDIS_802_11_NETWORK_TYPE  network_type_in_use;
+	struct ndis_802_11_conf  configuration;
+	enum NDIS_802_11_NETWORK_INFRASTRUCTURE  infrastructure_mode;
+	NDIS_802_11_RATES_EX  supported_rates;
+	struct wlan_phy_info phy_info;
+	u32  ie_length;
+	u8  ies[MAX_IE_SZ];	/* timestamp, beacon interval, and capability information) */
 } __packed;
 
 static inline uint get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss)
 {
-	return (sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + bss->IELength);
+	return (sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + bss->ie_length);
 }
 
 struct	wlan_network {
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index b7993e25764d51..42978ac860e9fa 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -238,7 +238,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 
 	/* DBG_8192C("%s\n", __func__); */
 
-	bssinf_len = pnetwork->network.IELength + sizeof(struct ieee80211_hdr_3addr);
+	bssinf_len = pnetwork->network.ie_length + sizeof(struct ieee80211_hdr_3addr);
 	if (bssinf_len > MAX_BSSINFO_LEN) {
 		DBG_871X("%s IE Length too long > %d byte\n", __func__, MAX_BSSINFO_LEN);
 		goto exit;
@@ -247,7 +247,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	{
 		u16 wapi_len = 0;
 
-		if (rtw_get_wapi_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &wapi_len) > 0)
+		if (rtw_get_wapi_ie(pnetwork->network.ies, pnetwork->network.ie_length, NULL, &wapi_len) > 0)
 		{
 			if (wapi_len > 0)
 			{
@@ -262,13 +262,13 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	if (adapter_wdev_data(padapter)->scan_request != NULL)
 	{
 		u8 *psr = NULL, sr = 0;
-		struct ndis_802_11_ssid *pssid = &pnetwork->network.Ssid;
+		struct ndis_802_11_ssid *pssid = &pnetwork->network.ssid;
 		struct cfg80211_scan_request *request = adapter_wdev_data(padapter)->scan_request;
 		struct cfg80211_ssid *ssids = request->ssids;
 		u32 wpsielen = 0;
 		u8 *wpsie = NULL;
 
-		wpsie = rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wpsielen);
+		wpsie = rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wpsielen);
 
 		if (wpsie && wpsielen > 0)
 			psr = rtw_get_wps_attr_content(wpsie,  wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
@@ -297,7 +297,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	/* spin_unlock_bh(&pwdev_priv->scan_req_lock); */
 
 
-	channel = pnetwork->network.Configuration.DSConfig;
+	channel = pnetwork->network.configuration.DSConfig;
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
 
 	notify_channel = ieee80211_get_channel(wiphy, freq);
@@ -309,7 +309,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network, 0)) {
 		notify_signal = 100*translate_percentage_to_dbm(padapter->recvpriv.signal_strength);/* dbm */
 	} else {
-		notify_signal = 100*translate_percentage_to_dbm(pnetwork->network.PhyInfo.SignalStrength);/* dbm */
+		notify_signal = 100*translate_percentage_to_dbm(pnetwork->network.phy_info.SignalStrength);/* dbm */
 	}
 
 	buf = kzalloc(MAX_BSSINFO_LEN, GFP_ATOMIC);
@@ -332,15 +332,15 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		SetFrameSubType(pbuf, WIFI_PROBERSP);
 	}
 
-	memcpy(pwlanhdr->addr2, pnetwork->network.MacAddress, ETH_ALEN);
-	memcpy(pwlanhdr->addr3, pnetwork->network.MacAddress, ETH_ALEN);
+	memcpy(pwlanhdr->addr2, pnetwork->network.mac_address, ETH_ALEN);
+	memcpy(pwlanhdr->addr3, pnetwork->network.mac_address, ETH_ALEN);
 
 
 	pbuf += sizeof(struct ieee80211_hdr_3addr);
 	len = sizeof(struct ieee80211_hdr_3addr);
 
-	memcpy(pbuf, pnetwork->network.IEs, pnetwork->network.IELength);
-	len += pnetwork->network.IELength;
+	memcpy(pbuf, pnetwork->network.ies, pnetwork->network.ie_length);
+	len += pnetwork->network.ie_length;
 
 	*((__le64 *)pbuf) = cpu_to_le64(notify_timestamp);
 
@@ -376,12 +376,12 @@ int rtw_cfg80211_check_bss(struct adapter *padapter)
 	if (!(pnetwork) || !(padapter->rtw_wdev))
 		return false;
 
-	freq = rtw_ieee80211_channel_to_frequency(pnetwork->Configuration.DSConfig, NL80211_BAND_2GHZ);
+	freq = rtw_ieee80211_channel_to_frequency(pnetwork->configuration.DSConfig, NL80211_BAND_2GHZ);
 
 	notify_channel = ieee80211_get_channel(padapter->rtw_wdev->wiphy, freq);
 	bss = cfg80211_get_bss(padapter->rtw_wdev->wiphy, notify_channel,
-			pnetwork->MacAddress, pnetwork->Ssid.Ssid,
-			pnetwork->Ssid.SsidLength,
+			pnetwork->mac_address, pnetwork->ssid.Ssid,
+			pnetwork->ssid.SsidLength,
 			WLAN_CAPABILITY_ESS, WLAN_CAPABILITY_ESS);
 
 	cfg80211_put_bss(padapter->rtw_wdev->wiphy, bss);
@@ -395,7 +395,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 	struct wireless_dev *pwdev = padapter->rtw_wdev;
 	struct wiphy *wiphy = pwdev->wiphy;
-	int freq = (int)cur_network->network.Configuration.DSConfig;
+	int freq = (int)cur_network->network.configuration.DSConfig;
 	struct ieee80211_channel *chan;
 
 	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
@@ -423,8 +423,8 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 				rtw_warn_on(1);
 				return;
 			}
-			if (!memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
-				&& !memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
+			if (!memcmp(&(scanned->network.ssid), &(pnetwork->ssid), sizeof(struct ndis_802_11_ssid))
+				&& !memcmp(scanned->network.mac_address, pnetwork->mac_address, sizeof(NDIS_802_11_MAC_ADDRESS))
 			) {
 				if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
 					DBG_871X(FUNC_ADPT_FMT" inform fail !!\n", FUNC_ADPT_ARG(padapter));
@@ -442,7 +442,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 	}
 	/* notify cfg80211 that device joined an IBSS */
 	chan = ieee80211_get_channel(wiphy, freq);
-	cfg80211_ibss_joined(padapter->pnetdev, cur_network->network.MacAddress, chan, GFP_ATOMIC);
+	cfg80211_ibss_joined(padapter->pnetdev, cur_network->network.mac_address, chan, GFP_ATOMIC);
 }
 
 void rtw_cfg80211_indicate_connect(struct adapter *padapter)
@@ -472,8 +472,8 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 			goto check_bss;
 		}
 
-		if (!memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
-			&& !memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
+		if (!memcmp(scanned->network.mac_address, pnetwork->mac_address, sizeof(NDIS_802_11_MAC_ADDRESS))
+			&& !memcmp(&(scanned->network.ssid), &(pnetwork->ssid), sizeof(struct ndis_802_11_ssid))
 		) {
 			if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
 				DBG_871X(FUNC_ADPT_FMT" inform fail !!\n", FUNC_ADPT_ARG(padapter));
@@ -482,8 +482,8 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 			}
 		} else {
 			DBG_871X("scanned: %s("MAC_FMT"), cur: %s("MAC_FMT")\n",
-				scanned->network.Ssid.Ssid, MAC_ARG(scanned->network.MacAddress),
-				pnetwork->Ssid.Ssid, MAC_ARG(pnetwork->MacAddress)
+				scanned->network.ssid.Ssid, MAC_ARG(scanned->network.mac_address),
+				pnetwork->ssid.Ssid, MAC_ARG(pnetwork->mac_address)
 			);
 			rtw_warn_on(1);
 		}
@@ -497,7 +497,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		struct wiphy *wiphy = pwdev->wiphy;
 		struct ieee80211_channel *notify_channel;
 		u32 freq;
-		u16 channel = cur_network->network.Configuration.DSConfig;
+		u16 channel = cur_network->network.configuration.DSConfig;
 		struct cfg80211_roam_info roam_info = {};
 
 		freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
@@ -506,7 +506,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 
 		DBG_871X(FUNC_ADPT_FMT" call cfg80211_roamed\n", FUNC_ADPT_ARG(padapter));
 		roam_info.channel = notify_channel;
-		roam_info.bssid = cur_network->network.MacAddress;
+		roam_info.bssid = cur_network->network.mac_address;
 		roam_info.req_ie =
 			pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2;
 		roam_info.req_ie_len =
@@ -519,7 +519,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 	}
 	else
 	{
-		cfg80211_connect_result(padapter->pnetdev, cur_network->network.MacAddress
+		cfg80211_connect_result(padapter->pnetdev, cur_network->network.mac_address
 			, pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2
 			, pmlmepriv->assoc_req_len-sizeof(struct ieee80211_hdr_3addr)-2
 			, pmlmepriv->assoc_rsp+sizeof(struct ieee80211_hdr_3addr)+6
@@ -1232,8 +1232,8 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	{
 		struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 
-		if (memcmp((u8 *)mac, cur_network->network.MacAddress, ETH_ALEN)) {
-			DBG_871X("%s, mismatch bssid ="MAC_FMT"\n", __func__, MAC_ARG(cur_network->network.MacAddress));
+		if (memcmp((u8 *)mac, cur_network->network.mac_address, ETH_ALEN)) {
+			DBG_871X("%s, mismatch bssid ="MAC_FMT"\n", __func__, MAC_ARG(cur_network->network.mac_address));
 			ret = -ENOENT;
 			goto exit;
 		}
@@ -1385,14 +1385,14 @@ void rtw_cfg80211_unlink_bss(struct adapter *padapter, struct wlan_network *pnet
 	struct wlan_bssid_ex *select_network = &pnetwork->network;
 
 	bss = cfg80211_get_bss(wiphy, NULL/*notify_channel*/,
-		select_network->MacAddress, select_network->Ssid.Ssid,
-		select_network->Ssid.SsidLength, 0/*WLAN_CAPABILITY_ESS*/,
+		select_network->mac_address, select_network->ssid.Ssid,
+		select_network->ssid.SsidLength, 0/*WLAN_CAPABILITY_ESS*/,
 		0/*WLAN_CAPABILITY_ESS*/);
 
 	if (bss) {
 		cfg80211_unlink_bss(wiphy, bss);
 		DBG_8192C("%s(): cfg80211_unlink %s!! () ", __func__,
-			  select_network->Ssid.Ssid);
+			  select_network->ssid.Ssid);
 		cfg80211_put_bss(padapter->rtw_wdev->wiphy, bss);
 	}
 }
@@ -1421,9 +1421,9 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 		pnetwork = LIST_CONTAINOR(plist, struct wlan_network, list);
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
-		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.Configuration.DSConfig) >= 0
-			&& rtw_mlme_band_check(padapter, pnetwork->network.Configuration.DSConfig) == true
-			&& true == rtw_validate_ssid(&(pnetwork->network.Ssid))
+		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.configuration.DSConfig) >= 0
+			&& rtw_mlme_band_check(padapter, pnetwork->network.configuration.DSConfig) == true
+			&& true == rtw_validate_ssid(&(pnetwork->network.ssid))
 		)
 		{
 			/* ev =translate_scan(padapter, a, pnetwork, ev, stop); */
@@ -2734,7 +2734,7 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 	if (rtw_get_wps_ie(pbuf+_FIXED_IE_LENGTH_, len-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
 		DBG_8192C("add bcn, wps_ielen =%d\n", wps_ielen);
 
-	/* pbss_network->IEs will not include p2p_ie, wfd ie */
+	/* pbss_network->ies will not include p2p_ie, wfd ie */
 	rtw_ies_remove_ie(pbuf, &len, _BEACON_IE_OFFSET_, _VENDOR_SPECIFIC_IE_, P2P_OUI, 4);
 	rtw_ies_remove_ie(pbuf, &len, _BEACON_IE_OFFSET_, _VENDOR_SPECIFIC_IE_, WFD_OUI, 4);
 
@@ -2771,10 +2771,10 @@ static int cfg80211_rtw_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 		struct wlan_bssid_ex *pbss_network = &adapter->mlmepriv.cur_network.network;
 		struct wlan_bssid_ex *pbss_network_ext = &adapter->mlmeextpriv.mlmext_info.network;
 
-		memcpy(pbss_network->Ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
-		pbss_network->Ssid.SsidLength = settings->ssid_len;
-		memcpy(pbss_network_ext->Ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
-		pbss_network_ext->Ssid.SsidLength = settings->ssid_len;
+		memcpy(pbss_network->ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
+		pbss_network->ssid.SsidLength = settings->ssid_len;
+		memcpy(pbss_network_ext->ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
+		pbss_network_ext->ssid.SsidLength = settings->ssid_len;
 	}
 
 	return ret;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 70247ba9017a59..099218ff22c25e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -60,9 +60,9 @@ void rtw_indicate_wx_assoc_event(struct adapter *padapter)
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)
-		memcpy(wrqu.ap_addr.sa_data, pnetwork->MacAddress, ETH_ALEN);
+		memcpy(wrqu.ap_addr.sa_data, pnetwork->mac_address, ETH_ALEN);
 	else
-		memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress, ETH_ALEN);
+		memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.mac_address, ETH_ALEN);
 
 	DBG_871X_LEVEL(_drv_always_, "assoc success\n");
 }
@@ -98,20 +98,20 @@ static char *translate_scan(struct adapter *padapter,
 	iwe.cmd = SIOCGIWAP;
 	iwe.u.ap_addr.sa_family = ARPHRD_ETHER;
 
-	memcpy(iwe.u.ap_addr.sa_data, pnetwork->network.MacAddress, ETH_ALEN);
+	memcpy(iwe.u.ap_addr.sa_data, pnetwork->network.mac_address, ETH_ALEN);
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_ADDR_LEN);
 
 	/* Add the ESSID */
 	iwe.cmd = SIOCGIWESSID;
 	iwe.u.data.flags = 1;
-	iwe.u.data.length = min((u16)pnetwork->network.Ssid.SsidLength, (u16)32);
-	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
+	iwe.u.data.length = min((u16)pnetwork->network.ssid.SsidLength, (u16)32);
+	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.Ssid);
 
 	/* parsing HT_CAP_IE */
 	if (pnetwork->network.Reserved[0] == 2) { /*  Probe Request */
-		p = rtw_get_ie(&pnetwork->network.IEs[0], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength);
+		p = rtw_get_ie(&pnetwork->network.ies[0], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.ie_length);
 	} else {
-		p = rtw_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength-12);
+		p = rtw_get_ie(&pnetwork->network.ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.ie_length-12);
 	}
 	if (p && ht_ielen > 0) {
 		struct rtw_ieee80211_ht_cap *pht_capie;
@@ -124,18 +124,18 @@ static char *translate_scan(struct adapter *padapter,
 
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
-	if (rtw_is_cckratesonly_included((u8 *)&pnetwork->network.SupportedRates)) {
+	if (rtw_is_cckratesonly_included((u8 *)&pnetwork->network.supported_rates)) {
 		if (ht_cap)
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bn");
 		else
 		snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11b");
-	} else if (rtw_is_cckrates_included((u8 *)&pnetwork->network.SupportedRates)) {
+	} else if (rtw_is_cckrates_included((u8 *)&pnetwork->network.supported_rates)) {
 		if (ht_cap)
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bgn");
 		else
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
 	} else {
-		if (pnetwork->network.Configuration.DSConfig <= 14) {
+		if (pnetwork->network.configuration.DSConfig <= 14) {
 			if (ht_cap)
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
 			else
@@ -152,7 +152,7 @@ static char *translate_scan(struct adapter *padapter,
 		__le16 le_tmp;
 
 	        iwe.cmd = SIOCGIWMODE;
-		memcpy((u8 *)&le_tmp, rtw_get_capability_from_ie(pnetwork->network.IEs), 2);
+		memcpy((u8 *)&le_tmp, rtw_get_capability_from_ie(pnetwork->network.ies), 2);
 		cap = le16_to_cpu(le_tmp);
 	}
 
@@ -165,14 +165,14 @@ static char *translate_scan(struct adapter *padapter,
 		start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN);
 	}
 
-	if (pnetwork->network.Configuration.DSConfig < 1)
-		pnetwork->network.Configuration.DSConfig = 1;
+	if (pnetwork->network.configuration.DSConfig < 1)
+		pnetwork->network.configuration.DSConfig = 1;
 
 	 /* Add frequency/channel */
 	iwe.cmd = SIOCGIWFREQ;
-	iwe.u.freq.m = rtw_ch2freq(pnetwork->network.Configuration.DSConfig) * 100000;
+	iwe.u.freq.m = rtw_ch2freq(pnetwork->network.configuration.DSConfig) * 100000;
 	iwe.u.freq.e = 1;
-	iwe.u.freq.i = pnetwork->network.Configuration.DSConfig;
+	iwe.u.freq.i = pnetwork->network.configuration.DSConfig;
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_FREQ_LEN);
 
 	/* Add encryption capability */
@@ -182,7 +182,7 @@ static char *translate_scan(struct adapter *padapter,
 	else
 		iwe.u.data.flags = IW_ENCODE_DISABLED;
 	iwe.u.data.length = 0;
-	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
+	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.Ssid);
 
 	/*Add basic and extended rates */
 	max_rate = 0;
@@ -191,8 +191,8 @@ static char *translate_scan(struct adapter *padapter,
 		return start;
 	p = custom;
 	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom), " Rates (Mb/s): ");
-	while (pnetwork->network.SupportedRates[i] != 0) {
-		rate = pnetwork->network.SupportedRates[i]&0x7F;
+	while (pnetwork->network.supported_rates[i] != 0) {
+		rate = pnetwork->network.supported_rates[i]&0x7F;
 		if (rate > max_rate)
 			max_rate = rate;
 		p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
@@ -224,8 +224,8 @@ static char *translate_scan(struct adapter *padapter,
 		u8 wpa_ie[255], rsn_ie[255];
 		u16 wpa_len = 0, rsn_len = 0;
 		u8 *p;
-		rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
+		rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
+		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.ssid.Ssid));
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
@@ -280,14 +280,14 @@ static char *translate_scan(struct adapter *padapter,
 		uint wps_ielen = 0;
 
 		u8 *ie_ptr;
-		total_ielen = pnetwork->network.IELength - ie_offset;
+		total_ielen = pnetwork->network.ie_length - ie_offset;
 
 		if (pnetwork->network.Reserved[0] == 2) { /*  Probe Request */
-			ie_ptr = pnetwork->network.IEs;
-			total_ielen = pnetwork->network.IELength;
+			ie_ptr = pnetwork->network.ies;
+			total_ielen = pnetwork->network.ie_length;
 		} else {    /*  Beacon or Probe Respones */
-			ie_ptr = pnetwork->network.IEs + _FIXED_IE_LENGTH_;
-			total_ielen = pnetwork->network.IELength - _FIXED_IE_LENGTH_;
+			ie_ptr = pnetwork->network.ies + _FIXED_IE_LENGTH_;
+			total_ielen = pnetwork->network.ie_length - _FIXED_IE_LENGTH_;
 		}
 
 		while (cnt < total_ielen) {
@@ -319,8 +319,8 @@ static char *translate_scan(struct adapter *padapter,
 		ss = padapter->recvpriv.signal_strength;
 		sq = padapter->recvpriv.signal_qual;
 	} else {
-		ss = pnetwork->network.PhyInfo.SignalStrength;
-		sq = pnetwork->network.PhyInfo.SignalQuality;
+		ss = pnetwork->network.phy_info.SignalStrength;
+		sq = pnetwork->network.phy_info.SignalQuality;
 	}
 
 
@@ -345,7 +345,7 @@ static char *translate_scan(struct adapter *padapter,
 	#if defined(CONFIG_SIGNAL_DISPLAY_DBM) && defined(CONFIG_BACKGROUND_NOISE_MONITOR)
 	{
 		s16 tmp_noise = 0;
-		rtw_hal_get_odm_var(padapter, HAL_ODM_NOISE_MONITOR, &(pnetwork->network.Configuration.DSConfig), &(tmp_noise));
+		rtw_hal_get_odm_var(padapter, HAL_ODM_NOISE_MONITOR, &(pnetwork->network.configuration.DSConfig), &(tmp_noise));
 		iwe.u.qual.noise = tmp_noise;
 	}
 	#else
@@ -764,11 +764,11 @@ static int rtw_wx_get_name(struct net_device *dev,
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
 		/* parsing HT_CAP_IE */
-		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength-12);
+		p = rtw_get_ie(&pcur_bss->ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->ie_length-12);
 		if (p && ht_ielen > 0)
 			ht_cap = true;
 
-		prates = &pcur_bss->SupportedRates;
+		prates = &pcur_bss->supported_rates;
 
 		if (rtw_is_cckratesonly_included((u8 *)prates)) {
 			if (ht_cap)
@@ -781,7 +781,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
 		} else {
-			if (pcur_bss->Configuration.DSConfig <= 14) {
+			if (pcur_bss->configuration.DSConfig <= 14) {
 				if (ht_cap)
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
 				else
@@ -789,7 +789,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 			}
 		}
 	} else {
-		/* prates = &padapter->registrypriv.dev_network.SupportedRates; */
+		/* prates = &padapter->registrypriv.dev_network.supported_rates; */
 		/* snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g"); */
 		snprintf(wrqu->name, IFNAMSIZ, "unassociated");
 	}
@@ -814,10 +814,10 @@ static int rtw_wx_get_freq(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
-		/* wrqu->freq.m = ieee80211_wlan_frequencies[pcur_bss->Configuration.DSConfig-1] * 100000; */
-		wrqu->freq.m = rtw_ch2freq(pcur_bss->Configuration.DSConfig) * 100000;
+		/* wrqu->freq.m = ieee80211_wlan_frequencies[pcur_bss->configuration.DSConfig-1] * 100000; */
+		wrqu->freq.m = rtw_ch2freq(pcur_bss->configuration.DSConfig) * 100000;
 		wrqu->freq.e = 1;
-		wrqu->freq.i = pcur_bss->Configuration.DSConfig;
+		wrqu->freq.i = pcur_bss->configuration.DSConfig;
 
 	} else {
 		wrqu->freq.m = rtw_ch2freq(padapter->mlmeextpriv.cur_channel) * 100000;
@@ -1151,12 +1151,12 @@ static int rtw_wx_set_wap(struct net_device *dev,
 
 		pmlmepriv->pscanned = get_next(pmlmepriv->pscanned);
 
-		dst_bssid = pnetwork->network.MacAddress;
+		dst_bssid = pnetwork->network.mac_address;
 
 		src_bssid = temp->sa_data;
 
 		if ((!memcmp(dst_bssid, src_bssid, ETH_ALEN))) {
-			if (!rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.InfrastructureMode)) {
+			if (!rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.infrastructure_mode)) {
 				ret = -1;
 				spin_unlock_bh(&queue->lock);
 				goto exit;
@@ -1199,7 +1199,7 @@ static int rtw_wx_get_wap(struct net_device *dev,
 	if  (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
 			((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
 			((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true)) {
-		memcpy(wrqu->ap_addr.sa_data, pcur_bss->MacAddress, ETH_ALEN);
+		memcpy(wrqu->ap_addr.sa_data, pcur_bss->mac_address, ETH_ALEN);
 	} else {
 		eth_zero_addr(wrqu->ap_addr.sa_data);
 	}
@@ -1447,9 +1447,9 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 		pnetwork = LIST_CONTAINOR(plist, struct wlan_network, list);
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
-		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.Configuration.DSConfig) >= 0
-			&& rtw_mlme_band_check(padapter, pnetwork->network.Configuration.DSConfig) == true
-			&& true == rtw_validate_ssid(&(pnetwork->network.Ssid))) {
+		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.configuration.DSConfig) >= 0
+			&& rtw_mlme_band_check(padapter, pnetwork->network.configuration.DSConfig) == true
+			&& true == rtw_validate_ssid(&(pnetwork->network.ssid))) {
 
 			ev = translate_scan(padapter, a, pnetwork, ev, stop);
 		}
@@ -1551,23 +1551,23 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 			pmlmepriv->pscanned = get_next(pmlmepriv->pscanned);
 
-			dst_ssid = pnetwork->network.Ssid.Ssid;
+			dst_ssid = pnetwork->network.ssid.Ssid;
 
 			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
 				 ("rtw_wx_set_essid: dst_ssid =%s\n",
-				  pnetwork->network.Ssid.Ssid));
+				  pnetwork->network.ssid.Ssid));
 
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)) &&
-				(pnetwork->network.Ssid.SsidLength == ndis_ssid.SsidLength)) {
+				(pnetwork->network.ssid.SsidLength == ndis_ssid.SsidLength)) {
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
 					 ("rtw_wx_set_essid: find match, set infra mode\n"));
 
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
-					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
+					if (pnetwork->network.infrastructure_mode != pmlmepriv->cur_network.network.infrastructure_mode)
 						continue;
 				}
 
-				if (rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.InfrastructureMode) == false) {
+				if (rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.infrastructure_mode) == false) {
 					ret = -1;
 					spin_unlock_bh(&queue->lock);
 					goto exit;
@@ -1613,11 +1613,11 @@ static int rtw_wx_get_essid(struct net_device *dev,
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) ||
 	      (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
-		len = pcur_bss->Ssid.SsidLength;
+		len = pcur_bss->ssid.SsidLength;
 
 		wrqu->essid.length = len;
 
-		memcpy(extra, pcur_bss->Ssid.Ssid, len);
+		memcpy(extra, pcur_bss->ssid.Ssid, len);
 
 		wrqu->essid.flags = 1;
 	} else {
@@ -2476,16 +2476,16 @@ static int rtw_get_ap_info(struct net_device *dev,
 		}
 
 
-		if (!memcmp(bssid, pnetwork->network.MacAddress, ETH_ALEN)) { /* BSSID match, then check if supporting wpa/wpa2 */
+		if (!memcmp(bssid, pnetwork->network.mac_address, ETH_ALEN)) { /* BSSID match, then check if supporting wpa/wpa2 */
 			DBG_871X("BSSID:" MAC_FMT "\n", MAC_ARG(bssid));
 
-			pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+			pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 			if (pbuf && (wpa_ielen > 0)) {
 				pdata->flags = 1;
 				break;
 			}
 
-			pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+			pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 			if (pbuf && (wpa_ielen > 0)) {
 				pdata->flags = 2;
 				break;
@@ -2750,7 +2750,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			}
 			break;
 		case 0x7a:
-			receive_disconnect(padapter, pmlmeinfo->network.MacAddress
+			receive_disconnect(padapter, pmlmeinfo->network.mac_address
 				, WLAN_REASON_EXPIRATION_CHK);
 			break;
 		case 0x7F:
@@ -2781,12 +2781,12 @@ static int rtw_dbg_port(struct net_device *dev,
 
 					break;
 				case 0x05:
-					psta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
+					psta = rtw_get_stainfo(pstapriv, cur_network->network.mac_address);
 					if (psta) {
 						int i;
 						struct recv_reorder_ctrl *preorder_ctrl;
 
-						DBG_871X("SSID =%s\n", cur_network->network.Ssid.Ssid);
+						DBG_871X("SSID =%s\n", cur_network->network.ssid.Ssid);
 						DBG_871X("sta's macaddr:" MAC_FMT "\n", MAC_ARG(psta->hwaddr));
 						DBG_871X("cur_channel =%d, cur_bwmode =%d, cur_ch_offset =%d\n", pmlmeext->cur_channel, pmlmeext->cur_bwmode, pmlmeext->cur_ch_offset);
 						DBG_871X("rtsen =%d, cts2slef =%d\n", psta->rtsen, psta->cts2self);
@@ -2803,7 +2803,7 @@ static int rtw_dbg_port(struct net_device *dev,
 						}
 
 					} else {
-						DBG_871X("can't get sta's macaddr, cur_network's macaddr:" MAC_FMT "\n", MAC_ARG(cur_network->network.MacAddress));
+						DBG_871X("can't get sta's macaddr, cur_network's macaddr:" MAC_FMT "\n", MAC_ARG(cur_network->network.mac_address));
 					}
 					break;
 				case 0x06:
@@ -4097,18 +4097,18 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 		if (0)
 			DBG_871X(FUNC_ADPT_FMT" ssid:(%s,%d), from ie:(%s,%d), (%s,%d)\n", FUNC_ADPT_ARG(adapter),
 				 ssid, ssid_len,
-				 pbss_network->Ssid.Ssid, pbss_network->Ssid.SsidLength,
-				 pbss_network_ext->Ssid.Ssid, pbss_network_ext->Ssid.SsidLength);
+				 pbss_network->ssid.Ssid, pbss_network->ssid.SsidLength,
+				 pbss_network_ext->ssid.Ssid, pbss_network_ext->ssid.SsidLength);
 
-		memcpy(pbss_network->Ssid.Ssid, (void *)ssid, ssid_len);
-		pbss_network->Ssid.SsidLength = ssid_len;
-		memcpy(pbss_network_ext->Ssid.Ssid, (void *)ssid, ssid_len);
-		pbss_network_ext->Ssid.SsidLength = ssid_len;
+		memcpy(pbss_network->ssid.Ssid, (void *)ssid, ssid_len);
+		pbss_network->ssid.SsidLength = ssid_len;
+		memcpy(pbss_network_ext->ssid.Ssid, (void *)ssid, ssid_len);
+		pbss_network_ext->ssid.SsidLength = ssid_len;
 
 		if (0)
 			DBG_871X(FUNC_ADPT_FMT" after ssid:(%s,%d), (%s,%d)\n", FUNC_ADPT_ARG(adapter),
-				 pbss_network->Ssid.Ssid, pbss_network->Ssid.SsidLength,
-				 pbss_network_ext->Ssid.Ssid, pbss_network_ext->Ssid.SsidLength);
+				 pbss_network->ssid.Ssid, pbss_network->ssid.SsidLength,
+				 pbss_network_ext->ssid.Ssid, pbss_network_ext->ssid.SsidLength);
 	}
 
 	DBG_871X(FUNC_ADPT_FMT" ignore_broadcast_ssid:%d, %s,%d\n", FUNC_ADPT_ARG(adapter),
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 27f990a01a23fd..a0ba1b8a14c31d 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1210,9 +1210,9 @@ static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
 			&& check_fwstate(pmlmepriv, _FW_LINKED)) {
 			DBG_871X("%s %s(" MAC_FMT "), length:%d assoc_ssid.length:%d\n", __func__,
-					pmlmepriv->cur_network.network.Ssid.Ssid,
-					MAC_ARG(pmlmepriv->cur_network.network.MacAddress),
-					pmlmepriv->cur_network.network.Ssid.SsidLength,
+					pmlmepriv->cur_network.network.ssid.Ssid,
+					MAC_ARG(pmlmepriv->cur_network.network.mac_address),
+					pmlmepriv->cur_network.network.ssid.SsidLength,
 					pmlmepriv->assoc_ssid.SsidLength);
 			rtw_set_to_roam(padapter, 1);
 		}
@@ -1285,9 +1285,9 @@ void rtw_suspend_wow(struct adapter *padapter)
 		if (rtw_chk_roam_flags(padapter, RTW_ROAM_ON_RESUME)) {
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) && check_fwstate(pmlmepriv, _FW_LINKED)) {
 				DBG_871X("%s %s(" MAC_FMT "), length:%d assoc_ssid.length:%d\n", __func__,
-						pmlmepriv->cur_network.network.Ssid.Ssid,
-						MAC_ARG(pmlmepriv->cur_network.network.MacAddress),
-						pmlmepriv->cur_network.network.Ssid.SsidLength,
+						pmlmepriv->cur_network.network.ssid.Ssid,
+						MAC_ARG(pmlmepriv->cur_network.network.mac_address),
+						pmlmepriv->cur_network.network.ssid.SsidLength,
 						pmlmepriv->assoc_ssid.SsidLength);
 
 				rtw_set_to_roam(padapter, 0);
-- 
2.53.0

