Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0063AD501
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835951; cv=none; b=CW94RCtbRbA/+yjs56ZudONUei8huavlfEVDBytVwEiacLSUzbgzUiJtHNic2Rbq7eWXxeJsg2B/Kh5ygAQBwuBhkfsmwAZ6dTUDjWnT3jkKZDQWfGo6u4GFQxhcax9oMite2Ijvsc2jzkVrajaywAZxUBYpx2pLtJDFecZ7u9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835951; c=relaxed/simple;
	bh=B9hksGm9ntRRj9QAGHsjEV4YR/Q7/10o0v3GbCpC97g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVoQ37TKg96IafJ0A/G0dh/CJTM0RCyxb4gbliUqnPp4Gbn336X21GaDg2SK/ICWm8HSgsxdRVaMEcSNMpsrVZCyA29i2WAwHBCXaoGt7GyXTs6PowkXef1R0risBL/EvdkZcOXgWahh+s0UVFswQV/6kBFO9cn2TiiqHHVi5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foX1r/kg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foX1r/kg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d01548ac96so5223835ad.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785835950; x=1786440750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/CQIRskVYtbOfiKczfu0y6F86/TMtPEfVhmtJ7xiMZw=;
        b=foX1r/kg8eYUxeKPru1VC6xZ8R9LGW4O6/BW8Jwu3542HU6bQrUhoRU0LlgGH64Mnj
         KYva5wpjCdMv0HNLltb3Fz33NNUotFZFL4noc7kYiJFq2+chP4Yk10vaRRNjWGJIhso7
         mMYWwBDnaE187QeRPr9o27Pfk4SQV3Ei4X6vYy9lg3iswn8l1v4DwEHK72I7Iqh7pZ0b
         m0BbkYleiqOv6suehuf4WPacCfIx4K15oo5TZear9FML7Z8ebAlzL9DyufiSRqinxOgY
         AQg9QxnFp/p4AOCx0DNxuuyB6uhMHCmGUV96QlG621fIBQqWuB+zujHhB5Ls1I8T5qP8
         cmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785835950; x=1786440750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/CQIRskVYtbOfiKczfu0y6F86/TMtPEfVhmtJ7xiMZw=;
        b=bsPlb6zJZ43lHUzOoyb6HPuwj7NoGmhoSVS+ymlDbFbgEb+9A5L8Ik+i3BhpMdYYNV
         7wyPyiaT2vezf76PFtGPrSvwxFaOAgZB4wMIzlokJOrU3NBYUl1RN2NjxU1TbitDob6C
         54Yo4W1cj6Y5A/t+9iiqDD2NjEZ3ZQ7SfHaId7IQWOtRyxG+SMGd52C4yEiR5ekd4pAd
         DqWZl2mfCcMvWizSfbeiB2FJh2DCndgkK4EFLW1x1u7Jiq133/FCgi+HXH3W3vodXvxg
         dgG7pM0rKBoTQNzTCe57tO21Zdu/fciK0A1RHepJTkBNhJyW8RTf5wKHrQaQTfATG8QR
         qW8w==
X-Forwarded-Encrypted: i=1; AHgh+Rptn8SIKJ2QPZ0dWTDMNpeMhpDrm0XHWDMi4NVLsGDbJYT3mu5ppksn30WFn2+AwiO3j8IeFp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnH6co4jknpJPwAsMVO4lqlKud0REhE9bEJjZZxfTmhpasHE1+
	3BRCV1CE3mAfr/2tNGMHW4/olhJQik8wwhQs28j9S8MMiZfmuY7zUI6m
X-Gm-Gg: AR+sD11AxeHIClMQLElnN/7p0rzBFzNViRLfit7yXDr6GIVD97ZjB+BICqPeF09TYvc
	oO0wkBzf9afGGOAQmJMVcpIhvqT8ee1yM6eS9Lm2Zo9ntzoZx3kLqClWsAmyPd3cLMYxkhkoNuX
	+opi5QPfw0Mr5ORtLQ9emxnKAfz4wyKd9XQcR3SgM7yWXeBaQWsp1rjsOYrfVHStOem/uvltZas
	7Ajx0cBSrtCh2+uRKBKhGYtu+JOYAf5rAfGtJaTUbUcle+vxgBjduDLo7ui0w/ByAW0fOOSNpgH
	XhjQF7ZuPVym8rych5YSpiQRvZwgSoGm36dac2q/dgePqw1CvPr3QsW9IjjDmSd3nAdZAb6RvPA
	lk92vVoyg7UXkWmwSsYEYiyYFsKbtKHcOHQ+cTfPzWL2e4IpTtTKDPpwZpaV9dQqdfaXlsGxpxH
	4jVC6eRd/qjm2A9kk5SgbdAko5YHFE8tZxGyDbkeUU35SzE3blDn1d3Um2e9SGD5R+UrnlwiV/n
	+T934MpSoMq4f9Oh3OesqxqYa90WP9Duh7nAVtPakanNOXkgK4=
X-Received: by 2002:a17:903:1aa3:b0:2cf:ca85:57e2 with SMTP id d9443c01a7336-2d05219bb79mr183170125ad.1.1785835949479;
        Tue, 04 Aug 2026 02:32:29 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa49325bsm3478945ad.40.2026.08.04.02.32.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:32:29 -0700 (PDT)
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
Subject: [PATCH net v6 2/3] packet: use consistent hard_header_len in non-ring send paths
Date: Tue,  4 Aug 2026 17:32:18 +0800
Message-ID: <20260804093218.33952-1-q.h.hack.winter@gmail.com>
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

packet_snd() reads dev->hard_header_len multiple times while allocating
and constructing an skb. Device reconfiguration can change this value
concurrently, for example through bonding device type changes.

For SOCK_RAW, packet_snd() can save a larger value in reserve and later
allocate headroom using a smaller value. Moving skb->data back by reserve
then places it before skb->head, and the following copy from userspace can
attempt an out-of-bounds write.

packet_sendmsg_spkt() has the same issue because it calculates its
reservation and header offset from separate reads before dropping the RCU
read lock to allocate the skb.

Add LL_RESERVED_SPACE_EX() for callers that already saved a header length.
Read hard_header_len once in packet_snd() and use it for allocation and
construction. In packet_sendmsg_spkt(), preserve the allocation-time value
through the device lookup retry.

The separate SOCK_DGRAM consistency problem between hard_header_len and
header_ops->create is not addressed here.

Fixes: b84bbaf7a6c8 ("packet: in packet_snd start writing at link layer allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/netdevice.h |  6 ++++--
 net/packet/af_packet.c    | 26 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9a770eb823ce..8840b126979f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -300,9 +300,11 @@ struct hh_cache {
  * We could use other alignment values, but we must maintain the
  * relationship HH alignment <= LL alignment.
  */
-#define LL_RESERVED_SPACE(dev) \
-	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom)) \
+#define LL_RESERVED_SPACE_EX(dev, hlen) \
+	((((hlen) + READ_ONCE((dev)->needed_headroom)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
+#define LL_RESERVED_SPACE(dev) \
+	LL_RESERVED_SPACE_EX(dev, (dev)->hard_header_len)
 #define LL_RESERVED_SPACE_EXTRA(dev,extra) \
 	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom) + (extra)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e75d2932475a..88674a6e868c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1953,8 +1953,9 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	struct net_device *dev;
 	struct sockcm_cookie sockc;
 	__be16 proto = 0;
-	int err;
+	int hard_header_len;
 	int extra_len = 0;
+	int err;
 
 	/*
 	 *	Get and verify the address.
@@ -1997,14 +1998,18 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		extra_len = 4; /* We're doing our own CRC */
 	}
 
+	/* Keep the allocation-time header length across retry. */
+	if (!skb)
+		hard_header_len = READ_ONCE(dev->hard_header_len);
+
 	err = -EMSGSIZE;
-	if (len > dev->mtu + dev->hard_header_len + VLAN_HLEN + extra_len)
+	if (len > dev->mtu + hard_header_len + VLAN_HLEN + extra_len)
 		goto out_unlock;
 
 	if (!skb) {
-		size_t reserved = LL_RESERVED_SPACE(dev);
+		size_t reserved = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		int tlen = dev->needed_tailroom;
-		unsigned int hhlen = dev->header_ops ? dev->hard_header_len : 0;
+		unsigned int hhlen = dev->header_ops ? hard_header_len : 0;
 
 		rcu_read_unlock();
 		skb = sock_wmalloc(sk, len + reserved + tlen, 0, GFP_KERNEL);
@@ -2034,7 +2039,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	if (len > (dev->mtu + dev->hard_header_len + extra_len) &&
+	if (len > (dev->mtu + hard_header_len + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
 		err = -EMSGSIZE;
 		goto out_unlock;
@@ -2956,7 +2961,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	int offset = 0;
 	struct packet_sock *po = pkt_sk(sk);
 	int vnet_hdr_sz = READ_ONCE(po->vnet_hdr_sz);
-	int hlen, tlen, linear;
+	int hard_header_len, hlen, tlen, linear;
 	int extra_len = 0;
 
 	/*
@@ -2996,8 +3001,9 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 			goto out_unlock;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (sock->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	if (vnet_hdr_sz) {
 		err = packet_snd_vnet_parse(msg, &len, &vnet_hdr, vnet_hdr_sz);
 		if (err)
@@ -3018,10 +3024,10 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	err = -ENOBUFS;
-	hlen = LL_RESERVED_SPACE(dev);
+	hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
-	linear = max(linear, min_t(int, len, dev->hard_header_len));
+	linear = max(linear, min_t(int, len, hard_header_len));
 	skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
 			       msg->msg_flags & MSG_DONTWAIT, &err);
 	if (skb == NULL)
@@ -3037,7 +3043,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	} else if (reserve) {
 		skb_reserve(skb, -reserve);
 		if (len < reserve + sizeof(struct ipv6hdr) &&
-		    dev->min_header_len != dev->hard_header_len)
+		    dev->min_header_len != hard_header_len)
 			skb_reset_network_header(skb);
 	}
 
-- 
2.50.1 (Apple Git-155)

