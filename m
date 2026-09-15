Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265848032F;
	Tue, 15 Sep 2026 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499874; cv=none; b=kUQA2aB4j/g1DrMwQbLPjr7CJuqb6V4uU822S3R2b89weGeTpPPj+IYtAG9XFRkInJWEhAZbIloyW65scvOIO6dSrEn0lp2ykXQrwVnaFCHOWrce799UJ4IEZdr3eVNMfM1HFGfn4aNyd/3tdhUmCrFIgoRBAjd7wMetWy+dHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499874; c=relaxed/simple;
	bh=HEtmDRA5zLwWEp9h+ExDYWp/QYt/+gtoTBpm1+CZoh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SAH5yD66KUEldaVfkpuSCLlQdezL9pqrgj/aWdj2t9Ot7v37ProNddF6JyLU40VSpZxIdZbZGioEP2tw7QGaqQS7WnSjN7jbgEX7tnbtcOJ3e3B5zHBZFCg/AMwlzS9o0YnLi/vBUI/CvoAvFpHy0t7kIy0I2laBdAMBweOtua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=IqhrVPRM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qN1nSiAS; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="IqhrVPRM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qN1nSiAS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 259111D0023F;
	Tue, 15 Sep 2026 15:17:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Sep 2026 15:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1789499871; x=1789586271; bh=kL
	/93JevXkseqtHR2MRALLG4tXbZXprR3whdNg3lJ4k=; b=IqhrVPRMICzHldDB35
	sPkPJfIzZfVfzBo8KKU2iLP8ndoysnCyHR2oR6WJis6ieQ2hnez+9gGoX422awdN
	ji7POEcBX2nhqhG4h5/miZ6TCOlGtDhD3vyiJdEranMDrHI32nNE5SHd97aSXDdC
	5idqVJYWezRdcameM6aDgcLmHWxGvzNJ4Ucb1XbHSglykVDy6KlD3931lRU84+4Y
	7xGQnoir9Mzq/8dWu00nC7xhkg+o35BqOhLifzI4EGs326bNshKdmi4PMjJTX3hY
	eHbYDKrpAfK6iBYT5gV+xiJeoOAk7yagFN/Vrhn95JmCfgtAHgdgMF/2E176x8sM
	BaJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1789499871; x=1789586271; bh=kL/93JevXkseqtHR2MRALLG4tXbZ
	XprR3whdNg3lJ4k=; b=qN1nSiASNoqxTvB7BhyEazqHfp32sc0fId/u1skHYZ73
	6fnw/ftkFxGXcPXpxrS6FMpWlzAYel8FVEF38tN2bTWO+oRdrzKf7bPfK7pbp+bK
	fLqSQAGgeAsGVDZoCmmuJO3HAMs4GiVUsJjdazt7LBRQI2Tgp0RGz37gB/+blZwj
	NIKJZcNCddPjSVNH8aY+nNGIqywlMWWcgeBrjvV+EH62pxba0OEXVGeewePsGoXU
	rxOuzjFOYZfdKuZR2PxvRRGKSIacNTPXPoAfg3dnTzjVCe8m3E9srnCxiKUqrKYK
	YvK/JlM/nXA1WxgEIQ4c/EeGD6PvuV0Z7J8AIAtkng==
X-ME-Sender: <xms:3pmpan_DEGd0aoeceElQv-n_DiwmN27aNSGC8zKT-u2U1SVdBhjlqA>
    <xme:3pmpao6eW33OjKW2F0o_Oc_kxetMwSqcUNz9k8UaVrODUQgkKW1DP2CfmIN0mhIoO
    huBQUWnKbL6B3rrEukRnjHnFPnh6UWkYt33WHJigyUvpiETk12v_d5DtQ>
X-ME-Received: <xmr:3pmpaoaeyB7TwaUczkI37cwV-PCvOjn7bPOi6Zp2mHta2Df-9psjctHKbm3Muz3BGek7NLLYLp3lZYWlDznvohW3NlJy0JD7r-XGUQ>
X-ME-Proxy-Cause: dmFkZTFPD9DIFWH4dBf0RmdbyhFybkdA8aSAEjOnCr4cOVYtmYr/XFuP3pekHMdjZ5wbpC
    I4qxZ/mpuPPCjf/zeb+CTBzTq7wtaSDN7kM+yLUzrKW0CdFRuMI2KeQ6snZ2DwZ0Vzcdkf
    vwO3+RwcpitGHq31KTcE07LqhURP2LEjcX9fmL9UAkqiBR1qNbyxm6rzWf/xlSkf/N3DQu
    ehnua/DspimpK/JTsPdSDF4dXRntQbm18Ku6UJSyJAPESO0t6+3e5PLTtOuqIVaRAgbQ5b
    OMa7152K53zxutCS9hboXS63VArSIGQVCaIEjxFdZiUZRFlPDanDKme6BT92x3AsXvpnXj
    yY0IO6GDiQn15HQJ+vrtg2bjiEfYy0UaDGod+vSpLdVH0P54g8eCgmmcN9tLULO/Q5UUkc
    w+u/Cxz688JIAulmDAWHnKj76eI79FFGw6xeFKSMijCDSsgQHXdUuqEr8g+XolKKM87pE2
    Nr5zbXoDZVM5dCPIJlbjgVmuINHt/LXtB7/NveGBdt7grL/yOPkfbFunkCnQ7L5szjh1L6
    NNVhlaKa9wYgOzZbu5qVDYvVIPl7opPPCb2PTd5aIeqcXKtCZdTR5L2IdPyU9xk/PoThdG
    mOfLj91shtgGECImskNishxYDbg78BxIw2C+TciKx6kkNWbvqJF3FTv85gdg
X-ME-Proxy: <xmx:3pmpai8ifk_QwryZd_zx8wy1ogiNryBWQ8BaJdZcDT67uYNoitDHVA>
    <xmx:3pmpanRbOlOVhldM-cdHlH6JNshGtAlI4oRjVFefRVIZHyVUTObGvg>
    <xmx:3pmpalKo0wVpqtaIuSAjU4QWiADuzKtOVDIIW3Wq_Q9gAeYWx-thCQ>
    <xmx:3pmpahToqy7LcETtazZ1L-LyBq5jmfYlBLHWz7tPsequ79XxBeej9A>
    <xmx:35mpatVFyxMYKNZQTULrr_jLQbDS5nD9zO-eoM3MCeqG2LXWWL2ppbUA>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 15:17:50 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Tue, 15 Sep 2026 21:17:38 +0200
Subject: [PATCH v2] wifi: brcmfmac: cfg80211: Report port_authorized for
 4-way HS offload
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-brcmfmac-4way-handshake-offload-authenticated-event-v2-1-fbb9cc7ac177@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6WOTQ7CIBSEr2JY+0yhP6muvIfp4gkPQS0YoGjT9
 O5ir+BuvslkZhYWKViK7LRbWKBso/WugNjvmDTobgRWFWaiEl115AKuQY56RAnNG2coERUNPgi
 81k+PCnBKhlyyEhMpoFw09G2t2x5JVDWx0vwKpO1nW70MhY2NyYd5O5H5z/1vL3PgQA3HDnvRc
 xTnOzqH08FRYsO6rl9AmooQ9wAAAA==
X-Change-ID: 20260912-brcmfmac-4way-handshake-offload-authenticated-event-853f58ae203e
To: Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Hante Meuleman <meuleman@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
 Pieter-Paul Giesberts <pieterpg@broadcom.com>
Cc: Jason Huang <jason.huang2@infineon.com>, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arend van Spriel <arend@broadcom.com>, stable@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3825; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=HEtmDRA5zLwWEp9h+ExDYWp/QYt/+gtoTBpm1+CZoh0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqyVM+9+U1vZ0ncx5kukiGfEpHVZR/pjnsZqKXjGHKy9U
 asrdT+9o5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwER8eRn+B/DPqvn/YMm7v+L7
 5sh9us52Ij/7rm/mpY6PJ0pKV7dfEGf473aTOfq/7qXAuDiHTX4vTGZInpmeeS31/7UZTDcNT6b
 M5wMA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Since commit 416386060 ("Mark authorization completed on driver
indication during 4-way HS offload") [0] wpa_supplicant expects
NL80211_CMD_PORT_AUTHORIZED to complete the authentication when the
driver supports 4-way handshake offload.
This was apparently never tested with the upstream brcmfmac driver as it
does not report this. This broke authentication on Apple silicon devices
(BRCM4378, BRMC4387, BRMC4388) and other devices when wpa_supplicant
2.11 was released [1]. This was initially dealt with by reverting the
commit in Fedora [2] and other Linux distributions.
Instead of carrying the revert over to wpa_supplicant 2.12 add the
expected NL80211_CMD_PORT_AUTHORIZED when the connection is established.

The "Fixes:" tag is not fully accurate as this has only became an issue
after userspace changes years after the change. Since the change is
expected to be required in all active stable branches for wpa_supplicant
2.11 / 2.12 compatibility it is helpful even though
BRCMF_PROFILE_FWSUP_SAE did not exists then.

Link: https://github.com/zephyrproject-rtos/hostap/commit/41638606054a09867fe3f9a2b5523aa4678cbfa5 [0]
Link: https://lists.infradead.org/pipermail/hostap/2024-August/042893.html [1]
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2302577 [2]
Link: https://lore.kernel.org/linux-wireless/20260911065656.1269623-5-Jason.Huang2@infineon.com/ [3]
Cc: stable@vger.kernel.org
Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")
Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- rebased on wireless-next with "brcmfmac: add FT/OKC roaming offload
  support" applied
- updated commit message
- Link to v1: https://lore.kernel.org/r/20260912-brcmfmac-4way-handshake-offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 9d8ce7bb046e..3e30d84835a2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6585,6 +6585,21 @@ brcmf_bss_roaming_done(struct brcmf_cfg80211_info *cfg,
 	return err;
 }
 
+static bool
+brcmf_fwsup_is_authorized(struct brcmf_cfg80211_profile *profile,
+			  struct cfg80211_connect_resp_params *conn_params)
+{
+	if ((profile->use_fwsup == BRCMF_PROFILE_FWSUP_1X ||
+	     profile->use_fwsup == BRCMF_PROFILE_FWSUP_ROAM) &&
+	    brcmf_has_pmkid(conn_params->req_ie, conn_params->req_ie_len))
+		return true;
+	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE ||
+	    profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK)
+		return true;
+
+	return false;
+}
+
 static s32
 brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 		       struct net_device *ndev, const struct brcmf_event_msg *e,
@@ -6622,10 +6637,7 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 		conn_params.resp_ie = conn_info->resp_ie;
 		conn_params.resp_ie_len = conn_info->resp_ie_len;
 		authorized = completed &&
-			     (profile->use_fwsup == BRCMF_PROFILE_FWSUP_1X ||
-			      profile->use_fwsup == BRCMF_PROFILE_FWSUP_ROAM) &&
-			     brcmf_has_pmkid(conn_params.req_ie,
-					     conn_params.req_ie_len);
+			     brcmf_fwsup_is_authorized(profile, &conn_params);
 		cfg80211_connect_done(ndev, &conn_params, GFP_KERNEL);
 		if (authorized)
 			cfg80211_port_authorized(ndev, profile->bssid, NULL, 0,

---
base-commit: 42aa76b3fd9278a8504dbfaf0a449993104d2a48
change-id: 20260912-brcmfmac-4way-handshake-offload-authenticated-event-853f58ae203e

Best regards,
-- 
Janne Grunau <j@jannau.net>

