Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91438313543
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331145; cv=none; b=ZZsuMBgjboLtBob8LT5gnKW0EdFHGk0GKvmt/smiV7HhCj6wZPh+4/vvgPNQqwZhwSnW+9ksBcMSbZMXUmEmq+JULXr+Ew/RDeJ0dTEM5upaXB4amsME6MgdV7sUxeDRPtkRrqJz25UsnbadF1VgmhULJu53mmL4aRcQyNTKfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331145; c=relaxed/simple;
	bh=kPMR8KZRkCclcelI4r55M6pvpJ3OUMGCLLZiXRrUa48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjVnn3QMTVmbmgdnR9eb4+l2cL9O3h7WTz9jpKkkLBUPm7jpdqpyVmUH4aUujyb/TaIHtO0rVngH88wXe5SAeYYXf2rdjXE3kGErulydCm3Poidy7k+bdB7ywuU91E3eb2c4OOJ4p3bzUWOfCsqXA6ZgZ10qp5jdwSMYaTtZAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwYdhb46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwYdhb46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4851F00A3F;
	Fri, 21 Aug 2026 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331142;
	bh=JD0mR69HJnywxdueJ3qmrljLur9MgHu3WukpoZs52+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwYdhb46iA3+fgdDgjt8IAlI6Ajzd3qIbNUNJg3IDpdWchuW++WqrKFm1ITdMUEYp
	 FyKmwA+yq7tPA/SH/O8EiQF/iqGiasNTHusIAzBLRT2UM+dmgjRifbR3aA5Siy3CA9
	 2GIE6frFEbj5bmay820CIFMjjTQFTgZSVc5BNjftpaZvT8ihS+5xO7R6+I2LHp0mga
	 K7MyJ4OMQMJqkoLghsL/L1yzWPcckZfFR6p1LYuSo8JRKSiM7Ue9DvDt5KGuoLDObI
	 bsb8yklpfl39ms7+HDbZd0DNDB1i29wuc9pl6mOu6imnyD02fZXgunZ1aR4LQO5UFc
	 vjnUgaUShAKkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qihang Tang <q.h.hack.winter@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] packet: use consistent hard_header_len in TX_RING send path
Date: Fri, 21 Aug 2026 12:52:19 -0400
Message-ID: <20260821165219.3595277-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821165219.3595277-1-sashal@kernel.org>
References: <2026081746-clarinet-enrage-8399@gregkh>
 <20260821165219.3595277-1-sashal@kernel.org>
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
index 4aa1976695a8a..3e72c77a8bc92 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2582,6 +2582,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2613,8 +2614,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2744,7 +2745,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2791,8 +2792,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2829,7 +2831,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
 		if (po->has_vnet_hdr) {
 			data += sizeof(vnet_hdr);
@@ -2847,10 +2849,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
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
@@ -2860,7 +2862,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
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

