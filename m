Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081951AEEB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112219; cv=none; b=W2wR3DhxK5BjhgovFhQlAN0nuZBmHdjbbZWLgaZXK31qjd1MCQVHCJHxpxeDR9GmTY2vBq4MmDB8b+mNmkp23zsw+I8p3og+Om9km+j6vWwsP7r1yXShJobId2WMSGlI47Jz/UP9+5Z6qpdqhRyyQjHhIf7b8aoZBIkYf2brMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112219; c=relaxed/simple;
	bh=kDiiipXZyKDgU6silckznMeJlObf+jJ7acGjJZB8JJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrWrpxxoHHrnSFUEpcYV6MH4InrzJiBF9oolMOxSow+7TZlSdoY/O9Lp7lLxzjd6YAGw1FElT9IxBvQDPvBZuBLMJIpqMOtkOzzvBwhc563a+5mhJLVCeAzPyfEsn93YEcyGvyWr40O/x+DIUDn6WHDT5+wzvQidfIMz9m0iOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFl2F4UG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFl2F4UG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EEA1F00899;
	Tue, 22 Sep 2026 21:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112200;
	bh=rIQOy+uW8vucEhQA77hHygTbSDK0xI5RbdwKQz4cuYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZFl2F4UGDiPtOq5AGXNfefSIjesmmdFwUsVm7z92XZRW2+mm86OIwXq+GHPXd38SQ
	 hMHZ+n3BRSCRVxFMkpuDj84DM6p4H38VFuHxCSQqcZia9TSxqvS8a+8RS0u5a2SAJA
	 L3W+41ytYwD2CWsAnMNonYtIV2qAc17TGEF/4zLltrvHET91F6nv+5ntNWiQJX6mwV
	 iNWwKGlT6wj7Gz1U0t/UmwyJOqhyrKfLq0CTJJAG81gqRA5a1fwORHfy/oQDNPOvQP
	 BE+08ccewvGSeGNbGe0XZejQ4va9sQH6elGT1Kp+Bu2tLclVSHLnVgH1iBWtA7Fkxp
	 xEsEFSjTOuzLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] wifi: mac80211: refuse to make a monitor active when it has no queue
Date: Tue, 22 Sep 2026 17:23:16 -0400
Message-ID: <20260922212316.751278-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922212316.751278-1-sashal@kernel.org>
References: <2026092222-setback-rupture-f2fe@gregkh>
 <20260922212316.751278-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Devin Wittmayer <lucid_duck@justthetip.ca>

[ Upstream commit 2b04d6556964ae9f89819b86a0a7801e39c3aae5 ]

A monitor interface only gets a TXQ if it's created active, and one can't
be added later. Setting the flag on a down interface is still allowed, so
the driver is handed a monitor with no queue. ath9k dereferences it:

  BUG: kernel NULL pointer dereference, address: 0000000000000066
  RIP: 0010:ath_tx_node_init+0x49/0x170 [ath9k]
   ath9k_add_interface+0x10c/0x140 [ath9k]
   drv_add_interface+0x54/0x250 [mac80211]
   ieee80211_do_open+0x32f/0x800 [mac80211]

Reached with CAP_NET_ADMIN by "iw dev X set monitor active" followed by
"ip link set X up". RTNL is held, so netlink operations block behind it.

Refuse the flag when there is no queue to give.

Fixes: 79af1f866193 ("mac80211: avoid allocating TXQs that won't be used")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Link: https://patch.msgid.link/20260904200338.10829-1-lucid_duck@justthetip.ca
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b1176e9d81d48..1a399252a1886 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -116,6 +116,10 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 			return -EBUSY;
 	}
 
+	/* TXQs are reserved in ieee80211_if_add() and cannot be added later */
+	if ((params->flags & MONITOR_FLAG_ACTIVE) && !sdata->vif.txq)
+		return -EOPNOTSUPP;
+
 	/* validate whether MU-MIMO can be configured */
 	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
 	    (params->vht_mumimo_groups || params->vht_mumimo_follow_addr))
-- 
2.53.0

