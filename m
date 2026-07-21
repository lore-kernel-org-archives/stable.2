Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C924386550
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623792; cv=none; b=Xe+43fHNmxxfAFOM0mwFEFwJylOPpkusEEfG9VPLK3q535wqhbnLTRoJl/ZNMOj2jNPE359DultmNnuwR2R6fO8vLtvK88drL0Bg+5/pDQ2MUci+FwK+o1H4yyfhllRPwWziT8Z7Up913cwv1Jxe4MYH3hZtpp3uolR3jDULdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623792; c=relaxed/simple;
	bh=RcrpbeZPSkwjz1aTB0ZgqvLy6rjwPuW7YLvzBf6pDfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TywwYnkPKpmual9L0HZ5j35C3dkvZGG3qNXzrSD27LwtOnOC585XEnrNASHwpkEnd4bQUSKPbLEO1HgaJt8GkSGTxcRkFc9vsG8VetDme1J2231Q98IlyMO6ZC+TShtLngwUDfnQtaHaim7DH6HETOPmuLeteuLzYMY6KsL8Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDRVM07G; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDRVM07G"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cb2513ec378so793037a12.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784623790; x=1785228590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8j4hIAfzbn00Z/jaQ9ccgbCithXJ/H8iHtNs94IUW2U=;
        b=hDRVM07GkiouTVCY17T/cYVemyyC9s0OtvcB+EMINVLRJb7H3xRNyJ89bzv5Q5UuB1
         1HaSAhSK7BX6dIXVo6nT4U9+Rq4F4l8wxb9y5TQ/oDjlWOky5hcrzVIfyzAMcd8HMTNe
         17TyVaH6nyFFpNoRfjFPgdqJmzMENbtdsRJTiP2W63GP/LXSKheqNiPk2NQ4QEk2wotG
         fUiH9X45aAwuH9kmANgbuhrzXEuIccdlblvTaTLTL3ToQiOzTmSwSB3QG5hwjlCcmbFo
         qbBIr8W8Y2mSz1748dbZybxrQcQJiw9dqVo7ILC5XoixtKJfDdNVs7ZaDRMSbF2NK2p1
         O5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784623790; x=1785228590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8j4hIAfzbn00Z/jaQ9ccgbCithXJ/H8iHtNs94IUW2U=;
        b=QmJTYlAcAoYZRGvMdnVf2SDn9bgybiifGRtVFqosuP33V47jEKtmS6oJOx9dDI7aQ/
         +N/gJTQZUNH7UQaYPyJQKCiCf4L+Rzd3+0ivlZCgD5bZKT0gObF+So0y/OGDsLI3Hy1I
         jycGEARe8ZC2b48sL0AcjMxMvgriptJ4xfeFiheo9dF2aoyHblTxM91oKXc3ysVdIpcP
         BnudcHTzFHBHWkqPXM4Y0LnAozEAzh81YAicydRfGSE7ktzXx5PT9T2nJyLVXZVp3qmA
         qu2LsnGMUTvAtyTwfsPsQeGBGIAPS4aJQLiCm2xnE5ri0claW3IXjxbYgB9z2yPHfp7k
         H0Wg==
X-Forwarded-Encrypted: i=1; AHgh+RrKzzaqY0TTvSCI5ZEn2pBQkvoaQ0mB28XqOh05sWutE91uCQjdkapQ06tLPBAFVTC7nP+NRSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhomuMCZetfkwkKUFCqRGvpevzzpnBkTsqQlme6Y2v42ptkzAr
	y0zf0qar/rzIfsUBrUUEF4MJPAb87mV0SV3UBJMkEUCkma+5Vuyaef5L
X-Gm-Gg: AR+sD13vj6qvN9eDS880fk8nnyaawyOhQuJCBNraV8L4vFqAQVWTggswkD0SvmvkdAs
	AZs4VXEtMqFOEoj4pSs6S7roe+PV/Qruz1+2x0ABy2Hi9ln79PFEx0YRrF9PQH+DtuGtLNiPifl
	LxxChbR5v9qgTyigDU6Zk/rKNEJizaVhFoxGPsFklw1bTI42cmHTh3ca8dwWGUEEIhshYYFNvnQ
	kPtpwnYurcj8cSb/h7JDNvQv1vu6eg9kE5wfQA6m3eAc0GJq//IsQl10qWbC7LFTNKw/V1evXJA
	vVCyoO070IL74RSi+OnuGi1rLQ6Rmf0yFIYwMD4lLf1kdZqggv9PgKVSqM7rlEeEnhVW2oBmXHn
	QFJsxfTcXP+2TqIOWr5kHg9PaWl/OWPnc5B5F8vV6x7dXvzGp404GBMz8fv4bARdnKLTGPdln+H
	d8WQhN22mntK7OiUMzQfiGL2LKt/ycy0+Y2FjEpgcRvg4cVCCu/pnKbLpXxUBEIlPn
X-Received: by 2002:a05:6a00:408a:b0:845:cb89:c1a3 with SMTP id d2e1a72fcca58-84e0313e3f6mr1884354b3a.1.1784623790220;
        Tue, 21 Jul 2026 01:49:50 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c3793ec61sm5853450b3a.42.2026.07.21.01.49.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 01:49:49 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Qihang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] packet: use a consistent hard_header_len in send paths
Date: Tue, 21 Jul 2026 16:49:35 +0800
Message-ID: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

packet_snd() and tpacket_snd() read dev->hard_header_len multiple times
while building an skb. Device reconfiguration can change this value
concurrently, for example through bonding device type changes.

For SOCK_RAW, packet_snd() stores the first value in reserve, later
allocates headroom using LL_RESERVED_SPACE(dev), and then subtracts
reserve from the skb headroom. If hard_header_len decreases between the
reads, the skb can be allocated with less headroom than reserve, moving
skb->data before skb->head. The subsequent skb_copy_datagram_from_iter()
can then attempt an out-of-bounds copy. Hardened usercopy catches this as
a kernel memory overwrite attempt.

tpacket_snd() has the same issue because its allocation and
tpacket_fill_skb() use separate hard_header_len reads.

Read hard_header_len once in each send path and use that snapshot
consistently for skb allocation and construction.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/packet/af_packet.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e6f3a734ba0..d29e59273054 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2569,6 +2569,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2600,8 +2601,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2732,7 +2733,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2779,8 +2780,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2817,7 +2819,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hlen = ((hard_header_len + READ_ONCE(dev->needed_headroom)) &
+			~(HH_DATA_MOD - 1)) + HH_DATA_MOD;
 		tlen = dev->needed_tailroom;
 		if (vnet_hdr_sz) {
 			data += vnet_hdr_sz;
@@ -2835,10 +2838,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
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
@@ -2848,7 +2851,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_status;
 		}
 		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
-					  addr, hlen, copylen, &sockc);
+					  addr, hlen, copylen, hard_header_len,
+					  &sockc);
 		if (likely(tp_len >= 0) &&
 		    tp_len > dev->mtu + reserve &&
 		    !vnet_hdr_sz &&
@@ -2956,7 +2960,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	int offset = 0;
 	struct packet_sock *po = pkt_sk(sk);
 	int vnet_hdr_sz = READ_ONCE(po->vnet_hdr_sz);
-	int hlen, tlen, linear;
+	int hard_header_len, hlen, tlen, linear;
 	int extra_len = 0;
 
 	/*
@@ -2996,14 +3000,16 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 			goto out_unlock;
 	}
 
-	if (sock->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
 	if (vnet_hdr_sz) {
 		err = packet_snd_vnet_parse(msg, &len, &vnet_hdr, vnet_hdr_sz);
 		if (err)
 			goto out_unlock;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
+	if (sock->type == SOCK_RAW)
+		reserve = hard_header_len;
+
 	if (unlikely(sock_flag(sk, SOCK_NOFCS))) {
 		if (!netif_supports_nofcs(dev)) {
 			err = -EPROTONOSUPPORT;
@@ -3018,10 +3024,11 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	err = -ENOBUFS;
-	hlen = LL_RESERVED_SPACE(dev);
+	hlen = ((hard_header_len + READ_ONCE(dev->needed_headroom)) &
+		~(HH_DATA_MOD - 1)) + HH_DATA_MOD;
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
-	linear = max(linear, min_t(int, len, dev->hard_header_len));
+	linear = max(linear, min_t(int, len, hard_header_len));
 	skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
 			       msg->msg_flags & MSG_DONTWAIT, &err);
 	if (skb == NULL)
@@ -3037,7 +3044,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	} else if (reserve) {
 		skb_reserve(skb, -reserve);
 		if (len < reserve + sizeof(struct ipv6hdr) &&
-		    dev->min_header_len != dev->hard_header_len)
+		    dev->min_header_len != hard_header_len)
 			skb_reset_network_header(skb);
 	}
 
-- 
2.50.1 (Apple Git-155)

