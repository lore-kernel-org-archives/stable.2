Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0F51A127
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907495; cv=none; b=ikLS3Y/o8uxPzQ9G3KykeaIcmwr7b9Sh6PsFTYdu8XQ7d0UtrsR7SYGK7RShjOUAHFBQwCN8IJg3Eb7tBUY83C5pKnmYdEbGbNlYFNw/4vWh/1x3NYM6WN+Kbc+MH9Hn64fHIY/Cfh16/3DFu7wkQRw3f5l8TAv/hBZIRV74rxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907495; c=relaxed/simple;
	bh=ztGjeMoV7U9cVInc7pb+sVMZwqjRXvQ331oTvmLeTWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IR6arqg0VPtpTe0ItQWzkDJQjzbcqCOXyV/XXK38RBIhM0dw/Dw+UK43xm4aSES8NDNqPcwnehe1rzSqnNgxYAUKWX7bu/yvj9qviZ8TN5cSWSegj43xvP3cAXjP8YKMRah8YF5VnhlK3YI+EKVuqpc/k/i6GXM1jfmxuQ/cu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf7T/OBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf7T/OBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AB21F00893;
	Tue, 13 Oct 2026 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907492;
	bh=LqVFbcrR+t2XZ4M2VXi48D4FkKzuKKCRyvQkPxaYyFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zf7T/OBKHvWYrUG9XQmF8/NxctxH18fzyolYEJwjVqpWvmupx3EOPBqDXW3u41dNT
	 oGhfyiHw5gZCGPCAwEmnP48T+sjK4EIOU9yoSD9KQwjAOStSBdKKdalAljz1luRA5/
	 Gy4NUcKWS656nJJNSkWXpGGGI/PtdfYuIIwRIZRblcz06dVYXhOyYMppkTSdXvCM3Z
	 zUfQ0bH4IUVF/yX7zT3ycI5ZLxlOGLmZP9jQl49n34cLgP9vR61ZRbX759Q0JKnvzr
	 KJgm/aAHQoApUQtTVJr5UWRIy5K+3/LVzElUR5A2W6QiGjnTnT7ETisgK7rzE1nYUO
	 QL1tf3MhwZy0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] net: team: fix NULL pointer dereference in team_xmit during mode change
Date: Tue, 13 Oct 2026 12:04:48 -0400
Message-ID: <20261013160440.383603-3-sashal@kernel.org>
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

[ Upstream commit 25fe708bbc59289d3d1ea4b126fbc1b460a072a5 ]

__team_change_mode() clears team->ops with memset() before restoring
safe dummy handlers via team_adjust_ops(). A concurrent team_xmit()
running under RCU on another CPU can read team->ops.transmit during
this window and call a NULL function pointer, crashing the kernel.

The race requires a mode change (CAP_NET_ADMIN) concurrent with
transmit on the team device.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 Oops: 0010 [#1] SMP KASAN NOPTI
 RIP: 0010:0x0
 Call Trace:
  team_xmit (drivers/net/team/team_core.c:1853)
  dev_hard_start_xmit (net/core/dev.c:3904)
  __dev_queue_xmit (net/core/dev.c:4871)
  packet_sendmsg (net/packet/af_packet.c:3109)
  __sys_sendto (net/socket.c:2265)

The original code assumed that no ports means no traffic, so mode
changes could freely memset()/memcpy() the ops.  AF_PACKET with
forced carrier breaks that assumption.

Prevent the race instead of making it safe: replace memset()/memcpy()
with per-field updates that never touch transmit or receive.  Those
two handlers are managed solely by team_adjust_ops(), which already
installs dummies when tx_en_port_count == 0 (always true during mode
change since no ports are present).  WRITE_ONCE/READ_ONCE prevent
store/load tearing on the handler pointers.

synchronize_net() before exit_op() drains in-flight readers that may
still reference old mode state from before port removal switched the
handlers to dummies.

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260521081159.1491563-3-bestswngs@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: b7454f1940c5 ("net: team: stop reusing skb after queue override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 45 +++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index c91dbd5262643..0ccd2edfc9d41 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -534,21 +534,23 @@ static void team_adjust_ops(struct team *team)
 
 	if (!team->en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->transmit)
-		team->ops.transmit = team_dummy_transmit;
+		WRITE_ONCE(team->ops.transmit, team_dummy_transmit);
 	else
-		team->ops.transmit = team->mode->ops->transmit;
+		WRITE_ONCE(team->ops.transmit, team->mode->ops->transmit);
 
 	if (!team->en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->receive)
-		team->ops.receive = team_dummy_receive;
+		WRITE_ONCE(team->ops.receive, team_dummy_receive);
 	else
-		team->ops.receive = team->mode->ops->receive;
+		WRITE_ONCE(team->ops.receive, team->mode->ops->receive);
 }
 
 /*
- * We can benefit from the fact that it's ensured no port is present
- * at the time of mode change. Therefore no packets are in fly so there's no
- * need to set mode operations in any special way.
+ * team_change_mode() ensures no ports are present during mode change,
+ * but lockless readers can still reach team_xmit().  Avoid touching
+ * transmit/receive -- they are already set to dummies by
+ * team_adjust_ops() since no ports are enabled.  synchronize_net()
+ * drains in-flight readers before destroying old mode state.
  */
 static int __team_change_mode(struct team *team,
 			      const struct team_mode *new_mode)
@@ -557,9 +559,21 @@ static int __team_change_mode(struct team *team,
 	if (team_is_mode_set(team)) {
 		void (*exit_op)(struct team *team) = team->ops.exit;
 
-		/* Clear ops area so no callback is called any longer */
-		memset(&team->ops, 0, sizeof(struct team_mode_ops));
-		team_adjust_ops(team);
+		/* Clear cold-path ops used only under RTNL.  transmit and
+		 * receive are already dummies (no ports) so leave them
+		 * alone -- overwriting them is the source of the race.
+		 */
+		team->ops.init = NULL;
+		team->ops.exit = NULL;
+		team->ops.port_enter = NULL;
+		team->ops.port_leave = NULL;
+		team->ops.port_change_dev_addr = NULL;
+		team->ops.port_tx_disabled = NULL;
+
+		/* Wait for in-flight readers before tearing down mode
+		 * state they may reference.
+		 */
+		synchronize_net();
 
 		if (exit_op)
 			exit_op(team);
@@ -582,7 +596,12 @@ static int __team_change_mode(struct team *team,
 	}
 
 	team->mode = new_mode;
-	memcpy(&team->ops, new_mode->ops, sizeof(struct team_mode_ops));
+	team->ops.init = new_mode->ops->init;
+	team->ops.exit = new_mode->ops->exit;
+	team->ops.port_enter = new_mode->ops->port_enter;
+	team->ops.port_leave = new_mode->ops->port_leave;
+	team->ops.port_change_dev_addr = new_mode->ops->port_change_dev_addr;
+	team->ops.port_tx_disabled = new_mode->ops->port_tx_disabled;
 	team_adjust_ops(team);
 
 	return 0;
@@ -738,7 +757,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
 		/* allow exact match delivery for disabled ports */
 		res = RX_HANDLER_EXACT;
 	} else {
-		res = team->ops.receive(team, port, skb);
+		res = READ_ONCE(team->ops.receive)(team, port, skb);
 	}
 	if (res == RX_HANDLER_ANOTHER) {
 		struct team_pcpu_stats *pcpu_stats;
@@ -1736,7 +1755,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_success = team_queue_override_transmit(team, skb);
 	if (!tx_success)
-		tx_success = team->ops.transmit(team, skb);
+		tx_success = READ_ONCE(team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
 
-- 
2.53.0

