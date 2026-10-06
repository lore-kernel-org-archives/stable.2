Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A437F739
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326022; cv=none; b=jl1WCUuog4Lj97nwLi2nT926vy1rc+g89+onVYMACvobnwvws0uF+R7wTJ0msPXCn4dSx3HiPjrElitsAem7bgaEsH6vCX2FO83EkOU7NNRVJBOrhiyWhVOQxydtDRjGMg32Jc7wmYfxk1w7MDvRFIP5usMWFc0nurHdfApBijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326022; c=relaxed/simple;
	bh=90dDTRV7Ska3t/xQ8smSobw26ayW4Sprvl2nVFZAonw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4CURVOvFYZpnIrNl0hnwCgJ+uV79WwoaPwQjE7oDFdSsvy+UkLnOzmAR0tyLVFHUbQSeEFiNBgLEO0IncfOjfn7rRo9ZflxuDH5+hty8dgfTXfbmEzr6IYh/ncH6+ZtAxv6IUTNITF0llH8OiAqNrlaon3cVbPJYLFHTvxZDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVdXuU4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVdXuU4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB311F0089B;
	Tue,  6 Oct 2026 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326021;
	bh=z9gipDBhXpv6eNQIAppafxf9iNTy/wYjKeNMY5qp3Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BVdXuU4KhK5g5HUXEyQpkLd4QNi366M3OVwESP1bukPk5SVCDQN4WRBvU7B4lp4/D
	 RCeUveQ/zjJor8tid0JW6xX556d7oAjFoT6sR0Uhw/78+/D44osiBREQbzbakoy06B
	 GXP5EZREtXqW0TpbiSZCeCqGeDHVQvTkLyFzJLUGlU2BOJ80ZHxLnz386AkGr5nmQ+
	 /+fiDQX4AqFh5PYOy3Sl+K/f1sQ677mlLWcZ67pvnHKG+8YauU7G2JEOrlsAg2RBtf
	 zxTKBvEZx5+nOxWO0jsWeWLLQf5auAlbiTNlpedW8qCKYYOtBNNZr8Eo02TfCCRi5Q
	 D5GDs+joj79Yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] wifi: mac80211: Add sta pointer sanity check in ieee80211_8023_xmit()
Date: Tue,  6 Oct 2026 18:33:37 -0400
Message-ID: <20261006222557.1120161-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100532-train-unsecured-ec6f@gregkh>
References: <2026100532-train-unsecured-ec6f@gregkh>
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
index e07bf5ba9b7a7..8ea17ac862451 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4657,7 +4657,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
-	struct tid_ampdu_tx *tid_tx;
+	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *seg, *next;
 	unsigned int skbs = 0, len = 0;
 	u16 queue;
@@ -4677,7 +4677,9 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	ieee80211_aggr_check(sdata, sta, skb);
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+
+	if (sta)
+		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
 	if (tid_tx) {
 		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
 			/* fall back to non-offload slow path */
@@ -4726,8 +4728,11 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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

