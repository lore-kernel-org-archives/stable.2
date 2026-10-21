Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550398;
	b=11rYDI3BZ8KZ482otEc0IRNHGdZZpeD1NQ/tLFkqXd5shd00yMKvAklI7QfCA1lWj7Ot
	 B0OEyYz74CFnnTSlWDhBtBOmBCHndDbn/tFvXYewKMxfYdzBes5209AfFPa4BoMXqONW3
	 NVnR8YWy0wOvP8mwpAvQx8/YyXmVo40IJhPAmAj0dzJLiU15EInnWa4Gb/gQQl50JqpPJ
	 fcAZcVnS+j1jrSbmZBDegRZSlwDxEtxJqfiCIMhPqxaB4kcCnEvHuDe3TcLlAM/VGr9Le
	 1h6Hhq6msfE02MkVmBCx01GJ33n9TCS3C7TglPiLrJjZ+5bBms2ZRzcg6EQiD3V3dlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Pvfl7DviDeBHS//72/Hi95KkgY+0Xu5/rbujyfFHLK0=;
	b=nsG4iNicV2oQ0wdQfmV6q3VovCYEJfLduH7mug51/g+UVWvzmmv3ufd2MYoui4llwicc
	 L1YvFdnpj7d/AZMyWV/0I5OjWiejHZqwzyLsH29ZQ8/CZA+rJ61r13kYyzz4mgK7x17dK
	 8ZpOCtuAIeycgdaibCEeKMbJ1xxKTgkod8XCfO71N5qk7QcyOAkCUwIeu7h53yIMSWqkN
	 Ha++WMQh2b3BKpE8wsNFNPuuyLPPTkbQklgi07map5JZ3QEjITd8FA5xcDGmcf0mvs7LZ
	 wIDaGCohlD14XpDbjc0BxvS5uhEqAo8h9X5Fbn148cp/D+2JKFx/uUfPMLzSGlD0ipg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="F/iNkFBi";
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787060A2604
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0787060A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=F/iNkFBi
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ba702cceaso3425566d6.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550397; x=1793155197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pvfl7DviDeBHS//72/Hi95KkgY+0Xu5/rbujyfFHLK0=;
        b=F/iNkFBirVBfnEafRXRu2OPVpKI7JLXjC30Y+cUA9A3n3yEkVflguQZF1gE6lRAn2k
         GOEWdaKODhaYPg432iFYEIGdsEk8Xatu7sp4ximEmgCcPgRMgcBDV+gvy+scaf8JY/0B
         OzRjY2LqWYHF79W/19hzAFpn1YaMszY8HnBPspNTehrxQ0aFZvVjI3pKBA6xEcDk2gTi
         si4VT1SdZdUFCOe3uLnxH3SXIjhcL2rqWwijdL3gxx+4UnxBvu/AXv6Jtm65keyzQwmY
         x4Qlp7VPSOWaMtixpJLa3iU2ssaHz4FcIeC31LKws18BR9zYzNaBu/sfIjeBcr2knfYK
         mywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550397; x=1793155197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pvfl7DviDeBHS//72/Hi95KkgY+0Xu5/rbujyfFHLK0=;
        b=TMiYWZrbnLx6pDe+Nyh/pEvMWx5zjyuKZCzd0GBFJ//XXk+c3xfvoFuzFpspW5VO8L
         +kABU/R6f1L2AQ/esRJsKnREeNNndtzfVmPjLmRLI0OVxYAXhLHmPFAH5AXrsBEl4oRA
         iSst2Sg8WGlACXhPmVrgfFdQTINAXEWGZ8HCuKEFklDFaQ1iA0pYotcIX/+PhF8x9ki/
         1h9C1j5HvRO2ic6ZbPFJQLbvp+tCBPvmq7t1bXz91ER5MExcPh9/pU+Kl5PYw8Tqq3oV
         1aChW+MM4jdm8f8Isop2/oVvjsYKQWUCaTPPq0sMqJ5TzcY+umlp68ab+s6AtN9WrD4I
         w5bw==
X-Forwarded-Encrypted: i=1; AKwUvBwh8bpXfkQl7IiDtPUTKrtfNYfjMMFGZpWZmiOnLdcS2mw9T11ft1c3XHh9CwJGKEadvAYSY+Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnvtDmfoC3txQrPg9Qoer7yWNymeBpGTI+1caQwsmcIsNtsDex
	R0BLSFq1JEJnnMc5xQssCu06FL68K1kGKDGTlGAuRCA3gVizw+TtWPz6q8Lg6PAowDw=
X-Gm-Gg: AYBFou1SWsFnKxqGTJnmqVBGbKsMr/k+ArjpSPNyBD3otiM4Eb4dmxkgJUG80hlR9Nw
	STzua9XYIc+/tzR9lvC9eGmAUz/Tgdg16XzK30N0/S6/kNtiUVOqFYuuwUa/5XJ4QgWkJ0LDwi/
	fPFEDL4dVdTFD+G60s/3ESYrBM5rR+28NmrrGgV3JbGw5EEFtjBlIglTIwc+VwUtITi0OjpVnD5
	fPB4/KI5zAkLmJLbLolwK9GYlLxeemfuZyZbcNL8jLd6FMBuaYxaxZz3bAdHqVFiJkBQgScQuz8
	NW2q6IV2TFuRacZE5gLq0eTjqBdM0nlGJfyPQjOk5TY9xwLcy4Z+gtEgwi5tiFgto7YALx5Vrv6
	hhCdtVHsB9VXnb6kGvfmRcWkkMlnC7Gih0r6KUe1Ib5DPd3Gblhp1fbuWvX0dvxKKd12na51gYZ
	ikOuPaEbntgxi5DGiZRe97gLgG+EvH96LvMrTXNIJQExuo5iMuimur2k+DF2OKn/9mFnIBUi+Z3
	W5OfLLntdjnDa2zmNr8Y3RBONl1eaW7kNKVjXNfnlO31BVE+uwkba+1hcQDwKT0aoq2XS8toDzM
	QnMJ4eZSJ2xpXHaWYZzrwE24SjKnx5TSFAoWxj/DYv/xJwMhE4Vdm54X0V0yvIc=
X-Received: by 2002:a05:6214:300c:b0:915:eacb:cb90 with SMTP id 6a1803df08f44-91c12dfef37mr14292296d6.5.1792550397043;
        Tue, 20 Oct 2026 19:39:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:56 -0700 (PDT)
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
Subject: [PATCH v3 7/8] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Tue, 20 Oct 2026 22:39:39 -0400
Message-ID: <20261021023940.1940971-8-gourry@gourry.net>
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
shifting the slots after the new zone. alloc_contig_pages() can then
take a range from a zone or node its filters rejected.

Writing 1 to a node's 1G nr_hugepages while that node's first
ZONE_MOVABLE block comes online puts the gigantic page in ZONE_MOVABLE,
which commit 79b63f12abcb ("mm, hugetlb: do not allocate non-migrateable
gigantic pages from movable zones") excludes.

alloc_contig_frozen_pages_noprof() walks the zonelist with the caller's
gfp and nodemask, and the iterator approves a slot before the walk loads
the zone from it:

  CPU 0                             CPU 1
  alloc_contig_frozen_pages_noprof(GFP_HIGHUSER | __GFP_THISNODE)
    slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1]
                                        -> [MOVABLE1, NORMAL1]
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    alloc_contig_frozen_range(MOVABLE1 pfns)

Check zonelist_update_seq before using each zone the walk returns, and
on the way out with nothing found, and restart the walk if it changed,
as the hugetlb pool walk does.

With kprobes holding the walk across the online, the base kernel put the
1G page in ZONE_MOVABLE in 3 of 3 runs, and this change put it in
ZONE_NORMAL in 3 of 3.

Calling alloc_contig_pages() directly, GFP_KERNEL with nodemask {1} got
a ZONE_MOVABLE range and nodemask {2} a node 1 range in 3 of 3 runs
each, and neither did with this change.

Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5ca8e57c5fcbf..96ae09c8099be 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7592,6 +7592,7 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
+	unsigned int zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
@@ -7600,8 +7601,13 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 
 retry:
 	zonelist = node_zonelist(nid, gfp_mask);
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
+		/* A rebuild may have shifted an ineligible zone into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry;
+
 		spin_lock_irqsave(&zone->lock, flags);
 
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
@@ -7640,6 +7646,8 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 		skip_hugetlb = false;
 		goto retry;
 	}
+	if (unlikely(check_retry_zonelist(zonelist_cookie)))
+		goto retry;
 	return NULL;
 }
 EXPORT_SYMBOL(alloc_contig_frozen_pages_noprof);
-- 
2.53.0-Meta

