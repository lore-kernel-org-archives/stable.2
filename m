Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430634;
	b=gW0+khcafhkkRZcQL77VOej8heqiecWtEI0HvYWtw9X8oWyGAIF6t+39hRKgTdyvbDAF
	 Lk8j1NrwIyLCd0mEjaX14ePPDiP6oRwI0IPqC25NuerzgiFoiap2aedNyUry6vFWwzV+s
	 N+fhEkI6rREZHW9LZvpMLrnucE1JXa/gE5tVe5AFh1jzmkKzwYur/Yot9m0VwEKVfOiPG
	 HIpP7g8LOb7fEvZPtiTUVtDa8Ef00E429CY1sSfQ+t0QRijzzgnnXo+2TGMbpzRX01hlo
	 8TGPlREtLFvxEdtzIEtlPep3moY1aMeLbjCJcMOeT5GJ64Al/Q46UohlBa/f2/pBKeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ykp4/R1v56ikD31+YWezPL+y1PopNUKQZFoNf3vFuBU=;
	b=gotkCO6TLYXCwzYO1a0yMkog8kptY3439TpHCl/q+Bx/pWHyQXJvTiUrxAxusfsLneT2
	 3cytMOjAgfbLHaVCf9RLCEA6ve83NVatuBdXc26JmvTzhpp3W4fQc2cdlLgq2SWFViA0f
	 UdZWLZQGv2MwkEOFdWfG2xzej+W8tFGv4U/BKUq8LgvboP7xdbPY4nG6KTP6qMtqdCopi
	 RsEUTSOShJxF7BKwGfk30xvmnY3ckeLAjSU05A5FcsQDF7n1uWelhiBbhCEDkkUSHq3Na
	 6WHZjakxmdVndt1htt6uUBrwCS1Y3i13NsTjT1E/D44gt5FO0Rr9gB99lIWjY/4beUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=IJpixvff;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29D606A322
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA29D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=IJpixvff
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f22a8515eso223095885a.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792430633; x=1793035433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ykp4/R1v56ikD31+YWezPL+y1PopNUKQZFoNf3vFuBU=;
        b=IJpixvff4in9lSpOW0FjhHULAGZlaxLLwi3T+3Ac6Wg1yxpt6NUmArJgfqS6EkHG4k
         Tl+0anSJ0lQVT7Fg/OtDRvFaOjjKLdx6ttZp/KKUenmEq1Gx5IR9/B0ndtFEED4xaHDJ
         i0TqdhDNjJxg/oEA/BvBqPdzrrBnF/95b8rdeCR+pJMSQQnZIzscS12YPsF7UP7rfe7b
         0NVqqqDdSlzvFcNkhxuTBEtG0tfucr+2Q3mnmEwGOlXMfaixidPVALU1x7anuaDWAafL
         HAjtsAXUpjOCec2u8hyDOvoAbF86wsDRP7UopxFm3Yf90570OOODNyqdz0fVg0hbceRk
         u6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430633; x=1793035433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ykp4/R1v56ikD31+YWezPL+y1PopNUKQZFoNf3vFuBU=;
        b=qvMEHAT9j12YbzaVLCVZGTE4JkUCpSqdF5Eau1Fm7U1KOfIJrXFGOdHRRwwu68XBRq
         /kLhe32cMrFQHThoAtq5o51BIfwvss77JrqhcHi8zxIjXuncY/LibXVHgcxrb7vLAJK6
         +ZkejAjIuh7L8rcVenVCU6iea7xFtldRINEJCR+6YHmOmsPdiiq4JZJk7yL+SuhfkMzr
         vTl1AcvdyDf8fOfF3LNadaWVXKNwg+Rzlq4YZb86FICeq8WN+Pmw/BugznQQJlde6jZ1
         6SGblOwVKxJnpQj+wn6njxxgRehoJIkDJdJ0tqiEmqQJE3O9TyJeF47/jmcrtL0DNK50
         apGg==
X-Forwarded-Encrypted: i=1; AKwUvBw2mlVrwOq0eqhQo7Syy1J56VX4SBuGloLS4OQYWUcTcL8ACYnlZOAnRwoQEFvfJfa/cPMIt38=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKYFercs2dG1wPZC6Fauo74FX4HDl9X/V8JoebpsZH1PNb4QWR
	w0v4MWp/g2JDuegIEgTpgQKfv0Pnrbd1W3TjIIoXcXsNp1WEtRdOYMTai3T76mvLhEg=
X-Gm-Gg: AYBFou1Ki/5e60IVnWv7SXObR6uH/5JFr7UblollAoj0VVFZCKlrSFUXazEY3dpbrKQ
	Z1qEr+zx3WuYkzJn8d//dtagmxdxdqWCDwgsl5S150QNgv1xKVCfERNTCPWAurn5zVyzfoHIztS
	dSL/gy4cek0M5WizV1IetgZXtg+leiI5gXuYDnYToFyY3LF1MMSSUiMzA8sOPySh3dVGj246g75
	inyDCjM6eOUtR4T1DJWpnncVqlDxQ+vMn3NJ28ht7hfj16YrE0JOwbOcfpjccao5MLiP1mbERgK
	kuIwAwhMVuUDfbk77JhnMG8fG4Z7Eg4bt5T2kLp1e/tThoqcirXZQhVOTJxgC5eSCA7MBdvNKqq
	BP4YZMws5a1HHgwOFjEu+ftjbxDrfqCI3lmtQ68ad71HB1sq6wI4JGrbomGgE4+h9RLiJZFVTsF
	1GkioKraOduTF/bHx7o9EvL8PsyxYvECIb38PA+Ok9DSUN6QO+sZyDizyLo9j9CpfBqs+PYoc14
	MBmDsah0feDJ0dZonK5wg31zE099wCClM5+/zyS3U5jhiwCyHpzKTWLtuNO
X-Received: by 2002:a05:620a:2783:b0:93e:d051:8f19 with SMTP id af79cd13be357-93f29ced575mr1321775885a.40.1792430632885;
        Mon, 19 Oct 2026 10:23:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4adb28c2sm14615385a.0.2026.10.19.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:23:52 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	mgorman@techsingularity.net,
	jiang.liu@huawei.com,
	Bessel.Wang@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] mm/page_alloc: validate zonelist slots against concurrent rebuilds
Date: Mon, 19 Oct 2026 13:23:42 -0400
Message-ID: <20261019172346.3344005-3-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019172346.3344005-1-gourry@gourry.net>
References: <20261019172346.3344005-1-gourry@gourry.net>
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
shifting the slots after the new zone. An in-flight walk can use a
zone it previously filtered. e.g.:
  - a GFP_KERNEL request can land in ZONE_MOVABLE,
  - a node not in the nodemask can have its zones selected.

With kprobes holding the walk across the online, I was able to get this
zone/node misplacement to happen consistently across hotplug events.

The iterator approves a slot by its zone index and node, and the
allocator then loads the zone pointer from the slot again:

  CPU 0                             CPU 1
  first_zones_zonelist(nodemask {1})
    slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1, NORMAL2, ...]
                                        -> [MOVABLE1, NORMAL1, ...]
  get_page_from_freelist()
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */

Every later step of the walk filters and loads the same way, so a slot
approved for one node can also hold another node's zone by that time.

Recheck the loaded zone against highest_zoneidx and the nodemask in both
allocator loops, and skip it on a mismatch. Hot-add only inserts zones,
so the zone that was in a skipped slot is still ahead in the walk, and a
walk that runs off the end meanwhile is retried by the zonelist seq-check.

The recheck adds about a dozen instructions per zone visited. The two
fields it reads share a cacheline with zone->per_cpu_pageset, which the
pcp allocation path loads anyway.

Fixes: c33d6c06f60f7 ("mm, page_alloc: avoid looking up the first zone in a zonelist twice")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c7125f6693574..aa3cd44fdaa5b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3784,6 +3784,19 @@ static inline unsigned int alloc_flags_cma(gfp_t gfp_mask)
 	return ALLOC_DEFAULT;
 }
 
+/*
+ * The zonelist can be rebuilt in place while it is walked, so the iterator's
+ * filters may have passed a slot that now holds a different zone. Recheck the
+ * zone itself.
+ */
+static inline bool zonelist_zone_valid(struct zone *zone,
+				       const struct alloc_context *ac)
+{
+	if (zone_idx(zone) > ac->highest_zoneidx)
+		return false;
+	return !ac->nodemask || node_isset(zone_to_nid(zone), *ac->nodemask);
+}
+
 /*
  * get_page_from_freelist goes through the zonelist trying to allocate
  * a page.
@@ -3812,6 +3825,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		struct page *page;
 		unsigned long mark;
 
+		if (unlikely(!zonelist_zone_valid(zone, ac)))
+			continue;
+
 		if (cpusets_enabled() &&
 			(alloc_flags & ALLOC_CPUSET) &&
 			!__cpuset_zone_allowed(zone, gfp_mask))
@@ -5236,6 +5252,9 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
 		unsigned long mark;
 
+		if (unlikely(!zonelist_zone_valid(zone, &ac)))
+			continue;
+
 		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
 		    !__cpuset_zone_allowed(zone, gfp)) {
 			continue;
-- 
2.53.0-Meta

