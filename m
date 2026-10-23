Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753149;
	b=X4THAyF6jcWb5E4g4sQgwvkmvqRl2bDCrSdNSoixWuZww/yGisBLXBY9kNWnQuveRmEz
	 Nou6zDH5KhszONPD/MAj53KFaoJoGZ7hM0mtjP22C7UAHer0KLV0kKnYzx+alXU12vqlU
	 fwOq/eBj0TB80Mpt+tpt1VW55G51A5DzvVNDdql0yUb7TUSjF7T8cIOWklE/siOolvP+T
	 v1lYC/KnP/c1vVqQvup55AXCPChwKVJpfq5QayeBW2uPqDxrdjPxBdzp/8PJj3b9o7Ao0
	 s5o1swKKlX2hsbW5B3Y8PoqVOyy5GAsqG3zFHsi+65xXzAlYe219VrZ3M9BNAE0wodw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753149;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=D2r4ZfyHCaD9dgkcWlKEJHPq9+nOT0JroYVFAyy9ixA=;
	b=QRRHivAHI3Lq9B2NXB8GIvGUPgrl3Kmoo3agEaTBV4Svm2XUdWEIRzR94vJDS/BjHulk
	 ALJhZ0jd6m5qwA2dh3gvunPZNOyQleH3ReXdy/52j9GRhgAcOQ2Q1XS3SIGutqkMdBkh8
	 /wcM+RUCbP5s3PH1Eb5CJ0/lp9ETYWdJ5CWsK05VmaLqtgY+iUYXJ3+gtdv1laY/e+Noy
	 7mYjTrAM1qWM/Z29+B5ddY67SPsAO4V47N6CHzcOHJwQght3itdL7IQRy1EmuuF+AtL1O
	 7gOrtX9m6/tKCqB3oSg1NQwuC3YQYpYs+9lf1xUAHsqcNxpizuaSWDEr+VJbwRU1yuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxMEOkn2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDBC606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxMEOkn2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925F91F01825;
	Fri, 23 Oct 2026 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792753148;
	bh=D2r4ZfyHCaD9dgkcWlKEJHPq9+nOT0JroYVFAyy9ixA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CxMEOkn2QmftN9/St9toBqP7XAtNuAbWcLCpgTK+PMt3x0BqCwxN28K8Ayx+vzucV
	 Pwan8wjYEC1jXvfZaCoyfaUNvZ+4cJ8bs5DxafA/pXyEq3rg+DCqvQ1MriZHOOutgG
	 9Kf1QHxbDA9Vvvp8qws2SOS+HENoV/V9SUeJA0lZforHoi2AMCHlcBl6Cq0Vn1Z7Qd
	 hNyL8NHI5RTaKrNpuZ/l/d7eBVknhC6JTl6AdHiUmLITB5r5AiesR1CMGgz1mhlSG6
	 Y+qdFdhFEBvjnbA2qGZswHYO1vsy/5JJaWJ6YqZWHwHnwcqiwsMxQM/vKlkoyyJ7WH
	 zfZZkDQZ2eFCw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9328A198003A;
	Fri, 23 Oct 2026 06:59:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 06:59:06 -0400
X-ME-Sender: <xms:9z3bakz8Narhsm6NIlOE1eLTc3lHS6fMAu1_6AZRtewOW_nKdFh43w>
    <xme:9z3bah-XRVU1xBrR7GzQVzp7UFXPEudLVV90gLKTM0sWhlTQStgm9w7E_70p161xM
    MJsXroMWl4MrFrPat4Mqtl-0yjEldh-HbHsFhV8QJe0KCBEQVzLmQ>
X-ME-Received: <xmr:9z3balpzXAa4oyEb17mjDnb5bKZ7jvZrGDcxBLCOH7A5QyIVCug8pwpuqWI>
X-ME-Proxy-Cause: dmFkZTFLMZyDGD5DpP6lSiL2dELHyUp4N06Rl6Lue143rkn3tUALUBKEbbJY+IvL1iRWKq
    Z4dgEQq0FUdnRtmFyFv4zy4Gipk1NXKUpdUDUE0u6EF3hakrjkxN38+WVeBhS2nVL2lHZb
    75VM0Av6Bd/1PNVIfgaHNaJ03W0Ny7LmLqoUTHhwQErKe7pJCcHo+AEzr3Wsj9B8lzTHMo
    H8KiLgkrfoOLC114GyzOjleNKw8JHQsy/mpTRdhcs1uIYE5N5X3CZKwWn/vDlTEIiWXXM4
    nbNBQlvaL2nm5ycmEWThCY8DfEVm79j+zbIADZBneeVvw+SuWQvYX9sb9LGTljPv6Q4nIx
    OAN5J4EUxiZttFLQoN4ReJusDmlByS3MUkJ+GoqXrb6BYlbLQkAYgctOiP+WudqZKi2kzs
    Eo4cD3MQGEE/Z50zZRKMwL7XxWcv9VxDfQFeiuUNirwidXVEnXBLbZ7yVX3zHcXStdVIZM
    r1FUVwpVrYI33gyqqoUg4x4z8kpo2k5VaHGS61SrSB6iGQlWd/Y91Jf8HHNken5LZIRP3w
    6xpHLEmTPGugU0ByEbVDg8ZcFjySOg1HetrgTM3cvT2FlXuirxYtC3QDsxVZjMbT/IfO2a
    KgfQ7u0Cc+SWIBp1jfS+7nLgADrnnEwsFg+B5Fmf7CcbKpIDbVoFX17sbdlg
X-ME-Proxy: <xmx:9z3baqkX-TfdGYOgfoTmSRdNqnO2J_kmsxDMDdF9VU4Tm7zxj4qFmw>
    <xmx:9z3baqY95VpbZt8w-QSYTPgo3eFDr7etRJs1xLepJxbuRSjxahw6Aw>
    <xmx:9z3bavsHAA-TFsQz13dPgtWTDmrCGc3FoJ5NHTb5RX8Sm9X002CyOA>
    <xmx:9z3bajpFZoxPX6SsvI8uBTyjgv8nBtH-4xkm58Ok9I6KYHWnCZDgnQ>
    <xmx:9z3bapmrYkD4lXGoqMsluOX2WMGITXGxk5jDLk_w9sg3xDmZVxEybPgG>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 06:59:02 -0400 (EDT)
Date: Fri, 23 Oct 2026 11:59:01 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <ats7oFM-fsYdUS8y@thinkstation>
References: <20261009125503.126202-1-kas@kernel.org>
 <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation>
 <20261014202936.GC371161@cmpxchg.org>
 <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>
 <atDMN5MoGrwJNpAj@thinkstation>
 <4aa14b41-9b89-494c-8825-55fffd5a541c@arm.com>
 <atiCG2iPrHwDznSZ@thinkstation>
 <d2b8edf0-39ab-4a44-bd0d-58230dee2fad@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b8edf0-39ab-4a44-bd0d-58230dee2fad@arm.com>

On Fri, Oct 23, 2026 at 12:09:07PM +0530, Dev Jain wrote:
> >> I ran a synthetic benchmark faulting in lots of 64k mTHP with swap enabled,
> >> defrag mode caused me to enter a warn_alloc (and 8 times more compact_stalls),
> >> which didn't happen without defrag.

Thanks for the benchmark. It reproduces on x86 in the same shape.

I think I found the problem.

Under pressure, the free order-4+ pages left are mostly in partly used
unmovable and reclaimable pageblocks. A movable request with
ALLOC_NOFRAGMENT cannot take them. But compaction_suit_allocation_order()
asks __zone_watermark_ok(), which counts free pages of every
migratetype, and returns COMPACT_SUCCESS without compacting anything.
The allocation then fails, and since compaction "succeeded", it is never
deferred.

With the diff below, compaction behaves the same with and without
defrag_mode. Medians of 15 runs of "compact-bench 99 64 16 20 0":

                             defrag_mode=0  defrag_mode=1  defrag_mode=1
                                                           + diff
    compact_stall                    2135          32476          2290
    compact_fail                      668          32330           606
    64K anon_fault_alloc            20689           6780         11804
    64K anon_fault_fallback           776          14502          9687

64K allocation is still lower with defrag_mode. I will look into this
further.

Could you try the diff on your setup?

diff --git a/mm/compaction.c b/mm/compaction.c
index a049415512c6..09be677fff36 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2365,6 +2365,10 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 			!free_area_empty(area, MIGRATE_CMA))
 			return COMPACT_SUCCESS;
 #endif
+		/* Under ALLOC_NOFRAGMENT it may only claim a whole block */
+		if ((cc->alloc_flags & ALLOC_NOFRAGMENT) && order < pageblock_order)
+			continue;
+
 		/*
 		 * Job done if allocation would steal freepages from
 		 * other migratetype buddy lists.
@@ -2510,6 +2514,43 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	return false;
 }
 
+/*
+ * The watermark check counts free pages of every migratetype.  Under
+ * ALLOC_NOFRAGMENT, a request below pageblock_order cannot take a page from a
+ * block of another migratetype unless it claims the whole block, so look for
+ * a free page the request can actually use.
+ */
+static bool compaction_free_page_usable(struct zone *zone, unsigned int order,
+					int migratetype, unsigned int alloc_flags)
+{
+	unsigned int o;
+	int mt;
+
+	if (!(alloc_flags & ALLOC_NOFRAGMENT) || order >= pageblock_order)
+		return true;
+
+	for (o = order; o < NR_PAGE_ORDERS; o++) {
+		struct free_area *area = &zone->free_area[o];
+
+		if (!free_area_empty(area, migratetype))
+			return true;
+#ifdef CONFIG_CMA
+		if ((alloc_flags & ALLOC_CMA) &&
+		    !free_area_empty(area, MIGRATE_CMA))
+			return true;
+#endif
+		/* From pageblock_order up, a free block can be claimed */
+		if (o < pageblock_order)
+			continue;
+		for (mt = 0; mt < MIGRATE_PCPTYPES; mt++) {
+			if (!free_area_empty(area, mt))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 /*
  * Should we do compaction for target allocation order.
  * Return COMPACT_SUCCESS if allocation for target order can be already
@@ -2520,7 +2561,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 static enum compact_result
 compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 				 int highest_zoneidx, unsigned int alloc_flags,
-				 bool async, bool kcompactd)
+				 int migratetype, bool async, bool kcompactd)
 {
 	unsigned long free_pages;
 	unsigned long watermark;
@@ -2532,7 +2573,8 @@ compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 
 	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 	if (__zone_watermark_ok(zone, order, watermark, highest_zoneidx,
-				alloc_flags, free_pages))
+				alloc_flags, free_pages) &&
+	    compaction_free_page_usable(zone, order, migratetype, alloc_flags))
 		return COMPACT_SUCCESS;
 
 	/*
@@ -2588,6 +2630,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		ret = compaction_suit_allocation_order(cc->zone, cc->order,
 						       cc->highest_zoneidx,
 						       cc->alloc_flags,
+						       cc->migratetype,
 						       cc->mode == MIGRATE_ASYNC,
 						       !cc->direct_compaction);
 		if (ret != COMPACT_CONTINUE)
@@ -3073,7 +3116,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 		ret = compaction_suit_allocation_order(zone,
 				pgdat->kcompactd_max_order,
 				highest_zoneidx, alloc_flags,
-				false, true);
+				MIGRATE_MOVABLE, false, true);
 		if (ret == COMPACT_CONTINUE)
 			return true;
 	}
@@ -3116,7 +3159,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 
 		ret = compaction_suit_allocation_order(zone,
 				cc.order, zoneid, cc.alloc_flags,
-				false, true);
+				MIGRATE_MOVABLE, false, true);
 		if (ret != COMPACT_CONTINUE)
 			continue;
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
