Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9993242D4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083553; cv=none; b=CtjErvFXgGrAg2tV288KZYERjY9soIjLhiWU5eGaX1SzK73i5ObpPwD5X8uZYd6koTAZeLaOL96zv+aVtxsgtiYQLeu8FJd4OFK2ZZ9xqfXDoq1uqv3qs1gAo5FsQG0QcQaualEAf0dYUykZdfRGc3VVkjFOdzcD27fEJLXIt8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083553; c=relaxed/simple;
	bh=2nvks5RB/ezmpYrNDThpURwLA3/Vwqk0wlxXlc8eLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/LDZWWhLEcdudJm7Yd9Yi/WVK2lj/u8QEYwGYxobxzCGPQKKoOnyv2QsChCQtNT6i1n9OpQB8ntB3UovdbXK+/V8k/XMylQ/euppeNhD0v85rOBoMhWOm+o60a/4AMQga+UsQL7KrWxpP5e/Wn2d7tBQnqCbQXPF4UbVdk/l4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQF8eDfV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQF8eDfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF17C1F00ACA;
	Wed, 15 Jul 2026 02:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083551;
	bh=MTJAsd0BuDu6BqCofxRswCKX9yrB8PQS1kvYn/oL62Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nQF8eDfV3cutgBfFfVZuiuebCt/rKxEmTzvL1qRAsiD7OH6EqcHnfMjzgUBa+E2E+
	 huyEIjgUioU5QvRwfXAaXbecaw1h/cfmX+ZBc9tiU/koUpOTFlcwRStiHgeCsc1vnR
	 05iy8eOL3Kd281eFzfNWA7oCDe42bpj5MD97ukx7rR53ZajYLSKgwWoV/olhlMKeBT
	 2I379DpgZE8fFM5rP91mWwti3zY8m5+cyrnSoG/N2ROhoAs6DAUeIzQnEtoG3EiGHz
	 9sxKVA2kANLyvqNZeVbmy5REIVfQ9K/Ixqo+zMryz/lhfL0zkYeGoR6qXUhiqB2E+x
	 nfRJnyjytb5wQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 08/10] staging: rtl8723bs: remove code related to unsupported channel bandwidth
Date: Tue, 14 Jul 2026 22:45:41 -0400
Message-ID: <20260715024543.105642-8-sashal@kernel.org>
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

[ Upstream commit 33137187d3c8c82b2ae264bb8313dfa2e2f354e1 ]

remove all code related to unsupported channel
bandwidth (i.e. 80, 80+80, 160 Mhz). rtl8723bs NIC
works only on 20 and 40 Mhz channels.

Module parameter rtw_bw_mode can only have two
values: 0 and 1 (20 Mhz and 40Mhz). So modify
the default value setting to zero the 5Ghz nibble.

Comments modified accordingly.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/7b2ee7cc0abfd8744ed5ff4a654fb333fee77ec7.1624367071.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ed51de4a86e1 ("staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 15 +-------
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  5 +--
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 34 -----------------
 drivers/staging/rtl8723bs/hal/odm.h           |  3 --
 drivers/staging/rtl8723bs/hal/odm_DIG.c       |  5 +--
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 31 ++--------------
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 37 +------------------
 drivers/staging/rtl8723bs/include/drv_types.h |  8 ++--
 drivers/staging/rtl8723bs/include/rtw_rf.h    |  4 --
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 10 +++--
 10 files changed, 18 insertions(+), 134 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 836eef6397c0ba..b359a409eec4ea 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -346,9 +346,7 @@ u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset)
 {
 	u8 center_ch = channel;
 
-	if (chnl_bw == CHANNEL_WIDTH_80) {
-		center_ch = 7;
-	} else if (chnl_bw == CHANNEL_WIDTH_40) {
+	if (chnl_bw == CHANNEL_WIDTH_40) {
 		if (chnl_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
 			center_ch = channel + 2;
 		else
@@ -385,14 +383,6 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 
 	center_ch = rtw_get_center_ch(channel, bwmode, channel_offset);
 
-	if (bwmode == CHANNEL_WIDTH_80) {
-		if (center_ch > channel)
-			chnl_offset80 = HAL_PRIME_CHNL_OFFSET_LOWER;
-		else if (center_ch < channel)
-			chnl_offset80 = HAL_PRIME_CHNL_OFFSET_UPPER;
-		else
-			chnl_offset80 = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
-	}
 
 	/* set Channel */
 	if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->setch_mutex)))
@@ -923,9 +913,6 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 	if (phtpriv->ht_option == false)
 		return;
 
-	if (pmlmeext->cur_bwmode >= CHANNEL_WIDTH_80)
-		return;
-
 	if (pIE->Length > sizeof(struct HT_info_element))
 		return;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 68a431b1f2b6da..d885778354185b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -331,15 +331,12 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 
 u8 query_ra_short_GI(struct sta_info *psta)
 {
-	u8 sgi = false, sgi_20m = false, sgi_40m = false, sgi_80m = false;
+	u8 sgi = false, sgi_20m = false, sgi_40m = false;
 
 	sgi_20m = psta->htpriv.sgi_20m;
 	sgi_40m = psta->htpriv.sgi_40m;
 
 	switch (psta->bw_mode) {
-	case CHANNEL_WIDTH_80:
-		sgi = sgi_80m;
-		break;
 	case CHANNEL_WIDTH_40:
 		sgi = sgi_40m;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index b9a6dee46bbf58..69fd75306447cf 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -999,7 +999,6 @@ u8 PHY_GetTxPowerIndexBase(
 )
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
-	u8 i = 0;	/* default set to 1S */
 	u8 txPower = 0;
 	u8 chnlIdx = (Channel-1);
 
@@ -1039,18 +1038,6 @@ u8 PHY_GetTxPowerIndexBase(
 				txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
 
 		}
-		/*  Willis suggest adopt BW 40M power index while in BW 80 mode */
-		else if (BandWidth == CHANNEL_WIDTH_80) {
-			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_1S];
-			if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_2S];
-			if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_3S];
-			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
-
-		}
 	} else {/* 3 ============================== 5 G ============================== */
 		if (MGN_6M <= Rate)
 			txPower = pHalData->Index5G_BW40_Base[RFPath][chnlIdx];
@@ -1080,23 +1067,6 @@ u8 PHY_GetTxPowerIndexBase(
 			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW40_5G_Diff[RFPath][TX_4S];
 
-		} else if (BandWidth == CHANNEL_WIDTH_80) { /*  BW80-1S, BW80-2S */
-			/*  <20121220, Kordan> Get the index of array "Index5G_BW80_Base". */
-			u8 channel5G_80M[CHANNEL_MAX_NUMBER_5G_80M] = {42, 58, 106, 122, 138, 155, 171};
-			for (i = 0; i < ARRAY_SIZE(channel5G_80M); ++i)
-				if (channel5G_80M[i] == Channel)
-					chnlIdx = i;
-
-			txPower = pHalData->Index5G_BW80_Base[RFPath][chnlIdx];
-
-			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31)  || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += + pHalData->BW80_5G_Diff[RFPath][TX_1S];
-			if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW80_5G_Diff[RFPath][TX_2S];
-			if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW80_5G_Diff[RFPath][TX_3S];
-			if ((MGN_MCS23 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW80_5G_Diff[RFPath][TX_4S];
 		}
 	}
 
@@ -1516,10 +1486,6 @@ static s16 get_bandwidth_idx(const enum CHANNEL_WIDTH bandwidth)
 		return 0;
 	case CHANNEL_WIDTH_40:
 		return 1;
-	case CHANNEL_WIDTH_80:
-		return 2;
-	case CHANNEL_WIDTH_160:
-		return 3;
 	default:
 		return -1;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index a8d232245227b2..144c1f930841f7 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -579,9 +579,6 @@ typedef enum tag_Security_Definition {
 typedef enum tag_Bandwidth_Definition {
 	ODM_BW20M		= 0,
 	ODM_BW40M		= 1,
-	ODM_BW80M		= 2,
-	ODM_BW160M		= 3,
-	ODM_BW10M		= 4,
 } ODM_BW_E;
 
 /*  ODM_CMNINFO_BOARD_TYPE */
diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index 40fe43c62c45d9..b63d53748a6b4d 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -250,8 +250,6 @@ void odm_Adaptivity(void *pDM_VOID, u8 IGI)
 		IGI_target = pDM_Odm->IGI_Base;
 	else if (*pDM_Odm->pBandWidth == ODM_BW40M)
 		IGI_target = pDM_Odm->IGI_Base + 2;
-	else if (*pDM_Odm->pBandWidth == ODM_BW80M)
-		IGI_target = pDM_Odm->IGI_Base + 2;
 	else
 		IGI_target = pDM_Odm->IGI_Base;
 	pDM_Odm->IGI_target = (u8) IGI_target;
@@ -290,8 +288,7 @@ void odm_Adaptivity(void *pDM_VOID, u8 IGI)
 		ODM_DBG_LOUD,
 		(
 			"BandWidth =%s, IGI_target = 0x%x, EDCCA_State =%d\n",
-			(*pDM_Odm->pBandWidth == ODM_BW80M) ? "80M" :
-			((*pDM_Odm->pBandWidth == ODM_BW40M) ? "40M" : "20M"),
+			(*pDM_Odm->pBandWidth == ODM_BW40M) ? "40M" : "20M",
 			IGI_target,
 			EDCCA_State
 		)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 15654bf850ddcc..7ba83d5a80747e 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2814,15 +2814,8 @@ u8 BWMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 	u8 BWSettingOfDesc = 0;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
-		if (pattrib->bwmode == CHANNEL_WIDTH_80)
-			BWSettingOfDesc = 2;
-		else if (pattrib->bwmode == CHANNEL_WIDTH_40)
-			BWSettingOfDesc = 1;
-		else
-			BWSettingOfDesc = 0;
-	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
-		if ((pattrib->bwmode == CHANNEL_WIDTH_40) || (pattrib->bwmode == CHANNEL_WIDTH_80))
+	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
+		if (pattrib->bwmode == CHANNEL_WIDTH_40)
 			BWSettingOfDesc = 1;
 		else
 			BWSettingOfDesc = 0;
@@ -2840,25 +2833,7 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 	u8 SCSettingOfDesc = 0;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
-		if (pattrib->bwmode == CHANNEL_WIDTH_80) {
-			SCSettingOfDesc = VHT_DATA_SC_DONOT_CARE;
-		} else if (pattrib->bwmode == CHANNEL_WIDTH_40) {
-			if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
-				SCSettingOfDesc = VHT_DATA_SC_40_LOWER_OF_80MHZ;
-			else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
-				SCSettingOfDesc = VHT_DATA_SC_40_UPPER_OF_80MHZ;
-		} else {
-			if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER))
-				SCSettingOfDesc = VHT_DATA_SC_20_LOWEST_OF_80MHZ;
-			else if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER))
-				SCSettingOfDesc = VHT_DATA_SC_20_LOWER_OF_80MHZ;
-			else if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER))
-				SCSettingOfDesc = VHT_DATA_SC_20_UPPER_OF_80MHZ;
-			else if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER))
-				SCSettingOfDesc = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
-		}
-	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
+	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		if (pattrib->bwmode == CHANNEL_WIDTH_40) {
 			SCSettingOfDesc = VHT_DATA_SC_DONOT_CARE;
 		} else if (pattrib->bwmode == CHANNEL_WIDTH_20) {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 5f45195f634442..e928af374b235b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -686,11 +686,6 @@ static void phy_SetRegBW_8723B(
 		rtw_write16(Adapter, REG_TRXPTCL_CTL_8723B, (u2tmp & 0xFEFF)); /*  BIT 7 = 1, BIT 8 = 0 */
 		break;
 
-	case CHANNEL_WIDTH_80:
-		u2tmp = RegRfMod_BW | BIT8;
-		rtw_write16(Adapter, REG_TRXPTCL_CTL_8723B, (u2tmp & 0xFF7F)); /*  BIT 7 = 0, BIT 8 = 1 */
-		break;
-
 	default:
 		break;
 	}
@@ -711,37 +706,7 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
 			pHalData->nCur40MhzPrimeSC
 		)
 	);
-	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
-		if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
-			SCSettingOf40 = VHT_DATA_SC_40_LOWER_OF_80MHZ;
-		else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
-			SCSettingOf40 = VHT_DATA_SC_40_UPPER_OF_80MHZ;
-		else
-			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
-
-		if (
-			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) &&
-			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
-		)
-			SCSettingOf20 = VHT_DATA_SC_20_LOWEST_OF_80MHZ;
-		else if (
-			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) &&
-			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
-		)
-			SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
-		else if (
-			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) &&
-			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
-		)
-			SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
-		else if (
-			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) &&
-			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
-		)
-			SCSettingOf20 = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
-		else
-			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
-	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
+	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		RT_TRACE(
 			_module_hal_init_c_,
 			_drv_info_,
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index c73f581aea064f..cc13ee47302720 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -128,9 +128,11 @@ struct registry_priv {
 	struct wlan_bssid_ex    dev_network;
 
 	u8 ht_enable;
-	/*  0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160MHz */
-	/*  2.4G use bit 0 ~ 3, 5G use bit 4 ~ 7 */
-	/*  0x21 means enable 2.4G 40MHz & 5G 80MHz */
+	/*
+	 * 0: 20 MHz, 1: 40 MHz
+	 * 2.4G use bit 0 ~ 3
+	 * 0x01 means enable 2.4G 40MHz
+	 */
 	u8 bw_mode;
 	u8 ampdu_enable;/* for tx */
 	u8 rx_stbc;
diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index d3a8e4b7069aff..8304a6304a26e8 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -101,10 +101,6 @@ enum RF90_RADIO_PATH {
 enum CHANNEL_WIDTH {
 	CHANNEL_WIDTH_20 = 0,
 	CHANNEL_WIDTH_40 = 1,
-	CHANNEL_WIDTH_80 = 2,
-	CHANNEL_WIDTH_160 = 3,
-	CHANNEL_WIDTH_80_80 = 4,
-	CHANNEL_WIDTH_MAX = 5,
 };
 
 /*  Represent Extension Channel Offset in HT Capabilities */
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index eb0a49ae4b9516..4ce675403d0dc1 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -67,10 +67,12 @@ static int rtw_uapsd_acvi_en;
 static int rtw_uapsd_acvo_en;
 
 int rtw_ht_enable = 1;
-/*  0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160MHz, 4: 80+80MHz */
-/*  2.4G use bit 0 ~ 3, 5G use bit 4 ~ 7 */
-/*  0x21 means enable 2.4G 40MHz & 5G 80MHz */
-static int rtw_bw_mode = 0x21;
+/*
+ * 0: 20 MHz, 1: 40 MHz
+ * 2.4G use bit 0 ~ 3
+ * 0x01 means enable 2.4G 40MHz
+ */
+static int rtw_bw_mode = 0x01;
 static int rtw_ampdu_enable = 1;/* for enable tx_ampdu ,0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
 static int rtw_rx_stbc = 1;/*  0: disable, 1:enable 2.4g */
 static int rtw_ampdu_amsdu;/*  0: disabled, 1:enabled, 2:auto . There is an IOT issu with DLINK DIR-629 when the flag turn on */
-- 
2.53.0

