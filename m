Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAE5221F6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906014; cv=none; b=kdXCHSOMzHYlotllNeqTGtIUAeVJr0HdbaoxxOGHaqpHqsAxdk3yBS5W9Bg6R5Gl/LbhMCAVNM+8i2w4R/8w1b3V3RoV2+k7WZRKzy4PbVn7CR8fvpO4lQ6y79htRmjZ9z4tPcuohRu/xZP1n6FWZ1+71lS+kELXUy+2uhNHhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906014; c=relaxed/simple;
	bh=6G0s7FDOmQMxG/X2IQeP6AAbwzOyMYoi0RndtYMdHfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbycQyXXPvJwvsAcOpgGfDj5hj2+SkPkSCMpFoNtnSGIBpUPpLdWhTS5zjGcqw4rlmUAJC29xKWZpur/x/OuEEIkv6+PtL2Zx5BRcH7F5cmanu/vIFXPW/SjJHDC+Zc9bhKunPZEE3prir71rT6ZMukEfiqToTJN6YIgeHmt8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8Z3xhT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8Z3xhT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177FA1F0089D;
	Tue, 13 Oct 2026 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906013;
	bh=SbYgSOgG54JjvHKhWdk3BxG/e9waGtEVn/wCKoPKIgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8Z3xhT8UvnrQrYcOp/Ac3zbXKDxA3Bi5xerxwOqIIrWbgOzYrphtmRfHNIGqkXYR
	 O1lcqhEy6yonkrkpk1HnzHEyyGmT9Sa+EfXlIhdrM/tb03gaXPnqcITXmOiEY0C1C/
	 7SuYQ49RrFSNTY1JSi+/7sRF/B9O0ZDGezIouZsS2yof8UFJWAx8ZOYE7meYaWTxpR
	 oFZdQxbSQyP6C+k/bsMsZCS4AXk6lfDeMGhPgY8tfns3KpWkpjZobTG9Gf2ulh1WNV
	 hvU+J6yTEJsHDtLNlvhgLZX7aAHWmglu+T4G6+Ngmt0ezA56vkR9xlnpTQt2UimI56
	 QNn6BfJQjhkNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	co+2cf741c3005abc20@bugs.sh,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] net: team: stop reusing skb after queue override
Date: Tue, 13 Oct 2026 11:40:09 -0400
Message-ID: <20261013153957.280683-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153957.280683-1-sashal@kernel.org>
References: <2026101204-platform-squealing-b6e9@gregkh>
 <20261013153957.280683-1-sashal@kernel.org>
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
index 1812b8b2f73a6..874a8b78803c4 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -822,7 +822,8 @@ static struct list_head *__team_get_qom_list(struct team *team, u16 queue_id)
 /*
  * note: already called with rcu_read_lock
  */
-static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
+static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb,
+					 bool *tx_success)
 {
 	struct list_head *qom_list;
 	struct team_port *port;
@@ -830,11 +831,11 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
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
@@ -1759,8 +1760,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
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

