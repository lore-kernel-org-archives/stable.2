Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62A367B9C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072056; cv=none; b=EkyOvBhQAt1gD6osNaM4pIjEk8tURYPMj2wMnvXhvWbOdAEpRgAAo5z/0NXHxy1kGB6FWbJlcOK5K8jurlljwP4k99zjZ+r19JaQBNaSqBKaY4fF3bS5HWLpsRXiruBthZ4Ua7zVKEKAhBsl7wD4hE16uQ3vrCSvKTk2UsyFZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072056; c=relaxed/simple;
	bh=5Oul+syQ21GCvHb4JqceHNzZ1qBeUbapzpgSODI3f+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTXaA2Xbm/WNQWlvmrRFPBMO4nSI9bN/LGOYVX7B0fbOukAY+PfYOCjhb4y0Se/N1i8g5F31yvKU3Bn789tKGzNpvPUzZqfD+4jpHUv1ya3NBwr1QVwzGAar5/XCwy3fZeBIlwTtqIS9ynn022Sv9phsFJk9GhJy5UY9HZXy9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEzfkbbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEzfkbbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948EC1F000E9;
	Tue, 14 Jul 2026 23:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072054;
	bh=LkniOhkRSLuIg4In7Z30ArjRn+qYGd5m1FIGU5py+eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oEzfkbbusIQjbD/uuT4BeoZjSNJ0AJ8v2eSqlcMGpkWVp/0ulUBrgsB1qKlK1H8ix
	 3Bvu0cY91y4UpER9s7f2BPGIY3hwdjp0sj8N1XYYm0G6yiOExmLrVDw1gsBCa+bJKP
	 lrid1kO/DJWw6NCldfrVTWznPlB2fnc+a+RH/igF4iIzsmfjTcKKQzuu4irdARgEi2
	 hTbzZr2GdkfwiqPjgb+XoV4McIew+fP+0gKh+/thzsNEP7SvInGl1W5TJMNzTZZeLl
	 39svpHZR3gJQHH0l5I0jmqAm6nhIKPyUr4rLqfxwvNgJQFBErX2+uEMLfD9iQJUJjy
	 lH217jPhIaZtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Straube <straube.linux@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 7/8] staging: rtl8723bs: clean up comparsions to NULL
Date: Tue, 14 Jul 2026 19:34:06 -0400
Message-ID: <20260714233407.3591885-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714233407.3591885-1-sashal@kernel.org>
References: <2026071352-wreckage-humorless-3481@gregkh>
 <20260714233407.3591885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Straube <straube.linux@gmail.com>

[ Upstream commit cd1f1450092216b3e39516f8db58869b6fc20575 ]

Clean up comparsions to NULL reported by checkpatch.

x == NULL -> !x
x != NULL -> x

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Link: https://lore.kernel.org/r/20210829154533.11054-1-straube.linux@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a1fc19d61f66 ("staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 20 ++--
 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 96 +++++++++----------
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  4 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  6 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 56 +++++------
 drivers/staging/rtl8723bs/core/rtw_security.c |  6 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 24 ++---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 18 ++--
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  4 +-
 9 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 08317df2c4f306..215672c39d2e36 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1033,7 +1033,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		&ie_len,
 		(pbss_network->IELength - _BEACON_IE_OFFSET_)
 	);
-	if (p !=  NULL) {
+	if (p) {
 		memcpy(supportRate, p + 2, ie_len);
 		supportRateNum = ie_len;
 	}
@@ -1045,7 +1045,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		&ie_len,
 		pbss_network->IELength - _BEACON_IE_OFFSET_
 	);
-	if (p !=  NULL) {
+	if (p) {
 		memcpy(supportRate + supportRateNum, p + 2, ie_len);
 		supportRateNum += ie_len;
 	}
@@ -1133,7 +1133,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 			break;
 		}
 
-		if ((p == NULL) || (ie_len == 0))
+		if (!p || ie_len == 0)
 				break;
 	}
 
@@ -1162,7 +1162,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 				break;
 			}
 
-			if ((p == NULL) || (ie_len == 0))
+			if (!p || ie_len == 0)
 				break;
 		}
 	}
@@ -1290,7 +1290,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->MacAddress);
 	if (!psta) {
 		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->MacAddress);
-		if (psta == NULL)
+		if (!psta)
 			return _FAIL;
 	}
 
@@ -1447,7 +1447,7 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 	}
 
 	psetstakey_para = rtw_zmalloc(sizeof(struct set_stakey_parm));
-	if (psetstakey_para == NULL) {
+	if (!psetstakey_para) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1485,12 +1485,12 @@ static int rtw_ap_set_key(
 	/* DBG_871X("%s\n", __func__); */
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
-	if (psetkeyparm == NULL) {
+	if (!psetkeyparm) {
 		kfree(pcmd);
 		res = _FAIL;
 		goto exit;
@@ -1662,11 +1662,11 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 		&wps_ielen
 	);
 
-	if (pwps_ie == NULL || wps_ielen == 0)
+	if (!pwps_ie || wps_ielen == 0)
 		return;
 
 	pwps_ie_src = pmlmepriv->wps_beacon_ie;
-	if (pwps_ie_src == NULL)
+	if (!pwps_ie_src)
 		return;
 
 	wps_offset = (uint)(pwps_ie - ie);
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index cee05385f87279..0af22e013db369 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -259,7 +259,7 @@ int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 {
 	_irqL irqL;
 
-	if (obj == NULL)
+	if (!obj)
 		goto exit;
 
 	/* spin_lock_bh(&queue->lock); */
@@ -335,7 +335,7 @@ int rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	int res = _FAIL;
 	struct adapter *padapter = pcmdpriv->padapter;
 
-	if (cmd_obj == NULL) {
+	if (!cmd_obj) {
 		goto exit;
 	}
 
@@ -509,7 +509,7 @@ int rtw_cmd_thread(void *context)
 		/* call callback function for post-processed */
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
-			if (pcmd_callback == NULL) {
+			if (!pcmd_callback) {
 				RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n", pcmd_callback, pcmd->cmdcode));
 				rtw_free_cmd_obj(pcmd);
 			} else {
@@ -530,7 +530,7 @@ int rtw_cmd_thread(void *context)
 	/*  free all cmd_obj resources */
 	do {
 		pcmd = rtw_dequeue_cmd(pcmdpriv);
-		if (pcmd == NULL) {
+		if (!pcmd) {
 			rtw_unregister_cmd_alive(padapter);
 			break;
 		}
@@ -572,11 +572,11 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	}
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL)
+	if (!ph2c)
 		return _FAIL;
 
 	psurveyPara = rtw_zmalloc(sizeof(struct sitesurvey_parm));
-	if (psurveyPara == NULL) {
+	if (!psurveyPara) {
 		kfree(ph2c);
 		return _FAIL;
 	}
@@ -640,13 +640,13 @@ u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pbsetdataratepara = rtw_zmalloc(sizeof(struct setdatarate_parm));
-	if (pbsetdataratepara == NULL) {
+	if (!pbsetdataratepara) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -683,7 +683,7 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 	}
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -716,7 +716,7 @@ int rtw_startbss_cmd(struct adapter  *padapter, int flags)
 	} else {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (pcmd == NULL) {
+		if (!pcmd) {
 			res = _FAIL;
 			goto exit;
 		}
@@ -774,7 +774,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	}
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd: memory allocate for cmd_obj fail!!!\n"));
 		goto exit;
@@ -891,7 +891,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 
 	/* prepare cmd parameter */
 	param = rtw_zmalloc(sizeof(*param));
-	if (param == NULL) {
+	if (!param) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -900,7 +900,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	if (enqueue) {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		cmdobj = rtw_zmalloc(sizeof(*cmdobj));
-		if (cmdobj == NULL) {
+		if (!cmdobj) {
 			res = _FAIL;
 			kfree(param);
 			goto exit;
@@ -928,7 +928,7 @@ u8 rtw_setopmode_cmd(struct adapter  *padapter, enum NDIS_802_11_NETWORK_INFRAST
 
 	psetop = rtw_zmalloc(sizeof(struct setopmode_parm));
 
-	if (psetop == NULL) {
+	if (!psetop) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -936,7 +936,7 @@ u8 rtw_setopmode_cmd(struct adapter  *padapter, enum NDIS_802_11_NETWORK_INFRAST
 
 	if (enqueue) {
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			kfree(psetop);
 			res = _FAIL;
 			goto exit;
@@ -964,7 +964,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 	u8 res = _SUCCESS;
 
 	psetstakey_para = rtw_zmalloc(sizeof(struct set_stakey_parm));
-	if (psetstakey_para == NULL) {
+	if (!psetstakey_para) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -988,14 +988,14 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 
 	if (enqueue) {
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			kfree(psetstakey_para);
 			res = _FAIL;
 			goto exit;
 		}
 
 		psetstakey_rsp = rtw_zmalloc(sizeof(struct set_stakey_rsp));
-		if (psetstakey_rsp == NULL) {
+		if (!psetstakey_rsp) {
 			kfree(ph2c);
 			kfree(psetstakey_para);
 			res = _FAIL;
@@ -1031,20 +1031,20 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 enqueu
 		}
 	} else {
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			res = _FAIL;
 			goto exit;
 		}
 
 		psetstakey_para = rtw_zmalloc(sizeof(struct set_stakey_parm));
-		if (psetstakey_para == NULL) {
+		if (!psetstakey_para) {
 			kfree(ph2c);
 			res = _FAIL;
 			goto exit;
 		}
 
 		psetstakey_rsp = rtw_zmalloc(sizeof(struct set_stakey_rsp));
-		if (psetstakey_rsp == NULL) {
+		if (!psetstakey_rsp) {
 			kfree(ph2c);
 			kfree(psetstakey_para);
 			res = _FAIL;
@@ -1076,13 +1076,13 @@ u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	paddbareq_parm = rtw_zmalloc(sizeof(struct addBaReq_parm));
-	if (paddbareq_parm == NULL) {
+	if (!paddbareq_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1110,13 +1110,13 @@ u8 rtw_reset_securitypriv_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1145,13 +1145,13 @@ u8 rtw_free_assoc_resources_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1181,13 +1181,13 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *padapter)
 
 	/* only  primary padapter does this cmd */
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1231,7 +1231,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
 
 	/* prepare cmd parameter */
 	setChannelPlan_param = rtw_zmalloc(sizeof(struct SetChannelPlan_param));
-	if (setChannelPlan_param == NULL) {
+	if (!setChannelPlan_param) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -1240,7 +1240,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
 	if (enqueue) {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		pcmdobj = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (pcmdobj == NULL) {
+		if (!pcmdobj) {
 			kfree(setChannelPlan_param);
 			res = _FAIL;
 			goto exit;
@@ -1501,13 +1501,13 @@ u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue)
 
 	if (enqueue) {
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			res = _FAIL;
 			goto exit;
 		}
 
 		pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-		if (pdrvextra_cmd_parm == NULL) {
+		if (!pdrvextra_cmd_parm) {
 			kfree(ph2c);
 			res = _FAIL;
 			goto exit;
@@ -1543,13 +1543,13 @@ u8 rtw_dm_in_lps_wk_cmd(struct adapter *padapter)
 
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1616,13 +1616,13 @@ u8 rtw_dm_ra_mask_wk_cmd(struct adapter *padapter, u8 *psta)
 
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1651,13 +1651,13 @@ u8 rtw_ps_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ppscmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ppscmd == NULL) {
+	if (!ppscmd) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ppscmd);
 		res = _FAIL;
 		goto exit;
@@ -1723,13 +1723,13 @@ u8 rtw_chk_hi_queue_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1817,13 +1817,13 @@ u8 rtw_c2h_packet_wk_cmd(struct adapter *padapter, u8 *pbuf, u16 length)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1852,13 +1852,13 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -2036,7 +2036,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)pcmd->parmbuf;
 	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
 
-	if (pcmd->parmbuf == NULL)
+	if (!pcmd->parmbuf)
 		goto exit;
 
 	if ((pcmd->res != H2C_SUCCESS)) {
@@ -2063,9 +2063,9 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	} else {
 		pwlan = rtw_alloc_network(pmlmepriv);
 		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
-		if (pwlan == NULL) {
+		if (!pwlan) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
-			if (pwlan == NULL) {
+			if (!pwlan) {
 				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n Error:  can't get pwlan in rtw_joinbss_event_callback\n"));
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto createbss_cmd_fail;
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 8b5f6a66bfb8df..ac19a1e3a07f44 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -508,7 +508,7 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("+rtw_set_802_11_bssid_list_scan(), fw_state =%x\n", get_fwstate(pmlmepriv)));
 
-	if (padapter == NULL) {
+	if (!padapter) {
 		res = false;
 		goto exit;
 	}
@@ -649,7 +649,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 		return 0;
 
 	psta = rtw_get_stainfo(&adapter->stapriv, get_bssid(pmlmepriv));
-	if (psta == NULL)
+	if (!psta)
 		return 0;
 
 	short_GI = query_ra_short_GI(psta);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 71be5dc0216c20..3517a5a4c492f6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -472,7 +472,7 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 		pwlan = LIST_CONTAINOR(plist, struct wlan_network, list);
 
 		if (!pwlan->fixed) {
-			if (oldest == NULL || time_after(oldest->last_scanned, pwlan->last_scanned))
+			if (!oldest || time_after(oldest->last_scanned, pwlan->last_scanned))
 				oldest = pwlan;
 		}
 
@@ -603,7 +603,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			/* TODO: don't  select netowrk in the same ess as oldest if it's new enough*/
 		}
 
-		if (oldest == NULL || time_after(oldest->last_scanned, pnetwork->last_scanned))
+		if (!oldest || time_after(oldest->last_scanned, pnetwork->last_scanned))
 			oldest = pnetwork;
 
 		plist = get_next(plist);
@@ -2023,7 +2023,7 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 			goto exit;
 	}
 
-	if (*candidate == NULL || (*candidate)->network.Rssi < competitor->network.Rssi) {
+	if (!*candidate || (*candidate)->network.Rssi < competitor->network.Rssi) {
 		*candidate = competitor;
 		updated = true;
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 2742c7da75a6cd..bd32f60152ab0b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -934,12 +934,12 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	}
 
 	pstat = rtw_get_stainfo(pstapriv, sa);
-	if (pstat == NULL) {
+	if (!pstat) {
 
 		/*  allocate a new one */
 		DBG_871X("going to alloc stainfo for sa ="MAC_FMT"\n",  MAC_ARG(sa));
 		pstat = rtw_alloc_stainfo(pstapriv, sa);
-		if (pstat == NULL) {
+		if (!pstat) {
 			DBG_871X(" Exceed the upper limit of supported clients...\n");
 			status = _STATS_UNABLE_HANDLE_STA_;
 			goto auth_fail;
@@ -1014,7 +1014,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
-			if ((p == NULL) || (ie_len <= 0)) {
+			if (!p || ie_len <= 0) {
 				DBG_871X("auth rejected because challenge failure!(1)\n");
 				status = _STATS_CHALLENGE_FAIL_;
 				goto auth_fail;
@@ -1255,7 +1255,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 	/*  check if the supported rate is ok */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SUPPORTEDRATES_IE_, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-	if (p == NULL) {
+	if (!p) {
 		DBG_871X("Rx a sta assoc-req which supported rate is empty!\n");
 		/*  use our own rate set as statoin used */
 		/* memcpy(supportRate, AP_BSSRATE, AP_BSSRATE_LEN); */
@@ -1272,7 +1272,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 		p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _EXT_SUPPORTEDRATES_IE_, &ie_len,
 				pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-		if (p !=  NULL) {
+		if (p) {
 
 			if (supportRateNum + ie_len <= sizeof(supportRate)) {
 				memcpy(supportRate+supportRateNum, p+2, ie_len);
@@ -1538,7 +1538,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		DBG_871X("  old AID %d\n", pstat->aid);
 	} else {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
-			if (pstapriv->sta_aid[pstat->aid - 1] == NULL)
+			if (!pstapriv->sta_aid[pstat->aid - 1])
 				break;
 
 		/* if (pstat->aid > NUM_STA) { */
@@ -2226,7 +2226,7 @@ static struct xmit_frame *_alloc_mgtxmitframe(struct xmit_priv *pxmitpriv, bool
 	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
-	if (pxmitbuf == NULL) {
+	if (!pxmitbuf) {
 		DBG_871X(FUNC_ADPT_FMT" alloc xmitbuf fail\n", FUNC_ADPT_ARG(pxmitpriv->adapter));
 		rtw_free_xmitframe(pxmitpriv, pmgntframe);
 		pmgntframe = NULL;
@@ -2596,7 +2596,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 	/* DBG_871X("%s\n", __func__); */
 
-	if (da == NULL)
+	if (!da)
 		return;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -2961,7 +2961,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	__le16 le_tmp;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -3097,7 +3097,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	DBG_871X("%s\n", __func__);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -3185,7 +3185,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 				break;
 			}
 
-			if ((pbuf == NULL) || (ie_len == 0)) {
+			if (!pbuf || ie_len == 0) {
 				break;
 			}
 		}
@@ -3229,7 +3229,7 @@ void issue_assocreq(struct adapter *padapter)
 	u8 vs_ie_length = 0;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -3420,7 +3420,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da,
 	pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -3573,7 +3573,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	DBG_871X("%s\n", __func__);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -3698,7 +3698,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 	/* DBG_871X("%s to "MAC_FMT"\n", __func__, MAC_ARG(da)); */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (!pmgntframe) {
 		goto exit;
 	}
 
@@ -4047,7 +4047,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	action = ACT_PUBLIC_BSSCOEXIST;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (!pmgntframe) {
 		return;
 	}
 
@@ -4114,7 +4114,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 			pbss_network = (struct wlan_bssid_ex *)&pnetwork->network;
 
 			p = rtw_get_ie(pbss_network->IEs + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pbss_network->IELength - _FIXED_IE_LENGTH_);
-			if ((p == NULL) || (len == 0)) {/* non-HT */
+			if (!p || len == 0) {/* non-HT */
 
 				if (pbss_network->Configuration.DSConfig <= 0)
 					continue;
@@ -4177,7 +4177,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 			return _SUCCESS;
 
 	psta = rtw_get_stainfo(pstapriv, addr);
-	if (psta == NULL)
+	if (!psta)
 		return _SUCCESS;
 
 	/* DBG_871X("%s:%s\n", __func__, (initiator == 0)?"RX_DIR":"TX_DIR"); */
@@ -5153,13 +5153,13 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL) {
+	if (!pcmd_obj) {
 		return;
 	}
 
 	cmdsz = (sizeof(struct stadel_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -5207,12 +5207,12 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct stassoc_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -5732,12 +5732,12 @@ void survey_timer_hdl(struct timer_list *t)
 		}
 
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			goto exit_survey_timer_hdl;
 		}
 
 		psurveyPara = rtw_zmalloc(sizeof(struct sitesurvey_parm));
-		if (psurveyPara == NULL) {
+		if (!psurveyPara) {
 			kfree(ph2c);
 			goto exit_survey_timer_hdl;
 		}
@@ -6467,7 +6467,7 @@ u8 chk_bmc_sleepq_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -6491,13 +6491,13 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	int len_diff = 0;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	ptxBeacon_parm = rtw_zmalloc(sizeof(struct Tx_Beacon_param));
-	if (ptxBeacon_parm == NULL) {
+	if (!ptxBeacon_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -6529,7 +6529,7 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	void (*event_callback)(struct adapter *dev, u8 *pbuf);
 	struct evt_priv *pevt_priv = &(padapter->evtpriv);
 
-	if (pbuf == NULL)
+	if (!pbuf)
 		goto _abort_event_;
 
 	peventbuf = (uint *)pbuf;
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index bf15902b3cef21..b4359f3af8e37c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -226,7 +226,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	struct	security_priv *psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv 	*pxmitpriv = &padapter->xmitpriv;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (!((struct xmit_frame *)pxmitframe)->buf_addr)
 		return;
 
 	hw_hdr_offset = TXDESC_OFFSET;
@@ -669,7 +669,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	struct	xmit_priv 	*pxmitpriv = &padapter->xmitpriv;
 	u32 res = _SUCCESS;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (!((struct xmit_frame *)pxmitframe)->buf_addr)
 		return _FAIL;
 
 	hw_hdr_offset = TXDESC_OFFSET;
@@ -1489,7 +1489,7 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 	u32 res = _SUCCESS;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (!((struct xmit_frame *)pxmitframe)->buf_addr)
 		return _FAIL;
 
 	hw_hdr_offset = TXDESC_OFFSET;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 65bb060b0958fd..577320aaf18afd 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -418,7 +418,7 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 		}
 		else
 		{
-			if (scanned == NULL) {
+			if (!scanned) {
 				rtw_warn_on(1);
 				return;
 			}
@@ -466,7 +466,7 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 
 		/* DBG_871X(FUNC_ADPT_FMT" BSS not found\n", FUNC_ADPT_ARG(padapter)); */
 
-		if (scanned == NULL) {
+		if (!scanned) {
 			rtw_warn_on(1);
 			goto check_bss;
 		}
@@ -597,7 +597,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 		}
 	}
 
-	if (strcmp(param->u.crypt.alg, "none") == 0 && (psta == NULL))
+	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta)
 	{
 		/* todo:clear default encryption keys */
 
@@ -607,7 +607,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 	}
 
 
-	if (strcmp(param->u.crypt.alg, "WEP") == 0 && (psta == NULL))
+	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta)
 	{
 		DBG_8192C("r871x_set_encryption, crypt.alg = WEP\n");
 
@@ -1001,7 +1001,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 			}
 
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (pbcmc_sta == NULL)
+			if (!pbcmc_sta)
 			{
 				/* DEBUG_ERR(("Set OID_802_11_ADD_KEY: bcmc stainfo is null\n")); */
 			}
@@ -1050,7 +1050,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 
 	param_len = sizeof(struct ieee_param) + params->key_len;
 	param = rtw_malloc(param_len);
-	if (param == NULL)
+	if (!param)
 		return -1;
 
 	memset(param, 0, param_len);
@@ -1214,7 +1214,7 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	}
 
 	psta = rtw_get_stainfo(pstapriv, (u8 *)mac);
-	if (psta == NULL) {
+	if (!psta) {
 		DBG_8192C("%s, sta_info is null\n", __func__);
 		ret = -ENOENT;
 		goto exit;
@@ -1495,7 +1495,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	struct rtw_wdev_priv *pwdev_priv;
 	struct mlme_priv *pmlmepriv;
 
-	if (ndev == NULL) {
+	if (!ndev) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -1783,7 +1783,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	u8 *pwpa, *pwpa2;
 	u8 null_addr[] = {0, 0, 0, 0, 0, 0};
 
-	if (pie == NULL || !ielen) {
+	if (!pie || !ielen) {
 		/* Treat this as normal case, but need to clear WIFI_UNDER_WPS */
 		_clr_fwstate_(&padapter->mlmepriv, WIFI_UNDER_WPS);
 		goto exit;
@@ -1795,7 +1795,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	}
 
 	buf = rtw_zmalloc(ielen);
-	if (buf == NULL) {
+	if (!buf) {
 		ret =  -ENOMEM;
 		goto exit;
 	}
@@ -2138,7 +2138,7 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = rtw_malloc(wep_total_len);
-			if (pwep == NULL) {
+			if (!pwep) {
 				DBG_871X(" wpa_set_encryption: pwep allocate fail !!!\n");
 				ret = -ENOMEM;
 				goto exit;
@@ -3073,7 +3073,7 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	struct adapter *padapter;
 	struct rtw_wdev_priv *pwdev_priv;
 
-	if (ndev == NULL) {
+	if (!ndev) {
 		ret = -EINVAL;
 		goto exit;
 	}
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index f7908b6ba16e18..8107ee03b9642e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -519,7 +519,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE) == true) { /* sta mode */
 			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
-			if (psta == NULL) {
+			if (!psta) {
 				/* DEBUG_ERR(("Set wpa_set_encryption: Obtain Sta_info fail\n")); */
 			} else {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
@@ -578,7 +578,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			}
 
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (pbcmc_sta == NULL) {
+			if (!pbcmc_sta) {
 				/* DEBUG_ERR(("Set OID_802_11_ADD_KEY: bcmc stainfo is null\n")); */
 			} else {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
@@ -608,9 +608,9 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 	int ret = 0;
 	u8 null_addr[] = {0, 0, 0, 0, 0, 0};
 
-	if ((ielen > MAX_WPA_IE_LEN) || (pie == NULL)) {
+	if (ielen > MAX_WPA_IE_LEN || !pie) {
 		_clr_fwstate_(&padapter->mlmepriv, WIFI_UNDER_WPS);
-		if (pie == NULL)
+		if (!pie)
 			return ret;
 		else
 			return -EINVAL;
@@ -618,7 +618,7 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 
 	if (ielen) {
 		buf = rtw_zmalloc(ielen);
-		if (buf == NULL) {
+		if (!buf) {
 			ret =  -ENOMEM;
 			goto exit;
 		}
@@ -3366,7 +3366,7 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 		return -EINVAL;
 
 	param = rtw_malloc(p->length);
-	if (param == NULL)
+	if (!param)
 		return -ENOMEM;
 
 	if (copy_from_user(param, p->pointer, p->length)) {
@@ -3448,7 +3448,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		}
 	}
 
-	if (strcmp(param->u.crypt.alg, "none") == 0 && (psta == NULL)) {
+	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta) {
 		/* todo:clear default encryption keys */
 
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
@@ -3462,7 +3462,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 
-	if (strcmp(param->u.crypt.alg, "WEP") == 0 && (psta == NULL)) {
+	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta) {
 		DBG_871X("r871x_set_encryption, crypt.alg = WEP\n");
 
 		wep_key_idx = param->u.crypt.idx;
@@ -4187,7 +4187,7 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 		return -EINVAL;
 
 	param = rtw_malloc(p->length);
-	if (param == NULL)
+	if (!param)
 		return -ENOMEM;
 
 	if (copy_from_user(param, p->pointer, p->length)) {
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index a7c4ad1c7cb986..b75377b6c57f40 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -525,7 +525,7 @@ void rtw_unregister_netdevs(struct dvobj_priv *dvobj)
 
 	padapter = dvobj->padapters;
 
-	if (padapter == NULL)
+	if (!padapter)
 		return;
 
 	pnetdev = padapter->pnetdev;
@@ -638,7 +638,7 @@ struct dvobj_priv *devobj_init(void)
 	struct dvobj_priv *pdvobj = NULL;
 
 	pdvobj = rtw_zmalloc(sizeof(*pdvobj));
-	if (pdvobj == NULL)
+	if (!pdvobj)
 		return NULL;
 
 	mutex_init(&pdvobj->hw_init_mutex);
-- 
2.53.0

