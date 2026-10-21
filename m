Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550396;
	b=MiyqG+/sgU+tg/zD7H8V7ujqqp9OdhjI6UvB3vWzVXGW/OM2HABoXONbh5a0CiTpru55
	 H0Kr5SKbnY4glwv5bPXU3EBGFPqay8w37FyrhtRDm80vENi8VZikL9r8amVxtaP9o6SW7
	 oUMP8hI8bxCUsdldcW/MSkWz+Wy1Ftsp7nys0RvWlSAZdcqMdLsKzy5l2r9QG1O2XUMiZ
	 585/566eMhjY3odRtxh2jF63J0SJT5pZg5Vndi6k6bNDc2aMkDfJ/QzjE3dADPvsDT8cP
	 xknzwwapqFO50hbj3X2DVCTksGZd7/5SS7fvk+8n9fBAfiRcV9wDX5hgouoVfEGU3aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SIfdYuKrZowGGWCzHHgolNoCF8XMtQxMyZQ9b0XJkH8=;
	b=NBgGTx4utV/Xd7/vpO8tfPuQEqG7QqS0VhiSIqLEWIyqOU95avg+OFxJLLFDte//6eAc
	 SRv6pt0bNVcETydijI0pZYU95CNWf9zSxmX5Hi7tkB+DC3/C9JF+7KI/Am0l2745LOdrG
	 G/Eq/b/Wf2dJmdXBgczX/L7I3H93whmaIG5XBDeXSyljb7thADcMZsJnYIriCyyIfIRrl
	 V5lnrwP+vwUFmfJbNJiHgxDBtlI7MCClbfaYX7pomdEgAsNi+7iVzgJkWlPtwoNdj8UHZ
	 FpwyVD77IDYe5t7tx5/9OEN6a7NJQzKgVOCND7gJo1Mwh5X1uvO1DBeTFLsZxUSneCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=agfPLIGG;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C060A2614
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD6C060A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=agfPLIGG
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f20b304c0so29371485a.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550395; x=1793155195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIfdYuKrZowGGWCzHHgolNoCF8XMtQxMyZQ9b0XJkH8=;
        b=agfPLIGGiLVsUCOLHMgU/UcLSpxwViouNvaZrSqAOZSdV5uSMjzkT4D+DlabS5tvPO
         9+2z5tm5/VtSy8fxs4XWBqbQ04lH8JCWHbgqmPQ4SRfKNhURTo0R7lBsM05I6U7ynqrM
         eWDsvZHJcQD0xvaYmZ5YeMEqzRifU+skeh5p6cMv8UAtGRRK6P/fUAhHrp7bFNYmC7J+
         z+XQSLsvtPXfYQgV5ykAyRnKxOU+bF5iFCYzmMp+NOoYkgqCodOXmB9DXqH1C795Idqw
         BmaMW24Rd8tqEt4oIro7K9vthFEuxjeZN0TOD1lbUgoyho/s7eT+K4djWgZsSug1qaTT
         rkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550395; x=1793155195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIfdYuKrZowGGWCzHHgolNoCF8XMtQxMyZQ9b0XJkH8=;
        b=VI/PlPWDjZMuXFwX5zC8n51EiTfK46HbsCAPGNPQz1hrxl59muQjAVJpE2gEHH3S0p
         OrBMTxld2HE32Uhb2carj2PtAxIWU0tHPTtrKN569+Nsc52cXkneTcZ0iZfJYVMPpVq6
         N1N7HJ2Q1hFgaFwWg68yU4HFKTRXboL0Yl2QoZxlSCwHuLqE9ZUK7T4/udZadfic/6tP
         FJ/QYPICRVKjGgffooPSAEr0Cr/Z8ofiTvZfC7o/RRnob8O59NPiDwJtQIA0MnFHS6zV
         LpeXYfIgVGS2PY9ekSQtHMVIrBIaRAVT7KqVbk4732VZgacsG/41VWdVkcNWgScHhmuY
         RXlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSNvACUzyXr33T0yxU64RKGqB1OShqXAPuHSC8XwnC3q5dT753CedkfkKVsOkzAqL6unf3LP0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS4bhtWrq6H7hPb1otnc/ts/2QN5p/oRw2Jer9o/XXbI1AaYiv
	nRAjLd3t0JohHO20aG58fJSs9qpvmfYKovKHYxg6hjHW5SCF/auKQlC2ypI67GDw+TM=
X-Gm-Gg: AYBFou03HBlYcV1hWOXENRpwK4RfwdUjZCEKb2GeiGqqdV05Qysn0cV62e86nPYup/K
	eeUIA7u7YimEbImvshILI441yBtjnJdHnoumnZKDRByY+24RnRJOv9WqXAlSbqleAtTqXXRULb7
	oO0RuN19vdDINQStF+K7ZL5r98PJORSoTvPxhD+gKJPrMfO9KKhXaQBw4hCecvcG1EYilIQ/aK2
	1ycv/XrvtHNfwZmfyVpp/emVDJbj+cAYqk6A0SFD7ecKDhR7u+9siBcdFM4l0RLkGrnL8JVe+qu
	DiJdLi4hPUw/28U+EEl069U/2rHo4UKCzMGlmze7Epte1B7FMMa7hr8eiiPiZsyudxiBS89Nucs
	HFwD8MVYbhKOoHvS0HCK9v7pTZ3MTLAWwh0wnrrfwWAl1DPQO0b/ySk60kmSEOiNYc/NLfjJyp+
	fe59zvtzxUIyVfm4CeftwgGxgxcss3Yf1ZmCT1TU94iB977w7hRBYtNpTRzEm8mUwoBClCkeI+N
	Im2nqapjy1dJiAkjNkpGGwg/FdFpkp+ykewElw/c+PoJIlalxcn7EKi8RJ6BmclQ++3Fun+jbZ6
	mQyjuBtksCOkkXzNKiyDsYx3pM27O1YtLK2AVjjLcPuyOGSuXBRdIJ1XIoE71fQ=
X-Received: by 2002:a05:620a:260a:b0:93e:48fc:aa85 with SMTP id af79cd13be357-93f57f1d75dmr211957385a.43.1792550394720;
        Tue, 20 Oct 2026 19:39:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:54 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3 6/8] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Tue, 20 Oct 2026 22:39:38 -0400
Message-ID: <20261021023940.1940971-7-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021023940.1940971-1-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone. A hugetlb fault bound to one node
can then take a pool page from another.

dequeue_hugetlb_folio_nodemask() picks pool nodes by walking a zonelist
with the policy nodemask. The iterator approves a slot by its node, and
the walk loads the zone from the slot afterwards:

  CPU 0                             CPU 1
  dequeue_hugetlb_folio_nodemask(nodemask {2})
    slot 3 (NORMAL2) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [.., NORMAL1, NORMAL2]
                                        -> [.., MOVABLE1, NORMAL1, ...]
    zone = zonelist_zone(slot 3)    /* NORMAL1 */
    dequeue_hugetlb_folio_node_exact(h, 1)

Check zonelist_update_seq before using each zone the walk returns, and
on the way out with nothing found, and restart the walk if it changed.
Checking before the dequeue leaves nothing to put back. Reset the node
the walk last tried on every restart, so a restart does not skip it.

With kprobes holding the walk across the online, a hugetlb fault bound
to node 2 took its page from node 1 in 3 of 3 runs, and from node 2 in 3
of 3 runs with this change.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/hugetlb.c    | 13 ++++++++++---
 mm/page_alloc.c |  4 ++--
 mm/page_alloc.h |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b37d7d0db7fc9..8edf323baf0fc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1293,11 +1293,11 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
 static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_mask,
 							int nid, nodemask_t *nmask)
 {
-	unsigned int cpuset_mems_cookie;
+	unsigned int cpuset_mems_cookie, zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
-	int node = NUMA_NO_NODE;
+	int node;
 
 	/* 'nid' should not be NUMA_NO_NODE. Try to catch any misuse of it and rectifiy. */
 	if (nid == NUMA_NO_NODE)
@@ -1306,10 +1306,16 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 	zonelist = node_zonelist(nid, gfp_mask);
 
 retry_cpuset:
+	node = NUMA_NO_NODE;
 	cpuset_mems_cookie = read_mems_allowed_begin();
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
 		struct folio *folio;
 
+		/* A rebuild may have shifted a node outside @nmask into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry_cpuset;
+
 		if (!cpuset_zone_allowed(zone, gfp_mask))
 			continue;
 		/*
@@ -1324,7 +1330,8 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 		if (folio)
 			return folio;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dd8c9046f9a06..5ca8e57c5fcbf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4411,7 +4411,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
  */
 static DEFINE_SEQLOCK(zonelist_update_seq);
 
-static unsigned int zonelist_iter_begin(void)
+unsigned int zonelist_iter_begin(void)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
@@ -4432,7 +4432,7 @@ static unsigned int zonelist_iter_sample(void)
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
+unsigned int check_retry_zonelist(unsigned int seq)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 2b1017a91928c..53df6b8a0c00a 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -265,6 +265,9 @@ extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 extern void zone_pcp_init(struct zone *zone);
 
+unsigned int zonelist_iter_begin(void);
+unsigned int check_retry_zonelist(unsigned int seq);
+
 enum fallback_result {
 	/* Found suitable migratetype, *mt_out is valid. */
 	FALLBACK_FOUND,
-- 
2.53.0-Meta

