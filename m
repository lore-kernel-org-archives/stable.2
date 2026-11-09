Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223814;
	b=U/vbOY7j/Z+IhZP+BPiYyNJTshiEzjF5iIYwFl3pkqE8yK+HBvtgrlCUMh7HrjFVOX3W
	 jZtTVTweduZ+ZA2Hxb+jWgaxeJ3OyuuZ7j95R4+BcGWHGQHSxDi1Ny+Z4oEfgrW+d4yjW
	 yGvJTw5KkchiWgp0MpJvIcyomeDOS9zFe040H3GE8jyOYJWGJyROVpV2eRwC04Yn4IcM1
	 /2vVXdMN99LLMRKNfstN2kMDehSBxD70S5MRR2dMon8mEf6CliQzCk2pk9wc89gkR4poe
	 wUiUIJaXvJ6Qam3aSv9Hog4HtaF+sf96z8ohehibz7lLAvbGXj+Vn+ujzav3yP4abKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223814;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=sISja8KYSklCfaPAc0at5XxyGiqK8Ueb0WkvKObYZAc=;
	b=BRmfbVGyn5jNA9swbK4M0TEHecC3ElhmRMDLfm5D1o2UprEFFsHOjWyJG210Lv6rbSj8
	 x2Eargfe5uQQoa8m/l3U/IB6CEdSZABhi+5PmJ6BXc0w7ams7yjhrmnC7g2NZax4fqVut
	 c4+Z65P8NyPW5F0mbBYTFoXPsGU/Otcawf+YjLbsPgAnBUMKop3PEmlsydWKUeO6k9umP
	 C0mAPnzHKCS5meg+PKU2e+9AR6kIXL+BQUDEgTb18mzaalu/hfuWdG195GXKH7v5N4/U7
	 zUjlBAS4fqElzD36uJRv0iZmd3KpSuJSAllJZtqfnz2AYvJ+tpxp51d/McSK6Nky6LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=b7Hiq1pU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Rd5mRS5L;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6F606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF6F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=b7Hiq1pU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Rd5mRS5L
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 162A37A0165
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:30:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 06:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794223811; x=
	1794310211; bh=sISja8KYSklCfaPAc0at5XxyGiqK8Ueb0WkvKObYZAc=; b=b
	7Hiq1pUFsbVqUjYddD8x0ERB0RuTSH6a4YD29g5S25OdEJWeObEM3ZweBWUrUhhc
	DJnM/Pb67dyBnU9zKQjn2fDLRGcNkjit3VFR0DkkcjsJTGxzORZZZTmWJSfzmxzG
	c4NtJoT8p68+QeOe3ZOCB5sXETYBvWa2LeF3T5nJKxfeNeMGsGLAgFfY7n1NtI9l
	maWKBMVscnOJo101l1qINS0Gq7NZlaxut6B7oYa5tsIAxckaDsE2Zikqbv1W2i5m
	AERrcEDMYjwSX1CNbQXSVt531fySfgRp7n5xeCopyIuUoFr206tPURAN1AMKGuTy
	rnvnHmr+QcLZdf5kHYVaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794223811; x=1794310211; bh=s
	ISja8KYSklCfaPAc0at5XxyGiqK8Ueb0WkvKObYZAc=; b=Rd5mRS5LoeahfWkIJ
	VhsBhhWuNC74U4Vgpv6haPLgg8Xoc9qJkNJw9GHfsnXNuDHERw6SJ6HvohPYXX1b
	ZJv4912vOMZNTmExK/K4q/3vBZCttkO96i7CVXbbeepX6LW9lWDviIWbQraZ7nYZ
	sNUGUw+lWKywOA5xL90EEPRwlgESjaeWD2vK2ASMWBKTlH0+bQ/hSIAuSoNxZO4K
	h+b7+aq46yDVxLnKi7gj4NheM3Qm+IjXHRZWX7ABA9gD9Dy+kFe+YDMzV0xw+p0B
	lwJWN2S1c9HFVIW+bOwZ2eZXkL/AgD8vp102hlhMbm2JxwBo+Sc7SQ3IhUD5rdRI
	Jp0Hw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794223811; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SJP2T7FT1a7AMELt4iwaREmstJK/L5LMNGLbChuHK1oKo/G
	Z7NZvVpnFWgyqLB+XGf4wC0BI1xTmaVZ1fw5Q/WdBS3XqOzOuadXUL6nPuiAUPy7
	mG17tVmrZ0twAZXeNW2JvZGnXKbe10hq1+urBJGLvNL1JyBso1sSR/uIBfLaUChM
	W+bwCi1HedBUEiRuDnY2o6qtyVXzJrM45l+C+klemNAhNzntr8sm5td35K5QBwHN
	VmGXI+bKI+4XhnJkv6nLjX767xhs1d1smPMnMNjRYE1ZaPQLY+8EVvEWPF6yDynV
	mGA0QW7jFls1ZQnIl0KFsD4vN/QjPrw5g3WW8fg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SrOSakRmiC4zbPn3nihnWGhEQA/UrbEsdWn4pHaMlhw=:8Dl7gtsoOiUWFeRIpvs5NkxXA8ta+eNX5ymLoBm5WZg=;
X-ME-Sender: <xms:w67xalrRJg1KwKONj5QoXyqt8p-NpbDKxZWeivPlvgvtzc4isL-YAA>
    <xme:w67xarXyWyJrUtmMQQOoQo7w76u_cbVuvXBM9duqOrDeXRbmW0X78dr1y7gWcNNJ0
    2mR4RxegLzwnK3L8BtdROtuhBEG4Uc1SNiFY11_ZsGEDKCjZjwhTeY>
X-ME-Received: <xmr:w67xaq1CiLmwn0V6uW1T_bvnQiBKRLxJWo8Fw97iQa2udyJZTCjHymVGFDo>
X-ME-Proxy-Cause: dmFkZTFdWTKyoYHeuTxQ8B1BRJRBSb/fCB0gPtprL58vVkwHPZCScv9Aex/RYly0dhFFuZ
    9jaWodSbLVOUPRoqT1D4ujW4sYjuRlT65hrbwt5m0MDFVQ7Q5Z1leqbiK6oEYfvo/vEJ1O
    7y8BwaDpNZK8BH7rz5HEn+gr1yAD+tY9Jxc/zDwcktjQpdOh88gEIM1aE6+GDk76elWXxd
    Fovo4BCJ8ytl2qHerlfJlgetT/EB6mFqJmA62EJohzTnaYAgzOqAE4DDanTFYvLGhvy/Tb
    pog2VUHhegEjsgMmBdT+2jGL+u54ELYDXjN3mI5BaDU2hz9Jh2xirFp7noFPSeqmNrHDX9
    27fidmO2nacgGqgKka1F3c3mE5LirYnnt7wfXMfIGntIzc6ADgGqgl8LxXePBRVUGU8Nvr
    FfhQqT/E9/xrivQDOByY+EagmjY7dhP+3chEaEw4Onxw/4xjAl2P/KwAtLDFdwL4xSzOjI
    hZZ+GtiN9HV6zmFUZPn17gRhxtm8vJgJQwaH7PQKG95P/VMawgeZ52OUhN9NvxZsO17H6F
    XKmTAJejbQKhmw4WZ0PZVRSNi+3r1cE/emOmDp6yBtvfn9Bqe39Vx7/cp/V/Wrb+OSGL/c
    dVxW2qzY4K+rGL7ipktf60apoizT/qb/LF0AB72nJRwvlkY4Cm8box4C6Uxg
X-ME-Proxy: <xmx:w67xaiQZ6Bjd1kvzDBR2wIYEMWInLjuEkL6m9gBZfMNBvwg-2OspQA>
    <xmx:w67xamSUA6baNxmvxNMqoVVEPKidHm3DJcpPq-gpx8ygOuHNUU1krg>
    <xmx:w67xarVFJgn7hJXRQSRJp__EyljrHrF7zsuz37JXuwNqBGjK9IuYmw>
    <xmx:w67xaoLfQ2OBFApoZ1owZJcV77dOffJO8awDzezBM1WxYEncRJGAyQ>
    <xmx:w67xaoDbUakfg8JcuDmCpo9Mxm4FUU3o01nlj_U_23zAQOT-8QG0535j>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 06:30:10 -0500 (EST)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	hannes@cmpxchg.org,
	david@kernel.org,
	harry@kernel.org,
	usama.arif@linux.dev,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 6.18.y] mm: page_alloc: make defrag_mode retries follow the promoted order
Date: Mon,  9 Nov 2026 11:30:06 +0000
Message-ID: <20261109113007.46714-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107051426-failed-6.18-4cd78a2dcfbb@kernel.org>
References: <20261107051426-failed-6.18-4cd78a2dcfbb@kernel.org>
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

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

commit 4cd78a2dcfbb13f049f841b98763896a3d1d7750 upstream.

Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm
in defrag_mode"), direct reclaim and compaction for non-movable requests
under defrag_mode run at pageblock_order, to produce the whole blocks that
ALLOC_NOFRAGMENT needs.  The retry decisions that follow still use the
request order.  An order-0 request can therefore retry indefinitely
without ever reaching the ALLOC_NOFRAGMENT fallback:

- Reclaim at pageblock_order gives up after one pass as soon as a zone
  looks compaction_ready(), and do_try_to_free_pages() then returns 1
  even though nothing was reclaimed. It returns before the retry that
  would reclaim memory.low-protected cgroups, so when most memory is
  protected, the pass that did run finds next to nothing.

- Compaction at pageblock_order fails or is deferred.

- should_reclaim_retry() takes the reported progress as progress for
  the order-0 request and resets no_progress_loops. The request
  retries.

Order 1-3 requests loop the same way, and should_compact_retry() also
checks their pageblock_order compaction result against the request order.

On a production host (64G, defrag_mode, memory.low covering most of the
workload), 95% of direct reclaim runs were order-9 runs that returned 1
with nothing reclaimed, at up to 60k runs per second.  Across ~200M
should_reclaim_retry() calls in a day, no_progress_loops never left 0.
The spinning allocations were SLUB slab refills for inode and dentry
caches.  The time spent registers as memory pressure, and pressure-based
OOM killing takes down both workloads and system services.

For promoted requests:

- Reclaim progress does not reset no_progress_loops, as for costly
  orders.

- should_compact_retry() checks the compaction result at the promoted
  order and does not retry COMPACT_SKIPPED, since the request can fall
  back. The compaction priority floor and the COMPACT_SUCCESS retry
  limit stay those of the request order, so a non-costly request still
  gets its COMPACT_PRIO_SYNC_FULL pass before it falls back.

When a promoted request takes the fallback, reset the retry counters, so
that the fallback attempt gets a full retry budget before the OOM killer
is considered.  A request whose reclaim was not promoted spent its budget
on the request itself and keeps its counters, as Usama Arif pointed out.

__alloc_pages_slowpath() computes the promoted order once per iteration
and keeps it in alloc_context for direct reclaim, direct compaction and
the two retry helpers, so no callee has to recompute it.  Harry Yoo asked
for the promoted order to be explicit rather than derived in each callee,
and Vlastimil Babka suggested alloc_context over new function parameters.

In a VM reproducer (32G, defrag_mode, inode churn under memory.low):

                                        before    after
    should_reclaim_retry() calls           63M     293k
    peak memory pressure (PSI some avg10)  99%      12%

File creation runs 5.7x faster.

[kas@kernel.org: s/order_nofrag_promoted/order_defrag_promoted/, per hannes]
  Link: https://lore.kernel.org/atDL-nSFP2KVU7cI@thinkstation
Link: https://lore.kernel.org/as5q14OsbK2CmOrh@thinkstation
Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Assisted-by: LLM
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
[ kas: alloc_context is in mm/internal.h and compaction_zonelist_suitable()
  takes no gfp_mask in 6.18. 6.18 also tries compaction once before the
  retry loop; set reclaim_compact_order there as well, or that attempt
  sees order 0 and is skipped. ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/internal.h   |  2 ++
 mm/page_alloc.c | 68 +++++++++++++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ef42eee87c7b..e0adafc45c8c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -594,6 +594,8 @@ struct alloc_context {
 	 */
 	enum zone_type highest_zoneidx;
 	bool spread_dirty_pages;
+	/* Set by __alloc_pages_slowpath() before reclaim and compaction */
+	unsigned int reclaim_compact_order;
 };
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ff863a87f2b8..392280288599 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4120,6 +4120,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	return page;
 }
 
+static inline bool order_defrag_promoted(unsigned int order,
+					 const struct alloc_context *ac)
+{
+	return ac->reclaim_compact_order != order;
+}
+
 /*
  * Maximum number of compaction retries with a progress before OOM
  * killer is consider as the only way to move forward.
@@ -4142,22 +4148,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 		.order = order,
 		.page = NULL,
 	};
-	int compact_order = order;
-
-	/*
-	 * If fallbacks are not permitted (defrag_mode), we either
-	 * need to reclaim space in a block of matching type, or clear
-	 * out an entire block to allow __rmqueue_claim() to convert.
-	 *
-	 * Reclaim by itself is primarily freeing space in movable
-	 * blocks, since that's where the LRU pages live. So this
-	 * works for movable requests, but not for others.
-	 *
-	 * For those, promote the order to help make blocks, instead
-	 * of spinning in reclaim alone unproductively.
-	 */
-	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
-		compact_order = max(order, pageblock_order);
+	int compact_order = ac->reclaim_compact_order;
 
 	if (!compact_order)
 		return NULL;
@@ -4248,7 +4239,7 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	int retries = *compaction_retries;
 	enum compact_priority priority = *compact_priority;
 
-	if (!order)
+	if (!ac->reclaim_compact_order)
 		return false;
 
 	if (fatal_signal_pending(current))
@@ -4257,9 +4248,11 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	/*
 	 * Compaction was skipped due to a lack of free order-0
 	 * migration targets. Continue if reclaim can help.
+	 * Promoted requests fall back instead.
 	 */
 	if (compact_result == COMPACT_SKIPPED) {
-		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
+		if (!order_defrag_promoted(order, ac))
+			ret = compaction_zonelist_suitable(ac, order, alloc_flags);
 		goto out;
 	}
 
@@ -4457,11 +4450,7 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 	struct page *page = NULL;
 	unsigned long pflags;
 	bool drained = false;
-	int reclaim_order = order;
-
-	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
-	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
-		reclaim_order = max(order, pageblock_order);
+	int reclaim_order = ac->reclaim_compact_order;
 
 	psi_memstall_enter(&pflags);
 	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
@@ -4629,9 +4618,12 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	/*
 	 * Costly allocations might have made a progress but this doesn't mean
 	 * their order will become available due to high fragmentation so
-	 * always increment the no progress counter for them
+	 * always increment the no progress counter for them. The same goes for
+	 * promoted requests: their reclaim reports progress when it backs off
+	 * for compaction without freeing anything.
 	 */
-	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
+	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER &&
+	    !order_defrag_promoted(order, ac))
 		*no_progress_loops = 0;
 	else
 		(*no_progress_loops)++;
@@ -4828,6 +4820,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 			(costly_order ||
 			   (order > 0 && ac->migratetype != MIGRATE_MOVABLE))
 			&& !gfp_pfmemalloc_allowed(gfp_mask)) {
+		/* Promote as the retry loop below does */
+		ac->reclaim_compact_order = order;
+		if ((alloc_flags & ALLOC_NOFRAGMENT) &&
+		    ac->migratetype != MIGRATE_MOVABLE)
+			ac->reclaim_compact_order = max(order, pageblock_order);
 		page = __alloc_pages_direct_compact(gfp_mask, order,
 						alloc_flags, ac,
 						INIT_COMPACT_PRIORITY,
@@ -4926,6 +4923,22 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (current->flags & PF_MEMALLOC)
 		goto nopage;
 
+	/*
+	 * If fallbacks are not permitted (defrag_mode), we either
+	 * need to reclaim space in a block of matching type, or clear
+	 * out an entire block to allow __rmqueue_claim() to convert.
+	 *
+	 * Reclaim by itself is primarily freeing space in movable
+	 * blocks, since that's where the LRU pages live. So this
+	 * works for movable requests, but not for others.
+	 *
+	 * For those, promote the order to help make blocks, instead
+	 * of spinning in reclaim alone unproductively.
+	 */
+	ac->reclaim_compact_order = order;
+	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
+		ac->reclaim_compact_order = max(order, pageblock_order);
+
 	/* Try direct reclaim and then allocating */
 	page = __alloc_pages_direct_reclaim(gfp_mask, order, alloc_flags, ac,
 							&did_some_progress);
@@ -4969,6 +4982,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	/* Reclaim/compaction failed to prevent the fallback */
 	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
 		alloc_flags &= ~ALLOC_NOFRAGMENT;
+		/* Retries went into making blocks, start the fallback afresh */
+		if (order_defrag_promoted(order, ac)) {
+			no_progress_loops = 0;
+			compaction_retries = 0;
+		}
 		goto retry;
 	}
 
-- 
2.54.0

