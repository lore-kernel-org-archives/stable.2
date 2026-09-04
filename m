Received: from mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0E348477
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552232; cv=none; b=kKuq6y+yWRt7MgGucJpd4NfKLpuZc0f5mdMfdrd1mMlzNwUktCnsT3/MTFVPAuCFjEfyl6iRRSzEv50gcByykqkT3yBqRRBVTIrf0UXECunCICvJjftr0re20g8B14H3jYJPpp8YvbovZMNTiYqytm8uAp7r7aZKcjR2h3LsOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552232; c=relaxed/simple;
	bh=qi6RHnGDCGkfNITqcvCFwcoWSmNWkH+un3Fby8LVM/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7gemzfY/5aVyEMDQ0h4OnEIxkBkFEcraawwG0OA/TOzjPWQHMMpnsMc3qr8phhCVJpWPhEdwIqSanSf6sHHStL8xnTDe2jFzZjkVv1V2DFlyPesfrf0x+urNEZLZNr+Ey4yNbjQ/koV6VNtb7lNZJ+DdqewhBU0PODbdFy08tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=vUExvtqC; arc=none smtp.client-ip=91.218.175.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="vUExvtqC"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qi6RHnGDCGkfNITqcvCFwcoWSmNWkH+un3Fby8LVM/w=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788552224; v=1; x=1789157024;
 b=vUExvtqCXp6WVeHtr2Cv7ZnN+0/rVxZ19W69DBHRoX26sJQBGwHVtZMn9IR5C+iJqVnNNVNX
 bw06bCKEehUOcoiM9RU94+6k7n4VlT7kyz/kGGaCusHqsOIa9Hwy9MVuWJgaEhGC/mZ5AK7Endp
 yW2sNZGbzfDnaOU/Wec7oymE1JkugZTINTSMiqJf+F5c2SNW4G9DrHeRfe2dqdezjU+5aDieI/h
 cA9wIvnbLunKfvf8AAsLIySTwDZn5TKYdxRjpdtoN8fq2OBAFshwgLSgJcRnGrruAXeq3yrydTb
 mzXt5K6yKD1VZlybeKMhXFQWA3Gr1IrdhC91GAatmc6hA==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7f571189813e464c;
	Fri, 04 Sep 2026 20:03:44 +0000
X-Mizu-Trace-ID: 7f571189813e464c
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless v2] wifi: mac80211: refuse to make a monitor active when it has no queue
Date: Fri,  4 Sep 2026 13:03:38 -0700
Message-ID: <20260904200338.10829-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Only drivers that advertise active monitor can reach this, since cfg80211
refuses the flag otherwise.

  crashes   ath9k, mt7603
  checks    mt7615, mt7915, mt7921, mt7925, mt7996

On the ones that check, the promotion works. A monitor promoted while down
captures the same as one created active:

  promoted        89, 89, 89 beacons in ten seconds
  created active  88, 89, 88
  passive         176

So this refuses something that currently functions on five drivers.
Reserving a queue for every monitor instead would keep it, at the cost of
undoing the commit named above.

Tested on a 7921 USB part: the promotion is refused, and both creating a
monitor active and toggling one that already has a queue still work.

v2: changelog and comment rewritten by hand. Dropped mt76x02 from the list
    above, it does not use the interface queue at all.

v1: https://lore.kernel.org/linux-wireless/20260824003656.27049-1-lucid_duck@justthetip.ca/

 net/mac80211/cfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 23f4f9ec86d0..8b47468dd5c0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -115,6 +115,10 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 			return -EBUSY;
 	}
 
+	/* TXQs are reserved in ieee80211_if_add() and cannot be added later */
+	if ((params->flags & MONITOR_FLAG_ACTIVE) && !sdata->vif.txq)
+		return -EOPNOTSUPP;
+
 	/* validate whether MU-MIMO can be configured */
 	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
 	    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
-- 
2.55.0

