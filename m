Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59138A702
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083576; cv=none; b=Cz46ZgbovZFplP4XwD3EkrQq/ac53meElTSeThC5NiLbYt6Mo07DOGsvMdnwl/nUfSEuWHHtwMRDBXsFMEeEJMtYW5yv0VrQe6Gyw7ds/yaFx7Rg2qh3CqkMB3S3Kow1S6wQrYzbYUvT4yaz4M+jlT0cWIl7aIlWTTkc68PwFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083576; c=relaxed/simple;
	bh=oClN6mA+IsWTS/beq5598JaEH6AaC5wu75Ziy+JA//Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Betm1vd51V+5ouy8UmqtV6+nA00NwEwa4BMNabIf424sQZKJtAQrOjA/NCcIJcN7NMQxtTOYSI+g7U19QT9Spy6dps/GGH+zhwAvSEqHlXAxfpsMn1vc9gMA41mkTbjKuxVxz3qQNqIl6rWKUABxcw0jppu8UYtlc7gzvTlQVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8e7Fjqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8e7Fjqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E621F00A3F;
	Wed, 15 Jul 2026 02:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083573;
	bh=zBLrSHAsEHDumXAX+mIV5zI+skC3r9TeMYJ7SXNwcPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z8e7FjqfOCnewA3EDYf6/iQLi2ZFctY7Q3gnSkY6+60JtJ02kD5CjDTHUzqGUAZIT
	 nEkIjxiILaa+JMFpVa92FTDBKLghLJidJ5v/YGnOhWlUCFKJbVheKTas/a+d8oFSp1
	 EstnHCzl+lpXp1fE0Ep35dQNXKQMNh2utWXhVYd+9nFsD97Lwq+/F0PL38XjEIiFTV
	 zvs464gUlzoXanAMB7CNqyolL8nKlTzQkc3n6wbLP0ynuOfPzKGh+qX/XwETXiD+zX
	 uh9hKJ//U2IgFcgT7UpMiAXd8NKez2ZOGZ3EsGtyjiBTP7ZPbJpODEsnwAXrX2N9ri
	 w+XUH8j9Exx1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 06/10] staging: rtl8723bs: remove unnecessary bracks on DBG_871X removal sites
Date: Tue, 14 Jul 2026 22:46:02 -0400
Message-ID: <20260715024606.107096-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715024606.107096-1-sashal@kernel.org>
References: <2026071347-leotard-finlike-cc76@gregkh>
 <20260715024606.107096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 709c8e49b51c3702417941ac5f45ae12e4e405ce ]

remove unnecessary bracks on DBG_871X removal sites

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/35f5edf0f39b717b3de3ad7861cbaa5f4ba60576.1617802415.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 3bf39f711ff2 ("staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  9 +-
 drivers/staging/rtl8723bs/core/rtw_btcoex.c   |  6 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 10 +--
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 10 +--
 drivers/staging/rtl8723bs/core/rtw_io.c       |  3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 32 +++-----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 77 ++++++-----------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 57 +++++--------
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 19 ++---
 drivers/staging/rtl8723bs/core/rtw_security.c | 12 +--
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 82 ++++++++-----------
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 49 +++++------
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c  |  4 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       |  6 +-
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 69 ++++++----------
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 12 +--
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  8 +-
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  3 +-
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  9 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  4 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  6 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 17 ++--
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 57 +++++--------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |  4 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 15 ++--
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |  3 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  9 +-
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c | 52 ++++--------
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  6 +-
 29 files changed, 242 insertions(+), 408 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index b5cdf3c9d438e0..d38c9325f63534 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -286,9 +286,8 @@ void expire_timeout_chk(struct adapter *padapter)
 				&& padapter->xmitpriv.free_xmitframe_cnt < ((
 					NR_XMITFRAME / pstapriv->asoc_list_cnt
 				) / 2)
-			) {
+			)
 				wakeup_sta_to_xmit(padapter, psta);
-			}
 		}
 	}
 
@@ -550,15 +549,13 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 
 		/*  B0 Config LDPC Coding Capability */
 		if (TEST_FLAG(phtpriv_ap->ldpc_cap, LDPC_HT_ENABLE_TX) &&
-			GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap))) {
+			      GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap)))
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
-		}
 
 		/*  B7 B8 B9 Config STBC setting */
 		if (TEST_FLAG(phtpriv_ap->stbc_cap, STBC_HT_ENABLE_TX) &&
-			GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap))) {
+			      GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap)))
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
-		}
 	} else {
 		phtpriv_sta->ampdu_enable = false;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
index ebdbd328b62c00..62cbf84b079a4c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
+++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
@@ -21,13 +21,11 @@ void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 mediaStatus)
 
 void rtw_btcoex_HaltNotify(struct adapter *padapter)
 {
-	if (!padapter->bup) {
+	if (!padapter->bup)
 		return;
-	}
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return;
-	}
 
 	hal_btcoex_HaltNotify(padapter);
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 337558b966e023..413dcc28ada06c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -316,9 +316,9 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 
 	if ((pcmdpriv->padapter->hw_init_completed == false && bAllow == false)
 		|| atomic_read(&(pcmdpriv->cmdthd_running)) == false	/* com_thread not running */
-	) {
+	)
 		return _FAIL;
-	}
+
 	return _SUCCESS;
 }
 
@@ -425,9 +425,8 @@ int rtw_cmd_thread(void *context)
 			break;
 		}
 
-		if (list_empty(&(pcmdpriv->cmd_queue.queue))) {
+		if (list_empty(&(pcmdpriv->cmd_queue.queue)))
 			continue;
-		}
 
 		if (rtw_register_cmd_alive(padapter) != _SUCCESS) {
 			RT_TRACE(_module_hal_xmit_c_, _drv_notice_,
@@ -1546,9 +1545,8 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
 
 	mutex_lock(&pwrpriv->lock);
 
-	if (pwrpriv->dtim != dtim) {
+	if (pwrpriv->dtim != dtim)
 		pwrpriv->dtim = dtim;
-	}
 
 	if ((pwrpriv->bFwCurrentInPSMode == true) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
 		u8 ps_mode = pwrpriv->pwr_mode;
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 436a606bdf85bb..4ca1e75d165649 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -869,9 +869,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	/* first 3 bytes in vendor specific information element are the IEEE
 	 * OUI of the vendor. The following byte is used a vendor specific
 	 * sub-type. */
-	if (elen < 4) {
+	if (elen < 4)
 		return -1;
-	}
 
 	oui = get_unaligned_be24(pos);
 	switch (oui) {
@@ -886,9 +885,9 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wpa_ie_len = elen;
 			break;
 		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
-			if (elen < 5) {
+			if (elen < 5)
 				return -1;
-			}
+
 			switch (pos[4]) {
 			case WME_OUI_SUBTYPE_INFORMATION_ELEMENT:
 			case WME_OUI_SUBTYPE_PARAMETER_ELEMENT:
@@ -956,9 +955,8 @@ ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 		elen = *pos++;
 		left -= 2;
 
-		if (elen > left) {
+		if (elen > left)
 			return ParseFailed;
-		}
 
 		switch (id) {
 		case WLAN_EID_SSID:
diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index 25fc52e557d1e0..1208ead0ed52ba 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -172,9 +172,8 @@ int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 {
 	int ret = false;
 	int value = atomic_inc_return(&dvobj->continual_io_error);
-	if (value > MAX_CONTINUAL_IO_ERR) {
+	if (value > MAX_CONTINUAL_IO_ERR)
 		ret = true;
-	}
 
 	return ret;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index f3e8a2b5bdb70a..1db5ecc651ec1f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -724,9 +724,8 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 		}
 	}
 
-	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0)) {
+	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0))
 		bselected = false;
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 		if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
@@ -1082,9 +1081,9 @@ void rtw_scan_abort(struct adapter *adapter)
 		msleep(20);
 	}
 
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		rtw_indicate_scan_done(adapter, true);
-	}
+
 	pmlmeext->scan_abort = false;
 }
 
@@ -1734,13 +1733,11 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 		&& jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
 
 		if (!padapter->registrypriv.wifi_spec) {
-			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true) {
+			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
 				goto exit;
-			}
 
-			if (pmlmepriv->LinkDetectInfo.bBusyTraffic) {
+			if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
 				goto exit;
-			}
 		}
 
 		rtw_set_802_11_bssid_list_scan(padapter, NULL, 0);
@@ -2439,12 +2436,11 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 	rtw_hal_get_def_var(padapter, HAL_DEF_EXPLICIT_BEAMFORMER, (u8 *)&bHwSupportBeamformer);
 	rtw_hal_get_def_var(padapter, HAL_DEF_EXPLICIT_BEAMFORMEE, (u8 *)&bHwSupportBeamformee);
 	CLEAR_FLAGS(phtpriv->beamform_cap);
-	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT4) && bHwSupportBeamformer) {
+	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT4) && bHwSupportBeamformer)
 		SET_FLAG(phtpriv->beamform_cap, BEAMFORMING_HT_BEAMFORMER_ENABLE);
-	}
-	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT5) && bHwSupportBeamformee) {
+
+	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT5) && bHwSupportBeamformee)
 		SET_FLAG(phtpriv->beamform_cap, BEAMFORMING_HT_BEAMFORMEE_ENABLE);
-	}
 }
 
 void rtw_build_wmm_ie_ht(struct adapter *padapter, u8 *out_ie, uint *pout_len)
@@ -2539,9 +2535,8 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 	if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_RX)) {
 		if ((channel <= 14 && pregistrypriv->rx_stbc == 0x1) ||	/* enable for 2.4GHz */
-			(pregistrypriv->wifi_spec == 1)) {
+			(pregistrypriv->wifi_spec == 1))
 			stbc_rx_enable = 1;
-		}
 	}
 
 	/* fill default supported_mcs_set */
@@ -2746,17 +2741,14 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 	priority = pattrib->priority;
 
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
-	if (pattrib->psta != psta) {
+	if (pattrib->psta != psta)
 		return;
-	}
 
-	if (!psta) {
+	if (!psta)
 		return;
-	}
 
-	if (!(psta->state & _FW_LINKED)) {
+	if (!(psta->state & _FW_LINKED))
 		return;
-	}
 
 	phtpriv = &psta->htpriv;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index de4cfdda050364..f412a9e4e2d59f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -400,9 +400,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, RT_CHANNEL_
 
 	memset(channel_set, 0, sizeof(RT_CHANNEL_INFO)*MAX_CHANNEL_NUM);
 
-	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE) {
+	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 		return chanset_size;
-	}
 
 	if (IsSupported24G(padapter->registrypriv.wireless_mode)) {
 		b2_4GBand = true;
@@ -737,10 +736,8 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 _issue_probersp:
 		if ((check_fwstate(pmlmepriv, _FW_LINKED)  &&
-			pmlmepriv->cur_network.join_res) || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
+			pmlmepriv->cur_network.join_res) || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
 			issue_probersp(padapter, get_sa(pframe), is_valid_p2p_probereq);
-		}
-
 	}
 
 	return _SUCCESS;
@@ -777,10 +774,9 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 
 	p = rtw_get_ie(pframe + sizeof(struct ieee80211_hdr_3addr) + _BEACON_IE_OFFSET_, _EXT_SUPPORTEDRATES_IE_, &ielen, precv_frame->u.hdr.len - sizeof(struct ieee80211_hdr_3addr) - _BEACON_IE_OFFSET_);
 	if ((p != NULL) && (ielen > 0)) {
-		if ((*(p + 1 + ielen) == 0x2D) && (*(p + 2 + ielen) != 0x2D)) {
+		if ((*(p + 1 + ielen) == 0x2D) && (*(p + 2 + ielen) != 0x2D))
 			/* Invalid value 0x2D is detected in Extended Supported Rates (ESR) IE. Try to fix the IE length to avoid failed Beacon parsing. */
 			*(p + 1) = ielen - 1;
-		}
 	}
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
@@ -1097,9 +1093,8 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (p == NULL) {
+			if (p == NULL)
 				goto authclnt_fail;
-			}
 
 			memcpy((void *)(pmlmeinfo->chg_txt), (void *)(p + 2), len);
 			pmlmeinfo->auth_seq = 3;
@@ -1170,9 +1165,8 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	}
 
 
-	if (pkt_len < sizeof(struct ieee80211_hdr_3addr) + ie_offset) {
+	if (pkt_len < sizeof(struct ieee80211_hdr_3addr) + ie_offset)
 		return _FAIL;
-	}
 
 	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 	if (!pstat) {
@@ -1954,13 +1948,11 @@ static s32 rtw_action_public_decache(union recv_frame *recv_frame, s32 token)
 	if (GetRetry(frame)) {
 		if (token >= 0) {
 			if ((seq_ctrl == mlmeext->action_public_rxseq)
-				&& (token == mlmeext->action_public_dialog_token)) {
+				&& (token == mlmeext->action_public_dialog_token))
 				return _FAIL;
-			}
 		} else {
-			if (seq_ctrl == mlmeext->action_public_rxseq) {
+			if (seq_ctrl == mlmeext->action_public_rxseq)
 				return _FAIL;
-			}
 		}
 	}
 
@@ -2152,9 +2144,8 @@ static struct xmit_frame *_alloc_mgtxmitframe(struct xmit_priv *pxmitpriv, bool
 	else
 		pmgntframe = rtw_alloc_xmitframe_ext(pxmitpriv);
 
-	if (pmgntframe == NULL) {
+	if (pmgntframe == NULL)
 		goto exit;
-	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
 	if (pxmitbuf == NULL) {
@@ -2363,9 +2354,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	/* DBG_871X("%s\n", __func__); */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
+	if (!pmgntframe)
 		return;
-	}
 
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
 
@@ -2486,9 +2476,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
 
-	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
+	if ((pattrib->pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
@@ -2523,10 +2512,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		return;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (pmgntframe == NULL)
 		return;
-	}
-
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -3207,15 +3194,13 @@ void issue_assocreq(struct adapter *padapter)
 		for (j = 0; j < sta_bssrate_len; j++) {
 			 /*  Avoid the proprietary data rate (22Mbps) of Handlink WSG-4000 AP */
 			if ((pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK)
-					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK)) {
+					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK))
 				break;
-			}
 		}
 
-		if (j != sta_bssrate_len) {
+		if (j != sta_bssrate_len)
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
-		}
 	}
 
 	bssrate_len = index;
@@ -3668,9 +3653,8 @@ void issue_action_SA_Query(struct adapter *padapter, unsigned char *raddr, unsig
 	DBG_871X("%s\n", __func__);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (pmgntframe == NULL)
 		return;
-	}
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -4085,11 +4069,10 @@ unsigned int send_beacon(struct adapter *padapter)
 	}
 
 
-	if (false == bxmitok) {
+	if (false == bxmitok)
 		return _FAIL;
-	} else {
+	else
 		return _SUCCESS;
-	}
 }
 
 /****************************************************************************
@@ -4242,9 +4225,8 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
-	if (len > MAX_IE_SZ) {
+	if (len > MAX_IE_SZ)
 		return _FAIL;
-	}
 
 	memset(bssid, 0, sizeof(struct wlan_bssid_ex));
 
@@ -4280,14 +4262,13 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
-	if (p == NULL) {
+	if (p == NULL)
 		return _FAIL;
-	}
 
 	if (*(p + 1)) {
-		if (len > NDIS_802_11_LENGTH_SSID) {
+		if (len > NDIS_802_11_LENGTH_SSID)
 			return _FAIL;
-		}
+
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
 		bssid->Ssid.SsidLength = *(p + 1);
 	} else
@@ -4299,18 +4280,18 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	i = 0;
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p != NULL) {
-		if (len > NDIS_802_11_LENGTH_RATES_EX) {
+		if (len > NDIS_802_11_LENGTH_RATES_EX)
 			return _FAIL;
-		}
+
 		memcpy(bssid->SupportedRates, (p + 2), len);
 		i = len;
 	}
 
 	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p != NULL) {
-		if (len > (NDIS_802_11_LENGTH_RATES_EX-i)) {
+		if (len > (NDIS_802_11_LENGTH_RATES_EX-i))
 			return _FAIL;
-		}
+
 		memcpy(bssid->SupportedRates + i, (p + 2), len);
 	}
 
@@ -5460,9 +5441,8 @@ void linked_status_chk(struct adapter *padapter)
 					}
 				}
 
-				if (tx_chk != _SUCCESS && pmlmeinfo->link_count++ == link_count_limit) {
+				if (tx_chk != _SUCCESS && pmlmeinfo->link_count++ == link_count_limit)
 					tx_chk = issue_nulldata_in_interrupt(padapter, NULL);
-				}
 			}
 
 			if (rx_chk == _FAIL) {
@@ -5536,9 +5516,7 @@ void survey_timer_hdl(struct timer_list *t)
 		}
 
 		if (pmlmeext->scan_abort) {
-			{
-				pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
-			}
+			pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
 
 			pmlmeext->scan_abort = false;/* reset */
 		}
@@ -6458,9 +6436,8 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	if (send_beacon(padapter) == _FAIL) {
+	if (send_beacon(padapter) == _FAIL)
 		return H2C_PARAMETERS_ERROR;
-	}
 
 	/* tx bc/mc frames after update TIM */
 	chk_bmc_sleepq_hdl(padapter, NULL);
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 9094a2dfdb51c5..b5d6ce5147aff0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -97,13 +97,11 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 
 	bool ret = false;
 
-	if (adapter_to_pwrctl(adapter)->bpower_saving) {
+	if (adapter_to_pwrctl(adapter)->bpower_saving)
 		goto exit;
-	}
 
-	if (time_before(jiffies, adapter_to_pwrctl(adapter)->ips_deny_time)) {
+	if (time_before(jiffies, adapter_to_pwrctl(adapter)->ips_deny_time))
 		goto exit;
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE|WIFI_SITE_MONITOR)
 		|| check_fwstate(pmlmepriv, WIFI_UNDER_LINKING|WIFI_UNDER_WPS)
@@ -153,9 +151,8 @@ void rtw_ps_processor(struct adapter *padapter)
 	mutex_lock(&adapter_to_pwrctl(padapter)->lock);
 	ps_deny = rtw_ps_deny_get(padapter);
 	mutex_unlock(&adapter_to_pwrctl(padapter)->lock);
-	if (ps_deny != 0) {
+	if (ps_deny != 0)
 		goto exit;
-	}
 
 	if (pwrpriv->bInSuspend) {/* system suspend or autosuspend */
 		pdbgpriv->dbg_ps_insuspend_cnt++;
@@ -222,9 +219,8 @@ void traffic_check_for_leave_lps(struct adapter *padapter, u8 tx, u32 tx_packets
 		if (pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod > 4/*2*/) {
 			if (adapter_to_pwrctl(padapter)->bLeisurePs
 			    && (adapter_to_pwrctl(padapter)->pwr_mode != PS_MODE_ACTIVE)
-			    && !(hal_btcoex_IsBtControlLps(padapter))) {
+			    && !(hal_btcoex_IsBtControlLps(padapter)))
 				bLeaveLPS = true;
-			}
 		}
 	}
 
@@ -360,9 +356,8 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 	)
 		return false;
 
-	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) && !(padapter->securitypriv.binstallGrpkey)) {
+	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) && !(padapter->securitypriv.binstallGrpkey))
 		return false;
-	}
 
 	if (!rtw_cfg80211_pwr_mgmt(padapter))
 		return false;
@@ -574,15 +569,13 @@ void LeaveAllPowerSaveModeDirect(struct adapter *Adapter)
 
 	DBG_871X("%s.....\n", __func__);
 
-	if (Adapter->bSurpriseRemoved) {
+	if (Adapter->bSurpriseRemoved)
 		return;
-	}
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) { /* connect */
 
-		if (pwrpriv->pwr_mode == PS_MODE_ACTIVE) {
+		if (pwrpriv->pwr_mode == PS_MODE_ACTIVE)
 			return;
-		}
 
 		mutex_lock(&pwrpriv->lock);
 
@@ -607,13 +600,11 @@ void LeaveAllPowerSaveMode(struct adapter *Adapter)
 	u8 enqueue = 0;
 	int n_assoc_iface = 0;
 
-	if (!Adapter->bup) {
+	if (!Adapter->bup)
 		return;
-	}
 
-	if (Adapter->bSurpriseRemoved) {
+	if (Adapter->bSurpriseRemoved)
 		return;
-	}
 
 	if (check_fwstate(&(dvobj->padapters->mlmepriv), WIFI_ASOC_STATE))
 		n_assoc_iface++;
@@ -658,9 +649,9 @@ void LPS_Leave_check(
 		if (bReady)
 			break;
 
-		if (jiffies_to_msecs(jiffies - start_time) > 100) {
+		if (jiffies_to_msecs(jiffies - start_time) > 100)
 			break;
-		}
+
 		msleep(1);
 	}
 }
@@ -682,9 +673,8 @@ void cpwm_int_hdl(
 
 	mutex_lock(&pwrpriv->lock);
 
-	if (pwrpriv->rpwm < PS_STATE_S2) {
+	if (pwrpriv->rpwm < PS_STATE_S2)
 		goto exit;
-	}
 
 	pwrpriv->cpwm = PS_STATE(preportpwrstate->state);
 	pwrpriv->cpwm_tog = preportpwrstate->state & PS_TOGGLE;
@@ -729,9 +719,9 @@ static void rpwmtimeout_workitem_callback(struct work_struct *work)
 	padapter = dvobj->if1;
 
 	mutex_lock(&pwrpriv->lock);
-	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
+	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2))
 		goto exit;
-	}
+
 	mutex_unlock(&pwrpriv->lock);
 
 	if (rtw_read8(padapter, 0x100) != 0xEA) {
@@ -745,9 +735,9 @@ static void rpwmtimeout_workitem_callback(struct work_struct *work)
 
 	mutex_lock(&pwrpriv->lock);
 
-	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
+	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2))
 		goto exit;
-	}
+
 	pwrpriv->brpwmtimeout = true;
 	rtw_set_rpwm(padapter, pwrpriv->rpwm);
 	pwrpriv->brpwmtimeout = false;
@@ -763,9 +753,8 @@ static void pwr_rpwm_timeout_handler(struct timer_list *t)
 {
 	struct pwrctrl_priv *pwrpriv = from_timer(pwrpriv, t, pwr_rpwm_timer);
 
-	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
+	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2))
 		return;
-	}
 
 	_set_workitem(&pwrpriv->rpwmtimeoutwi);
 }
@@ -1167,18 +1156,14 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		pwrpriv->ips_deny_time = deny_time;
 
 
-	if (pwrpriv->ps_processing) {
+	if (pwrpriv->ps_processing)
 		while (pwrpriv->ps_processing && jiffies_to_msecs(jiffies - start) <= 3000)
 			mdelay(10);
-	}
 
-	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend) {
-		while (pwrpriv->bInSuspend
-			&& jiffies_to_msecs(jiffies - start) <= 3000
-		) {
+	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend)
+		while (pwrpriv->bInSuspend && jiffies_to_msecs(jiffies - start) <= 3000
+		)
 			mdelay(10);
-		}
-	}
 
 	/* System suspend is not allowed to wakeup */
 	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 4a5ed27f2be32c..502a26ddeb199b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -874,9 +874,8 @@ sint ap2sta_data_frame(
 				(" ap2sta_data_frame:  compare BSSID fail ; BSSID ="MAC_FMT"\n", MAC_ARG(pattrib->bssid)));
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid ="MAC_FMT"\n", MAC_ARG(mybssid)));
 
-			if (!bmcast) {
+			if (!bmcast)
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
-			}
 
 			ret = _FAIL;
 			goto exit;
@@ -1806,14 +1805,12 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 		/* Offset 12 denote 2 mac address */
 		nSubframe_Length = get_unaligned_be16(pdata + 12);
 
-		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
+		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length))
 			break;
-		}
 
 		sub_pkt = rtw_os_alloc_msdu_pkt(prframe, nSubframe_Length, pdata);
-		if (!sub_pkt) {
+		if (!sub_pkt)
 			break;
-		}
 
 		/* move the data point to data content */
 		pdata += ETH_HLEN;
@@ -1821,9 +1818,8 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 
 		subframes[nr_subframes++] = sub_pkt;
 
-		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
+		if (nr_subframes >= MAX_SUBFRAME_COUNT)
 			break;
-		}
 
 		pdata += nSubframe_Length;
 		a_len -= nSubframe_Length;
@@ -1833,9 +1829,9 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 				padding_len = 0;
 			}
 
-			if (a_len < padding_len) {
+			if (a_len < padding_len)
 				break;
-			}
+
 			pdata += padding_len;
 			a_len -= padding_len;
 		}
@@ -2024,9 +2020,8 @@ int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctr
 			plist = get_next(plist);
 			list_del_init(&(prframe->u.hdr.list));
 
-			if (SN_EQUAL(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
+			if (SN_EQUAL(preorder_ctrl->indicate_seq, pattrib->seq_num))
 				preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
-			}
 
 			/* Set this as a lock to make sure that only one thread is indicating packet. */
 			/* pTS->RxIndicateState = RXTS_INDICATE_PROCESSING; */
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 5b15c60d665f3e..c67a4728d428bd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1887,9 +1887,9 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 	ori_len = pattrib->pkt_len-WLAN_HDR_A3_LEN+BIP_AAD_SIZE;
 	BIP_AAD = rtw_zmalloc(ori_len);
 
-	if (BIP_AAD == NULL) {
+	if (BIP_AAD == NULL)
 		return _FAIL;
-	}
+
 	/* PKT start */
 	pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
 	/* mapping to wlan header */
@@ -1906,15 +1906,15 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 		memcpy(&le_tmp64, p+4, 6);
 		temp_ipn = le64_to_cpu(le_tmp64);
 		/* BIP packet number should bigger than previous BIP packet */
-		if (temp_ipn <= pmlmeext->mgnt_80211w_IPN_rx) {
+		if (temp_ipn <= pmlmeext->mgnt_80211w_IPN_rx)
 			goto BIP_exit;
-		}
+
 		/* copy key index */
 		memcpy(&le_tmp, p+2, 2);
 		keyid = le16_to_cpu(le_tmp);
-		if (keyid != padapter->securitypriv.dot11wBIPKeyid) {
+		if (keyid != padapter->securitypriv.dot11wBIPKeyid)
 			goto BIP_exit;
-		}
+
 		/* clear the MIC field of MME to zero */
 		memset(p+2+len-8, 0, 8);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index eeeb7044846890..e93bf08225d2cf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -901,9 +901,8 @@ void WMMOnAssocRsp(struct adapter *padapter)
 			}
 		}
 
-		for (i = 0; i < 4; i++) {
+		for (i = 0; i < 4; i++)
 			pxmitpriv->wmm_para_seq[i] = inx[i];
-		}
 	}
 }
 
@@ -1064,21 +1063,21 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		/*  Config STBC setting */
-		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_TX_STBC(pIE->data)) {
+		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_TX_STBC(pIE->data))
 			SET_FLAG(cur_stbc_cap, STBC_HT_ENABLE_TX);
-		}
+
 		phtpriv->stbc_cap = cur_stbc_cap;
 	} else {
 		/*  Config LDPC Coding Capability */
-		if (TEST_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_LDPC_CAP(pIE->data)) {
+		if (TEST_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_LDPC_CAP(pIE->data))
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
-		}
+
 		phtpriv->ldpc_cap = cur_ldpc_cap;
 
 		/*  Config STBC setting */
-		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data)) {
+		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data))
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
-		}
+
 		phtpriv->stbc_cap = cur_stbc_cap;
 	}
 }
@@ -1228,18 +1227,15 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
-	if (len > MAX_IE_SZ) {
+	if (len > MAX_IE_SZ)
 		return _FAIL;
-	}
 
-	if (memcmp(cur_network->network.MacAddress, pbssid, 6)) {
+	if (memcmp(cur_network->network.MacAddress, pbssid, 6))
 		return true;
-	}
 
 	bssid = rtw_zmalloc(sizeof(struct wlan_bssid_ex));
-	if (!bssid) {
+	if (!bssid)
 		return true;
-	}
 
 	if ((pmlmepriv->timeBcnInfoChkStart != 0) && (jiffies_to_msecs(jiffies - pmlmepriv->timeBcnInfoChkStart) > DISCONNECT_BY_CHK_BCN_FAIL_OBSERV_PERIOD_IN_MS)) {
 		pmlmepriv->timeBcnInfoChkStart = 0;
@@ -1290,16 +1286,15 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	if (p) {
 			bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
-			rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
-			if (pht_info) {
-					bcn_channel = pht_info->primary_channel;
-			} else { /* we don't find channel IE, so don't check it */
-					bcn_channel = Adapter->mlmeextpriv.cur_channel;
-			}
+		rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+		if (pht_info)
+			bcn_channel = pht_info->primary_channel;
+		else /* we don't find channel IE, so don't check it */
+			bcn_channel = Adapter->mlmeextpriv.cur_channel;
 	}
-	if (bcn_channel != Adapter->mlmeextpriv.cur_channel) {
+
+	if (bcn_channel != Adapter->mlmeextpriv.cur_channel)
 			goto _mismatch;
-	}
 
 	/* checking SSID */
 	ssid_len = 0;
@@ -1318,11 +1313,9 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 				cur_network->network.Ssid.SsidLength));
 
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
-			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
-		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
+			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength)
+		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) /* not hidden ssid */
 			goto _mismatch;
-		}
-	}
 
 	/* check encryption info */
 	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
@@ -1335,24 +1328,21 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
 			("%s(): cur_network->network.Privacy is %d, bssid.Privacy is %d\n",
 			 __func__, cur_network->network.Privacy, bssid->Privacy));
-	if (cur_network->network.Privacy != bssid->Privacy) {
+	if (cur_network->network.Privacy != bssid->Privacy)
 		goto _mismatch;
-	}
 
 	rtw_get_sec_ie(bssid->IEs, bssid->IELength, NULL, &rsn_len, NULL, &wpa_len);
 
-	if (rsn_len > 0) {
+	if (rsn_len > 0)
 		encryp_protocol = ENCRYP_PROTOCOL_WPA2;
-	} else if (wpa_len > 0) {
+	else if (wpa_len > 0)
 		encryp_protocol = ENCRYP_PROTOCOL_WPA;
-	} else {
+	else
 		if (bssid->Privacy)
 			encryp_protocol = ENCRYP_PROTOCOL_WEP;
-	}
 
-	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol) {
+	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol)
 		goto _mismatch;
-	}
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
 		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
@@ -1376,13 +1366,11 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
 				("%s cur_network->group_cipher is %d: %d\n", __func__, cur_network->BcnInfo.group_cipher, group_cipher));
-		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
+		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher)
 			goto _mismatch;
-		}
 
-		if (is_8021x != cur_network->BcnInfo.is_8021x) {
+		if (is_8021x != cur_network->BcnInfo.is_8021x)
 			goto _mismatch;
-		}
 	}
 
 	kfree(bssid);
@@ -1559,12 +1547,11 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 						Vender = HT_IOT_PEER_REALTEK_SOFTAP;
 
 					if (pIE->data[4] == 2) {
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT) {
+						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)
 							Vender = HT_IOT_PEER_REALTEK_JAGUAR_BCUTAP;
-						}
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT) {
+
+						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)
 							Vender = HT_IOT_PEER_REALTEK_JAGUAR_CCUTAP;
-						}
 					}
 				}
 
@@ -1847,13 +1834,11 @@ void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 			ratio_20_delay += pmlmeext->bcn_delay_ratio[i];
 			ratio_80_delay += pmlmeext->bcn_delay_ratio[i];
 
-			if (ratio_20_delay > 20 && DrvBcnEarly == 0xff) {
+			if (ratio_20_delay > 20 && DrvBcnEarly == 0xff)
 				DrvBcnEarly = i;
-			}
 
-			if (ratio_80_delay > 80 && DrvBcnTimeOut == 0xff) {
+			if (ratio_80_delay > 80 && DrvBcnTimeOut == 0xff)
 				DrvBcnTimeOut = i;
-			}
 
 			/* reset adaptive_early_32k cnt */
 			pmlmeext->bcn_delay_cnt[i] = 0;
@@ -1890,11 +1875,10 @@ void rtw_alloc_macid(struct adapter *padapter, struct sta_info *psta)
 	}
 	spin_unlock_bh(&pdvobj->lock);
 
-	if (i > (NUM_STA-1)) {
+	if (i > (NUM_STA-1))
 		psta->mac_id = NUM_STA;
-	} else {
+	else
 		psta->mac_id = i;
-	}
 }
 
 void rtw_release_macid(struct adapter *padapter, struct sta_info *psta)
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 08fbd46552a6eb..68a431b1f2b6da 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -994,17 +994,14 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 		{
 			struct sta_info *psta;
 			psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
-			if (pattrib->psta != psta) {
+			if (pattrib->psta != psta)
 				return _FAIL;
-			}
 
-			if (!psta) {
+			if (!psta)
 				return _FAIL;
-			}
 
-			if (!(psta->state & _FW_LINKED)) {
+			if (!(psta->state & _FW_LINKED))
 				return _FAIL;
-			}
 
 			if (psta) {
 				psta->sta_xmitpriv.txseq_tid[pattrib->priority]++;
@@ -1247,9 +1244,9 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 		goto xmitframe_coalesce_success;
 
 	/* IGTK key is not install, it may not support 802.11w */
-	if (padapter->securitypriv.binstallBIPkey != true) {
+	if (padapter->securitypriv.binstallBIPkey != true)
 		goto xmitframe_coalesce_success;
-	}
+
 	/* station mode doesn't need TX BIP, just ready the code */
 	if (bmcst) {
 		int frame_body_len;
@@ -1303,13 +1300,11 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 			else
 				psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 
-			if (!psta) {
+			if (!psta)
 				goto xmitframe_coalesce_fail;
-			}
 
-			if (!(psta->state & _FW_LINKED) || !pxmitframe->buf_addr) {
+			if (!(psta->state & _FW_LINKED) || !pxmitframe->buf_addr)
 				goto xmitframe_coalesce_fail;
-			}
 
 			/* according 802.11-2012 standard, these five types are not robust types */
 			if (subtype == WIFI_ACTION &&
@@ -1485,9 +1480,8 @@ static struct xmit_buf *__rtw_alloc_cmd_xmitbuf(struct xmit_priv *pxmitpriv,
 		pxmitbuf->agg_num = 0;
 		pxmitbuf->pg_num = 0;
 
-		if (pxmitbuf->sctx) {
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 
 	return pxmitbuf;
@@ -1500,9 +1494,8 @@ struct xmit_frame *__rtw_alloc_cmdxmitframe(struct xmit_priv *pxmitpriv,
 	struct xmit_buf		*pxmitbuf;
 
 	pcmdframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (!pcmdframe) {
+	if (!pcmdframe)
 		return NULL;
-	}
 
 	pxmitbuf = __rtw_alloc_cmd_xmitbuf(pxmitpriv, buf_type);
 	if (!pxmitbuf) {
@@ -1551,9 +1544,8 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		pxmitbuf->pdata = pxmitbuf->ptail = pxmitbuf->phead;
 		pxmitbuf->agg_num = 1;
 
-		if (pxmitbuf->sctx) {
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 
 	spin_unlock_irqrestore(&pfree_queue->lock, irqL);
@@ -1612,9 +1604,8 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		pxmitbuf->agg_num = 0;
 		pxmitbuf->pg_num = 0;
 
-		if (pxmitbuf->sctx) {
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
@@ -1630,9 +1621,8 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 	if (!pxmitbuf)
 		return _FAIL;
 
-	if (pxmitbuf->sctx) {
+	if (pxmitbuf->sctx)
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_FREE);
-	}
 
 	if (pxmitbuf->buf_tag == XMITBUF_CMD) {
 	} else if (pxmitbuf->buf_tag == XMITBUF_MGNT) {
@@ -2116,12 +2106,12 @@ inline bool xmitframe_hiq_filter(struct xmit_frame *xmitframe)
 	if (registry->hiq_filter == RTW_HIQ_FILTER_ALLOW_SPECIAL) {
 		struct pkt_attrib *attrib = &xmitframe->attrib;
 
-		if (attrib->ether_type == 0x0806
-			|| attrib->ether_type == 0x888e
-			|| attrib->dhcp_pkt
-		) {
+		if (attrib->ether_type == 0x0806 ||
+		    attrib->ether_type == 0x888e ||
+		    attrib->dhcp_pkt
+		)
 			allow = true;
-		}
+
 	} else if (registry->hiq_filter == RTW_HIQ_FILTER_ALLOW_ALL)
 		allow = true;
 	else if (registry->hiq_filter == RTW_HIQ_FILTER_DENY_ALL) {
@@ -2673,12 +2663,11 @@ int rtw_sctx_wait(struct submit_ctx *sctx, const char *msg)
 	int status = 0;
 
 	expire = sctx->timeout_ms ? msecs_to_jiffies(sctx->timeout_ms) : MAX_SCHEDULE_TIMEOUT;
-	if (!wait_for_completion_timeout(&sctx->done, expire)) {
+	if (!wait_for_completion_timeout(&sctx->done, expire))
 		/* timeout, do something?? */
 		status = RTW_SCTX_DONE_TIMEOUT;
-	} else {
+	else
 		status = sctx->status;
-	}
 
 	if (status == RTW_SCTX_DONE_SUCCESS)
 		ret = _SUCCESS;
diff --git a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
index 50bcddcc8e69db..329e84d400d76e 100644
--- a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
@@ -147,9 +147,9 @@ u8 HalPwrSeqCmdParsing(
 					else
 						udelay(10);
 
-					if (pollingCount++ > maxPollingCnt) {
+					if (pollingCount++ > maxPollingCnt)
 						return false;
-					}
+
 				} while (!bPollingBit);
 
 				break;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 498d8d4d042bf7..b7b102d41988f2 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -151,9 +151,8 @@ bool HAL_IsLegalChannel(struct adapter *Adapter, u32 Channel)
 	bool bLegalChannel = true;
 
 	if ((Channel <= 14) && (Channel >= 1)) {
-		if (IsSupported24G(Adapter->registrypriv.wireless_mode) == false) {
+		if (IsSupported24G(Adapter->registrypriv.wireless_mode) == false)
 			bLegalChannel = false;
-		}
 	} else {
 		bLegalChannel = false;
 	}
@@ -1375,9 +1374,8 @@ bool GetHexValueFromString(char *szStr, u32 *pu4bVal, u32 *pu4bMove)
 	char *szScan = szStr;
 
 	/*  Check input parameter. */
-	if (!szStr || !pu4bVal || !pu4bMove) {
+	if (!szStr || !pu4bVal || !pu4bMove)
 		return false;
-	}
 
 	/*  Initialize output. */
 	*pu4bMove = 0;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index fd7099bab6ece7..b9a6dee46bbf58 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -17,9 +17,8 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 	u8	value = 0;
 
-	if (RfPath > ODM_RF_PATH_D) {
+	if (RfPath > ODM_RF_PATH_D)
 		return 0;
-	}
 
 	if (Band == BAND_ON_2_4G) {
 		switch (RateSection) {
@@ -105,9 +104,8 @@ phy_SetTxPowerByRateBase(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 
-	if (RfPath > ODM_RF_PATH_D) {
+	if (RfPath > ODM_RF_PATH_D)
 		return;
-	}
 
 	if (Band == BAND_ON_2_4G) {
 		switch (RateSection) {
@@ -707,17 +705,14 @@ static void PHY_StoreTxPowerByRateNew(
 
 	PHY_GetRateValuesOfTxPowerByRate(padapter, RegAddr, BitMask, Data, rateIndex, PwrByRateVal, &rateNum);
 
-	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G) {
+	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G)
 		return;
-	}
 
-	if (RfPath > ODM_RF_PATH_D) {
+	if (RfPath > ODM_RF_PATH_D)
 		return;
-	}
 
-	if (TxNum > ODM_RF_PATH_D) {
+	if (TxNum > ODM_RF_PATH_D)
 		return;
-	}
 
 	for (i = 0; i < rateNum; ++i) {
 		if (rateIndex[i] == PHY_GetRateIndexOfTxPowerByRate(MGN_VHT2SS_MCS0) ||
@@ -1008,9 +1003,8 @@ u8 PHY_GetTxPowerIndexBase(
 	u8 txPower = 0;
 	u8 chnlIdx = (Channel-1);
 
-	if (HAL_IsLegalChannel(padapter, Channel) == false) {
+	if (HAL_IsLegalChannel(padapter, Channel) == false)
 		chnlIdx = 0;
-	}
 
 	*bIn24G = phy_GetChnlIndex(Channel, &chnlIdx);
 
@@ -1021,9 +1015,9 @@ u8 PHY_GetTxPowerIndexBase(
 			txPower = pHalData->Index24G_BW40_Base[RFPath][chnlIdx];
 
 		/*  OFDM-1T */
-		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
+		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate))
 			txPower += pHalData->OFDM_24G_Diff[RFPath][TX_1S];
-		}
+
 		if (BandWidth == CHANNEL_WIDTH_20) { /*  BW20-1S, BW20-2S */
 			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW20_24G_Diff[RFPath][TX_1S];
@@ -1062,9 +1056,8 @@ u8 PHY_GetTxPowerIndexBase(
 			txPower = pHalData->Index5G_BW40_Base[RFPath][chnlIdx];
 
 		/*  OFDM-1T */
-		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
+		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate))
 			txPower += pHalData->OFDM_5G_Diff[RFPath][TX_1S];
-		}
 
 		/*  BW20-1S, BW20-2S */
 		if (BandWidth == CHANNEL_WIDTH_20) {
@@ -1119,13 +1112,11 @@ s8 PHY_GetTxPowerTrackingOffset(struct adapter *padapter, u8 RFPath, u8 Rate)
 	if (pDM_Odm->RFCalibrateInfo.TxPowerTrackControl  == false)
 		return offset;
 
-	if ((Rate == MGN_1M) || (Rate == MGN_2M) || (Rate == MGN_5_5M) || (Rate == MGN_11M)) {
+	if ((Rate == MGN_1M) || (Rate == MGN_2M) || (Rate == MGN_5_5M) || (Rate == MGN_11M))
 		offset = pDM_Odm->Remnant_CCKSwingIdx;
-	} else {
+	else
 		offset = pDM_Odm->Remnant_OFDMSwingIdx[RFPath];
 
-	}
-
 	return offset;
 }
 
@@ -1403,18 +1394,17 @@ s8 PHY_GetTxPowerByRate(
 		   padapter->registrypriv.RegEnableTxPowerByRate == 0)
 		return 0;
 
-	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G) {
+	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G)
 		return value;
-	}
-	if (RFPath > ODM_RF_PATH_D) {
+
+	if (RFPath > ODM_RF_PATH_D)
 		return value;
-	}
-	if (TxNum >= RF_MAX_TX_NUM) {
+
+	if (TxNum >= RF_MAX_TX_NUM)
 		return value;
-	}
-	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE) {
+
+	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE)
 		return value;
-	}
 
 	return pHalData->TxPwrByRateOffset[Band][RFPath][TxNum][rateIndex];
 
@@ -1432,18 +1422,17 @@ void PHY_SetTxPowerByRate(
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	u8 rateIndex = PHY_GetRateIndexOfTxPowerByRate(Rate);
 
-	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G) {
+	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G)
 		return;
-	}
-	if (RFPath > ODM_RF_PATH_D) {
+
+	if (RFPath > ODM_RF_PATH_D)
 		return;
-	}
-	if (TxNum >= RF_MAX_TX_NUM) {
+
+	if (TxNum >= RF_MAX_TX_NUM)
 		return;
-	}
-	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE) {
+
+	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE)
 		return;
-	}
 
 	pHalData->TxPwrByRateOffset[Band][RFPath][TxNum][rateIndex] = Value;
 }
@@ -1640,10 +1629,8 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 		channel = phy_GetChannelIndexOfTxPowerLimit(band_type, channel);
 
 	if (idx_band == -1 || idx_regulation == -1 || idx_bandwidth == -1 ||
-	    idx_rate_sctn == -1 || idx_channel == -1) {
-
+	    idx_rate_sctn == -1 || idx_channel == -1)
 		return MAX_POWER_INDEX;
-	}
 
 	if (band_type == BAND_ON_2_4G) {
 		s8 limits[10] = {0}; u8 i = 0;
@@ -1872,10 +1859,8 @@ void PHY_SetTxPowerLimit(
 		rateSection = 8;
 	else if (eqNByte(RateSection, (u8 *)("VHT"), 3) && eqNByte(RfPath, (u8 *)("4T"), 2))
 		rateSection = 9;
-	else {
+	else
 		return;
-	}
-
 
 	if (eqNByte(Bandwidth, (u8 *)("20M"), 3))
 		bandwidth = 0;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index c0b194c1aed610..14fbf5c7a3223f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -201,9 +201,8 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 
 _ConstructBeacon:
 
-	if ((pktlen + TXDESC_SIZE) > 512) {
+	if ((pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	*pLength = pktlen;
 
@@ -1062,13 +1061,11 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 				ratio_20_delay += pmlmeext->bcn_delay_ratio[i];
 				ratio_80_delay += pmlmeext->bcn_delay_ratio[i];
 
-				if (ratio_20_delay > 20 && pmlmeext->DrvBcnEarly == 0xff) {
+				if (ratio_20_delay > 20 && pmlmeext->DrvBcnEarly == 0xff)
 					pmlmeext->DrvBcnEarly = i;
-				}
 
-				if (ratio_80_delay > 80 && pmlmeext->DrvBcnTimeOut == 0xff) {
+				if (ratio_80_delay > 80 && pmlmeext->DrvBcnTimeOut == 0xff)
 					pmlmeext->DrvBcnTimeOut = i;
-				}
 
 				/* reset adaptive_early_32k cnt */
 				pmlmeext->bcn_delay_cnt[i] = 0;
@@ -1416,9 +1413,8 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	MaxRsvdPageBufSize = RsvdPageNum*PageSize;
 
 	pcmdframe = rtw_alloc_cmdxmitframe(pxmitpriv);
-	if (!pcmdframe) {
+	if (!pcmdframe)
 		return;
-	}
 
 	ReservedPagePacket = pcmdframe->buf_addr;
 	memset(&RsvdPageLoc, 0, sizeof(RSVDPAGE_LOC));
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 406e48f9d5e928..15654bf850ddcc 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -367,9 +367,8 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	/* 2. read power_state = 0xA0[1:0] */
 	tmp_ps = rtw_read8(padapter, 0xa0);
 	tmp_ps &= 0x03;
-	if (tmp_ps != 0x01) {
+	if (tmp_ps != 0x01)
 		pdbgpriv->dbg_downloadfw_pwr_state_cnt++;
-	}
 
 #ifdef CONFIG_WOWLAN
 	if (bUsedWoWLANFw)
@@ -2069,11 +2068,10 @@ static void rtl8723b_SetHalODMVar(
 
 static void hal_notch_filter_8723b(struct adapter *adapter, bool enable)
 {
-	if (enable) {
+	if (enable)
 		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) | BIT1);
-	} else {
+	else
 		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) & ~BIT1);
-	}
 }
 
 static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index e2235b0790d423..5f45195f634442 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -879,9 +879,8 @@ static void PHY_HandleSwChnlAndSetBW8723B(
 	/* DBG_871X("=> PHY_HandleSwChnlAndSetBW8812: bSwitchChannel %d, bSetBandWidth %d\n", bSwitchChannel, bSetBandWidth); */
 
 	/* check is swchnl or setbw */
-	if (!bSwitchChannel && !bSetBandWidth) {
+	if (!bSwitchChannel && !bSetBandWidth)
 		return;
-	}
 
 	/* skip change for channel or bandwidth is the same */
 	if (bSwitchChannel) {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 152f3ac39190d0..a80aaf5578b744 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -19,9 +19,8 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
 		if (
 			(padapter->bSurpriseRemoved) ||
 			(padapter->bDriverStopped)
-		) {
+		)
 			return false;
-		}
 
 		HalQueryTxOQTBufferStatus8723BSdio(padapter);
 
@@ -296,14 +295,12 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 				}
 
 				/*  ok to send, remove frame from queue */
-				if (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true) {
+				if (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true)
 					if (
 						(pxmitframe->attrib.psta->state & WIFI_SLEEP_STATE) &&
 						(pxmitframe->attrib.triggered == 0)
-					) {
+					)
 						break;
-					}
-				}
 
 				list_del_init(&pxmitframe->list);
 				ptxservq->qcnt--;
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 9779a0ff34a883..17e63e99b3ee0e 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -732,9 +732,9 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 			if ((cpwm_orig ^ cpwm_now) & 0x80)
 				break;
 
-			if (jiffies_to_msecs(jiffies - start_time) > 100) {
+			if (jiffies_to_msecs(jiffies - start_time) > 100)
 				break;
-			}
+
 		} while (1);
 
 		rtl8723b_set_FwPwrModeInIPS_cmd(padapter, 0);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 7dbb2a6ac09331..ae2d02e10f3864 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -469,9 +469,8 @@ static u32 sdio_write_port(
 	adapter = intfhdl->padapter;
 	psdio = &adapter_to_dvobj(adapter)->intf_data;
 
-	if (!adapter->hw_init_completed) {
+	if (!adapter->hw_init_completed)
 		return _FAIL;
-	}
 
 	cnt = round_up(cnt, 4);
 	HalSdioGetCmdAddr8723BSdio(adapter, addr, cnt >> 2, &addr);
@@ -876,9 +875,8 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 			skb_reserve(recvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 		}
 
-		if (!recvbuf->pskb) {
+		if (!recvbuf->pskb)
 			return NULL;
-		}
 	}
 
 	/* 3 3. read data from rxfifo */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 03b617c7407781..a2f1dd3f339719 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -239,9 +239,8 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	/* DBG_8192C("%s\n", __func__); */
 
 	bssinf_len = pnetwork->network.IELength + sizeof(struct ieee80211_hdr_3addr);
-	if (bssinf_len > MAX_BSSINFO_LEN) {
+	if (bssinf_len > MAX_BSSINFO_LEN)
 		goto exit;
-	}
 
 	{
 		u16 wapi_len = 0;
@@ -249,9 +248,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		if (rtw_get_wapi_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &wapi_len) > 0)
 		{
 			if (wapi_len > 0)
-			{
 				goto exit;
-			}
 		}
 	}
 
@@ -414,11 +411,10 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 			}
 			if (!memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
 				&& !memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
-			) {
+			)
 				rtw_cfg80211_inform_bss(padapter, scanned);
-			} else {
+			else
 				rtw_warn_on(1);
-			}
 		}
 
 		if (!rtw_cfg80211_check_bss(padapter))
@@ -455,11 +451,10 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 
 		if (!memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
 			&& !memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
-		) {
+		)
 			rtw_cfg80211_inform_bss(padapter, scanned);
-		} else {
+		else
 			rtw_warn_on(1);
-		}
 	}
 
 check_bss:
@@ -2248,9 +2243,7 @@ static int cfg80211_rtw_del_pmksa(struct wiphy *wiphy,
 	}
 
 	if (false == bMatched)
-	{
 		return -EINVAL;
-	}
 
 	return 0;
 }
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 89fa6550fd56dd..e75ea1f80ab8e7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -208,11 +208,10 @@ static char *translate_scan(struct adapter *padapter,
 	if (vht_cap) {
 		max_rate = vht_data_rate;
 	} else if (ht_cap) {
-		if (mcs_rate&0x8000) { /* MCS15 */
+		if (mcs_rate&0x8000) /* MCS15 */
 			max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
-		} else { /* default MCS7 */
+		else /* default MCS7 */
 			max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
-		}
 
 		max_rate = max_rate*2;/* Mbps/2; */
 	}
@@ -2422,9 +2421,8 @@ static int rtw_set_pid(struct net_device *dev,
 	}
 
 	selector = *pdata;
-	if (selector < 3 && selector >= 0) {
+	if (selector < 3 && selector >= 0)
 		padapter->pid[selector] = *(pdata+1);
-	}
 
 exit:
 
@@ -2646,9 +2644,8 @@ static int rtw_dbg_port(struct net_device *dev,
 						int i;
 						struct recv_reorder_ctrl *preorder_ctrl;
 
-						for (i = 0; i < 16; i++) {
+						for (i = 0; i < 16; i++)
 							preorder_ctrl = &psta->recvreorder_ctrl[i];
-						}
 
 					}
 					break;
@@ -2683,11 +2680,9 @@ static int rtw_dbg_port(struct net_device *dev,
 
 								plist = get_next(plist);
 
-								if (extra_arg == psta->aid) {
-									for (j = 0; j < 16; j++) {
+								if (extra_arg == psta->aid)
+									for (j = 0; j < 16; j++)
 										preorder_ctrl = &psta->recvreorder_ctrl[j];
-									}
-								}
 							}
 						}
 
@@ -2716,12 +2711,11 @@ static int rtw_dbg_port(struct net_device *dev,
 					break;
 				case 0x0c:/* dump rx/tx packet */
 					{
-						if (arg == 0) {
+						if (arg == 0)
 							/* pHalData->bDumpRxPkt =extra_arg; */
 							rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DUMP_RXPKT, &(extra_arg));
-						} else if (arg == 1) {
+						else if (arg == 1)
 							rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DUMP_TXPKT, &(extra_arg));
-						}
 					}
 					break;
 				case 0x0e:
@@ -2751,18 +2745,16 @@ static int rtw_dbg_port(struct net_device *dev,
 					struct registry_priv *pregpriv = &padapter->registrypriv;
 					/*  0: disable, bit(0):enable 2.4g, bit(1):enable 5g, 0x3: enable both 2.4g and 5g */
 					/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
-					if (extra_arg == 0 || extra_arg == 1 || extra_arg == 2 || extra_arg == 3) {
+					if (extra_arg == 0 || extra_arg == 1 || extra_arg == 2 || extra_arg == 3)
 						pregpriv->rx_stbc = extra_arg;
-					}
 				}
 				break;
 				case 0x13: /* set ampdu_enable */
 				{
 					struct registry_priv *pregpriv = &padapter->registrypriv;
 					/*  0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
-					if (extra_arg < 3) {
+					if (extra_arg < 3)
 						pregpriv->ampdu_enable = extra_arg;
-					}
 				}
 				break;
 				case 0x14:
@@ -2801,11 +2793,10 @@ static int rtw_dbg_port(struct net_device *dev,
 						/*  extra_arg : */
 						/*  BIT0: Enable VHT LDPC Rx, BIT1: Enable VHT LDPC Tx, */
 						/*  BIT4: Enable HT LDPC Rx, BIT5: Enable HT LDPC Tx */
-						if (arg == 0) {
+						if (arg == 0)
 							pregistrypriv->ldpc_cap = 0x00;
-						} else if (arg == 1) {
+						else if (arg == 1)
 							pregistrypriv->ldpc_cap = (u8)(extra_arg&0x33);
-						}
 					}
                                         break;
 				case 0x1a:
@@ -2814,11 +2805,10 @@ static int rtw_dbg_port(struct net_device *dev,
 						/*  extra_arg : */
 						/*  BIT0: Enable VHT STBC Rx, BIT1: Enable VHT STBC Tx, */
 						/*  BIT4: Enable HT STBC Rx, BIT5: Enable HT STBC Tx */
-						if (arg == 0) {
+						if (arg == 0)
 							pregistrypriv->stbc_cap = 0x00;
-						} else if (arg == 1) {
+						else if (arg == 1)
 							pregistrypriv->stbc_cap = (u8)(extra_arg&0x33);
-						}
 					}
                                         break;
 				case 0x1b:
@@ -3195,10 +3185,9 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		}
 	} else {
 		psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-		if (!psta) {
+		if (!psta)
 			/* ret = -EINVAL; */
 			goto exit;
-		}
 	}
 
 	if (strcmp(param->u.crypt.alg, "none") == 0 && (psta == NULL)) {
@@ -3227,9 +3216,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
-			if (pwep == NULL) {
+			if (pwep == NULL)
 				goto exit;
-			}
 
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
@@ -3678,9 +3666,8 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	if (ie_len > 0) {
 		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_beacon_ie_len = ie_len;
-		if (pmlmepriv->wps_beacon_ie == NULL) {
+		if (pmlmepriv->wps_beacon_ie == NULL)
 			return -EINVAL;
-		}
 
 		memcpy(pmlmepriv->wps_beacon_ie, param->u.bcn_ie.buf, ie_len);
 
@@ -3713,9 +3700,9 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_probe_resp_ie_len = ie_len;
-		if (pmlmepriv->wps_probe_resp_ie == NULL) {
+		if (pmlmepriv->wps_probe_resp_ie == NULL)
 			return -EINVAL;
-		}
+
 		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
 
@@ -3743,9 +3730,8 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_assoc_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
-		if (pmlmepriv->wps_assoc_resp_ie == NULL) {
+		if (pmlmepriv->wps_assoc_resp_ie == NULL)
 			return -EINVAL;
-		}
 
 		memcpy(pmlmepriv->wps_assoc_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
@@ -4104,9 +4090,8 @@ static int rtw_test(
 	len = wrqu->data.length;
 
 	pbuf = rtw_zmalloc(len);
-	if (pbuf == NULL) {
+	if (pbuf == NULL)
 		return -ENOMEM;
-	}
 
 	if (copy_from_user(pbuf, wrqu->data.pointer, len)) {
 		kfree(pbuf);
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index aaa44c416c937b..804d788f7aaa4a 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -151,9 +151,9 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 		RT_TRACE(_module_mlme_osdep_c_, _drv_info_, ("rtw_report_sec_ie, authmode =%d\n", authmode));
 
 		buff = rtw_zmalloc(IW_CUSTOM_MAX);
-		if (NULL == buff) {
+		if (NULL == buff)
 			return;
-		}
+
 		p = buff;
 
 		p += sprintf(p, "ASSOCINFO(ReqIEs =");
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 2086378802ac3a..eb0a49ae4b9516 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -905,9 +905,8 @@ int _netdev_open(struct net_device *pnetdev)
 		}
 
 		status = rtw_start_drv_threads(padapter);
-		if (status == _FAIL) {
+		if (status == _FAIL)
 			goto netdev_open_error;
-		}
 
 		if (padapter->intf_start)
 			padapter->intf_start(padapter);
@@ -950,9 +949,8 @@ int netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
-	if (pwrctrlpriv->bInSuspend) {
+	if (pwrctrlpriv->bInSuspend)
 		return 0;
-	}
 
 	if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->hw_init_mutex)))
 		return -1;
@@ -1384,11 +1382,10 @@ int rtw_suspend_common(struct adapter *padapter)
 	rtw_stop_cmd_thread(padapter);
 
 	/*  wait for the latest FW to remove this condition. */
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		hal_btcoex_SuspendNotify(padapter, 0);
-	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
+	else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 		hal_btcoex_SuspendNotify(padapter, 1);
-	}
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_SUSPEND);
 
@@ -1668,14 +1665,12 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 	netif_device_attach(pnetdev);
 	netif_carrier_on(pnetdev);
 
-	if (padapter->pid[1] != 0) {
+	if (padapter->pid[1] != 0)
 		rtw_signal_process(padapter->pid[1], SIGUSR2);
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		if (rtw_chk_roam_flags(padapter, RTW_ROAM_ON_RESUME))
 			rtw_roaming(padapter, NULL);
-
 	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		rtw_ap_restore_network(padapter);
 	}
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 64e2d7b211b7e8..d6f4fc0ab4cc2d 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -62,9 +62,8 @@ _pkt *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8
 	pattrib = &prframe->u.hdr.attrib;
 
 	sub_skb = rtw_skb_alloc(nSubframe_Length + 12);
-	if (!sub_skb) {
+	if (!sub_skb)
 		return NULL;
-	}
 
 	skb_reserve(sub_skb, 12);
 	skb_put_data(sub_skb, (pdata + ETH_HLEN), nSubframe_Length);
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index e6ccc9519eae4e..ec69e9a1afe311 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -58,9 +58,8 @@ static void sd_sync_int_hdl(struct sdio_func *func)
 
 	psdpriv = sdio_get_drvdata(func);
 
-	if (!psdpriv->if1) {
+	if (!psdpriv->if1)
 		return;
-	}
 
 	rtw_sdio_set_irq_thd(psdpriv, current);
 	sd_int_hdl(psdpriv->if1);
@@ -460,9 +459,8 @@ static int rtw_drv_init(
 	}
 
 	if1 = rtw_sdio_if1_init(dvobj, id);
-	if (if1 == NULL) {
+	if (if1 == NULL)
 		goto free_dvobj;
-	}
 
 	/* dev_alloc_name && register_netdev */
 	status = rtw_drv_register_netdev(if1);
@@ -544,9 +542,8 @@ static int rtw_sdio_suspend(struct device *dev)
 	struct adapter *padapter = psdpriv->if1;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	if (padapter->bDriverStopped) {
+	if (padapter->bDriverStopped)
 		return 0;
-	}
 
 	if (pwrpriv->bInSuspend) {
 		pdbgpriv->dbg_suspend_error_cnt++;
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 6ece6daee499fc..5cedf775b6ef3c 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -40,9 +40,8 @@ u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return v;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -73,17 +72,15 @@ s32 _sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 
 	for (i = 0; i < cnt; i++) {
 		pdata[i] = sdio_readb(func, addr + i, &err);
-		if (err) {
+		if (err)
 			break;
-		}
 	}
 	return err;
 }
@@ -107,9 +104,8 @@ s32 sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -140,17 +136,15 @@ s32 _sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 
 	for (i = 0; i < cnt; i++) {
 		sdio_writeb(func, pdata[i], addr + i, &err);
-		if (err) {
+		if (err)
 			break;
-		}
 	}
 	return err;
 }
@@ -174,9 +168,8 @@ s32 sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -203,9 +196,8 @@ u8 sd_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return v;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -231,9 +223,8 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return v;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -284,9 +275,8 @@ void sd_write8(struct intf_hdl *pintfhdl, u32 addr, u8 v, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -310,9 +300,8 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
@@ -378,9 +367,8 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 
@@ -391,9 +379,8 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 		for (i = 0; i < cnt; i++) {
 			*(pbuf + i) = sdio_readb(func, addr + i, &err);
 
-			if (err) {
+			if (err)
 				break;
-			}
 		}
 		return err;
 	}
@@ -430,9 +417,9 @@ s32 sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
+
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
@@ -473,9 +460,8 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 /*	size = sdio_align_size(func, cnt); */
@@ -486,9 +472,8 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 
 		for (i = 0; i < cnt; i++) {
 			sdio_writeb(func, *(pbuf + i), addr + i, &err);
-			if (err) {
+			if (err)
 				break;
-			}
 		}
 
 		return err;
@@ -526,9 +511,8 @@ s32 sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdiodev = pintfhdl->pintf_dev;
 	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved)
 		return err;
-	}
 
 	func = psdio->func;
 	claim_needed = rtw_sdio_claim_host_needed(func);
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 233c0d13e4e084..953594e5a6335b 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -112,9 +112,8 @@ static void rtw_check_xmit_resource(struct adapter *padapter, _pkt *pkt)
 	queue = skb_get_queue_mapping(pkt);
 	if (padapter->registrypriv.wifi_spec) {
 		/* No free space for Tx, tx_worker is too slow */
-		if (pxmitpriv->hwxmits[queue].accnt > WMM_XMIT_THRESHOLD) {
+		if (pxmitpriv->hwxmits[queue].accnt > WMM_XMIT_THRESHOLD)
 			netif_stop_subqueue(padapter->pnetdev, queue);
-		}
 	} else {
 		if (pxmitpriv->free_xmitframe_cnt <= 4) {
 			if (!netif_tx_queue_stopped(netdev_get_tx_queue(padapter->pnetdev, queue)))
@@ -233,9 +232,8 @@ int _rtw_xmit_entry(_pkt *pkt, _nic_hdl pnetdev)
 	}
 
 	res = rtw_xmit(padapter, &pkt);
-	if (res < 0) {
+	if (res < 0)
 		goto drop_packet;
-	}
 
 	RT_TRACE(_module_xmit_osdep_c_, _drv_info_, ("rtw_xmit_entry: tx_pkts =%d\n", (u32)pxmitpriv->tx_pkts));
 	goto exit;
-- 
2.53.0

