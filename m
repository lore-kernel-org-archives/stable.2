Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C32C9D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074934; cv=none; b=P8RftvTpbh06pKQfh5bmH8yeYy+tSsbTHkaQ2qXvuoD4rsdHPy+DDcDEIZL0J+L5Wy5BydDwXekkPQgLW60BMVeDVPSfoRmISogaXk8T9/BWtQFz7D1XW+1u8zDTfAxctYpo9Iv+pPO5pGEkMTjH2jLbMa/eahSMWnGT+CWGiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074934; c=relaxed/simple;
	bh=OCjxHCBPYRPen1kMNCGKpTEynZq2/R6J4Jut530Q5GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA5bCkTYfbiCkWg0gEwdBBzvq/SB9ELwhfNGDzN9KWJxu0PPsZZUMSCnZj7tz+tNYY3jzk+vVwmQrKT4Y6dQz09NGkUM7ql1gQuZQrXd5NGTO3G27LFAxqaBNvNRW+BDB8VxyqYh46YoNev413EyJa9emlA+gMK512Nc2mAHp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+mD8OQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+mD8OQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5EC1F00A3A;
	Wed, 15 Jul 2026 00:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074933;
	bh=dq0xAp7rb4SkzNX93nJN14wssZkepp4fFDxpHJpcCzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+mD8OQaVMUih7gdwY2vBWX8qJv7y1rpNbUDSy2A1QPuG/v1/AlMXux1VYhZ0hIGg
	 2WpfJ0gnnYEM4AqPU7AC/RJwHD1+W5PaayitiuCmQqjjU0H80+qMj4/5+teFK9St+d
	 qfwYl1Wd5cUzd6dBNgGBRqeew5tpdPGgEfKBKS2+1kOpZZt7o064oJ9gCltzy1dTEu
	 eL+q0IF/txbL46Bm9xJwi4jJu+xM7kmMiLz920OovWCuRtiUnqRKYEkzmsVg4FS0aE
	 rQP+/CLEsKthTxBMOeQMEVEaFYiaAqG8HjOeHYPbtUfT4nm26pONIqKM6sMqLHV0d1
	 SaWyg+3cuy81Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolay Kulikov <nikolayof23@gmail.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] staging: rtl8723bs: fix spaces around binary operators
Date: Tue, 14 Jul 2026 20:22:09 -0400
Message-ID: <20260715002210.3789107-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715002210.3789107-1-sashal@kernel.org>
References: <2026071358-harpist-prompter-f7c3@gregkh>
 <20260715002210.3789107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikolay Kulikov <nikolayof23@gmail.com>

[ Upstream commit 0c9d1b56f9af0762a5be5118e1bb962f23784dc4 ]

Add missing spaces and fix line length to comply with kernel coding
style.

Signed-off-by: Nikolay Kulikov <nikolayof23@gmail.com>
Reviewed-by: Ethan Tidmore <ethantidmore06@gmail.com>
Link: https://patch.msgid.link/20260221172751.52329-1-nikolayof23@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 78 ++++++++++---------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index a7f836b915c3ca..674dc5ab3f264e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -455,10 +455,10 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		return _FAIL;
 	}
 
-	if ((*wpa_ie != WLAN_EID_VENDOR_SPECIFIC) || (*(wpa_ie+1) != (u8)(wpa_ie_len - 2)) ||
-	   (memcmp(wpa_ie+2, RTW_WPA_OUI_TYPE, WPA_SELECTOR_LEN))) {
+	if ((*wpa_ie != WLAN_EID_VENDOR_SPECIFIC) ||
+	    (*(wpa_ie + 1) != (u8)(wpa_ie_len - 2)) ||
+	    (memcmp(wpa_ie + 2, RTW_WPA_OUI_TYPE, WPA_SELECTOR_LEN)))
 		return _FAIL;
-	}
 
 	pos = wpa_ie;
 
@@ -518,7 +518,7 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		return _FAIL;
 	}
 
-	if ((*rsn_ie != WLAN_EID_RSN) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2)))
+	if ((*rsn_ie != WLAN_EID_RSN) || (*(rsn_ie + 1) != (u8)(rsn_ie_len - 2)))
 		return _FAIL;
 
 	pos = rsn_ie;
@@ -586,18 +586,18 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
 
-		/* if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY) */
-		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY && (!memcmp(&in_ie[cnt+6], wapi_oui1, 4) ||
-					!memcmp(&in_ie[cnt+6], wapi_oui2, 4))) {
+		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY &&
+		    (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
+		     !memcmp(&in_ie[cnt + 6], wapi_oui2, 4))) {
 			if (wapi_ie)
-				memcpy(wapi_ie, &in_ie[cnt], in_ie[cnt+1]+2);
+				memcpy(wapi_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 
 			if (wapi_len)
-				*wapi_len = in_ie[cnt+1]+2;
+				*wapi_len = in_ie[cnt + 1] + 2;
 
-			cnt += in_ie[cnt+1]+2;  /* get next */
+			cnt += in_ie[cnt + 1] + 2;  /* get next */
 		} else {
-			cnt += in_ie[cnt+1]+2;   /* get next */
+			cnt += in_ie[cnt + 1] + 2;   /* get next */
 		}
 	}
 
@@ -621,9 +621,10 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
 
-		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt+2], &wpa_oui[0], 4))) {
+		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) &&
+		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 			if (wpa_ie)
-				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
+				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 
 			*wpa_len = in_ie[cnt + 1] + 2;
 			cnt += in_ie[cnt + 1] + 2;  /* get next */
@@ -632,10 +633,10 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 				if (rsn_ie)
 					memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 
-				*rsn_len = in_ie[cnt+1]+2;
-				cnt += in_ie[cnt+1]+2;  /* get next */
+				*rsn_len = in_ie[cnt + 1] + 2;
+				cnt += in_ie[cnt + 1] + 2;  /* get next */
 			} else {
-				cnt += in_ie[cnt+1]+2;   /* get next */
+				cnt += in_ie[cnt + 1] + 2;   /* get next */
 			}
 		}
 	}
@@ -667,20 +668,20 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 	while (cnt < in_len) {
 		eid = in_ie[cnt];
 
-		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt+2], wps_oui, 4))) {
+		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			wpsie_ptr = &in_ie[cnt];
 
 			if (wps_ie)
-				memcpy(wps_ie, &in_ie[cnt], in_ie[cnt+1]+2);
+				memcpy(wps_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 
 			if (wps_ielen)
-				*wps_ielen = in_ie[cnt+1]+2;
+				*wps_ielen = in_ie[cnt + 1] + 2;
 
-			cnt += in_ie[cnt+1]+2;
+			cnt += in_ie[cnt + 1] + 2;
 
 			break;
 		}
-		cnt += in_ie[cnt+1]+2; /* goto next */
+		cnt += in_ie[cnt + 1] + 2; /* goto next */
 	}
 
 	return wpsie_ptr;
@@ -758,12 +759,12 @@ u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8
 
 	if (attr_ptr && attr_len) {
 		if (buf_content)
-			memcpy(buf_content, attr_ptr+4, attr_len-4);
+			memcpy(buf_content, attr_ptr + 4, attr_len - 4);
 
 		if (len_content)
-			*len_content = attr_len-4;
+			*len_content = attr_len - 4;
 
-		return attr_ptr+4;
+		return attr_ptr + 4;
 	}
 
 	return NULL;
@@ -1009,20 +1010,25 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	int group_cipher = 0, pairwise_cipher = 0, is8021x = 0;
 	int ret = _FAIL;
 
-	pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
+	pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12],
+			      &wpa_ielen,
+			      pnetwork->network.ie_length - 12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-		if (rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
+		if (rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher,
+				     &pairwise_cipher, &is8021x) == _SUCCESS) {
 			pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
 			pnetwork->bcn_info.group_cipher = group_cipher;
 			pnetwork->bcn_info.is_8021x = is8021x;
 			ret = _SUCCESS;
 		}
 	} else {
-		pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
+		pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen,
+				       pnetwork->network.ie_length - 12);
 
 		if (pbuf && (wpa_ielen > 0)) {
-			if (rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
+			if (rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher,
+					      &pairwise_cipher, &is8021x) == _SUCCESS) {
 				pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
 				pnetwork->bcn_info.group_cipher = group_cipher;
 				pnetwork->bcn_info.is_8021x = is8021x;
@@ -1091,21 +1097,21 @@ u16 rtw_mcs_rate(u8 bw_40MHz, u8 short_GI, unsigned char *MCS_rate)
 	u16 max_rate = 0;
 
 	if (MCS_rate[0] & BIT(7))
-		max_rate = (bw_40MHz) ? ((short_GI)?1500:1350):((short_GI)?722:650);
+		max_rate = (bw_40MHz) ? ((short_GI) ? 1500 : 1350) : ((short_GI) ? 722 : 650);
 	else if (MCS_rate[0] & BIT(6))
-		max_rate = (bw_40MHz) ? ((short_GI)?1350:1215):((short_GI)?650:585);
+		max_rate = (bw_40MHz) ? ((short_GI) ? 1350 : 1215) : ((short_GI) ? 650 : 585);
 	else if (MCS_rate[0] & BIT(5))
-		max_rate = (bw_40MHz) ? ((short_GI)?1200:1080):((short_GI)?578:520);
+		max_rate = (bw_40MHz) ? ((short_GI) ? 1200 : 1080) : ((short_GI) ? 578 : 520);
 	else if (MCS_rate[0] & BIT(4))
-		max_rate = (bw_40MHz) ? ((short_GI)?900:810):((short_GI)?433:390);
+		max_rate = (bw_40MHz) ? ((short_GI) ? 900 : 810) : ((short_GI) ? 433 : 390);
 	else if (MCS_rate[0] & BIT(3))
-		max_rate = (bw_40MHz) ? ((short_GI)?600:540):((short_GI)?289:260);
+		max_rate = (bw_40MHz) ? ((short_GI) ? 600 : 540) : ((short_GI) ? 289 : 260);
 	else if (MCS_rate[0] & BIT(2))
-		max_rate = (bw_40MHz) ? ((short_GI)?450:405):((short_GI)?217:195);
+		max_rate = (bw_40MHz) ? ((short_GI) ? 450 : 405) : ((short_GI) ? 217 : 195);
 	else if (MCS_rate[0] & BIT(1))
-		max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
+		max_rate = (bw_40MHz) ? ((short_GI) ? 300 : 270) : ((short_GI) ? 144 : 130);
 	else if (MCS_rate[0] & BIT(0))
-		max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
+		max_rate = (bw_40MHz) ? ((short_GI) ? 150 : 135) : ((short_GI) ? 72 : 65);
 
 	return max_rate;
 }
-- 
2.53.0

