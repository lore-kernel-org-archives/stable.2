Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5383A7F69
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083575; cv=none; b=R3iE3xdc8Wz4eIq0duYh0zDuz4DlwjUX6rjXzH202fjuvmuwkiGL+HEYZE3ZEb+By54U6TI4SV8i9sQZ/skSWWIyNBobJHHpV8S93XFUvDZ1rJWt3ki2+LdcI7zb+bcdGyf3I7eNUVCqgRAQ1jcA1eqX8N3Zduib/1uqrkNaZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083575; c=relaxed/simple;
	bh=kwKcTLeFgTU7iYmS/Oc+AC4fcYBNdMJ8NPdFpeHyR4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKcUj5Fqr03MpfALfmQqZL7W2/xVFYeM0HtPSkQQ4lLzW3HShdpm2hkafGhONL1sxTWzuU+sFPy0S5juD9TadmZ9Cmf/btABtOQ6om0MdnOWEmJFgOZYGUATTALKrVAW5WrcV0TPwTtCThSj45oRcaLvACsOBMltBrYBq+Uddak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAFtdLEm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAFtdLEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BF31F00ACA;
	Wed, 15 Jul 2026 02:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083573;
	bh=0mB6lIJzVafKxF808ShBMLpT2h/gUbrJvca/gZZYO5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PAFtdLEmDmDszxR1L9PArGlf9rfJBM/CGV0PlnJfDgY2IZjELbRNfcsILtffkZkcs
	 SgS26yvRd2a5XK/xqhjvUrXpoTaC0yxE8mhY8i+6QQ+9zHjrbC9KdQK6vGKIJa3vRl
	 BioUznPycgWkn/b/TrhcImsYQTBecYEZRP8JvM4gHkHHN3/SOJB4ux1LzHpsGsF4ko
	 hpj6vc4R80UGZq1stR6jVYeh/Di4KA7ja4yzRFZQh2ABoxmTBveI7UIkxX3yhgqplq
	 ofy8rWmzxzuuRBFFZgu8GMgUfZ2SjifAK2BekYkWyn1lyTRsdukmzi4y5FzKOyhwF9
	 VfZ7nx+8p7VXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 07/10] staging: rtl8723bs: refactor to reduce indents
Date: Tue, 14 Jul 2026 22:46:03 -0400
Message-ID: <20260715024606.107096-7-sashal@kernel.org>
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
Stable-dep-of: 3bf39f711ff2 ("staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop")
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

