Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AA37E5E3
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066669; cv=none; b=q27N75t1xRADE1MZIJAlYyK8XbSAbVqaHPlwrQ4kWb0P9D+va7JpmtwrKBGOB329ZB1BvwyVULrONmmN/DLKEhVxnNJNN6BrSBhRz/sI2bobjpC82Y5r3AvT1lhwdKSlwmJ3w13B/CHkCEDDFkKYaUFqFvDJK7fdUB8pishPIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066669; c=relaxed/simple;
	bh=2BWY5JzF1bJ3x2ERLoLhO8/iydvhUqz19DWr5HodIow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3gD0quMK7H9PEQJ4715GCjISNIS6mIwnScyy+Zr1E1S/zIcNc7JQU8hRGEgTBD7wSpGy8V/DTGVd/4+BNOZvPD67y6X0CBioBNLG9NU+Gmbc1ZIToLKXks0jqy6Re2zxFH2IUQZOM9bMNGxatMuvpAhRZAIZtu77jPJb+vZgGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmAw+B/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmAw+B/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388851F00A3E;
	Tue, 14 Jul 2026 22:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066668;
	bh=DYGTL9vyCJxbykjQqTC/EFv1lJ83w2KLh3buMqs8PJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fmAw+B/Bhl6uwDC2bZck/rmma0nSevHLqwo6OXepSpr/Jq65X15uOKll7wnJhZF2D
	 Z+JUwLqzPz0OngAABK0VymDkwGVNrkjdiNmn21ZGEneOwZi953+9Fb83+rDW9yWETw
	 10AHLnlemlbHM+Gcz9UXHcXTriqFaGrJzDB/C+qllfhdMcgjl+RqVwqcHe3/PZOOs2
	 3v0rfyppOuRnnXXeXoIEhHq6iY1TPXEMrFBUc/QKCxVfrxOGpAjRLz8AGbTQjeDnXK
	 vLiDTHgRks8wbsYc0/rIl/h3F1yjab1BwLOgibpz3sZKNz7SsyMuC1TwoloCTJFdfJ
	 zQXj2R0bROtIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Franziska Naepelt <franziska.naepelt@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] staging: rtl8723bs: Fix indentation issues
Date: Tue, 14 Jul 2026 18:04:24 -0400
Message-ID: <20260714220426.3334125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071335-spindle-refutable-39c3@gregkh>
References: <2026071335-spindle-refutable-39c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Franziska Naepelt <franziska.naepelt@googlemail.com>

[ Upstream commit b59cba2309b16fa364df03e3693b8d45c3fadbd6 ]

Fix the following checkpatch indentation issues:
- WARNING: suspect code indent for conditional statements (32, 48)
- WARNING: suspect code indent for conditional statements (24, 24)
- ERROR: code indent should use tabs where possible

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
Link: https://lore.kernel.org/r/20230619180351.18925-1-franziska.naepelt@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 5a752a616e75 ("staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 6ac79b430acc97..bc340c6fdaf99d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -582,7 +582,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 				if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
+					psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
@@ -1305,7 +1305,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	} else if (request->n_channels <= 4) {
 		for (j = request->n_channels - 1; j >= 0; j--)
 			for (i = 0; i < survey_times; i++)
-			memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
+				memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, ch, survey_times * request->n_channels);
 	} else {
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, NULL, 0);
@@ -2805,7 +2805,7 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 	wdev->netdev = pnetdev;
 
 	wdev->iftype = NL80211_IFTYPE_STATION; /*  will be init in rtw_hal_init() */
-	                                       /*  Must sync with _rtw_init_mlme_priv() */
+					   /*  Must sync with _rtw_init_mlme_priv() */
 					   /*  pmlmepriv->fw_state = WIFI_STATION_STATE */
 	padapter->rtw_wdev = wdev;
 	pnetdev->ieee80211_ptr = wdev;
-- 
2.53.0

