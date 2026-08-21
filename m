Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6847728F
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310021; cv=none; b=VyFr9VJG9jHkU0LKK+ENQp9GeC/zu3fLO7lI3RE8ebX477Giwe4a9JfDdxlJz/tRxQH77U5CuXS+QFFRMtYfmFWsK9yK1dBeeKO7ETboa/48sUL1JSyy1myrxSMrFY//BilGm2Vr1oOsAA4MbkyferE8SLwAnLbF4JP3bcKnZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310021; c=relaxed/simple;
	bh=WlqR5pr15Tl9F5iX8LWyDw4u/41qm0GBtdQJL0iMc6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0AO2mjU8rmzoyPybkpeUeOENNisfwdsgmqoEXKq7RWrKxMZUaFecIlSQYUfVt3AMa+pkArYsS3+H2JIAmYOvW69By2xqFqRmqhZQXqUB6SrKpP3NAJpBu/EcD3KtD53daSJbLl2QGNr9abjOUgBB6QBaf/2lcDrd4NF70z/Ih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oepWJUwk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oepWJUwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B1A1F00A3A;
	Fri, 21 Aug 2026 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787310020;
	bh=4YcZ3J8DNez4g5fJgfVAlkSU+69c3k6726xpdCjY7KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oepWJUwkEOiie8EriUUijhGIKTxoBcly7EEausMFNz1fjIEPBOgWz3aWFNc+eihbF
	 6hkmhYRklEMszD7yKZWDn7vsUrH4Ck40pke/zip6GM6Savy+iNlozk+3Ea+5yPrjbd
	 Awinwwv6b45OeCffC+xN/02CeHyiGsqfltWsuzZsjRDfcZydXSEc/hQv3xZ7Q0Xv1F
	 e5rK6qyqkhDqFUxF88jF/vQpVuoTuc04nmF9S6Dj80IAapS2KbK1r2JblVkhoOngZj
	 AmLrbYDsPWTXZW6rWw1V7UNpLoY8nxgnjcbLLZPE0V0AeD4yyCTbaytO5kmjesHc6O
	 76wP/W5iKIFcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qihang Tang <q.h.hack.winter@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] packet: use consistent hard_header_len in TX_RING send path
Date: Fri, 21 Aug 2026 07:00:17 -0400
Message-ID: <20260821110017.2816998-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821110017.2816998-1-sashal@kernel.org>
References: <2026081745-brisket-pastime-f9bb@gregkh>
 <20260821110017.2816998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

[ Upstream commit 21b5953e7494c16a42e6cd8cf110e18d13ae4a6b ]

tpacket_snd() reads dev->hard_header_len independently for skb
allocation and header construction in tpacket_fill_skb(). Concurrent
netdevice reconfiguration can therefore make the reserved headroom
smaller than the amount later pushed, or make copylen - hard_header_len
negative.

Snapshot hard_header_len once before processing ring frames and use it
for the frame limit, headroom allocation, copy length, and skb
construction. Pass the snapshot to tpacket_fill_skb().

The separate SOCK_DGRAM consistency problem between hard_header_len and
header_ops->create is not addressed here.

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260805125729.19220-4-q.h.hack.winter@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 3130c4bf3f5b5..76ddf808e0a7b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2624,6 +2624,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2655,8 +2656,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2786,7 +2787,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2833,8 +2834,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2872,7 +2874,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
 		if (packet_sock_flag(po, PACKET_SOCK_HAS_VNET_HDR)) {
 			data += sizeof(vnet_hdr);
@@ -2890,10 +2892,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 						    vnet_hdr.hdr_len);
 			has_vnet_hdr = true;
 		}
-		copylen = max_t(int, copylen, dev->hard_header_len);
+		copylen = max_t(int, copylen, hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
 				hlen + tlen + sizeof(struct sockaddr_ll) +
-				(copylen - dev->hard_header_len),
+				(copylen - hard_header_len),
 				!need_wait, &err);
 
 		if (unlikely(skb == NULL)) {
@@ -2903,7 +2905,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_status;
 		}
 		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
-					  addr, hlen, copylen, &sockc);
+					  addr, hlen, copylen, hard_header_len,
+					  &sockc);
 		if (likely(tp_len >= 0) &&
 		    tp_len > dev->mtu + reserve &&
 		    !packet_sock_flag(po, PACKET_SOCK_HAS_VNET_HDR) &&
-- 
2.53.0

