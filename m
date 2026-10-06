Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453C38AC9A
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324495; cv=none; b=cWzO7XEEANbuPNKzd71w2JV+e7ZgJ/nHoYTILlbWO2In87URLE1ZWcWEPbfZIUhEBuOxmMA5vt68oaihP4UIknurEx8P9oStFMnjl0HeUx1X7PVWroqzklcJ07PqNyX/1qoLtVJgRV07cVj8WYA3eBOYXYOcKMUK6iWdyZzSxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324495; c=relaxed/simple;
	bh=DKUk/YjMQQ+lswNcWWPnWriniz284Y/OJb71rLXF0CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfdFBxczXPciXRFdS9Pfkkus8b+jcBTGTo4SXQbW8XgGZ6mlBgJflP8vjANCGDt369uLmchVSoLdCYvP74f1zaiKyrlaCsr5LXiUlfbIzO4eQ7PTcbcbtehyvO2qwlx8WfrneD1RX5Bo877fbU27Yaf3+9jVuNDdIkxLCNrKGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhGmtaH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhGmtaH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605E61F0089B;
	Tue,  6 Oct 2026 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324493;
	bh=m1u6Ltdhtn3OP6JZbGwoE4J/jnfUhuEJXd912yis2XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nhGmtaH3hoGq0OsegqYbr8IXJZWykPnQlnTRXAh38kHiDo7Olecyad+o5KYRpI2MM
	 ifrudvRPMn7CZWPcTnD1L6YQ24St24PnRecPkJuKh3R5Tdnf0TTtf4+IwnXmLfPg/H
	 e2xmJkA5Kqeda5o4bCnnxOvUUfPhidLkLDNfT8adpZLEsZiCts1THCBCevjtlQULOg
	 /Lr4vv/xU2k4dJV2pMWb5e+liWayt9ODiMw0DIQShWb0cSgz+HSF/wZsJGMaixlXve
	 A6tDZdW6WYtB7Wo5SawskKr4ZiXN1Z4iIDTqfXJA9fwrVgerI0q9QfZxpBnc5ljIMj
	 BKpbHuF1ip5JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] wifi: mac80211: Add sta pointer sanity check in ieee80211_8023_xmit()
Date: Tue,  6 Oct 2026 18:08:08 -0400
Message-ID: <20261006220025.1049115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100532-destruct-relative-8c7b@gregkh>
References: <2026100532-destruct-relative-8c7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

[ Upstream commit 303f11fda2fa4c6f7aa86b8fa54aaee5e1ef181b ]

Currently ieee80211_8023_xmit() accesses the sta pointer without any
sanity check, assuming that only unicast packets for an authorized
station are processed. But the sta pointer could become NULL when
a framework to support 802.3 offload for the multicast packets is
added in the follow-up patches. Add the valid sta pointer sanity
check to avoid the invalid pointer access.

This aligns with some of the subordinate functions called by
ieee80211_8023_xmit() that already NULL-check 'sta' such as
ieee80211_select_queue() and ieee80211_aggr_check().

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Link: https://patch.msgid.link/20260604162403.1563729-2-tamizh.raja@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 4febc02cd02f ("wifi: mac80211: set info->band for 802.3 encap offload frames")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8fc72da0187d8..723b14381612a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4659,7 +4659,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
-	struct tid_ampdu_tx *tid_tx;
+	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *seg, *next;
 	unsigned int skbs = 0, len = 0;
 	u16 queue;
@@ -4679,7 +4679,9 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	ieee80211_aggr_check(sdata, sta, skb);
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+
+	if (sta)
+		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
 	if (tid_tx) {
 		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
 			/* fall back to non-offload slow path */
@@ -4727,8 +4729,11 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	}
 
 	dev_sw_netstats_tx_add(dev, skbs, len);
-	sta->deflink.tx_stats.packets[queue] += skbs;
-	sta->deflink.tx_stats.bytes[queue] += len;
+
+	if (sta) {
+		sta->deflink.tx_stats.packets[queue] += skbs;
+		sta->deflink.tx_stats.bytes[queue] += len;
+	}
 
 	ieee80211_tpt_led_trig_tx(local, len);
 
-- 
2.53.0

