Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697D377EA1
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129807; cv=none; b=oHOiFb4h2N2voIdh7Bq0JXvyB403zZxai1+WVsTnAyxSVSEw27Nb9eJN1jLkJgPayg3lkDvoYkif8VZHa1NiutsIeQ6o8p8ZusMJEvMFtnY8wnXuOtoVXPYRPcIkl6q5PJqMq31N6WwxO8GVxUg4yRJ6w8LOIJeS6LviQ/mNCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129807; c=relaxed/simple;
	bh=IJaQy4P2yd4pyDkGK7B65H8YZOqfHcYmq4JiucGMmnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGlYZ9dYqyHJDv7SgJY8bTqwo+QgbMCbSPzBsPUIgXnmwJmbenqr4oGxs3EL/saR2jIdqztws8YbBhq4ak6zZwzAewsq4TAIl62HfCbLkeJ/zE7GZj/mi1CkLayxvgkJSjpRGN72JA2PYBdd2AmTyOZE/dffwKTOcNFz+pA1OWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjP+RMZX; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjP+RMZX"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff2f2c4eso838015ad.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790129806; x=1790734606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAh2KuGuRj18JxYhJBsvAeliSXyDq2aM3hEwgBQ4fC4=;
        b=BjP+RMZXDgDC3J1mGFhUi3jljc7kGHllnx68jmL3qb5CG8OiEtg8YhVJbd+RK6vahf
         6gN241+pdRvnxwr2gtPD1f27JRR6ia17fEVwRiidoDnogFVC39tGJHbCVfR9xa88G4iD
         Xqz3Q0DwX5rf7epfJPcS7I+ShsEVD2D8LdCIgcfvQ8tDZCv/YeqlW8uH/b05p7bxWCRQ
         jn66CMoRb9VOv5fzzEnrMcmuRwrGWn6NgbmSZQKthBOncT/Oy4DRH+PcQOCjB/VqHw/P
         mDg537DPJ7k2Kh0ORW1nh6q0n2p3ATRoEaCCdAN6ak8eTyH67w8BiQL2aXyE9XXenZhc
         mRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790129806; x=1790734606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAh2KuGuRj18JxYhJBsvAeliSXyDq2aM3hEwgBQ4fC4=;
        b=EjTIvzs+Wq1RAsBV6HV8Ps1P4xGJeTFy7Cy154zF8BB5sgi+XJF+Rh0uDVRBNE+Esj
         ppz0TPic1Ydefm8iy5mkyO7q/Ih+b6XYDLPXBFhREW57F4wGcJY8WoR5bCfFN+6HWQiR
         cRM9ztHsSMmCTEkhH6cn1Mv3p+deAf5WhzEipnuK/tTLMWY5JjwMrt8pgO5X7cFNyiz/
         QXi8i5o6Qd+r7EMhYu9gJwZr0x6AdsUuJ5RPhzuBJP5c3aMEOZZWtNNd19mXSQnQ1gJK
         T+i5k6eLiZwiUcoieQOkJQuilXO1DZNe5cuyjBMJuPj08s4GfXmnSLK8k5eE7ISJFuUB
         Q9Iw==
X-Forwarded-Encrypted: i=1; AKwUvByqCiE9Fv3nVWlcor1joULB4VFooexlyY0MgzyTz+LvFbt5UUu+M2FhmRLhNQuYIAQakJRG3TE=@vger.kernel.org
X-Gm-Message-State: AFuF++mBG/7FKWToZT+abicyqZ6JOtBpStMJFimZLsmZ9qt88FykQvzW
	6nyUX5Ksp/kVHEUtxVFlBnfZNa3ckP8abqEmXAYs2JsHWjcf3+IAZF02/ffGyQ==
X-Gm-Gg: AYBFou2ctmCxExPTMznKO116IQ2BrNnq3yPTabLGXGEvjTytUEan+oqCa+xQdjx9YGy
	jNqClyj49gxyr6UjFYYJ0zoVl0PcIys+Z/Z+Ev8J9H8PyFZN/vJ7lqxddAYKTnzbxsbTBFw/zJ6
	fWutwxKLfk7gxDo2InOHW1nVtGCZYX4vhvoMveq3N0BpCLYDmEe52qVhGJijY88ZOlMl7c+ZG1j
	9BidO7znyXKFJ5OyBuoo6D+PM0Nf2rgl0AMjqZQN9a2O1ggNE7qzBCdZHiyFRg1ER3fT/UFtPQb
	SyAvcbOxdKlCyzHS1iYriJ34AImTg7SWvLxNgEYOxEfPIUDOrX/UUn2o+sIErJbcMSRAiMaknre
	CYwX3Bg9h0VIPoV4GuF8bHwZeh/rElOSYWAM2t4TzZu9mhUeSVrnXQG48A2fD/xOg8EupnD07NC
	NQSA1zqk7ccg/PIHJhwZwCy6WeQFyWujMBVBJ4xxRqUFQAdIIAz6XQ4amKmDxvqPwLwPOTsvwX5
	n/ZbSugSN+xsMxVQ/5vO5iBf9hKF5olvcFb124RJ+q9Jn+3lUK9ysKOCj6jEA==
X-Received: by 2002:a17:90a:b82:b0:3a0:8001:7d11 with SMTP id 98e67ed59e1d1-3a080017e7amr849638a91.6.1790129805703;
        Tue, 22 Sep 2026 19:16:45 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dbc013fsm2249648a91.5.2026.09.22.19.16.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 19:16:45 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: [PATCH net v2] xfrm: validate ihl in xfrm4_transport_output()
Date: Wed, 23 Sep 2026 10:16:40 +0800
Message-ID: <20260923021640.38855-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917072226.80788-1-q.h.hack.winter@gmail.com>
References: <20260917072226.80788-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm4_transport_output() reads the IPv4 header length (ihl) from the
packet and uses it for __skb_pull() and memmove() without validating it,
so a frame with ihl * 4 larger than the linear header underflows skb->len
to a huge value or trips BUG() in __skb_pull().

Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
device) reach xfrm output without the header validation that
ip_rcv_core() applies to received traffic.  The underflowed length then
flows into esp_output() and the crypto scatterlist setup, where every
length in the underflow window ends in a fatal fault (BUG_ON in
__skb_to_sgvec()).  This is a deterministic local denial of service
reachable by an unprivileged user through a user and network namespace.

Reject ihl < 5, matching ip_rcv_core(), so a complete IPv4 header is
present.  Then use pskb_may_pull() to make the header linear: this
rejects ihl > skb->len, linearizes a header that currently lives in
fragments, and guarantees __skb_pull()'s precondition that the pull must
not drive skb->len below skb->data_len, and it keeps the memmove() source
in bounds.  ip_hdr() is re-read afterwards because pskb_may_pull() may
reallocate the skb head.  xfrm6_transport_output() already bounds its
header length through xfrm6_hdr_offset().

Fixes: b59f45d0b2878 ("[IPSEC] xfrm: Abstract out encapsulation modes")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_output.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e305ba3..86943e2 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -66,6 +66,11 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *iph = ip_hdr(skb);
 	int ihl = iph->ihl * 4;
 
+	if (iph->ihl < 5 || !pskb_may_pull(skb, ihl))
+		return -EINVAL;
+
+	iph = ip_hdr(skb);
+
 	if (!skb->inner_protocol)
 		skb_set_inner_transport_header(skb,
 					       skb_transport_offset(skb));
-- 
2.46.0
