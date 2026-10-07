Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02691340D90
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354283; cv=none; b=YVpDufbdtJu8YdXDDDMS1/yDdEI7gqshI1bc0O7zZtNCs3wYoPROEHVNq9b2UUsojq2BCv2IVdkYj6qp73vjGcAGivyZt3eveEdVBCFqAnttpzgESEmgjnsRvkkkkmkMMoLTGRTO8L+2ar2580wJ82FMjOkkv9qrf3NMP6Nv+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354283; c=relaxed/simple;
	bh=p2Y9SgsuYhWhOwsEhvUISERdjIpYFI1CmvQ1P0nj4gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL3tzFCQs4fy5P3rxGcDS3/2YgRqaVS9tlZgMtHo3n25Ha++yJ9hoWu0hRBkjvv56ZcWCBCHZ4uai9Zvj5dINWQdLL+4StB/9p0DsPEgJJJ+BSbYVdYfa+KvLVsQMnzwgyELXUoLDMSYuN5iAzIMfBYMNeartzHLeaPe4P09GS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEo+5sYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEo+5sYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC8B1F0089B;
	Wed,  7 Oct 2026 06:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791354282;
	bh=Nh/KwnVw4hXFM6K89RSqkiQwuucvENon9r8mJRnCgDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QEo+5sYLzxc7qxrwlOTPfN1yieo+HZyuGbfUP0YenEMNuLh8CjkgrdqsOHK/DKN7Q
	 ZHsRId/eD3bNI41lF4Hj84fsQIkjcyv9W2kl+xY5AbXXqrweACQy14Ao5n4N5z/HV9
	 5vyPFzszHfjD5jCZLrrTv5YV3hjIHEpUAfc5sGkRaOn/xI0+MoOL87ULyjKfLQdset
	 UMfSo2sDjoWeU6z74v9/qdoNp+tZHsYs0RvaqyHFsMmMBAybqhwLEadJwVOhLMM4ww
	 b6wYHSM9QFt0tnc0W8+EPGAb+ZL8lN7fxjpn/zgt+sENPM6QWXnM+O++cGjp4sfxre
	 g2O01RTNCY8cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Andrea Pesaresi <andreapesaresi82@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: mac80211: set info->band for 802.3 encap offload frames
Date: Wed,  7 Oct 2026 02:24:39 -0400
Message-ID: <20261007062236.1622424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100534-stonewall-borax-0afd@gregkh>
References: <2026100534-stonewall-borax-0afd@gregkh>
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
[ sashal: adapted MLD-aware channel-context handling to unconditional vif.chanctx_conf access with out_free cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 87fc109595959..73b79a9611011 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4272,6 +4272,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
@@ -4317,6 +4318,11 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 		sdata = container_of(sdata->bss,
 				     struct ieee80211_sub_if_data, u.ap);
 
+	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	if (unlikely(!chanctx_conf))
+		goto out_free;
+	info->band = chanctx_conf->def.chan->band;
+
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 
-- 
2.53.0

