Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13535E1D9
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127600; cv=none; b=SXAzvrhQneONy1wXMC2Rjef2cjllnlKoQj8tn2Q0sbm4zFpkW85LuEOye1PEF15Q98sqdLyYFiO2mUzLHpnQ/OHwIwBsRPhVhfl/qRx3K/BAiD15tMRmA8oGdzrfrAYaIPXTcuxKCHCOGV6klYcWhjXoUGOp5fK29LZ9xIUZ0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127600; c=relaxed/simple;
	bh=7eSJ4+xYqWJJSLSku13YS1y+N/gaYOxCCZMHnyokxSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQUcgxKKy6VHKDcwmoJDJfjssAVHIsqevtM0aRVOXL4CoQtHRRnAcwmLkaltJir/zHEh+j/ciq0OQsZhmteLVcMiyhWfOmBRL0fd42nCYarBPNCSIPXl5JOvq2EQehDpPu03DV2mh5dlUZ4PAqAxtMeC/kkY6k32u2clP0y0UsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2dclX35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2dclX35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C9F1F00893;
	Wed, 23 Sep 2026 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127599;
	bh=3jtfeWUl3AWpdIMezgwpLDjqF2ReuVhZaNh/dqg9Cw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2dclX35HPnCEsDi4pCcBi3DaMw+dlLvqs/liBaznCDPJFO7MkvRlgVtH9IzIJsab
	 4KeTeD8PN/tEeqxSIhLNjxj7Vy2BaBPXJILeMNkNcZzLj2z+v/Qea7DWeKcBqMlejC
	 HJhIDgIFk9GSmoxY4LMIf8rjdbN+g3Wf/5vnTzM+IrCU2lK0PjmDoy+djsADGeOQo3
	 YyC/GDe4H0m/N9nWsRuibNf1f8eMaubJT8Om26TIPCn5BJVHrqpRRcO5F4SgTGs0aO
	 Pbqr6X+BQydJeQxfJszxle9htL4TggbSnkThrlOfFdmbiw4J9LPIWARiZEyn01OJr9
	 NOb2t+qzYcMoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] wifi: mac80211: refuse to make a monitor active when it has no queue
Date: Tue, 22 Sep 2026 21:39:55 -0400
Message-ID: <20260923013955.878331-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923013955.878331-1-sashal@kernel.org>
References: <2026092223-support-ladylike-66dd@gregkh>
 <20260923013955.878331-1-sashal@kernel.org>
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
index aa03cebbcf931..a1f7827bdaa92 100644
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

