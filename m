Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCB52F290
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066495; cv=none; b=SVMvKZ7ckphmEhUh9DZ6Zc+gnS7USuA2AFrxd5f+4W/JsCkGeQgKVMhFDpI3EQoHoyTK9/5Oh7AJM2CUzQ2FDhhBJIuCtpO35Xn6e95b3Tyu1CidGd1R9Glt8AAu1+Q2IrOqzdRZbCsK1crstMDLpzQra6OaFSdTaaIy6XkaVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066495; c=relaxed/simple;
	bh=Yizwf49hTgGWK0f7w1A7hUDvewrlrBBNlQW6FGUza3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuOeUfWYSyMpaech47SDg4x3DPQRwbzVT8hTi7X/R/mMk797wsjWkwP8VZ8v5kcTBmK+Nn5zFG5/PnUim+1WTTMFSxqM+/L/1ddoRIn2+z771P5qaHMJ9k1iyUCrWbSP28QwblcTpHD1jApecTDr96GM6Dqpu+Tw2Ti1L78NdnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjt1Mp2j; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjt1Mp2j"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc745abb731so1149975a12.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066493; x=1790671293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbIdLkWcjcYqMS1e8Ux9cE0ST5iQLHRVAtymRNEq84E=;
        b=sjt1Mp2jbhMxQSI8jMmRRwck5TEaCW+Evr6xB4ogE38WqQ3+zCY73oTvj58q2GY1Bn
         triD6lQXGmu1Hd+nIvJrcm9nZfTowab6oXcLGRWKISIkN57ebZUebq3K+SSBWUKjtsfV
         +PCSWA6TS87WHlZhIJXUVcQ/FsiUWWEQDc5W7p2ubLJBRsN7i6dznT0bUlaQs2cV8fU0
         mJCAX6Hj3f6hi1RZtJjHvJIDnHC1G9IwcQgdajbGZNrUZUaAlvO7zZ68llp8qnVST2Da
         Byq9MoapsjFL61t8G38+hZxKRwM2mNk8mflD86KODO5oqMbxUhHP6yWG46BXSnbTxpRc
         ySPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066493; x=1790671293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lbIdLkWcjcYqMS1e8Ux9cE0ST5iQLHRVAtymRNEq84E=;
        b=f+Dioz2PS5RVPe0r862Lp1QRS33Kf678MCSbFoYtEuDSpa9GLhvN8hNCvBIx/uoaUb
         64+bLjOxVeL2S2h/UBHmuT7pUfVhnveABOLmV81TRi3EyH+FDeinvYe/sS90mRTErzvm
         vaZkV33cNNZ2biMxb89JcHVGjlrr9J3T9ZHzcAM0LxAKZrV8JTFCdLxfAYl5QtlBcxv+
         BziPtZG2iqYUKObLXpk1sGFnHjATRaPdhHFGH/xpfWAlNjOiZCguvwSgaWBZJYNY4l7f
         GJ00niA3g+dJxOz82D79BQwEdTn0ZMDvxBPMGmKhcFQePuRnVgWdR9qyThGspLPgGxGN
         Cc7w==
X-Forwarded-Encrypted: i=1; AKwUvBx8n7UiwtPpioCq+DrLVIE8ynS/c4lb0I4vtQwE2xsnCbFz288KB2+YbVesXFqwK4HgCismTWI=@vger.kernel.org
X-Gm-Message-State: AFuF++k+vzr3DcuuiMEq0Q6rNvmXlJOS5LEZqehGG+v4udyX+8vwUZ/K
	L1TkagaF280/I8NRDvSZiBscp3D5WB+RfjeueCxk+sj238nEL2HQ28Ha
X-Gm-Gg: AYBFou1b0ag2zWpJu34xMS+C7oi0X44r/ll6EigmigU1IxsCGw+3Cj5YMit8TYtEXDV
	lCcdZ0St2AOXUR0Ci77J7aka94alHQdvy+aTJkkEpveNwdnomn/htdnRSz7t0lfM2nKmHje7RoZ
	wIdbYTTascyknVy3unUrrtOYtsIaGceQFQuhUrdhN+8HzGub7E/JZNJe6pJqozZfMLkI85gPFdQ
	jAlYoz4EoN7BvfMv2rowl2ScBOx2s6rsifhZtopAKpubenz8wl9D8Izg2Ynt+01IQ5b0gVJGfCo
	UStS2mPpKEIxJry3WJADMrs8b2tvegEK60ZAsDVrxsHAzBQIycvggasPYWxuWICyf9FNcixlpYC
	ylb0pDdp6dU748EKeBr9qln+3Y/7XaJfyzk7g1wIzUk8jCwSPW4f+VqrrJuTZv50ftSGwKJH0AH
	NhDk/8/Zpq58526FxCtd389wdyOQlMlQ0LSmj5vyq9o1k6IhQtJpyHER8IjnkRtUdcuree90OAa
	kh0URWtZXZGLezjN9gV6pgq5PW9EmOsD8J3dg==
X-Received: by 2002:a17:902:cf4c:b0:2dd:c053:82f4 with SMTP id d9443c01a7336-2df60b46f92mr5284585ad.43.1790066492911;
        Tue, 22 Sep 2026 01:41:32 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:b519:cd9:fed2:d000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d047dafsm6084765ad.52.2026.09.22.01.41.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 01:41:32 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH v2] net/sched: sch_cake: prevent shaper corruption and stall in cake_overhead()
Date: Tue, 22 Sep 2026 16:41:24 +0800
Message-ID: <20260922084124.36858-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179000041222.2160803.11108326722307773525@kernel.org>
References: <179000041222.2160803.11108326722307773525@kernel.org>
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

However, cake_overhead() suffers from several issues:

1. When segs == 0 (e.g. from dodgy GSO packets where gso_segs is not
   recomputed), the multi-segment arithmetic underflows: (segs - 1) wraps
   to 4294967295, causing cake_calc_overhead() * (segs - 1) to produce
   an enormous length. When charged in cake_advance_shaper(),
   time_next_packet is pushed decades into the future, permanently
   stalling the CAKE dequeue queue.
   Fix this by returning cake_calc_overhead(q, len, off) for segs <= 1.

2. When the transport header was never set, skb->transport_header holds
   the sentinel value ~0U. skb_transport_offset() returns ~65535, which
   is not caught by a negative offset check. skb_header_pointer() fails,
   and hdr_len stays ~65535, charging ~66 KB per segment to the shaper.
   Fix this by mirroring qdisc_pkt_len_segs_init() and checking
   unlikely(!skb_transport_header_was_set(skb)).

3. Both skb_transport_offset() and skb_inner_transport_offset() return
   signed int, but hdr_len is declared as unsigned int. If post-enqueue
   mangling (such as BPF packet trimming via bpf_skb_net_shrink())
   produces a negative offset, hdr_len wraps to near UINT_MAX, causing
   corrupted header length accounting.
   Fix this by declaring hdr_len as int and falling back to
   cake_calc_overhead(q, len, off) if hdr_len is negative.

Fixes: a41851bea7bf ("net: account for encap headers in qdisc pkt len")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
v2:
 - Accurately describe the impact as shaper accounting corruption / stall
   rather than OOB read past the allocation per Sashiko review.
 - Fix pre-existing high-severity integer underflow when segs == 0 by
   checking segs <= 1.
 - Import companion check !skb_transport_header_was_set(skb) from
   qdisc_pkt_len_segs_init() to prevent unset transport header sentinel
   (~0U) from inflating packet length to ~66 KB.

 net/sched/sch_cake.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..45969c1b95fc 100644
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
 
-	if (segs == 1)
+	if (segs <= 1)
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

