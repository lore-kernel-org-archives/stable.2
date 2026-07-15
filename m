Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B03A875D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083552; cv=none; b=V2IBfGkKbPOSWlTc6493yUxnox9pFXxB8KAMHvCBenKbp0es6yygy8gU2z9NarQUotU3zXkAflSxp6gPpbyMtkZ46DDVdm4MTvHqiSoHa3ziVwKG9MvewJAJ3yoDgQvEhHuOvAkZxhfrEtu93+PTOWrP3at23+nedGHeIcH5Z34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083552; c=relaxed/simple;
	bh=6agrAULzFh/WAVgXIvcDvBZ3zh1m4QRB9goSubVlgYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV84kA4hw6mJ/6HXanh4wL4C7BhFgXGqY2zzApTI2tJIBLw3bGrX72uPzSG5qTAoQG3efgj47gm6B2D53SsycIcbPLMnd3QuF3irO6dEWoZoWFvQq6MVm4YrSdl63gDRSBT0DopyotFx9aDQmjMZtfl83fgMcOLVop/5M76CHbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmif3xSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmif3xSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F881F00A3F;
	Wed, 15 Jul 2026 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083550;
	bh=jSE27aJQMKYWQUwfTd4C+TSX2rl+BM22ylxmF6KQPAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmif3xSGDinTZE4AMzJubiY866NiSKNaZ+DeHdx4EvyvUEZ3J9EPV5rFox09S8cp1
	 4ycl9aSAbjiWNKP0Kk3KqxB78o6+FyrP6CZWJu4yem24CAScfHQe8fhZ4vaPyIUVs+
	 Dx/jUIhQLyu9yrs168cGUKzbQblVwLbeePBtHd9Qp5dzDzJbQdRTAG7cXpuS3olC6w
	 hf1B+lpw2pMjR6SvDhthl3zi5BR9dnslDkOBdTyL10R8y7bikF/Dr84ECWKKiKeFNB
	 FCxwgRdF97eKWrLm4HmeDafoWJCC+oS0z44l2RSsef6UIiPq8r+yImuGjefgKwhN0E
	 4L26LcDchjuTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 07/10] staging: rtl8723bs: refactor to reduce indents
Date: Tue, 14 Jul 2026 22:45:40 -0400
Message-ID: <20260715024543.105642-7-sashal@kernel.org>
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

From: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>

[ Upstream commit 3c8c577fd2fcf3587f16a2a9e8174c9f849cb7a6 ]

Reduce the number of indents in rtw_wlan_util.c file by refactoring the
code.

Moved the part of code that rearranged ac paramaters in the function
WMMOnAssocResp to a separate function named sort_wmm_ac_params. It takes
both the array of ac params and their indexes as arguments and sorts them.
Has return type void.

Moved the part of code that checked IE for realtek vendor in the
function check_assoc_AP to a separate function named
get_realtek_assoc_AP_vender. It takes a struct ndis_80211_var_ie * as an
argument and returns u32 realtek vendor.

Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Link: https://lore.kernel.org/r/20210524135105.5550-2-chouhan.shreyansh630@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ed51de4a86e1 ("staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 108 +++++++++---------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index e93bf08225d2cf..836eef6397c0ba 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -775,6 +775,32 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	return true;
 }
 
+static void sort_wmm_ac_params(u32 *inx, u32 *edca)
+{
+	u32 i, j, change_inx = false;
+
+	/* entry indx: 0->vo, 1->vi, 2->be, 3->bk. */
+	for (i = 0; i < 4; i++) {
+		for (j = i + 1; j < 4; j++) {
+			/* compare CW and AIFS */
+			if ((edca[j] & 0xFFFF) < (edca[i] & 0xFFFF)) {
+				change_inx = true;
+			} else if ((edca[j] & 0xFFFF) == (edca[i] & 0xFFFF)) {
+				/* compare TXOP */
+				if ((edca[j] >> 16) > (edca[i] >> 16))
+					change_inx = true;
+			}
+
+			if (change_inx) {
+				swap(edca[i], edca[j]);
+				swap(inx[i], inx[j]);
+
+				change_inx = false;
+			}
+		}
+	}
+}
+
 void WMMOnAssocRsp(struct adapter *padapter)
 {
 	u8 ACI, ACM, AIFS, ECWMin, ECWMax, aSifsTime;
@@ -871,35 +897,8 @@ void WMMOnAssocRsp(struct adapter *padapter)
 
 		inx[0] = 0; inx[1] = 1; inx[2] = 2; inx[3] = 3;
 
-		if (pregpriv->wifi_spec == 1) {
-			u32 j, tmp, change_inx = false;
-
-			/* entry indx: 0->vo, 1->vi, 2->be, 3->bk. */
-			for (i = 0; i < 4; i++) {
-				for (j = i+1; j < 4; j++) {
-					/* compare CW and AIFS */
-					if ((edca[j] & 0xFFFF) < (edca[i] & 0xFFFF)) {
-						change_inx = true;
-					} else if ((edca[j] & 0xFFFF) == (edca[i] & 0xFFFF)) {
-						/* compare TXOP */
-						if ((edca[j] >> 16) > (edca[i] >> 16))
-							change_inx = true;
-					}
-
-					if (change_inx) {
-						tmp = edca[i];
-						edca[i] = edca[j];
-						edca[j] = tmp;
-
-						tmp = inx[i];
-						inx[i] = inx[j];
-						inx[j] = tmp;
-
-						change_inx = false;
-					}
-				}
-			}
-		}
+		if (pregpriv->wifi_spec == 1)
+			sort_wmm_ac_params(inx, edca);
 
 		for (i = 0; i < 4; i++)
 			pxmitpriv->wmm_para_seq[i] = inx[i];
@@ -1510,6 +1509,33 @@ void set_sta_rate(struct adapter *padapter, struct sta_info *psta)
 	Update_RA_Entry(padapter, psta);
 }
 
+static u32 get_realtek_assoc_AP_vender(struct ndis_80211_var_ie *pIE)
+{
+	u32 Vender = HT_IOT_PEER_REALTEK;
+
+	if (pIE->Length >= 5) {
+		if (pIE->data[4] == 1)
+			/* if (pIE->data[5] & RT_HT_CAP_USE_LONG_PREAMBLE) */
+			/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
+			if (pIE->data[5] & RT_HT_CAP_USE_92SE)
+				/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_92SE; */
+				Vender = HT_IOT_PEER_REALTEK_92SE;
+
+		if (pIE->data[5] & RT_HT_CAP_USE_SOFTAP)
+			Vender = HT_IOT_PEER_REALTEK_SOFTAP;
+
+		if (pIE->data[4] == 2) {
+			if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)
+				Vender = HT_IOT_PEER_REALTEK_JAGUAR_BCUTAP;
+
+			if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)
+				Vender = HT_IOT_PEER_REALTEK_JAGUAR_CCUTAP;
+		}
+	}
+
+	return Vender;
+}
+
 unsigned char check_assoc_AP(u8 *pframe, uint len)
 {
 	unsigned int	i;
@@ -1533,29 +1559,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 			} else if (!memcmp(pIE->data, CISCO_OUI, 3)) {
 				return HT_IOT_PEER_CISCO;
 			} else if (!memcmp(pIE->data, REALTEK_OUI, 3)) {
-				u32 Vender = HT_IOT_PEER_REALTEK;
-
-				if (pIE->Length >= 5) {
-					if (pIE->data[4] == 1)
-						/* if (pIE->data[5] & RT_HT_CAP_USE_LONG_PREAMBLE) */
-						/* 	bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
-						if (pIE->data[5] & RT_HT_CAP_USE_92SE)
-							/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_92SE; */
-							Vender = HT_IOT_PEER_REALTEK_92SE;
-
-					if (pIE->data[5] & RT_HT_CAP_USE_SOFTAP)
-						Vender = HT_IOT_PEER_REALTEK_SOFTAP;
-
-					if (pIE->data[4] == 2) {
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)
-							Vender = HT_IOT_PEER_REALTEK_JAGUAR_BCUTAP;
-
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)
-							Vender = HT_IOT_PEER_REALTEK_JAGUAR_CCUTAP;
-					}
-				}
-
-				return Vender;
+				return get_realtek_assoc_AP_vender(pIE);
 			} else if (!memcmp(pIE->data, AIRGOCAP_OUI, 3)) {
 				return HT_IOT_PEER_AIRGO;
 			} else
-- 
2.53.0

