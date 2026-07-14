Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA95378D64
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033536; cv=none; b=rPBE/JRyoVmx5r9m4YtSRpCPYwu4REkma3Iq8kofyrrMrGT2rS2xzwLZhKeJNNeixTObQ3mUzKaRGHCmy+IAAUppk/wgl0pNViDThDFE/jRm0bIVd4EJ9jcnBCtKWQ5ac1SveqV+b0+Hb4SJTpjao5UHzXyZPEQS8mtuM3mPY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033536; c=relaxed/simple;
	bh=K/aLER6+ebVkGgjRtZVtDuCurkZdvKTMurcmLpU+6qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+rhOzWAz8kDnHiEVkwO/WmGETxYMvHR0sNRnzd0A0q4AHazbOwArm6jFqQwPxMVQ76VNz9W45ZqLJpqySyy11eX/ZLc98rVczJDrrqynnLrjhIcMIYfm9tkG6ZtPcNzBHaVSruWNPVEQsRZlexEPo+zws3yvmv/v/ir7bAFPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=sk3JiuPO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="sk3JiuPO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so27413125e9.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 05:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784033532; x=1784638332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uhf+KlmAvjC3IU/9RdHkwgo2wg9fs34PDje4Hy9fpNw=;
        b=sk3JiuPOqxdxnkH7kO50+YJGa2IxqAOoVxMoO3FKJdtydnbninLrPlh48hQjpqpIMx
         PhgvGZgAMfcYIErJcDb1h/QoWxVP4uJUxProb1uO96XmzmviLdHICmubWE/w2xiTF0ES
         FQeBQqoiMQtIPppiWezODMiAVZw1kQsz+lzexh/uuPAk8u/Qx2xviaOQtgStfWY42sTd
         2YMEMTAUtygUjAsmi/HKdP7FiWxPwr1a9GWUz2m7foW2Vug2RqeIQIlzEZOnZUI1TKaN
         aOECkYFoKNUhqy+pvrF+Pt8FjXM+lOlATaxhvwDYyEGKecATuYyWgtdtsJFY9MMBXyLW
         GyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784033532; x=1784638332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uhf+KlmAvjC3IU/9RdHkwgo2wg9fs34PDje4Hy9fpNw=;
        b=allq8lnrbhYDE5knuS7LE+B8rcQSuUjiOEVVb4PV1etACFxw3C4g093e1eyhdzuErL
         YKRQ2BkVYgFxXt9GZDy4L2UT57a5iq9knFQzAAVOMM4f8op2M7eUjUveUdhd0Y4W6yKF
         9Y6wj+s+el+Kpp2fmH1uwG15dakCM9aKL9Ff1p69NoyQkbUnpMwcNdzGYLE5GDXGi2KX
         bu/X1Ku/eynqWdkVGq3l/nBELFbjx9YYihxY0af0FOvwTNyuxWfPdvLF3T93zVW7aL0H
         a7zufuvz4jwHPpsLdwl/tRVNyGO6F6A/hvvA4/82w5q5YADgt/KyzMqzMrCIszgoZOZ5
         OOyA==
X-Forwarded-Encrypted: i=1; AHgh+Rootl1RoVCLsHj05efOPBt71hefPI9N+w9VBdUnmlvGdd6mJQc9VoCkILjVjjwmuUt788ZZvic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxexrqY6zixLtTekm5+FIlDhatQgOiF02nCbN0LUS0mTWuYtUP4
	8pD+W64cvJSDCghhv/SsTdTRYYxn1tJJoV+87+naAKPMtix6xBdsk23bwANLSl3BpziY
X-Gm-Gg: AfdE7clSUnLLGUhghLsMhm88yJ1OedHXRxJx5if46ODJnGjXtS1t5TE40zTf8yhQB2V
	zFCV2ThG5jcqvd8JG3DDpRj5LEkP4XDGj4dP0+zINrfGYL71MLIJxT9GgFeuGKnhS0JFadQYLEN
	0Te2oBDIEJyHklirimQAmt1AHraydsWAFuQoq9o60+47mBFXG2Sp+Z5BaRycN8hYBYHx7dEz6Ew
	tBiZAct46MbdBSZhvhzgnhemTmsE0gby9mcTsLrK7ndBirmduzlpdKOhl7JNyzfnIfjlvFQD7Kl
	ITyhQS8JroZNDjMpSLtCwlRPkFW6o3c/DFPvk6SMUQsxDtrnb0qlNw40OzJLCs8ql3+u9q5pDkM
	LGxhO6fQTYrqYJWlNdapajOO85I4uRTdJTqzOxOq2hdnPDFhvBuMtUbm/A9Ycwb/3u1+Frqde2w
	F8aj7rIRRSfTYUZeZvvchsEdr8zJpaE+vQTxeHRE8oVNGNi0SBQiEXUVVb5f3OI4BmunAOaE0Nb
	qRxyLziix7QmRtezXN2DF3noQi5uYjiESs=
X-Received: by 2002:a05:600c:609a:b0:492:4363:e7eb with SMTP id 5b1f17b1804b1-495389d21cfmr22459345e9.32.1784033531857;
        Tue, 14 Jul 2026 05:52:11 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f9402sm78431305e9.13.2026.07.14.05.52.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:52:11 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: take chan_l lock in ecred defer recvmsg path to fix list corruption
Date: Tue, 14 Jul 2026 14:52:09 +0200
Message-ID: <20260714125209.39790-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a deferred L2CAP_MODE_EXT_FLOWCTL connection is accepted,
l2cap_sock_recvmsg() (BT_CONNECT2 + BT_SK_DEFER_SETUP branch) calls
__l2cap_ecred_conn_rsp_defer() while holding only lock_sock(sk).  That
function walks conn->chan_l via __l2cap_chan_list_id() and, on the
authorization/refuse path, removes channels with l2cap_chan_del() ->
list_del(&chan->list) -- all without conn->lock.

conn->chan_l is serialised by conn->lock and is concurrently mutated by
the RX worker, which processes inbound signalling (e.g. an
L2CAP_DISCONN_REQ -> l2cap_chan_del()) under conn->lock.  A lockless
traversal/removal racing the RX worker's list_del() corrupts the list:

  list_del corruption, ...->next is LIST_POISON1 (dead000000000100)
  WARNING lib/list_debug.c:56 __list_del_entry_valid_or_report
   l2cap_chan_del+0xdb/0x1140
   __l2cap_ecred_conn_rsp_defer+0x61d/0x700
   l2cap_sock_recvmsg+0x758/0x8b0
  Oops: general protection fault
  KASAN: maybe wild-memory-access in range [dead000000000100-...]
   __l2cap_ecred_conn_rsp_defer+0x3c6/0x700
   l2cap_sock_recvmsg+0x758/0x8b0

This is the recvmsg-path sibling of commit 41c2713b204e ("Bluetooth:
L2CAP: Fix possible crash on l2cap_ecred_conn_rsp"), which addressed the
same conn->chan_l manipulation on the signalling (l2cap_ecred_conn_rsp)
side; the deferred-accept path was left unguarded.

Take conn->lock around __l2cap_ecred_conn_rsp_defer().  The established
lock order is conn->lock -> chan->lock -> sk_lock (the RX worker reaches
the socket via l2cap_chan_del() -> l2cap_sock_teardown_cb() ->
lock_sock_nested()), so the socket lock is dropped before conn->lock is
taken, mirroring l2cap_sock_shutdown() and l2cap_sock_cleanup_listen().
The conn is pinned with l2cap_conn_hold_unless_zero() across the
unlocked window.  Only the EXT_FLOWCTL branch needs this; the LE and
BR/EDR defer paths respond for a single channel and do not walk
conn->chan_l.

Found by 0sec (https://0sec.ai).
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/bluetooth/l2cap_sock.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 735167f73f31..796b9a4eee24 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1227,9 +1227,39 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (sk->sk_state == BT_CONNECT2 && test_bit(BT_SK_DEFER_SETUP,
 						    &bt_sk(sk)->flags)) {
 		if (pi->chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
+			struct l2cap_chan *chan = pi->chan;
+			struct l2cap_conn *conn;
+
 			sk->sk_state = BT_CONNECTED;
-			pi->chan->state = BT_CONNECTED;
-			__l2cap_ecred_conn_rsp_defer(pi->chan);
+			chan->state = BT_CONNECTED;
+
+			/* __l2cap_ecred_conn_rsp_defer() walks and mutates
+			 * conn->chan_l (via __l2cap_chan_list_id() and
+			 * l2cap_chan_del()), which is serialised by conn->lock
+			 * and is concurrently modified by the RX worker.  The
+			 * established lock order is
+			 * conn->lock -> chan->lock -> sk_lock, so the socket
+			 * lock must be dropped before taking conn->lock to
+			 * avoid inverting it (lockdep deadlock).  Pin the conn
+			 * across the unlocked window.
+			 */
+			conn = l2cap_conn_hold_unless_zero(chan->conn);
+			release_sock(sk);
+			if (conn) {
+				mutex_lock(&conn->lock);
+				/* The RX worker may have torn the channel down
+				 * (FLAG_DEL, removed from conn->chan_l) while the
+				 * socket lock was dropped; skip the response in
+				 * that case. conn->lock below serialises the
+				 * chan_l walk against the RX worker's
+				 * l2cap_chan_del().
+				 */
+				if (!test_bit(FLAG_DEL, &chan->flags))
+					__l2cap_ecred_conn_rsp_defer(chan);
+				mutex_unlock(&conn->lock);
+				l2cap_conn_put(conn);
+			}
+			lock_sock(sk);
 		} else if (bdaddr_type_is_le(pi->chan->src_type)) {
 			sk->sk_state = BT_CONNECTED;
 			pi->chan->state = BT_CONNECTED;
-- 
2.43.0

