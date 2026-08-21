Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB615435529
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353886; cv=none; b=FoEfo7+3b2WlxOw2PvJM3S+Nq2oTMcCXktWPzz3p3yswx3nNgzFqG9NDBRZTkX3KwPR5Nz9OClgI55igUy5u1nJJvykK8pfUvXAjupCh35hBORek4kJa6gfk+QYMD8D3wObswfqbqVmJ5Xf86Ta63CQ+MyApQKxQttsZA7fH694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353886; c=relaxed/simple;
	bh=7p3maSGJLmMKuRxF2UTVneoWG3u3TMn6OHBR6WjDf7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL0tXSF6tES+Va3H+9zbiFXKTOUul/HxRFpDBRejhCmH3qQGTSCgufnRq0lY+r8j0KYoq6AjcIVA1XqZ6WzSe+ktWcTQeQX4YovP30MBnWZ3eDInMvE8a73Y/OShMGW8MwO/ZXODVHTu+dF0cao7wCjQggUmmk2oG8HdzhfpwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqBvbohi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqBvbohi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17461F000E9;
	Fri, 21 Aug 2026 23:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787353883;
	bh=hptTMYkCCWgauTN+E/Mj29rEJ6vmxunz9L+d046Wmo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqBvbohiQ0GJyBG5r8z/i+1LCHF/dHDJPdmdUPKXgLjECGvAH2hA9Qk1I8PRY/eZG
	 bbTgWlKKuZU+6M9sp0oRnKpFudy04bzvqoG/w7miI3dP5WrV7DleHAHOJchFG6TfJO
	 oqDazuk/+BLU4C/0ZrXDAstVaphyWbUD56P66Cf16pckmKUP8RIxNYXFJ6THR1cT7E
	 XcHtW40rkc1F7zxPNxCeDwHizu+gyx+BLH9JrRR17aOm9/WSvD9kUxONq/+05N1bv7
	 jxxoplIw6uDzUXXX/ByKtWAIS4/z+Tayh3GGvLcGU+YqqqZmZi4UefWIFNtMcLgLwB
	 rCYsJuk95N0TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] packet: synchronize pressure clearing with ring reconfiguration
Date: Fri, 21 Aug 2026 19:11:21 -0400
Message-ID: <20260821231121.123131-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081735-ardently-exemplify-6b2b@gregkh>
References: <2026081735-ardently-exemplify-6b2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit 1a35da325cac4d5bcad76a2aa943408a6f1d9000 ]

packet_set_ring() updates the RX ring state under sk_receive_queue.lock,
but used to publish the tpacket receive mode through po->prot_hook.func
after releasing that lock. packet_poll() and packet_recvmsg() can then
run the pressure clearing path after the ring has been cleared while
still seeing tpacket_rcv, causing __packet_rcv_has_room() to dereference
stale or NULL ring storage.

Move the existing receive hook assignment into the same
sk_receive_queue.lock section as the ring state update. Keep the
assignment otherwise unchanged, including on TX ring reconfiguration, to
avoid adding behavior changes that are not required for the fix.

Serialize packet_recvmsg() pressure clearing with the same queue lock
only after PACKET_SOCK_PRESSURE has been observed. If the flag is clear
and the socket has moved away from tpacket_rcv, packet_set_ring() has
already detached the socket and waited for synchronize_net(), so no new
packet input can set the flag again.

packet_poll() already holds sk_receive_queue.lock, so it uses the new
unlocked helper directly.

Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Link: https://patch.msgid.link/f90b5688311fa278d1361ea8c6be0bf25967d591.1785247446.git.zihanx@nebusec.ai
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Replaced `packet_sock_flag(po, PACKET_SOCK_PRESSURE)` with `READ_ONCE(po->pressure)` since the flag conversion isn't in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f73e2c3b813d9..32a093b792fd2 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1330,13 +1330,25 @@ static int packet_rcv_has_room(struct packet_sock *po, struct sk_buff *skb)
 	return ret;
 }
 
-static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+static void __packet_rcv_try_clear_pressure(struct packet_sock *po)
 {
 	if (READ_ONCE(po->pressure) &&
 	    __packet_rcv_has_room(po, NULL) == ROOM_NORMAL)
 		WRITE_ONCE(po->pressure,  0);
 }
 
+static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+{
+	struct sock *sk = &po->sk;
+
+	if (!READ_ONCE(po->pressure))
+		return;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	__packet_rcv_try_clear_pressure(po);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
 static void packet_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_error_queue);
@@ -4295,7 +4307,7 @@ static __poll_t packet_poll(struct file *file, struct socket *sock,
 			TP_STATUS_KERNEL))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
-	packet_rcv_try_clear_pressure(po);
+	__packet_rcv_try_clear_pressure(po);
 	spin_unlock_bh(&sk->sk_receive_queue.lock);
 	spin_lock_bh(&sk->sk_write_queue.lock);
 	if (po->tx_ring.pg_vec) {
@@ -4535,14 +4547,14 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		rb->frame_max = (req->tp_frame_nr - 1);
 		rb->head = 0;
 		rb->frame_size = req->tp_frame_size;
+		po->prot_hook.func = (po->rx_ring.pg_vec) ?
+						tpacket_rcv : packet_rcv;
 		spin_unlock_bh(&rb_queue->lock);
 
 		swap(rb->pg_vec_order, order);
 		swap(rb->pg_vec_len, req->tp_block_nr);
 
 		rb->pg_vec_pages = req->tp_block_size/PAGE_SIZE;
-		po->prot_hook.func = (po->rx_ring.pg_vec) ?
-						tpacket_rcv : packet_rcv;
 		skb_queue_purge(rb_queue);
 		if (atomic_long_read(&po->mapped))
 			pr_err("packet_mmap: vma is busy: %ld\n",
-- 
2.53.0

