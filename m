Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1280143848C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114194; cv=none; b=N8uimRXsSv+tZCNGk7qFOFRhGRkLIhIOtxmgkgM4RXT/KYZbE87DcdINCVYaEyy9m3HPibYZzUGEot39SKtk5YRD7vWR3hX8uKeHs0a8b3aFkwF55iB0tTZS4XiEEZHdal8Xp3CB/9faJOvhvjJsPoySMVB5y4FLJGEWzMolGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114194; c=relaxed/simple;
	bh=goKTchNIlPhjJSAm8G82ruwGXeYiK0e3U4FvZAKCR98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQg3rU4CwQKe1by2wzbL8JsD66/ANEN4zFp1c3KuwyODubYLvODpiIgPGSs8KWeh25hZG+xls3ixPM525ff9Rux9z4WCCQZATEvMx4m4Eak4vaGBZHl7l+U22a6byFgBevpoYZOZBVI/v85i0gfsa/tVx1lNw3U4ztm2xNRSUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mre2bXKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mre2bXKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1171F00A3D;
	Wed, 15 Jul 2026 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114193;
	bh=nO/yvL7FvQY1V7QCrzbKeKux1B1FHkCxEaiftTnULdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mre2bXKLVY20S2vlAXETkXZPnby13kfgsDx2XACFUBb6NctiHdOd3njZbHm6OZE4r
	 wlm6DAc7Y8vQiZJlkGOGolAAANgexe5Dk+bC+QFnlm9iR5AHkUx3P/BYblfKF/he+s
	 9pyIvqrIvYQwTOwh5r3ndnIRnN6flGOmrTPcm16j0YJ3D4yhCZdA/fWMRMRhfAnb1d
	 8HMLovSvpCsXq4HRAG3L5jCfxavMzf/IlIdaHvU+wDLQZS+PloxTXSS90hZ7OU05DK
	 xevn6uykgS/GuLhkAg1cQ0s7fj2PMgcbkJo8B8sE1MeOY9qv9e5ss/ToEbgHvaU6oI
	 hy5/FN9ZLcE4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Hansen-Baird <william.hansen.baird@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 08/10] staging: rtl8723bs: core: move constants to right side in comparison
Date: Wed, 15 Jul 2026 07:16:23 -0400
Message-ID: <20260715111625.647536-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715111625.647536-1-sashal@kernel.org>
References: <2026071300-length-drainable-3f8e@gregkh>
 <20260715111625.647536-1-sashal@kernel.org>
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
index 232158930be0df..e59cd050c3755b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1137,7 +1137,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 
 	if (pbuf && (wpa_ielen > 0)) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_cipher_info: wpa_ielen: %d", wpa_ielen));
-		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
+		if (rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 			pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
 			pnetwork->bcn_info.group_cipher = group_cipher;
 			pnetwork->bcn_info.is_8021x = is8021x;
@@ -1150,7 +1150,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 
 		if (pbuf && (wpa_ielen > 0)) {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE\n"));
-			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
+			if (rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE  OK!!!\n"));
 				pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
 				pnetwork->bcn_info.group_cipher = group_cipher;
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index bf15902b3cef21..e577fc68811888 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -2334,7 +2334,7 @@ void rtw_sec_restore_wep_key(struct adapter *adapter)
 	struct security_priv *securitypriv = &(adapter->securitypriv);
 	sint keyid;
 
-	if ((_WEP40_ == securitypriv->dot11PrivacyAlgrthm) || (_WEP104_ == securitypriv->dot11PrivacyAlgrthm)) {
+	if ((securitypriv->dot11PrivacyAlgrthm == _WEP40_) || (securitypriv->dot11PrivacyAlgrthm == _WEP104_)) {
 		for (keyid = 0; keyid < 4; keyid++) {
 			if (securitypriv->key_mask & BIT(keyid)) {
 				if (keyid == securitypriv->dot11PrivacyKeyIndex)
-- 
2.53.0

