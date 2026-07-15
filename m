Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BEB3242D4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083550; cv=none; b=RfgR8kGuyGTyNLyqsgw9vMMWGMMsrYYXIRDgFw2SluuE+V3E3HZSOulZcPTgs2OqfkvteIT6BvPpEtg20tHF/hFhsM/jhAChRHxEQV5oqkQF/027StDWKFnXl09p/Gf5C4khmspmMgxFQuYlvk4NE0WprjsNBqk2N+9IumgQd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083550; c=relaxed/simple;
	bh=jFA4oHqU53iyhwibzpiOLb3JyQdCbsvjdCKOZf3gxFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8MQDRwmqmy1rT3MnOQjeSKeqtO7T6Ui0UvBWzD8HXxh+B3JaLqV6i9fCTyihtmeV5vOuYT2cmEUwtt+xeYJODHHKDct4XZ9dQ0f4gKgV0mkJVZ7MVS4SwrMBhxybBVkkgjOCQYFOQJd+YRMAuzu466nZsdbinnBKxapvC2gsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovmOSHxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovmOSHxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E801F00A3E;
	Wed, 15 Jul 2026 02:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083548;
	bh=k93msqEa7PO20udQQPPNzMH5Jg6jfstXoTubpQOa3Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ovmOSHxopZtSj3YC02I7+Flj24hohb1RcfsaR+O/GXyQubghffqVHeThwTnPWZPuK
	 pxLdLBTdRPAl+rEvM0BOY/X+8ClMGkiSPWiM3BBUxpT2/xWqjTP53x9oL+6LAl3Efp
	 p0ZR5uCmBaGoJrg2kASEWRepSUbRAYBSiUS2AmiI4eJCqNZtsxjRLm4zYl9eROQ5IW
	 /EsE8I70FREV0OW9rVcIgYUaB687ax92w44KqgxDEuAUMfM92FTUk53C17AYU6e76+
	 2LnEMuMCzP+36Fxvcr232GciLkIuuJxhBPcCcpmji2Z03nTI5soF/OheoyaHDhTShy
	 /fvpSTN5FVm/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 04/10] staging: rtl8723bs: remove all if-else empty blocks left by DBG_871X removal
Date: Tue, 14 Jul 2026 22:45:37 -0400
Message-ID: <20260715024543.105642-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715024543.105642-1-sashal@kernel.org>
References: <2026071316-urchin-unenvied-752f@gregkh>
 <20260715024543.105642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 21e161c3cea5ab3265b540ccb5c4671940306831 ]

remove all if-else empty {} blocks left by spatch application.

removed unused variables and an unused static function definition
after if-else blocks removal, to suppress compiler warnings.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/56055b20bc064d7ac1e8f14bd1ed42aba6b02c36.1617802415.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ed51de4a86e1 ("staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 22 +++-------
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  5 ---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  4 --
 drivers/staging/rtl8723bs/core/rtw_io.c       |  2 +-
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 16 --------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 40 +------------------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 21 ++--------
 drivers/staging/rtl8723bs/core/rtw_recv.c     |  6 ---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  6 ---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  8 ----
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 24 -----------
 drivers/staging/rtl8723bs/hal/hal_com.c       |  6 +--
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 32 ++++-----------
 drivers/staging/rtl8723bs/hal/hal_intf.c      | 10 +----
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 10 +----
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  7 ----
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  2 -
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  3 --
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  2 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  4 --
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  7 +---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 38 +++---------------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 34 ++--------------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  2 -
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c | 20 ----------
 26 files changed, 33 insertions(+), 301 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index e4194a41be8bed..32255387772db0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -205,8 +205,6 @@ void expire_timeout_chk(struct adapter *padapter)
 
 	/* check auth_queue */
 	#ifdef DBG_EXPIRATION_CHK
-	if (phead != plist) {
-	}
 	#endif
 	while (phead != plist) {
 		psta = LIST_CONTAINOR(plist, struct sta_info, auth_list);
@@ -238,8 +236,6 @@ void expire_timeout_chk(struct adapter *padapter)
 
 	/* check asoc_queue */
 	#ifdef DBG_EXPIRATION_CHK
-	if (phead != plist) {
-	}
 	#endif
 	while (phead != plist) {
 		psta = LIST_CONTAINOR(plist, struct sta_info, asoc_list);
@@ -403,7 +399,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		arg[3] = psta->init_rate;
 
 		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
-	} else {
 	}
 }
 
@@ -480,7 +475,6 @@ void update_bmc_sta(struct adapter *padapter)
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
 
-	} else {
 	}
 }
 
@@ -684,8 +678,6 @@ static void update_hw_ht_param(struct adapter *padapter)
 	pmlmeinfo->SM_PS = (le16_to_cpu(
 		pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
 	) & 0x0C) >> 2;
-	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		{}
 
 	/*  */
 	/*  Config current HT Protection mode. */
@@ -860,8 +852,7 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 
 #ifndef CONFIG_INTERRUPT_BASED_TXBCN /* other case will  tx beacon when bcn interrupt coming in. */
 		/* issue beacon frame */
-		if (send_beacon(padapter) == _FAIL)
-			{}
+		send_beacon(padapter);
 
 #endif /* CONFIG_INTERRUPT_BASED_TXBCN */
 	}
@@ -1638,9 +1629,6 @@ static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 
 	else if (!memcmp(P2P_OUI, oui, 4))
 		update_bcn_p2p_ie(padapter);
-
-	else
-		{}
 }
 
 void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
@@ -1935,8 +1923,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			psta->no_ht_set = 1;
 			pmlmepriv->num_sta_no_ht++;
 		}
-		if (pmlmepriv->htpriv.ht_option == true) {
-		}
 	}
 
 	if (rtw_ht_operation_update(padapter) > 0) {
@@ -2189,8 +2175,10 @@ void rtw_ap_restore_network(struct adapter *padapter)
 	for (i = 0; i < chk_alive_num; i++) {
 		psta = rtw_get_stainfo_by_offset(pstapriv, chk_alive_list[i]);
 
-		if (psta == NULL) {
-		} else if (psta->state & _FW_LINKED) {
+		if (psta == NULL)
+			continue;
+
+		if (psta->state & _FW_LINKED) {
 			rtw_sta_media_status_rpt(padapter, psta, 1);
 			Update_RA_Entry(padapter, psta);
 			/* pairwise key */
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index fd8bd4405505af..337558b966e023 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -392,7 +392,6 @@ int rtw_cmd_thread(void *context)
 	struct cmd_obj *pcmd;
 	u8 *pcmdbuf;
 	unsigned long cmd_start_time;
-	unsigned long cmd_process_time;
 	u8 (*cmd_hdl)(struct adapter *padapter, u8 *pbuf);
 	void (*pcmd_callback)(struct adapter *dev, struct cmd_obj *pcmd);
 	struct adapter *padapter = context;
@@ -492,10 +491,6 @@ int rtw_cmd_thread(void *context)
 			mutex_unlock(&(pcmd->padapter->cmdpriv.sctx_mutex));
 		}
 
-		cmd_process_time = jiffies_to_msecs(jiffies - cmd_start_time);
-		if (cmd_process_time > 1000) {
-		}
-
 		/* call callback function for post-processed */
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index f4f02c225662dc..436a606bdf85bb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -870,8 +870,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	 * OUI of the vendor. The following byte is used a vendor specific
 	 * sub-type. */
 	if (elen < 4) {
-		if (show_errors) {
-		}
 		return -1;
 	}
 
@@ -959,8 +957,6 @@ ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 		left -= 2;
 
 		if (elen > left) {
-			if (show_errors) {
-			}
 			return ParseFailed;
 		}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index ed01354f58bdce..25fc52e557d1e0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -174,8 +174,8 @@ int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 	int value = atomic_inc_return(&dvobj->continual_io_error);
 	if (value > MAX_CONTINUAL_IO_ERR) {
 		ret = true;
-	} else {
 	}
+
 	return ret;
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index dff1f65ad8efc9..1fce6b38feb3db 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -486,8 +486,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 		rtw_indicate_disconnect(padapter);
 		/* modify for CONFIG_IEEE80211W, none 11w can use it */
 		rtw_free_assoc_resources_cmd(padapter);
-		if (_FAIL == rtw_pwr_wakeup(padapter))
-			{}
+		rtw_pwr_wakeup(padapter);
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 4605a54a83aad9..5ef66b53f10183 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -531,8 +531,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	dst->Rssi = rssi_final;
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
-	if (strcmp(dst->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
-	}
 	#endif
 }
 
@@ -1093,8 +1091,6 @@ void rtw_scan_abort(struct adapter *adapter)
 	}
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
-		if (!adapter->bDriverStopped && !adapter->bSurpriseRemoved)
-			{}
 		rtw_indicate_scan_done(adapter, true);
 	}
 	pmlmeext->scan_abort = false;
@@ -1782,9 +1778,6 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 	if (adapter->net_closed)
 		return;
 
-	if (is_primary_adapter(adapter))
-		{}
-
 	if ((adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
 		&& !(hal_btcoex_IsBtControlLps(adapter))
 		) {
@@ -1960,9 +1953,6 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 		updated = true;
 	}
 
-	if (updated) {
-	}
-
 exit:
 	return updated;
 }
@@ -2445,8 +2435,6 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 		if (TEST_FLAG(pregistrypriv->ldpc_cap, BIT5))
 			SET_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX);
 	}
-	if (phtpriv->ldpc_cap)
-		{}
 
 	/*  STBC */
 	rtw_hal_get_def_var(padapter, HAL_DEF_TX_STBC, (u8 *)&bHwSTBCSupport);
@@ -2460,8 +2448,6 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 		if (TEST_FLAG(pregistrypriv->stbc_cap, BIT4))
 			SET_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_RX);
 	}
-	if (phtpriv->stbc_cap)
-		{}
 
 	/*  Beamforming setting */
 	rtw_hal_get_def_var(padapter, HAL_DEF_EXPLICIT_BEAMFORMER, (u8 *)&bHwSupportBeamformer);
@@ -2751,8 +2737,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	pmlmeinfo->SM_PS =
 		(le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) &
 		 0x0C) >> 2;
-	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		{}
 
 	/*  */
 	/*  Config current HT Protection mode. */
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index b870373db3ef91..a099c4a0a13b85 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1499,8 +1499,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 
 	/* get a unique AID */
-	if (pstat->aid > 0) {
-	} else {
+	if (pstat->aid == 0) {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (pstapriv->sta_aid[pstat->aid - 1] == NULL)
 				break;
@@ -2855,12 +2854,6 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 		#endif
 	}
 
-	if (try_cnt && wait_ms) {
-		if (da)
-			{}
-		else
-			{}
-	}
 exit:
 	return ret;
 }
@@ -3218,12 +3211,10 @@ void issue_assocreq(struct adapter *padapter)
 			if ((pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK)
 					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK)) {
 				break;
-			} else {
 			}
 		}
 
-		if (j == sta_bssrate_len) {
-		} else {
+		if (j != sta_bssrate_len) {
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
 		}
@@ -3426,12 +3417,6 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 		#endif
 	}
 
-	if (try_cnt && wait_ms) {
-		if (da)
-			{}
-		else
-			{}
-	}
 exit:
 	return ret;
 }
@@ -3570,12 +3555,6 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 		#endif
 	}
 
-	if (try_cnt && wait_ms) {
-		if (da)
-			{}
-		else
-			{}
-	}
 exit:
 	return ret;
 }
@@ -3671,12 +3650,6 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 		#endif
 	}
 
-	if (try_cnt && wait_ms) {
-		if (da)
-			{}
-		else
-			{}
-	}
 exit:
 	return ret;
 }
@@ -4097,7 +4070,6 @@ unsigned int send_beacon(struct adapter *padapter)
 	u8 bxmitok = false;
 	int	issue = 0;
 	int poll = 0;
-	unsigned long start = jiffies;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_BCN_VALID, NULL);
 	rtw_hal_set_hwreg(padapter, HW_VAR_DL_BCN_SEL, NULL);
@@ -4120,12 +4092,6 @@ unsigned int send_beacon(struct adapter *padapter)
 	if (false == bxmitok) {
 		return _FAIL;
 	} else {
-		unsigned long passing_time = jiffies_to_msecs(jiffies - start);
-
-		if (passing_time > 100 || issue > 3)
-			{}
-		/* else */
-
 		return _SUCCESS;
 	}
 }
@@ -4419,8 +4385,6 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	}
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) & 1
-	if (strcmp(bssid->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
-	}
 	#endif
 
 	/*  mark bss info receiving from nearby channel as SignalQuality 101 */
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 3f0f2d4e683def..9094a2dfdb51c5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -250,8 +250,7 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 
 	pslv = PS_STATE(pslv);
 
-	if (pwrpriv->brpwmtimeout) {
-	} else {
+	if (!pwrpriv->brpwmtimeout) {
 		if ((pwrpriv->rpwm == pslv)
 			|| ((pwrpriv->rpwm >= PS_STATE_S2) && (pslv >= PS_STATE_S2))) {
 			RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
@@ -594,8 +593,7 @@ void LeaveAllPowerSaveModeDirect(struct adapter *Adapter)
 		rtw_lps_ctrl_wk_cmd(pri_padapter, LPS_CTRL_LEAVE, 0);
 	} else {
 		if (pwrpriv->rf_pwrstate == rf_off)
-			if (!ips_leave(pri_padapter))
-				{}
+			ips_leave(pri_padapter);
 	}
 }
 
@@ -628,8 +626,7 @@ void LeaveAllPowerSaveMode(struct adapter *Adapter)
 		LPS_Leave_check(Adapter);
 	} else {
 		if (adapter_to_pwrctl(Adapter)->rf_pwrstate == rf_off) {
-			if (!ips_leave(Adapter))
-				{}
+			ips_leave(Adapter);
 		}
 	}
 }
@@ -1173,10 +1170,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	if (pwrpriv->ps_processing) {
 		while (pwrpriv->ps_processing && jiffies_to_msecs(jiffies - start) <= 3000)
 			mdelay(10);
-		if (pwrpriv->ps_processing)
-			{}
-		else
-			{}
 	}
 
 	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend) {
@@ -1185,10 +1178,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		) {
 			mdelay(10);
 		}
-		if (pwrpriv->bInSuspend)
-			{}
-		else
-			{}
 	}
 
 	/* System suspend is not allowed to wakeup */
@@ -1292,8 +1281,6 @@ void rtw_ps_deny(struct adapter *padapter, enum PS_DENY_REASON reason)
 	pwrpriv = adapter_to_pwrctl(padapter);
 
 	mutex_lock(&pwrpriv->lock);
-	if (pwrpriv->ps_deny & BIT(reason)) {
-	}
 	pwrpriv->ps_deny |= BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
 }
@@ -1309,8 +1296,6 @@ void rtw_ps_deny_cancel(struct adapter *padapter, enum PS_DENY_REASON reason)
 	pwrpriv = adapter_to_pwrctl(padapter);
 
 	mutex_lock(&pwrpriv->lock);
-	if ((pwrpriv->ps_deny & BIT(reason)) == 0) {
-	}
 	pwrpriv->ps_deny &= ~BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 8261b313e7d540..63553e7b67ffab 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -249,9 +249,6 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 		cnt++;
 	}
 
-	if (cnt)
-		{}
-
 	return cnt;
 }
 
@@ -2405,9 +2402,6 @@ int recv_func(struct adapter *padapter, union recv_frame *rframe)
 			DBG_COUNTER(padapter->rx_logs.core_rx_dequeue);
 			recv_func_posthandle(padapter, pending_frame);
 		}
-
-		if (cnt)
-			{}
 	}
 
 	DBG_COUNTER(padapter->rx_logs.core_rx);
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 08c54dcd7bf0c8..77325da8b13803 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -106,17 +106,11 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 {
 	int offset = (((u8 *)sta) - stapriv->pstainfo_buf)/sizeof(struct sta_info);
 
-	if (!stainfo_offset_valid(offset))
-		{}
-
 	return offset;
 }
 
 inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
 {
-	if (!stainfo_offset_valid(offset))
-		{}
-
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 114d25cdfcee7e..eeeb7044846890 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -383,9 +383,6 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 {
 	u8 center_ch, chnl_offset80 = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
-	if (padapter->bNotifyChannelChange)
-		{}
-
 	center_ch = rtw_get_center_ch(channel, bwmode, channel_offset);
 
 	if (bwmode == CHANNEL_WIDTH_80) {
@@ -626,11 +623,6 @@ static s16 _rtw_camid_search(struct adapter *adapter, u8 *addr, s16 kid)
 		break;
 	}
 
-	if (addr)
-		{}
-	else
-		{}
-
 	return cam_id;
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index f7db4cd979d761..dbb1bd47035b35 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1496,7 +1496,6 @@ static struct xmit_buf *__rtw_alloc_cmd_xmitbuf(struct xmit_priv *pxmitpriv,
 		if (pxmitbuf->sctx) {
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
-	} else {
 	}
 
 	return pxmitbuf;
@@ -1632,8 +1631,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		}
 	}
 	#ifdef DBG_XMIT_BUF
-	else
-		{}
 	#endif
 
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
@@ -2087,8 +2084,6 @@ s32 rtw_xmit(struct adapter *padapter, _pkt **ppkt)
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
 
 	if (jiffies_to_msecs(jiffies - start) > 2000) {
-		if (drop_cnt)
-			{}
 		start = jiffies;
 		drop_cnt = 0;
 	}
@@ -2711,26 +2706,9 @@ int rtw_sctx_wait(struct submit_ctx *sctx, const char *msg)
 	return ret;
 }
 
-static bool rtw_sctx_chk_warning_status(int status)
-{
-	switch (status) {
-	case RTW_SCTX_DONE_UNKNOWN:
-	case RTW_SCTX_DONE_BUF_ALLOC:
-	case RTW_SCTX_DONE_BUF_FREE:
-
-	case RTW_SCTX_DONE_DRV_STOP:
-	case RTW_SCTX_DONE_DEV_REMOVE:
-		return true;
-	default:
-		return false;
-	}
-}
-
 void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
-		if (rtw_sctx_chk_warning_status(status))
-			{}
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
@@ -2759,6 +2737,4 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
 
 	if (pxmitpriv->ack_tx)
 		rtw_sctx_done_err(&pack_tx_ops, status);
-	else
-		{}
 }
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 018705916e8770..498d8d4d042bf7 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1688,8 +1688,6 @@ void rtw_bb_rf_gain_offset(struct adapter *padapter)
 			/* res |= (padapter->eeprompriv.EEPROMRFGainVal & 0x0f)<< 15; */
 			/* rtw_hal_write_rfreg(padapter, RF_PATH_A, REG_RF_BB_GAIN_OFFSET, RF_GAIN_OFFSET_MASK, res); */
 			res = rtw_hal_read_rfreg(padapter, RF_PATH_A, 0x7f, 0xffffffff);
-		} else
-			{}
-	} else
-		{}
+		}
+	}
 }
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index e35047c47d3bfe..fd7099bab6ece7 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -88,8 +88,7 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
 		default:
 			break;
 		}
-	} else
-		{}
+	}
 
 	return value;
 }
@@ -177,8 +176,7 @@ phy_SetTxPowerByRateBase(
 		default:
 			break;
 		}
-	} else
-		{}
+	}
 }
 
 static void
@@ -774,9 +772,7 @@ void PHY_StoreTxPowerByRate(
 			pHalData->pwrGroupCnt++;
 		else if (RegAddr == rTxAGC_B_Mcs15_Mcs12 && pHalData->rf_type != RF_1T1R)
 			pHalData->pwrGroupCnt++;
-	} else
-		{}
-
+	}
 }
 
 static void
@@ -967,8 +963,7 @@ void PHY_SetTxPowerIndexByRateSection(
 					       pHalData->CurrentChannelBW,
 					       Channel, vhtRates4T,
 					       ARRAY_SIZE(vhtRates4T));
-	} else
-		{}
+	}
 }
 
 static bool phy_GetChnlIndex(u8 Channel, u8 *ChannelIdx)
@@ -1024,8 +1019,6 @@ u8 PHY_GetTxPowerIndexBase(
 			txPower = pHalData->Index24G_CCK_Base[RFPath][chnlIdx];
 		else if (MGN_6M <= Rate)
 			txPower = pHalData->Index24G_BW40_Base[RFPath][chnlIdx];
-		else
-			{}
 
 		/*  OFDM-1T */
 		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
@@ -1067,8 +1060,6 @@ u8 PHY_GetTxPowerIndexBase(
 	} else {/* 3 ============================== 5 G ============================== */
 		if (MGN_6M <= Rate)
 			txPower = pHalData->Index5G_BW40_Base[RFPath][chnlIdx];
-		else
-			{}
 
 		/*  OFDM-1T */
 		if ((MGN_6M <= Rate && Rate <= MGN_54M) && !IS_CCK_RATE(Rate)) {
@@ -1524,11 +1515,7 @@ static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Band, u8 Channel)
 			if (channel5G[i] == Channel)
 				channelIndex = i;
 		}
-	} else
-		{}
-
-	if (channelIndex == -1)
-		{}
+	}
 
 	return channelIndex;
 }
@@ -1639,9 +1626,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	idx_bandwidth = get_bandwidth_idx(bandwidth);
 	idx_rate_sctn = get_rate_sctn_idx(data_rate);
 
-	if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
-		{}
-
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
 	/*  CCK table will only be given in BW 20M */
@@ -1696,7 +1680,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 					       [idx_rate_sctn]
 					       [idx_channel]
 					       [rf_path];
-	} else {
 	}
 
 	/*  combine 5G VHT & HT rate */
@@ -1855,9 +1838,8 @@ void PHY_SetTxPowerLimit(
 	u8 regulation = 0, bandwidth = 0, rateSection = 0, channel;
 	s8 powerLimit = 0, prevPowerLimit, channelIndex;
 
-	if (!GetU1ByteIntegerFromStringInDecimal((s8 *)Channel, &channel) ||
-		 !GetU1ByteIntegerFromStringInDecimal((s8 *)PowerLimit, &powerLimit))
-		{}
+	GetU1ByteIntegerFromStringInDecimal((s8 *)Channel, &channel);
+	GetU1ByteIntegerFromStringInDecimal((s8 *)PowerLimit, &powerLimit);
 
 	powerLimit = powerLimit > MAX_POWER_INDEX ? MAX_POWER_INDEX : powerLimit;
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 1e23a99b710866..af347cd80a01b3 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -123,8 +123,8 @@ uint rtw_hal_deinit(struct adapter *padapter)
 	if (status == _SUCCESS) {
 		padapter = dvobj->padapters;
 		padapter->hw_init_completed = false;
-	} else {
 	}
+
 	return status;
 }
 
@@ -176,16 +176,12 @@ void rtw_hal_enable_interrupt(struct adapter *padapter)
 {
 	if (padapter->HalFunc.enable_interrupt)
 		padapter->HalFunc.enable_interrupt(padapter);
-	else
-		{}
 }
 
 void rtw_hal_disable_interrupt(struct adapter *padapter)
 {
 	if (padapter->HalFunc.disable_interrupt)
 		padapter->HalFunc.disable_interrupt(padapter);
-	else
-		{}
 }
 
 u8 rtw_hal_check_ips_status(struct adapter *padapter)
@@ -193,8 +189,6 @@ u8 rtw_hal_check_ips_status(struct adapter *padapter)
 	u8 val = false;
 	if (padapter->HalFunc.check_ips_status)
 		val = padapter->HalFunc.check_ips_status(padapter);
-	else
-		{}
 
 	return val;
 }
@@ -450,8 +444,6 @@ s32 rtw_hal_fill_h2c_cmd(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8
 
 	if (padapter->HalFunc.fill_h2c_cmd)
 		ret = padapter->HalFunc.fill_h2c_cmd(padapter, ElementID, CmdLen, pCmdBuffer);
-	else
-		{}
 
 	return ret;
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 4eee7eb47d9dab..c0b194c1aed610 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -996,11 +996,6 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 	u8 u1H2CPwrModeParm[H2C_PWRMODE_LEN] = {0};
 	u8 PowerState = 0, awake_intvl = 1, byte5 = 0, rlbm = 0;
 
-	if (pwrpriv->dtim > 0)
-		{}
-	else
-		{}
-
 #ifdef CONFIG_WOWLAN
 	if (psmode == PS_MODE_DTIM) { /* For WOWLAN LPS, DTIM = (awake_intvl - 1) */
 		awake_intvl = 3;/* DTIM =2 */
@@ -1084,7 +1079,6 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 			pmlmeext->bcn_cnt = 0;
 			pmlmeext->adaptive_tsf_done = true;
 
-		} else {
 		}
 
 /* offload to FW if fw version > v15.10
@@ -1930,9 +1924,7 @@ void rtl8723b_download_rsvd_page(struct adapter *padapter, u8 mstatus)
 		} while (!bcn_valid && DLBcnCount <= 100 && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
 
 		if (padapter->bSurpriseRemoved || padapter->bDriverStopped) {
-		} else if (!bcn_valid)
-			{}
-		else {
+		} else {
 			struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
 			pwrctl->fw_psmode_iface_id = padapter->iface_id;
 		}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index ace7564344d24b..406e48f9d5e928 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -33,9 +33,6 @@ static void _FWDownloadEnable(struct adapter *padapter, bool enable)
 			msleep(1);
 		} while (count++ < 100);
 
-		if (count > 0)
-			{}
-
 		/*  8051 reset */
 		tmp = rtw_read8(padapter, REG_MCUFWDL+2);
 		rtw_write8(padapter, REG_MCUFWDL+2, tmp&0xf7);
@@ -2853,8 +2850,6 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 				SCSettingOfDesc = VHT_DATA_SC_40_LOWER_OF_80MHZ;
 			else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 				SCSettingOfDesc = VHT_DATA_SC_40_UPPER_OF_80MHZ;
-			else
-				{}
 		} else {
 			if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER))
 				SCSettingOfDesc = VHT_DATA_SC_20_LOWEST_OF_80MHZ;
@@ -2864,8 +2859,6 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 				SCSettingOfDesc = VHT_DATA_SC_20_UPPER_OF_80MHZ;
 			else if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER))
 				SCSettingOfDesc = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
-			else
-				{}
 		}
 	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		if (pattrib->bwmode == CHANNEL_WIDTH_40) {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 3e3a1b80ee6ffb..e2235b0790d423 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -840,8 +840,6 @@ static void phy_SwChnlAndSetBwMode8723B(struct adapter *Adapter)
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
 	/* RT_TRACE(COMP_SCAN, DBG_LOUD, ("phy_SwChnlAndSetBwMode8723B(): bSwChnl %d, bSetChnlBW %d\n", pHalData->bSwChnl, pHalData->bSetChnlBW)); */
-	if (Adapter->bNotifyChannelChange) {
-	}
 
 	if (Adapter->bDriverStopped || Adapter->bSurpriseRemoved)
 		return;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index bcb08a9521ae95..f69a5a2664ca48 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -423,9 +423,6 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 				alignment = tmpaddr & (RECVBUFF_ALIGN_SZ-1);
 				skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 			}
-
-			if (!precvbuf->pskb) {
-			}
 		}
 
 		list_add_tail(&precvbuf->list, &precvpriv->free_recv_buf_queue.queue);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index ce8adc6e68fa7c..2373bfb7b40343 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -26,8 +26,6 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
 		HalQueryTxOQTBufferStatus8723BSdio(padapter);
 
 		if ((++n % 60) == 0) {
-			if ((n % 300) == 0) {
-			}
 			msleep(1);
 			/* yield(); */
 		}
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index fbe4ec27cc2fce..9779a0ff34a883 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1077,7 +1077,6 @@ static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
 						cnt++;
 						mdelay(10);
 					} while (cnt < 100 && (val8 != 0xEA));
-				} else {
 				}
 
 				adapter_to_pwrctl(padapter)->pre_ips_type = 0;
@@ -1249,9 +1248,6 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 	/*  This part read and parse the eeprom/efuse content */
 	/*  */
 
-	if (sizeof(pEEPROM->efuse_eeprom_data) < HWSET_MAX_SIZE_8723B)
-		{}
-
 	hwinfo = pEEPROM->efuse_eeprom_data;
 
 	Hal_InitPGData(padapter, hwinfo);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index ab266c3020303f..7dbb2a6ac09331 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -985,8 +985,7 @@ void sd_int_dpc(struct adapter *adapter)
 			}
 		} else {
 			/* Error handling for malloc fail */
-			if (rtw_cbuf_push(adapter->evtpriv.c2h_queue, NULL) != _SUCCESS)
-				{}
+			rtw_cbuf_push(adapter->evtpriv.c2h_queue, NULL);
 			_set_workitem(&adapter->evtpriv.c2h_wk);
 		}
 	}
@@ -1025,10 +1024,6 @@ void sd_int_dpc(struct adapter *adapter)
 			if (!hisr)
 				break;
 		} while (1);
-
-		if (alloc_fail_time == 10)
-			{}
-
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 53a3a74782311f..64f4d1c16a934a 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -277,13 +277,9 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 			{
 				DBG_8192C("ssid =%s, len =%d\n", pssid->Ssid, pssid->SsidLength);
 
-				if (ssids[0].ssid_len == 0) {
-				}
-				else if (pssid->SsidLength == ssids[0].ssid_len &&
-					!memcmp(pssid->Ssid, ssids[0].ssid, ssids[0].ssid_len))
-				{
-				}
-				else
+				if (ssids[0].ssid_len != 0 &&
+				    (pssid->SsidLength != ssids[0].ssid_len ||
+				     memcmp(pssid->Ssid, ssids[0].ssid, ssids[0].ssid_len)))
 				{
 					if (psr != NULL)
 						*psr = 0; /* clear sr */
@@ -408,10 +404,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 		{
 
 			memcpy(&cur_network->network, pnetwork, sizeof(struct wlan_bssid_ex));
-			if (!rtw_cfg80211_inform_bss(padapter, cur_network))
-				{}
-			else
-				{}
+			rtw_cfg80211_inform_bss(padapter, cur_network);
 		}
 		else
 		{
@@ -422,9 +415,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 			if (!memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
 				&& !memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
 			) {
-				if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
-				} else {
-				}
+				rtw_cfg80211_inform_bss(padapter, scanned);
 			} else {
 				rtw_warn_on(1);
 			}
@@ -465,9 +456,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		if (!memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
 			&& !memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
 		) {
-			if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
-			} else {
-			}
+			rtw_cfg80211_inform_bss(padapter, scanned);
 		} else {
 			rtw_warn_on(1);
 		}
@@ -2413,10 +2402,6 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 
 		DBG_8192C("RTW_Tx:da ="MAC_FMT" via "FUNC_NDEV_FMT"\n",
 			MAC_ARG(GetAddr1Ptr(buf)), FUNC_NDEV_ARG(ndev));
-		if (category == RTW_WLAN_CATEGORY_PUBLIC)
-			{}
-		else
-			{}
 
 		/* starting alloc mgmt frame to dump it */
 		if ((pmgntframe = alloc_mgtxmitframe(pxmitpriv)) == NULL)
@@ -2848,10 +2833,6 @@ void rtw_cfg80211_rx_action(struct adapter *adapter, u8 *frame, uint frame_len,
 	rtw_action_frame_parse(frame, frame_len, &category, &action);
 
 	DBG_8192C("RTW_Rx:cur_ch =%d\n", channel);
-	if (msg)
-		{}
-	else
-		{}
 
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
 
@@ -2980,10 +2961,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	}
 
 	DBG_8192C("RTW_Tx:tx_ch =%d, da ="MAC_FMT"\n", tx_ch, MAC_ARG(GetAddr1Ptr(buf)));
-	if (category == RTW_WLAN_CATEGORY_PUBLIC)
-		{}
-	else
-		{}
 
 	rtw_ps_deny(padapter, PS_DENY_MGNT_TX);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
@@ -2996,9 +2973,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 		tx_ret = _cfg80211_rtw_mgmt_tx(padapter, tx_ch, buf, len);
 	} while (dump_cnt < dump_limit && tx_ret != _SUCCESS);
 
-	if (tx_ret != _SUCCESS || dump_cnt > 1) {
-	}
-
 	switch (type) {
 	case P2P_GO_NEGO_CONF:
 		rtw_clear_scan_deny(padapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index a6f4b9149d1605..67429033886b58 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -400,7 +400,6 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		}
-	} else if (value & WLAN_AUTH_LEAP) {
 	} else {
 		ret = -EINVAL;
 	}
@@ -1282,7 +1281,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 
 			spin_unlock_bh(&pmlmepriv->lock);
 
-		} else if (req->scan_type == IW_SCAN_TYPE_PASSIVE) {
 		}
 
 	} else if (wrqu->data.length >= WEXT_CSCAN_HEADER_SIZE
@@ -1480,9 +1478,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	if (wrqu->essid.flags && wrqu->essid.length) {
 		len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ? wrqu->essid.length : IW_ESSID_MAX_SIZE;
 
-		if (wrqu->essid.length != 33)
-			{}
-
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
 		ndis_ssid.SsidLength = len;
 		memcpy(ndis_ssid.Ssid, extra, len);
@@ -2294,9 +2289,7 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 channel_plan_req = (u8)(*((int *)wrqu));
 
-	if (_SUCCESS == rtw_set_chplan_cmd(padapter, channel_plan_req, 1, 1))
-		{}
-	 else
+	if (_SUCCESS != rtw_set_chplan_cmd(padapter, channel_plan_req, 1, 1))
 		return -EPERM;
 
 	return 0;
@@ -2450,8 +2443,6 @@ static int rtw_set_pid(struct net_device *dev,
 	if (selector < 3 && selector >= 0) {
 		padapter->pid[selector] = *(pdata+1);
 	}
-	else
-		{}
 
 exit:
 
@@ -2675,11 +2666,8 @@ static int rtw_dbg_port(struct net_device *dev,
 
 						for (i = 0; i < 16; i++) {
 							preorder_ctrl = &psta->recvreorder_ctrl[i];
-							if (preorder_ctrl->enable)
-								{}
 						}
 
-					} else {
 					}
 					break;
 				case 0x06:
@@ -2716,8 +2704,6 @@ static int rtw_dbg_port(struct net_device *dev,
 								if (extra_arg == psta->aid) {
 									for (j = 0; j < 16; j++) {
 										preorder_ctrl = &psta->recvreorder_ctrl[j];
-										if (preorder_ctrl->enable)
-											{}
 									}
 								}
 							}
@@ -2785,9 +2771,7 @@ static int rtw_dbg_port(struct net_device *dev,
 					/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
 					if (extra_arg == 0 || extra_arg == 1 || extra_arg == 2 || extra_arg == 3) {
 						pregpriv->rx_stbc = extra_arg;
-					} else
-						{}
-
+					}
 				}
 				break;
 				case 0x13: /* set ampdu_enable */
@@ -2796,9 +2780,7 @@ static int rtw_dbg_port(struct net_device *dev,
 					/*  0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
 					if (extra_arg < 3) {
 						pregpriv->ampdu_enable = extra_arg;
-					} else
-						{}
-
+					}
 				}
 				break;
 				case 0x14:
@@ -3587,11 +3569,8 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 
 		psta = NULL;
 
-	} else {
-		/* ret = -1; */
 	}
 
-
 	return ret;
 
 }
@@ -3687,7 +3666,6 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 			param->u.wpa_ie.len = copy_len;
 
 			memcpy(param->u.wpa_ie.reserved, psta->wpa_ie, copy_len);
-		} else {
 		}
 	} else {
 		ret = -1;
@@ -3826,16 +3804,10 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 		memcpy(ssid, ssid_ie+2, ssid_len);
 		ssid[ssid_len] = 0x0;
 
-		if (0)
-			{}
-
 		memcpy(pbss_network->Ssid.Ssid, (void *)ssid, ssid_len);
 		pbss_network->Ssid.SsidLength = ssid_len;
 		memcpy(pbss_network_ext->Ssid.Ssid, (void *)ssid, ssid_len);
 		pbss_network_ext->Ssid.SsidLength = ssid_len;
-
-		if (0)
-			{}
 	}
 
 	return ret;
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index a83d6129c82e03..2086378802ac3a 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1678,8 +1678,6 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 
 	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		rtw_ap_restore_network(padapter);
-	} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-	} else {
 	}
 
 exit:
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 827ce3013acbf9..6ece6daee499fc 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -52,8 +52,6 @@ u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	v = sdio_f0_readb(func, addr, err);
 	if (claim_needed)
 		sdio_release_host(func);
-	if (err && *err)
-		{}
 	return v;
 }
 
@@ -217,8 +215,6 @@ u8 sd_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	v = sdio_readb(func, addr, err);
 	if (claim_needed)
 		sdio_release_host(func);
-	if (err && *err)
-		{}
 	return v;
 }
 
@@ -272,12 +268,6 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 				}
 			}
 		}
-
-		if (i == SD_IO_TRY_CNT)
-			{}
-		else
-			{}
-
 	}
 	return  v;
 }
@@ -306,8 +296,6 @@ void sd_write8(struct intf_hdl *pintfhdl, u32 addr, u8 v, s32 *err)
 	sdio_writeb(func, v, addr, err);
 	if (claim_needed)
 		sdio_release_host(func);
-	if (err && *err)
-		{}
 }
 
 void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
@@ -359,10 +347,6 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 			}
 		}
 
-		if (i == SD_IO_TRY_CNT)
-			{}
-		else
-			{}
 	}
 }
 
@@ -415,8 +399,6 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	}
 
 	err = sdio_memcpy_fromio(func, pdata, addr, cnt);
-	if (err)
-		{}
 
 	return err;
 }
@@ -514,8 +496,6 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 
 	size = cnt;
 	err = sdio_memcpy_toio(func, addr, pdata, size);
-	if (err)
-		{}
 
 	return err;
 }
-- 
2.53.0

