Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0937106A
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083574; cv=none; b=IfTCotC7SE81iIyhi+U9OnzxUAEdhGWs5h+0JFI6//hMFHAcN5a7EFceH/KTFz1W51baeBi/WJJFccutlExNxRplMQNXsEn44RXUkUEdzyaZuPWOva1zNM25PrTVPwiRzuNLPhzSHPCD4WvzbnHT6G4zkLsORjaC+6WQmdgQJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083574; c=relaxed/simple;
	bh=zO5a+9qiQflfUtBflgNklJuDmPcZPX8T0dWJvKaS9zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAqmTq5NKPfO5yEYhsPF8AmHmmirLdHZcq28xA4DlD9iqZB3cQZsuEJmHOtoMgY5ucU/zbFldaI2z/zVQSfDmlVz3DEWomtsZkhSgB0Roa/+fMXQacm1bqyqx0Dqv+Wb+Sdo9RUE/D7QaF+elcOMfRy9TWqkbmcNlpu2PGKcbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HETXlTSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HETXlTSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6730A1F000E9;
	Wed, 15 Jul 2026 02:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083570;
	bh=I8uoIQ+0DpJIyK/1hTs3y3efE8Y6lMLY/TNmXBaUPQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HETXlTSDn8wI1PHJ9GmE1B0TKzGnAraqqcMawrzpI4uaEgyn68SdxmCO5soBs4CvO
	 SBpWasbY84c2+hE84ehHpiAmsGOFgllRniWkC2fLzcWe7Th1/cvk4dFE6FpMZKDk3q
	 3h4q9IJrdLtYe59ut4/hTqz5XpK6eLu6QVEonBRCWsK+r1O+MjnpblR4NEOPGL8AzA
	 zqiUDJZJRNnJKJExkfOYDYRmzjXJ+zJygDxBMvow15+htW8E9Tn8e48af2svdKR5sq
	 X4Ufzy3TzUPRKbXqEG0Nn38hkPOfkSPwjK4hczaPsFnVRaUxqYDWkgqwKVDEIPzhjA
	 2lLyoy0lEd55g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 03/10] staging: rtl8723bs: remove commented out DBG_871X logs
Date: Tue, 14 Jul 2026 22:45:59 -0400
Message-ID: <20260715024606.107096-3-sashal@kernel.org>
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

[ Upstream commit 68e79909e1d84251ae1889cbad45672f5ba85d7e ]

remove all commented out DBG_871X logs unmatched by
semantic patch.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/125e216e3bb5bc938e06b15dadfbbf51d9517dde.1617802415.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 3bf39f711ff2 ("staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  2 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 24 ------
 drivers/staging/rtl8723bs/core/rtw_efuse.c    |  6 --
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  1 -
 drivers/staging/rtl8723bs/core/rtw_io.c       |  1 -
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  2 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  7 --
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 36 ---------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 23 ------
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 22 ------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  5 --
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |  2 -
 drivers/staging/rtl8723bs/hal/hal_com.c       |  1 -
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 78 -------------------
 drivers/staging/rtl8723bs/hal/odm.c           |  3 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 30 -------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 13 ----
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  5 --
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  2 -
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  1 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  9 +--
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 34 --------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  2 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |  1 -
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c | 13 ----
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  3 -
 26 files changed, 2 insertions(+), 324 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 3df733e863ccb9..e4194a41be8bed 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -271,8 +271,6 @@ void expire_timeout_chk(struct adapter *padapter)
 					psta->expire_to = pstapriv->expire_to;
 					psta->state |= WIFI_STA_ALIVE_CHK_STATE;
 
-					/* DBG_871X("alive chk, sta:" MAC_FMT " is at ps mode!\n", MAC_ARG(psta->hwaddr)); */
-
 					/* to update bcn with tim_bitmap for this station */
 					pstapriv->tim_bitmap |= BIT(psta->aid);
 					update_beacon(padapter, _TIM_IE_, NULL, true);
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 653ab5c06c879c..fd8bd4405505af 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -317,12 +317,6 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	if ((pcmdpriv->padapter->hw_init_completed == false && bAllow == false)
 		|| atomic_read(&(pcmdpriv->cmdthd_running)) == false	/* com_thread not running */
 	) {
-		/* DBG_871X("%s:%s: drop cmdcode:%u, hw_init_completed:%u, cmdthd_running:%u\n", caller_func, __func__, */
-		/* 	cmd_obj->cmdcode, */
-		/* 	pcmdpriv->padapter->hw_init_completed, */
-		/* 	pcmdpriv->cmdthd_running */
-		/*  */
-
 		return _FAIL;
 	}
 	return _SUCCESS;
@@ -433,7 +427,6 @@ int rtw_cmd_thread(void *context)
 		}
 
 		if (list_empty(&(pcmdpriv->cmd_queue.queue))) {
-			/* DBG_871X("%s: cmd queue is empty!\n", __func__); */
 			continue;
 		}
 
@@ -532,8 +525,6 @@ int rtw_cmd_thread(void *context)
 			break;
 		}
 
-		/* DBG_871X("%s: leaving... drop cmdcode:%u size:%d\n", __func__, pcmd->cmdcode, pcmd->cmdsz); */
-
 		if (pcmd->cmdcode == GEN_CMD_CODE(_Set_Drv_Extra)) {
 			extra_parm = (struct drvextra_cmd_parm *)pcmd->parmbuf;
 			if (extra_parm->pbuf && extra_parm->size > 0) {
@@ -1084,8 +1075,6 @@ u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr)
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, paddbareq_parm, GEN_CMD_CODE(_AddBAReq));
 
-	/* DBG_871X("rtw_addbareq_cmd, tid =%d\n", tid); */
-
 	/* rtw_enqueue_cmd(pcmdpriv, ph2c); */
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 
@@ -1325,7 +1314,6 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 		/*  check traffic for  powersaving. */
 		if (((pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod + pmlmepriv->LinkDetectInfo.NumTxOkInPeriod) > 8) ||
 			(pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod > 2)) {
-			/* DBG_871X("(-)Tx = %d, Rx = %d\n", pmlmepriv->LinkDetectInfo.NumTxOkInPeriod, pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod); */
 			bEnterPS = false;
 
 			if (bBusyTraffic == true) {
@@ -1334,15 +1322,11 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 
 				pmlmepriv->LinkDetectInfo.TrafficTransitionCount++;
 
-				/* DBG_871X("Set TrafficTransitionCount to %d\n", pmlmepriv->LinkDetectInfo.TrafficTransitionCount); */
-
 				if (pmlmepriv->LinkDetectInfo.TrafficTransitionCount > 30/*TrafficTransitionLevel*/) {
 					pmlmepriv->LinkDetectInfo.TrafficTransitionCount = 30;
 				}
 			}
 		} else {
-			/* DBG_871X("(+)Tx = %d, Rx = %d\n", pmlmepriv->LinkDetectInfo.NumTxOkInPeriod, pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod); */
-
 			if (pmlmepriv->LinkDetectInfo.TrafficTransitionCount >= 2)
 				pmlmepriv->LinkDetectInfo.TrafficTransitionCount -= 2;
 			else
@@ -1435,7 +1419,6 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 
 	switch (lps_ctrl_type) {
 	case LPS_CTRL_SCAN:
-		/* DBG_871X("LPS_CTRL_SCAN\n"); */
 		hal_btcoex_ScanNotify(padapter, true);
 
 		if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
@@ -1444,11 +1427,9 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 		}
 		break;
 	case LPS_CTRL_JOINBSS:
-		/* DBG_871X("LPS_CTRL_JOINBSS\n"); */
 		LPS_Leave(padapter, "LPS_CTRL_JOINBSS");
 		break;
 	case LPS_CTRL_CONNECT:
-		/* DBG_871X("LPS_CTRL_CONNECT\n"); */
 		mstatus = 1;/* connect */
 		/*  Reset LPS Setting */
 		pwrpriv->LpsIdleCount = 0;
@@ -1456,20 +1437,17 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 		rtw_btcoex_MediaStatusNotify(padapter, mstatus);
 		break;
 	case LPS_CTRL_DISCONNECT:
-		/* DBG_871X("LPS_CTRL_DISCONNECT\n"); */
 		mstatus = 0;/* disconnect */
 		rtw_btcoex_MediaStatusNotify(padapter, mstatus);
 		LPS_Leave(padapter, "LPS_CTRL_DISCONNECT");
 		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_JOINBSSRPT, (u8 *)(&mstatus));
 		break;
 	case LPS_CTRL_SPECIAL_PACKET:
-		/* DBG_871X("LPS_CTRL_SPECIAL_PACKET\n"); */
 		pwrpriv->DelayLPSLastTimeStamp = jiffies;
 		hal_btcoex_SpecialPacketNotify(padapter, PACKET_DHCP);
 		LPS_Leave(padapter, "LPS_CTRL_SPECIAL_PACKET");
 		break;
 	case LPS_CTRL_LEAVE:
-		/* DBG_871X("LPS_CTRL_LEAVE\n"); */
 		LPS_Leave(padapter, "LPS_CTRL_LEAVE");
 		break;
 	case LPS_CTRL_TRAFFIC_BUSY:
@@ -1580,8 +1558,6 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
 	if ((pwrpriv->bFwCurrentInPSMode == true) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
 		u8 ps_mode = pwrpriv->pwr_mode;
 
-		/* DBG_871X("change DTIM from %d to %d, ps_mode =%d\n", pwrpriv->dtim, dtim, ps_mode); */
-
 		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
 	}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 4f3c6cac5e3678..b313b7782641b6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -262,9 +262,6 @@ bool		bPseudoTest)
 	u8 bResult;
 	u8 readbyte;
 
-	/* DBG_871X("===> EFUSE_OneByteRead(), addr = %x\n", addr); */
-	/* DBG_871X("===> EFUSE_OneByteRead() start, 0x34 = 0x%X\n", rtw_read32(padapter, EFUSE_TEST)); */
-
 	if (bPseudoTest) {
 		return Efuse_Read1ByteFromFakeContent(padapter, addr, data);
 	}
@@ -312,9 +309,6 @@ bool		bPseudoTest)
 	u8 bResult = false;
 	u32 efuseValue = 0;
 
-	/* DBG_871X("===> EFUSE_OneByteWrite(), addr = %x data =%x\n", addr, data); */
-	/* DBG_871X("===> EFUSE_OneByteWrite() start, 0x34 = 0x%X\n", rtw_read32(padapter, EFUSE_TEST)); */
-
 	if (bPseudoTest) {
 		return Efuse_Write1ByteToFakeContent(padapter, addr, data);
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 9cd8d44c4c63f6..f4f02c225662dc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -809,7 +809,6 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
 
-		/* DBG_871X("%s attr_ptr:%p, id:%u, length:%u\n", __func__, attr_ptr, attr_id, attr_data_len); */
 		if (attr_id == target_attr_id) {
 			target_attr_ptr = attr_ptr;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index 03ba5bca815678..ed01354f58bdce 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -175,7 +175,6 @@ int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 	if (value > MAX_CONTINUAL_IO_ERR) {
 		ret = true;
 	} else {
-		/* DBG_871X("[dvobj:%p] continual_io_error:%d\n", dvobj, value); */
 	}
 	return ret;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 068ba9a72dacc8..dff1f65ad8efc9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -137,7 +137,6 @@ u8 rtw_do_join(struct adapter *padapter)
 				if (pmlmepriv->LinkDetectInfo.bBusyTraffic == false
 					|| rtw_to_roam(padapter) > 0
 				) {
-					/* DBG_871X("rtw_do_join() when   no desired bss in scanning queue\n"); */
 					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
 					if (_SUCCESS != ret) {
 						pmlmepriv->to_join = false;
@@ -415,7 +414,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 
 	if (*pold_state != networktype) {
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, (" change mode!"));
-		/* DBG_871X("change mode, old_mode =%d, new_mode =%d, fw_state = 0x%x\n", *pold_state, networktype, get_fwstate(pmlmepriv)); */
 
 		if (*pold_state == Ndis802_11APMode) {
 			/* change to other mode from Ndis802_11APMode */
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 7a465c4a801423..4605a54a83aad9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -208,8 +208,6 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 
 	pmlmepriv->num_of_scanned--;
 
-	/* DBG_871X("_rtw_free_network:SSID =%s\n", pnetwork->network.Ssid.Ssid); */
-
 	spin_unlock_bh(&free_queue->lock);
 }
 
@@ -895,8 +893,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		}
 	}
 
-	/* DBG_871X("scan complete in %dms\n", jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time)); */
-
 	spin_unlock_bh(&pmlmepriv->lock);
 
 	rtw_os_xmit_schedule(adapter);
@@ -1047,8 +1043,6 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING|WIFI_UNDER_WPS);
 
-	/* DBG_871X("clear wps when %s\n", __func__); */
-
 	if (rtw_to_roam(padapter) > 0)
 		_clr_fwstate_(pmlmepriv, _FW_LINKED);
 
@@ -2684,7 +2678,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 		max_ampdu_sz = (pht_capie->ampdu_params_info & IEEE80211_HT_CAP_AMPDU_FACTOR);
 		max_ampdu_sz = 1 << (max_ampdu_sz+3); /*  max_ampdu_sz (kbytes); */
 
-		/* DBG_871X("rtw_update_ht_cap(): max_ampdu_sz =%d\n", max_ampdu_sz); */
 		phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
 
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 371767045040b8..b870373db3ef91 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -612,9 +612,6 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 		return _SUCCESS;
 	}
 
-
-	/* DBG_871X("+OnProbeReq\n"); */
-
 #ifdef CONFIG_AUTO_AP_MODE
 	if (check_fwstate(pmlmepriv, _FW_LINKED) &&
 			pmlmepriv->cur_network.join_res) {
@@ -741,7 +738,6 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 _issue_probersp:
 		if ((check_fwstate(pmlmepriv, _FW_LINKED)  &&
 			pmlmepriv->cur_network.join_res) || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
-			/* DBG_871X("+issue_probersp during ap mode\n"); */
 			issue_probersp(padapter, get_sa(pframe), is_valid_p2p_probereq);
 		}
 
@@ -836,7 +832,6 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
 				if ((sta_rx_pkts(psta) & 0xf) == 0)
-					/* DBG_871X("update_bcn_info\n"); */
 					update_beacon_info(padapter, pframe, len, psta);
 
 				adaptive_early_32k(pmlmeext, pframe, len);
@@ -847,7 +842,6 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
 				if ((sta_rx_pkts(psta) & 0xf) == 0) {
-					/* DBG_871X("update_bcn_info\n"); */
 					update_beacon_info(padapter, pframe, len, psta);
 				}
 			} else {
@@ -1104,7 +1098,6 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
 			if (p == NULL) {
-				/* DBG_871X("marc: no challenge text?\n"); */
 				goto authclnt_fail;
 			}
 
@@ -1126,7 +1119,6 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 		}
 	} else {
 		/*  this is also illegal */
-		/* DBG_871X("marc: clnt auth failed due to illegal seq =%x\n", seq); */
 		goto authclnt_fail;
 	}
 
@@ -1924,7 +1916,6 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 				psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
 			}
 
-			/* DBG_871X("marc: ADDBA RSP: %x\n", pmlmeinfo->agg_enable_bitmap); */
 			break;
 
 		case RTW_WLAN_ACTION_DELBA: /* DELBA */
@@ -2151,8 +2142,6 @@ unsigned int OnAction(struct adapter *padapter, union recv_frame *precv_frame)
 
 unsigned int DoReserved(struct adapter *padapter, union recv_frame *precv_frame)
 {
-
-	/* DBG_871X("rcvd mgt frame(%x, %x)\n", (GetFrameSubType(pframe) >> 4), *(unsigned int *)GetAddr1Ptr(pframe)); */
 	return _SUCCESS;
 }
 
@@ -2203,7 +2192,6 @@ void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 
 	pmlmeext->tx_rate = rate;
-	/* DBG_871X("%s(): rate = %x\n", __func__, rate); */
 }
 
 void update_mgntframe_attrib(struct adapter *padapter, struct pkt_attrib *pattrib)
@@ -2334,8 +2322,6 @@ static int update_hidden_ssid(u8 *ies, u32 ies_len, u8 hidden_ssid_mode)
 
 	ssid_ie = rtw_get_ie(ies,  WLAN_EID_SSID, &ssid_len_ori, ies_len);
 
-	/* DBG_871X("%s hidden_ssid_mode:%u, ssid_ie:%p, ssid_len_ori:%d\n", __func__, hidden_ssid_mode, ssid_ie, ssid_len_ori); */
-
 	if (ssid_ie && ssid_len_ori > 0) {
 		switch (hidden_ssid_mode) {
 		case 1:
@@ -2412,7 +2398,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
-		/* DBG_871X("ie len =%d\n", cur_network->IELength); */
 		{
 			int len_diff;
 
@@ -2510,7 +2495,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	/* DBG_871X("issue bcn_sz =%d\n", pattrib->last_txcmdsz); */
 	if (timeout_ms > 0)
 		dump_mgntframe_and_wait(padapter, pmgntframe, timeout_ms);
 	else
@@ -2964,13 +2948,11 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 			use_shared_key = 1;
 		}
 		le_tmp = cpu_to_le16(val16);
-		/* DBG_871X("%s auth_algo = %s auth_seq =%d\n", __func__, (pmlmeinfo->auth_algo == 0)?"OPEN":"SHARED", pmlmeinfo->auth_seq); */
 
 		/* setting IV for auth seq #3 */
 		if ((pmlmeinfo->auth_seq == 3) && (pmlmeinfo->state & WIFI_FW_AUTH_STATE) && (use_shared_key == 1)) {
 			__le32 le_tmp32;
 
-			/* DBG_871X("==> iv(%d), key_index(%d)\n", pmlmeinfo->iv, pmlmeinfo->key_index); */
 			val32 = ((pmlmeinfo->iv++) | (pmlmeinfo->key_index << 30));
 			le_tmp32 = cpu_to_le32(val32);
 			pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&le_tmp32, &(pattrib->pktlen));
@@ -3211,14 +3193,12 @@ void issue_assocreq(struct adapter *padapter)
 
 	/*  Check if the AP's supported rates are also supported by STA. */
 	get_rate_set(padapter, sta_bssrate, &sta_bssrate_len);
-	/* DBG_871X("sta_bssrate_len =%d\n", sta_bssrate_len); */
 
 	if (pmlmeext->cur_channel == 14) /*  for JAPAN, channel 14 can only uses B Mode(CCK) */
 		sta_bssrate_len = 4;
 
 
 	/* for (i = 0; i < sta_bssrate_len; i++) { */
-	/* 	DBG_871X("sta_bssrate[%d]=%02X\n", i, sta_bssrate[i]); */
 	/*  */
 
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
@@ -3237,10 +3217,8 @@ void issue_assocreq(struct adapter *padapter)
 			 /*  Avoid the proprietary data rate (22Mbps) of Handlink WSG-4000 AP */
 			if ((pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK)
 					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK)) {
-				/* DBG_871X("match i = %d, j =%d\n", i, j); */
 				break;
 			} else {
-				/* DBG_871X("not match: %02X != %02X\n", (pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK), (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK)); */
 			}
 		}
 
@@ -3343,8 +3321,6 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da,
 	struct mlme_ext_priv *pmlmeext;
 	struct mlme_ext_info *pmlmeinfo;
 
-	/* DBG_871X("%s:%d\n", __func__, power_mode); */
-
 	if (!padapter)
 		goto exit;
 
@@ -3618,8 +3594,6 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 	int ret = _FAIL;
 	__le16 le_tmp;
 
-	/* DBG_871X("%s to "MAC_FMT"\n", __func__, MAC_ARG(da)); */
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (pmgntframe == NULL) {
 		goto exit;
@@ -4093,8 +4067,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	if (psta == NULL)
 		return _SUCCESS;
 
-	/* DBG_871X("%s:%s\n", __func__, (initiator == 0)?"RX_DIR":"TX_DIR"); */
-
 	if (initiator == 0) {/*  recipient */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
@@ -4106,7 +4078,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 			}
 		}
 	} else if (initiator == 1) {/*  originator */
-		/* DBG_871X("tx agg_enable_bitmap(0x%08x)\n", psta->htpriv.agg_enable_bitmap); */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
@@ -4154,7 +4125,6 @@ unsigned int send_beacon(struct adapter *padapter)
 		if (passing_time > 100 || issue > 3)
 			{}
 		/* else */
-		/* 	DBG_871X("%s success, issue:%d, poll:%d, %u ms\n", __func__, issue, poll, passing_time); */
 
 		return _SUCCESS;
 	}
@@ -4315,7 +4285,6 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
 	if (len > MAX_IE_SZ) {
-		/* DBG_871X("IE too long for survey event\n"); */
 		return _FAIL;
 	}
 
@@ -4571,7 +4540,6 @@ void start_clnt_join(struct adapter *padapter)
 
 		report_join_res(padapter, 1);
 	} else {
-		/* DBG_871X("marc: invalid cap:%x\n", caps); */
 		return;
 	}
 
@@ -5337,8 +5305,6 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 
 		pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
 
-		/* DBG_871X("set_sta_rate\n"); */
-
 		psta->wireless_mode = pmlmeext->cur_wireless_mode;
 
 		/* set per sta rate after updating HT cap. */
@@ -5617,8 +5583,6 @@ void survey_timer_hdl(struct timer_list *t)
 	struct cmd_priv 				*pcmdpriv = &padapter->cmdpriv;
 	struct mlme_ext_priv 	*pmlmeext = &padapter->mlmeextpriv;
 
-	/* DBG_871X("marc: survey timer\n"); */
-
 	/* issue rtw_sitesurvey_cmd */
 	if (pmlmeext->sitesurvey_res.state > SCAN_START) {
 		if (pmlmeext->sitesurvey_res.state ==  SCAN_PROCESS) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 2640c191f0a082..3f0f2d4e683def 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -98,12 +98,10 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 	bool ret = false;
 
 	if (adapter_to_pwrctl(adapter)->bpower_saving) {
-		/* DBG_871X("%s: already in LPS or IPS mode\n", __func__); */
 		goto exit;
 	}
 
 	if (time_before(jiffies, adapter_to_pwrctl(adapter)->ips_deny_time)) {
-		/* DBG_871X("%s ips_deny_time\n", __func__); */
 		goto exit;
 	}
 
@@ -231,7 +229,6 @@ void traffic_check_for_leave_lps(struct adapter *padapter, u8 tx, u32 tx_packets
 	}
 
 	if (bLeaveLPS)
-		/* DBG_871X("leave lps via %s, Tx = %d, Rx = %d\n", tx?"Tx":"Rx", pmlmepriv->LinkDetectInfo.NumTxOkInPeriod, pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod); */
 		/* rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_LEAVE, 1); */
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_LEAVE, tx?0:1);
 }
@@ -540,8 +537,6 @@ void LPS_Enter(struct adapter *padapter, const char *msg)
 		} else
 			pwrpriv->LpsIdleCount++;
 	}
-
-/* 	DBG_871X("-LeisurePSEnter\n"); */
 }
 
 /*  */
@@ -556,8 +551,6 @@ void LPS_Leave(struct adapter *padapter, const char *msg)
 	struct pwrctrl_priv *pwrpriv = dvobj_to_pwrctl(dvobj);
 	char buf[32] = {0};
 
-/* 	DBG_871X("+LeisurePSLeave\n"); */
-
 	if (hal_btcoex_IsBtControlLps(padapter))
 		return;
 
@@ -572,8 +565,6 @@ void LPS_Leave(struct adapter *padapter, const char *msg)
 	}
 
 	pwrpriv->bpower_saving = false;
-/* 	DBG_871X("-LeisurePSLeave\n"); */
-
 }
 
 void LeaveAllPowerSaveModeDirect(struct adapter *Adapter)
@@ -739,7 +730,6 @@ static void rpwmtimeout_workitem_callback(struct work_struct *work)
 	pwrpriv = container_of(work, struct pwrctrl_priv, rpwmtimeoutwi);
 	dvobj = pwrctl_to_dvobj(pwrpriv);
 	padapter = dvobj->if1;
-/* 	DBG_871X("+%s: rpwm = 0x%02X cpwm = 0x%02X\n", __func__, pwrpriv->rpwm, pwrpriv->cpwm); */
 
 	mutex_lock(&pwrpriv->lock);
 	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
@@ -1299,9 +1289,6 @@ void rtw_ps_deny(struct adapter *padapter, enum PS_DENY_REASON reason)
 {
 	struct pwrctrl_priv *pwrpriv;
 
-/* 	DBG_871X("+" FUNC_ADPT_FMT ": Request PS deny for %d (0x%08X)\n", */
-/* 		FUNC_ADPT_ARG(padapter), reason, BIT(reason)); */
-
 	pwrpriv = adapter_to_pwrctl(padapter);
 
 	mutex_lock(&pwrpriv->lock);
@@ -1309,9 +1296,6 @@ void rtw_ps_deny(struct adapter *padapter, enum PS_DENY_REASON reason)
 	}
 	pwrpriv->ps_deny |= BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
-
-/* 	DBG_871X("-" FUNC_ADPT_FMT ": Now PS deny for 0x%08X\n", */
-/* 		FUNC_ADPT_ARG(padapter), pwrpriv->ps_deny); */
 }
 
 /*
@@ -1322,10 +1306,6 @@ void rtw_ps_deny_cancel(struct adapter *padapter, enum PS_DENY_REASON reason)
 {
 	struct pwrctrl_priv *pwrpriv;
 
-
-/* 	DBG_871X("+" FUNC_ADPT_FMT ": Cancel PS deny for %d(0x%08X)\n", */
-/* 		FUNC_ADPT_ARG(padapter), reason, BIT(reason)); */
-
 	pwrpriv = adapter_to_pwrctl(padapter);
 
 	mutex_lock(&pwrpriv->lock);
@@ -1333,9 +1313,6 @@ void rtw_ps_deny_cancel(struct adapter *padapter, enum PS_DENY_REASON reason)
 	}
 	pwrpriv->ps_deny &= ~BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
-
-/* 	DBG_871X("-" FUNC_ADPT_FMT ": Now PS deny for 0x%08X\n", */
-/* 		FUNC_ADPT_ARG(padapter), pwrpriv->ps_deny); */
 }
 
 /*
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 0babb6f0c989d4..8261b313e7d540 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -340,7 +340,6 @@ sint recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvframe)
 				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
 
 				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic: bcmc key\n"));
-				/* DBG_871X("\n recvframe_chkmic: bcmc key psecuritypriv->dot118021XGrpKeyid(%d), pmlmeinfo->key_index(%d) , recv key_id(%d)\n", */
 				/* 								psecuritypriv->dot118021XGrpKeyid, pmlmeinfo->key_index, rxdata_key_idx); */
 
 				if (psecuritypriv->binstallGrpkey == false) {
@@ -642,7 +641,6 @@ void process_pwrbit_data(struct adapter *padapter, union recv_frame *precv_frame
 
 				stop_sta_xmit(padapter, psta);
 
-				/* DBG_871X("to sleep, sta_dz_bitmap =%x\n", pstapriv->sta_dz_bitmap); */
 			}
 		} else {
 			if (psta->state & WIFI_SLEEP_STATE) {
@@ -650,8 +648,6 @@ void process_pwrbit_data(struct adapter *padapter, union recv_frame *precv_frame
 				/* pstapriv->sta_dz_bitmap &= ~BIT(psta->aid); */
 
 				wakeup_sta_to_xmit(padapter, psta);
-
-				/* DBG_871X("to wakeup, sta_dz_bitmap =%x\n", pstapriv->sta_dz_bitmap); */
 			}
 		}
 
@@ -764,8 +760,6 @@ sint sta2sta_data_frame(
 	u8 *sta_addr = NULL;
 	sint bmcast = IS_MCAST(pattrib->dst);
 
-	/* DBG_871X("[%s] %d, seqnum:%d\n", __func__, __LINE__, pattrib->seq_num); */
-
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) ||
 		(check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
 
@@ -962,8 +956,6 @@ sint ap2sta_data_frame(
 				/* for AP multicast issue , modify by yiwei */
 				static unsigned long send_issue_deauth_time;
 
-				/* DBG_871X("After send deauth , %u ms has elapsed.\n", jiffies_to_msecs(jiffies - send_issue_deauth_time)); */
-
 				if (jiffies_to_msecs(jiffies - send_issue_deauth_time) > 10000 || send_issue_deauth_time == 0) {
 					send_issue_deauth_time = jiffies;
 
@@ -1050,8 +1042,6 @@ sint validate_recv_ctrl_frame(struct adapter *padapter, union recv_frame *precv_
 	struct sta_info *psta = NULL;
 	/* uint len = precv_frame->u.hdr.len; */
 
-	/* DBG_871X("+validate_recv_ctrl_frame\n"); */
-
 	if (GetFrameType(pframe) != WIFI_CTRL_TYPE)
 		return _FAIL;
 
@@ -1130,15 +1120,11 @@ sint validate_recv_ctrl_frame(struct adapter *padapter, union recv_frame *precv_
 
 				pxmitframe->attrib.triggered = 1;
 
-				/* DBG_871X("handling ps-poll, q_len =%d, tim =%x\n", psta->sleepq_len, pstapriv->tim_bitmap); */
-
 				rtw_hal_xmitframe_enqueue(padapter, pxmitframe);
 
 				if (psta->sleepq_len == 0) {
 					pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
-					/* DBG_871X("after handling ps-poll, tim =%x\n", pstapriv->tim_bitmap); */
-
 					/* update BCN for TIM IE */
 					/* update_BCNTIM(padapter); */
 					update_beacon(padapter, _TIM_IE_, NULL, true);
@@ -1151,7 +1137,6 @@ sint validate_recv_ctrl_frame(struct adapter *padapter, union recv_frame *precv_
 				/* spin_unlock_bh(&psta->sleep_q.lock); */
 				spin_unlock_bh(&pxmitpriv->lock);
 
-				/* DBG_871X("no buffered packets to xmit\n"); */
 				if (pstapriv->tim_bitmap&BIT(psta->aid)) {
 					if (psta->sleepq_len == 0) {
 						/* issue nulldata with More data bit = 0 to indicate we have no buffered packets */
@@ -1396,10 +1381,8 @@ static sint validate_80211w_mgmt(struct adapter *adapter, union recv_frame *prec
 			/* verify BIP MME IE of broadcast/multicast de-auth/disassoc packet */
 			BIP_ret = rtw_BIP_verify(adapter, (u8 *)precv_frame);
 			if (BIP_ret == _FAIL) {
-				/* DBG_871X("802.11w BIP verify fail\n"); */
 				goto validate_80211w_fail;
 			} else if (BIP_ret == RTW_RX_HANDLED) {
-				/* DBG_871X("802.11w recv none protected packet\n"); */
 				/* issue sa query request */
 				issue_action_SA_Query(adapter, NULL, 0, 0);
 				goto validate_80211w_fail;
@@ -2102,8 +2085,6 @@ int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctr
 			/* indicate this recv_frame */
 			/* DbgPrint("recv_indicatepkts_in_order, indicate_seq =%d, seq_num =%d\n", precvpriv->indicate_seq, pattrib->seq_num); */
 			if (!pattrib->amsdu) {
-				/* DBG_871X("recv_indicatepkts_in_order, amsdu!= 1, indicate_seq =%d, seq_num =%d\n", preorder_ctrl->indicate_seq, pattrib->seq_num); */
-
 				if ((padapter->bDriverStopped == false) &&
 				    (padapter->bSurpriseRemoved == false))
 					rtw_recv_indicatepkt(padapter, prframe);/* indicate this recv_frame */
@@ -2268,8 +2249,6 @@ void rtw_reordering_ctrl_timeout_handler(struct timer_list *t)
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved)
 		return;
 
-	/* DBG_871X("+rtw_reordering_ctrl_timeout_handler() =>\n"); */
-
 	spin_lock_bh(&ppending_recvframe_queue->lock);
 
 	if (recv_indicatepkts_in_order(padapter, preorder_ctrl, true) == true)
@@ -2444,7 +2423,6 @@ int recv_func(struct adapter *padapter, union recv_frame *rframe)
 			!psecuritypriv->busetkipkey) {
 			DBG_COUNTER(padapter->rx_logs.core_rx_enqueue);
 			rtw_enqueue_recvframe(rframe, &padapter->recvpriv.uc_swdec_pending_queue);
-			/* DBG_871X("%s: no key, enqueue uc_swdec_pending_queue\n", __func__); */
 
 			if (recvpriv->free_recvframe_cnt < NR_RECVFRAME/4) {
 				/* to prevent from recvframe starvation, get recvframe from uc_swdec_pending_queue to free_recvframe_cnt  */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index b1eb3c82f65e0c..114d25cdfcee7e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1302,7 +1302,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 			if (pht_info) {
 					bcn_channel = pht_info->primary_channel;
 			} else { /* we don't find channel IE, so don't check it */
-					/* DBG_871X("Oops: %s we don't find channel IE, so don't check it\n", __func__); */
 					bcn_channel = Adapter->mlmeextpriv.cur_channel;
 			}
 	}
@@ -1819,8 +1818,6 @@ void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 	tsf = tsf << 32;
 	tsf |= le32_to_cpu(*pbuf);
 
-	/* DBG_871X("%s(): tsf_upper = 0x%08x, tsf_lower = 0x%08x\n", __func__, (u32)(tsf>>32), (u32)tsf); */
-
 	/* delay = (timestamp mod 1024*100)/1000 (unit: ms) */
 	/* delay_ms = do_div(tsf, (pmlmeinfo->bcn_interval*1024))/1000; */
 	delay_ms = do_div(tsf, (pmlmeinfo->bcn_interval*1024));
@@ -1834,12 +1831,10 @@ void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 		/* pmlmeext->bcn_delay_ratio[delay_ms] = (pmlmeext->bcn_delay_cnt[delay_ms] * 100) /pmlmeext->bcn_cnt; */
 
 /*
-	DBG_871X("%s(): (a)bcn_cnt = %d\n", __func__, pmlmeext->bcn_cnt);
 
 
 	for (i = 0; i<9; i++)
 	{
-		DBG_871X("%s():bcn_delay_cnt[%d]=%d,  bcn_delay_ratio[%d]=%d\n", __func__, i,
 			pmlmeext->bcn_delay_cnt[i] , i, pmlmeext->bcn_delay_ratio[i]);
 	}
 */
diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 3705a60a054621..4512cb19eb0c13 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -1522,7 +1522,6 @@ u32 hal_btcoex_GetDBG(struct adapter *padapter, u8 *pStrBuf, u32 bufSize)
 
 	pstr = pStrBuf;
 	leftSize = bufSize;
-/* 	DBG_871X(FUNC_ADPT_FMT ": bufsize =%d\n", FUNC_ADPT_ARG(padapter), bufSize); */
 
 	count = rtw_sprintf(pstr, leftSize, "#define DBG\t%d\n", DBG);
 	if ((count < 0) || (count >= leftSize))
@@ -1631,7 +1630,6 @@ u32 hal_btcoex_GetDBG(struct adapter *padapter, u8 *pStrBuf, u32 bufSize)
 
 exit:
 	count = pstr - pStrBuf;
-/* 	DBG_871X(FUNC_ADPT_FMT ": usedsize =%d\n", FUNC_ADPT_ARG(padapter), count); */
 
 	return count;
 }
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index e6cbe20acde6ea..018705916e8770 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1669,7 +1669,6 @@ void rtw_bb_rf_gain_offset(struct adapter *padapter)
 	u32 res, i = 0;
 	u32 *Array = Array_kfreemap;
 	u32 v1 = 0, v2 = 0, target = 0;
-	/* DBG_871X("+%s value: 0x%02x+\n", __func__, value); */
 
 	if (value & BIT4) {
 		if (padapter->eeprompriv.EEPROMRFGainVal != 0xff) {
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 48f61736394f83..e35047c47d3bfe 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -193,63 +193,48 @@ struct adapter *padapter
 	for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_B; ++path) {
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_1TX, MGN_11M);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, CCK, RF_1TX, base);
-		/* DBG_871X("Power index base of 2.4G path %d 1Tx CCK = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_1TX, MGN_54M);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, OFDM, RF_1TX, base);
-		/* DBG_871X("Power index base of 2.4G path %d 1Tx OFDM = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_1TX, MGN_MCS7);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, HT_MCS0_MCS7, RF_1TX, base);
-		/* DBG_871X("Power index base of 2.4G path %d 1Tx MCS0-7 = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_2TX, MGN_MCS15);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, HT_MCS8_MCS15, RF_2TX, base);
-		/* DBG_871X("Power index base of 2.4G path %d 2Tx MCS8-15 = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_3TX, MGN_MCS23);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, HT_MCS16_MCS23, RF_3TX, base);
-		/* DBG_871X("Power index base of 2.4G path %d 3Tx MCS16-23 = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_1TX, MGN_VHT1SS_MCS7);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, VHT_1SSMCS0_1SSMCS9, RF_1TX, base);
-		/* DBG_871X("Power index base of 2.4G path %d 1Tx VHT1SS = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_2TX, MGN_VHT2SS_MCS7);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, VHT_2SSMCS0_2SSMCS9, RF_2TX, base);
-		/* DBG_871X("Power index base of 2.4G path %d 2Tx VHT2SS = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_3TX, MGN_VHT3SS_MCS7);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, VHT_3SSMCS0_3SSMCS9, RF_3TX, base);
-		/* DBG_871X("Power index base of 2.4G path %d 3Tx VHT3SS = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_1TX, MGN_54M);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, OFDM, RF_1TX, base);
-		/* DBG_871X("Power index base of 5G path %d 1Tx OFDM = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_1TX, MGN_MCS7);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, HT_MCS0_MCS7, RF_1TX, base);
-		/* DBG_871X("Power index base of 5G path %d 1Tx MCS0~7 = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_2TX, MGN_MCS15);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, HT_MCS8_MCS15, RF_2TX, base);
-		/* DBG_871X("Power index base of 5G path %d 2Tx MCS8~15 = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_3TX, MGN_MCS23);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, HT_MCS16_MCS23, RF_3TX, base);
-		/* DBG_871X("Power index base of 5G path %d 3Tx MCS16~23 = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_1TX, MGN_VHT1SS_MCS7);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, VHT_1SSMCS0_1SSMCS9, RF_1TX, base);
-		/* DBG_871X("Power index base of 5G path %d 1Tx VHT1SS = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_2TX, MGN_VHT2SS_MCS7);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, VHT_2SSMCS0_2SSMCS9, RF_2TX, base);
-		/* DBG_871X("Power index base of 5G path %d 2Tx VHT2SS = > 0x%x\n", path, base); */
 
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_5G, path, RF_3TX, MGN_VHT2SS_MCS7);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, VHT_3SSMCS0_3SSMCS9, RF_3TX, base);
-		/* DBG_871X("Power index base of 5G path %d 3Tx VHT3SS = > 0x%x\n", path, base); */
 	}
 
 	/* DBG_871X("<===%s\n", __func__); */
@@ -753,8 +738,6 @@ static void PHY_StoreTxPowerByRateOld(
 	u8	index = PHY_GetRateSectionIndexOfTxPowerByRate(padapter, RegAddr, BitMask);
 
 	pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][index] = Data;
-	/* DBG_871X("MCSTxPowerLevelOriginalOffset[%d][0] = 0x%x\n", pHalData->pwrGroupCnt, */
-	/*	pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][0]); */
 }
 
 void PHY_InitTxPowerByRate(struct adapter *padapter)
@@ -830,8 +813,6 @@ struct adapter *padapter
 		MGN_VHT3SS_MCS5, MGN_VHT3SS_MCS6, MGN_VHT3SS_MCS7, MGN_VHT3SS_MCS8, MGN_VHT3SS_MCS9
 	};
 
-	/* DBG_871X("===>PHY_ConvertTxPowerByRateInDbmToRelativeValues()\n"); */
-
 	for (band = BAND_ON_2_4G; band <= BAND_ON_5G; ++band) {
 		for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_D; ++path) {
 			for (txNum = RF_1TX; txNum < RF_MAX_TX_NUM; ++txNum) {
@@ -893,8 +874,6 @@ struct adapter *padapter
 			}
 		}
 	}
-
-	/* DBG_871X("<===PHY_ConvertTxPowerByRateInDbmToRelativeValues()\n"); */
 }
 
 /*
@@ -1040,8 +1019,6 @@ u8 PHY_GetTxPowerIndexBase(
 
 	*bIn24G = phy_GetChnlIndex(Channel, &chnlIdx);
 
-	/* DBG_871X("[%s] Channel Index: %d\n", (*bIn24G?"2.4G":"5G"), chnlIdx); */
-
 	if (*bIn24G) { /* 3 ============================== 2.4 G ============================== */
 		if (IS_CCK_RATE(Rate))
 			txPower = pHalData->Index24G_CCK_Base[RFPath][chnlIdx];
@@ -1050,13 +1027,9 @@ u8 PHY_GetTxPowerIndexBase(
 		else
 			{}
 
-		/* DBG_871X("Base Tx power(RF-%c, Rate #%d, Channel Index %d) = 0x%X\n", */
-		/*		((RFPath == 0)?'A':'B'), Rate, chnlIdx, txPower); */
-
 		/*  OFDM-1T */
 		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
 			txPower += pHalData->OFDM_24G_Diff[RFPath][TX_1S];
-			/* DBG_871X("+PowerDiff 2.4G (RF-%c): (OFDM-1T) = (%d)\n", ((RFPath == 0)?'A':'B'), pHalData->OFDM_24G_Diff[RFPath][TX_1S]); */
 		}
 		if (BandWidth == CHANNEL_WIDTH_20) { /*  BW20-1S, BW20-2S */
 			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
@@ -1068,9 +1041,6 @@ u8 PHY_GetTxPowerIndexBase(
 			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW20_24G_Diff[RFPath][TX_4S];
 
-			/* DBG_871X("+PowerDiff 2.4G (RF-%c): (BW20-1S, BW20-2S, BW20-3S, BW20-4S) = (%d, %d, %d, %d)\n", ((RFPath == 0)?'A':(RFPath == 1)?'B':(RFPath ==2)?'C':'D'), */
-			/*	pHalData->BW20_24G_Diff[RFPath][TX_1S], pHalData->BW20_24G_Diff[RFPath][TX_2S], */
-			/*	pHalData->BW20_24G_Diff[RFPath][TX_3S], pHalData->BW20_24G_Diff[RFPath][TX_4S]); */
 		} else if (BandWidth == CHANNEL_WIDTH_40) { /*  BW40-1S, BW40-2S */
 			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW40_24G_Diff[RFPath][TX_1S];
@@ -1081,9 +1051,6 @@ u8 PHY_GetTxPowerIndexBase(
 			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
 
-			/* DBG_871X("+PowerDiff 2.4G (RF-%c): (BW40-1S, BW40-2S, BW40-3S, BW40-4S) = (%d, %d, %d, %d)\n", ((RFPath == 0)?'A':(RFPath == 1)?'B':(RFPath ==2)?'C':'D'), */
-			/*	pHalData->BW40_24G_Diff[RFPath][TX_1S], pHalData->BW40_24G_Diff[RFPath][TX_2S], */
-			/*	pHalData->BW40_24G_Diff[RFPath][TX_3S], pHalData->BW40_24G_Diff[RFPath][TX_4S]); */
 		}
 		/*  Willis suggest adopt BW 40M power index while in BW 80 mode */
 		else if (BandWidth == CHANNEL_WIDTH_80) {
@@ -1096,9 +1063,6 @@ u8 PHY_GetTxPowerIndexBase(
 			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
 
-			/* DBG_871X("+PowerDiff 2.4G (RF-%c): (BW40-1S, BW40-2S, BW40-3S, BW40-4T) = (%d, %d, %d, %d) P.S. Current is in BW 80MHz\n", ((RFPath == 0)?'A':(RFPath == 1)?'B':(RFPath ==2)?'C':'D'), */
-			/*	pHalData->BW40_24G_Diff[RFPath][TX_1S], pHalData->BW40_24G_Diff[RFPath][TX_2S], */
-			/*	pHalData->BW40_24G_Diff[RFPath][TX_3S], pHalData->BW40_24G_Diff[RFPath][TX_4S]); */
 		}
 	} else {/* 3 ============================== 5 G ============================== */
 		if (MGN_6M <= Rate)
@@ -1106,13 +1070,9 @@ u8 PHY_GetTxPowerIndexBase(
 		else
 			{}
 
-		/* DBG_871X("Base Tx power(RF-%c, Rate #%d, Channel Index %d) = 0x%X\n", */
-		/*	((RFPath == 0)?'A':'B'), Rate, chnlIdx, txPower); */
-
 		/*  OFDM-1T */
 		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
 			txPower += pHalData->OFDM_5G_Diff[RFPath][TX_1S];
-			/* DBG_871X("+PowerDiff 5G (RF-%c): (OFDM-1T) = (%d)\n", ((RFPath == 0)?'A':'B'), pHalData->OFDM_5G_Diff[RFPath][TX_1S]); */
 		}
 
 		/*  BW20-1S, BW20-2S */
@@ -1126,9 +1086,6 @@ u8 PHY_GetTxPowerIndexBase(
 			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW20_5G_Diff[RFPath][TX_4S];
 
-			/* DBG_871X("+PowerDiff 5G (RF-%c): (BW20-1S, BW20-2S, BW20-3S, BW20-4S) = (%d, %d, %d, %d)\n", ((RFPath == 0)?'A':(RFPath == 1)?'B':(RFPath ==2)?'C':'D'), */
-			/*	pHalData->BW20_5G_Diff[RFPath][TX_1S], pHalData->BW20_5G_Diff[RFPath][TX_2S], */
-			/*	pHalData->BW20_5G_Diff[RFPath][TX_3S], pHalData->BW20_5G_Diff[RFPath][TX_4S]); */
 		} else if (BandWidth == CHANNEL_WIDTH_40) { /*  BW40-1S, BW40-2S */
 			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31)  || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW40_5G_Diff[RFPath][TX_1S];
@@ -1139,9 +1096,6 @@ u8 PHY_GetTxPowerIndexBase(
 			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW40_5G_Diff[RFPath][TX_4S];
 
-			/* DBG_871X("+PowerDiff 5G(RF-%c): (BW40-1S, BW40-2S) = (%d, %d, %d, %d)\n", ((RFPath == 0)?'A':(RFPath == 1)?'B':(RFPath ==2)?'C':'D'), */
-			/*	pHalData->BW40_5G_Diff[RFPath][TX_1S], pHalData->BW40_5G_Diff[RFPath][TX_2S], */
-			/*	pHalData->BW40_5G_Diff[RFPath][TX_3S], pHalData->BW40_5G_Diff[RFPath][TX_4S]); */
 		} else if (BandWidth == CHANNEL_WIDTH_80) { /*  BW80-1S, BW80-2S */
 			/*  <20121220, Kordan> Get the index of array "Index5G_BW80_Base". */
 			u8 channel5G_80M[CHANNEL_MAX_NUMBER_5G_80M] = {42, 58, 106, 122, 138, 155, 171};
@@ -1159,10 +1113,6 @@ u8 PHY_GetTxPowerIndexBase(
 				txPower += pHalData->BW80_5G_Diff[RFPath][TX_3S];
 			if ((MGN_MCS23 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW80_5G_Diff[RFPath][TX_4S];
-
-			/* DBG_871X("+PowerDiff 5G(RF-%c): (BW80-1S, BW80-2S, BW80-3S, BW80-4S) = (%d, %d, %d, %d)\n", ((RFPath == 0)?'A':(RFPath == 1)?'B':(RFPath ==2)?'C':'D'), */
-			/*	pHalData->BW80_5G_Diff[RFPath][TX_1S], pHalData->BW80_5G_Diff[RFPath][TX_2S], */
-			/*	pHalData->BW80_5G_Diff[RFPath][TX_3S], pHalData->BW80_5G_Diff[RFPath][TX_4S]); */
 		}
 	}
 
@@ -1180,10 +1130,8 @@ s8 PHY_GetTxPowerTrackingOffset(struct adapter *padapter, u8 RFPath, u8 Rate)
 
 	if ((Rate == MGN_1M) || (Rate == MGN_2M) || (Rate == MGN_5_5M) || (Rate == MGN_11M)) {
 		offset = pDM_Odm->Remnant_CCKSwingIdx;
-		/* DBG_871X("+Remnant_CCKSwingIdx = 0x%x\n", RFPath, Rate, pDM_Odm->Remnant_CCKSwingIdx); */
 	} else {
 		offset = pDM_Odm->Remnant_OFDMSwingIdx[RFPath];
-		/* DBG_871X("+Remanant_OFDMSwingIdx[RFPath %u][Rate 0x%x] = 0x%x\n", RFPath, Rate, pDM_Odm->Remnant_OFDMSwingIdx[RFPath]); */
 
 	}
 
@@ -1683,9 +1631,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 		break;
 	}
 
-	/* DBG_871X("pMgntInfo->RegPwrTblSel %d, final regulation %d\n", */
-	/*         adapter->registrypriv.RegPwrTblSel, idx_regulation); */
-
 	if (band_type == BAND_ON_2_4G)
 		idx_band = 0;
 	else if (band_type == BAND_ON_5G)
@@ -1712,9 +1657,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 
 	if (idx_band == -1 || idx_regulation == -1 || idx_bandwidth == -1 ||
 	    idx_rate_sctn == -1 || idx_channel == -1) {
-		/* DBG_871X("Wrong index value to access power limit table [band %d][regulation %d][bandwidth %d][rf_path %d][rate_section %d][chnlGroup %d]\n", */
-		/*         idx_band, idx_regulation, idx_bandwidth, rf_path, */
-		/*         idx_rate_sctn, channel); */
 
 		return MAX_POWER_INDEX;
 	}
@@ -1777,8 +1719,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	}
 	*/
 
-	/* DBG_871X("TxPwrLmt[Regulation %d][Band %d][BW %d][RFPath %d][Rate 0x%x][Chnl %d] = %d\n", */
-	/*		idx_regulation, hal_data->CurrentBandType, bandwidth, rf_path, data_rate, channel, pwr_lmt); */
 	return pwr_lmt;
 }
 
@@ -1796,7 +1736,6 @@ static void phy_CrossReferenceHTAndVHTTxPowerLimit(struct adapter *padapter)
 					if (tempPwrLmt == MAX_POWER_INDEX) {
 						u8 baseSection = 2, refSection = 6;
 						if (bw == 0 || bw == 1) { /*  5G 20M 40M VHT and HT can cross reference */
-							/* DBG_871X("No power limit table of the specified band %d, bandwidth %d, ratesection %d, channel %d, rf path %d\n", */
 							/*			1, bw, rateSection, channel, ODM_RF_PATH_A); */
 							if (rateSection >= 2 && rateSection <= 9) {
 								if (rateSection == 2) {
@@ -1827,8 +1766,6 @@ static void phy_CrossReferenceHTAndVHTTxPowerLimit(struct adapter *padapter)
 								pHalData->TxPwrLimit_5G[regulation][bw][baseSection][channel][ODM_RF_PATH_A] =
 									pHalData->TxPwrLimit_5G[regulation][bw][refSection][channel][ODM_RF_PATH_A];
 							}
-
-							/* DBG_871X("use other value %d", tempPwrLmt); */
 						}
 					}
 				}
@@ -1845,8 +1782,6 @@ void PHY_ConvertTxPowerLimitToPowerIndex(struct adapter *Adapter)
 	s8 tempValue = 0, tempPwrLmt = 0;
 	u8 rfPath = 0;
 
-	/* DBG_871X("=====> PHY_ConvertTxPowerLimitToPowerIndex()\n"); */
-
 	phy_CrossReferenceHTAndVHTTxPowerLimit(Adapter);
 
 	for (regulation = 0; regulation < MAX_REGULATION_NUM; ++regulation) {
@@ -1881,8 +1816,6 @@ void PHY_ConvertTxPowerLimitToPowerIndex(struct adapter *Adapter)
 			}
 		}
 	}
-
-	/* DBG_871X("<===== PHY_ConvertTxPowerLimitToPowerIndex()\n"); */
 }
 
 void PHY_InitTxPowerLimit(struct adapter *Adapter)
@@ -1890,8 +1823,6 @@ void PHY_InitTxPowerLimit(struct adapter *Adapter)
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 	u8 i, j, k, l, m;
 
-	/* DBG_871X("=====> PHY_InitTxPowerLimit()!\n"); */
-
 	for (i = 0; i < MAX_REGULATION_NUM; ++i) {
 		for (j = 0; j < MAX_2_4G_BANDWIDTH_NUM; ++j)
 			for (k = 0; k < MAX_RATE_SECTION_NUM; ++k)
@@ -1907,8 +1838,6 @@ void PHY_InitTxPowerLimit(struct adapter *Adapter)
 					for (l = 0; l < MAX_RF_PATH_NUM; ++l)
 						pHalData->TxPwrLimit_5G[i][j][k][m][l] = MAX_POWER_INDEX;
 	}
-
-	/* DBG_871X("<===== PHY_InitTxPowerLimit()!\n"); */
 }
 
 void PHY_SetTxPowerLimit(
@@ -1926,9 +1855,6 @@ void PHY_SetTxPowerLimit(
 	u8 regulation = 0, bandwidth = 0, rateSection = 0, channel;
 	s8 powerLimit = 0, prevPowerLimit, channelIndex;
 
-	/* DBG_871X("Index of power limit table [band %s][regulation %s][bw %s][rate section %s][rf path %s][chnl %s][val %s]\n", */
-	/*	  Band, Regulation, Bandwidth, RateSection, RfPath, Channel, PowerLimit); */
-
 	if (!GetU1ByteIntegerFromStringInDecimal((s8 *)Channel, &channel) ||
 		 !GetU1ByteIntegerFromStringInDecimal((s8 *)PowerLimit, &powerLimit))
 		{}
@@ -1989,8 +1915,6 @@ void PHY_SetTxPowerLimit(
 		if (powerLimit < prevPowerLimit)
 			pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A] = powerLimit;
 
-		/* DBG_871X("2.4G Band value : [regulation %d][bw %d][rate_section %d][chnl %d][val %d]\n", */
-		/*	  regulation, bandwidth, rateSection, channelIndex, pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A]); */
 	} else if (eqNByte(Band, (u8 *)("5G"), 2)) {
 		channelIndex = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_5G, channel);
 
@@ -2002,8 +1926,6 @@ void PHY_SetTxPowerLimit(
 		if (powerLimit < prevPowerLimit)
 			pHalData->TxPwrLimit_5G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A] = powerLimit;
 
-		/* DBG_871X("5G Band value : [regulation %d][bw %d][rate_section %d][chnl %d][val %d]\n", */
-		/*	  regulation, bandwidth, rateSection, channel, pHalData->TxPwrLimit_5G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A]); */
 	} else {
 		return;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index f2a9e95a1563e8..8b9ede67b4784b 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -1383,12 +1383,9 @@ void ODM_TXPowerTrackingCheck(PDM_ODM_T pDM_Odm)
 	if (!pDM_Odm->RFCalibrateInfo.TM_Trigger) { /* at least delay 1 sec */
 		PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_T_METER_NEW, (BIT17 | BIT16), 0x03);
 
-		/* DBG_871X("Trigger Thermal Meter!!\n"); */
-
 		pDM_Odm->RFCalibrateInfo.TM_Trigger = 1;
 		return;
 	} else {
-		/* DBG_871X("Schedule TxPowerTracking direct call!!\n"); */
 		ODM_TXPowerTrackingCallback_ThermalMeter(Adapter);
 		pDM_Odm->RFCalibrateInfo.TM_Trigger = 0;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index e63f13799c9dfd..4eee7eb47d9dab 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -129,9 +129,6 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-
-	/* DBG_871X("%s\n", __func__); */
-
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	fctrl = &(pwlanhdr->frame_control);
@@ -165,7 +162,6 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	pktlen += 2;
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
-		/* DBG_871X("ie len =%d\n", cur_network->IELength); */
 		pktlen += cur_network->IELength - sizeof(struct ndis_802_11_fix_ie);
 		memcpy(pframe, cur_network->IEs+sizeof(struct ndis_802_11_fix_ie), pktlen);
 
@@ -211,8 +207,6 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 
 	*pLength = pktlen;
 
-	/* DBG_871X("%s bcn_sz =%d\n", __func__, pktlen); */
-
 }
 
 static void ConstructPSPoll(struct adapter *padapter, u8 *pframe, u32 *pLength)
@@ -222,8 +216,6 @@ static void ConstructPSPoll(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	/* DBG_871X("%s\n", __func__); */
-
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	/*  Frame control. */
@@ -263,9 +255,6 @@ static void ConstructNullFunctionData(
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-
-	/* DBG_871X("%s:%d\n", __func__, bForcePowerSave); */
-
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	fctrl = &pwlanhdr->frame_control;
@@ -991,9 +980,6 @@ void rtl8723b_set_rssi_cmd(struct adapter *padapter, u8 *param)
 	u8 rssi = *(param+2);
 	u8 uldl_state = 0;
 
-	/* DBG_871X("%s(): param =%.2x-%.2x-%.2x\n", __func__, *param, *(param+1), *(param+2)); */
-	/* DBG_871X("%s(): mac_id =%d rssi =%d\n", __func__, mac_id, rssi); */
-
 	SET_8723B_H2CCMD_RSSI_SETTING_MACID(u1H2CRssiSettingParm, mac_id);
 	SET_8723B_H2CCMD_RSSI_SETTING_RSSI(u1H2CRssiSettingParm, rssi);
 	SET_8723B_H2CCMD_RSSI_SETTING_ULDL_STATE(u1H2CRssiSettingParm, uldl_state);
@@ -1126,8 +1112,6 @@ void rtl8723b_set_FwPsTuneParam_cmd(struct adapter *padapter)
 	u8 ps_timeout = 20;  /* ms Keep awake when tx */
 	u8 dtim_period = 3;
 
-	/* DBG_871X("%s(): FW LPS mode = %d\n", __func__, psmode); */
-
 	SET_8723B_H2CCMD_PSTUNE_PARM_BCN_TO_LIMIT(u1H2CPsTuneParm, bcn_to_limit);
 	SET_8723B_H2CCMD_PSTUNE_PARM_DTIM_TIMEOUT(u1H2CPsTuneParm, dtim_timeout);
 	SET_8723B_H2CCMD_PSTUNE_PARM_PS_TIMEOUT(u1H2CPsTuneParm, ps_timeout);
@@ -1429,8 +1413,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 #endif
 #endif
 
-	/* DBG_871X("%s---->\n", __func__); */
-
 	pxmitpriv = &padapter->xmitpriv;
 	pmlmeext = &padapter->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
@@ -1467,9 +1449,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	ConstructPSPoll(padapter, &ReservedPagePacket[BufIndex], &PSPollLength);
 	rtl8723b_fill_fake_txdesc(padapter, &ReservedPagePacket[BufIndex-TxDescLen], PSPollLength, true, false, false);
 
-	/* DBG_871X("%s(): HW_VAR_SET_TX_CMD: PS-POLL %p %d\n", */
-	/* 	__func__, &ReservedPagePacket[BufIndex-TxDescLen], (PSPollLength+TxDescLen)); */
-
 	CurtPktPageNum = (u8)PageNum_128(TxDescLen + PSPollLength);
 
 	TotalPageNum += CurtPktPageNum;
@@ -1487,9 +1466,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	);
 	rtl8723b_fill_fake_txdesc(padapter, &ReservedPagePacket[BufIndex-TxDescLen], NullDataLength, false, false, false);
 
-	/* DBG_871X("%s(): HW_VAR_SET_TX_CMD: NULL DATA %p %d\n", */
-	/* 	__func__, &ReservedPagePacket[BufIndex-TxDescLen], (NullDataLength+TxDescLen)); */
-
 	CurtPktPageNum = (u8)PageNum_128(TxDescLen + NullDataLength);
 
 	TotalPageNum += CurtPktPageNum;
@@ -1507,9 +1483,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	);
 	rtl8723b_fill_fake_txdesc(padapter, &ReservedPagePacket[BufIndex-TxDescLen], QosNullLength, false, false, false);
 
-	/* DBG_871X("%s(): HW_VAR_SET_TX_CMD: QOS NULL DATA %p %d\n", */
-	/* 	__func__, &ReservedPagePacket[BufIndex-TxDescLen], (QosNullLength+TxDescLen)); */
-
 	CurtPktPageNum = (u8)PageNum_128(TxDescLen + QosNullLength);
 
 	TotalPageNum += CurtPktPageNum;
@@ -1527,9 +1500,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	);
 	rtl8723b_fill_fake_txdesc(padapter, &ReservedPagePacket[BufIndex-TxDescLen], BTQosNullLength, false, true, false);
 
-	/* DBG_871X("%s(): HW_VAR_SET_TX_CMD: BT QOS NULL DATA %p %d\n", */
-	/* 	__func__, &ReservedPagePacket[BufIndex-TxDescLen], (BTQosNullLength+TxDescLen)); */
-
 	CurtPktPageNum = (u8)PageNum_128(TxDescLen + BTQosNullLength);
 
 	TotalPageNum += CurtPktPageNum;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index ece17fc2093fb2..ace7564344d24b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -834,7 +834,6 @@ static void hal_ReadEFuse_WiFi(
 	u16 i, total, used;
 	u8 efuse_usage = 0;
 
-	/* DBG_871X("YJ: ====>%s():_offset =%d _size_byte =%d bPseudoTest =%d\n", __func__, _offset, _size_byte, bPseudoTest); */
 	/*  */
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
@@ -2820,8 +2819,6 @@ u8 BWMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 	u8 BWSettingOfDesc = 0;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	/* DBG_871X("BWMapping pHalData->CurrentChannelBW %d, pattrib->bwmode %d\n", pHalData->CurrentChannelBW, pattrib->bwmode); */
-
 	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
 		if (pattrib->bwmode == CHANNEL_WIDTH_80)
 			BWSettingOfDesc = 2;
@@ -2848,8 +2845,6 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 	u8 SCSettingOfDesc = 0;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	/* DBG_871X("SCMapping: pHalData->CurrentChannelBW %d, pHalData->nCur80MhzPrimeSC %d, pHalData->nCur40MhzPrimeSC %d\n", pHalData->CurrentChannelBW, pHalData->nCur80MhzPrimeSC, pHalData->nCur40MhzPrimeSC); */
-
 	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
 		if (pattrib->bwmode == CHANNEL_WIDTH_80) {
 			SCSettingOfDesc = VHT_DATA_SC_DONOT_CARE;
@@ -2873,8 +2868,6 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 				{}
 		}
 	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
-		/* DBG_871X("SCMapping: HT Case: pHalData->CurrentChannelBW %d, pHalData->nCur40MhzPrimeSC %d\n", pHalData->CurrentChannelBW, pHalData->nCur40MhzPrimeSC); */
-
 		if (pattrib->bwmode == CHANNEL_WIDTH_40) {
 			SCSettingOfDesc = VHT_DATA_SC_DONOT_CARE;
 		} else if (pattrib->bwmode == CHANNEL_WIDTH_20) {
@@ -3565,9 +3558,6 @@ void CCX_FwC2HTxRpt_8723b(struct adapter *padapter, u8 *pdata, u8 len)
 #define	GET_8723B_C2H_TX_RPT_LIFE_TIME_OVER(_Header)	LE_BITS_TO_1BYTE((_Header + 0), 6, 1)
 #define	GET_8723B_C2H_TX_RPT_RETRY_OVER(_Header)	LE_BITS_TO_1BYTE((_Header + 0), 7, 1)
 
-	/* DBG_871X("%s, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\n", __func__, */
-	/* 		*pdata, *(pdata+1), *(pdata+2), *(pdata+3), *(pdata+4), *(pdata+5), *(pdata+6), *(pdata+7)); */
-
 	seq_no = *(pdata+6);
 
 	if (GET_8723B_C2H_TX_RPT_RETRY_OVER(pdata) | GET_8723B_C2H_TX_RPT_LIFE_TIME_OVER(pdata)) {
@@ -3575,7 +3565,6 @@ void CCX_FwC2HTxRpt_8723b(struct adapter *padapter, u8 *pdata, u8 len)
 	}
 /*
 	else if (seq_no != padapter->xmitpriv.seq_no) {
-		DBG_871X("tx_seq_no =%d, rpt_seq_no =%d\n", padapter->xmitpriv.seq_no, seq_no);
 		rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_CCX_PKT_FAIL);
 	}
 */
@@ -3705,8 +3694,6 @@ void C2HPacketHandler_8723B(struct adapter *padapter, u8 *pbuffer, u16 length)
 	C2hEvent.CmdLen = length-2;
 	tmpBuf = pbuffer+2;
 
-	/* DBG_871X("%s C2hEvent.CmdID:%x C2hEvent.CmdLen:%x C2hEvent.CmdSeq:%x\n", */
-	/* 		__func__, C2hEvent.CmdID, C2hEvent.CmdLen, C2hEvent.CmdSeq); */
 	RT_PRINT_DATA(_module_hal_init_c_, _drv_notice_, "C2HPacketHandler_8723B(): Command Content:\n", tmpBuf, C2hEvent.CmdLen);
 
 	process_c2h_event(padapter, &C2hEvent, tmpBuf);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 8d59061e78e18b..bcb08a9521ae95 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -38,7 +38,6 @@ static void update_recvframe_attrib(struct adapter *padapter,
 
 	/*  update rx report to recv_frame attribute */
 	pattrib->pkt_rpt_type = prxreport->c2h_ind ? C2H_PACKET : NORMAL_RX;
-/* 	DBG_871X("%s: pkt_rpt_type =%d\n", __func__, pattrib->pkt_rpt_type); */
 
 	if (pattrib->pkt_rpt_type == NORMAL_RX) {
 		/*  Normal rx packet */
@@ -165,8 +164,6 @@ static void rtl8723bs_c2h_packet_handler(struct adapter *padapter,
 	if (length == 0)
 		return;
 
-	/* DBG_871X("+%s() length =%d\n", __func__, length); */
-
 	tmp = rtw_zmalloc(length);
 	if (!tmp)
 		return;
@@ -177,8 +174,6 @@ static void rtl8723bs_c2h_packet_handler(struct adapter *padapter,
 
 	if (!res)
 		kfree(tmp);
-
-	/* DBG_871X("-%s res(%d)\n", __func__, res); */
 }
 
 static inline union recv_frame *try_alloc_recvframe(struct recv_priv *precvpriv,
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 1567831caf914a..d64d340ca56c34 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -702,13 +702,11 @@ void sa_query_timer_hdl(struct timer_list *t);
 
 #define set_survey_timer(mlmeext, ms) \
 	do { \
-		/*DBG_871X("%s set_survey_timer(%p, %d)\n", __func__, (mlmeext), (ms));*/ \
 		_set_timer(&(mlmeext)->survey_timer, (ms)); \
 	} while (0)
 
 #define set_link_timer(mlmeext, ms) \
 	do { \
-		/*DBG_871X("%s set_link_timer(%p, %d)\n", __func__, (mlmeext), (ms));*/ \
 		_set_timer(&(mlmeext)->link_timer, (ms)); \
 	} while (0)
 #define set_sa_query_timer(mlmeext, ms) \
diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 3d999540e239ea..cbe0a16fdc93f2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -310,7 +310,6 @@ struct pwrctrl_priv {
 
 #define _rtw_set_pwr_state_check_timer(pwrctl, ms) \
 	do { \
-		/*DBG_871X("%s _rtw_set_pwr_state_check_timer(%p, %d)\n", __func__, (pwrctl), (ms));*/ \
 		_set_timer(&(pwrctl)->pwr_state_check_timer, (ms)); \
 	} while (0)
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 8a2017269734b5..53a3a74782311f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -424,7 +424,6 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 			) {
 				if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
 				} else {
-					/* DBG_871X(FUNC_ADPT_FMT" inform success !!\n", FUNC_ADPT_ARG(padapter)); */
 				}
 			} else {
 				rtw_warn_on(1);
@@ -458,8 +457,6 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		struct wlan_bssid_ex  *pnetwork = &(padapter->mlmeextpriv.mlmext_info.network);
 		struct wlan_network *scanned = pmlmepriv->cur_network_scanned;
 
-		/* DBG_871X(FUNC_ADPT_FMT" BSS not found\n", FUNC_ADPT_ARG(padapter)); */
-
 		if (scanned == NULL) {
 			rtw_warn_on(1);
 			goto check_bss;
@@ -470,7 +467,6 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		) {
 			if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
 			} else {
-				/* DBG_871X(FUNC_ADPT_FMT" inform success !!\n", FUNC_ADPT_ARG(padapter)); */
 			}
 		} else {
 			rtw_warn_on(1);
@@ -967,13 +963,12 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 					}
 					else if (strcmp(param->u.crypt.alg, "BIP") == 0)
 					{
-						/* DBG_871X("BIP key_len =%d , index =%d @@@@@@@@@@@@@@@@@@\n", param->u.crypt.key_len, param->u.crypt.idx); */
 						/* save the IGTK key, length 16 bytes */
 						memcpy(padapter->securitypriv.dot11wBIPKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-						/*DBG_871X("IGTK key below:\n");
+						/*
 						for (no = 0;no<16;no++)
 							printk(" %02x ", padapter->securitypriv.dot11wBIPKey[param->u.crypt.idx].skey[no]);
-						DBG_871X("\n");*/
+						*/
 						padapter->securitypriv.dot11wBIPKeyid = param->u.crypt.idx;
 						padapter->securitypriv.binstallBIPkey = true;
 					}
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index bf176c8bce53be..a6f4b9149d1605 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -42,8 +42,6 @@ void indicate_wx_scan_complete_event(struct adapter *padapter)
 	union iwreq_data wrqu;
 
 	memset(&wrqu, 0, sizeof(union iwreq_data));
-
-	/* DBG_871X("+rtw_indicate_wx_scan_complete_event\n"); */
 }
 
 
@@ -213,7 +211,6 @@ static char *translate_scan(struct adapter *padapter,
 		if (mcs_rate&0x8000) { /* MCS15 */
 			max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
 		} else { /* default MCS7 */
-			/* DBG_871X("wx_get_scan, mcs_rate_bitmap = 0x%x\n", mcs_rate); */
 			max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
 		}
 
@@ -359,8 +356,6 @@ static char *translate_scan(struct adapter *padapter,
 	iwe.u.qual.noise = 0; /*  noise level */
 	#endif
 
-	/* DBG_871X("iqual =%d, ilevel =%d, inoise =%d, iupdated =%d\n", iwe.u.qual.qual, iwe.u.qual.level , iwe.u.qual.noise, iwe.u.qual.updated); */
-
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_QUAL_LEN);
 
 	{
@@ -1298,14 +1293,11 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 		char sec_len;
 		int ssid_index = 0;
 
-		/* DBG_871X("%s COMBO_SCAN header is recognized\n", __func__); */
-
 		while (len >= 1) {
 			section = *(pos++); len -= 1;
 
 			switch (section) {
 				case WEXT_CSCAN_SSID_SECTION:
-					/* DBG_871X("WEXT_CSCAN_SSID_SECTION\n"); */
 					if (len < 1) {
 						len = 0;
 						break;
@@ -1318,8 +1310,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 					    sec_len <= 32) {
 						ssid[ssid_index].SsidLength = sec_len;
 						memcpy(ssid[ssid_index].Ssid, pos, sec_len);
-						/* DBG_871X("%s COMBO_SCAN with specific ssid:%s, %d\n", __func__ */
-						/* 	, ssid[ssid_index].Ssid, ssid[ssid_index].SsidLength); */
 						ssid_index++;
 					}
 
@@ -1328,31 +1318,23 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 
 
 				case WEXT_CSCAN_CHANNEL_SECTION:
-					/* DBG_871X("WEXT_CSCAN_CHANNEL_SECTION\n"); */
 					pos += 1; len -= 1;
 					break;
 				case WEXT_CSCAN_ACTV_DWELL_SECTION:
-					/* DBG_871X("WEXT_CSCAN_ACTV_DWELL_SECTION\n"); */
 					pos += 2; len -= 2;
 					break;
 				case WEXT_CSCAN_PASV_DWELL_SECTION:
-					/* DBG_871X("WEXT_CSCAN_PASV_DWELL_SECTION\n"); */
 					pos += 2; len -= 2;
 					break;
 				case WEXT_CSCAN_HOME_DWELL_SECTION:
-					/* DBG_871X("WEXT_CSCAN_HOME_DWELL_SECTION\n"); */
 					pos += 2; len -= 2;
 					break;
 				case WEXT_CSCAN_TYPE_SECTION:
-					/* DBG_871X("WEXT_CSCAN_TYPE_SECTION\n"); */
 					pos += 1; len -= 1;
 					break;
 				default:
-					/* DBG_871X("Unknown CSCAN section %c\n", section); */
 					len = 0; /*  stop parsing */
 			}
-			/* DBG_871X("len:%d\n", len); */
-
 		}
 
 		/* jeff: it has still some scan parameter to parse, we only do this now... */
@@ -2284,7 +2266,6 @@ static int rtw_wx_write_rf(struct net_device *dev,
 	path = *(u32 *)extra;
 	addr = *((u32 *)extra + 1);
 	data32 = *((u32 *)extra + 2);
-/* 	DBG_871X("%s: path =%d addr = 0x%02x data = 0x%05x\n", __func__, path, addr, data32); */
 	rtw_hal_write_rfreg(padapter, path, addr, 0xFFFFF, data32);
 
 	return 0;
@@ -2302,8 +2283,6 @@ static int dummy(struct net_device *dev, struct iw_request_info *a,
 	/* struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev); */
 	/* struct mlme_priv *pmlmepriv = &(padapter->mlmepriv); */
 
-	/* DBG_871X("cmd_code =%x, fwstate = 0x%x\n", a->cmd, get_fwstate(pmlmepriv)); */
-
 	return -1;
 
 }
@@ -2552,7 +2531,6 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 		rereg_priv->old_ifname[IFNAMSIZ-1] = 0;
 	}
 
-	/* DBG_871X("%s wrqu->data.length:%d\n", __func__, wrqu->data.length); */
 	if (wrqu->data.length > IFNAMSIZ)
 		return -EFAULT;
 
@@ -3115,7 +3093,6 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 	case IEEE_PARAM_WPAX_SELECT:
 
 		/*  added for WPA2 mixed mode */
-		/* DBG_871X(KERN_WARNING "------------------------>wpax value = %x\n", value); */
 		/*
 		spin_lock_irqsave(&ieee->wpax_suitlist_lock, flags);
 		ieee->wpax_type_set = 1;
@@ -3527,7 +3504,6 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
 	if (psta)
 	{
-		DBG_871X("rtw_add_sta(), free has been added psta =%p\n", psta);
 		spin_lock_bh(&(pstapriv->sta_hash_lock));
 		rtw_free_stainfo(padapter,  psta);
 		spin_unlock_bh(&(pstapriv->sta_hash_lock));
@@ -3540,8 +3516,6 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	if (psta) {
 		int flags = param->u.add_sta.flags;
 
-		/* DBG_871X("rtw_add_sta(), init sta's variables, psta =%p\n", psta); */
-
 		psta->aid = param->u.add_sta.aid;/* aid = 1~2007 */
 
 		memcpy(psta->bssrateset, param->u.add_sta.tx_supp_rates, 16);
@@ -3600,8 +3574,6 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 	if (psta) {
 		u8 updated = false;
 
-		/* DBG_871X("free psta =%p, aid =%d\n", psta, psta->aid); */
-
 		spin_lock_bh(&pstapriv->asoc_list_lock);
 		if (list_empty(&psta->asoc_list) == false) {
 			list_del_init(&psta->asoc_list);
@@ -3948,8 +3920,6 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 		return -EFAULT;
 	}
 
-	/* DBG_871X("%s, cmd =%d\n", __func__, param->cmd); */
-
 	switch (param->cmd) {
 	case RTL871X_HOSTAPD_FLUSH:
 
@@ -4140,9 +4110,6 @@ static int rtw_wx_set_priv(struct net_device *dev,
 	vfree(ext_dbg);
 	#endif
 
-	/* DBG_871X("rtw_wx_set_priv: (SIOCSIWPRIV) %s ret =%d\n", */
-	/* 		dev->name, ret); */
-
 	return ret;
 
 }
@@ -4463,7 +4430,6 @@ static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
 		piwstats->qual.qual = 0;
 		piwstats->qual.level = 0;
 		piwstats->qual.noise = 0;
-		/* DBG_871X("No link  level:%d, qual:%d, noise:%d\n", tmp_level, tmp_qual, tmp_noise); */
 	} else {
 		#ifdef CONFIG_SIGNAL_DISPLAY_DBM
 		tmp_level = translate_percentage_to_dbm(padapter->recvpriv.signal_strength);
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 2ab99f90fab063..a83d6129c82e03 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -314,7 +314,6 @@ static int rtw_net_set_mac_address(struct net_device *pnetdev, void *p)
 	struct sockaddr *addr = p;
 
 	if (!padapter->bup) {
-		/* DBG_871X("r8711_net_set_mac_address(), MAC =%x:%x:%x:%x:%x:%x\n", addr->sa_data[0], addr->sa_data[1], addr->sa_data[2], addr->sa_data[3], */
 		/* addr->sa_data[4], addr->sa_data[5]); */
 		memcpy(padapter->eeprompriv.mac_addr, addr->sa_data, ETH_ALEN);
 		/* memcpy(pnetdev->dev_addr, addr->sa_data, ETH_ALEN); */
@@ -1060,7 +1059,6 @@ static int netdev_close(struct net_device *pnetdev)
 
 /*if (!padapter->hw_init_completed)
 	{
-		DBG_871X("(1)871x_drv - drv_close, bup =%d, hw_init_completed =%d\n", padapter->bup, padapter->hw_init_completed);
 
 		padapter->bDriverStopped = true;
 
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index d579b370e33533..64e2d7b211b7e8 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -133,7 +133,6 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
 				}
 			} else {
 				/*  to APself */
-				/* DBG_871X("to APSelf\n"); */
 				DBG_COUNTER(padapter->rx_logs.os_indicate_ap_self);
 			}
 		}
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index ee68b564e8dbfd..827ce3013acbf9 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -41,7 +41,6 @@ u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return v;
 	}
 
@@ -77,7 +76,6 @@ s32 _sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
@@ -112,7 +110,6 @@ s32 sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
@@ -146,7 +143,6 @@ s32 _sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
@@ -181,7 +177,6 @@ s32 sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
@@ -211,7 +206,6 @@ u8 sd_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return v;
 	}
 
@@ -242,7 +236,6 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return v;
 	}
 
@@ -302,7 +295,6 @@ void sd_write8(struct intf_hdl *pintfhdl, u32 addr, u8 v, s32 *err)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return;
 	}
 
@@ -331,7 +323,6 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return;
 	}
 
@@ -404,7 +395,6 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
@@ -459,7 +449,6 @@ s32 sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 	func = psdio->func;
@@ -503,7 +492,6 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
@@ -559,7 +547,6 @@ s32 sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
-		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 79a56dfde32d6c..93ddacbcb04b1c 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -113,7 +113,6 @@ static void rtw_check_xmit_resource(struct adapter *padapter, _pkt *pkt)
 	if (padapter->registrypriv.wifi_spec) {
 		/* No free space for Tx, tx_worker is too slow */
 		if (pxmitpriv->hwxmits[queue].accnt > WMM_XMIT_THRESHOLD) {
-			/* DBG_871X("%s(): stop netif_subqueue[%d]\n", __func__, queue); */
 			netif_stop_subqueue(padapter->pnetdev, queue);
 		}
 	} else {
@@ -231,8 +230,6 @@ int _rtw_xmit_entry(_pkt *pkt, _nic_hdl pnetdev)
 			if (res)
 				goto exit;
 		} else {
-			/* DBG_871X("Stop M2U(%d, %d)! ", pxmitpriv->free_xmitframe_cnt, pxmitpriv->free_xmitbuf_cnt); */
-			/* DBG_871X("!m2u); */
 			DBG_COUNTER(padapter->tx_logs.os_tx_m2u_stop);
 		}
 	}
-- 
2.53.0

