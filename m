Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE7378D76
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294109; cv=none; b=PPWf20XT9oEchiCKVmq92OiFpuXT1ukU5U7xhrVOLPU2poozHp3BJjfK+KIUT85gzT+d7UbMrKUEJXZiTmWyVir1yBxTENeDhSGsuyP2YNjjUAqHV77AYZL1FtLbRm2TQRfBZZTcU0jI212+gOVGIhNPtHHLlkYhS/2eoZh3Ess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294109; c=relaxed/simple;
	bh=2+lD755z7Rh4q3JmyL4x3OHtwEBfh1KbS7Y4miJd/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOPJhCpTTMqo1SrC1cB+3IRwRQRhpKYSPSzUDxvkSszwkKAarFBuDlyHvK75uh2BAIJgq9tAIv0+bIiBoSnVfO1nnscscC27CVskSpJgfwf2q2NTUG1XiCK1GbwhCccVWh8sSq1P//igCasrMxn6ykaLouBBbsU8W6afjImW6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sU2TVmBg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sU2TVmBg"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf4c37dbe6so74215ad.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785294107; x=1785898907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xg7bd++vUDfsPPAlCp93j183GeX7bX18Uk0d449Ghw8=;
        b=sU2TVmBg6j7Jj9H8t/dy5mhSXKwnfbV1MAWQ8eXmtKas4EFPP7iUdag1TlCKHmYU/x
         Z6grkbDn8Igx0bvjcDsgWzXrIXYKqjTStV5f2G+j+cQpS4ttfhm1wSVoytvM0guiwVcT
         C4f6AB2k780ysdsZInOnD//e/XIv1jNML9UfaCJ/1mUMxxKSO/G4PygmQnq1coTWwDPs
         PFb8Rj6L65iC2lFm5Rt94wsKitho+3YY8HzaHR076cSCySDQ1wMSLpTWP54+21x6sxfP
         smu6Tp/1ffP3VoVmgUggra3RRltOfXGrAJ4KErnPNTMMWVvNEwYlN8FIfg4+QUaj5Hp4
         L/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294107; x=1785898907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xg7bd++vUDfsPPAlCp93j183GeX7bX18Uk0d449Ghw8=;
        b=rT8zt2U2OyvwWPjGOnR0GAX5aNbYYX/7JjH5BDS83lNhoCMTwsTeuXP7yLj5n/N8FW
         AAeB2DkudFwYKLYA0Iv51nx4hiGZStKoau0sx5Tidig2F2TkXvU22q58WdvDyOovx5mr
         OhA+e+oaRVOOcON0bDhJllsRzyJGasDlQRmnrHG7IaqcLmhAlePbGHoDhuBDpkKDeECo
         T0iFmxSLJXzw+39OKFIlKstmADm8rF6XijW07TVdTPki5tpcx1hK6yW8JFz7Qvm60Tf1
         FHy9WDBDEioMjTYij0toJZGpVVzG6Zl1MVA75NyieREGr2MIkwhioT/FepPUAnJFA55H
         5BhQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro02pc46gjkMU8OZ3B93LlioamaPRcSN8507RifgLvh5ZwPmSylZHjrczBuj3J0TTZzuszuRgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNwtQgklgPeTZju0nxz2sxzRgrMmO3StaVhtdvNjoPs5ccxhBw
	V/r+6r7Gdx/PaEczzOYOlHBYkICiXHzlrCc6Q7NwFLFdw6Zy8GVDruYW
X-Gm-Gg: AR+sD13XUPt6SD1mzloimusAjd4N4g2FtJ5jvHrYGmPP0/GroU6w6a07XymWP/Bq/9j
	fRT47hvElbk+PQS2RY12KgYioQeVUBrqmFPW+XeMjlA4kqwvWK9iklYnf+H2FhII4d5lG3FzN2Q
	VtWfhWSyUwf0nZuuYQhflwcayp+tltTsBJ988YtSDxf+Nh3dtiNv9KB98rO+cfz0uZJjwEJkDLs
	WOAWQ6vY/08PQCfFuWaHSeEsC8L4si26i2//g9Jg8g7Vjgklpu/0viN3Rs3RnUYKPUEZ8LYzKNR
	SakP2DAnCtpDZ6KvSp1QqFrWZ844m5kgumrUvP2vXh0DQhM5wEIcswdBV+DLGq7aWnvvzF9f1IF
	gd16DQDRDJEi5lkUlvaX9mX03NsUTiGUcA2pcmuoOS5T2NTBPNBAh6osPclzR8RAe49wR9MImTh
	VHrqdejyNWx+t/C1Ez3/lfV8Jpt3t6AmryHmAmoEtONtapD3QK5xrDEgsdJNNJh2KT0NnAbDndU
	duIRiD0vI4TWX7i64MB1Pq7H+MDhhfJ8c6MBzfTiVleMciUoqI=
X-Received: by 2002:a17:903:2f07:b0:2cc:d6de:d58e with SMTP id d9443c01a7336-2d015c2fa1bmr45187925ad.4.1785294106897;
        Tue, 28 Jul 2026 20:01:46 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c3721esm4097385ad.77.2026.07.28.20.01.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:01:46 -0700 (PDT)
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
	Qihang <q.h.hack.winter@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v4 1/2] packet: use consistent hard_header_len in non-ring send paths
Date: Wed, 29 Jul 2026 11:01:21 +0800
Message-ID: <20260729030122.21462-2-q.h.hack.winter@gmail.com>
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
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/netdevice.h |  6 ++++--
 net/packet/af_packet.c    | 26 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..e50e8abc1392 100644
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

