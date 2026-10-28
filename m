Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207851;
	b=eIZuNEEWzhN9ShVQZmat2ANgdn9BmvzXshnsUfEO/h+69sLYtFG3jETbmRmKT3ujudXM
	 VX7tBOENR+2KZVdAjgdUuhs8UY1JEvqA+fMvwUtcGNPXoMObrXJiwQhn0lp6e8IhfKjSN
	 UM9FfUJju16Mo+ygEE8zf3+h531TRPhCPTMWIvIBFsbBrSFwUp4P7aSMfDRimc5fZIGvw
	 pne2w7sM8/XujVAC3z4aG42KSvD3LJIDegLWcaNMsuQLnnz7+aoxR26SeMhx35szEo1oD
	 HVUEkyROLG/n18qW6HYg6FKt6MweQLqJCBZMNq63+13WBh3DBko48Ut1qauSEkUkSmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YJiZZYGUYOh8zA+NsUNeXjoG3ihKbYj9buhXSzinHms=;
	b=dOFE6LU5UB7F0Kz7ZD1TvESnVKOO/DcHIbqd3MxqhxPkGZq8VERozEo+wpPunqjfrsr3
	 96/35/ihp1cCW0cd8+ZnvZElRphpNqV55ovcri5S3y80r1ludzkiWZltWzYso+6UdpMJy
	 WcLG2OqbhcJRfIWkY+jsBj4R1WgT4oftc1rlpti0SfZknBhNuFPhBdjTodpTW7DaO6t3C
	 Z4rF7bOvFF20FpX/YNscsKLdefiMyIujS7M8Wd6NDIaBc1akBxF4wtRDC/eJhhd2cgdj/
	 VNfgx6FSL7RmrJfuzA42s8ANkrwTanpMuuIzX9OHdZK6WJlk3c4nqqt05jX9pgJipXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=nJBZ3NdD;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A3606A326
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A4A3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=nJBZ3NdD
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8aea7b7ca0cso10214697b3.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793207849; x=1793812649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJiZZYGUYOh8zA+NsUNeXjoG3ihKbYj9buhXSzinHms=;
        b=nJBZ3NdD8NwQYO+4L14dOulGF7vs2dg0OeKUTZd7V54b0lTBAJN+AwciszMl3aJVOg
         TXjY/NR/YOh1j8DdLKBOUWtVzbOS7dhfi+vOL71phrJSUe+p9cIPu+Cb/Yx9Ljb72Ek9
         qdGFzxfFAwfOuAKnSfG84ISjR3s9gRhzmZ8xFAIj/1eueCW3MmmM8Cj7gYjsJEKRSRnq
         mTPpaMW4zVbcdcNW2TKlbYW20V0nd0YA/9Qx5f/ISXew+Uzw5LVfSNqpmJJTeEuPBHDc
         1Hs+/Pq34K0GWKbqDJobP+T3HMYx5N7a2gLQp/fTJ18DRRuKO7sX/ALTyZqviqljMFKH
         69Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207849; x=1793812649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJiZZYGUYOh8zA+NsUNeXjoG3ihKbYj9buhXSzinHms=;
        b=w+sqNPWiDV3gPvDhDvVgRVrBx8NVX4CEoiCEdPoX+a5uRCthL4+tmi/UqZ7gCiMrEg
         1sWYAbH7+ayJJs5AYp+TYiIuPbEk9HST9i7n9j3WlDRnZmJMrEF8wbIbZ1DRXu4iRoRd
         5h+BgUKsT+qcAqMyavlsH8HVGk4s6zFJi22Qw0xNeYf+3t0prokIZgnEsBCWe7Rhxdq+
         8Q/dwip1eLDHTfq7bZzHYCvxEvsZXq970mQPHfXSQ68c8oGoDX6z5fE/PwTWy5UbwT75
         x/KG9Ewj9+qibIayj+957NQTf73yOqLAaCBp7cYbBcv52OQisgFYs/1PprkPETq27VCH
         ExCw==
X-Forwarded-Encrypted: i=1; AKwUvByhBsdKTjD6Rd0DP4K9lVwAoTkWF+H/OkuOlkf+TSeSRjvcktF7uQAEAJFlF9Tt4wt9SUcTnh8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyTKc/pX34EN0Mu7kJ5AHHBJ/uEaWSBC7MKBtBReM0dIav2VBy
	leW0WhgUm6UIGx4PCCNRH2wbkC3HwvdcVlRQMqBwg1nXEjucSLL2VSmqQKf6ukYe3hc=
X-Gm-Gg: AYBFou0n5UPeYOIZggmhF77rCqWFsUGIFcMzbonEcAMHz5KyIIm9orvrCgZAvTNQjRM
	aP8yWsyz52wmgbEEM6VSgCE+vAUMkhZbr0NOcdTTCO9mNNRsvRYORWJlWSUD9xLPKoVUJq0H+kk
	C9QJKRotdJz++MmD/ScrG9cx+RcukpeRDDvpQvGDh1gQHIk3XWEJTHloyr2vRqlteXjBKPXPlj4
	l854KOVlsqMrPwOB05Yd4Iq3vmVqHecib66z3h2KKpj6tbDNLITRFFhoMEHOwbgQua+aUzMholC
	6Lzi6+kckGruhxSydgd/DR3g6IyIpsxuZSE6ZsSCcBLoiNTPAW1Bm3fUnTFRTIzr/mBU8VtsG0n
	XAKKgthBYK92t/3tDHotXmgGPpdfpGqRtkXlPzKGJZEin0SJE9XYrGTYduZmqDT7IWGrEOjs6wn
	+YPie0f/vCaY1Agph5KDl0mxEoSdxkQfi6G6YVmxmJNtDBSzA3gT29W2XgKd+76e5750btGtbez
	GF5XfY8dffFU05ROjKrM8GzQ7kTbKvEKes3T+kL41r8N57VJ90EySWtOtSeJHlJtnfnYc21HLcC
	itrWorYRcEDq19SAu78zEw9xo9CK
X-Received: by 2002:a05:690c:930c:20b0:881:a45f:9006 with SMTP id 00721157ae682-8b1b5bd657emr15463867b3.32.1793207849119;
        Wed, 28 Oct 2026 10:17:29 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e609932sm31617307b3.35.2026.10.28.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:17:28 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Salvatore Dipietro <dipiets@amazon.it>,
	Christoph Hellwig <hch@lst.de>,
	Dave Chinner <dgc@kernel.org>,
	Matt Fleming <matt@readmodwrite.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm: page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES
Date: Wed, 28 Oct 2026 13:15:54 -0400
Message-ID: <20261028171719.2043421-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028171719.2043421-1-hannes@cmpxchg.org>
References: <20261028171719.2043421-1-hannes@cmpxchg.org>
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

1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
non-blocking allocations accesses reserves") stopped handing out
reserve access for ALLOC_NON_BLOCK on its own: the extra 25% below the
min watermark is now only granted on top of ALLOC_MIN_RESERVE. But the
flag was left in ALLOC_RESERVES, which produces something odd:

With the ALLOC_RESERVES match, __zone_watermark_unusable_free() doesn't
subtract the free highatomic pages for them. So in the slowpath, they
get to consume regular blocks below the min watermark by the number of
free highatomic pages. The highatomic reserve is capped at 1% of the
zone, which on any decently sized machine is a multiple of the min
watermark: GFP_NOWAIT can drain regular memory to zero.

The user-visible result is brutal hiccups during bursts of GFP_NOWAIT
allocations under memory pressure. This was found in review and
reproduced with a synthetic burst, not observed in production, but the
sequence of events is a realistic one: On a 32G box with an anonymous
working set, swap, and a filled 290M highatomic reserve, a GFP_NOWAIT
burst drove regular free memory in the 28G Normal zone (min=60M) to
28M, 0.8M and 0.6M in three runs. Swapout failed to allocate its swap
table, reclaim scanned 13M pages to reclaim 200k, page faults stalled
for tens to hundreds of milliseconds. The machine survives it, but not
by design: direct reclaimers eventually fail and start unreserving
highatomic blocks, until the allocation succeeds or the reserve is
gone and the OOM killer runs. That reserve exists for high-order
atomic allocations; here it is destroyed to bail out a GFP_NOWAIT
consumer that was never entitled to the memory.

Remove ALLOC_NON_BLOCK from ALLOC_RESERVES. With that, the GFP_NOWAIT
burst is stopped short at the min watermark. No direct reclaim, no
stalls, no failed allocations, and the highatomic reserve stays intact
for the requests it exists for.

__zone_watermark_ok() is unaffected, since everything it keys on
ALLOC_NON_BLOCK is already nested under ALLOC_MIN_RESERVE. Update the
flag comments accordingly: ALLOC_NON_BLOCK just means the caller can't
block; the reserve math belongs with ALLOC_MIN_RESERVE.

GFP_ATOMIC order-0 requests have a milder version of the same problem.
Through ALLOC_MIN_RESERVE they also count the free highatomic pages in
their watermark check, but rmqueue_buddy() serves them regular pages
first and only falls back to the reserve once those are gone. They can
still push regular free memory to 37.5% of min minus the free
highatomic pages before the reserve is touched. Unlike GFP_NOWAIT they
are entitled to the reserve, so this needs the watermark check and the
freelist order reworked together, and is left to a separate patch.

Fixes: 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 9c3c2830acb0..7097ea1805f6 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -32,12 +32,11 @@
 #define ALLOC_OOM		ALLOC_NO_WATERMARKS
 #endif
 
-#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
-				       * to 25% of the min watermark or
-				       * 62.5% if __GFP_HIGH is set.
-				       */
+#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. */
 #define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
-				       * of the min watermark.
+				       * of the min watermark, or 62.5% if
+				       * the caller cannot block either
+				       * (ALLOC_NON_BLOCK).
 				       */
 #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
 #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
@@ -58,7 +57,7 @@
 #define ALLOC_NO_CODETAG       0x1000
 
 /* Flags that allow allocations below the min watermark. */
-#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
+#define ALLOC_RESERVES (ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
 /* Flags that mean GFP_ATOMIC */
 #define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
-- 
2.56.0

