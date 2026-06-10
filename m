Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E531D74B
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108830; cv=none; b=itPw07kU+Q6rzu60Wsgl8/ZJ0IgDItdlXmlaPnJTKK2+Q++bqlcwqjU7nDPBNK6xZ6gsiY30nhDKWORg/mH7inaNSCt8aEgSroMtQ8Ecq/pRvueKSVm1t1znlIde3Cah5SO+YBrqt7toeNeRYBnNaTw42a3fctKiarR4iyocwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108830; c=relaxed/simple;
	bh=B78wIJqXokp8mpXgkSEPkPvItVTtbIMo5Q1GjtZt0EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=buIloHgxtm44sRC4btAUbzTGlwuF+Bon7IBFG2aVOyuoHmBpCaeqtiwQupREZ0R/AV04gbFcXG21YsL9cE9pn1s4pCChms0Djf7xGE5adX8UtTk2Xmj+v/ItERpVpxD80SRIAKfbsWCspfKIFSpmXd0QI/HwE0S3jUbPNAu3LXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH0U4B9/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH0U4B9/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so3782928a91.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781108828; x=1781713628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+erzCBLFlOAKM2dQsuv+OuH5Up4E4JpQcVQ6GV+20g=;
        b=qH0U4B9/vyOcYcbdFlnTjLMWt0jeVacI6FfXwRqZSe06n6pWqemhkrI6w2IMdpkWh3
         g4PH0oqU5tEjD75p0jSdGwX+fqsl4BEJ0X0a5e9ZWCLrchTlrBD9vrR6Q1514e1TAwe8
         PRsTq49lyzPLyb/6J1yFQGD2qxfWBL2uItOkJOnl8KBjokp+uNolDJgqp+qgLAA1f50B
         3/df3onk4FRPbhdLu42Op6fLFJEXv3CXqB5ElfWplVnbcMRFm0OljEXKtCtFCLFGIKAp
         xIsaVskr/2R2kjWcbyP61BT64QKnz+OKhCrvUK2+xtnd/FKbxp0yJ0VbBZFtWXwBZDFt
         PQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108828; x=1781713628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+erzCBLFlOAKM2dQsuv+OuH5Up4E4JpQcVQ6GV+20g=;
        b=ol1t1a1GLtNapI5pX/xOmCiBx1BxrGKiZWi4eS0OyRIODsPFBEUnHthugKj2NZFV/U
         yvP2IAleEoafPNuEXVp+ecNNdZuUrLtEYDVek9Y2LZa6bnhoMvGyPT9hWkpwRZSqxqUr
         nndM5cHncA4KXGn/BZjS+h/yyKmlnGYyAIfu1VoDV39k9CSAI8ZGsomWtBhgCQrex+zO
         yFGq2+YKEsfw0kWBAujE1cOS1Y5upeRKHS+rYIJLLq+e5UWGe56OqVDs0xR+xWN1qduL
         CwB1X3Hc5KK24f7yRohXuKMSgDIedkJNb3tLnTAU8NWmOaJ0bU083gLNTsB1hKY5PvHV
         i6/g==
X-Forwarded-Encrypted: i=1; AFNElJ/xzaFZejX5G6AH8DBDwuGKT5jfI5gC1cgZEzfE3G7enKGATeSwAAV9XJjM3v++S9xD98+Zwc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxttmy6f30GC7XdoFZp8flsExL+I048/yT7w+v9oIE0ROYrTn05
	4XaKN9NnR6GsESBWGJKq3yibTXKRDFZITKEzYpgWuS07uu5zfZf5vzQL
X-Gm-Gg: Acq92OGpG1ybfV61UvHhYcQHphwzRABWIkBLGuTzGg0OuBbLzys+Yxd65H9eaIBvNA8
	v02PZtmD26KMy6HltRJPw/3M6RvOckT3Sqk5jp4cvSsA/b07eeS1diuHGsSjgsPAx0QrAQhQ4rZ
	/06iaPPaWwFd3O9M9ggpKr2HM4FSG+MUyrwulmND5udQxJpeubvyRaLBcuTc4RGKvg25H7WJkza
	tG5d+kUyMflpRPUzFaJU5wML1eqNHb6H0dJA8Wd8KelzmRAL9mSSjZiM5o+iWbl3nb+Ayp31Wjs
	FUuYbJgjfkytIhQHQhHy6BRdQWqgvHfZplUYD6XIuOijlerhyV4ssfgH1y2CJte9ZD2i6e3CrA/
	/kHGKDRguGEq509Eg7HG2dRSXpJ8a7oQ9RMxOkG98el9pU+kuThFtqJXjbdbMJjHwRMi+dFTY8z
	el/xt5GAMxwBVhxbUBHX/jajzDrJvbsaFdddqOVSadUA7pN+hYf3Owt/kP32htgpKLvk3+o/bEu
	Q==
X-Received: by 2002:a17:90b:5787:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-370f0d52f5cmr28362494a91.23.1781108828061;
        Wed, 10 Jun 2026 09:27:08 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772ca3047fsm234011a91.9.2026.06.10.09.27.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 09:27:07 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Pedersen <thomas@adapt-ip.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: validate S1G beacon length before RX
Date: Thu, 11 Jun 2026 00:27:00 +0800
Message-ID: <20260610162700.58722-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S1G beacons are extension frames, so ieee80211_hdrlen() only guarantees
the extension header before the generic RX path starts dispatching the
frame.

The RX path can then reach helpers and interface handling code that read
regular 802.11 header address fields, which are not present at those
offsets in an S1G beacon.

Pull the complete S1G beacon fixed header, including optional fixed
fields indicated by frame control, before generic RX dispatch.

Also make ieee80211_get_bssid() length-safe for S1G beacons and avoid
regular-header address reads for S1G frames in accept/interface/MLO
address handling. Skip extension frames in duplicate detection for the
same reason, since that path consumes the regular sequence-control field.

Fixes: 09a740ce352e ("mac80211: receive and process S1G beacons")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 include/linux/ieee80211.h | 13 +++++++++++++
 net/mac80211/rx.c         | 33 ++++++++++++++++++++++++++++-----
 net/mac80211/util.c       |  3 +++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 23f9df9be8372..baee81fbb4a79 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2855,6 +2855,19 @@ struct ieee80211_tbtt_info_ge_11 {
 #include "ieee80211-p2p.h"
 #include "ieee80211-nan.h"
 
+/**
+ * ieee80211_s1g_beacon_min_len - minimum length of an S1G beacon frame
+ * @fc: frame control bytes in little-endian byteorder
+ *
+ * Return: the minimum frame length containing the fixed S1G beacon fields and
+ * optional fixed fields indicated in the S1G beacon frame control.
+ */
+static inline size_t ieee80211_s1g_beacon_min_len(__le16 fc)
+{
+	return offsetof(struct ieee80211_ext, u.s1g_beacon.variable) +
+	       ieee80211_s1g_optional_len(fc);
+}
+
 /**
  * ieee80211_check_tim - check if AID bit is set in TIM
  * @tim: the TIM IE
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3fb40449c6c5c..2e6d0ce8509e4 100644
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
@@ -4487,12 +4490,17 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
-	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
-			 ieee80211_is_s1g_beacon(hdr->frame_control);
+	bool s1g = ieee80211_is_s1g_beacon(hdr->frame_control);
+	bool multicast;
 	static const u8 nan_network_id[ETH_ALEN] __aligned(2) = {
 		0x51, 0x6F, 0x9A, 0x01, 0x00, 0x00
 	};
 
+	if (s1g)
+		return sdata->vif.type == NL80211_IFTYPE_STATION && bssid;
+
+	multicast = is_multicast_ether_addr(hdr->addr1);
+
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
 		if (!bssid && !sdata->u.mgd.use_4addr)
@@ -5175,11 +5183,13 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 	}
 
 	/* Store a copy of the pre-translated link addresses for SW crypto */
-	if (unlikely(is_unicast_ether_addr(hdr->addr1) &&
+	if (unlikely(!ieee80211_is_s1g_beacon(hdr->frame_control) &&
+		     is_unicast_ether_addr(hdr->addr1) &&
 		     !ieee80211_is_data(hdr->frame_control)))
 		memcpy(rx->link_addrs, &hdr->addrs, 3 * ETH_ALEN);
 
 	if (unlikely(rx->sta && rx->sta->sta.mlo) &&
+	    !ieee80211_is_s1g_beacon(hdr->frame_control) &&
 	    is_unicast_ether_addr(hdr->addr1) &&
 	    !ieee80211_is_probe_resp(hdr->frame_control) &&
 	    !ieee80211_is_beacon(hdr->frame_control)) {
@@ -5260,23 +5270,30 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 {
 	struct link_sta_info *link_sta;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
+	u8 *sta_addr = hdr->addr2;
 	struct sta_info *sta;
 	int link_id = -1;
 
+	if (ieee80211_is_s1g_beacon(hdr->frame_control)) {
+		sta_addr = ieee80211_get_bssid(hdr, skb->len, rx->sdata->vif.type);
+		if (!sta_addr)
+			return false;
+	}
+
 	/*
 	 * Look up link station first, in case there's a
 	 * chance that they might have a link address that
 	 * is identical to the MLD address, that way we'll
 	 * have the link information if needed.
 	 */
-	link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
+	link_sta = link_sta_info_get_bss(rx->sdata, sta_addr);
 	if (link_sta) {
 		sta = link_sta->sta;
 		link_id = link_sta->link_id;
 	} else {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
-		sta = sta_info_get_bss(rx->sdata, hdr->addr2);
+		sta = sta_info_get_bss(rx->sdata, sta_addr);
 		if (status->link_valid) {
 			link_id = status->link_id;
 		} else if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
@@ -5347,6 +5364,12 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		return;
 	}
 
+	if (ieee80211_is_s1g_beacon(fc) &&
+	    !pskb_may_pull(skb, ieee80211_s1g_beacon_min_len(fc))) {
+		dev_kfree_skb(skb);
+		return;
+	}
+
 	hdr = (struct ieee80211_hdr *)skb->data;
 	ieee80211_parse_qos(&rx);
 	ieee80211_verify_alignment(&rx);
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
