Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2575221F0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904560; cv=none; b=P7BJWrmJsp2wu7/s+Ico2cVqshd99opEPcO8OCQnvvq9zcu2iHVzrbK/L6orl0ucR+1u+YDo24ffNGdin6sD4eJaBkphj9eLS3rWdzGp8Jh21fO/UnCwpZSgnB3/R0HKaFEUg4YY3TkrhzczHXkRkzf813dXjFmutFlljaPhN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904560; c=relaxed/simple;
	bh=2BPigyeOI1hSqV+ozxmuroOuwA1MFhYApIiNszaAYac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQBbShBuqOE4irT5ClmAxzO3z0bSKSl4SlXBX9G6/SRhrdl4ZkWMKzMh/hauQ2hPDziuDBvDGyl0+SdC5vPFvgiHcpzWQO0gsNbhN/5rjm3G59TFsn7sxVu7q41QYsa23UrVR1JhEnA9nawRLBCuv7BmZP0mi4Jix6GcSwLtTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZXnw4UH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZXnw4UH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB1A1F00899;
	Tue, 13 Oct 2026 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904559;
	bh=XJeVjbfdPafIlCEwG5d3gMTajME1e7Sf+6w71jz0Chc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AZXnw4UHebgEaCwTkDBuIn7K2bFg2KmuXgRPN2s00C/YKCb8Xw8s2U/Tic4QrKShz
	 sTJMearqd7U0rAPkfwFnB4MiQAhCZ7MWhZ2MInL6NvHG7X5DiP6jpvvjx67/zy4pmp
	 GvEoGZcI9IxwRdNAfoxE5BGxQIU4aqiXKfFegIVCzobFe1p4YzpWv8HRWWFuxLoqm/
	 FGVKuLliFzSvECMCSsQCmYOcR2WfGrRxx/Ni/lr+enidi07GjJFJJJ8zjfYz04UC9o
	 iJWBwCtcBpHTLxNIRIXji+pks6LNmBsZjsKdgy58s+yvIAhhuUidqk7QSVqQsEYpx0
	 CLKKRtnuyP/4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	co+2cf741c3005abc20@bugs.sh,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] net: team: stop reusing skb after queue override
Date: Tue, 13 Oct 2026 11:15:54 -0400
Message-ID: <20261013151545.72467-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013151545.72467-1-sashal@kernel.org>
References: <2026101202-slimy-extrude-989f@gregkh>
 <20261013151545.72467-1-sashal@kernel.org>
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
 drivers/net/team/team_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 29d903de77da0..0cdcff2537c8f 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -821,7 +821,8 @@ static struct list_head *__team_get_qom_list(struct team *team, u16 queue_id)
 /*
  * note: already called with rcu_read_lock
  */
-static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
+static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb,
+					 bool *tx_success)
 {
 	struct list_head *qom_list;
 	struct team_port *port;
@@ -829,11 +830,11 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
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

