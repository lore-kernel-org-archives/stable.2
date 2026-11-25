Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629442;
	b=YYqWRM4tKkEqvYn58v1klQdsSPYZu0303AZ4tVgDmfMSW5O3qB3yh8b2oi3Wzm3yhjmg
	 FZ8JfsJ/0nAmpq0LjPXsdCQYwnsTeHb+1XfVHvt7CTIruPQpDor30wswHgu0KAb1eDw3x
	 z+3xQoFjVUxYazDpMpO5Xi4FXk6iOiTD5QF3nkcKE93BdmgD3ElkiBxlEdUXNVtIHNKwp
	 DK4ClbrUbl83G0TeWU3d6MszEQfLme0zb30Al1LOoy39JcwkJ8VH1qecvV4FXZBPWMlJi
	 zShOwlOIK6FBd0YrnciMhZSVPa2WNekewxX1XjzDFG6kzLkD6M6b8dqF9bLfyYPhh4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629442;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2E1IZ5jkAh+srZwrXi7N2C4ZfkW2IGnMFW3peZ/D7Ek=;
	b=d5CD5m8uKzzUSsykiGkPPE5J71VZzi49SGo3NmDrClvgHkTedJCxJnMiGVD/xXr5Qr1j
	 E5RAfuxMlg6QvIbiHPus1Ax+7GSnV7VNvxEFvGDxtS06VJmNIezoO1vopTp86X5TsBel5
	 B7/1nyX5rgtqUUrhDGMtyCh2wqJwC31136mqrP688/odM51qnT0JROJDLlvfGoYwxknnq
	 LExCxbHpW8ODaZC45gEKv+QuP1BjkwQc0GnE5Lv6Ih7SP4Z4eMXT6wGlZZFcC4DFUVe61
	 JhJLvlxWMDlyjENEGQvywbSWbmlWwdeflopMHbdgiAP0o9TvMBswERorTg+DdP1Hdzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1k1zx6K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1A606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1k1zx6K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76BD1F000CF;
	Wed, 25 Nov 2026 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629442;
	bh=2E1IZ5jkAh+srZwrXi7N2C4ZfkW2IGnMFW3peZ/D7Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T1k1zx6KEHz43+46/Ct1teJvOTAm1GYXhgZyqqzF/3jqpwFTyNuxIMlY8u6VXme5k
	 qR/G4fYLKAcvKg11n668pq+AAh/r18GITLfdP8DsnbIzA1M6zIXAg+Vw8OZlKOvvmU
	 qlY4Xli0Lu3Ys4n/1078tmYRYWkf/l9S8R9cxokazUndR56Cv9hiuh7w/VP1CoEbjT
	 godYZpGR2C7HpqWogb65L/8zLCZKBz5M4IPe1kZI5X2/P+FlcGKOpe8jhE+HdnGUWy
	 deoRnewR3XI/e2gHPqH7vIyqbQgdypJklGBr+hcQWjFcOcJ6VOgOHsb96gTx4/xQcd
	 FqOhTYiLlbxsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] Bluetooth: L2CAP: Only accept LE responses to outstanding requests
Date: Wed, 25 Nov 2026 12:57:20 -0500
Message-ID: <20261125175659.853333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112523-bobbing-relatable-c980@gregkh>
References: <2026112523-bobbing-relatable-c980@gregkh>
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
[ sashal: adapted to the older locking scheme, using conn->chan_lock mutex and chan_lock-based loops instead of conn->lock, and pdu struct/sizeof usage instead of struct_size ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 69 ++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cbde15ad06fa4..37ec39ec09372 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -781,6 +781,7 @@ enum {
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
 	FLAG_ECRED_CONN_REQ_SENT,
+	FLAG_ECRED_RECONF_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
 	FLAG_DEL,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2c7330d021875..3a62d5472e90e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -189,7 +189,8 @@ static struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 static bool l2cap_chan_connect_pending(struct l2cap_chan *chan)
 {
 	return chan->state == BT_CONNECT &&
-	       test_bit(CONF_CONNECT_PEND, &chan->conf_state);
+	       (test_bit(CONF_CONNECT_PEND, &chan->conf_state) ||
+		test_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags));
 }
 
 /* Other channels may hold the same ident for a response they still have
@@ -201,7 +202,7 @@ static struct l2cap_chan *__l2cap_get_connect_chan_by_ident(struct l2cap_conn *c
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &conn->chan_l, list) {
-		if (c->ident == ident && l2cap_chan_connect_pending(c))
+		if (l2cap_chan_connect_pending(c) && c->ident == ident)
 			return c;
 	}
 	return NULL;
@@ -5853,7 +5854,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 
 	mutex_lock(&conn->chan_lock);
 
-	chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+	chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 	if (!chan) {
 		err = -EBADSLT;
 		goto unlock;
@@ -6415,9 +6416,10 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
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
@@ -6634,28 +6636,33 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
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
 
@@ -6664,27 +6671,36 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
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
@@ -8544,6 +8560,7 @@ static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
 	pdu.scid    = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
+	set_bit(FLAG_ECRED_RECONF_REQ_SENT, &chan->flags);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
 		       sizeof(pdu), &pdu);
-- 
2.53.0

