Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614334A4F1F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105631; cv=none; b=JIW/JotzQpMXQpIvVnlYQ4TnC/B/aKi0SE6Shji2mM0MEfMCIKtE9fLf2MbytM0Hs6wvmTViUw6ehj0zQ5tS9lH94F/ecSiz4fklGPS42f3Y3pq/qgPsMj7m2odrPO29T5yTrZVc35+s2vRjOuXVRHl3or/us4fVgESDAGxvCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105631; c=relaxed/simple;
	bh=Yhe6c+BFdprl/QHBmq8qhxDnnJhzdIO53Ck87vaOA1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuQFRUeLXz59HTqSA9b389QCuEWStax/Q4vKNecjX83SYnQzW6jmHc/Wdx/omwbgOT5C30boGjuDHX3A895O++Hjhk60ZHKUYxcy167bCTMKbBKHp/N2YyzYDlyfXewut6oDef+hD7ow4X8hmcm/tP8jlU2mk4D6cynWJutDV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoMYueuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoMYueuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93481F00898;
	Tue, 22 Sep 2026 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105630;
	bh=GLyZXbxvsf6hmhwB80vHn7BoVvamKRrUT80Vb6KbM40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WoMYueuBTc42oa+HXIKoOHtsiUrdBxG1vGN9Er9FtwZWzC61KRCURcoB2t9YwSOx1
	 mcdlzDr2olm/iWagDNejQR1Wmc2T2dHL7p1OQ/zGzWFVJleC3fItcBMhuKT8Kg8WMl
	 U7ifKSkvMsdsbFA+zoUDOIo4NyQ/eQcy/b2ypkwHniMtqYsQr3hPctsShTHO7CX7EL
	 p1h1BUSOOI9Cz52birO8oODDYKt72bx+uOxZHJVmeVXWEjsnhsh0feh8O5QuWmYlY5
	 PX74FcGL1rY//ULZ98bj/JRFJFpcYAQ90AaHIoZV4XDB1vl1gSoS0YOOQty2gp1O17
	 8TlsphjkR7mzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] wifi: mac80211: refuse to make a monitor active when it has no queue
Date: Tue, 22 Sep 2026 15:33:47 -0400
Message-ID: <20260922193347.4153826-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922193347.4153826-1-sashal@kernel.org>
References: <2026092221-mashed-snippet-eb34@gregkh>
 <20260922193347.4153826-1-sashal@kernel.org>
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
index 02552b7ce01db..d29a517a41849 100644
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

