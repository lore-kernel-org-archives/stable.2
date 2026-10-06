Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AE37C108
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324496; cv=none; b=gcqmMP49FUY0M/Dk5L77meHONxuqXYxbEazhGvydSMvjHu/ZGYBI4kudjPIxYB4sX6BO0xBwOBeNp0XmMaM4rX71K5kmN2IYnWyEHroFA9NYkcPg9HDCsACZ9WHb7XpxOcnX0f7xk/F+xHo+1Mn+o6zy0DYgoRTQVIIeOpv2TiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324496; c=relaxed/simple;
	bh=UbFl6dWE2n/b4t1IkNWDVqDPokdkqreaX+/oOh34On8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKQIAKdPdoc4wIJ9Oxvj87EI1XODIt9iHgO6PZUoVcHvokwKH0uGKNv5j9t82OS0vcenCOX+7QjFPP8tkzUL0RzfmPTJqLOUjhv+ryDU4CAvOW6bz2peguXCkRYTCGURtYE6EoZmPvczQf7vCGeo76TFFCP+MlE/SPM0UhiPIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP12og0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP12og0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020D71F0089C;
	Tue,  6 Oct 2026 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324495;
	bh=pF2K7ni2po3bjk/71JEVun48rZV9fui71sFwDxU73sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RP12og0Fb1PynQAZK/1MxLdRWPEWIY9urdBldBbuae2EOjokVHOBV12gThTt5kgHR
	 U7JpsSBwkUlx/3xZgmMK2qLVLkjByCtUoqe5axw8ryDZThey3c3oXxh8y4mXXk5xOX
	 cBfjRkQSZWnQSiSfePu+vz4+0+0LkuxscMXS5Dbd1v9jpS0NLpCrFK4kF50bcubemn
	 BC8KxiC5QCd+I17e8kXdaHdV/R8jVwLibfT7ojpDzRx30h8aWEXMU9oqeNnKtOz3i1
	 bp5oQzi8GFBvQHEj93gF4UtPilv1t/Mo8lxQd14RS/XdN4wwrsT6WJe5GJCy+aONq9
	 fEBRLaClhDX0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Andrea Pesaresi <andreapesaresi82@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] wifi: mac80211: set info->band for 802.3 encap offload frames
Date: Tue,  6 Oct 2026 18:08:09 -0400
Message-ID: <20261006220025.1049115-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006220025.1049115-1-sashal@kernel.org>
References: <2026100532-destruct-relative-8c7b@gregkh>
 <20261006220025.1049115-1-sashal@kernel.org>
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
index 723b14381612a..d77f9f9810a02 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4659,6 +4659,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *seg, *next;
 	unsigned int skbs = 0, len = 0;
@@ -4708,6 +4709,16 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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

