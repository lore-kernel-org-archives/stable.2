Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298BA25CC57
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114191; cv=none; b=jmWQRZh2XwBXhW4MMI2hRk0TbfVzqnjmOT6hyJTPA4SwSVdUsJDyaivKKGNlz2CNsZQIUcQe+n4ccibS9A8iFmNvX5gW1yXCF2isMnB0/Sj5uXupXb4HGkl59GZ+cBXgyh45GG8QSYYzhw+GM4DFiu3kz8bTc5Fw/APB/m7AJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114191; c=relaxed/simple;
	bh=M3PB6YGnXT2oY2d1phXIrIocOq5skRFLXmjSb02+HJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7v3oKbTXfVoWFdVmGKzK/PjDxx9UYYWFmgNATw+jAuFxrOXtsXhFKLkf7BMid5tc/KItwIpH25K/CmKYlrji1g+wcJ5EQJEMvyKOw5/4ByfJOy+Tpoo+H+RxfoOeTbZjBBRhpcCLzAXDN+0v0yK0XYT05vXe08PWj/C5O32uR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6XLM9W+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6XLM9W+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929DE1F00A3D;
	Wed, 15 Jul 2026 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114190;
	bh=qrBJCXTk7G19K85XeedmWb1wxxUZ9wJeMw0zXpIxpvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O6XLM9W+QPQxUyegljk2lANGEz7Hn4thXtDQtmfuiR3wnt1MCjLySZ7+jzw/FLhPw
	 oEd/47hsZw+oNdS8S9laM18k6FmDxxF7WRjtqPcbXvvJ2qVHr9eXSRNEnLtVFQyM4Z
	 Q/YSEBvABAVzImyw5VFW+Gd9nu/8HL/BLg2kSys4SdExxniiLdjm9wLEzDLAnOc+CA
	 LYPEuXE9Qd7BvFAOLoWwhL/jBcXBNCHmvKRh5VAPwGgFa5YdYkdi34JbahaCY0S0+j
	 0UCbcWr59zqEqnDDgxt5cgll/47gSAjqMYoA6Fw1ImFiMshHfatbdze7JPw3SFcz8B
	 oKtO8JD0cfoTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 04/10] staging: rtl8723bs: fix camel case in struct wlan_bcn_info
Date: Wed, 15 Jul 2026 07:16:19 -0400
Message-ID: <20260715111625.647536-4-sashal@kernel.org>
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

[ Upstream commit d7361874468f9b963d0263223c299f0afd7e51a7 ]

fix camel case in struct wlan_bcn_info all over the driver.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/52c74cf0183da44f2ddaac2607e4b7ccaf9abd91.1626874164.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 38 +++++++++----------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 22 +++++------
 .../staging/rtl8723bs/include/wlan_bssdef.h   |  2 +-
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index a194e81688624f..a81e77e5f9444b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1146,11 +1146,11 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	if (pbuf && (wpa_ielen > 0)) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_cipher_info: wpa_ielen: %d", wpa_ielen));
 		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
-			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
-			pnetwork->BcnInfo.group_cipher = group_cipher;
-			pnetwork->BcnInfo.is_8021x = is8021x;
+			pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
+			pnetwork->bcn_info.group_cipher = group_cipher;
+			pnetwork->bcn_info.is_8021x = is8021x;
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d, is_8021x is %d",
-						__func__, pnetwork->BcnInfo.pairwise_cipher, pnetwork->BcnInfo.is_8021x));
+						__func__, pnetwork->bcn_info.pairwise_cipher, pnetwork->bcn_info.is_8021x));
 			ret = _SUCCESS;
 		}
 	} else {
@@ -1160,12 +1160,12 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE\n"));
 			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE  OK!!!\n"));
-				pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
-				pnetwork->BcnInfo.group_cipher = group_cipher;
-				pnetwork->BcnInfo.is_8021x = is8021x;
+				pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
+				pnetwork->bcn_info.group_cipher = group_cipher;
+				pnetwork->bcn_info.is_8021x = is8021x;
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d,"
-							"pnetwork->group_cipher is %d, is_8021x is %d",	__func__, pnetwork->BcnInfo.pairwise_cipher,
-							pnetwork->BcnInfo.group_cipher, pnetwork->BcnInfo.is_8021x));
+							"pnetwork->group_cipher is %d, is_8021x is %d",	__func__, pnetwork->bcn_info.pairwise_cipher,
+							pnetwork->bcn_info.group_cipher, pnetwork->bcn_info.is_8021x));
 				ret = _SUCCESS;
 			}
 		}
@@ -1192,7 +1192,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		bencrypt = 1;
 		pnetwork->network.privacy = 1;
 	} else {
-		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
+		pnetwork->bcn_info.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
 	rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, NULL, &rsn_len, NULL, &wpa_len);
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.ssid.Ssid));
@@ -1201,17 +1201,17 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 	if (rsn_len > 0) {
-		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
+		pnetwork->bcn_info.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
 	} else if (wpa_len > 0) {
-		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA;
+		pnetwork->bcn_info.encryp_protocol = ENCRYP_PROTOCOL_WPA;
 	} else {
 		if (bencrypt)
-			pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WEP;
+			pnetwork->bcn_info.encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-				pnetwork->BcnInfo.encryp_protocol));
+				pnetwork->bcn_info.encryp_protocol));
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-				pnetwork->BcnInfo.encryp_protocol));
+				pnetwork->bcn_info.encryp_protocol));
 	rtw_get_cipher_info(pnetwork);
 
 	/* get bwmode and ch_offset */
@@ -1219,17 +1219,17 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_cap = (struct ieee80211_ht_cap *)(p + 2);
-			pnetwork->BcnInfo.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
+			pnetwork->bcn_info.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
 	} else {
-			pnetwork->BcnInfo.ht_cap_info = 0;
+			pnetwork->bcn_info.ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
 	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_info = (struct HT_info_element *)(p + 2);
-			pnetwork->BcnInfo.ht_info_infos_0 = pht_info->infos[0];
+			pnetwork->bcn_info.ht_info_infos_0 = pht_info->infos[0];
 	} else {
-			pnetwork->BcnInfo.ht_info_infos_0 = 0;
+			pnetwork->bcn_info.ht_info_infos_0 = 0;
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index a14fdef29b7150..24b5a7e7942dff 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1295,17 +1295,17 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	} else {
 			ht_info_infos_0 = 0;
 	}
-	if (ht_cap_info != cur_network->BcnInfo.ht_cap_info ||
-		((ht_info_infos_0&0x03) != (cur_network->BcnInfo.ht_info_infos_0&0x03))) {
+	if (ht_cap_info != cur_network->bcn_info.ht_cap_info ||
+		((ht_info_infos_0&0x03) != (cur_network->bcn_info.ht_info_infos_0&0x03))) {
 			DBG_871X("%s bcn now: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
 							ht_cap_info, ht_info_infos_0);
 			DBG_871X("%s bcn link: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
-							cur_network->BcnInfo.ht_cap_info, cur_network->BcnInfo.ht_info_infos_0);
+							cur_network->bcn_info.ht_cap_info, cur_network->bcn_info.ht_info_infos_0);
 			DBG_871X("%s bw mode change\n", __func__);
 			{
 				/* bcn_info_update */
-				cur_network->BcnInfo.ht_cap_info = ht_cap_info;
-				cur_network->BcnInfo.ht_info_infos_0 = ht_info_infos_0;
+				cur_network->bcn_info.ht_cap_info = ht_cap_info;
+				cur_network->bcn_info.ht_info_infos_0 = ht_info_infos_0;
 				/* to do : need to check that whether modify related register of BB or not */
 			}
 			/* goto _mismatch; */
@@ -1381,7 +1381,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 			encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
 
-	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol) {
+	if (cur_network->bcn_info.encryp_protocol != encryp_protocol) {
 		DBG_871X("%s(): enctyp is not match\n", __func__);
 		goto _mismatch;
 	}
@@ -1407,15 +1407,15 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		}
 
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-				("%s cur_network->group_cipher is %d: %d\n", __func__, cur_network->BcnInfo.group_cipher, group_cipher));
-		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
+				("%s cur_network->group_cipher is %d: %d\n", __func__, cur_network->bcn_info.group_cipher, group_cipher));
+		if (pairwise_cipher != cur_network->bcn_info.pairwise_cipher || group_cipher != cur_network->bcn_info.group_cipher) {
 			DBG_871X("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match\n", __func__,
-					pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
-					group_cipher, cur_network->BcnInfo.group_cipher);
+					pairwise_cipher, cur_network->bcn_info.pairwise_cipher,
+					group_cipher, cur_network->bcn_info.group_cipher);
 			goto _mismatch;
 		}
 
-		if (is_8021x != cur_network->BcnInfo.is_8021x) {
+		if (is_8021x != cur_network->bcn_info.is_8021x) {
 			DBG_871X("%s authentication is not match\n", __func__);
 			goto _mismatch;
 		}
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index 39163773b56027..17668e4669c9fc 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -233,7 +233,7 @@ struct	wlan_network {
 	int	aid;			/* will only be valid when a BSS is joinned. */
 	int	join_res;
 	struct wlan_bssid_ex	network; /* must be the last item */
-	struct wlan_bcn_info	BcnInfo;
+	struct wlan_bcn_info	bcn_info;
 };
 
 enum VRTL_CARRIER_SENSE {
-- 
2.53.0

