Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886254C9DE2
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647751; cv=none; b=BdxRRiqTgmn1cz+8MpCNP/cxbIcWtO7rdNeDVbjr1FkXIrqE3FBWxphLws6LfQT8i9ujAuCEgcTthhrAhnbzyNn4d8okvJ46LUv2sz363LCY9YLU6+fXCTFncL3IjSnTvgKuFp66xpoe4QRma31pAZnQr5MJiDek2/m7GPoTvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647751; c=relaxed/simple;
	bh=XrJ0VeKnp+J1RFUwjeprMLnlrhf98H0KM5V+BZvYvcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3jaiegAshrehZqb7kKudmG8+60fdqlIjn3E8y5wcfbaT/l7619i+vaOn7u95gmIKxcXEGjiFR4NWvuKFMx6oOqf6QTGtXUgWGqxrCymwJbhM6TDekW0CnQRmQLNGLapTh5zxnt3c3SL7DVNdtO9FKE+VClAvier8ofE+hggJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbUY0w6w; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbUY0w6w"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso696947a91.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789647739; x=1790252539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQIiSsuwt9WvlQFUEqBDd4ifbvhEk0k5QLOiD415P9c=;
        b=BbUY0w6w8lWZmtbLK0m12G4RNbZyjLpikyFaif0uK0TLGA1camgXaQ+eLTmQPOWtnC
         Xvpk7k9PzEvMA1y8ROzPoOfMyj66unhzLSY+a8qhuafjXc0/tXo7Oa0kLNVehCkAhQHC
         eUHQamJEM8x11UgwMx8eQHznTo/9Xj/RMU9oRTCMWYiswcqdGizNzTGYAVJdgWiWdwgB
         rb4GwhB+7IapfC1EHXVgMvdKLW/nvVtu4X0ZNdLX3pr2IiFnQakRO1bDfAw24G9/4sGS
         c8aPGVZ1USTnL3fCBOKWvwzwb1LGmiCABOOGEdfm1LIOq/PC/zbTAHOIIe/NqqQmYqDT
         BYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647739; x=1790252539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vQIiSsuwt9WvlQFUEqBDd4ifbvhEk0k5QLOiD415P9c=;
        b=AfiNBrb1746feMPlE9aW6AO9uxdf17vbolLeoDnszxxdZndZ7HZ2/K4ELfO4/PW5zI
         pLevTK5m0pNFYBI5IyuynKnI8F1H39G90Uqo6tJf5bXTjfBowKlAD/URXLwHza9oMDv4
         lYitnVPvAT4rC94YVx7sJ68Py/jQBc6+BBkQxQGaG5AhuIXjqvwF9BC3sR7qbZHQ0yGs
         FOqgDgDqJbItTLEfTn2hm5XuRZBJCCF5SMf2aXOl6hB5CfQXc570x+GI/ZHQOZJmKrdE
         GOMBCEWnHlsGxy+9bnyA7Lor8k8yyjp8frQwkUaxOK+lz3HSCFeJI4H5g2YRB0tJ1RcQ
         M/jw==
X-Forwarded-Encrypted: i=1; AKwUvBxmxGhjX9MZu6aaiihQLRgREDaQuAqwAoharF3XEMvDBNbPQdslgx/3DN8HTr7DBEggzb5IJW0=@vger.kernel.org
X-Gm-Message-State: AFuF++k2ACUGL6GDgT2Z4c+VUADCt5n2UZbpZ8nziiGN6iF5xX68UDtX
	yfwZQ90MSxry/1EtBpOr8kyPCJAzRGai20Emc6UAWOR9BXF2jyRRUfmT
X-Gm-Gg: AYBFou1FlhOs4ZuDi2hOIcJsP5JW16dgs+s/pAu0h1Cox7DhNEkZWtBaprp/A56x9YP
	TpUjEBZgkXzztmoSA245nIxT4P2QX7H4JZ/mWZhqPzAdPP4Z2jTtkajZLI8f1zQF7QNC5eri5oD
	8TVHduzIVRfe7sYbmoII8J9LYp+L1pDLt3q6XVBBgwhM02L46eEITPocVutGLn4ASnwfPHiVBbR
	WC5NJj4HdOitm3qo47q8D4GMhDUpj0HmCEL2G9woBY/638slJil0Y4F4c4FPL3E2OGL1evv614w
	ZiCPBRaxZR/cQ8IshNxIj7JYmVWnpuN6vtsyLDbFAMAdps5NTmsbgmDYCF11K+BRvbKRrHJoShL
	ba5YhG9p90SWiwzxSdkGiuKL9+vmbmaPhbOg0PpMiYXGhuflKmeuxPL82ZdGIB0uibZBFo15Eph
	06KvgqREGdyAVI7zrfknM/Q1zPi//PdbHiMjkKKuSKaRbhHd8HpCkqOdCEZSq4yG9w0IvjzEpy/
	SIfPs/B4xiqWRmaI3qoRpWYm5QS
X-Received: by 2002:a17:90b:4a81:b0:39d:f773:37b5 with SMTP id 98e67ed59e1d1-39e1df6193cmr19859184a91.0.1789647739396;
        Thu, 17 Sep 2026 05:22:19 -0700 (PDT)
Received: from localhost.localdomain ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a175sm16360661eec.9.2026.09.17.05.22.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 05:22:18 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zjamg <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] net/sched: sch_cake: check negative transport offset in cake_overhead()
Date: Thu, 17 Sep 2026 20:21:53 +0800
Message-ID: <20260917122153.62722-3-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917122153.62722-1-ndaugoing@gmail.com>
References: <20260917122153.62722-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cake_overhead(), the header length up to the transport layer is
computed using logic borrowed from qdisc_pkt_len_segs_init():

	/* borrowed from qdisc_pkt_len_segs_init() */
	if (!skb->encapsulation)
		hdr_len = skb_transport_offset(skb);
	else
		hdr_len = skb_inner_transport_offset(skb);

Both skb_transport_offset() and skb_inner_transport_offset() return a
signed int, but hdr_len is declared as unsigned int.

If an encapsulated or stripped packet has a negative transport offset,
hdr_len is converted to a huge positive integer near UINT_MAX. When
passed to skb_header_pointer(skb, hdr_len, ...), the signed offset argument
in skb_header_pointer() becomes negative, which can lead to an
out-of-bounds pointer (skb->data + negative_offset) and an OOB read.

Fix this by declaring hdr_len as int and falling back to the standard
cake_calc_overhead() calculation if hdr_len is negative.

Fixes: a41851bea7bf ("net: account for encap headers in qdisc pkt len")
Cc: stable@vger.kernel.org
Signed-off-by: zjamg <ndaugoing@gmail.com>
---
 net/sched/sch_cake.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..ce9e85f9571e 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1413,10 +1413,11 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
 static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 {
 	const struct skb_shared_info *shinfo = skb_shinfo(skb);
-	unsigned int hdr_len, last_len = 0;
+	unsigned int last_len = 0;
 	u32 off = skb_network_offset(skb);
 	u16 segs = qdisc_pkt_segs(skb);
 	u32 len = qdisc_pkt_len(skb);
+	int hdr_len;
 
 	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
 
@@ -1429,6 +1430,9 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 	else
 		hdr_len = skb_inner_transport_offset(skb);
 
+	if (unlikely(hdr_len < 0))
+		return cake_calc_overhead(q, len, off);
+
 	/* + transport layer */
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |
 						SKB_GSO_TCPV6))) {
-- 
2.53.0

