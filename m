Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598755;
	b=A/idcEtSq2HhMi0q21pYmy74GSlOFgOY9WgX3IoEY6V8mCI8zMlC90BxRz3xrlyDNnkD
	 OpamVw9oN/xVn+4dngS/V0851CdKbFQkMOpOJpl40vpeUtfAxUcVMt1YQZmwMgrmYsrPK
	 vXofn8jm8sV2DWAp4slk5mShk0fovN/KiICyphYpQcBY9AvdjIDAVBS4uZcupY3i1+gtS
	 FUHr5Nr2/5G3yifJHnmYaCxJVGRshypRX3jGwOLfDQKgCTMy4GElz2bSXNWYgLV5eSvlq
	 5NxmM662mKZUqDluyd+WF9ZyZzM/8aTfbd4HCSRqAYCf00fI5LyN8bxCho56x3vUPmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598755;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WsxSd2mUWfiY4Pi21KJRkWpLWhb0sv/Y8dH/0ANB6LE=;
	b=HcbgVLsjhbOQSRNfNxX/PSSnGdqNZw5gaMx1ApiLl6j0fgkyAH5XfVuf8c8u4+ZWY8/e
	 V2EowVViq6kUL8IL9JTis5tBijb234Hkx0AGnxWVWqH7l0hxN+63PWD4tfvGbkeK7/oan
	 O7qfHU6mqj2hf5XUBrPbBlwiwOdC8G3BXQOO/Fgpc6rhthzfmS7UPsA8LxtNaQUWhaX1c
	 jkcOw8IP1rGdbuYvvxjHLbUtbQBdS/mklFDlfr1fgd7CuPAqcUAWBImQOqZ7OV7nwzSm9
	 SYj75Tw/X9ONLHu/NeFBmfNIoSTMTaL0dz57jKt2MkRnF8ZnFxk8DeLIm2ApHSeGi8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ag2f99rl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D2606A33D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ag2f99rl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6361D1F0093E;
	Wed, 25 Nov 2026 09:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598754;
	bh=WsxSd2mUWfiY4Pi21KJRkWpLWhb0sv/Y8dH/0ANB6LE=;
	h=Subject:To:Cc:From:Date;
	b=Ag2f99rlyEcdlRuA2iXAbvyWk7owgvpNatswQu+UXamYsnpj26uYng3EHrsAztEPd
	 fAGJm5a5pWewkT6aG53hGRIANurBXPYRH5aPck6k4un0kzRJKvgug8uJ25gMrNGZBy
	 TLA8i0ntnua6UJy1E9Y5EBlPu+sGx4FC3lp9B7V8=
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Only accept LE responses to outstanding" failed to apply to 6.12-stable tree
To: enderaoelyther@gmail.com,luiz.von.dentz@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:18:21 +0100
Message-ID: <2026112521-boots-hunting-cbcf@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f50b32aa233d4687af2d241ddcb572da969e8989
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112521-boots-hunting-cbcf@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f50b32aa233d4687af2d241ddcb572da969e8989 Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Mon, 2 Nov 2026 20:47:34 +0800
Subject: [PATCH] Bluetooth: L2CAP: Only accept LE responses to outstanding
 requests

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

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 54eddcdd341f..2a05bda8ab43 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -756,6 +756,7 @@ enum {
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
 	FLAG_ECRED_CONN_REQ_SENT,
+	FLAG_ECRED_RECONF_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
 	FLAG_DEL,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 70ad30b091e4..2e79e72fea51 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -144,24 +144,12 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 	return c;
 }
 
-static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
-						    u8 ident)
-	__must_hold(&conn->lock)
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
@@ -174,7 +162,7 @@ static struct l2cap_chan *__l2cap_get_connect_chan_by_ident(struct l2cap_conn *c
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &conn->chan_l, list) {
-		if (c->ident == ident && l2cap_chan_connect_pending(c))
+		if (l2cap_chan_connect_pending(c) && c->ident == ident)
 			return c;
 	}
 	return NULL;
@@ -5073,7 +5061,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	BT_DBG("dcid 0x%4.4x mtu %u mps %u credits %u result 0x%2.2x",
 	       dcid, mtu, mps, credits, result);
 
-	chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+	chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 	if (!chan)
 		return -EBADSLT;
 
@@ -5621,9 +5609,10 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
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
@@ -5842,16 +5831,9 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
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
@@ -5860,7 +5842,15 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 		lockdep_assert_held(&chan->conn->lock);
 
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
@@ -5875,26 +5865,35 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	__must_hold(&conn->lock)
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
-	lockdep_assert_held(&chan->conn->lock);
-	l2cap_chan_del(chan, ECONNREFUSED);
-	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
+		l2cap_chan_lock(chan);
+		lockdep_assert_held(&chan->conn->lock);
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
 	return 0;
 }
 
@@ -7765,6 +7764,7 @@ static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
 	pdu->scid[0] = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
+	set_bit(FLAG_ECRED_RECONF_REQ_SENT, &chan->flags);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
 		       struct_size(pdu, scid, 1), pdu);

