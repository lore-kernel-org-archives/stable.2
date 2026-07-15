Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635B42BC45
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074933; cv=none; b=kZzrE3zJ1cadFSd3mdsFvmoqyLDY+rS20M+1dUcCfDwv9KWEJuR//lsI+HjaytFgKfc8N0T8yjVr4QGxnVRGBvBcGP3PC/WdRmjxdCp8TNHqhPaOpBf0/l3MUhzcv1QmkRZSrTel26QGr+SOqmTeTLPNmFUsjv8PgaBwTT2qqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074933; c=relaxed/simple;
	bh=LIMy8t8cYY3slF4U9yrWovIREozCwbLQznW2v0j9yiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXcLOIJWkS18cyeC+JGVM6RAJojQB37utKJs+JsV5XAZCSHApl6n41jjZld4ikxajH/G/E7lgyqMgrPf2PdrBkNDl/uop0ATjxSZ94+S3pfBbC9HECSelQg99A0sEobjOEd319RBxWB4Gsubw3k4SeKx1OXKkmk+DUg0oFIUTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSIF7ton; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSIF7ton"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF161F000E9;
	Wed, 15 Jul 2026 00:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074932;
	bh=bWpGMWillA06cyJIifzMOTnWNvaFNPKv14eEkb9Fxu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cSIF7tonrtNXInwMHnKPj8/KcycRpcHkd/tQ0F9+FWRRA5z4U46HySnh/qlj6yMD6
	 pPGtIn9PoMpnBO5a3w8V+WQ+WXopKxPMcpNWUJc/LTb2zBHXn1qM9HiR1PAsjqxcVN
	 XCpKHI7IhSsXLZ2mNyXEY65P52Rwi0yWLoPsq7EyMAmh45wAtMI6xv3b2TNdvrP/Fy
	 lDQ2X4D6+HmDDgsP013z6/zuXmvfnVnfceTuEkRRdvqRbXiGA+wg4MaO7eawgHUKy3
	 3Um1bOvPCnTxuaFoR0q36ZE6EZQ1bzyQ6pYUBcyUnK23/Tui3QQ8oGCMjmhIV0xF8s
	 Fa6m2BcfWUcUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Hansen-Baird <william.hansen.baird@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] staging: rtl8723bs: core: move constants to right side in comparison
Date: Tue, 14 Jul 2026 20:22:08 -0400
Message-ID: <20260715002210.3789107-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071358-harpist-prompter-f7c3@gregkh>
References: <2026071358-harpist-prompter-f7c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Hansen-Baird <william.hansen.baird@gmail.com>

[ Upstream commit cf0f2680c30d4b438a5e84b73dc70be405936b54 ]

Move constants to right side in if-statement conditions.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
Link: https://patch.msgid.link/20251224100329.762141-3-william.hansen.baird@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_security.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 7cd44e8c69668e..a7f836b915c3ca 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1012,7 +1012,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
+		if (rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 			pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
 			pnetwork->bcn_info.group_cipher = group_cipher;
 			pnetwork->bcn_info.is_8021x = is8021x;
@@ -1022,7 +1022,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 		pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 
 		if (pbuf && (wpa_ielen > 0)) {
-			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
+			if (rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 				pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
 				pnetwork->bcn_info.group_cipher = group_cipher;
 				pnetwork->bcn_info.is_8021x = is8021x;
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index cfc0db7d99e7fc..2f44a24d136be3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1538,7 +1538,7 @@ void rtw_sec_restore_wep_key(struct adapter *adapter)
 	struct security_priv *securitypriv = &(adapter->securitypriv);
 	signed int keyid;
 
-	if ((_WEP40_ == securitypriv->dot11PrivacyAlgrthm) || (_WEP104_ == securitypriv->dot11PrivacyAlgrthm)) {
+	if ((securitypriv->dot11PrivacyAlgrthm == _WEP40_) || (securitypriv->dot11PrivacyAlgrthm == _WEP104_)) {
 		for (keyid = 0; keyid < 4; keyid++) {
 			if (securitypriv->key_mask & BIT(keyid)) {
 				if (keyid == securitypriv->dot11PrivacyKeyIndex)
-- 
2.53.0

