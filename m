Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624151;
	b=angcU/TFNYxLXBQ8jFdvQ2n8S1REePm+k7ZoW3UrDmsdnYgq4PpLVf0Vv+knS6doppM2
	 hgFt5bLwK3dSIpvHi5pdQIJ+EdXWuC4miy8cwznASrhfByEPQksq9fsoHYvChKCz/0Mz7
	 NynyLDputH9ON8G2OwCz5wV6tP38XshxjYLUeJV8ZgVfB5S0CqGjwAlFxeKyKdsuPwBrr
	 SGjEWrB6JrFuCngkG88YJ7aeUygpS5ENm9JMb6gNTD5txNuXyJYp8tsQhl+8x/9IkarXC
	 0smrqK8n2yrWPA8RUo2RX5BcE2249fGRM8KuloDtLBF36fb6osL2xUfEZrqrik07p4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624151;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aO05WFKJC8K1Ieg2L7dsCNqo6pJnj46aMtO+bBk9UX4=;
	b=HMDOl/nIGHyzxTks+TFmEqnIkk8XF5aPUZQxU4Sl3qnfTqyAh7s3Umt3p8dNtFOVNuhV
	 fhZsdpoz8StRTvm6Wt/hQHfX7M6buZNhi/wsIl8UaWk0se9TrDgufemG9Gg9Zsv1aylz7
	 d+3jqOUPhFG1IJv2M2ZADOSH+bcPQqfKIDDIGAzh0aSDj+3KtwRhAT9naYvAfycJdGyda
	 DkbY8XrhnFQ6JdrfOWA5FFPyfkVXQCfkaiaXAuus3wDZDmRRpchkIcNH7ns6kNaqxXcxM
	 eGEqD8VeUOLDcZdR0fcuWqtVB8x6ukTQED01RgevFwlqNdlrLxqHT18BqA+Ol2nmDbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmGu83nX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF2606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmGu83nX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E21B1F000CF;
	Wed, 25 Nov 2026 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624150;
	bh=aO05WFKJC8K1Ieg2L7dsCNqo6pJnj46aMtO+bBk9UX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmGu83nXIwbHuWe+GfMmWtDpCgXIIkEs6e0jZZ525qbi/oDF0kIyliTfDiMJ0owR+
	 xhU+w7Ht8vSsjgYWRQlXIc1l1Vhz0mZFpGsk1OvTh+HqBk1lzxoeJdXkZhDUYURpp2
	 4rjbSMx6GMbQph47mbUV7/6MtkpcLgZi91xxpaFOAI8wg3ISWPTAmkeDS7cJxn9pZ8
	 Xvcsv0CPclCY4BqK601U6//NIIUHWyDrmul/ZshfCArpX7i02RNIy02ewEkwxMG+gp
	 Y8lrxvVS0doc+Zs4zzBQUxztd+N/8gI+EiBOcT9wVCkpWCXYCOGgY8VpHZLPja7PgV
	 vtY9W6DT+TwRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Bluetooth: L2CAP: Only accept LE responses to outstanding requests
Date: Wed, 25 Nov 2026 11:29:08 -0500
Message-ID: <20261125162845.784822-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112522-clean-mouth-4dc2@gregkh>
References: <2026112522-clean-mouth-4dc2@gregkh>
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
[ sashal: Added chan_lock locking around the l2cap_ecred_reconf_rsp() channel loop and dropped the conn->lock annotations, since this tree has no conn->lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 81 +++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b15ab4ead3bc3..eb64839da9c33 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -746,6 +746,7 @@ enum {
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
 	FLAG_ECRED_CONN_REQ_SENT,
+	FLAG_ECRED_RECONF_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
 	FLAG_DEL,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c6231c630ad50..5e96f659a3357 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -153,23 +153,12 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
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
@@ -181,7 +170,7 @@ static struct l2cap_chan *__l2cap_get_connect_chan_by_ident(struct l2cap_conn *c
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &conn->chan_l, list) {
-		if (c->ident == ident && l2cap_chan_connect_pending(c))
+		if (l2cap_chan_connect_pending(c) && c->ident == ident)
 			return c;
 	}
 	return NULL;
@@ -4919,7 +4908,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 
 	mutex_lock(&conn->chan_lock);
 
-	chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+	chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 	if (!chan) {
 		err = -EBADSLT;
 		goto unlock;
@@ -5473,9 +5462,10 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
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
@@ -5692,28 +5682,33 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("result 0x%4.4x", result);
 
-	if (!result) {
-		list_for_each_entry(chan, &conn->chan_l, list) {
-			if (chan->ident == cmd->ident)
-				chan->ident = 0;
-		}
-		return 0;
-	}
+	mutex_lock(&conn->chan_lock);
 
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
 	}
 
+	mutex_unlock(&conn->chan_lock);
+
 	return 0;
 }
 
@@ -5722,27 +5717,36 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 				       u8 *data)
 {
 	struct l2cap_cmd_rej_unk *rej = (struct l2cap_cmd_rej_unk *) data;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *tmp;
 
 	if (cmd_len < sizeof(*rej))
 		return -EPROTO;
 
 	mutex_lock(&conn->chan_lock);
 
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
+
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
 	mutex_unlock(&conn->chan_lock);
 	return 0;
 }
@@ -7579,6 +7583,7 @@ static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
 	pdu.scid    = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
+	set_bit(FLAG_ECRED_RECONF_REQ_SENT, &chan->flags);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
 		       sizeof(pdu), &pdu);
-- 
2.53.0

