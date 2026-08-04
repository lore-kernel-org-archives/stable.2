Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4123C503
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835993; cv=none; b=Oo8218WEyCtnSmo4RYdlUtnZlk9Bd8zZXNHOzE4Iq75Krg/WE2tfU76FhZW52fSz+PQjp/yOPjqF5KSiGI2lGUIVbj6haef5/KR0l2GNiLa39zGIWqcclXI/weZNBPoW8mC6BpVbJmTaF0qfZ1ybHgaUnh2p35KsB/tg05DRcKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835993; c=relaxed/simple;
	bh=2c3j+x1oQYyMuC6YkSoOlfgH9+YHkAE/oawSeizlMoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2I3etMqHm/enG1aDv21TWgOBBd/S7caUBVAtiQiZWV6yf+D+5FA2/n90/DE/dZs0+NWv+Hahu6SyCkMXO5a1sQbddkpBTh1dqc7W/LLZOS9PjGcxv03FM8rNAPpylKev7bzM4s5vT8kaKfxrpV/J79ilICDr0C9aNVBacm2kG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNd0WWVD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNd0WWVD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cad68425a7so4784165ad.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785835991; x=1786440791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJek6yMdu453eh5vhUQNuwpWpa+Mp383syuPawBLsMg=;
        b=DNd0WWVDOyy9O+FC9u9GJ35Tz+7+tBzaoeDtaX4gn/D9koMZFRA75DQu0zE/AGwk+Y
         mEBKjoKWmXjn5Y4s4SlHgRWlP/NGwPGGfg01rgN+yoaZhG1QWqJC5xeeMH0v0kVnZ5yu
         1GHmxruifYZDFayDjOAYwTqLivYGjwoDhig2m9Rgth0hpkRyB8f/S1NLKFHJH2dZ8k4H
         3530AgtnfL6LUanOSc7xRFVDvoGpBm9JFDnuQgDFFEMZJlWt9NJOEGKMlDPScMuWcNmm
         B593Uz7o7CPwgAbZpgdwSXtyIF5YvNakNdRrU6OziPN2Ces7WmA5ISAsSPEq3Hc0LjhX
         HTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785835991; x=1786440791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJek6yMdu453eh5vhUQNuwpWpa+Mp383syuPawBLsMg=;
        b=el7TkiG8/qDr4eb4idS1/48E5iRudqXyWhKJ+4LJcKmWfmOssYAN6qIcN7DJfSwzfK
         Qfj2nJhIi4HssABRJjF4/sqyFgLTs8ipwVBh63C/RhW27nJFZ+qZlLUjm2MQSrPuVu3q
         NwRO7GS2YeTzgDovx7AqpROdQqNlGMCH6Jy5m05Ug9pQ9zMITnBsYxzY0EOrQYevjzpV
         NAln79EKsM/GwOUzxwZsvC1DXrEFcLh2NLssdbllkTWg7qI9QWxWyDuuwDgdQXy/B9/k
         RcnzIKx12XvuQviqJ7eELgRO3q9EBxLga+Wiq5vXZW7QzsYG/z+eZws3e5V5X2BtHKS8
         daBA==
X-Forwarded-Encrypted: i=1; AHgh+RqlZjcj/JauDbj11ej7mwYarc2iyDtfHTeOB113X0HifbgnsvNAF7TzpboEY2ZV56I7FI3Ab/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8wcGEUKadIZShIsgkXqwpqwiEJuh+57Euk7RgBIHffXUSYO8
	/kbLSVJwMU79U2Ihjnt/968qhMLuQixf8byxhiOhGwZQKegO2/Ezglq9
X-Gm-Gg: AR+sD10jJnZ2yQB10Z2lL0QtWy4YN7Az1vHoUkgfSanwJ+vZHOqibgnHIcNw189P53K
	/vcO5xfHAEmwzKyySIVAdh0ZYyY3D++hOby52O+JV9remuGSXekv68Q4bLrVLaLr6ozhQ8w9APG
	abn8AHUa19zYOL9+i3A2uinV/986id3YefAEnLtWOIUfxSTNHbTESGDY4zbicUMiiWKL07DPiem
	5oVWlxn1zaKUdnjU9C02BSyc1XzT+F09khMC/C03yOwZNw04Xn5TMAuH4sJVwy6LXaLOMDCQWBZ
	S9/1LPUSApRg6EZBRZzZ2SZ2TJOYUkJkc9mU6CqSpfKxY8gHVYK763T6bWcmyH/mb3MThAMHvSs
	aN4XPT6HcLc5RghUtCULAJBEGxMcVYtaMxo/kRcKNfa2EKyPh7brweXXPlH9Ffonn/AqTReoZXm
	CILYZVztpV+39xQRsxa4zfXm6cE2XLyw+2gp0jTAkg9DJwzACO0/VK5p62za8GICjWYCqL9E0Ym
	JsMPTrzxqsKxvsEvowUe9BsM01Dy7niJ+dw0v7HUvHGl2bGiYI=
X-Received: by 2002:a17:903:1450:b0:2c9:d298:6c0a with SMTP id d9443c01a7336-2d05246fbb8mr198442035ad.2.1785835991198;
        Tue, 04 Aug 2026 02:33:11 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9fd5f7fsm3731525ad.19.2026.08.04.02.33.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:33:10 -0700 (PDT)
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
Date: Tue,  4 Aug 2026 17:33:02 +0800
Message-ID: <20260804093302.33990-1-q.h.hack.winter@gmail.com>
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

