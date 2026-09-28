Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207B4BFE8E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601918; cv=none; b=OUgi2j+6vYoH1bc6/qcc5iGXW0//rU3sm3CRCjPczUTDprD6efCbgi6lFM/KfkfYn/8FydBx0Ka6BnVZA/N+o0fpgvhu64vecInNoxVL/yq1V3WJh7RqFmrlDeT2KDURzS1eFP1GktbLkj1TDdwSRf+4yDI8s7G1v9pHsYnEQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601918; c=relaxed/simple;
	bh=omWUq2ylgri5HVuCo9P7BsNPWyA3Qdamo17UVw6wFGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3I7/eLpUsF4FhfXIxeVwRdVfr9hYoUaYX7B8Ac5zCgcCft2TiOK1R0wqMe+ruwtrrhJK0Glqk/sR4P46V3rai9C09ITJ8WLdMJy6bFGHk43Q/GaD9pG92UuwfsZquEaKm6io/swmSHnqR3TuPegNWuqTkZZaeKTXJ6vpFMkPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfAYq3xS; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfAYq3xS"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-8659af7454eso32747037b3.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790601915; x=1791206715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J+r/qb76YDeMxdfipeBCvFr6YaXG+gMr49LHmpmmJnA=;
        b=WfAYq3xSFi7kZ/2GXBjCbmZHxxCTKcuQX3tGUKuRSI+MiYulCzyQofksi4eyy4yG94
         mONbf4d7xsxWhnJRCoBz2hBrIeyI/mqvga15DCh0fRK06BvDVnvG70ku0A/9puUlQ482
         PMLN8gx+X8QctwVMQV04LDgRUdonb1xFo5mM9HlyPK2LcwLjT50MbdsIB8e91l845lr6
         +bWdu5BgeumSM4QrosYIup/dBcACpwgFrDv5/7NPJ31OMU9k0pvmEOfj4jMmrSP1wjx1
         3EDqRR3y6QEfO3BskSlMMXAXBOB/SYMBzO16azi34QJJUY0lNkhKjfKG9qWdMPmIlGMp
         gjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601915; x=1791206715;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+r/qb76YDeMxdfipeBCvFr6YaXG+gMr49LHmpmmJnA=;
        b=Mc9S0krVwU6svaUJBJMN+CyttV9OlczKXCYKXqNrNn3BGf71pajrN+kEzoxv2MkKkv
         wrPcjP6wBJPRRDRyXoldeQRHKjoXT3TyB35rGIOs6NQT+kEVmRM/KLXOGt93JyHwiNrw
         1UyIWxFLWuLB8zGUkLeLQFoysFrhseW4YKg+z0nVMpgUe3WIO2zqBQTJXHeDE91XqmKt
         6PxBXjpfvCQd+AKAwODHCn0Qnslnabqa/BgJFqaw/DU2R+sRoR+ZtB7Uo8D89zABXZCo
         ZanLMujU2dAXdG2bZjiVC+XIg6Mg5pTFESBAGq0AJ50sUTjxpkuwSWHysFaBW+jxyeQL
         hE4g==
X-Forwarded-Encrypted: i=1; AKwUvByaVK315yjsBzhvNuN+pekL1CSDw7jyDdqFDRfaIIueCNQPHGcIjoNqAsqljiLhr2fMzsrymjU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwZLf8kyiWk+DAoKqZZXfGG4LtYqFYRKH9Ms0RHZPu7xa8b+L3
	WH8hYcjspZYUYJWqibEIhCK8bNjb06Nw6ODMwlaZr+tuziPRPrGtjlfj
X-Gm-Gg: AYBFou3hOhwkctPSzwlJmMSX0NgilP3sblfO8MD3i+DclOHB5FJ2tSxGh3CaFeFCu1t
	bGcRcKQgEiX+nUr+Fybw2veOwVsf/N4RO5XdLRd7vHNRTuJgEtWK1ukv4xxIBq2bc5wgpbrJD3T
	guaUW1h7ThnYXPYkw7zb0RtKY+uRdJuNP/91zelkBGP0UaxIGM5LQjVFLJwAriVpI1/mJqskSO1
	0IpmDoCpczMgSFih9tYQUVewXVgDGLNZRKUQgWI/KJvVVFCt9HuuejlTlGqErsgqoEdsQS9AlUB
	t0iyKkRVc+2iHxDZqs2N285N+Ax8M2PNftYiexFA3HHkM/sE7SUqpMCZbg2eBAv6yEAKMBTGfez
	4PHjVdcYavi48btsbb7MwdWlqQifGg+nZ0mxNI/EekicvqWPCYjUPeZJGs6pJCxJwXLojujv9zT
	IwbZKAxdkfkTQcXddCFOXXh7sKzFGqcE7YGTJV4P627e9AmbpMgHevKaOs/MX5215YMcxfCRhjN
	BNkcOcoq+mEmFw6YCu5uBAi7h5RRTT9e0a+NY7RZSg10sY79A==
X-Received: by 2002:a05:690c:348a:b0:8a8:722a:9a25 with SMTP id 00721157ae682-8a8722aa639mr37186547b3.63.1790601915083;
        Mon, 28 Sep 2026 06:25:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:94d6:8f64:6f66:fcd2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab391acfb0sm298087b3.48.2026.09.28.06.25.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 06:25:14 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH net v4 2/2] net/sched: sch_cake: validate transport header offset in cake_overhead()
Date: Mon, 28 Sep 2026 21:24:52 +0800
Message-ID: <20260928132452.59996-3-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260928132452.59996-1-ndaugoing@gmail.com>
References: <20260928132452.59996-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In cake_overhead(), the header length up to the transport layer is
computed using logic borrowed from qdisc_pkt_len_segs_init():

	/* borrowed from qdisc_pkt_len_segs_init() */
	if (!skb->encapsulation)
		hdr_len = skb_transport_offset(skb);
	else
		hdr_len = skb_inner_transport_offset(skb);

However, cake_overhead() does not validate the computed offset:

1. When the transport header was never set, skb->transport_header holds
   the sentinel value ~0U. skb_transport_offset() returns ~65535.
   skb_header_pointer() subsequently fails, leaving hdr_len as ~65535,
   charging ~66 KB per segment to the shaper.
   Mirror qdisc_pkt_len_segs_init() by bailing out when
   unlikely(!skb_transport_header_was_set(skb)).

2. While qdisc_pkt_len_segs_init() runs at the start of __dev_queue_xmit(),
   packet headers may be adjusted before cake_overhead() is reached:
   - in sch_handle_egress() via tc/BPF egress filters;
   - inside cake_enqueue() via cake_classify() -> tcf_classify() (e.g.
     act_bpf, act_pedit, act_mpls, act_vlan).
   For example, bpf_skb_adjust_room(..., BPF_ADJ_ROOM_MAC) invokes
   bpf_skb_net_hdr_pop(), which pulls skb->data forward and re-syncs
   transport_header only when it aliased network_header, i.e. when no
   transport header had been parsed. If a transport header had been
   parsed, its offset is left where it was while skb->data moves forward,
   so skb_transport_offset() becomes old_offset - len and can turn
   negative. Since hdr_len was declared as unsigned int, a negative offset
   wraps around to near UINT_MAX, corrupting header length accounting.

Declare hdr_len as int and fall back to cake_calc_overhead(q, len, off) if
unlikely(hdr_len < 0). Consolidate all early fallback paths into a single
'err' label at the end of the function.

Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the rate shaper")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
v4:
 - Consolidate the 3 duplicate calls to cake_calc_overhead() into a single
   'err' label at the end of the function, turning early returns into
   'goto err' statements per Toke Høiland-Jørgensen review.
 - Link to v3: https://lore.kernel.org/netdev/20260927131009.24250-1-ndaugoing@gmail.com/

v3:
 - Split from v2 into a standalone patch with its own Fixes: tag
   (a729b7f0bd5b) per Simon Horman and Sashiko review.
 - Clarify header mangling ordering (sch_handle_egress() and cake_classify()
   before cake_overhead()) rather than inaccurate "post-enqueue mangling"
   wording per Sashiko review.
 - Link to v2: https://lore.kernel.org/netdev/20260922084124.36858-1-ndaugoing@gmail.com/
 - Link to v1: https://lore.kernel.org/netdev/20260917122153.62722-1-ndaugoing@gmail.com/
 net/sched/sch_cake.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index b0d604a7052a..f8deb8083f16 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1413,21 +1413,28 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
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
 
 	if (segs <= 1)
-		return cake_calc_overhead(q, len, off);
+		goto err;
 
 	/* borrowed from qdisc_pkt_len_segs_init() */
-	if (!skb->encapsulation)
+	if (!skb->encapsulation) {
+		if (unlikely(!skb_transport_header_was_set(skb)))
+			goto err;
 		hdr_len = skb_transport_offset(skb);
-	else
+	} else {
 		hdr_len = skb_inner_transport_offset(skb);
+	}
+
+	if (unlikely(hdr_len < 0))
+		goto err;
 
 	/* + transport layer */
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |
@@ -1452,6 +1459,9 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 
 	return (cake_calc_overhead(q, len, off) * (segs - 1) +
 		cake_calc_overhead(q, last_len, off));
+
+err:
+	return cake_calc_overhead(q, len, off);
 }
 
 static void cake_heap_swap(struct cake_sched_data *q, u16 i, u16 j)
-- 
2.53.0

