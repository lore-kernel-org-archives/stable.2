Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364046D2DC
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934705; cv=none; b=Znr7vvmZyAHub+5vH0y/0Z9s72XNAIhmn8xSd4F9AVUh+csrXGOXpKPe22kMSgJw0Kwfo9LJcW26nypi4z3tJfzHvLQsL1VgXO63EGHa9QxIa41VNdxXoPXjxO/tqGtotTpt0l+b1HaRguU7k2P556Xyk9MmtgVD6+qnodxuXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934705; c=relaxed/simple;
	bh=2c3j+x1oQYyMuC6YkSoOlfgH9+YHkAE/oawSeizlMoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhQy7R8Tkfh5dWabB6L9bQ/YRAN4tj7YUzULtHu0rdU2Ofa84RxXCSTwvQHELdrFFUVbFml3AygaqEkCWdjLYPZCk8YKme3CPngTZJqfLXloLw9oOmrp69qkh0mdqShBZ7eCkv26gYHsS7cjF2vGHxbjjMwyhe8DduIKMXEP0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBH8IMLP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBH8IMLP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cad68425a7so1247935ad.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934703; x=1786539503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJek6yMdu453eh5vhUQNuwpWpa+Mp383syuPawBLsMg=;
        b=aBH8IMLPrbrch1dXwExltplFgANN7PjT9g7m4cjKy7Snx7tyc2O28PcCg/N5TJH3sQ
         Z2ANqIXthsvwQNhm+S896PoOMxRkT6O08yZdKLar5AWgO1WRYZrXZw5JihYfwBpVpJSf
         xi+Pq1bqmdKD7/VJWiGw1++KfzB/ou/MJeMPTPQ6dLPRoEHiDAr/B2wD8Y4qd6z7WU+S
         NRgZBvzDOqU7zKF4VBsM7SYxFccbKNYeoQHPBdHklMVvj4pW//ur6UtfVfh4KGtdKIhv
         OazMyACbEB+x3OlpNryel3zeZG3KiWjHy29eUqV2vZwmsEniPqBwW6plakA3rsjOayuE
         fp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934703; x=1786539503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJek6yMdu453eh5vhUQNuwpWpa+Mp383syuPawBLsMg=;
        b=d4ZYW6RZoe6RDO8sj25b03KU+rOxgDKjrz9zVYTTNxzNVLIAxf0HXXXo8K2EFdJKPK
         cYTclJotDFQla5sAI+0A3nqnzv1Dmbjw9dmfs0Nw+rc0ywZNRD1dNeJQ6r15ZuLrmE6E
         lLhoGcNAIFXeE6KL1js11hHopgANy/BxWhDMDERe1uX9P+taKaC2xu42MUiXfr1G6ejE
         h8Rcb6exmqZlk/0fbbKB6jHVfgGLOXGJrb3H4S31U19n6y9En59hOnI8I6VbIO0m7fO8
         AMeRM/zSdJTvsUhw0U6uWWPWnglWrQyBU207KCpGJTpLdIb59p1o6Zxy5b2l3fFYXJRZ
         uLJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpmzc45DQ4Ixuhp/yfjLEuLtEZDj7Fuh7CiwsVqWp4S7aRKIBzoL2/9V2ZCCvqdZHVzgUhGCIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31QJ1L7V/vxQN927jAA121EVKKBuQWZSo6ufUJ2YHFj26Os7z
	SKjn8B99pyXC8C98ZJ29Da1s9bnhbksbZQVZz5y7QFz+3XgFKiJA4GUC
X-Gm-Gg: AR+sD12poVI78f1WgZgdqXtzRcBKFo7tXDwpdHpweQ8KnVCfSV6B0n6SiSZV82e7DyH
	GUanzkAVNOj5Yk3qw/OXABCyiD0Nq9CbryiQmMjK4AaKoM3J/nBa5vR5hMkqts7H3pENeiIG2tX
	O+p8YcBSvW+fOdV1jw3yHs+UY98k+k/nK6VDr7T2seQiJbpyeiu5socgjwWREBcKuPov84UGq6h
	EQGikNk4hJcA02PZR1GJ9FhwlMtTgX+Xmk5vlwLr06FVKo6mpRJR8ND+EG1XuhWnD3M0KZk5cD7
	VgeXKC9rywsmgUC8dm/4mldBTMUAmyPIf51hhQyHH05+qKPIH97pDUl/9t8qc1Xgi/fMTPxec9S
	vJTxFQbuOP/S5HfGsSoBeAP6vPiKY7Gy1y6eznSi82qVLBqRr1A3PyD0sdJoUG3Iz7wtZDyc3Nm
	BgOWmk+BpTZ7QZo55IlrpPquOpM16eXqXSMMhCnbjUrZOAT+IowaejvjbH4kStkzVgVTI15rGgV
	BmjxGVz+P2nfCr0KC+X1ywAFYnkEcJjqYkLENIwmVzRt4FCbosHt+IhzpjefA==
X-Received: by 2002:a17:903:32c9:b0:2c4:397:dd7a with SMTP id d9443c01a7336-2d0caa4978fmr47974385ad.4.1785934703288;
        Wed, 05 Aug 2026 05:58:23 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f8fb4bsm16514625ad.5.2026.08.05.05.58.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 05:58:23 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v6 3/3] packet: use consistent hard_header_len in TX_RING send path
Date: Wed,  5 Aug 2026 20:57:29 +0800
Message-ID: <20260805125729.19220-4-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
References: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

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
---
 net/packet/af_packet.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 88674a6e868c..e9b6810c885e 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2574,6 +2574,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2605,8 +2606,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2737,7 +2738,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2784,8 +2785,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2822,7 +2824,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
 		if (vnet_hdr_sz) {
 			data += vnet_hdr_sz;
@@ -2840,10 +2842,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
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
@@ -2853,7 +2855,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_status;
 		}
 		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
-					  addr, hlen, copylen, &sockc);
+					  addr, hlen, copylen, hard_header_len,
+					  &sockc);
 		if (likely(tp_len >= 0) &&
 		    tp_len > dev->mtu + reserve &&
 		    !vnet_hdr_sz &&
-- 
2.50.1 (Apple Git-155)

