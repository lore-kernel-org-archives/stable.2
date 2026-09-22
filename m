Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64B386562
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101288; cv=none; b=XDOhrONEfp5mmsZp6BzS9mZkXr8M/96GztnppbEZi1nDDdRVMVdADP9aBMGUEZrm9xCa46udCjRUagiO6ySBTBrjty+3GGz1ADhImorMR09JULyvMSg010OThu5YqEn3OToys46Um/rnVIrvr0+NtyzWdykASfu7An6F844zLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101288; c=relaxed/simple;
	bh=I6XkxrY7pnS9lchxqZ8sZXRSiFl0RKqzxq4econ5Gok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTgBSN/0RDvBhMvXT5pzJfAlPV2pZH3zPIOumDT+eom1yYohZ1d0tzi5OYeVt1qiI6A4+ffiSc9sgYYxkID8tip0x+rVZrLI/Pyfb6g8v+5Fwwr9YBSJiqoInvLr1NhswLZHtemtwjwOubBLUNkGhf1iv+oc9SgZ05y+fue26I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYK/8VH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYK/8VH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408F51F00899;
	Tue, 22 Sep 2026 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101286;
	bh=EPwk8EowQ+c6OhEVw8n+lM3Xz+EQ0Q80qhtw78QCt2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iYK/8VH4/dzRWViM/Cz/P1JNqbNyq9q5aB1qxyLhgeed6vHD9RBYp9kd9JHpl3PpY
	 wE8JgruZ7f4iz1ygQORu7/1pPsd4dkJVtmamGo2YY+kwP2Vq7cFSXCmPU0AlVtcVzz
	 iml5duJW+tqUC5o9XzEVwBSpkDFvbJXeCdZuPp8rQu9V6s4JBUuHGUdfDoLzCZmoI4
	 91zAoSS76urE3rnEiRWDfnftFkAaoZXiWi85arGN9fGdux6lwuMdgs3qhAanTXLzhQ
	 nx7PXiTXShbqJsk6TJDOs8+tNMlaAeq4cisVkoJaWsGt0DaElF4MgGBbb2FNjpfqLx
	 ffzV19NaDDDSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] wifi: mac80211: refuse to make a monitor active when it has no queue
Date: Tue, 22 Sep 2026 14:21:24 -0400
Message-ID: <20260922182124.3570726-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922182124.3570726-1-sashal@kernel.org>
References: <2026092221-dislodge-perfume-02cd@gregkh>
 <20260922182124.3570726-1-sashal@kernel.org>
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
index 2aacbbb974139..7ca3218c620a1 100644
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
2.53.0

