Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558648B39E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059370; cv=none; b=GmtZsTYggD0vTFbL/ilI/xcd6MFK7Xyu/wichznNoZuw1Yf4VhADLjG6F5Jf1t5oGxSBIRoA4LXZFZ2b4FELJRAgAnqfMz7qf8ZLtZWNOzjQEzAhNZiOpdvdyFuVgbwgKIpodtsxFGmH3RN4XqgUqqWJv2iEAGcU27ArXKUCPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059370; c=relaxed/simple;
	bh=q0KKgdkJSW00aObGvbkyXc7XUjiixEKZxti/qwRfBDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHNocnwQkTU/thqzezbQHDRZApOBqKn/UclPb+Az9vQf1Th49++gxjaQSYhL7Z1o7grSorH5nREBSEGMzSpp/xKBaYJhYO1UPFZ7yTG7UCSEurbNqv0itiB8B0OnkeN6AaRzo2zYgcOtcSUEnvgr0fxQUFmN1PG7TzhsUl255U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEJjhdZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEJjhdZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27391F00ACA;
	Tue, 14 Jul 2026 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059363;
	bh=l0CWaKmBDtqOuXRcrEmcTqtZfuGnsGmFSzy30FWBrNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kEJjhdZh+FjW9jGMMLzxwot0NJ+srabZBcV0Xsq29WxQC8QFD0Ovguk4+N2TGHChU
	 1LrMp0W8u5UDMfym4D6Q8KXbOpQjCuSWq69KjDS5qB9seude+e6iyUVsFrbyVwTixS
	 gMXk4/5Dw0tl5oe6GfVK10mgMF4Z9g4/Q5MyC4QuZOrpaa8WTQ5PZtJ+pelCqlTRR+
	 41nM4RKfywKO8Tikmj8k4/TDGkU1gtYDBtch2tV6Xkiw4lhbLNnv9wuVPIskB66ndZ
	 D7tmIAFCIaz/irSS+bMiPPtr+ANGb8u0AvRUF5NjVO+4ZBemHYWQ6wajWhUZv4/ibZ
	 8ryW7xEtfd+mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Franziska Naepelt <franziska.naepelt@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] staging: rtl8723bs: Fix indentation issues
Date: Tue, 14 Jul 2026 16:02:39 -0400
Message-ID: <20260714200241.3154071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071335-fool-faction-0f5b@gregkh>
References: <2026071335-fool-faction-0f5b@gregkh>
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
index 08b8307b96d9e5..5bef829780c1b1 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -582,7 +582,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 				if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
+					psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
@@ -1306,7 +1306,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	} else if (request->n_channels <= 4) {
 		for (j = request->n_channels - 1; j >= 0; j--)
 			for (i = 0; i < survey_times; i++)
-			memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
+				memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, ch, survey_times * request->n_channels);
 	} else {
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, NULL, 0);
@@ -2811,7 +2811,7 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 	wdev->netdev = pnetdev;
 
 	wdev->iftype = NL80211_IFTYPE_STATION; /*  will be init in rtw_hal_init() */
-	                                       /*  Must sync with _rtw_init_mlme_priv() */
+					   /*  Must sync with _rtw_init_mlme_priv() */
 					   /*  pmlmepriv->fw_state = WIFI_STATION_STATE */
 	padapter->rtw_wdev = wdev;
 	pnetdev->ieee80211_ptr = wdev;
-- 
2.53.0

