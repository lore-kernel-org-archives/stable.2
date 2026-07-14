Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A12424D60
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072055; cv=none; b=HYFrCT/9Jqhm3ffJ7cjmG1gRSQaHwa6E4LAwWs+BOfa4jWJo4cty/dc22vvEsBD0lru9IXPxZObFarGITpAPrBDYvJIj5bnGjquIqgp8/Loaxcrzn1jSJ+F3IeLnCgIVnZ62H0Ena7BUfVpJsjwgf7QOY2b+OJcVNPgXAeGeL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072055; c=relaxed/simple;
	bh=DdmkLiEGP0ur64iuMoF/uEMqaz/5ygfNugus/k+l8Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWdNpUZdCPq7Ko83a2gJ/3fxPWXBJq0KLJjFa+vdbNihdFtIey67VvpZyAE2JGfs1VUeCfLwttwXGdxRvnKclK9XJCKgee6dsTj3iXBOKBzNY4UbupDwMMobAe6rAj4MNwAcPAd4OI2yaLE0cDlXpgYqdPXSm8ktrF80exgGkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3ZMmNNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3ZMmNNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95B71F00AC4;
	Tue, 14 Jul 2026 23:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072054;
	bh=FjyPfno1vVyrlQbyhCbS6OF6N8j7jK4Xg3RmTyIaqkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A3ZMmNNLVrDXourNoOXleCwWBX8tj90mh7k04PgiD1S8j5diAwuCMa6bAm1Ucw6bv
	 A16pWWqJ5UyVRdsE5pvk3z+v1gdeq41njQt8mRrEEujHSBvgUG/6toGatc/nbutjel
	 bGAx1CA1Y7y+D1rReAAPnvAjbIY5J2D/IydgnMGv4rlrSY/o599Ftoub+agddf3PHI
	 E/U5isoxebWy5eTHzHcKYqhrI2wK4ImiJhjH17plN1A4UmRTFpHUA+11p2eMVO7MjA
	 SGw7SYtr36kppzBS6hxs5OgRlcbMIs+nz4fmHyezoOBHPLYCHTyphgootWxl7eBTMs
	 +m42BWYwxMaGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] staging: rtl8723bs: Fix space issues
Date: Tue, 14 Jul 2026 19:34:10 -0400
Message-ID: <20260714233411.3592079-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071336-divorcee-scope-a8b1@gregkh>
References: <2026071336-divorcee-scope-a8b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Franziska Naepelt <franziska.naepelt@googlemail.com>

[ Upstream commit c4b811b9361b0d7ea167a79587f5ec0a13fd8863 ]

Fix the following checkpatch space issues:
- CHECK: spaces preferred around that '*' (ctx:VxV)
- CHECK: spaces preferred around that '+' (ctx:VxV)
- CHECK: spaces preferred around that '-' (ctx:VxV)
- CHECK: spaces preferred around that '|' (ctx:VxV)
- CHECK: No space is necessary after a cast
- WARNING: please, no spaces at the start of a line

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
Link: https://lore.kernel.org/r/20230701102538.5359-1-franziska.naepelt@googlemail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 5a752a616e75 ("staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 84 +++++++++----------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index b7993e25764d51..c20fa87c95bd5b 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -99,14 +99,14 @@ static struct ieee80211_channel rtw_2ghz_channels[] = {
 static void rtw_2g_channels_init(struct ieee80211_channel *channels)
 {
 	memcpy((void *)channels, (void *)rtw_2ghz_channels,
-		sizeof(struct ieee80211_channel)*RTW_2G_CHANNELS_NUM
+		sizeof(struct ieee80211_channel) * RTW_2G_CHANNELS_NUM
 	);
 }
 
 static void rtw_2g_rates_init(struct ieee80211_rate *rates)
 {
 	memcpy(rates, rtw_g_rates,
-		sizeof(struct ieee80211_rate)*RTW_G_RATES_NUM
+		sizeof(struct ieee80211_rate) * RTW_G_RATES_NUM
 	);
 }
 
@@ -133,8 +133,8 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
 	if (!spt_band)
 		goto exit;
 
-	spt_band->channels = (struct ieee80211_channel *)(((u8 *)spt_band)+sizeof(struct ieee80211_supported_band));
-	spt_band->bitrates = (struct ieee80211_rate *)(((u8 *)spt_band->channels)+sizeof(struct ieee80211_channel)*n_channels);
+	spt_band->channels = (struct ieee80211_channel *)(((u8 *)spt_band) + sizeof(struct ieee80211_supported_band));
+	spt_band->bitrates = (struct ieee80211_rate *)(((u8 *)spt_band->channels) + sizeof(struct ieee80211_channel) * n_channels);
 	spt_band->band = band;
 	spt_band->n_channels = n_channels;
 	spt_band->n_bitrates = n_bitrates;
@@ -268,10 +268,10 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		u32 wpsielen = 0;
 		u8 *wpsie = NULL;
 
-		wpsie = rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wpsielen);
+		wpsie = rtw_get_wps_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, pnetwork->network.IELength - _FIXED_IE_LENGTH_, NULL, &wpsielen);
 
 		if (wpsie && wpsielen > 0)
-			psr = rtw_get_wps_attr_content(wpsie,  wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
+			psr = rtw_get_wps_attr_content(wpsie, wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
 
 		if (sr != 0)
 		{
@@ -307,9 +307,9 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	/* We've set wiphy's signal_type as CFG80211_SIGNAL_TYPE_MBM: signal strength in mBm (100*dBm) */
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true &&
 		is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network, 0)) {
-		notify_signal = 100*translate_percentage_to_dbm(padapter->recvpriv.signal_strength);/* dbm */
+		notify_signal = 100 * translate_percentage_to_dbm(padapter->recvpriv.signal_strength);/* dbm */
 	} else {
-		notify_signal = 100*translate_percentage_to_dbm(pnetwork->network.PhyInfo.SignalStrength);/* dbm */
+		notify_signal = 100 * translate_percentage_to_dbm(pnetwork->network.PhyInfo.SignalStrength);/* dbm */
 	}
 
 	buf = kzalloc(MAX_BSSINFO_LEN, GFP_ATOMIC);
@@ -508,22 +508,22 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		roam_info.channel = notify_channel;
 		roam_info.bssid = cur_network->network.MacAddress;
 		roam_info.req_ie =
-			pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2;
+			pmlmepriv->assoc_req + sizeof(struct ieee80211_hdr_3addr) + 2;
 		roam_info.req_ie_len =
-			pmlmepriv->assoc_req_len-sizeof(struct ieee80211_hdr_3addr)-2;
+			pmlmepriv->assoc_req_len - sizeof(struct ieee80211_hdr_3addr) - 2;
 		roam_info.resp_ie =
-			pmlmepriv->assoc_rsp+sizeof(struct ieee80211_hdr_3addr)+6;
+			pmlmepriv->assoc_rsp + sizeof(struct ieee80211_hdr_3addr) + 6;
 		roam_info.resp_ie_len =
-			pmlmepriv->assoc_rsp_len-sizeof(struct ieee80211_hdr_3addr)-6;
+			pmlmepriv->assoc_rsp_len - sizeof(struct ieee80211_hdr_3addr) - 6;
 		cfg80211_roamed(padapter->pnetdev, &roam_info, GFP_ATOMIC);
 	}
 	else
 	{
 		cfg80211_connect_result(padapter->pnetdev, cur_network->network.MacAddress
-			, pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2
-			, pmlmepriv->assoc_req_len-sizeof(struct ieee80211_hdr_3addr)-2
-			, pmlmepriv->assoc_rsp+sizeof(struct ieee80211_hdr_3addr)+6
-			, pmlmepriv->assoc_rsp_len-sizeof(struct ieee80211_hdr_3addr)-6
+			, pmlmepriv->assoc_req + sizeof(struct ieee80211_hdr_3addr) + 2
+			, pmlmepriv->assoc_req_len - sizeof(struct ieee80211_hdr_3addr) - 2
+			, pmlmepriv->assoc_rsp + sizeof(struct ieee80211_hdr_3addr) + 6
+			, pmlmepriv->assoc_rsp_len - sizeof(struct ieee80211_hdr_3addr) - 6
 			, WLAN_STATUS_SUCCESS, GFP_ATOMIC);
 	}
 }
@@ -856,7 +856,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
-	if (param_len < (u32) ((u8 *) param->u.crypt.key - (u8 *) param) + param->u.crypt.key_len)
+	if (param_len < (u32)((u8 *)param->u.crypt.key - (u8 *)param) + param->u.crypt.key_len)
 	{
 		ret =  -EINVAL;
 		goto exit;
@@ -1253,10 +1253,10 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	}
 
 	/* for Ad-Hoc/AP mode */
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)
- || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)
- || check_fwstate(pmlmepriv, WIFI_AP_STATE))
-		&& check_fwstate(pmlmepriv, _FW_LINKED)
+	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
+	     check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
+	     check_fwstate(pmlmepriv, WIFI_AP_STATE)) &&
+	    check_fwstate(pmlmepriv, _FW_LINKED)
 	)
 	{
 		/* TODO: should acquire station info... */
@@ -1520,7 +1520,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 		DBG_871X("%s under WIFI_AP_STATE\n", __func__);
 #endif
 
-		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
+		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS | _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true)
 		{
 			DBG_8192C("%s, fwstate = 0x%x\n", __func__, pmlmepriv->fw_state);
 
@@ -1593,7 +1593,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	}
 
 	/* parsing channels, n_channels */
-	memset(ch, 0, sizeof(struct rtw_ieee80211_channel)*RTW_CHANNEL_SCAN_AMOUNT);
+	memset(ch, 0, sizeof(struct rtw_ieee80211_channel) * RTW_CHANNEL_SCAN_AMOUNT);
 	for (i = 0; i < request->n_channels && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
 		#ifdef DEBUG_CFG80211
 		DBG_871X(FUNC_ADPT_FMT CHAN_FMT"\n", FUNC_ADPT_ARG(padapter), CHAN_ARG(request->channels[i]));
@@ -1611,7 +1611,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 		for (j = request->n_channels - 1; j >= 0; j--)
 			for (i = 0; i < survey_times; i++)
 		{
-			memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
+			memcpy(&ch[j * survey_times + i], &ch[j], sizeof(struct rtw_ieee80211_channel));
 		}
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, ch, survey_times * request->n_channels);
 	} else {
@@ -1791,7 +1791,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 		goto exit;
 	}
 
-	if (ielen > MAX_WPA_IE_LEN+MAX_WPS_IE_LEN+MAX_P2P_IE_LEN) {
+	if (ielen > MAX_WPA_IE_LEN + MAX_WPS_IE_LEN + MAX_P2P_IE_LEN) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -1819,26 +1819,22 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	}
 
 	pwpa = rtw_get_wpa_ie(buf, &wpa_ielen, ielen);
-	if (pwpa && wpa_ielen > 0)
-	{
-		if (rtw_parse_wpa_ie(pwpa, wpa_ielen+2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS)
-		{
+	if (pwpa && wpa_ielen > 0) {
+		if (rtw_parse_wpa_ie(pwpa, wpa_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
-			memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen+2);
+			memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen + 2);
 
 			DBG_8192C("got wpa_ie, wpa_ielen:%u\n", wpa_ielen);
 		}
 	}
 
 	pwpa2 = rtw_get_wpa2_ie(buf, &wpa2_ielen, ielen);
-	if (pwpa2 && wpa2_ielen > 0)
-	{
-		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen+2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS)
-		{
+	if (pwpa2 && wpa2_ielen > 0) {
+		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
-			memcpy(padapter->securitypriv.supplicant_ie, &pwpa2[0], wpa2_ielen+2);
+			memcpy(padapter->securitypriv.supplicant_ie, &pwpa2[0], wpa2_ielen + 2);
 
 			DBG_8192C("got wpa2_ie, wpa2_ielen:%u\n", wpa2_ielen);
 		}
@@ -2305,7 +2301,7 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 
 			memcpy(psecuritypriv->PMKIDList[index].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
 			psecuritypriv->PMKIDList[index].bUsed = true;
-			psecuritypriv->PMKIDIndex = index+1;
+			psecuritypriv->PMKIDIndex = index + 1;
 			blInserted = true;
 			break;
 		}
@@ -2479,8 +2475,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		return _rtw_xmit_entry(skb, padapter->pnetdev);
 
 	}
-	else if ((frame_control & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE))
-		== (IEEE80211_FTYPE_MGMT|IEEE80211_STYPE_ACTION)
+	else if ((frame_control & (IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE))
+		== (IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_ACTION)
 	)
 	{
 		/* only for action frames */
@@ -2618,7 +2614,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	}
 
 	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
-	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
+	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ + 1);
 
 out:
 	if (ret && mon_wdev) {
@@ -2721,14 +2717,14 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 	if (head_len < 24)
 		return -EINVAL;
 
-	pbuf = rtw_zmalloc(head_len+tail_len);
+	pbuf = rtw_zmalloc(head_len + tail_len);
 	if (!pbuf)
 		return -ENOMEM;
 
-	memcpy(pbuf, (void *)head+24, head_len-24);/*  24 =beacon header len. */
-	memcpy(pbuf+head_len-24, (void *)tail, tail_len);
+	memcpy(pbuf, (void *)head + 24, head_len - 24);/*  24 =beacon header len. */
+	memcpy(pbuf + head_len - 24, (void *)tail, tail_len);
 
-	len = head_len+tail_len-24;
+	len = head_len + tail_len - 24;
 
 	/* check wps ie if inclued */
 	if (rtw_get_wps_ie(pbuf+_FIXED_IE_LENGTH_, len-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
@@ -3084,7 +3080,7 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	pwdev_priv = adapter_wdev_data(padapter);
 
 	/* cookie generation */
-	*cookie = (unsigned long) buf;
+	*cookie = (unsigned long)buf;
 
 #ifdef DEBUG_CFG80211
 	DBG_871X(FUNC_ADPT_FMT" len =%zu, ch =%d"
-- 
2.53.0

