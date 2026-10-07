Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE002347BD4
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351355; cv=none; b=rdny+XDElbzgPwMtmV7qXqOr9b9EqDBnAAwAm9T9qpR+iJ4RkUscWq2LdkeLB5lVHILyZKms891bMhekdCYJ/mID/d3ByfAOZn1auUn6qwQppOAoJgvzRa4nnEAl+pEMOteqik6ItdmHQVuFcPemH8m3BFvn6PVPgKs3U8J9zLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351355; c=relaxed/simple;
	bh=X+E0zVX8lRb97dsjzQvYwTZ8g0ryRG1f+PXDestYUMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fW+yF5ZE4TUNQwhJaOsW9DS6rjRly2W/l6u0H6yujurr/R6Qs+PwGSElmPwwJTS/2qjj62Bfb/NK/OfkW1GT4FMFJqxpJTmqeMRM32Xfm8zI8Q6bqIoWe3MH9S/x4vbj/57FCrK5XbO1jAr0teNjPAg/hUioZidkrAJEibwzLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEQUuGQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEQUuGQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB4F1F0089B;
	Wed,  7 Oct 2026 05:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351354;
	bh=KYQlwVv8qQDX+MF6D6wElBFRtFagrcHbqBzpBuSLw9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LEQUuGQPoB/RJS1vX/ASVBr/Sdx6pI5cdSiUYWffIE2u10fPhOuKD98WfzDqEn2hr
	 R5R5o0/BopWrAf+O0tJEYDBcp1otI8wmGnw9xz8bcjijfSfFOHp//tTJcovnzcUicj
	 qVlhVJdE+fgded/4ghCKSFuX3ajPA2n84t6hDpIpef+xCMKlwT6HIjbpjwA5L+zCA4
	 XODelgeDvy7aq4ljJXuqCKtb/BNOyHlaoYFBUNC2oZj56qZ1xAaSFV29JD7AaloKD6
	 TRjjFoSFwjFkA0PcSnj5hm1DM5ABuKEcUbUc0azVJZtyBb+mHz4Wt00zMmQmxmYkWD
	 pFYckGzuyDVhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Andrea Pesaresi <andreapesaresi82@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mac80211: set info->band for 802.3 encap offload frames
Date: Wed,  7 Oct 2026 01:35:50 -0400
Message-ID: <20261007052610.1195278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100533-tastiness-nuzzle-0ee0@gregkh>
References: <2026100533-tastiness-nuzzle-0ee0@gregkh>
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
[ sashal: Adapted helper usage to direct valid_links checks and single-packet kfree_skb() cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 00e8eda67f130..51cf8c4e0e90a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4545,6 +4545,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
@@ -4602,6 +4603,16 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 		sdata = container_of(sdata->bss,
 				     struct ieee80211_sub_if_data, u.ap);
 
+	/* MLD transmissions must not rely on the band */
+	if (!sdata->vif.valid_links) {
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+		if (unlikely(!chanctx_conf)) {
+			kfree_skb(skb);
+			return;
+		}
+		info->band = chanctx_conf->def.chan->band;
+	}
+
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 
-- 
2.53.0

