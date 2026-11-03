Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704019;
	b=fDfaMBKzx11zKURMOikFToNAW5yemVtm+rKbLuMYMFHvGAkGG6+NwkSBJZR0rGRMJBbI
	 OhWfLBnjLMkDNMAPmiF84ys5xDTKBID/hY4hRTKFx/Cj5N9hrC9aPAAGhBLv4ckpJ4CIi
	 D9wJiQ7jQZfKsvtUUC7TQ9h/4IzBn++oHkOpHHldtnFXtf1RH1E4pB3EphbrQKogs4F1a
	 hH0qYKndTriBVOmpJlWhRs2m0JgImii+n2Qhybc9tkv6W9sw8gk2OVMC8h6pVX1me70e9
	 P9h77NqNM/Es5fCKM1tExbNezxuPq7J8mlWF4YmHtbuV++eifwJbWDGFhkAu8XoLt+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704019;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L/mN1pC2XVZusi6HS1x490eJxFziQ3Oja24KpyTNeu8=;
	b=ekeC+J0TK11SkPhAIttZjVSiNx+B+Dlp3sYeJV2OQtZNaZgp80zQTuup7NJGJMu6Jxm+
	 LxcOiK3tLWQENB04rKGlS+LuD8aSUcFEqcQ/nor6JgKxYXsqcLKJigSa8JiUi9A8bHdfx
	 fVX+ksv8hWd0ZqVAzFeNc7QmsKaKs3rby5Ys9016zf6s4TP/1PcrB8+wRNbusFeAI+9dv
	 L2NtSKgtEPXWUNf5OiUvz5IwrBlr3+ZxKMnfcV3Wl1U7oudNY36/abqyzQSCKAWxrVmaw
	 VFIbxPl5CTO5+wz0dpqHjAkwULfAOQ6VbEbGyjQxOYOVtpTlEwZsPvQ6E3qCbz1hvVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HknpvLCE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFC606B13B;
	Tue,  3 Nov 2026 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HknpvLCE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939341F000C1;
	Tue,  3 Nov 2026 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704019;
	bh=L/mN1pC2XVZusi6HS1x490eJxFziQ3Oja24KpyTNeu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HknpvLCELMseCRXmzPJN74VCtOCOja6wLUD8dwLP9L3Y+dNsdlouwkihXjx2pCmyU
	 creHvADwIMhg1wm3LrThGBXfUZUSO75NJA/aD7eVi+5PBM3Lcf9cySy57RBnPWpTfF
	 NwBM9zuXHTJ2SO88avJGdyFiVXeGDAI/GXqhKuCSIlGoZWhqPchJNb4m8skHnSytZp
	 2AYCa+WXxXTV/SSDrGiKEKH0cAN8ptQwOLeyVkM972H5M8/uBbvohmJ9CrXGSZBM4J
	 7efkmTy/t83mNbN3qMNsPBtwl3DRQQoQLwSac7ZRCyxdP0bxRJTAN6Xmvmj5tTDJSQ
	 /FgeMcSEZOGdg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Jouni Malinen <j@w1.fi>,
	Jiri Benc <jbenc@suse.cz>,
	Michael Wu <flamingice@sourmilk.net>,
	Rajkumar Manoharan <rmanohar@qca.qualcomm.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: mac80211: send wake nullfunc when TIM bit is set while awake
Date: Tue,  3 Nov 2026 11:06:33 +0000
Message-ID: <20261103110642.260244-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103110642.260244-1-lee@kernel.org>
References: <20261103110642.260244-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an AP's Beacon TIM element indicates buffered unicast traffic for a
station's AID, the AP believes the station is in power-save mode.  If
the station is actually awake (IEEE80211_CONF_PS is not set) and
dynamic power-save is disabled (dynamic_ps_timeout == 0, for instance
when power-save is disabled on the interface), ieee80211_rx_mgmt_beacon()
currently takes neither the dynamic-PS wakeup branch nor the PS-Poll
branch.

As a result, if the AP's power-save state for the station becomes
desynchronised (for example, due to an unauthenticated frame with the PM
bit set), an awake client with power-save disabled ignores its AID bit
in the TIM and never transmits a nullfunc frame with PM=0 to flush the
AP's buffered frames.

Send a wake nullfunc frame in ieee80211_rx_mgmt_beacon() whenever the
TIM indicates buffered traffic for the station while IEEE80211_CONF_PS
is not set.

Fixes: 6f0756a38fc4 ("mac80211: do not send pspoll when powersave is disabled")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: New patch per Johannes Berg's review suggestion

 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6ec45a9f7221..802c714ba852 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8286,7 +8286,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
 	    ieee80211_check_tim(elems->tim, elems->tim_len, vif_cfg->aid,
 				vif_cfg->s1g)) {
-		if (local->hw.conf.dynamic_ps_timeout > 0) {
+		if (local->hw.conf.dynamic_ps_timeout > 0 ||
+		    !(local->hw.conf.flags & IEEE80211_CONF_PS)) {
 			if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 				local->hw.conf.flags &= ~IEEE80211_CONF_PS;
 				ieee80211_hw_config(local, -1,
-- 
2.56.0.313.g2479322e68-goog

