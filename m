Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7F48EC68
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817033; cv=none; b=QJgFYEt2qsdhzloZ9hxL042ugDh3MTxSk/zICeqW6JVpJj0OmBLviSzXlgiPnTaewevntXpMHvrrUm65MkuD+PsHBrCvjQJaqZwq+hSOeaGuXlAO9IxtuvuaxKBXo8PCsoX258rsXPbL0XgSUjIZ6YzKBYD5GARDrq2Ejh5RnE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817033; c=relaxed/simple;
	bh=ZdkkE8u09Vq/Un7jvdFtk12e31tnsHp3Un10TZocO6g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cCUWQfLgM+zYvYaCvrJbqI3YnMbq8R2Kkp1dh8LSyGmzFzov3W2wrUIp7x1Qv+U9ujhze1gB68i+CxqeVIvfjuRvCDCumVlZWkUGaEXJl96ogL7vaBAyi0NVHXLo6TgZwz9UlwWG4LP1klXM1NVp9/30bEuaL++THB5whka/hSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zGAh1dQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zGAh1dQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F2F1F0089B;
	Mon, 12 Oct 2026 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817032;
	bh=sBY4QPC/aE4ZPbSQBCdPHi+lJ11lLhf2C+9x55th4fY=;
	h=Subject:To:Cc:From:Date;
	b=zGAh1dQKk9sosh3IPsDA4yfMWDyOgeCE2J90LGYq8qPdHeijuJlXHUo0npgxCima/
	 rCoFyUnPgUcYdHKeuEOYRFnNfihArtFsDn5mqhi8ijbJgrfxm1w8K1fDYcvvOeoW8J
	 +27TtQoWDUdww+fHuLw9blSdYYieUONP+Ocq7VfI=
Subject: FAILED: patch "[PATCH] net: team: stop reusing skb after queue override" failed to apply to 6.1-stable tree
To: bestswngs@gmail.com,co+2cf741c3005abc20@bugs.sh,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:57:04 +0200
Message-ID: <2026101204-platform-squealing-b6e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b7454f1940c5e6d92e753853c476a769e452f30a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101204-platform-squealing-b6e9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b7454f1940c5e6d92e753853c476a769e452f30a Mon Sep 17 00:00:00 2001
From: Weiming Shi <bestswngs@gmail.com>
Date: Fri, 2 Oct 2026 02:23:25 +0800
Subject: [PATCH] net: team: stop reusing skb after queue override

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

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index beffbe450612..ca75f08e3c59 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -820,7 +820,8 @@ static struct list_head *__team_get_qom_list(struct team *team, u16 queue_id)
 /*
  * note: already called with rcu_read_lock
  */
-static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
+static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb,
+					 bool *tx_success)
 {
 	struct list_head *qom_list;
 	struct team_port *port;
@@ -828,11 +829,11 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
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
@@ -1864,8 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool tx_success;
 	unsigned int len = skb->len;
 
-	tx_success = team_queue_override_transmit(team, skb);
-	if (!tx_success)
+	if (!team_queue_override_transmit(team, skb, &tx_success))
 		tx_success = READ_ONCE(team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;

