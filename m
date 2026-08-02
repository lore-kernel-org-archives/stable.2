Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35361A262D
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785676836; cv=none; b=dtoO8VbBqPknl8rJaZ79zcWesJ6gobAFx0/ndCwcj6Dt5a3V8mfDnlZ2pb1o8xaoMMhntc8CY04+cbdmN/KFqJxlTUBuDVscApMpbiNRYTVeVXdBf7+CHKwO8UacvNFvnvBNnDLogZzqPaQIxvOn+IShHeqi4EcLk+eGuvirPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785676836; c=relaxed/simple;
	bh=VLQyAYtULRZagQmNoCHD7IAvvHyJU9vQFCpQQCOoadM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPRYiIZJ9qGrJIGnFRhoucS+XkKJCrQxCIwy9z9pD1RJQRD15rZCHfHtMxmaDvp5h7rgpCCPIM+XgTaa0wFnKRxnj06t8Ho6wpN0wu6GHAh8/5drCQvbNlv0TXuPJLUKh+31NKc2rVeYOW/UEj4EVIEkf3S693MSqunM3V5rTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=sc7mXQ8N; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="sc7mXQ8N"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so2514f8f.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785676833; x=1786281633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hV44Gh0Q41UPQ1NztmVqRIIGr05UAdzVNPCYL2ru+ao=;
        b=sc7mXQ8NeYE2eVvWL29QNmCroQmg1ADDGevFkxqA2/p2O3B8PZw59rJqwo8jgrhBQK
         uDJH7YqFl+3E/seMpzNSTbOJ+nj/3vE8Fo3ABOUITk+f9aRlM4/7dz29RELbrqCt0xiu
         /OpGYCAVTM7k9PWpQCjWrEIUJC4yo7ZCdBuFaiPpb/7Floj6Su7BR7iCA5Zw96C87foK
         18kxg0Wt8lQ5WFcvtclaIwBmvfZsg9fTq+epTMl/YmR/fWrhNHbBeqwihNcxMa+nrd6M
         IMjDPuSTLVkbGwqc8l3PQAB8pOT4RhFTzMsOKhougEqV8IWa36Ut93xEzs1l0waSnnHq
         +R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785676833; x=1786281633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hV44Gh0Q41UPQ1NztmVqRIIGr05UAdzVNPCYL2ru+ao=;
        b=bfYHmn8JlmDlxztu9ZjLaNwi1DsicNen2sXA6tOLAR/ya0lruHZBOHPK+s7/iG6wyZ
         DI+0wV2sB5zKC9iFKUYgtszB1KeTbBDeMHU0t7H3Nx6uavau+PS0oFwPtwmYm21/HQI4
         xjOEkftJwo0X8UjJjhmS1c1GhfqzfP0Od94/ipPU6VJwKHHA0WSEo57QlNdEdn+iwYxz
         oiNMtBphsxagE63WuaYlbhpXjyYoSzzh1W9u/ZieJS6EHPPyoQ1tkfqVaZKmskV/Syxt
         sywYt+AcrWbmWtG41zNTugfSZrkbxxJv7kV5r34OLM1OPZCaPtKtCPTs/NHREq8RrM1H
         SEQw==
X-Forwarded-Encrypted: i=1; AHgh+RoWgQpPdUavQUJi/r7TZS1HynL0D3yjaQep3yV7kBv9R8w7oH1JlThwaE+g47ju8oawytuYvU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNokZwWM4FNaHpbPzo4PdOKiJsWTXI8U/dNqKwuDFX+4O2qOPr
	jI+T5yCAUdjtlGqsQN9xBWIGwjwNZ1cyxuDjvLvqIhpWVqtLWkr+yC1PTnEzx/zWVhN57GdG9Vm
	CwqqaFQ==
X-Gm-Gg: AR+sD10JWx1zv36OpHd8HpdOHDS15Ly7rvWCFbje2N0YsdzGn8XBHi1WR4KZin2rhL1
	w30vxU2HqkZCMxylGOm04HVyPd59qScFd2b8kaCH5eqotamug8n0Fpmv06SPqgqbK5JafCJp9np
	U/IYpiH4yXOuqXwNMXO1gvMpRr5DBVT/u3F0gdDL6ZdBbkWEgDMHD9aRpP+Bx4YORFhbzEYoRLe
	sxi2V5xvXFyo9U16d3tD8NeiWEy1SxtKKFEsctERpTVROYGG8jSivPRa51rdYNGcppKtZBS2K9h
	14AlKCsINhPxL9v9Y1UgnbKH3bg6J9EQlcIle+25P7Z0vGYVkflOTq66zY+DGT08/+CqERsm63D
	nKq8BJk9NOUhY3uKbauB3xh0reC7N2V70qAgeQHn/GxFbxOIrwgLFp7IYxwAelrrVY4UvSWp5Kj
	t727p05KlpQemMXjGq6Li6hGjMYM8HJvMLh4I/ESfX4GPmINMQYyntKNCaqRC7QeEs1vIkvXok1
	zHeXhzAEmhCOVyKZgDrDYVzPffKpZjyxhfEQV88iMnLKQxq4diojDhJq64UqL3fTR9giLuhr3w/
	26dzURo5p2U02av+Yvo5fiahGfduTA==
X-Received: by 2002:adf:e9cc:0:b0:47f:4e42:669 with SMTP id ffacd0b85a97d-47fd72b0a31mr11669791f8f.22.1785676832932;
        Sun, 02 Aug 2026 06:20:32 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm25429435f8f.27.2026.08.02.06.20.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 06:20:31 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix list corruption in ecred defer recvmsg path
Date: Sun,  2 Aug 2026 15:20:29 +0200
Message-ID: <20260802132029.5118-1-doruk@0sec.ai>
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
L2CAP_DISCONN_REQ -> l2cap_chan_del()) under conn->lock.  Every other
walker of the list holds that lock: l2cap_chan_list() takes it around
__l2cap_chan_list(), and the signalling handlers reach the list from
l2cap_recv_frame(), which runs with it held.  The deferred-accept path
from l2cap_sock_recvmsg() is the only one that does not, so a peer
disconnect landing during the walk leaves it on a poisoned entry:

  list_del corruption, ffff88810420c480->next is LIST_POISON1
  (dead000000000100)
  WARNING: CPU: 1 PID: 88 at lib/list_debug.c:56
  __list_del_entry_valid_or_report+0xd6/0x140
   l2cap_chan_del+0x7c/0x7c0
   __l2cap_ecred_conn_rsp_defer+0x333/0x340
   l2cap_sock_recvmsg+0x338/0x340
   sock_recvmsg+0xec/0xf0
   __sys_recvfrom+0x14c/0x1f0

  BUG: KASAN: wild-memory-access in
  __l2cap_ecred_conn_rsp_defer+0x1c0/0x340
  Read of size 8 at addr dead000000000100 by task race/95
   __l2cap_ecred_conn_rsp_defer+0x1c0/0x340
   l2cap_sock_recvmsg+0x338/0x340
   sock_recvmsg+0xec/0xf0
   __sys_recvfrom+0x14c/0x1f0
  Oops: general protection fault, probably for non-canonical
  address 0xdead000000000100

Take conn->lock around __l2cap_ecred_conn_rsp_defer().  The established
lock order is conn->lock -> chan->lock -> sk_lock (the RX worker reaches
the socket via l2cap_chan_del() -> l2cap_sock_teardown_cb() ->
lock_sock_nested()), so the socket lock is dropped before conn->lock is
taken, mirroring l2cap_sock_shutdown().  The conn is pinned with
l2cap_conn_hold_unless_zero() across the unlocked window.  Only the
EXT_FLOWCTL branch needs this; the LE and BR/EDR defer paths respond for
a single channel and do not walk conn->chan_l.

Reproduced with hci_vhci on a KASAN + PROVE_LOCKING kernel: a peer sends
L2CAP_ECRED_CONN_REQ over LE, userspace accepts the deferred channels,
and an L2CAP_DISCONN_REQ for a sibling channel races the recvmsg() that
completes the accept.  7 of 10 unpatched boots reproduced it; 10 patched
boots gave neither a splat nor a lockdep report.  Well-formed traffic is
unaffected: the response is built from the same channels with the same
contents, and the only case now skipped is a channel the RX worker has
already removed from conn->chan_l, for which no response is meaningful.

Found by 0sec (https://0sec.ai).
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: Rewrite the commit message.  v1 called this the recvmsg-path sibling
    of 41c2713b204e; that commit fixes iterator invalidation in a path
    that already runs under conn->lock, not a missing lock, so the
    reference is dropped and the invariant is stated directly instead.
    v1 also cited l2cap_sock_cleanup_listen() as precedent for taking
    conn->lock, which is backwards: it deliberately avoids conn->lock
    because it runs under the parent sk lock.  Only l2cap_sock_shutdown()
    is cited now.  The splat is quoted from an actual run.  Shorten the
    subject to 80 columns and use the AGENT_NAME:MODEL_VERSION form for
    Assisted-by.  The only code change from v1 is four comment lines on
    why chan needs no extra reference across the unlocked window.

    Note for stable: this uses FLAG_DEL, added by b66774b48dd9
    ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref",
    v7.2-rc1).  Trees without that commit need it first; the patch does
    not build otherwise.

v1: https://lore.kernel.org/linux-bluetooth/20260714125209.39790-1-doruk@0sec.ai/
 net/bluetooth/l2cap_sock.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 735167f73f312..af35608791994 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1227,9 +1227,42 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
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
+			 * across the unlocked window; chan needs no extra
+			 * reference because the socket holds one until
+			 * sk->sk_socket is cleared, which cannot happen while
+			 * this call is in progress.
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

