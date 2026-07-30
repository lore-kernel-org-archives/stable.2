Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5DD3C9EE8
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400221; cv=none; b=jj6CxY9Nal/GKM5utUKR2qGNOfi8vAHNUIFbxyt4GSqpsOAGdN1sVV89Q362cHVRYOFOUsBzXmmjr8es+ijxn2eg8BRS+IPIqJen9HA3Vj9SkPgRFGIBroMlaBXUe+SxfnG+MLeVn1NwOMvBI9W6GyePRrJyX4CXK5PK679gU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400221; c=relaxed/simple;
	bh=l7p9UcHDiSd7+m7lm/77lTGfiIA203P9noSrPEmlO3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZnqNPJlql7b/lDhvgSkxanGpqs5eEv01dIxUJtaIA1hjpbgKdaQbEMrmNW7sEWe+KdaK+JGJt200xrfl4haKLV6iWIcGCpYH66KRig7FFk5LnUKnj/e5lTi90BKzoLw/qer2ZBRtLeGLZw6H4hocuQ6VHyd3PgLoAkwsYsgHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGIA8v9z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGIA8v9z"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38ecc48b3deso136636a91.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400219; x=1786005019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FhwT5i7wSSCttQ3m6wlTBY5PMPdtDneVtB578ExkyTo=;
        b=PGIA8v9z/JZWlynjiLhzFAzA+44q6dPYrC5kTZHVayzwELC/LPYGdu7OWIjsY86cVQ
         nB7iC7GMC6RYQO6jpIdKtY/xgoCsr7oBvgFvJUV45lxmKJV1/RmSiOO++qcTC3DXbna4
         9JpwU0JmaeDOD31c0wAb1CmrbVhUEO+DGOZT0QdJpqTSeIxB/YvO5Mrqc0adPB5FiPxt
         1ptA+c1bqFE2xtAfQEEzB81ZfaOJFRJsbRu0LKcs2rjoD8NDv5NCdNNl14UoDDoVQ70Y
         VTn14AMB1AkIv2DpwAR+XA+K7qRziJU5v8WV+tpgXlIbn4t9Z6hH5f+w5BJd8iVFM8pE
         Z9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400219; x=1786005019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FhwT5i7wSSCttQ3m6wlTBY5PMPdtDneVtB578ExkyTo=;
        b=KTB3DIx7JW4wVLzh3+HcqAA6eh5wIM9T13QmZjjUsffn6pliEaAqT90YlrqszqYQVf
         JUZtmoU9E/96GuzCzXDo8WrpX46kLsvrfNfGfUUxUtZgfESpG1Lst9n5jupLYW4DRcit
         5rpoI5oloNTwiqbvxdHiw4KbRkbxL7JMzvSp0JQS7gNFaQz+s/sbQrO3kHUmyP/F2WTk
         9Bj67ANo9oMF4MIz1RfA3xGS6br2BwLXqhc5c4ipBldKVm+8qIosgsB9GTsfwrAs0g40
         0oNK/kh7+H7B+rXssAHSodTloAxSZqMqw4vNxibvjhbcEDG3i/DlM615yTViQ8IN5PRI
         YF7A==
X-Forwarded-Encrypted: i=1; AHgh+RqixSld/aP5NAhUYnRZTaFpGWxmTjHDc2Z/GcnZDwpuV6rDQwEc6Q3hhPq+zO1hUTp2QgVKnw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1TtwRHIZGqSeFjOVnbhqrtC41o874pXyEuGCDFX/wrXXCrhmY
	skUEye4sYecynRqI6+HT1Sl41Z62fwbheqNVhGyRaR7FQXeeQA+4gljF
X-Gm-Gg: AR+sD12Jy91YvAkTw7ppwSmtrKpDxbd47V0LY31FDft9NiTK38IcDC8jogA0Oox3MGR
	O28wVjNFtsOsNcULwZd5CTd363mAT5bBY7DnKbyJ2+lXLdogu/ab4Z8jW0SAKYiabQko/AyaE4a
	WluuBIGO9bJIbriJiJVe5It6CC8IadHMaosHkr+c5bZmwcM3Btfl/8OH18sSvtKpOAuCxQxnGH8
	8m8zpTtHcXzCFaRGY9wtXij1HypLQuS7bbBfc+EaCVpXgCbt2NSy/FzB3IvOiEqCodjKbgKqOIG
	BzmpZmkHpL+SEzMWD/MMlSm6aAuUrVt53OHRl5C8G0M3Ob/4mg67G49cnYMVe7bG/97eQ46DoIa
	dy0WXjeY2TUkFIs4OO3oWv4RSoJTTwmCRHfahpi/7ZEeg4q3XynxOHz3sQy10FurC7fIiMhGSgd
	+ootqlUIkytVbDxnBPDgTRY3zbAyW+H2Nu7q6rVkzArlyRqhqFQHDBCnUk4tfoYsaZAanekSwP7
	Y2AVoS+OePUwIq7MJy0xWDvgGDwiaTYDTHtSJcEC2MO5h3qHqc=
X-Received: by 2002:a17:90b:4d10:b0:37f:eda5:516f with SMTP id 98e67ed59e1d1-38f9bb0ccc8mr2200269a91.0.1785400219464;
        Thu, 30 Jul 2026 01:30:19 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b770e33sm664279a91.15.2026.07.30.01.30.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 01:30:18 -0700 (PDT)
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
Subject: [PATCH net v5 2/2] packet: use consistent hard_header_len in TX_RING send path
Date: Thu, 30 Jul 2026 16:29:25 +0800
Message-ID: <20260730082925.93759-3-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
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
construction. Pass the snapshot to tpacket_fill_skb().

The separate SOCK_DGRAM consistency problem between hard_header_len and
header_ops->create is not addressed here.

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
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
