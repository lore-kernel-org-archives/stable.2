Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567D13790B
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079252; cv=none; b=ciyi2NN7/xB5ffScvlAEqVASQF640ytOq9vyCuCp6bBiGno0fCS4QYpOFVA7hYPpUPG2Ct2VTHInY6Ag7fC6dzE06OAW7ruv554wTLqdCB+TZB9fBxIBHBxAUQcWUs+psnc2zlrfVIE8UBQzAtO/Nv9x2wcLwaDfdIAS+oqYx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079252; c=relaxed/simple;
	bh=SlK7FDyEivXps8TBU91/DflotaTTclA3wC39xO6KwuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANYKmFexlVTrEW3d04+vNpYO1eSw6YsfE9XD5EQRbOQLcCFmIsv5CJIutl4WdlQtuf5HK+gguEBojv1F4t7cRAvHFfonGvhYjysCLhGRKF+p3k2ErH4rDOClQlMnI7yqkbcjJ4MRKxfpF9bB2cWmp1pEfNPJcmZtvVS1ZnZHqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iklCwbmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iklCwbmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBE11F00A3D;
	Wed, 15 Jul 2026 01:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079251;
	bh=X2h0kEhvPzHz8yEDGagucNjudePLMWpsdmTsxHb7//U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iklCwbmynKzto0BcaTS4gmh1EvOBmLWwKu5YyzO7ZyN2NF/RpRvujfmMg6t/xPunv
	 csDa4CredMEwBQOdedzZbNuz8G2yyKCcjhlhBbi9Vmsi8Nux11GyObvHsQkOiJIlNA
	 sPj5zPLTMbPVT+Uo7bUEXThNDIg48CWcjPqq55ck6w+ZrZ8QhTY0tfMKNizq3KAznL
	 M44R9evyT9WEXuTcj37ZgQrXlsXHMUUllHffpk/Bo9PNnDiTnNvvVLyJt1hOfmFhRF
	 mfiK+rA40eipQhNGZ4QpTPX0pQ/8NFqfBjYoB2RQ+fWZmaxZFI0Og1C7DZ3ieYVM14
	 IcBpTojihy6dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] staging: rtl8723bs: remove redundant braces in if statements
Date: Tue, 14 Jul 2026 21:34:05 -0400
Message-ID: <20260715013408.4110029-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715013408.4110029-1-sashal@kernel.org>
References: <2026071359-gecko-previous-ef42@gregkh>
 <20260715013408.4110029-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>

[ Upstream commit 94579b02720bb63096312c4bc7694fd2f6df7cbb ]

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Link: https://lore.kernel.org/r/20220331113245.GA425141@euclid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 8932161637a65e..559ae13db3d362 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -341,9 +341,8 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 
 	ie = rtw_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2, (u8 *)&(pdev_network->configuration.atim_window), &sz);
 
-	if (rateLen > 8) {
+	if (rateLen > 8)
 		ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_network->supported_rates + 8), &sz);
-	}
 
 	/* HT Cap. */
 	if ((pregistrypriv->wireless_mode & WIRELESS_11_24N) &&
@@ -372,9 +371,8 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 
 		if (pbuf) {
 			/* check if oui matches... */
-			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type))) {
+			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)))
 				goto check_next_ie;
-			}
 
 			/* check version... */
 			memcpy((u8 *)&le_tmp, (pbuf + 6), sizeof(val16));
@@ -499,9 +497,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 	if (is_8021x) {
 		if (left >= 6) {
 			pos += 2;
-			if (!memcmp(pos, SUITE_1X, 4)) {
+			if (!memcmp(pos, SUITE_1X, 4))
 				*is_8021x = 1;
-			}
 		}
 	}
 
@@ -520,9 +517,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		return _FAIL;
 	}
 
-	if ((*rsn_ie != WLAN_EID_RSN) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2))) {
+	if ((*rsn_ie != WLAN_EID_RSN) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2)))
 		return _FAIL;
-	}
 
 	pos = rsn_ie;
 	pos += 4;
-- 
2.53.0

