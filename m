Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6137267E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132667; cv=none; b=Qi5Xrf8gYN4eHSk2cUssJ27pXlzLw90HPEvXK4z5GKnah84FRRRHLgfKTugBnUAsXAxjnbCGfku0MmTyVUkw7+ahl+jG6oxPH1KaAIy9l1854PFU3Qf8tZW72Csy1LBVuRMlCEbjdPgCKLcYPPXTvTc0ZqlXErPT9kWwXsBN+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132667; c=relaxed/simple;
	bh=2l3Kgjx1jJi2TQ68E98utMz1YmaM0+O3afCGjVWkMgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqj7KW/5qDYdzhQQogaQp9VMHnYQVcLUN7S1+V5cVFcUtPVBXqmxM+uGv8ov6YRA35WCQ//jLQHnLj6a1/ItwCJYy7/8oBXBgjGar8RVDPkd7EbTeQVdJ6rKudqHhWUkZq1iZkOCt+N3098S8M4FxhyfW6vDe1IPHT6jCVnFZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxXmp8qy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxXmp8qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CC71F00893;
	Wed, 23 Sep 2026 03:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790132665;
	bh=POJVs3lt8lsien3Tn8SoiwxNm37Gwv/x77SneAfYGUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxXmp8qyXEUtu/zCsDJaE78OqhQ3/y1ArNkxTEAST5lLoKsDR24hADlQQsNyViv2S
	 71l4hfe71JE/YgVHD7Z+jt4dtFkh27unQ4lAlFvNWNC1O/qzHcHtnff1FcM55vAJvw
	 g3++HlGq2LfP+dr/mmpZwvtzyNHhm9TQNz/a2kjDwZOuV40+z4yZYC2dbcu8kaJzrY
	 QSqhXjgJy4qVw97K53lHkV1JgceIt8xnVJSnK7bD85rqEk+w7xjca7b8H/EnlFM8Y1
	 uWSeMpYP5nj0QZBCnsNAme1vfTLL+p1P79i/Yjt8DJv/dNAV3FcvGTFQuISA1iFi0a
	 MFg//LvejpY2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] wifi: mac80211: refuse to make a monitor active when it has no queue
Date: Tue, 22 Sep 2026 23:04:22 -0400
Message-ID: <20260923030422.1050587-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923030422.1050587-1-sashal@kernel.org>
References: <2026092224-stonework-unpicked-99d1@gregkh>
 <20260923030422.1050587-1-sashal@kernel.org>
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
index 88a49bbcad36c..07712a241a30e 100644
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

