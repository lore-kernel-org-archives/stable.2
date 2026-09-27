Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954E3F1055
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790514648; cv=none; b=DrKiM0DLaT+Ayw34R37G3poQwzrgXFt/pYPclSO9tYRg+L7K7YXwZqUujMxAiRqip+FwFwISV/rU1wPo/r3GGeVvuTMIem7RiBQ1WOsgeFM81WQoDjWoIEt8QUJ3HKdwqlBQTorFbv20XHEnCgXDAQZXzJdvSfTXFZRlfHR9Fpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790514648; c=relaxed/simple;
	bh=GMVGcW/z1YmLoydR+yKyE5mO/6ycsecZsCwbxXRcr1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swJsNol/fDQ66GOjdDL99WjsmMqxUxFy78Ana0YaEqM0HIZLmPqQMwLAVCHGD2IMMSRp4wfB4yV+DaDRAf0IOOIPrapfF3gdM/faaUeLqcMMAsZXyBoN9wyGjbqe9lM7Ld8RoziAvr662Z/voQido+j0zmnTYJQ/eo9FyymZmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ol+PuzBe; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ol+PuzBe"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bd71827eso1170097a91.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790514645; x=1791119445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VLUxpe6alY7Jo7e+VhiSQ88rPLMcwFQfsWyKXgdfUU=;
        b=ol+PuzBeLKFtByfH0+NlU+RKQCdZohoXeHb0P5K3TAAwaPaIUot1l1awhqnfTqZuco
         WIrJ7dDeis0yapAWA1dNyJJme+mAi22hty3Gm4f4XuxdHHjN7zy67d7L2yicMFdn2D26
         1ttQHbbCC2FbAoeme0hrYEhar7nCKCfXsN7KvMwQWk6qg2p3kMEgbz6YUiYvotv6PGqm
         DfbCMfedg3eIEw666Z8UBnwLB7hZlkr9Y6V5qeKwDDNmoi4QfVIcIDwJUuSVp4t1BFpC
         3sTv8V2mXUjpzVHWYFGLgCzFq9RIfjgoDl/KZ6OHD1cKFpl9o2ETq8bzMOxdmtrOjFoP
         m1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790514645; x=1791119445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VLUxpe6alY7Jo7e+VhiSQ88rPLMcwFQfsWyKXgdfUU=;
        b=MaNYqDC9qiqpzwSL3Cklf5d3oeHJB3ujnNlbM35z5b78vyXQOcrWfRi7m/3BI1ldRk
         s5/tKeYeOjm1oNaxnEJEnPjIvYSFLsHDfrLf6Ls4tdDBMFvfqy6Xj+pLCGzKeFH6+//Z
         QZN5IEyWMLzBJ2wAtvJgR/n9h8LecXqXflDGjrkEV5c1okJ8+rJ8oCNQRumRAaJZlnOZ
         dG4Vnd8vIB8PZkOTTdspsrpiw2r/k1EMcOXfxA3KgZohAn2lmcvWG0DX6nVw4fC4ctpS
         qk8kxakhpYFA8fvktcNXHCQT1qYBFQbteVTtlCAHOmXIz7IuIqNCnv1SORZwcx5rLDDX
         CLPA==
X-Forwarded-Encrypted: i=1; AKwUvBx4Lo9jazoqBK+TYyQVjIWOf9q6M2Z76sa6UWdaJeRycivWi85XDGQo1I1YpWD+rQtSzphLYLU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYcv/3TiHYgoIeShclqMfI8UmF1Ps/xZwMdFcsZ/RySoN1kaRQ
	8gabps7XzkirLOSBI929m9eLkJfPK6an/t6HV3cJC+9uiLuZnO6WiDGt
X-Gm-Gg: AYBFou00htTz6ar7adsZSRy3Pm9Td81r0It72jXisXLujfz3FogK0ACBwYqM3uQcFXx
	a4XAXMKuyNP7Z4vCrMGSjO1dUZf3Xsp0vyaVKlS9L2SnFoE8NPya5QtXD5WdluBJ3wM9gipdemL
	eBTbuVlSNBa9E68kvfqoj9zbhmCYdYCdGgdPpdEU1nF2A3NZX5sSXrkoLn4S7CJVJ2bHaxgGzFO
	1jksOq7GmMCVFt/n0+v6Et+E/AsxYtMpIUa3aWFd+8o5QviMy1IUz1UNVZvcMOEvfP4DAtOiACI
	xwVOkg5viMjVSE8f4Ocrbm7DThGv9NDaHzw0ENXhdlIMcY6iDL+hUtuFUEbVVqy4+z5uuvbWD7o
	W9jPXiyVFMGv1MIY9Dn08D5ERjhmiSQbRoVsPtm/pUkwbk+W+9O3m9o5lNM+Wc8R9QQbxhYzW70
	EHRgdCcOgJET9xDTo6dyejdrMsjxo+eIvPUewUQCy65UbD5OBGjYnI+0k/hMENyssq+uLeEQB/8
	UUQndwXL6gdru2taxx6gmVHW6gW34sPsw==
X-Received: by 2002:a17:90b:3e87:b0:39e:6a80:dda0 with SMTP id 98e67ed59e1d1-3a09872e15cmr8724182a91.39.1790514644816;
        Sun, 27 Sep 2026 06:10:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:84a7:e3d7:8c7e:980a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589f7esm14890506a91.10.2026.09.27.06.10.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 06:10:44 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] net/sched: sch_cake: validate transport header offset in cake_overhead()
Date: Sun, 27 Sep 2026 21:10:09 +0800
Message-ID: <20260927131009.24250-3-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260927131009.24250-1-ndaugoing@gmail.com>
References: <20260927131009.24250-1-ndaugoing@gmail.com>
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

However, cake_overhead() does not validate the computed offset:

1. When the transport header was never set, skb->transport_header holds
   the sentinel value ~0U. skb_transport_offset() returns ~65535.
   skb_header_pointer() subsequently fails, leaving hdr_len as ~65535,
   charging ~66 KB per segment to the shaper.
   Mirror qdisc_pkt_len_segs_init() by returning cake_calc_overhead()
   when unlikely(!skb_transport_header_was_set(skb)).

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
unlikely(hdr_len < 0).

Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the rate shaper")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
v3:
 - Split from v2 into a standalone patch with its own Fixes: tag
   (a729b7f0bd5b) per Simon Horman and Sashiko review.
 - Clarify header mangling ordering (sch_handle_egress() and cake_classify()
   before cake_overhead()) rather than inaccurate "post-enqueue mangling"
   wording per Sashiko review.
 - Link to v2: https://lore.kernel.org/netdev/20260922084124.36858-1-ndaugoing@gmail.com/
 - Link to v1: https://lore.kernel.org/netdev/20260917122153.62722-1-ndaugoing@gmail.com/

 net/sched/sch_cake.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index b0d604a7052a..45969c1b95fc 100644
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
 
@@ -1424,10 +1425,16 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 		return cake_calc_overhead(q, len, off);
 
 	/* borrowed from qdisc_pkt_len_segs_init() */
-	if (!skb->encapsulation)
+	if (!skb->encapsulation) {
+		if (unlikely(!skb_transport_header_was_set(skb)))
+			return cake_calc_overhead(q, len, off);
 		hdr_len = skb_transport_offset(skb);
-	else
+	} else {
 		hdr_len = skb_inner_transport_offset(skb);
+	}
+
+	if (unlikely(hdr_len < 0))
+		return cake_calc_overhead(q, len, off);
 
 	/* + transport layer */
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |
-- 
2.53.0

