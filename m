Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088337F739
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326024; cv=none; b=XVSPgWAfw8PY0p0Rh5tKLn5+cY2+dg9zOJAUU5nKcakTd0GqujBBsO+FLHsC3UbmcqmxXiHWQkoQWQt5lI/MppmgnVWcLzoxOHNz/BBlfMtmj0YRmcy72qkLRhWvaes9dCmfKumGxPqN+PA/kxCGhLaPwvmUjduqPbbXO2MzxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326024; c=relaxed/simple;
	bh=uUaLnL01xttqcdunl2GjnA3HRXQNj6LrP4ho9xAYOd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MudD1tVRI/cIU1N+56t8il5nGumfe4cwjK6+yfFNEYy9a1+n15BUEpNc/Qt1KLh8+ezJIybKu8lkWOqQpAPX4HJavsbxQHUCUz02XAuFvjojmKm/ihbBwtnfpeJd6Sgq3R0/x8GrBsjzwgLP/lh6rlF7pC91XSS+7vpgTDlo6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPAGEWA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPAGEWA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D393A1F0089C;
	Tue,  6 Oct 2026 22:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326023;
	bh=Z6iEaF14kBWKWJPC86h/UTr6HBrrrvZFgJfohzggeJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VPAGEWA3BrzSrixBXHg0i+8giGuBT5PsuO1+mL9k45j887MqW3fGZ2xg5rW6bWJ0U
	 uIJ+8jAZJMLb2ylNKvIBbYARpoIqWd94TwQBoRGjkeezkeHIKhhdI6jDonoIaI8mbp
	 TUAyQAgBdHN5R1FUDdxvLoWQ7w8hYt4AuzjTReGj2woyAMyLBAEM2JhHg3xv7KJHT8
	 tnyG90H+ExxJga3cfBZOgRy1sa4YAzPZjtCbo0b4zjlYnHK2SREsCY2vcWrfQmaMUU
	 pg0z8bhJ6m0WkByxDFqvR3Rym9zef4XO+RaT3D1hkEIDRs+W2LHG7QG4eXz74jOhC7
	 ch39EGBV9g9uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Andrea Pesaresi <andreapesaresi82@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] wifi: mac80211: set info->band for 802.3 encap offload frames
Date: Tue,  6 Oct 2026 18:33:38 -0400
Message-ID: <20261006222557.1120161-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006222557.1120161-1-sashal@kernel.org>
References: <2026100532-train-unsecured-ec6f@gregkh>
 <20261006222557.1120161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 4febc02cd02f021f2b6d0768332be643ef14a12d ]

Unlike the 802.11 TX paths, ieee80211_8023_xmit() does not set
info->band from the channel context on non-MLD interfaces. It stays at
0, so ieee80211_get_tx_rates() uses the wrong band for these frames.

Set it the same way as ieee80211_build_hdr(): drop the frame if there is
no channel context, and leave the band at 0 on MLD interfaces.

Reported-by: Andrea Pesaresi <andreapesaresi82@gmail.com>
Fixes: 50ff477a8639 ("mac80211: add 802.11 encapsulation offloading support")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://patch.msgid.link/20260926120216.4054712-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8ea17ac862451..0fad278d8f249 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4657,6 +4657,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *seg, *next;
 	unsigned int skbs = 0, len = 0;
@@ -4706,6 +4707,16 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 		sdata = container_of(sdata->bss,
 				     struct ieee80211_sub_if_data, u.ap);
 
+	/* MLD transmissions must not rely on the band */
+	if (!ieee80211_vif_is_mld(&sdata->vif)) {
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+		if (unlikely(!chanctx_conf)) {
+			kfree_skb_list(skb);
+			return;
+		}
+		info->band = chanctx_conf->def.chan->band;
+	}
+
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 
-- 
2.53.0

