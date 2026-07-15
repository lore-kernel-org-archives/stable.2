Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859051E8342
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074683; cv=none; b=ptFASt8+CuUaBxIrZ53vm5p3PFJfBI+ifwkvCOmDa6d1gkO7YfhymD5SsDR89NoPdbAkB39V5gFbbdcg7us6YTv64Bol1A1YobOU30YpkAsPH1pOs/TyF9rz9QOAi06sIXFiaGTFfe0mWLlPkNYeKKWGynerhFOyox7JRkdZ4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074683; c=relaxed/simple;
	bh=PF+NfSXvOjKsD0zxbmEsD1Ps7psWpA3SPcgeTei8cMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qn9LJOJQaikiaALm/Xiq8xjtoqRXmpeKRprHRGtdShr0rKcc5uJYJa5TN8hT4aY4T+2sfaI7pmRjKHn0H5s2pj69y6xJuvHYFD78xjpf89qEhid5Q3YEMGiGK/nTPW9A+XbJQCXGw9MSfB+/irBri4UJdZ1ebzrWrz82e4GxQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQubsr5U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQubsr5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E604F1F00A3F;
	Wed, 15 Jul 2026 00:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074682;
	bh=pnShW5zVg0VvEhW/ZCptkTn/m966oGbuwWQTxkCePv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQubsr5UcaeLVgZliwXj4Gkkv/WxW3tYMB7tYkPNWUBhmC0QjpE8Y3NX+1qC5udwB
	 ZczVsbsghZLixbv8MkV9FTYbFfBYyXKNSWRoEGfXCX6xehJEKtf2mshTK54CTdAYuc
	 1p8E84kbo6A1LyhYaqhfZQb0Q93G35aSdOf9DQ8omxaf1WkhMb4B1jUYFHe8Y48wne
	 t3IXkODlALgnARHLCdlDatZT2ZQSwBhF5vKmHvvTyXj5WWngrxHSM/1EUosGfYZA6l
	 s7ydJz95Xp2L2FXfNN7WxNQE61JhFGvSsfcZOV/xFF+MbeVjcyxtYHkwcuwAwG+99+
	 aT/SmWlJEre1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Hansen-Baird <william.hansen.baird@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] staging: rtl8723bs: core: move constants to right side in comparison
Date: Tue, 14 Jul 2026 20:17:58 -0400
Message-ID: <20260715001800.3784291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071358-startling-counting-680a@gregkh>
References: <2026071358-startling-counting-680a@gregkh>
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
index 83b770571bee9f..ea63150061c341 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1013,7 +1013,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
+		if (rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 			pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
 			pnetwork->bcn_info.group_cipher = group_cipher;
 			pnetwork->bcn_info.is_8021x = is8021x;
@@ -1023,7 +1023,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 		pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.ie_length-12);
 
 		if (pbuf && (wpa_ielen > 0)) {
-			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
+			if (rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 				pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
 				pnetwork->bcn_info.group_cipher = group_cipher;
 				pnetwork->bcn_info.is_8021x = is8021x;
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 7bbb0abf1d871a..38ea6bf68295d6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1537,7 +1537,7 @@ void rtw_sec_restore_wep_key(struct adapter *adapter)
 	struct security_priv *securitypriv = &(adapter->securitypriv);
 	signed int keyid;
 
-	if ((_WEP40_ == securitypriv->dot11PrivacyAlgrthm) || (_WEP104_ == securitypriv->dot11PrivacyAlgrthm)) {
+	if ((securitypriv->dot11PrivacyAlgrthm == _WEP40_) || (securitypriv->dot11PrivacyAlgrthm == _WEP104_)) {
 		for (keyid = 0; keyid < 4; keyid++) {
 			if (securitypriv->key_mask & BIT(keyid)) {
 				if (keyid == securitypriv->dot11PrivacyKeyIndex)
-- 
2.53.0

