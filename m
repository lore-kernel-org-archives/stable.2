Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724851CF4B
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907495; cv=none; b=f9U23MWF7c2OlvFZZ/t1H8jXVumq+kF9YRh+ZBQFmRzRYXR7yuVoOOm7BXtznQVIT5hpXR9JconM1i/KRtzhZj4NPfnAdpuVsyoBV9fOWurt5eMwffxd195LvM07awGHhm9WoPzGwwcTkY01BqQgPfxKwyFKPDnngSizae4Tlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907495; c=relaxed/simple;
	bh=n1xDH9bUSenRhSlm0EPcjKKSCrW0zDlVgo++KlH5wDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlIPiwIFnfkAIod+FXOStBWCJmjXhOv02fz3W9EZhMnEi7byDrFz8nifshgUOEhs5mEo22+ckC3vqUC6+V5Mb/A8Q9Mj8Gc753+wxNtZQe5ANkG/1JN513r4fpbCkOG9u2sBdV6l21xlU8LIDTD1Hb5lz4vbLMop4XsXQEWVHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmFsgf6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmFsgf6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A491F000FF;
	Tue, 13 Oct 2026 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907493;
	bh=qpPYPyfxK/OckbIbEyFjNcuO1T8ZxC786CII4LZbfTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CmFsgf6no43VRJoUmBF6RbemkJa+wCtbQopQsTTch4fNFI2TYBrRZm4Aa6+tTHgpD
	 uAzAN822Hpsl96KH4laFSHChVm5z7WzWhirZx8qahBI12zXFZyyc4j+bBfsS56Prfv
	 IpoZanTZhX2QwktLAM6QankxMd5eEA7sd3TWDGthCy7HQbstpOf0zPlJnY4vdGMRxg
	 WEr+QgRL8koUS0ccqgYB/jJojtLG8oapKwHqozWKPbRzzIcBHj6SHafLVScKyYmEfl
	 pEI6/bld9TZouUPHR6CxCyZu9GcpQ0tflV4ekTf4ab/FTi/IyNmBn4Wrkootn9vc2c
	 YtQp25aTf827Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	co+2cf741c3005abc20@bugs.sh,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] net: team: stop reusing skb after queue override
Date: Tue, 13 Oct 2026 12:04:49 -0400
Message-ID: <20261013160440.383603-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013160440.383603-1-sashal@kernel.org>
References: <2026101205-aluminum-trading-cda4@gregkh>
 <20261013160440.383603-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit b7454f1940c5e6d92e753853c476a769e452f30a ]

A nonzero dev_queue_xmit() result does not return ownership of the skb.
When an override port's qdisc drops it, the queue override helper used to
try another port or the mode transmit op with the freed skb.

Return the handoff decision separately from transmit success. Select only
the first override port under RCU and stop after handing it the skb,
regardless of the lower transmit result. Keep the existing success and
drop accounting.

  BUG: KASAN: slab-use-after-free in sk_skb_reason_drop
  Write of size 4 by task poc/5040
  sk_skb_reason_drop (net/core/skbuff.c:1240)
  dev_kfree_skb_any_reason (net/core/dev.c:3470)
  ab_transmit (drivers/net/team/team_mode_activebackup.c:49)
  team_xmit (drivers/net/team/team_core.c:1849)
  __dev_direct_xmit (net/core/dev.c:4934)
  Freed by task 5040:
  __tcf_kfree_skb_list (net/sched/sch_generic.c:43)
  __dev_queue_xmit (net/core/dev.c:4831)
  team_xmit (drivers/net/team/team_core.c:1846)
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Cc: stable@vger.kernel.org
Fixes: 8ff5105a2b9d ("team: add support for queue override by setting queue_id for port")
Reported-by: <co+2cf741c3005abc20@bugs.sh>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Link: https://patch.msgid.link/20261001182326.572045-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 0ccd2edfc9d41..6d7be450e57c7 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -816,7 +816,8 @@ static struct list_head *__team_get_qom_list(struct team *team, u16 queue_id)
 /*
  * note: already called with rcu_read_lock
  */
-static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
+static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb,
+					 bool *tx_success)
 {
 	struct list_head *qom_list;
 	struct team_port *port;
@@ -824,11 +825,11 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
 	if (!team->queue_override_enabled || !skb->queue_mapping)
 		return false;
 	qom_list = __team_get_qom_list(team, skb->queue_mapping);
-	list_for_each_entry_rcu(port, qom_list, qom_list) {
-		if (!team_dev_queue_xmit(team, port, skb))
-			return true;
-	}
-	return false;
+	port = list_first_or_null_rcu(qom_list, struct team_port, qom_list);
+	if (!port)
+		return false;
+	*tx_success = !team_dev_queue_xmit(team, port, skb);
+	return true;
 }
 
 static void __team_queue_override_port_del(struct team *team,
@@ -1753,8 +1754,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool tx_success;
 	unsigned int len = skb->len;
 
-	tx_success = team_queue_override_transmit(team, skb);
-	if (!tx_success)
+	if (!team_queue_override_transmit(team, skb, &tx_success))
 		tx_success = READ_ONCE(team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
-- 
2.53.0

