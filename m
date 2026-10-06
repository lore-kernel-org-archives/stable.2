Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20684DAFA1
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327727; cv=none; b=AXInt4gUvEwiC1o8N45AauOg9tI0JQLc0zeAhUTC3yLN1CpWDni5KXHQEnLeWZZIjPHP7plEfhXzzTXZml11cpGkJrfNNuAdIbdvctdMAHDvOOHijmTdUmQuPQrYb3ZeqRSSgBfb8Da80nGi19ggN74sm6xgDnTvVW7J6iH/gSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327727; c=relaxed/simple;
	bh=iJYURnkEB+UEyikgkAmIq5Ut9weqsDwJzqPiL9eRe5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT5Gp8bKbHWOkr7XdREiTUGTD7GFRLDVCv2+CCameEMDSptoxfged+EZfZFYV2x11k2nas9hkEtrOjDVmW7dgmOiy0CgfiGoo7GvxQe55dpU220DOqxH9LsOh43x5cNU/jpn1R4y7DaykG3obK6dYOPdyVlutCiJHRdt8X7PZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNfgWrMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNfgWrMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D421F0089C;
	Tue,  6 Oct 2026 23:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327726;
	bh=+obfekS1L4W+6IjeRfagK5lwf1hGFNaMBZyqrlqIKXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNfgWrMSBRbUK2/nQZlgwq8mKsSh9rs0XbzQeM63FOSiinD2PXyVsemH9pDLIcXQy
	 uLiLSfAyi0DoHfSuV+z8f+bJOBbk9IJOmAQ7cOB4xVAR+Kopu/ad1WRoZPMe2eLmIe
	 cD4RafEVNyQC1aGhiRcqzQLkEVd2ZcZInKFy/Ih/lG9kXTm+Kp2xnGTb8Ph9gChBe+
	 H8LXuf5C4Syz7RrfrTMM8kSfFtZiusDVoi8hZg1OYM238yu7q3izasSJ2g/yH9MkeA
	 xbBsVWOxj3Si4ASx2vIFl4GLpam2OcMekduSArug3YTGqGYThLR9e+ZNRGIiU9nGf8
	 i2j4dUXkYBMBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Andrea Pesaresi <andreapesaresi82@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] wifi: mac80211: set info->band for 802.3 encap offload frames
Date: Tue,  6 Oct 2026 19:02:02 -0400
Message-ID: <20261006225444.1158984-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006225444.1158984-1-sashal@kernel.org>
References: <2026100533-lethargy-enroll-444a@gregkh>
 <20261006225444.1158984-1-sashal@kernel.org>
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
index 931acf3bb6da1..cc7507ffaf001 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4623,6 +4623,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *seg, *next;
 	unsigned int skbs = 0, len = 0;
@@ -4672,6 +4673,16 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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

