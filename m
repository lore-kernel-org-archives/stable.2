Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FBE23AB9D
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129798; cv=none; b=c15q57JrXF6lFZnRDivqPOHvi5b+exSzX2IXf3bnkT+imuWc638POoCmHEoolwcNogxzJBKyd4InlQUrLHyD95sQrnQoCS9UYz/c0jVk4RiZslJD8EHjheqUal4l0id9idmgdtBL1SWt6Gu9egHEQ22tCaEeqHnIdPB9J3P1oBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129798; c=relaxed/simple;
	bh=WNyQAPHcMtxkI5xnOSY5+lak8E+zjNjXoO144Q6r3yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+dHwcvyCSO9oLq0K3dizXX6hvCBM3z+JrGR5HVKw86nlIGBZ3qEmBoLHNpmibLR2Yr2OCuT9bePOe5zbPrEWwfnA2KubA+YdSHJ34bzkcH/jgKBkEa6AKRx/UlvMgatXeUlQTZCCpW5sc4hIr2H96L6KJZvTUbFIvBYFtxZsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqaNpQqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqaNpQqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1481F00898;
	Wed, 23 Sep 2026 02:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129796;
	bh=flq5a9Q0ycFtbQvak424Sbnll0r71hjAbtmXksRjPeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqaNpQqoa3mWJdRQh2hZSd5XcQqxT50DpARM5ZBRg1ROfthZCYBzPKCZAVxDy5z3p
	 8G5XbfkWEKORX317+i4DcIkNn0hMPp7I/j3yujCFWYXlFt4RSN+w4lX10y6mQhJ/7G
	 rsRVq6EgU66qCZCNyMS1+hkLLeKHnhfb6Gj3B8j8msTGDiRcfxYYKweXLPwixcL94S
	 XqrgndYfH04ITvOyJecFU25l06rIZtbh/AkEElQbk1dzT+D0z5aCqRqQWpDY1lta0m
	 K0A6A0+uqlofMK4kySfT59YAJRpF3hUkogoNco47sJfII7izE+juSwptER9PYcc7Ek
	 nr01ZWPmEKRHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] wifi: mac80211: refuse to make a monitor active when it has no queue
Date: Tue, 22 Sep 2026 22:16:33 -0400
Message-ID: <20260923021633.902921-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923021633.902921-1-sashal@kernel.org>
References: <2026092224-dawdler-equator-70f2@gregkh>
 <20260923021633.902921-1-sashal@kernel.org>
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
index c019dd9af6866..514ac12414aed 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -91,6 +91,10 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
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

