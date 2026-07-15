Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8725CC57
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114193; cv=none; b=ijDgFK0pWRFgJ/k1gkkOZr3xn9jIA3YaKUrOJveTEOURqZJCc79wTvPgiVJ1mI3cXU+A0WxIm1f4Ae7SlU59a5V7Podx8Ja78BS80Ipiws79+4PBMbcFaD+s9VH+YHo/9Yj/Ouy7YykijgfRKko+bjEd3KnY5McKtHcAJudRMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114193; c=relaxed/simple;
	bh=M/ok4w0hV9YxoAjKkAkGXd194HoRyfWBVammQj1BkOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kzg/x+aajmjc7SoabSNQdeymDAYO5Fbw1WouZ5c9nb889xYoN04aG02m43yoRv08vxltMPtDUGKHWkpeZ7gDyzLOUiohgAXLomNy1jNHsCzTVxWkR3HKPVkNX73oz1l0TJQsC9m9Y5XhNAM4UgED+q5k7dHn2tddHt2hSkiYBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9mQRMG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9mQRMG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD81F000E9;
	Wed, 15 Jul 2026 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114192;
	bh=EeYknLNpnCE46PHXN7geyV9bZuoxv6GCVx8O4EIrxJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P9mQRMG593GozVI8D0FUBuf4gddJDworlBrGTpN06kBjDiSupgI70o7ihOWFVyAFL
	 ag+fcRdhyNPaoZBUkT5g/54J1IHTcdD3u8AXqqqcK++clqViSMpeJab+BeyD4SmGfU
	 gq1OYQvtURz8GnP2AEmlEJszd4jXssdSdWWqadqPwIVAK1CAFNY/+qVu/2guerLtWy
	 99FvXoEcTF13FFEQ/+wGcDajMHF9y2Sj2uroxPhT2HS78iTjqs7Co069OYKRX9zvqS
	 15U88yQvi30/vsHZvdKucLxqZYD/CLCxnghMonRJYgj/7njiKlxiJw0AtxiuDR5VNq
	 yXonhYF0JroPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 07/10] staging: rtl8723bs: remove redundant braces in if statements
Date: Wed, 15 Jul 2026 07:16:22 -0400
Message-ID: <20260715111625.647536-7-sashal@kernel.org>
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
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index b1b1e72751045e..232158930be0df 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -360,9 +360,8 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 
 	ie = rtw_set_ie(ie, _IBSS_PARA_IE_, 2, (u8 *)&(pdev_network->configuration.ATIMWindow), &sz);
 
-	if (rateLen > 8) {
+	if (rateLen > 8)
 		ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (pdev_network->supported_rates + 8), &sz);
-	}
 
 	/* HT Cap. */
 	if (((pregistrypriv->wireless_mode&WIRELESS_11_5N) || (pregistrypriv->wireless_mode&WIRELESS_11_24N))
@@ -391,9 +390,8 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 
 		if (pbuf) {
 			/* check if oui matches... */
-			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type))) {
+			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)))
 				goto check_next_ie;
-			}
 
 			/* check version... */
 			memcpy((u8 *)&le_tmp, (pbuf + 6), sizeof(val16));
@@ -548,9 +546,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		return _FAIL;
 	}
 
-	if ((*rsn_ie != _WPA2_IE_ID_) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2))) {
+	if ((*rsn_ie != _WPA2_IE_ID_) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2)))
 		return _FAIL;
-	}
 
 	pos = rsn_ie;
 	pos += 4;
-- 
2.53.0

