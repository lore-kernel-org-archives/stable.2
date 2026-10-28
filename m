Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225083;
	b=VXX/EjH+ZdnZUMjFhvu84bmxkiH1idgkz81LRE2QUyEUaqxGiDJaKUsRC+oWsZ/YcP+P
	 T4kEdQGriR9Go0chsN6KYZP/kNXTN1Vhl3bJzzz/kp8HBxJItdDH51WDrzvIGgisaUtLK
	 2HpAdKRB5gQbI9v4bsu8OQEcYosEBRV6twQvg/W1gVAS2CtWBtKE7izoh5T7Jb//VfLgj
	 7PZmLmG1UzcEFQeHtdRH40PyTYdOAWkrVewYe+RGsW2ZLrcW51jvD6R6DsninFSKqRBxK
	 DTBepbU2MC5YdL8aqKzBsWxjKk6PxzVDKGX4UGa7o6AC0HA4deYHZ7E48UCwne889EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225083;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=bbh7ro44JUZscSvhfLF662noRd/zDD1qgxDlfqHkslM=;
	b=1Dbqr9LgxHMRB66XDp06euJbYGalynbZeMC7Xg5YOzqs3bnt90NGc5CEkIutB0Avlu5e
	 lFtKLpC7wMllPh5mg1OjJgvNTSh6TziYzUoysF8kQLkQaMIYGKulm9erEbTYESOcp/CXS
	 gJXntXudD55pTM/wmGr3ob/yF5KjdTb8uzc3W68cMqZd0bheDGuPHKrScWeLdmfolscbD
	 kvoIb2GM/xeQisbJCT6Kznyw5L1u+LskGcO7CWZqNsqfRhpgDC9W2xMzIRl9rraywR93U
	 XPC/NKP0uH37SjU5HnN7wwNQ5wiP1Be5ctWdmOvVhTChHwXRMrVEEtYzQ4COh22ITAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=unstable.cc;
	spf=pass smtp.mailfrom=unstable.cc;
	dkim=pass header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=zOmZeaQW;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F76606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unstable.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=zOmZeaQW
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jFLxd1KBLzKnB8;
	Wed, 28 Oct 2026 23:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
	t=1793225077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bbh7ro44JUZscSvhfLF662noRd/zDD1qgxDlfqHkslM=;
	b=zOmZeaQWQhAa00nQ5Gp3+f+x+qbwM/jaSdzwYM3FiuwYDzDI0Pb6ceqqgEJFjji+p/Irdx
	lqxqHNJuDEEbEz4bA3VYCE7xf4oCQS7UUKCz01Hw3hD6vC5TNVWmGaBG/zWkVIXB11pruB
	3c1yv6IbuNtodiDYxNF98M/gOs/HBg/ekf7VUKcQI2caywtqqRPrU0c+B00J0Z5/RDN9hy
	aGPFDoNBj7rxdP0FVx6xLMh7Yh2wAeJjdXL1MyKyBoHKWHeAP7vR1+631ZQF93dCqeZCeW
	YtK7AejclTpUVgP4OKt1MrLuc5WIwhrYtmRsbW2txVUJrVYhpjQVE8sCnQ4Mvw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@openvpn.net>,
	stable@vger.kernel.org,
	Bernhard Schmidt <berni@birkenwald.de>
Subject: [PATCH ovpn net] ovpn: drop packets looping back into their own TCP transport socket
Date: Wed, 28 Oct 2026 23:04:30 +0100
Message-ID: <20261028220430.968756-1-a@unstable.cc>
X-Mailer: git-send-email 2.55.0
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
X-Rspamd-Queue-Id: 4jFLxd1KBLzKnB8

From: Antonio Quartulli <antonio@openvpn.net>

If the outer packets of a TCP peer are routed into the ovpn interface,
ovpn_net_xmit() selects that same peer and ovpn_tcp_send_skb() tries to
take sk->sk_lock.slock, which the TCP transmit path already holds.
The CPU deadlocks.

Drop such packets in ovpn_net_xmit().

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Cc: stable@vger.kernel.org
Reported-by: Bernhard Schmidt <berni@birkenwald.de>
Closes: https://lore.kernel.org/openvpn-devel/auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index f14eb4e6c46a..57cdea45dce7 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -349,6 +349,31 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	ovpn_peer_put(peer);
 }
 
+/**
+ * ovpn_skb_is_looping - check if skb comes from the peer's own socket
+ * @peer: the peer the skb is about to be sent to
+ * @skb: the packet to check
+ *
+ * Return: true if @skb was generated by the transport socket of @peer,
+ * false otherwise
+ */
+static bool ovpn_skb_is_looping(struct ovpn_peer *peer,
+				const struct sk_buff *skb)
+{
+	struct ovpn_socket *sock;
+	bool ret;
+
+	if (!skb->sk)
+		return false;
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	ret = sock && sock->sk == skb->sk;
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -386,6 +411,13 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		goto drop_no_peer;
 	}
+
+	if (unlikely(ovpn_skb_is_looping(peer, skb))) {
+		net_warn_ratelimited("%s: recursive routing detected, dropping TCP packet to peer %u\n",
+				     netdev_name(ovpn->dev), peer->id);
+		goto drop;
+	}
+
 	/* dst was needed for peer selection - it can now be dropped */
 	skb_dst_drop(skb);
 
-- 
2.55.0

