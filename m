Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653401;
	b=oP1IqNBs2WgjYWg53ICKKsnXcErLqqWF0O5VaoHikMnfVNpKP/oIU9w3UlgicFJJO+yy
	 LFKu5tlhiy26RbUBKb4z3q/rJShh+Len3Jt6ozM35FXyeeYNg0EZVHqcc+a8W6XcPLMBH
	 KSlvajhnttRsya/fm8wTBPSR81eTFBS8heu4X65BLdGbk+Vto1dAt0yc48iUG+RD+uyUI
	 ModL1nPZBaYQxcc6xBYpgH9+xNtJ530D8RDzGHM10xnN1iLR4X3Ur9FRflBpAR4/S4WJE
	 kNvaNTKQPJa3M6hMJRfkapGofgu0cmD32FvkPOtGsxpU71t8fRPfbXB/6eZcMomkZ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653401;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XI1vibZyT4TcoB3+q9Ej9r2osyH37zBdqNJVHXqLwUM=;
	b=IM1+e6alDFhpcSGEfsb/iVAeTl1wxwml6dMBmFNBjChmGW0I5eNTQHvBsSVdbNrVxR/E
	 wo6fDLo6fkU0G5WWLvl6jTiFvl54EMcC756LqUniNQaVK/6sW2bIvSzJpdL6tGStTxRgk
	 3h91UbKQQ2PlTw68mYdi/+/JUmh83TAOnZIhdj3EBzR7U7X3IhS9RfsP5l6zWChGPvcTi
	 XgAfPT+H0CqvJY78r9lJAH11GW/oMxW4ZYzcJFsxGVFXLOM15USsUZhv9y/tw+Kiw3G+E
	 89S0QTwB6dUogALXmyv6SiN2rcjrGuRVH/MHcxpmoBbAHrZGvTUz4qgFp+g5kxSUlRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=YI76s4ff;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B60606A324;
	Mon,  2 Nov 2026 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=YI76s4ff
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XI1vibZyT4TcoB3+q9Ej9r2osyH37zBdqNJVHXqLwUM=; t=1793653400; x=1794863000; 
	b=YI76s4ffRxtnrepuMS5+071FcClMYqOlrmHtERABMfpWhlUDNLnsfklDYYJKm9rl3X6WaFfGmSk
	A6iyawkT93agLhyDjrO1LHnrG6FsyGKL/twauLM6CxAaRSA0nJxPbhspWM2gwbw5Ph1iXOKuSzA6H
	+ciQqZUSlh6gcfEmSMZETyOJQJka31O8Z9kEMQHDpzWQxRLyp/uFvdTVh1nLA+33XWWxHQIk3Njf4
	0lDsrJQYWS/WjceD1KAb4LS7xGTyTrLqjg4xGSGyWc9/OzCW/oAJyx3MOqpHgif7w9vYsNWu0QSeH
	vNkzUda1DKzD3M/jPqxEqQwEPVIg0dBGgZqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xNzBU-00000001xqw-3NKe;
	Mon, 02 Nov 2026 22:03:17 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: fix use-after-free on TTLM disconnect
Date: Mon,  2 Nov 2026 22:03:13 +0100
Message-ID: <20261102220313.3cf5e709417b.I339967c7e614057253aa68c005d9ae220577f99a@changeid>
X-Mailer: git-send-email 2.56.0
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

From: Johannes Berg <johannes.berg@intel.com>

If ieee80211_process_adv_ttlm() disconnects, and some other
changes were also detected in the beacon, the link update
to the driver is still done, leading to use-after-free. Fix
this by returning, like other functions, whether or not the
update was accepted by the function.

Cc: stable@vger.kernel.org
Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TID-to-link mapping")
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8eda8154ba3d..4e2e01d2f5d3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7950,15 +7950,15 @@ static void ieee80211_tid_to_link_map_work(struct wiphy *wiphy,
 	sdata->u.mgd.ttlm_info.switch_time = 0;
 }
 
-static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
-					  struct ieee802_11_elems *elems,
-					  u64 beacon_ts)
+static bool ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
+				       struct ieee802_11_elems *elems,
+				       u64 beacon_ts)
 {
 	u8 i;
 	int ret;
 
 	if (!ieee80211_vif_is_mld(&sdata->vif))
-		return;
+		return true;
 
 	if (!elems->ttlm_num) {
 		if (sdata->u.mgd.ttlm_info.switch_time) {
@@ -7976,14 +7976,14 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 						      0);
 			if (ret) {
 				sdata_info(sdata, "Failed setting valid/dormant links\n");
-				return;
+				return true;
 			}
 			ieee80211_vif_cfg_change_notify(sdata,
 							BSS_CHANGED_MLD_VALID_LINKS);
 		}
 		memset(&sdata->u.mgd.ttlm_info, 0,
 		       sizeof(sdata->u.mgd.ttlm_info));
-		return;
+		return true;
 	}
 
 	for (i = 0; i < elems->ttlm_num; i++) {
@@ -7995,7 +7995,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 
 		if (res) {
 			__ieee80211_disconnect(sdata);
-			return;
+			return false;
 		}
 
 		if (ttlm_info.switch_time) {
@@ -8020,7 +8020,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			 * switch the AP will continue to announce it anyway.
 			 */
 			if (delay > IEEE80211_ADV_TTLM_ST_UNDERFLOW)
-				return;
+				return true;
 
 			delay_usec = ieee80211_tu_to_usec(delay);
 
@@ -8039,9 +8039,11 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 						 &sdata->u.mgd.ttlm_work,
 						 us_to_ktime(delay_usec));
-			return;
+			return true;
 		}
 	}
+
+	return true;
 }
 
 static void
@@ -8535,8 +8537,9 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 					       elems->cisco_dtpc_elem);
 
 	ieee80211_ml_reconfiguration(sdata, elems);
-	ieee80211_process_adv_ttlm(sdata, elems,
-				      le64_to_cpu(mgmt->u.beacon.timestamp));
+	if (!ieee80211_process_adv_ttlm(sdata, elems,
+					le64_to_cpu(mgmt->u.beacon.timestamp)))
+		goto free;
 
 apply:
 	ieee80211_link_info_change_notify(sdata, link, changed);
-- 
2.56.0

