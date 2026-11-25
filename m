Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622872;
	b=dxvbZnRfN7ensy/+jnlTCSv5nmWHXZW+V7CIAQdHUoGTK/n6ak8mZ6WvaVE/t6VR9eIU
	 o9D5Lkatj3Ev+Mkcynlerkst6iOMjPXB6zRkk3ka9pZbFOZiIspVtvwKW+eNt82IaQGTe
	 SdH7pAvuOf14Ep+IQr9cg194pquGVlT2nKXM7gyxnkbpU8vmfzWJHJh0xamz08CYGrm41
	 WYW3+RDuML917fRCXhbjvW48WT2PfnPgNILbyYrERkf1Ym7F65AetLGN0AhuPKmBbH9wj
	 Q4KldchG8MuRxWr7Nh8nfZLloA7ys3YZH8RH+K+G1A6ftK0zderBuTNpKnlZp5+qBog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622872;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=edwjgHEs/f/PNXhvTOTJ+KqvpGk2IfreeUNTD8ATHnc=;
	b=fXrLksD3Qh7ELk0rkNrsTiNz5Kzqhl+7jn3lx68WTi9vsceRPvhjNUD37+OMcF4gKC3y
	 ZPj5TxvQKbEU2vZA2q58DDCDWjuVIMg1CIfmeWFM87yUC7HFFc6P/vDdfcg2CtEuw442x
	 0PHrZ88YDfD5+SjyTAt1f/kRfXsGZT3LQISZk+V8MCWV1IzrW8vcvOETj3IDfdZkrb2Ot
	 m6iNFsmTHYUDcC8mhq8ykn8jeggPacDjTLa7E+T44p38y8/vO46UD8lMOnGm+r5ESfWpV
	 kKJJbdzh32j4QQYqY/7Rp2MsRhdfxzxXy25qB0FwbkvoC6uxwYkS6bNUCyBOcVdOqzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVXJ7fGQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C4606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVXJ7fGQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA9F1F000C6;
	Wed, 25 Nov 2026 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622872;
	bh=edwjgHEs/f/PNXhvTOTJ+KqvpGk2IfreeUNTD8ATHnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nVXJ7fGQKDsRv2DjQD0ohM4YaiQFKgVbhR+ZkPd9CN6Dp1kKfw+x+VyOXVUHgt9hm
	 MmuywLeoSyKDT5m0bvHfkjOj3eBjtIudUTWdaG6SnOUqDV6xsJ0547mOz/pxG/lGPt
	 wQfbOLE1pQ/jERTED1Su2eb+GzkSbArwltT88BuxLe1Xu/DEI+/ATy7ezHbAOTGawU
	 IQHeDO9QuBq46EKfzopR5qJ0u4uS+NfLsVb/fJrgnkYi0x7RgeJcQ3delISPJJtycv
	 pnAvWi4mdjEKaS6uBOwqUJMMIplaD3em91Do9FrW3je4gvKNKC82bUD+FcYAIr4GdO
	 5KrRctECDZmgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] Bluetooth: L2CAP: Only accept LE responses to outstanding requests
Date: Wed, 25 Nov 2026 11:07:49 -0500
Message-ID: <20261125160655.662669-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112520-anything-mahogany-763c@gregkh>
References: <2026112520-anything-mahogany-763c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit f50b32aa233d4687af2d241ddcb572da969e8989 ]

The LE and ECRED response handlers match channels by identifier without
checking whether they sent the request. An incoming channel stores the
identifier chosen by the peer, so an unsolicited response can bypass
deferred setup, delete an established channel, or leave an unaccepted
socket and channel allocated after l2cap_chan_del().

Extend the BR/EDR lookup from commit a518b9a9ef6e ("Bluetooth: L2CAP:
Only accept connection responses to outstanding requests") to LE.
Require the matching connect-request flag and add a reconfigure-request
flag. Check reconfigure identifiers under the channel lock, since
BT_RCVMTU can replace a request without the connection lock. Match all
members of a rejected ECRED request, which share one identifier.

A reconfigure request can outlive close(). Complete it even in
BT_DISCONN, and call the close callback after deletion to release an
orphaned socket. Otherwise deletion cancels the timer and removes the
channel before the disconnect response or the channel timeout can close
it.

AI assistance was used.

Fixes: f1496dee9cbd ("Bluetooth: Add initial code for LE L2CAP Connect Request")
Fixes: 71fb419724fa ("Bluetooth: Fix handling of L2CAP Command Reject over LE")
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: <stable@vger.kernel.org> # 5.7.x: a518b9a9ef6e: Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Cc: <stable@vger.kernel.org> # 5.7.x
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ sashal: Dropped the lockdep_assert_held() and __must_hold() annotations, since this tree lacks them; the l2cap_le_command_rej() and l2cap_ecred_reconf_rsp() logic is otherwise unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 78 +++++++++++++++++------------------
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 84f557d354cae..b864d50bb5e59 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -749,6 +749,7 @@ enum {
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
 	FLAG_ECRED_CONN_REQ_SENT,
+	FLAG_ECRED_RECONF_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
 	FLAG_DEL,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdf92a3d57455..7ac5dd0fb6fe4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -139,23 +139,12 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 	return c;
 }
 
-static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
-						    u8 ident)
-{
-	struct l2cap_chan *c;
-
-	list_for_each_entry(c, &conn->chan_l, list) {
-		if (c->ident == ident)
-			return c;
-	}
-	return NULL;
-}
-
 /* Our connection request has been sent and is still outstanding */
 static bool l2cap_chan_connect_pending(struct l2cap_chan *chan)
 {
 	return chan->state == BT_CONNECT &&
-	       test_bit(CONF_CONNECT_PEND, &chan->conf_state);
+	       (test_bit(CONF_CONNECT_PEND, &chan->conf_state) ||
+		test_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags));
 }
 
 /* Other channels may hold the same ident for a response they still have
@@ -167,7 +156,7 @@ static struct l2cap_chan *__l2cap_get_connect_chan_by_ident(struct l2cap_conn *c
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &conn->chan_l, list) {
-		if (c->ident == ident && l2cap_chan_connect_pending(c))
+		if (l2cap_chan_connect_pending(c) && c->ident == ident)
 			return c;
 	}
 	return NULL;
@@ -4964,7 +4953,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	BT_DBG("dcid 0x%4.4x mtu %u mps %u credits %u result 0x%2.2x",
 	       dcid, mtu, mps, credits, result);
 
-	chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+	chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 	if (!chan)
 		return -EBADSLT;
 
@@ -5501,9 +5490,10 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 		struct l2cap_chan *orig;
 		u16 dcid;
 
-		if (chan->ident != cmd->ident ||
+		if (chan->state != BT_CONNECT ||
 		    chan->mode != L2CAP_MODE_EXT_FLOWCTL ||
-		    chan->state == BT_CONNECTED)
+		    !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags) ||
+		    chan->ident != cmd->ident)
 			continue;
 
 		l2cap_chan_hold(chan);
@@ -5718,23 +5708,24 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("result 0x%4.4x", result);
 
-	if (!result) {
-		list_for_each_entry(chan, &conn->chan_l, list) {
-			if (chan->ident == cmd->ident)
-				chan->ident = 0;
-		}
-		return 0;
-	}
-
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
-		if (chan->ident != cmd->ident)
+		/* Reconfiguration updates ident with only chan->lock held. */
+		if (data_race(READ_ONCE(chan->ident)) != cmd->ident)
 			continue;
 
 		if (!l2cap_chan_hold_unless_zero(chan))
 			continue;
 		l2cap_chan_lock(chan);
 
-		l2cap_chan_del(chan, ECONNRESET);
+		if (chan->ident == cmd->ident &&
+		    test_and_clear_bit(FLAG_ECRED_RECONF_REQ_SENT, &chan->flags)) {
+			if (result) {
+				l2cap_chan_del(chan, ECONNRESET);
+				chan->ops->close(chan);
+			} else {
+				chan->ident = 0;
+			}
+		}
 
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
@@ -5748,25 +5739,33 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 				       u8 *data)
 {
 	struct l2cap_cmd_rej_unk *rej = (struct l2cap_cmd_rej_unk *) data;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *tmp;
 
 	if (cmd_len < sizeof(*rej))
 		return -EPROTO;
 
-	chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
-	if (!chan)
-		goto done;
+	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
+		/* Reconfiguration updates ident with only chan->lock held. */
+		if (data_race(READ_ONCE(chan->ident)) != cmd->ident)
+			continue;
 
-	chan = l2cap_chan_hold_unless_zero(chan);
-	if (!chan)
-		goto done;
+		if (!l2cap_chan_hold_unless_zero(chan))
+			continue;
 
-	l2cap_chan_lock(chan);
-	l2cap_chan_del(chan, ECONNREFUSED);
-	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
+		l2cap_chan_lock(chan);
+		if (chan->ident == cmd->ident &&
+		    ((chan->state == BT_CONNECT &&
+		      (test_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags) ||
+		       test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))) ||
+		     test_bit(FLAG_ECRED_RECONF_REQ_SENT, &chan->flags))) {
+			l2cap_chan_del(chan, ECONNREFUSED);
+			chan->ops->close(chan);
+		}
+
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+	}
 
-done:
 	return 0;
 }
 
@@ -7628,6 +7627,7 @@ static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
 	pdu->scid[0] = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
+	set_bit(FLAG_ECRED_RECONF_REQ_SENT, &chan->flags);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
 		       struct_size(pdu, scid, 1), pdu);
-- 
2.53.0

