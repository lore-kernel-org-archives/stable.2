Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6693D9026
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327725; cv=none; b=ojTwoNKFae8jNHG1rc35C1XBUya17lykaHnX7QeVI4gKURAuCuzb2rnYtiYUIauRQ9lQfpEOMYCn6ebg/re7+nRhEUh69Re7M1oiPSM0MA/AAzv8p/Wvyb5lDSs8AYXsRkaBSlW9BMOAnnsUPIRDMf5FXh0VqLO4CP+aPE86o/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327725; c=relaxed/simple;
	bh=wbilJYcLDQDOgvhKHeTz+T97LmRqnLoLvGbEKda8n/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNZh8FgIf2A0qBKd7xLLhG8w+3WM2jtjhQqBSN9kQQypC8CDTaP8vD6/IGYfYc11tHKYTB1hb3FRPdZkvLvqGB9qQ6jrPVNnr8DhqLYqgwHmu1xmBtdzs0f57sUm1lqNsUIfOBcB3+dsF05OcU/Hj095jGAEFjjb20nho+xYCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxJya6al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxJya6al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDC31F0089B;
	Tue,  6 Oct 2026 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327725;
	bh=r3vr35Len9+bZzDLZ3Y6Egdq4qgOgZJUeqnT2A53nvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxJya6altT2ZEyc9bjdk/cKhHWmXuWLLAhXFF/FpLKYKNJszrCVYB5QofWzXhhW6r
	 oyJH84rvUijSNXeTtcL4v+0Md96g3g11rUT/PbTyisGKdiUWws2QLni49zboGfXCMi
	 zPh0p0nDVKap7e1L+E8ZKAenTtjbrBPeYcHNzmMOJ4fjsZRleQ8zlmPYZJsLOtVH8I
	 a7Zcsu5lNxz8L/IzS9zsu7+RbC2o6jHRKcoKJo9ytnmRZIkPHyk216tyfInZRXtq03
	 r+j01Be/Oxt/HzxsD7rxPBDIZEvVzUHgszpBd18eZUJdFnlTeL5Dn8AJtHc5D6s+WU
	 J/499njQDO80A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] wifi: mac80211: Add sta pointer sanity check in ieee80211_8023_xmit()
Date: Tue,  6 Oct 2026 19:02:01 -0400
Message-ID: <20261006225444.1158984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100533-lethargy-enroll-444a@gregkh>
References: <2026100533-lethargy-enroll-444a@gregkh>
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
index e5bd558c9ae51..931acf3bb6da1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4623,7 +4623,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
-	struct tid_ampdu_tx *tid_tx;
+	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *seg, *next;
 	unsigned int skbs = 0, len = 0;
 	u16 queue;
@@ -4643,7 +4643,9 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	ieee80211_aggr_check(sdata, sta, skb);
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+
+	if (sta)
+		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
 	if (tid_tx) {
 		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
 			/* fall back to non-offload slow path */
@@ -4692,8 +4694,11 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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

