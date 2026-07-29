Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB452377016
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294119; cv=none; b=usvq4l9Gn1nmnJMLsRaoQQuNt1JSnLRylKm09TRgXVL4Kn+sRMY21aUsg5a4IwNM9ZUSHgXFQ0+553G+Rd0f0PTRBhR1Nqy3rD56uil/VdTBRr0yjhk7zrXsEwsx4ap6v7HjIRjC79PYUGal3vyHktsg928F1xltT4C6S4ZBXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294119; c=relaxed/simple;
	bh=8pQmOMcFljWndvm8K6rOOGOJ+N7FFwl468qrnHJKbbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgH55ZbboFOY+eD68mZPIEXf8j7iNlKIIsg4dF7y1eU2uUFfkvT/p8A08PrizhO+Md/SKU9ESnhslw4vlZvZ+p/J/f6kczTi+SbfZlQAbfI1ESMixx/ASKVHEyewDd7gtgszl1t6jS+YHpeZfsYyZdTkKYQY+NaYgdK1lwfHvk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLMBnNJG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLMBnNJG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf420670bbso404015ad.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785294117; x=1785898917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NixGGEEqw+E2z4UzpPLkFQOamKXWaytt2d5AlloTFNI=;
        b=aLMBnNJGx72582/bcD+6zuK6BhMwujxBrA4sL5pj6b6fHSnwYrnIV1QMU8jdgRn81S
         ode6R4Z/vzTYqr+aIGqf8rWCg7CXH+uNCoslDr/BvcOZLWTEEyK+e7S78IsE4b5pErgl
         ThkiVVO1A7ZfBB3nKPvPFzAEFsWZydph0eQO8HEmZOugvEKOE5T1qOwiBXGANi1oUiX3
         VTzq15Bac7Fc4+BQ6O9Z8I2/LUAszSQ4c6IvDQHvYfEpRxkGsyC7yBFC+q9QN6AQTQ2A
         PmLiZo+d1JLzMa0ZCxOKGeSFppnGT9NEkRTTpS2VC82vlBj6dojdJebEOft17jGP9ytc
         ozYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294117; x=1785898917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NixGGEEqw+E2z4UzpPLkFQOamKXWaytt2d5AlloTFNI=;
        b=exYfqP/sHwohceiz5JsrOKUE+HurxBUjMccJ2SHvRLMbRNKVYb9/EzT/JNQcUI7L3n
         L2C7e1FEx1ozDMqB/Hl49FtM8Th/QnWYuJuGambdbNae89NNHMOkimEyGxUk3Jra+dAM
         gcm3nYtREbs6cRg1BDzVCEGb0KdTyC4G74QP7OXmxnAL0U5mIwfAwPM016zm107Kh49p
         2g2nTq86es8UcCqLwjaHdgQDb+cqzAUxN4OGdbTRYepRM/6/QO4ouyUkgx3Sag0hBVTz
         /jUwC3IGprm89BMm8xALQji/EEHq2WTdy9Kc55M4cgDbdepghBOHKdFDPNSXuqI75+eW
         NObA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9qZOh73ynzZG9L/HxjhmsJgBkttHI1oMsD7b72+gy1cVHUYjOQKzlAchd135V+hAggquBdtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tzomGl4Oe9ech3OITM1LAI5mahSenL0KQZLWiIu9DQnws+40
	zciK8Dt/6FTncjHK/MunSVA2HxXDrR0RHsbw9FTAR1x/q3LLK7Zijc0q
X-Gm-Gg: AR+sD129ZkeoGE3xkw3zyWyRvHBT0i07Cfekh1wGUqct2ttimYW1VnScCZKKaObGLzm
	sYPGJxhHQ9BkCveOdko8AC6kTOt2A/sMy6LVhhfSeq8UOHkru4TiUppLR9pEJRPGiq6YfevFIO7
	X6cafPlug74IC10E0Ps+HLfxaNo24dzW5nVzCb8MzYbYF7dq1fwX7HypvcWl8kvnLysS3w/a5ee
	XS7F7STw6npglKmE6y/ct+C5R+A29HxlCg2Vu8JbWXTjilhDAt6sDVAWJkYujycjF0e0VX4+GBv
	XP80ngFXyYlf/X4gNHuNlY/3hZToNynW5HIF7kA+V4k9Xrbiv1FJ7ghPRY+rfj5y3Wev9l3cy0f
	efQ4syqAgB9n+N5BtW/u9YcKg8u3CHWdN1HhwZyjhyL/IlE5xu8Qjwypkxtb0uV8mYqAaUyaB7m
	Tc5/R1WjCVCijw2WEomb9bEngLhFBqJntih1Hdrq2d2NCtslohzcjkGwNrVJLOx0pc/RVuZ550T
	gEXb7f1c7vR44wZXiwtCJc329P2YMDOMTWRbVWGLxwGq/ZI+Eo=
X-Received: by 2002:a17:903:1904:b0:2ca:6885:8a06 with SMTP id d9443c01a7336-2d015d3a94emr44001065ad.5.1785294117180;
        Tue, 28 Jul 2026 20:01:57 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c3721esm4097385ad.77.2026.07.28.20.01.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:01:56 -0700 (PDT)
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
Subject: [PATCH net v4 2/2] packet: use consistent hard_header_len in TX_RING send path
Date: Wed, 29 Jul 2026 11:01:22 +0800
Message-ID: <20260729030122.21462-3-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729030122.21462-1-q.h.hack.winter@gmail.com>
References: <20260729030122.21462-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpacket_snd() reads dev->hard_header_len independently for skb
allocation and header construction in tpacket_fill_skb(). Concurrent
netdevice reconfiguration can therefore make the reserved headroom
smaller than the amount later pushed, or make copylen - hard_header_len
negative.

Snapshot hard_header_len once before processing ring frames and use it
for the frame limit, headroom allocation, copy length, and skb
construction. Pass the snapshot to tpacket_fill_skb(). Reset copylen for
each frame so a previous frame cannot retain a larger construction
length.

The separate SOCK_DGRAM consistency problem between hard_header_len and
header_ops->create is not addressed here.

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/packet/af_packet.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 88674a6e868c..8ee0a80fdcea 100644
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
 
@@ -2822,8 +2824,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
+		copylen = 0;
 		if (vnet_hdr_sz) {
 			data += vnet_hdr_sz;
 			tp_len -= vnet_hdr_sz;
@@ -2840,10 +2843,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
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
@@ -2853,7 +2856,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
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

