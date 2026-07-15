Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B713777E
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083576; cv=none; b=fuGkGiF1Tw2rQYhwX4xpK52FwWe405/zf10gzGC8SARjmMuiTkchYuXZ91l7+03JOOOZNhwvjT4FAfy0vRqLEWOz12rvHDSXMDzAr46h0jjJ1OEciQrpUfwwh6TdANVDELvxwaWrxyRU6S/HzfiQW1gvoABq9snBFEnnNzl1nNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083576; c=relaxed/simple;
	bh=kAEFGOY87/xa4m+4EwsuwJg5JxFcdRKJmc+b+TASc3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOz+xp6Quq0TW/lsBSEUyszNUf0sVQh/4JSozx3iIGxJrtl+pUb/d+N0X4IU5mjuLQa3GDV2aldH0C101CMr7CYuLAL98zd+V3DFCfKwb9Iwe1pykdWjPY3qhRQQjE2plo2W78j0laut7CtNm8nPQ25/Yo0PPQSXd8j2NYrsgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMkv2iD7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMkv2iD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6221F00A3A;
	Wed, 15 Jul 2026 02:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083572;
	bh=+0GFrs7tFtCYlNV0MHo/PkFlkMg1/PqUWyXNKW8pfug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMkv2iD7RkkBEFYXS7VWTN93F/2YNLa4YBycQtpzebBcIWKdXDYapbs3FCbM7WtUD
	 cgM5Bpj88VqMQb//ckyGwzfZ8Q0O5eHTlE0J2osQQCCPs1YsYXrmvGweqsLPt4Yp4Z
	 eTTYokDqGORCJllfZBOtO+w7ChZNKoWUOS15yrp2ajKZKtSoedGJJg72GYtqSscHVZ
	 ou25k65VCjG4a5hWd/32XfRhtOib8EIw0w16TEwvSoOwHQIZXNt9lp53/nQdZrpgrV
	 lnnRzVlfJPggq83PBRAOhI3s4zY6DibaI1JHxYFiH9zGtcyDbMJXpxECutPfPm8Hzn
	 6ZbxmrR/A64Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 05/10] staging: rtl8723bs: remove empty #ifdef blocks after DBG_871X removal
Date: Tue, 14 Jul 2026 22:46:01 -0400
Message-ID: <20260715024606.107096-5-sashal@kernel.org>
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

[ Upstream commit b4f27a06f6382b9d6f9f5cd8a6445b0af001a2a6 ]

remove #ifdef and blocks #if defined() blocks left empty
after DBG_871X removal.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/4e19eb1c71bc1d43d30c1b0a04851ab7ce528f36.1617802415.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 3bf39f711ff2 ("staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  7 --
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 14 ----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 18 -----
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 76 -------------------
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  2 -
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 20 -----
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  2 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 16 ----
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 18 -----
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  4 -
 10 files changed, 177 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 32255387772db0..b5cdf3c9d438e0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -180,9 +180,6 @@ static void update_BCNTIM(struct adapter *padapter)
 u8 chk_sta_is_alive(struct sta_info *psta);
 u8 chk_sta_is_alive(struct sta_info *psta)
 {
-	#ifdef DBG_EXPIRATION_CHK
-	#endif
-
 	sta_update_last_rx_pkts(psta);
 
 	return true;
@@ -204,8 +201,6 @@ void expire_timeout_chk(struct adapter *padapter)
 	plist = get_next(phead);
 
 	/* check auth_queue */
-	#ifdef DBG_EXPIRATION_CHK
-	#endif
 	while (phead != plist) {
 		psta = LIST_CONTAINOR(plist, struct sta_info, auth_list);
 
@@ -235,8 +230,6 @@ void expire_timeout_chk(struct adapter *padapter)
 	plist = get_next(phead);
 
 	/* check asoc_queue */
-	#ifdef DBG_EXPIRATION_CHK
-	#endif
 	while (phead != plist) {
 		psta = LIST_CONTAINOR(plist, struct sta_info, asoc_list);
 		plist = get_next(plist);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5ef66b53f10183..f3e8a2b5bdb70a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -491,11 +491,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	u8 sq_final;
 	long rssi_final;
 
-	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
-	if (strcmp(dst->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
-	}
-	#endif
-
 	/* The rule below is 1/5 for sample value, 4/5 for history value */
 	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&(padapter->mlmepriv.cur_network.network), src, 0)) {
 		/* Take the recvpriv's value for the connected AP*/
@@ -529,9 +524,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	dst->PhyInfo.SignalStrength = ss_final;
 	dst->PhyInfo.SignalQuality = sq_final;
 	dst->Rssi = rssi_final;
-
-	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
-	#endif
 }
 
 static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
@@ -1163,8 +1155,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			preorder_ctrl = &psta->recvreorder_ctrl[i];
 			preorder_ctrl->enable = false;
 			preorder_ctrl->indicate_seq = 0xffff;
-			#ifdef DBG_RX_SEQ
-			#endif
 			preorder_ctrl->wend_b = 0xffff;
 			preorder_ctrl->wsize_b = 64;/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
 		}
@@ -1176,8 +1166,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 				preorder_ctrl = &bmc_sta->recvreorder_ctrl[i];
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
-				#ifdef DBG_RX_SEQ
-				#endif
 				preorder_ctrl->wend_b = 0xffff;
 				preorder_ctrl->wsize_b = 64;/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
 			}
@@ -1214,8 +1202,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	padapter->recvpriv.signal_qual = ptarget_wlan->network.PhyInfo.SignalQuality;
 	/* the ptarget_wlan->network.Rssi is raw data, we use ptarget_wlan->network.PhyInfo.SignalStrength instead (has scaled) */
 	padapter->recvpriv.rssi = translate_percentage_to_dbm(ptarget_wlan->network.PhyInfo.SignalStrength);
-	#if defined(DBG_RX_SIGNAL_DISPLAY_PROCESSING) && 1
-	#endif
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a099c4a0a13b85..de4cfdda050364 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1932,8 +1932,6 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 				preorder_ctrl =  &psta->recvreorder_ctrl[tid];
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
-				#ifdef DBG_RX_SEQ
-				#endif
 			}
 			/* todo: how to notify the host while receiving DELETE BA */
 			break;
@@ -4046,8 +4044,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
-				#ifdef DBG_RX_SEQ
-				#endif
 			}
 		}
 	} else if (initiator == 1) {/*  originator */
@@ -4121,10 +4117,6 @@ void site_survey(struct adapter *padapter)
 		}
 	}
 
-#ifdef DBG_FIXED_CHAN
-	
-#endif
-
 	if (survey_channel != 0) {
 		/* PAUSE 4-AC Queue when site_survey */
 		/* rtw_hal_get_hwreg(padapter, HW_VAR_TXPAUSE, (u8 *)(&val8)); */
@@ -4384,9 +4376,6 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 			pmlmepriv->num_sta_no_ht++;
 	}
 
-	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) & 1
-	#endif
-
 	/*  mark bss info receiving from nearby channel as SignalQuality 101 */
 	if (bssid->Configuration.DSConfig != rtw_get_oper_ch(padapter))
 		bssid->PhyInfo.SignalQuality = 101;
@@ -5413,9 +5402,6 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 {
 	u8 ret = false;
 
-	#ifdef DBG_EXPIRATION_CHK
-	#endif
-
 	if ((sta_rx_data_pkts(psta) == sta_last_rx_data_pkts(psta))
 		&& sta_rx_beacon_pkts(psta) == sta_last_rx_beacon_pkts(psta)
 		&& sta_rx_probersp_pkts(psta) == sta_last_rx_probersp_pkts(psta)
@@ -5468,8 +5454,6 @@ void linked_status_chk(struct adapter *padapter)
 			{
 				if (rx_chk != _SUCCESS) {
 					if (pmlmeext->retry == 0) {
-						#ifdef DBG_EXPIRATION_CHK
-						#endif
 						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
 						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
 						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
@@ -5477,8 +5461,6 @@ void linked_status_chk(struct adapter *padapter)
 				}
 
 				if (tx_chk != _SUCCESS && pmlmeinfo->link_count++ == link_count_limit) {
-					#ifdef DBG_EXPIRATION_CHK
-					#endif
 					tx_chk = issue_nulldata_in_interrupt(padapter, NULL);
 				}
 			}
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 63553e7b67ffab..4a5ed27f2be32c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -465,9 +465,6 @@ union recv_frame *decryptor(struct adapter *padapter, union recv_frame *precv_fr
 	if ((prxattrib->encrypt > 0) && ((prxattrib->bdecrypted == 0) || (psecuritypriv->sw_decrypt == true))) {
 		psecuritypriv->hw_decrypted = false;
 
-		#ifdef DBG_RX_DECRYPTOR
-		#endif
-
 		switch (prxattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
@@ -492,13 +489,8 @@ union recv_frame *decryptor(struct adapter *padapter, union recv_frame *precv_fr
 		DBG_COUNTER(padapter->rx_logs.core_rx_post_decrypt_hw);
 
 		psecuritypriv->hw_decrypted = true;
-		#ifdef DBG_RX_DECRYPTOR
-
-		#endif
 	} else {
 		DBG_COUNTER(padapter->rx_logs.core_rx_post_decrypt_unknown);
-		#ifdef DBG_RX_DECRYPTOR
-		#endif
 	}
 
 	if (res == _FAIL) {
@@ -861,8 +853,6 @@ sint ap2sta_data_frame(
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA ==myself\n"));
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			ret = _FAIL;
 			goto exit;
 		}
@@ -871,8 +861,6 @@ sint ap2sta_data_frame(
 		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast)) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
 				(" ap2sta_data_frame:  compare DA fail; DA ="MAC_FMT"\n", MAC_ARG(pattrib->dst)));
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			ret = _FAIL;
 			goto exit;
 		}
@@ -885,8 +873,6 @@ sint ap2sta_data_frame(
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
 				(" ap2sta_data_frame:  compare BSSID fail ; BSSID ="MAC_FMT"\n", MAC_ARG(pattrib->bssid)));
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid ="MAC_FMT"\n", MAC_ARG(mybssid)));
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 
 			if (!bmcast) {
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
@@ -903,8 +889,6 @@ sint ap2sta_data_frame(
 
 		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ap2sta: can't get psta under STATION_MODE ; drop pkt\n"));
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			ret = _FAIL;
 			goto exit;
 		}
@@ -934,8 +918,6 @@ sint ap2sta_data_frame(
 		*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
 		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under MP_MODE ; drop pkt\n"));
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			ret = _FAIL;
 			goto exit;
 		}
@@ -962,8 +944,6 @@ sint ap2sta_data_frame(
 		}
 
 		ret = _FAIL;
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 	}
 
 exit:
@@ -1214,8 +1194,6 @@ sint validate_recv_data_frame(struct adapter *adapter, union recv_frame *precv_f
 	pbssid = get_hdr_bssid(ptr);
 
 	if (!pbssid) {
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		goto exit;
 	}
@@ -1258,8 +1236,6 @@ sint validate_recv_data_frame(struct adapter *adapter, union recv_frame *precv_f
 	}
 
 	if (ret == _FAIL) {
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		goto exit;
 	} else if (ret == RTW_RX_HANDLED) {
 		goto exit;
@@ -1268,8 +1244,6 @@ sint validate_recv_data_frame(struct adapter *adapter, union recv_frame *precv_f
 
 	if (!psta) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" after to_fr_ds_chk; psta == NULL\n"));
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		goto exit;
 	}
@@ -1305,8 +1279,6 @@ sint validate_recv_data_frame(struct adapter *adapter, union recv_frame *precv_f
 	/*  decache, drop duplicate recv packets */
 	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decache : drop pkt\n"));
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		goto exit;
 	}
@@ -1516,8 +1488,6 @@ sint validate_recv_frame(struct adapter *adapter, union recv_frame *precv_frame)
 	default:
 		DBG_COUNTER(adapter->rx_logs.core_rx_pre_unknown);
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! type = 0x%x\n", type));
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		retval = _FAIL;
 		break;
 	}
@@ -1898,8 +1868,6 @@ int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
 	/*  Rx Reorder initialize condition. */
 	if (preorder_ctrl->indicate_seq == 0xFFFF) {
 		preorder_ctrl->indicate_seq = seq_num;
-		#ifdef DBG_RX_SEQ
-		#endif
 
 		/* DbgPrint("check_indicate_seq, 1st->indicate_seq =%d\n", precvpriv->indicate_seq); */
 	}
@@ -1911,10 +1879,6 @@ int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
 		/* RT_TRACE(COMP_RX_REORDER, DBG_LOUD, ("CheckRxTsIndicateSeq(): Packet Drop! IndicateSeq: %d, NewSeq: %d\n", pTS->RxIndicateSeq, NewSeqNum)); */
 		/* DbgPrint("CheckRxTsIndicateSeq(): Packet Drop! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
 
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
-
-
 		return false;
 	}
 
@@ -1926,8 +1890,6 @@ int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
 	if (SN_EQUAL(seq_num, preorder_ctrl->indicate_seq)) {
 		preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
 
-		#ifdef DBG_RX_SEQ
-		#endif
 	} else if (SN_LESS(wend, seq_num)) {
 		/* RT_TRACE(COMP_RX_REORDER, DBG_LOUD, ("CheckRxTsIndicateSeq(): Window Shift! IndicateSeq: %d, NewSeq: %d\n", pTS->RxIndicateSeq, NewSeqNum)); */
 		/* DbgPrint("CheckRxTsIndicateSeq(): Window Shift! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
@@ -1938,8 +1900,6 @@ int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
 		else
 			preorder_ctrl->indicate_seq = 0xFFF - (wsize - (seq_num + 1)) + 1;
 		pdbgpriv->dbg_rx_ampdu_window_shift_cnt++;
-		#ifdef DBG_RX_SEQ
-		#endif
 	}
 
 	/* DbgPrint("exit->check_indicate_seq(): IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
@@ -2044,8 +2004,6 @@ int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctr
 		prframe = (union recv_frame *)plist;
 		pattrib = &prframe->u.hdr.attrib;
 
-		#ifdef DBG_RX_SEQ
-		#endif
 		recv_indicatepkts_pkt_loss_cnt(pdbgpriv, preorder_ctrl->indicate_seq, pattrib->seq_num);
 		preorder_ctrl->indicate_seq = pattrib->seq_num;
 
@@ -2068,8 +2026,6 @@ int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctr
 
 			if (SN_EQUAL(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
 				preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
-				#ifdef DBG_RX_SEQ
-				#endif
 			}
 
 			/* Set this as a lock to make sure that only one thread is indicating packet. */
@@ -2139,9 +2095,6 @@ int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *prframe
 
 			}
 
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
-
 			return _FAIL;
 
 		}
@@ -2149,32 +2102,22 @@ int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *prframe
 		if (preorder_ctrl->enable == false) {
 			/* indicate this recv_frame */
 			preorder_ctrl->indicate_seq = pattrib->seq_num;
-			#ifdef DBG_RX_SEQ
-			#endif
 
 			rtw_recv_indicatepkt(padapter, prframe);
 
 			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1)%4096;
-			#ifdef DBG_RX_SEQ
-			#endif
 
 			return _SUCCESS;
 		}
 	} else if (pattrib->amsdu == 1) { /* temp filter -> means didn't support A-MSDUs in a A-MPDU */
 		if (preorder_ctrl->enable == false) {
 			preorder_ctrl->indicate_seq = pattrib->seq_num;
-			#ifdef DBG_RX_SEQ
-			#endif
 
 			retval = amsdu_to_msdu(padapter, prframe);
 
 			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1)%4096;
-			#ifdef DBG_RX_SEQ
-			#endif
 
 			if (retval != _SUCCESS) {
-				#ifdef DBG_RX_DROP_FRAME
-				#endif
 			}
 
 			return retval;
@@ -2190,8 +2133,6 @@ int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *prframe
 	/* s2. check if winstart_b(indicate_seq) needs to been updated */
 	if (!check_indicate_seq(preorder_ctrl, pattrib->seq_num)) {
 		pdbgpriv->dbg_rx_ampdu_drop_count++;
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		goto _err_exit;
 	}
 
@@ -2201,8 +2142,6 @@ int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *prframe
 		/* DbgPrint("recv_indicatepkt_reorder, enqueue_reorder_recvframe fail!\n"); */
 		/* spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql); */
 		/* return _FAIL; */
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		goto _err_exit;
 	}
 
@@ -2270,8 +2209,6 @@ int process_recv_indicatepkts(struct adapter *padapter, union recv_frame *prfram
 		/* prframe->u.hdr.preorder_ctrl = &precvpriv->recvreorder_ctrl[pattrib->priority]; */
 
 		if (recv_indicatepkt_reorder(padapter, prframe) != _SUCCESS) { /*  including perform A-MPDU Rx Ordering Buffer Control */
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 
 			if ((padapter->bDriverStopped == false) &&
 			    (padapter->bSurpriseRemoved == false)) {
@@ -2283,8 +2220,6 @@ int process_recv_indicatepkts(struct adapter *padapter, union recv_frame *prfram
 		retval = wlanhdr_to_ethhdr(prframe);
 		if (retval != _SUCCESS) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("wlanhdr_to_ethhdr: drop pkt\n"));
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			return retval;
 		}
 
@@ -2339,8 +2274,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	prframe = decryptor(padapter, prframe);
 	if (!prframe) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decryptor: drop pkt\n"));
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		DBG_COUNTER(padapter->rx_logs.core_rx_post_decrypt_err);
 		goto _recv_data_drop;
@@ -2349,8 +2282,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	prframe = recvframe_chk_defrag(padapter, prframe);
 	if (!prframe)	{
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chk_defrag: drop pkt\n"));
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		DBG_COUNTER(padapter->rx_logs.core_rx_post_defrag_err);
 		goto _recv_data_drop;
 	}
@@ -2358,8 +2289,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	prframe = portctrl(padapter, prframe);
 	if (!prframe) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("portctrl: drop pkt\n"));
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		DBG_COUNTER(padapter->rx_logs.core_rx_post_portctrl_err);
 		goto _recv_data_drop;
@@ -2370,8 +2299,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	ret = process_recv_indicatepkts(padapter, prframe);
 	if (ret != _SUCCESS) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recv_func: process_recv_indicatepkts fail!\n"));
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		rtw_free_recvframe(orig_prframe, pfree_recv_queue);/* free this recv_frame */
 		DBG_COUNTER(padapter->rx_logs.core_rx_post_indicate_err);
 		goto _recv_data_drop;
@@ -2533,9 +2460,6 @@ static void rtw_signal_stat_timer_hdl(struct timer_list *t)
 		recvpriv->signal_strength = tmp_s;
 		recvpriv->rssi = (s8)translate_percentage_to_dbm(tmp_s);
 		recvpriv->signal_qual = tmp_q;
-
-		#if defined(DBG_RX_SIGNAL_DISPLAY_PROCESSING) && 1
-		#endif
 	}
 
 set_timer:
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 77325da8b13803..4d30a5ad651cd6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -264,8 +264,6 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 			preorder_ctrl->enable = false;
 
 			preorder_ctrl->indicate_seq = 0xffff;
-			#ifdef DBG_RX_SEQ
-			#endif
 			preorder_ctrl->wend_b = 0xffff;
 			/* preorder_ctrl->wsize_b = (NR_RECVBUFF-2); */
 			preorder_ctrl->wsize_b = 64;/* 64; */
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index dbb1bd47035b35..08fbd46552a6eb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -495,8 +495,6 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 
 		if ((pattrib->ether_type != 0x888e) && (check_fwstate(pmlmepriv, WIFI_MP_STATE) == false)) {
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\npsta->ieee8021x_blocked == true,  pattrib->ether_type(%.4x) != 0x888e\n", pattrib->ether_type));
-			#ifdef DBG_TX_DROP_FRAME
-			#endif
 			res = _FAIL;
 			goto exit;
 		}
@@ -538,8 +536,6 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 		pattrib->icv_len = 4;
 
 		if (psecuritypriv->busetkipkey == _FAIL) {
-			#ifdef DBG_TX_DROP_FRAME
-			#endif
 			res = _FAIL;
 			goto exit;
 		}
@@ -738,8 +734,6 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 		if (!psta)	{ /*  if we cannot get psta => drop the pkt */
 			DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib_err_ucast_sta);
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:" MAC_FMT"\n", MAC_ARG(pattrib->ra)));
-			#ifdef DBG_TX_DROP_FRAME
-			#endif
 			res = _FAIL;
 			goto exit;
 		} else if ((check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) && (!(psta->state & _FW_LINKED))) {
@@ -753,8 +747,6 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 		/*  if we cannot get psta => drop the pkt */
 		DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib_err_sta);
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:" MAC_FMT "\n", MAC_ARG(pattrib->ra)));
-		#ifdef DBG_TX_DROP_FRAME
-		#endif
 		res = _FAIL;
 		goto exit;
 	}
@@ -1552,8 +1544,6 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 
 	if (pxmitbuf) {
 		pxmitpriv->free_xmit_extbuf_cnt--;
-		#ifdef DBG_XMIT_BUF_EXT
-		#endif
 
 		pxmitbuf->priv_data = NULL;
 
@@ -1585,8 +1575,6 @@ s32 rtw_free_xmitbuf_ext(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 
 	list_add_tail(&pxmitbuf->list, get_list_head(pfree_queue));
 	pxmitpriv->free_xmit_extbuf_cnt++;
-	#ifdef DBG_XMIT_BUF_EXT
-	#endif
 
 	spin_unlock_irqrestore(&pfree_queue->lock, irqL);
 
@@ -1616,8 +1604,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 
 	if (pxmitbuf) {
 		pxmitpriv->free_xmitbuf_cnt--;
-		#ifdef DBG_XMIT_BUF
-		#endif
 
 		pxmitbuf->priv_data = NULL;
 
@@ -1630,8 +1616,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
-	#ifdef DBG_XMIT_BUF
-	#endif
 
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
 
@@ -1662,8 +1646,6 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 			      get_list_head(pfree_xmitbuf_queue));
 
 		pxmitpriv->free_xmitbuf_cnt++;
-		#ifdef DBG_XMIT_BUF
-		#endif
 		spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
 	}
 	return _SUCCESS;
@@ -2099,8 +2081,6 @@ s32 rtw_xmit(struct adapter *padapter, _pkt **ppkt)
 
 	if (res == _FAIL) {
 		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: update attrib fail\n", __func__));
-		#ifdef DBG_TX_DROP_FRAME
-		#endif
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 		return -1;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 2373bfb7b40343..152f3ac39190d0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -251,8 +251,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 			ptxservq = LIST_CONTAINOR(sta_plist, struct tx_servq, tx_pending);
 			sta_plist = get_next(sta_plist);
 
-#ifdef DBG_XMIT_BUF
-#endif
 			pframe_queue = &ptxservq->sta_pending;
 
 			frame_phead = get_list_head(pframe_queue);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 64f4d1c16a934a..03b617c7407781 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1170,9 +1170,6 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 		goto exit;
 	}
 
-#ifdef DEBUG_CFG80211
-#endif
-
 	/* for infra./P2PClient mode */
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
 		&& check_fwstate(pmlmepriv, _FW_LINKED)
@@ -1293,9 +1290,6 @@ void rtw_cfg80211_indicate_scan_done(struct adapter *adapter, bool aborted)
 
 	spin_lock_bh(&pwdev_priv->scan_req_lock);
 	if (pwdev_priv->scan_request != NULL) {
-		#ifdef DEBUG_CFG80211
-		#endif
-
 		/* avoid WARN_ON(request != wiphy_to_dev(request->wiphy)->scan_req); */
 		if (pwdev_priv->scan_request->wiphy != pwdev_priv->rtw_wdev->wiphy)
 		{
@@ -1308,8 +1302,6 @@ void rtw_cfg80211_indicate_scan_done(struct adapter *adapter, bool aborted)
 
 		pwdev_priv->scan_request = NULL;
 	} else {
-		#ifdef DEBUG_CFG80211
-		#endif
 	}
 	spin_unlock_bh(&pwdev_priv->scan_req_lock);
 }
@@ -1450,9 +1442,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
 	{
-#ifdef DEBUG_CFG80211
-#endif
-
 		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
 		{
 			DBG_8192C("%s, fwstate = 0x%x\n", __func__, pmlmepriv->fw_state);
@@ -1526,8 +1515,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	/* parsing channels, n_channels */
 	memset(ch, 0, sizeof(struct rtw_ieee80211_channel)*RTW_CHANNEL_SCAN_AMOUNT);
 	for (i = 0; i < request->n_channels && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
-		#ifdef DEBUG_CFG80211
-		#endif
 		ch[i].hw_value = request->channels[i]->hw_value;
 		ch[i].flags = request->channels[i]->flags;
 	}
@@ -2948,9 +2935,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	/* cookie generation */
 	*cookie = (unsigned long) buf;
 
-#ifdef DEBUG_CFG80211
-#endif /* DEBUG_CFG80211 */
-
 	/* indicate ack before issue frame to avoid racing with rsp frame */
 	rtw_cfg80211_mgmt_tx_status(padapter, *cookie, buf, len, ack, GFP_KERNEL);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 67429033886b58..89fa6550fd56dd 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -1227,9 +1227,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_set_scan\n"));
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	rtw_ps_deny(padapter, PS_DENY_SCAN);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
 		ret = -1;
@@ -1349,9 +1346,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_SCAN);
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	return ret;
 }
 
@@ -1371,9 +1365,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan\n"));
 	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, (" Start of Query SIOCGIWSCAN .\n"));
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	if (adapter_to_pwrctl(padapter)->brfoffbyhw && padapter->bDriverStopped) {
 		ret = -EINVAL;
 		goto exit;
@@ -1419,9 +1410,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 
 exit:
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	return ret;
 
 }
@@ -1446,9 +1434,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	uint ret = 0, len;
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
 		 ("+rtw_wx_set_essid: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
 
@@ -1540,9 +1525,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_JOIN);
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	return ret;
 }
 
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 93ddacbcb04b1c..233c0d13e4e084 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -209,8 +209,6 @@ int _rtw_xmit_entry(_pkt *pkt, _nic_hdl pnetdev)
 	if (rtw_if_up(padapter) == false) {
 		DBG_COUNTER(padapter->tx_logs.os_tx_err_up);
 		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("rtw_xmit_entry: rtw_if_up fail\n"));
-		#ifdef DBG_TX_DROP_FRAME
-		#endif
 		goto drop_packet;
 	}
 
@@ -236,8 +234,6 @@ int _rtw_xmit_entry(_pkt *pkt, _nic_hdl pnetdev)
 
 	res = rtw_xmit(padapter, &pkt);
 	if (res < 0) {
-		#ifdef DBG_TX_DROP_FRAME
-		#endif
 		goto drop_packet;
 	}
 
-- 
2.53.0

