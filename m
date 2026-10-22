Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671378;
	b=OsXe6tZCuATuFn3gn9Rgg8ARR6GoK9beM0OkW9AUuuxxhrgZz3P1sc/loW0Tw6XfDOIu
	 MyD94+EZTFc/SIRVGkyuA5lD0bGM32i1D4MknOtPAA2Vfs7aXSuhty7+3C7g4Phi0j/NO
	 2e4mf8EFW/UWCxdWxnMjdvJk2aTurQp13sXeGYTwKRHPYSjx4qWhven5PnOF/hhbSLSlK
	 HxyZl3j2eqn232OGSkG/2qWM7l5Vu9NChYLGCjnKx7osKMgYvHl3P5nQKSOfY+S5VHZ/v
	 vGmQt1K91wn32fLsE6TOuCt7x279ORygwEXt91sQdQJv8hmIG69j361iNNeI3jXZ8cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gfTYAoVpaaDmH0mgQFGDbepVIqXA0f2bS7AW/yiLqxs=;
	b=Xdp6afDVrgcXKlkzpqSPpib9OxvXroE/H5614Yzec0TCGndj/wViFEzvFXJHjrB69I9P
	 0Ax0wV2UyVWhLhkqSoBQ0BsuZRfpVEA9CYoK8TKMfjoAmKA1MaC9uVLX/DHFATx+IC5XN
	 4RbV1do6fu2BL3DKEMHBJl8ZSagfwL5I+mKe1MMtcMCnP2FGSjjRi3CgfcrUOlmIPaIx8
	 2DfrPPtHM3NkdM/jSoyo3XC6LjXg0FAiD3CLkkUqHMA+LiBwz1Bq7aWkEoxFOvPfIOVek
	 Ey7SmDjMduIrG8zpHfLqyNFIOGsf0OIQNFkThHBS+zTcx0ywjcaXBhiGUm4ysmEeJ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NW5mqozZ;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854C606A337
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A854C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NW5mqozZ
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afbd2c386so1220800f8f.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 05:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671376; x=1793276176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gfTYAoVpaaDmH0mgQFGDbepVIqXA0f2bS7AW/yiLqxs=;
        b=NW5mqozZyzr5AGlK58+S1W/Wh0Q8DckUgRPxd1dtig7bG7VBr3/PLAYsJARbwMjBC5
         vXHMg5dJJuM7cy4CDXZFx4Fqh/gIljWwhqSA639STEZPll9PYhQXVfdqtxWTLXUhmu0D
         Zkly2pWPj3tafjz+PwfPrXR0q0jDE+CLuou5uzGGLsMjxdVe0N5oeZSl01CloPnN0w71
         XBU9XgAxAdj26w2QJzDdKvCE8WzJXrTMzICSszdQ/j2t6mjUpEHsAWQ3xWzw3ZArrz/L
         q2qijos7xf2ftPckueGA9QN2Xsn6VUvr7bEzwdwRPIz+NvaJ42U0E04i0cfJeSzlrIJo
         1Iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671376; x=1793276176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gfTYAoVpaaDmH0mgQFGDbepVIqXA0f2bS7AW/yiLqxs=;
        b=RLULDIP3BECKGOqT8jNA3oKy3FE9oot8ZOW0dGgpdYpDMik8htLJg1QmKdORSBoXfQ
         tibKxjQvkAmTBFwtASptrjNz+4AHdzRyx1LYqC2oH1mDFjIg8uPvNKJyGz/AKjmJcrlQ
         tMhPFHVITe7GeOAp9WcxO1doKPFJHtvn7gCAPOPPuA2UcNyt7u5jyoSVpcsoQjiGE14J
         WmpOw/TCmh2lKObmGzudmzkOEPN3o64yIt7yqnUkZnlVTro89Ck5QDoas2/FbBitip+Y
         kyXl1dkZPH7MNY6Hj/fNZ+wmzy6pktc6OEwRvy8i3NYUqn66mlMHyolxRMnSwxHD/L2x
         ts+A==
X-Forwarded-Encrypted: i=1; AKwUvBwNSGrMqkHG0Md3bu9+E8pdZZNv1ZyyepIXS4QD9pwlfw5vB/XOWWE1rJeEP/tzvx+oF8mqV6U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxr8CB1zfilRBYPXcuZ+T/XxtIa2JsRVzHSYK2SpLzVXwLXz1K
	p0UmoSTjco5lwYJDU2CBvv/Rpa8C61sWl5TGcJASIm3h0908rXp1hunyohNqRAzHDI4hSsOAk55
	k4x8n8b0LiAo0hMuUjq7EwkK7lPgg3N0MLTYHyb881SAMZ4aoUX+ZIuWh3v+yUBlTius=
X-Gm-Gg: AYBFou2nIw5ePIChh5d7hSEJYn+2Pm+4M7jZG6ua/SflkPQBJrdmExyTzvEr+688rwJ
	7CiRDknTtgVXNR/Gzh5omLYqSfK3JogfRiatB47pfdnWvQaELO5XsIpMmTJQk1ck24FUJqlqvJY
	qhTtjwVlbkNoYf8VgrRYwjq7KW1h4H5LvHfh7hcblh5kFLKQFsj4wIeXFPIJSolLA0KDymv8VXq
	wgCQ3dSIkW59o84kO9p7/XoWDTIcOWVu8Nl1BMA+xP1TM6aIsPSVnPpURXQNJjHSWAEAsLIIJ7L
	YubEZCHx2hpcvUJJUvxJ23ayvDTiwGQWdQeD/hKANr6t7wB3I8RgJRzgKfdR3hBwVasBcCqWD/U
	9Zr8EKVUUTsx5bily68k2OgR9kJgOES7PmlT2GbsM6Jwfx4/X6/KMvOPqbH2K5osi6AXd+5ENe0
	FaZCDNtyKHUD8vkzvSTSfGsyGl6NMair8okedebrybWt7sRsCS41dRQ67bVkLweMOPpog5qCqAP
	1HEeCteH79pxXII40BXN6Ivvm8BUqGvYV+XtrNc28HDS6pmPlsKB2UV2u812v4zyIbI
X-Received: by 2002:a05:600c:4e03:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a1fdd14200mr92652925e9.12.1792671375852;
        Thu, 22 Oct 2026 05:16:15 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:15 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 6/7] ovpn: fix TCP TX accounting for locally dropped packets
Date: Thu, 22 Oct 2026 14:15:49 +0200
Message-ID: <20261022121606.732029-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022121606.732029-1-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
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

From: Ralf Lici <ralf@mandelbit.com>

ovpn_encrypt_post updates peer TX stats and last_sent after handing an
encrypted skb to the configured transport. This is wrong for TCP when
the transport path rejects the skb locally: ovpn_tcp_send_skb can fail
when the per-peer output queue is full, or when another output skb is
still busy.

Make the TCP send helpers return an error when they cannot consume the
skb. For the encrypted data path, keep ownership in ovpn_encrypt_post on
error so it can account and free the drop without updating peer TX stats
or last_sent. Handle the same helper errors locally in TCP release and
sendmsg paths, which do not go through ovpn_encrypt_post.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Cc: stable@vger.kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c  |  4 ++-
 drivers/net/ovpn/tcp.c | 55 ++++++++++++++++++++++++++++++------------
 drivers/net/ovpn/tcp.h | 10 ++------
 3 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ce1993b243e6..eb9ba709523e 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -287,7 +287,9 @@ void ovpn_encrypt_post(void *data, int ret)
 			goto err_unlock;
 		break;
 	case IPPROTO_TCP:
-		ovpn_tcp_send_skb(peer, sock->sk, skb);
+		ret = ovpn_tcp_send_skb(peer, sock->sk, skb);
+		if (unlikely(ret < 0))
+			goto err_unlock;
 		break;
 	default:
 		/* no transport configured yet */
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 5340860c0b82..a3165580e97b 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -319,28 +319,39 @@ void ovpn_tcp_tx_work(struct work_struct *work)
 	release_sock(sock->sk);
 }
 
-static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
-				   struct sk_buff *skb)
+static int ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
+				  struct sk_buff *skb)
 {
 	if (peer->tcp.out_msg.skb)
 		ovpn_tcp_send_sock(peer, sk);
 
-	if (peer->tcp.out_msg.skb) {
-		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-		kfree_skb(skb);
-		return;
-	}
+	if (peer->tcp.out_msg.skb)
+		return -EBUSY;
 
 	peer->tcp.out_msg.skb = skb;
 	peer->tcp.out_msg.len = skb->len;
 	peer->tcp.out_msg.offset = 0;
 	ovpn_tcp_send_sock(peer, sk);
+	return 0;
 }
 
-void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb)
+/**
+ * ovpn_tcp_send_skb - Prepare skb and enqueue it for sending to peer
+ * @peer: destination peer
+ * @sk: transport socket
+ * @skb: packet to send
+ *
+ * Prepends the skb payload length, as required by the OpenVPN protocol in
+ * order to extract packets from the TCP stream on the receiver side.
+ *
+ * Return: 0 on success or a negative error code otherwise. On failure, the
+ * caller retains ownership of @skb.
+ */
+int ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb)
 {
 	u16 len = skb->len;
+	int ret = 0;
 
 	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
 
@@ -348,16 +359,16 @@ void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	if (sock_owned_by_user(sk)) {
 		if (skb_queue_len(&peer->tcp.out_queue) >=
 		    READ_ONCE(net_hotdata.max_backlog)) {
-			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-			kfree_skb(skb);
+			ret = -ENOBUFS;
 			goto unlock;
 		}
 		__skb_queue_tail(&peer->tcp.out_queue, skb);
 	} else {
-		ovpn_tcp_send_sock_skb(peer, sk, skb);
+		ret = ovpn_tcp_send_sock_skb(peer, sk, skb);
 	}
 unlock:
 	spin_unlock(&sk->sk_lock.slock);
+	return ret;
 }
 
 static void ovpn_tcp_release(struct sock *sk)
@@ -366,6 +377,7 @@ static void ovpn_tcp_release(struct sock *sk)
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
 	struct sk_buff *skb;
+	int ret;
 
 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
@@ -388,8 +400,13 @@ static void ovpn_tcp_release(struct sock *sk)
 	__skb_queue_head_init(&queue);
 	skb_queue_splice_init(&peer->tcp.out_queue, &queue);
 
-	while ((skb = __skb_dequeue(&queue)))
-		ovpn_tcp_send_sock_skb(peer, sk, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		ret = ovpn_tcp_send_sock_skb(peer, sk, skb);
+		if (unlikely(ret < 0)) {
+			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+			kfree_skb(skb);
+		}
+	}
 
 	peer->tcp.sk_cb.prot->release_cb(sk);
 	ovpn_peer_put(peer);
@@ -447,8 +464,14 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	}
 
 	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
-	ovpn_tcp_send_sock_skb(peer, sk, skb);
-	ret = size;
+	ret = ovpn_tcp_send_sock_skb(peer, sk, skb);
+	if (unlikely(ret < 0)) {
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
+		kfree_skb(skb);
+	} else {
+		ret = size;
+	}
+
 peer_free:
 	release_sock(sk);
 	ovpn_peer_put(peer);
diff --git a/drivers/net/ovpn/tcp.h b/drivers/net/ovpn/tcp.h
index a3aa3570ae5e..957f7f7db6c8 100644
--- a/drivers/net/ovpn/tcp.h
+++ b/drivers/net/ovpn/tcp.h
@@ -24,14 +24,8 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock);
 void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock);
 
-/* Prepare skb and enqueue it for sending to peer.
- *
- * Preparation consist in prepending the skb payload with its size.
- * Required by the OpenVPN protocol in order to extract packets from
- * the TCP stream on the receiver side.
- */
-void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb);
+int ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb);
 void ovpn_tcp_tx_work(struct work_struct *work);
 
 #endif /* _NET_OVPN_TCP_H_ */
