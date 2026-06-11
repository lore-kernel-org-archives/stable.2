Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158B426EA0
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194797; cv=none; b=LMzDBR0kxL/riRwGPug99xsOrnoE3VJBWb8XetsClyNUz0sRUlHmD9fFxTCVcPPit9IW+V1RVrpKdkPKAo8RgrewrRDUacknofyGTofe3Cd5NFSiP9c+pJRfWR6DK5oNe7nU3WXEz1nLudTvu+bNHAmm2p4+wPh3WIfOIQSNKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194797; c=relaxed/simple;
	bh=DzgCdxPYJOePYwK5vrSfRjaSRfCOu+Wqxn9lMnTZ3f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8+ObkyP8PGyoTVuPAcTiywcN8/YBjd/d7R4Ke3AA8ruiRXCCRFkSwiLtotLCgNOjqlZI5QZrjuqzP+FXkwZOVNUBbX6Ga86cnryhPN5zbfVr3BCI94m2LFYgg8tk/j7rF1yTnPCXt2K1q1XWJiiF7t7twgojkA27xF4G8r8EPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo5L0Roc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo5L0Roc"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c85893bce34so3303877a12.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194794; x=1781799594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJGGrvtsDjeSpn6534BCemT2I+fldwyUkxnGoTosm9g=;
        b=Xo5L0Roc6M6vw7fhReDKl82hMQXbTf2/0nOBnCadyQWavqIfafuk5emW+MTmTySG5f
         70A7soOA/MGOpaMnAupp+TSIMDqT2Ol7aoXJVFNA8Rr+huwSB8emUZTjefuhnYPopHzb
         /r9IKpIbPnMHi6TCxqPrRXpm+bvzGj6dJwpfLHbQW7QhIXZVYOp3CTQ/LpaZ4wgmWMmF
         +tDZaDeif4Q525YSjFodN3ikNI+TMaCRWahOLrCLYCdTTMZDKjnr2ls73OjiC1JQ53D1
         gPHoIXJs9dCjIjyRVI1z7J9AgFLg/ps7ugvt/hu0cv/HaFkAYT+UufkjOR3SfRahNGpl
         d5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194794; x=1781799594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJGGrvtsDjeSpn6534BCemT2I+fldwyUkxnGoTosm9g=;
        b=a5GAtcnHISWhFuIii++kvAPEWKkbX19zO72t2hpz9w627WhePXCSLmCLncbSYpjN0t
         NVuNuepofst3h6pJ6JfRPPg/j8gr+V0r2BQSTFvTVrLnx5QfS8PQSACCZtd8/+rG49im
         VuctNLaSLu7UmA0fhz9FRZBceB9NVyxvwL0gq7dT6PkVKH8O4vONB9ZV2Q8h6W62B4Vx
         0cVKjHp2xiDS4hQvNYHg1RTONoddmqtGlM3a4AaOmyzB6uz0QdLJ7oB+XDHocJ2VAkis
         PvFc7W4TnqcuIXfGoUVL1M0WpyQdRnHCCSj3gESmzDEwV3mehEL+O3V+VzAlUCw4Lk9v
         pTEA==
X-Forwarded-Encrypted: i=1; AFNElJ/MlH3Z+ze4G28+ZgH9Ia5/3AIO4ljrNafG7JWsGsb0pY7m0Un0vCHbPDQs62w8wJ6MIl5R6J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyPqU9jxPM4jk9CpMeHQP9ELoLJ/vg1GyICzr59SIPHPaWK+P
	Dnfec63mI9JnStdXZkFEmcdeHPR9tH9/9+cWGO9be0r614pqDN7wmly5
X-Gm-Gg: Acq92OGmS+f4f8kLw19avdE+liDgSLEa2G4AkgiJsYD0JLJUKuzjFgdPK/2chrZYCGJ
	/IGkBqPfmD8hsDsLU7qz4uHeUpgi/o8fjtP/CELZ79MMnlbdIjqSXm57lUwNo9KJRC4x8CGKNq6
	05Vih6zey58WvqETnSzmlTjcVghhpOCHDz3VAeC5qKBfFlOyOtU0bcny60yNfUeJMsNDOdWysy4
	u2VXdOAixo7ZzouDcokrE15bkSsAzml8hrWKUX8xtQNKu4+goSbj6GPdZoy9xUzMXs9Naae/nlS
	Jaxm0B1lz6HxcK1+sKRSTDRubDNC9EFAFTqX2mESi07eMRJO6bp8ZVd6hgJ/MmoaQoRN/k0ch+n
	tkizIU60ZhIP67dHHRk3PAyrh9QbhhE++8lJeXbuwt8e9orQXRd/f5JRAsxwOc4yIyXs4/OgB68
	bcafdA/dNk9QgEmAN6XlhMBQesdYwfkHiuQK2po/pwVMKU4VDGkwl2+Whub7HA+6k=
X-Received: by 2002:a05:6a20:918b:b0:3b3:223f:d3f1 with SMTP id adf61e73a8af0-3b5e32009acmr3985763637.18.1781194794267;
        Thu, 11 Jun 2026 09:19:54 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865881640bsm2871231a12.26.2026.06.11.09.19.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 09:19:53 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Pedersen <thomas@adapt-ip.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: mac80211: validate extension-frame layout before RX
Date: Fri, 12 Jun 2026 00:19:45 +0800
Message-ID: <20260611161943.91069-5-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260611161943.91069-4-enderaoelyther@gmail.com>
References: <20260610162700.58722-1-enderaoelyther@gmail.com>
 <20260611161943.91069-4-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extension frames only have the extension header at the regular 802.11
header offset. The generic RX path can still reach helpers and interface
dispatch code that read regular header address fields before unsupported
extension subtypes are dropped.

mac80211 currently only handles S1G beacon extension frames. Drop other
extension subtypes before they can reach regular-header RX processing.
For S1G beacons, linearize the SKB with the management-frame path and
require the fixed S1G beacon header, including optional fixed fields
indicated by frame control, before generic RX dispatch.

Route S1G beacons through the station/default-link RX path without
regular-header station lookup. Avoid regular-header address reads in the
mac80211 RX paths that process S1G extension beacons, including
accept-frame, duplicate-detection, address-copy, and MLO
address-translation paths.

Also make ieee80211_get_bssid() length-safe before returning the S1G
source-address pointer.

Fixes: 09a740ce352e ("mac80211: receive and process S1G beacons")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/mac80211/rx.c   | 34 ++++++++++++++++++++++++++++++++--
 net/mac80211/util.c |  3 +++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3fb40449c6c5c..3ddde3e808364 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1526,6 +1526,9 @@ ieee80211_rx_h_check_dup(struct ieee80211_rx_data *rx)
 	if (status->flag & RX_FLAG_DUP_VALIDATED)
 		return RX_CONTINUE;
 
+	if (ieee80211_is_ext(hdr->frame_control))
+		return RX_CONTINUE;
+
 	/*
 	 * Drop duplicate 802.11 retransmissions
 	 * (IEEE 802.11-2012: 9.3.2.10 "Duplicate detection and recovery")
@@ -4487,12 +4490,16 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
-	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
-			 ieee80211_is_s1g_beacon(hdr->frame_control);
+	bool multicast;
 	static const u8 nan_network_id[ETH_ALEN] __aligned(2) = {
 		0x51, 0x6F, 0x9A, 0x01, 0x00, 0x00
 	};
 
+	if (ieee80211_is_s1g_beacon(hdr->frame_control))
+		return sdata->vif.type == NL80211_IFTYPE_STATION && bssid;
+
+	multicast = is_multicast_ether_addr(hdr->addr1);
+
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
 		if (!bssid && !sdata->u.mgd.use_4addr)
@@ -5174,6 +5181,11 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 		hdr = (struct ieee80211_hdr *)rx->skb->data;
 	}
 
+	if (ieee80211_is_s1g_beacon(hdr->frame_control)) {
+		ieee80211_invoke_rx_handlers(rx);
+		return true;
+	}
+
 	/* Store a copy of the pre-translated link addresses for SW crypto */
 	if (unlikely(is_unicast_ether_addr(hdr->addr1) &&
 		     !ieee80211_is_data(hdr->frame_control)))
@@ -5263,6 +5275,13 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	struct sta_info *sta;
 	int link_id = -1;
 
+	if (ieee80211_is_s1g_beacon(hdr->frame_control)) {
+		if (!ieee80211_rx_data_set_sta(rx, NULL, -1))
+			return false;
+
+		return ieee80211_prepare_and_rx_handle(rx, skb, consume);
+	}
+
 	/*
 	 * Look up link station first, in case there's a
 	 * chance that they might have a link address that
@@ -5338,6 +5357,17 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			err = -ENOBUFS;
 		else
 			err = skb_linearize(skb);
+	} else if (ieee80211_is_s1g_beacon(fc)) {
+		size_t s1g_hdr_len = offsetof(struct ieee80211_ext,
+					      u.s1g_beacon.variable) +
+				     ieee80211_s1g_optional_len(fc);
+
+		if (skb->len < s1g_hdr_len)
+			err = -ENOBUFS;
+		else
+			err = skb_linearize(skb);
+	} else if (ieee80211_is_ext(fc)) {
+		err = -EINVAL;
 	} else {
 		err = !pskb_may_pull(skb, ieee80211_hdrlen(fc));
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2529b01e2cd55..5bc719222a87d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -73,6 +73,9 @@ u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
 	if (ieee80211_is_s1g_beacon(fc)) {
 		struct ieee80211_ext *ext = (void *) hdr;
 
+		if (len < offsetofend(struct ieee80211_ext, u.s1g_beacon.sa))
+			return NULL;
+
 		return ext->u.s1g_beacon.sa;
 	}
 
-- 
2.50.1 (Apple Git-155)
