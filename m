Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704013;
	b=29BMC+UmLCGUucaavymYptYaA1qprIx5zt5PQsODJQYMyerG/wTybh7y2SCK3sEXuhvz
	 LkgDfyYeH5LLDY6PLBthfT5UaIPJIW8bD6EGrK9Zjjf0J0HzKCm5e07Pb/B1eCDg01Nlz
	 hBHziOgTeOAuDQgsYoIh/MYhUJU0WlO+3v4D0j0lQQli761FHJTxaoi1qHKcIU5olUZz8
	 A9ZLBrSIW25HoEWjzBKr/toMYRXUhfYuKk70WCGsaFq3Xp2eIU6XAdrwR+TnVygATZ884
	 ZtR3SphTgJjKbhdZ9/8VJNqSiurwUAWlZ0jpmHpC9aLKjQWTcjB+Icb05f2vtdmDwbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704013;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3s6r6uQsgyw51J/xpkAs4rKI159aXGfCjK6BzQ+pIp8=;
	b=QlwPOHwhdNUH6gZkEezZDmqwz7CbbPncjMvDEGpoyXozMIqQIhgcZs6aKCFumS2bSfw5
	 JMCH3sWMMgtRa8tt5VDS9Z9/2kJgPWS9ym+WKC0Id4RrxY2Hab0CHv91O2QQIu3etXVQT
	 D1aHRVwvOLy+3hCM7w+wquP2fWw78uky2Y5LdL3zKaf/gM2H5Oc6GO93I4Rb2U4APRdMs
	 1dFLuQvnIvXh7xuoUuk00A8NygLBYZZnVcKYWqcztKtJMu7W9F/mph1UIsDyI/voCb8t0
	 p5Tl5H9Ds8voEkmebfEMzGNRhKS3fPUDtRsZx+TOjMq7w/zoZ7FzBdzOmEoB5iA4IDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mo2rcKq7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463E6070091;
	Tue,  3 Nov 2026 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mo2rcKq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A0B1F00A2D;
	Tue,  3 Nov 2026 11:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704012;
	bh=3s6r6uQsgyw51J/xpkAs4rKI159aXGfCjK6BzQ+pIp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mo2rcKq7CqqioQK7xHc6HQmaTfv2DwklFwvtAw07GTItNhDgXiTI59K8H8WPxfcme
	 SCLX7WGnjt9jmlq07lyXHhEpwf6SZjtVdH9MS7aP1+0DNlkwqfpgcs8BqQW66FeXPl
	 fqPlgxHRwaslkQ6Bydo+qZnPT0dFZHGZgd03a9p6+XCK0SttLvJ5KxmuW2j9GEqoQQ
	 p8Y2wvl0pjYmAifOPMWQ88Xva8wUG6F2hU1fuxTXepgdwYOUeWTyUccDxw3W2VyQpA
	 F92Qqr+FOSxcHNh5QTgUjbQ6LIueWyrWqBs1ZNrNmLFZseXAZJEcf0/SsV/EYG+SEx
	 CQ0fbWhATRQYg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Jiri Benc <jbenc@suse.cz>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: mac80211: ignore PM bit in non-bufferable MMPDUs
Date: Tue,  3 Nov 2026 11:06:32 +0000
Message-ID: <20261103110642.260244-2-lee@kernel.org>
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

In AP mode, the Power Management (PM) subfield in the Frame Control
header is reserved in non-bufferable management frames (such as Probe
Request, Authentication, and (Re)Association Request).  Transmitters set
reserved subfields to zero and receivers are expected to ignore them.

Commit 9fef65443388 ("mac80211: always update the PM state of a peer on
MGMT / DATA frames") removed the bufferable MMPDU check from
ieee80211_rx_h_sta_process() so that a sleeping station that disappears
and later re-authenticates transitions back to awake (sta_ps_end()).
However, removing the check altogether caused the AP to honour the
reserved PM bit on all non-bufferable management frames in both
directions:

 - A sleeping station transmitting a non-bufferable MMPDU with the
   reserved PM bit set to 0 (for example, a Probe Request) is
   spuriously transitioned out of power-save mode.

 - An awake station for which a non-bufferable MMPDU with the reserved
   PM bit set to 1 is received (for example, a spoofed Association
   Request) is transitioned into power-save mode, causing the AP to
   buffer subsequent frames such as SA Query Requests.

Only inspect the PM bit on data frames and bufferable management frame
subtypes (Action, Disassociation, and Deauthentication) via
hdr->frame_control, avoiding inspection of encrypted Action payloads
prior to ieee80211_rx_h_decrypt().  For Authentication and
(Re)Association Request frames, where a station is always in Active
mode per IEEE 802.11, transition a sleeping station to awake without
consulting the reserved PM bit.

Fixes: 9fef65443388 ("mac80211: always update the PM state of a peer on MGMT / DATA frames")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Make non-bufferable MMPDU PM-bit handling symmetric across both wake-to-doze and doze-to-wake transitions
 - Expand commit description explaining both transitions and why Authentication/(Re)Association Request still wake sleeping stations

 net/mac80211/rx.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ecee9348c70d..29383fc85a63 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1920,12 +1920,22 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 	    !(status->rx_flags & IEEE80211_RX_DEFERRED_RELEASE) &&
 	    (rx->sdata->vif.type == NL80211_IFTYPE_AP ||
 	     rx->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)) {
-		if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
-			if (!ieee80211_has_pm(hdr->frame_control))
-				sta_ps_end(sta);
-		} else {
-			if (ieee80211_has_pm(hdr->frame_control))
-				sta_ps_start(sta);
+		if (ieee80211_is_data(hdr->frame_control) ||
+		    ieee80211_is_action(hdr->frame_control) ||
+		    ieee80211_is_disassoc(hdr->frame_control) ||
+		    ieee80211_is_deauth(hdr->frame_control)) {
+			if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
+				if (!ieee80211_has_pm(hdr->frame_control))
+					sta_ps_end(sta);
+			} else {
+				if (ieee80211_has_pm(hdr->frame_control))
+					sta_ps_start(sta);
+			}
+		} else if (test_sta_flag(sta, WLAN_STA_PS_STA) &&
+			   (ieee80211_is_auth(hdr->frame_control) ||
+			    ieee80211_is_assoc_req(hdr->frame_control) ||
+			    ieee80211_is_reassoc_req(hdr->frame_control))) {
+			sta_ps_end(sta);
 		}
 	}
 
-- 
2.56.0.313.g2479322e68-goog

