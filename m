Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62B2F616A
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353513; cv=none; b=IGjqz52r4Bc+Nf80Wi4mupzYvCflpuTv9AwBKFMQuyJyfxL2c3VTVt8Jr1ktJylgiaeX+6JVM1x57tqMFw2XPNRenJSv+T7ifdfxONGceVsZhMC8orSqjiCGPWCOwDxdFXW63kizz/1V5kT43noXjA9t92Il6AgHICNtMM7LOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353513; c=relaxed/simple;
	bh=ygi8rZPnU/27Isf9aJxI1MNhrm+xvHj42T472cG8K1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q81fYfPM8ub8wK6mjSoYbanYJ2e04QUoAvet6z6r/ctS410pqdmNjDz8JTcOgFqxIPUjVujxLqq/+DdoJIXtMMEO49HgCZwfXUmhQQybqicQ7YC4AYKp+TJFQeaY1nArEjBrtcXOCbhYYnsd1y7SQWbeqdNyap04EKhPGSUiUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYbqiqS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYbqiqS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E415A1F0089B;
	Wed,  7 Oct 2026 06:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791353512;
	bh=fSrYGvzNvS6+qamV3LE47IX/OVt8m/PE36uq4FmlSwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TYbqiqS2mfTNAs7w9578yhNfTmpeaTv0tAZH5YdXFE37GfZtic3xM9iIVNYePGHFY
	 iUhuI47m0TcSTug9zO9aqAhXXR1nf/XsyqDiMFrzWWBZ6wYs42UoEIrt5fwT70Pf3T
	 i31BGVxCrUoQBeYV7OKylAtVl7SeiZVlWvdlM+6jIJWMWZ6ak1aGihg9IeLXWZzXwn
	 sqrG231zGJpio5opQU68STXt1sqhZktMf9EcAG/e2LJhDw802/LV+a7mCYeOe1Ad3M
	 d7uo8j0fCoiM089btDIdQL7vAGJfrGzWYN6Sm96yytdSMEH17FDLabTLaesQphPhwP
	 89wnLwkwq5A0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Andrea Pesaresi <andreapesaresi82@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: mac80211: set info->band for 802.3 encap offload frames
Date: Wed,  7 Oct 2026 02:11:48 -0400
Message-ID: <20261007060910.1495101-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100533-rarity-deafening-ae05@gregkh>
References: <2026100533-rarity-deafening-ae05@gregkh>
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
[ sashal: Changed vif.bss_conf.chanctx_conf access to vif.chanctx_conf. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b7865f3b97879..a919d585b6b1b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4467,6 +4467,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
@@ -4514,6 +4515,11 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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

