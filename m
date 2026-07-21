Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE5446840
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627133; cv=none; b=rDApPbGLIp7W7NAKOGmPwxRU+z2bRSWo2mccAQ9fzZ9afG/1BzjAA6VBD7VVPWPoyFPp42HGzE6gYcNAfZTLBg8JhV8QjCE9QQDMx2O+JfT7g9E6xO6OcMoRU7t8OKGpfxjkTSN3cChnNOGmdngVTG7NElziD9x3GcUGKkqS39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627133; c=relaxed/simple;
	bh=LajRcjZnzA0yk1hulLOTKYmEFzNAH/qBuky0UVBXaCo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fb55F+dKFlH3PdZiHDSUsOeEFJDfCnN4v5NOK8yk4z+/iscuaUVqN/FVo8ImS1Uhfi2qkhx7+Ln99DBxJcpJipMNfdNnIBHGvgJt8S6lARmvrFcGMZ1QpN9A6mSVkU1TEkKPQuaFsMJh1loqR6necG/BkrVZR+TFwVoFW4L5L44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4VD0qXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4VD0qXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612AC1F000E9;
	Tue, 21 Jul 2026 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784627131;
	bh=mWm5xNveGSHnVlNe0YvqprtZfME354T8utxCMfZILcw=;
	h=Subject:To:Cc:From:Date;
	b=p4VD0qXzsLSZsQ0yoew80Y7f/Hnub/aD/Lw3d+RHQhCy2eCYOuicRFbsMsF1xNML4
	 HQjjBdhtOiEWsVkJ7NFStI14v76g2bjrSYDv+6bpRRb+OZggqb1ZQ8VMTt4oNQs7T1
	 3zEAK3sETbK4DvHviuixikvyyvAYWr3UHOwKFnUQ=
Subject: FAILED: patch "[PATCH] wifi: mac80211: validate extension-frame layout before RX" failed to apply to 5.15-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:45:10 +0200
Message-ID: <2026072110-polyester-manpower-a59f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 57d503ce32eccfa7650065ca4c560f7e29a2e676
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072110-polyester-manpower-a59f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57d503ce32eccfa7650065ca4c560f7e29a2e676 Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Fri, 12 Jun 2026 00:19:45 +0800
Subject: [PATCH] wifi: mac80211: validate extension-frame layout before RX

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
Link: https://patch.msgid.link/20260611161943.91069-5-enderaoelyther@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index fb9a3574afe9..d9ea19be075d 100644
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
@@ -4510,12 +4513,16 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
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
@@ -5212,6 +5219,11 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
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
@@ -5301,6 +5313,13 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
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
@@ -5376,6 +5395,17 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
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
index f6d4ae4127c8..59f73dabe6e0 100644
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
 

