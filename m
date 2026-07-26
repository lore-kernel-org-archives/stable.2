Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCF1F0991
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785057692; cv=none; b=gAOz7FXRti9nnXZqpkL9koMoQ31wu9qhmxn8VPyVFI/PECaPB4PX2BmPB7t6ySH0s6jMdEw5oGoztOfpyv9eAAyS7KLHx6iHlQXt4bCxF0bbJvus7toZaANdFZR7ERW7mm0siyXh9omstt1YwN5+D3E+BA2M/b/if2+MSYwaMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785057692; c=relaxed/simple;
	bh=lafd3XEcaNeaMaLenplXzbLxjLUVzRQKpK5icSzVVTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJmYqswuTpC4jYNN/mgDB1CepY9qdkthJGF5rqGAaW/AtddN2Np8+ngRP5PfMTHmQRgi03XJjwguNHPEbWSPwRWdd4RlOJJkZf0a436qQ+aglROzNJP9Os7QgnmBAqfxCYnX7uu8G+D2v5ZyEdi7iX9wSdPK6NLhMHcNAwbn5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPB07ovy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPB07ovy"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a3e5ca66eso246378b3a.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785057691; x=1785662491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+s/4/9g/DhYkPtUyAU+bTxPmdaVZeyponCpbYYiuK/k=;
        b=JPB07ovy3Llk7wLaLSLuN+P1Chj4oZVGuc89ECHZKFmLKhKJgFrSQcjOkBmKLyMKOh
         NeMsdutDG1B1uvZ299xVXfpk98EohPKdohGv7mNyvYD9ibRR64P8pMYzhKBNP4eUrfZB
         MQ9+9ElJyT41bQQlJG7o9rVtXhwlfmLm4ilUJppw4uULZZ3bIuY1Vk/KYcDChXc8GqIg
         yvnWXRy16OAeh049iiDqILayCZ3QABMGyv7L4mIKaSOmgaO8i4ZcWVQPYbjUO+QFvFSb
         EbuKmsNT5qVGeo6i1BoQLYJwZSCyzfqRtEhyoYaJU5mP7r1BenuBAlbrTNDWFZx76Osi
         cpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785057691; x=1785662491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+s/4/9g/DhYkPtUyAU+bTxPmdaVZeyponCpbYYiuK/k=;
        b=MjtdeX2leysmdGGFzlR25O4O89k/UJbDn3jLA3pfltWHgpqWPrgBjUwWwrb46685U5
         yKx7KJKxKwlIrVzxXBxHrIctcpYbL5nkDgXq4odTHOagxxRdn6sfJIhPJhx2GPShYata
         ucFbsaR6OLyt7WLhYiggrVA4jqrEB/15Pw4T4HyUCuXdxadvcb6XFhEGh2EHDcVhTSDs
         k1r2UlpuaPgf6b79ghQnWWorkFVN395ah6VpcYbLciDI/j/fHVqD5kUhHsJMor0DyMBa
         TyaIwpmYDIXghUk3b56hdDzSPwSPIibJm2Tq+WZNZ8U8cwgBFxB0TkMu58cUrVY+0hTH
         xBzw==
X-Forwarded-Encrypted: i=1; AHgh+RoEboF5LjECN7jf/JvZik8Zw6oWMPlfFYe3q9pYlPQYGG0LcJXeO6hg6z9jfDswxLrNkP4fTTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo36pWAAZNNzOrAIKGqVJVOP/rgusqOlbiiGTFTFs9e/zzmRbJ
	nLVLZPWO2KuPi2KZEDZ7v5ilLWr8v1NBTMX6o7avamwEBXRiRq0dy04w
X-Gm-Gg: AR+sD13CYTkyLfnDSA2eXcMpXXnksy2WoGPuNG36RQ6QoCHEJHytMxeMuD4Dx93lK8Z
	bKs4mmpRbCGs5ZCCgJUHyzp2tSfDhq91K4FWLMQC6E0PA0lYqWCISQnz5JbbbFBZMDtmzEBVlC7
	f/4eE18aKWnQI3Zlcspoi3FhabbHcf++ElzuhkACbKdJFtepk/col+BUcs3GDfE9qaanl6ozPsr
	qU4bNRbBwPxz9cH0KG4sV1kmNnnyFcFkXulxJSItIBaUZypv8bBXNWhLjVpd18Z/bivyPktFr/g
	D1rScPs416LiIEvMirfR3uvkNzi77ZHZ8BKlC2MtB0ahyv6E6DzeZgHX37wwCEneqlEBdASaMKc
	Ki91V0LMia5KTmV7XUyYOBQDXjDwi4pBWPhXHZDl01W0eiASol+SdD7y8HM/uF8lngzAIAFEVk/
	JddBoeRRMXZZxo6W4qc3Ul+fH2j9QXlUkMBSpuuYgXU5a2Zs+UzxaCTCGe/NMt5J8K1QNf
X-Received: by 2002:a17:903:468d:b0:2c9:99be:f011 with SMTP id d9443c01a7336-2cfde8941b5mr36180245ad.6.1785057690388;
        Sun, 26 Jul 2026 02:21:30 -0700 (PDT)
Received: from localhost.localdomain ([183.46.220.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b44sm18158465ad.27.2026.07.26.02.21.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 02:21:30 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v2] packet: use consistent header lengths in raw send paths
Date: Sun, 26 Jul 2026 17:21:10 +0800
Message-ID: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
References: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

packet_snd(), tpacket_snd(), and packet_sendmsg_spkt() read
dev->hard_header_len multiple times while allocating and constructing an
skb. Device reconfiguration can change this value concurrently, for
example through bonding device type changes.

For SOCK_RAW, packet_snd() can save a larger value in reserve and later
allocate headroom using a smaller value. Moving skb->data back by reserve
then places it before skb->head, and the following copy from userspace can
attempt an out-of-bounds write.

tpacket_snd() similarly uses independent values for allocation and for
the skb_push()/skb_put() operations in tpacket_fill_skb(). The legacy
packet_sendmsg_spkt() path also calculates its reservation and header
offset from separate reads before dropping the RCU read lock to allocate
the skb. A larger offset than reservation can move skb->data before
skb->head, while mixed TX-ring values can also make
copylen - hard_header_len negative.

Read hard_header_len once for each send operation and use that value for
RAW allocation and construction. The trigger requires racing an
AF_PACKET sender with privileged netdevice reconfiguration.

The separate SOCK_DGRAM consistency problem between hard_header_len and
header_ops->create is not addressed here.

Fixes: b84bbaf7a6c8 ("packet: in packet_snd start writing at link layer allocation")
Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
v2:
- Cover packet_sendmsg_spkt().
- Limit snapshot-based calculations to RAW construction; leave DGRAM
  unchanged for a separate fix.

Link to v1: https://lore.kernel.org/netdev/20260721084935.12312-1-q.h.hack.winter@gmail.com/
---
 net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e75d2932475a..d23898f24641 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1953,6 +1953,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	struct net_device *dev;
 	struct sockcm_cookie sockc;
 	__be16 proto = 0;
+	unsigned int hard_header_len = 0;
 	int err;
 	int extra_len = 0;
 
@@ -1996,15 +1997,21 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		}
 		extra_len = 4; /* We're doing our own CRC */
 	}
+	if (!skb)
+		hard_header_len = READ_ONCE(dev->hard_header_len);
 
 	err = -EMSGSIZE;
-	if (len > dev->mtu + dev->hard_header_len + VLAN_HLEN + extra_len)
+	if (len > dev->mtu + hard_header_len + VLAN_HLEN + extra_len)
 		goto out_unlock;
 
 	if (!skb) {
-		size_t reserved = LL_RESERVED_SPACE(dev);
+		size_t reserved;
 		int tlen = dev->needed_tailroom;
-		unsigned int hhlen = dev->header_ops ? dev->hard_header_len : 0;
+		unsigned int hhlen = READ_ONCE(dev->header_ops) ?
+				     hard_header_len : 0;
+
+		reserved = ((hard_header_len + READ_ONCE(dev->needed_headroom)) &
+			    ~(HH_DATA_MOD - 1)) + HH_DATA_MOD;
 
 		rcu_read_unlock();
 		skb = sock_wmalloc(sk, len + reserved + tlen, 0, GFP_KERNEL);
@@ -2569,6 +2576,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2600,8 +2608,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2732,7 +2740,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len = 0, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2779,8 +2787,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
-	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+	if (po->sk.sk_socket->type == SOCK_RAW) {
+		hard_header_len = READ_ONCE(dev->hard_header_len);
+		reserve = hard_header_len;
+	}
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2817,7 +2827,12 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		if (po->sk.sk_socket->type == SOCK_RAW)
+			hlen = ((hard_header_len +
+				 READ_ONCE(dev->needed_headroom)) &
+				~(HH_DATA_MOD - 1)) + HH_DATA_MOD;
+		else
+			hlen = LL_RESERVED_SPACE(dev);
 		tlen = dev->needed_tailroom;
 		if (vnet_hdr_sz) {
 			data += vnet_hdr_sz;
@@ -2835,10 +2850,14 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 						    vnet_hdr.hdr_len);
 			has_vnet_hdr = true;
 		}
-		copylen = max_t(int, copylen, dev->hard_header_len);
+		if (po->sk.sk_socket->type == SOCK_RAW)
+			copylen = max_t(int, copylen, hard_header_len);
+		else
+			copylen = max_t(int, copylen, dev->hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
 				hlen + tlen + sizeof(struct sockaddr_ll) +
-				(copylen - dev->hard_header_len),
+				(copylen - (po->sk.sk_socket->type == SOCK_RAW ?
+				 hard_header_len : dev->hard_header_len)),
 				!need_wait, &err);
 
 		if (unlikely(skb == NULL)) {
@@ -2848,7 +2867,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_status;
 		}
 		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
-					  addr, hlen, copylen, &sockc);
+					  addr, hlen, copylen, hard_header_len,
+					  &sockc);
 		if (likely(tp_len >= 0) &&
 		    tp_len > dev->mtu + reserve &&
 		    !vnet_hdr_sz &&
@@ -2956,7 +2976,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	int offset = 0;
 	struct packet_sock *po = pkt_sk(sk);
 	int vnet_hdr_sz = READ_ONCE(po->vnet_hdr_sz);
-	int hlen, tlen, linear;
+	int hard_header_len = 0, hlen, tlen, linear;
 	int extra_len = 0;
 
 	/*
@@ -2996,14 +3016,17 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 			goto out_unlock;
 	}
 
-	if (sock->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
 	if (vnet_hdr_sz) {
 		err = packet_snd_vnet_parse(msg, &len, &vnet_hdr, vnet_hdr_sz);
 		if (err)
 			goto out_unlock;
 	}
 
+	if (sock->type == SOCK_RAW) {
+		hard_header_len = READ_ONCE(dev->hard_header_len);
+		reserve = hard_header_len;
+	}
+
 	if (unlikely(sock_flag(sk, SOCK_NOFCS))) {
 		if (!netif_supports_nofcs(dev)) {
 			err = -EPROTONOSUPPORT;
@@ -3018,10 +3041,15 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	err = -ENOBUFS;
-	hlen = LL_RESERVED_SPACE(dev);
+	if (sock->type == SOCK_RAW)
+		hlen = ((hard_header_len + READ_ONCE(dev->needed_headroom)) &
+			~(HH_DATA_MOD - 1)) + HH_DATA_MOD;
+	else
+		hlen = LL_RESERVED_SPACE(dev);
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
-	linear = max(linear, min_t(int, len, dev->hard_header_len));
+	linear = max(linear, min_t(int, len, sock->type == SOCK_RAW ?
+					 hard_header_len : dev->hard_header_len));
 	skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
 			       msg->msg_flags & MSG_DONTWAIT, &err);
 	if (skb == NULL)
@@ -3037,7 +3065,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	} else if (reserve) {
 		skb_reserve(skb, -reserve);
 		if (len < reserve + sizeof(struct ipv6hdr) &&
-		    dev->min_header_len != dev->hard_header_len)
+		    dev->min_header_len != hard_header_len)
 			skb_reset_network_header(skb);
 	}
 
-- 
2.50.1 (Apple Git-155)

