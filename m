Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623685;
	b=gY6/fYjpJtVv8ZlGViDrEenMsXhoSd2XeNsQ/P1gc8nnlOlUHjZtOzIi9qof5ZKyDwEk
	 htu7jBFEp3sFQClOJ9c8fVAbz51usCh+55TAIcqvaWQ4bQU3ztmluvRckETE+Py5F3y8t
	 6AKN/xcMhsy2ToOCvcsmaFReH+BLl9nN2aQEOmGIJn4ux55mu+n2+bunFDCWUo2+X5EAy
	 6kA5AT9UhAfKYKcPVhEWUhg1JyGXcXDE1j9/ok7DxecK3RpCKaOkgkhEPHDCNxSrBajDa
	 4MQlQ5/XPLCnxkytMM1T8Izw3C6R89ewa+9+KL9C5k1w01BHU3WNBcLn8vp9M7VZa/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UQh3Hhv6qjNy92jmqlHZeQDSexdAkfgjQwGaT5rQ7nk=;
	b=LifHTT9V79JLarOMERHlmBJBO7mc6vLeNFTm3tApzjrPoSe2ytXUyGNK2y76zPKnLwQu
	 UpJNZoPCC96tviABZhBq1gpGt/S82tCAi3G+lMKl7otV8C6FbgogkLyVlzfWPMtSYG0pn
	 V68cSulpCbu4kwS6yfKvbY9yws3WpkogfZEg5HkeORKA2qrSvrTTTqFHeXQ6UbXg35qT1
	 +q59B7LYHPtu9w1mRUtVM4KDxgsJyClBCk/6lFdyfJzRxtLzvKwx1arR50THQsOF3EkPn
	 TTrEe0FKJb9OU6ZCnauBVaqk42ncQ2HBtutXyV3Nb4JHHX3xO0yaLVo7mSot+V8ADJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=llkcERm3;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C209606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C209606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=llkcERm3
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so1434972b3a.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623684; x=1794228484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQh3Hhv6qjNy92jmqlHZeQDSexdAkfgjQwGaT5rQ7nk=;
        b=llkcERm3dY9S+MXVNxFUy6yIL5WHeYI2OEQd0kAGizxhHB5Zp+hfiHvATonAfBupC0
         dxlrdTgAaKlcqgPcb0pfmgsLo/Wy45Gp5sXLvMANUXNILOXNXD9lGaxJV9nAA+ytouyE
         W0NbnNAECzZqxpXysgc4TZB8qw3qSNfp0VXNxyirQyAGPoffSs5l0c79D5vA1R9WTrB/
         rQhyjZvDVwJhzBC3l7cUqKavl8QvVs8rtkOvxMPHLo5DNp5zhM/XDJcqz3gGiw81WfK5
         GhkcFNe7gE4xX5/4uHm9pw1L2V4rLARGb05Xap/3EFUlmC80QTcAuBVWtDzH1E67MPG5
         1JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623684; x=1794228484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQh3Hhv6qjNy92jmqlHZeQDSexdAkfgjQwGaT5rQ7nk=;
        b=I982UFVibJQr3TN6rZQJk+siFO5ehNic1UCdHtj4yDuRE5nSqnr8X7R+HuuwwVeD3A
         cj1hgCp5XFrfLvWeYwrdSEhMxdNJyCMDhoBKU8T0HR+e8mY9uk6sGLKV6BVz6GM6PfBm
         YrqGgRG6izbSJGVs7TtT7sC/QXxVpkxxZpys57AZMcVSwjXwwpS4c7X1RnefEaj2coOV
         5yCW+UJfoKATwsgDyP6FlSs8cOjC3rqckiegBrnKQdCRv0rF1ZKcGxlsipj92jDYOh0L
         kCYQ/FVO3V1pnyFF/hrbSB4G0DBcCKeo9bnikiJ7vSxI0ZvbqPtqhI8dbRe8Tu3U9xYj
         IbVA==
X-Forwarded-Encrypted: i=1; AKwUvByYvR3VEOoTMlL/yZyEa2wQcUT1BhAR2LZE+Vv41c4FT2OqRRoLRb68rx4QsrNatFWzzGv06q4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+H7r5JT8X9kF5U3Z/WrYoiwNBMf3eDOkKpXMyDHqusg5YJxaKL
	4hEGTEDdz2MMxMdGE6NlkUbIM/J6T3V3MxGLjDI2hJy0ZISD8QxBIbfQBoQZ8qKL
X-Gm-Gg: AYBFou251S6ZiqC5Uy0V06oT/85HZaLVWNOXpxmVryvL4CrvMlu57OqKsMbjoOAMnzi
	+j2Pds0Iq/AekTUcBWpKi/1Zwy2BZN3sF8awc+5SkRNp0nWpUHGf9lE/YaEnmP7PdbjQvNe8ciX
	6iZoHYEWTkIzz9voPbxXd0MqYRrnO8VFxhm252PJhL5VJlccSZcL/G3QM0RoEfEzC+ATIbvjqDi
	HRnNZ0i6bXMWPATVpnkxewwhjckLH7ghWSrT45sqNNB6VjS5w4WS+/9h88oVnCvVQPrpibv32hS
	5PP9E1ptNWsSucmzdL71XNg8hP9m0XeFBgiPhgpWFogPB/cTXbLxGPnAKmcxwFHM/Ttk3JKbx2R
	8Q5MfPZtARg8AUxQQV8iydc53ZSJUYppmZnNQlRX5Xaj9Whwk2S+ubhoCgoAgbBnmfDLNArqb65
	cNYhRgv+euDPEem69QWEuZgZhW5EiO/151hOj3NuxAwnLvxi1PtO7RCOs28MaLvDqgeirg+c0u8
	YgO1Mo9mR4T4bXsWQxyAzHM6tb9JSTo3SBfB+pXcbtcEZ3PKXAptNy8RLM+AqVj2j9FNkbcPPXV
	Ihnx6hrrpzd4w4nvC1b6ZgWwow+J8QcTd4UxnC+QHlroQcbsa8oejhLqltMNcJJiaDLYm3atyvt
	eJ837V//WjTdzTA==
X-Received: by 2002:a05:6a00:1382:b0:8a0:31e5:8cc3 with SMTP id d2e1a72fcca58-8a8317dd858mr7535283b3a.10.1793623683085;
        Mon, 02 Nov 2026 04:48:03 -0800 (PST)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fda1asm1908357b3a.6.2026.11.02.04.47.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 04:48:01 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	security@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: L2CAP: Only accept LE responses to outstanding requests
Date: Mon,  2 Nov 2026 20:47:34 +0800
Message-ID: <20261102124735.23199-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102124735.23199-1-enderaoelyther@gmail.com>
References: <20261102124735.23199-1-enderaoelyther@gmail.com>
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
---
Built in patch order at W=1 with GCC 12.2 (x86_64 module, x86_64
built-in and i386 module) and Clang 19.1.7 (x86_64 module). The x86_64
module builds with both compilers also linked vmlinux and modules.
Sparse checked l2cap_core.c with C=2 after each patch without
diagnostics. Smatch reported the same pre-existing l2cap_chan_connect()
diagnostic as the base; no cross-function database was used.

Coccinelle 1.3's use_after_iter rule found nothing in the changed
functions. All changed functions were processed; five unchanged parser
gaps also occur in the base. Hardware validation has not been run.
This diff does not apply to stable branches as is; adapted backports
compiled at W=1 on the seven supported lines and, with patch 2's
backport applied, linked as modules. Their behaviour was not tested.

QEMU/vhci testing with patch 1 alone kept all 445 established channels
alive. In 40-pair close-before runs, failed reconfigure responses and
Command Rejects each reached 44 l2cap_sock_destruct calls with the fix
and four base boot-noise calls; success reached 43 on both. A 1200-pair
base run retained 1984 kB of gross Slab memory at listener close while
the fixed arms released memory. Kmemleak reported nothing even on the
leaking base, so it was not used for the leak verdict. A KCSAN kernel
with both patches, built without KASAN, ran the same close-before
workloads without data-race reports.

The stable request covers 5.7 and newer with the declared BR/EDR lookup
prerequisite or an equivalent backport. Older LE-only trees need an
adapted patch without ECRED hunks. The diff exceeds the stable guideline
of 100 lines including context.

 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 82 +++++++++++++++++------------------
 2 files changed, 42 insertions(+), 41 deletions(-)

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
index 4dd56e0074fd..a21b2d70ad8a 100644
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
 
@@ -7757,6 +7756,7 @@ static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
 	pdu->scid[0] = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
+	set_bit(FLAG_ECRED_RECONF_REQ_SENT, &chan->flags);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
 		       struct_size(pdu, scid, 1), pdu);
-- 
2.56.0

