Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095377;
	b=p9cikaIbed22+n5vWYrN106NzjbdXtcNthE3MVJq3y1IzqPSwzacY+128sN6LXLDWEa8
	 OZDEY9BxXhNGs7Nx5B4LqoSnZtecEoX9oLMDJtLUX2FBQzVAS336DiIzGm+yvdlpmZm7h
	 Bi6vpLAD/v5m76DxYcDSTFPhATM2XBmYAVfX2uki9ze9FMjG0qWwe2X/D+Cs88sfST9oY
	 292IJotY66n707boZ2vgZAJqYMuVrl3B7Mc8bRhDb5A7Y/vWx8/FFSTV9UwX+4K4XtKZl
	 byaLgLUDg1cts3GyglcHetxkPSUc6OpOx1PefWJN4H1m2Gg5vyVUk+/X1WzRnImCRrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095377;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GGRD4rHxzGR/0Ca4q08YEFPKFTP39F+dpDG023MGztQ=;
	b=LEs9T1bpK1RtHE085TB1NH0LhE45JqWqz8Sx/mNjR7ztXVSWqLqia1Cs6e2yWBepwwMn
	 9y/dx+Sq3Lun4eu7LJtokboU/jWJ8BTp1t32D7nXFyYcG6uC5xcW/GmVy3vZFYRUPnKst
	 OdSx7Pt78sa6ncJKExfiSTbY621CUqBZ5BAn77jXkF0itphNF14YW1bWFz8a1V5WGqVNb
	 bekMDMeJ/Q2teRp0hRCFN+ARYAkdyBfZ/UQjDsupA8rFBfe/r1T1LEJhlHf6//CirPPii
	 u3N2LdnPqo57n8tDfV9/FN+xtcUqmpW51prfdEMVCRqTkZjKJ4MenuohVS5CUKUbrGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAV7po4c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1865606A331;
	Tue, 27 Oct 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAV7po4c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBA71F031E2;
	Tue, 27 Oct 2026 10:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793095376;
	bh=GGRD4rHxzGR/0Ca4q08YEFPKFTP39F+dpDG023MGztQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NAV7po4clxqLOB0eFidpYCyquPlfwwLy3U5lnPcK+H4LLuBw0jnMIum8/5BA49Ksc
	 lg6lmt6cfNZJlbbtAlRaCiqtUpuO6DoZIVUALueWJ5JzhMlRkV5f31f61wcUNdSBoK
	 EjTNsl9LQZ/4G3EWSXk8WtF3wk5bDG/sgS4fVzT4tZLLF5/TI7OD3fC9HV2YEKnxk1
	 uqZxNRKLejFQ0Hl/sX3vmpu6X9F5ZIFsbd81idFC7utwcYr+u7cvl9Q1da44GlxI4M
	 GfGsJsDZQoouXZseBHsYzbK0+D9UAy6cfwBPrtu5gBZQOe6nCYfhhVL5E86fJIH2u1
	 Fs/VvBq6g3LHg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Maxim Krasnyansky <maxk@qualcomm.com>,
	Marco Elver <elver@google.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [STABLE v6.1-v5.10 2/2] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
Date: Tue, 27 Oct 2026 10:02:40 +0000
Message-ID: <20261027100242.2886699-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027100242.2886699-1-lee@kernel.org>
References: <20261027100242.2886699-1-lee@kernel.org>
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

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 86b55991d3cd690e73c5ef8d20b75ae4905b357a ]

l2cap_chan may be linked to l2cap_conn at most once. This is assumed in
several places, eg l2cap_chan_del cleanup.

There is a TOCTOU race where the invariant is violated:

    [Task 1]                          [Task 2]
    l2cap_chan_connect                l2cap_sock_bind
      l2cap_chan_lock                   lock_sock
      l2cap_state_change                if (sk->sk_state != BT_OPEN)
        chan->state = BT_CONNECT
        l2cap_sock_state_change_cb      chan->state = BT_BOUND
                                        sk->sk_state = BT_BOUND
          lock_sock <------------------ release_sock
          sk->sk_state = BT_CONNECT

l2cap_sock_connect() does not check sk->sk_state, so since chan->state
is now BT_BOUND, subsequent connect() ends up with second
__l2cap_chan_add.

Explicitly document and check the invariant in __l2cap_chan_add with
WARN_ON_ONCE. The only callsite where it could be hit is
l2cap_chan_connect, so add pre-check there to avoid relying on
chan->state. chan->state read/write is not properly guarded currently so
there can be other TOCTOUC problems.

Add l2cap_lock_chan in l2cap_sock_bind() to guard chan->state write.

Fixes: b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")
Assisted-by: deepseek-4-flash # finding the race condition
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[Lee: Resolve context conflict around mutex_lock(&conn->chan_lock) prior to commit 56c2b5831d39 ("Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect")]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/bluetooth/l2cap_core.c | 7 ++++++-
 net/bluetooth/l2cap_sock.c | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 88ddd8eabae9..445a43c721f6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -630,6 +630,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 	       __le16_to_cpu(chan->psm), chan->dcid);
 
+	/* Caller must ensure l2cap_chan is linked to l2cap_conn only once */
+	if (WARN_ON_ONCE(chan->conn || test_bit(FLAG_DEL, &chan->flags)))
+		return;
+
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	chan->conn = l2cap_conn_get(conn);
@@ -7431,7 +7435,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(chan);
 
-	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
+	if ((cid && __l2cap_get_chan_by_dcid(conn, cid)) || chan->conn ||
+	    test_bit(FLAG_DEL, &chan->flags)) {
 		hci_conn_drop(hcon);
 		err = -EBUSY;
 		goto chan_unlock;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b11558b0dfec..655922aa82f1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -111,6 +111,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 			return -EINVAL;
 	}
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
@@ -176,6 +177,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return err;
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog

