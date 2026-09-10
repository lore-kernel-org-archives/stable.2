Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E445FFD8
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038550; cv=none; b=Eul6eL1h77SKYvePWzVwQkM4f8M4pQjpKyDVSamu9GQtxru3pPAMqmwaotkRkAPCg7y0HlbDy+A3i/ouiaGvKrxuOyFjiwrej2Dz60lxB7ZdstsI6vWxtGa4uwjjeJKUe5ul0cqC7+0Za4Lq3BWLfm2vF88iO6KDQXIEPdqvASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038550; c=relaxed/simple;
	bh=Z39hF2YJI+6fr4z6/g3vP2xCz99TS4bBcxE8JMsHkXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8z5tbuXpZg5/1UqO7ua+BUruO3C7LVmuCfpx50uILpiWlZamj4gaydUZ4zY63pnv9wUUYpl2tGAVW7LMDHTvzXt5A7NSEeD3SUKiw09nuF9e9ovmKPC/BsQGahCWFNMFgtM0AKdHK1Ob3YfnscklHrivGQvtu9x1BSylsHt9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKriudtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKriudtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E225B1F000FF;
	Thu, 10 Sep 2026 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038548;
	bh=LCpuDJEejB4q0mrQfHTwE6KEZKRQHAxH7KBB+sPxe3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EKriudtpeDSP1pqr7l6/jKAnranziTr8uLNPB2CeRUGusRKkjI215FmdVdRJzJocg
	 NOk9LcUYSGkqm90tat0z8Vvdwnrj0I3U1AxVO+QegCNPAQvVNjwKVTMI4R+3Uta5US
	 WeGwwycSMlQ5Y5KDlJMni8IZ4O/9Z6ncelYh9BzOUYXDFIXfzbGIvQ7rySAW/RyYRc
	 xni3UWdK/HRtzKhwinhEZmrt2sOeyXwOYjNbTlhH+/bTCXvKaU0X319IH5I6j3zHYn
	 QciprMT1ESJzpIkwTu2JK6YFeIz66cA/NidDsvsddzKtXTuZ2t0Avd/Ju2vsDLfeBM
	 ea/YWixm140rQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] staging: rtl8723bs: remove commented out RT_TRACE logs in hal/ and os_dep/
Date: Thu, 10 Sep 2026 07:09:03 -0400
Message-ID: <20260910110906.4147966-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090853-convent-spill-68e6@gregkh>
References: <2026090853-convent-spill-68e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 6544c672ee1d250cb55efb750b4cd529e97615f4 ]

Remove all commented out TR_TRACE calls.

Remove all of the RT_TRACE logs in hal/ and os_dep/ file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/85338f2b2cffb530efbd987064d146fc2be49c72.1617640221.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 99aa998dec83 ("staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 3 ---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c    | 1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 8 --------
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c   | 2 --
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 6 ------
 5 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 85ea535dd6e93..167657f33cebe 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -1852,7 +1852,6 @@ void PHY_IQCalibrate_8723B(
 				bResult = FAIL;
 				break;
 			}
-			/* RT_TRACE(_module_mp_, _drv_notice_, ("Switch to S1 TxIQC(offset, data) = (0x%X, 0x%X)\n", offset, data)); */
 			PHY_SetBBReg(pDM_Odm->Adapter, offset, bMaskDWord, data);
 		}
 
@@ -1869,7 +1868,6 @@ void PHY_IQCalibrate_8723B(
 				bResult = FAIL;
 				break;
 			}
-			/* RT_TRACE(_module_mp_, _drv_notice_, ("Switch to S1 RxIQC (offset, data) = (0x%X, 0x%X)\n", offset, data)); */
 			PHY_SetBBReg(pDM_Odm->Adapter, offset, bMaskDWord, data);
 		}
 
@@ -1955,7 +1953,6 @@ void PHY_IQCalibrate_8723B(
 			}
 		}
 	}
-/* 	RT_TRACE(COMP_INIT, DBG_LOUD, ("Release Mutex in IQCalibrate\n")); */
 
 	for (i = 0; i < 4; i++) {
 		RegE94 = result[i][0];
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index f806b3c7ee6ae..a50cda70b6a79 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1789,7 +1789,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	/*
 	if (band_type == BAND_ON_5G && pwr_lmt == MAX_POWER_INDEX) {
 		if (idx_bandwidth == 0 || idx_bandwidth == 1) {
-			RT_TRACE(COMP_INIT, DBG_LOUD, ("No power limit table of the specified band %d, bandwidth %d, ratesection %d, rf path %d\n",
 				 idx_band, idx_bandwidth,
 				 idx_rate_sctn, rf_path));
 			if (idx_rate_sctn == 2)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 44dca46a799ac..0933cc0906dbf 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2709,7 +2709,6 @@ void Hal_EfuseParseEEPROMVer_8723B(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	if (!AutoLoadFail)
 		pHalData->EEPROMVersion = hwinfo[EEPROM_VERSION_8723B];
 	else
@@ -2792,7 +2791,6 @@ void Hal_EfuseParseCustomerID_8723B(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	if (!AutoLoadFail)
 		pHalData->EEPROMCustomerID = hwinfo[EEPROM_CustomID_8723B];
 	else
@@ -2815,7 +2813,6 @@ void Hal_EfuseParseXtal_8723B(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	if (!AutoLoadFail) {
 		pHalData->CrystalCap = hwinfo[EEPROM_XTAL_8723B];
 		if (pHalData->CrystalCap == 0xFF)
@@ -2833,7 +2830,6 @@ void Hal_EfuseParseThermalMeter_8723B(
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	/*  */
 	/*  ThermalMeter from EEPROM */
 	/*  */
@@ -3144,8 +3140,6 @@ static void rtl8723b_fill_default_txdesc(
 
 		ptxdesc->usb_txagg_num = pxmitframe->agg_num;
 	} else if (pxmitframe->frame_tag == MGNT_FRAMETAG) {
-/* 		RT_TRACE(_module_hal_xmit_c_, _drv_notice_, ("%s: MGNT_FRAMETAG\n", __func__)); */
-
 		ptxdesc->macid = pattrib->mac_id; /*  CAM_ID(MAC_ID) */
 		ptxdesc->qsel = pattrib->qsel;
 		ptxdesc->rate_id = pattrib->raid; /*  Rate ID */
@@ -3961,9 +3955,7 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 				ulCommand = ulCommand | CAM_POLLINIG | CAM_WRITE;
 				/*  write content 0 is equall to mark invalid */
 				rtw_write32(padapter, WCAMI, ulContent);  /* mdelay(40); */
-				/* RT_TRACE(COMP_SEC, DBG_LOUD, ("CAM_empty_entry(): WRITE A4: %lx\n", ulContent)); */
 				rtw_write32(padapter, RWCAM, ulCommand);  /* mdelay(40); */
-				/* RT_TRACE(COMP_SEC, DBG_LOUD, ("CAM_empty_entry(): WRITE A0: %lx\n", ulCommand)); */
 			}
 		}
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
index aafceaf9b1394..b3ec240ff215f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
@@ -74,7 +74,6 @@ void PHY_RF6052SetBandwidth8723B(
 		break;
 
 	default:
-		/* RT_TRACE(COMP_DBG, DBG_LOUD, ("PHY_SetRF8225Bandwidth(): unknown Bandwidth: %#X\n", Bandwidth)); */
 		break;
 	}
 
@@ -153,7 +152,6 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 
 	ODM_ConfigRFWithTxPwrTrackHeaderFile(&pHalData->odmpriv);
 
-	/* RT_TRACE(COMP_INIT, DBG_LOUD, ("<---phy_RF6052_Config_ParaFile()\n")); */
 	return _SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 8107ee03b9642..d9b53fff66a6b 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -4313,7 +4313,6 @@ static int rtw_wx_set_priv(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct iw_point *dwrq = (struct iw_point *)awrq;
 
-	/* RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_notice_, ("+rtw_wx_set_priv\n")); */
 	if (dwrq->length == 0)
 		return -EFAULT;
 
@@ -4326,11 +4325,6 @@ static int rtw_wx_set_priv(struct net_device *dev,
 		return -EFAULT;
 	}
 
-
-	/* RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_notice_, */
-	/* 	 ("rtw_wx_set_priv: %s req =%s\n", */
-	/* 	  dev->name, ext)); */
-
 	#ifdef DEBUG_RTW_WX_SET_PRIV
 	if (!(ext_dbg = vmalloc(len))) {
 		vfree(ext, len);
-- 
2.53.0

