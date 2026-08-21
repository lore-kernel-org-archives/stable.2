Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950D429CEC
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323807; cv=none; b=JJ7S+i73AKFdiSfKUYRJzzaUM8Q4vkN4VO8xSs8euA/eNFItEWBLJ3GZSbHIlitdYezcjrEQDrb5gsGP4W59QAInPfjPHCvZqgsulsRYKxZ/xNKkLhJwShQ4nwEYsrV1XIPF3g8n5hceqjVTVRl392F8f/DqmRs8jNbH+sB+A2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323807; c=relaxed/simple;
	bh=qi1QTodV+kIwmETN2emF6aLpTrJ2CSY9+JheTqWovGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcNOs0pVeGFpGf8KIRkqIZ3TfQ9bWgcUuhJ52pDIkKGxBnvPQhiiN1sWF23A+GaCTOOGMdurOg0jVfNZOva15GDxufLifR6W0XOAn0VtHEuwL8ZFzf7scELpl9TU25lceN0zVO/ukxErknNzlLKuE3QXpmYLn+dl6EOcuF4hwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMHH5rSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMHH5rSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E7C1F00A3E;
	Fri, 21 Aug 2026 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323805;
	bh=bkt2Y+xV37qKRs1kUzoqHomyE0j+MYUeNLUKvUCZoqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMHH5rSYeTCWnorNzUmO70222552hypTOhC7V03GjErJ8BCo0zq1e407aBEPDa9PC
	 t9+6eG0bSLIFyxaMj9dwAxCPBH+PpWWDsORYkML9gvs1lZpShd8hQJCy2zPCAQ7czy
	 S9LypJJwbEQvILX23HuD3vcgBtD+DjUxR0tvznB9338o2/PHxbKDkiQ8LRsYkx413L
	 ElztGLFBEOeFoDgchNEda1p1ObNn8aD5VSWO+YWgYv8PduGp/liQ6h/uzZZXhhcIHF
	 k8sCBeeOu9DhaBs34yujME3xyAQHOic6ArmuNQLM4RqpxPpHqECkMtvss3hAJA3WSR
	 FVECiBdUXV54Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qihang Tang <q.h.hack.winter@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] packet: use consistent hard_header_len in TX_RING send path
Date: Fri, 21 Aug 2026 10:50:02 -0400
Message-ID: <20260821145002.3430322-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821145002.3430322-1-sashal@kernel.org>
References: <2026081746-railing-baffling-3449@gregkh>
 <20260821145002.3430322-1-sashal@kernel.org>
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
[ Applied cleanly after amending the prerequisite that adds `LL_RESERVED_SPACE_EX()`; no target-side adaptation was needed. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index c1c345dd2ee3b..3a93c045232fa 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2586,6 +2586,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2617,8 +2618,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2748,7 +2749,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2795,8 +2796,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2833,7 +2835,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
 		if (po->has_vnet_hdr) {
 			data += sizeof(vnet_hdr);
@@ -2851,10 +2853,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
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
@@ -2864,7 +2866,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_status;
 		}
 		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
-					  addr, hlen, copylen, &sockc);
+					  addr, hlen, copylen, hard_header_len,
+					  &sockc);
 		if (likely(tp_len >= 0) &&
 		    tp_len > dev->mtu + reserve &&
 		    !po->has_vnet_hdr &&
-- 
2.53.0

