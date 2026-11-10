Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273744;
	b=zaF3auEiXqhQK28+YdcISDH/DCr5cna6hfhjtC9r+v5BP90mFtSNhIXQNMCwjm7P4Sn5
	 f3+yV4UK6c9TPVhQVOCCTSKLyZ5lF0LC+nPU4CKYCI1XBN+HE+e/qGgaU+AsaPSpNHsSG
	 AjF08XY4VYPSLvAR8QpcQNTZ7ZuZvhbI1IUc3Xw7L/sPUuhivTPGEKuZjVFNtQI1Rp/Wr
	 No/sc34AlV39y7zIgn5CjbD5tdaz0Dy9HRVHFBrXFuW6rRxBi6QfNxM6HZUqwUhucSlL2
	 UF/nP9rStUPiDvUsis+sk3vAiuMP9XwoZjVAslqJfmi2PccEClNO+NldQYXfbgzQpDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273744;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=id6SzVsPfMDFN1VchH+QQvllbnSN1ikNfZcrABKsEAU=;
	b=QN/NYj5+kOOSguE5fWBr9JKwWMtZN+ocXB6hV3z+xH7AZ4yGJWXeULFn1zeyj2tQVtAa
	 0EhlFnroOWwlIzgosFth4vC4PsfXGeVFJwW5P6Vg4neeUabZLGeWu2pxdgy3uymy2sucd
	 nnaRl6nqHDh//28NmrkTZcNNM3VML9DrS/pqVdeGLzYy5mpRqvbVm6JGn6wdEoXKVKxXO
	 Hj/yTnec927MzZsvIVFLKjKXsRZPdxcTT/MvCC6z+mXqNzVCC4n3D6EOySjj73DlLd+F3
	 apgf6tjcb4M5KbrbvaMFH0GgpGPlw+udkgah1GRI8e/ePTlT1vTLgWzuehzW9xpowEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSWqU0oU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB7606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSWqU0oU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA601F008A2;
	Tue, 10 Nov 2026 01:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273743;
	bh=id6SzVsPfMDFN1VchH+QQvllbnSN1ikNfZcrABKsEAU=;
	h=From:To:Cc:Subject:Date;
	b=lSWqU0oUGJu0o7XPZfWGedkpkin+JUVR9Jt7d5BpWDPoKc9QryIhgkwZZBnQdztUD
	 3s5kF++aMmNlF7F5pWT8Bb6OHL4RsEwMEQzLj/A5By8gBqPHx+bt+b7haq5f1OudJg
	 Z1SWw9/Q1Jk4Bk6dOvT+HSkb74MbA8B58hVTc1OJqUZPm7t81JBe81Pll90hANKSzX
	 BlRIGYjmmZLARETP/EMb/Mbil9C9Q0gPyoZxkJR/2tHi+f5dZxmHpKKnbx5S3purl8
	 17shFvS9AmTOEAFxrnpo+/4MlClMO0BFKOMwrHvsUFTHg4JA1o+6iAcwfsdUwexKPh
	 mnvutHkimnT2Q==
From: Sasha Levin <sashal@kernel.org>
To: hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	balbirs@nvidia.com,
	vbabka@kernel.org,
	willy@infradead.org,
	dipiets@amazon.it,
	hch@lst.de,
	dgc@kernel.org,
	matt@readmodwrite.com,
	mgorman@techsingularity.net,
	mhocko@suse.com,
	surenb@google.com,
	brendan.jackman@linux.dev,
	ziy@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:20 -0500
Message-ID: <20261109202220-failed-5.15-fe21f930d1e6@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fe21f930d1e64d121191673076fc4ebe79fc82d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202220-failed-5.15-fe21f930d1e6@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fe21f930d1e64d121191673076fc4ebe79fc82d5 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 28 Oct 2026 13:15:54 -0400
Subject: [PATCH] mm: page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES

1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
non-blocking allocations accesses reserves") stopped handing out reserve
access for ALLOC_NON_BLOCK on its own: the extra 25% below the min
watermark is now only granted on top of ALLOC_MIN_RESERVE.  But the flag
was left in ALLOC_RESERVES, which produces something odd:

With the ALLOC_RESERVES match, __zone_watermark_unusable_free() doesn't
subtract the free highatomic pages for them.  So in the slowpath, they get
to consume regular blocks below the min watermark by the number of free
highatomic pages.  The highatomic reserve is capped at 1% of the zone,
which on any decently sized machine is a multiple of the min watermark:
GFP_NOWAIT can drain regular memory to zero.

The user-visible result is brutal hiccups during bursts of GFP_NOWAIT
allocations under memory pressure.  This was found in review and
reproduced with a synthetic burst, not observed in production, but the
sequence of events is a realistic one: On a 32G box with an anonymous
working set, swap, and a filled 290M highatomic reserve, a GFP_NOWAIT
burst drove regular free memory in the 28G Normal zone (min=60M) to 28M,
0.8M and 0.6M in three runs.  Swapout failed to allocate its swap table,
reclaim scanned 13M pages to reclaim 200k, page faults stalled for tens to
hundreds of milliseconds.  The machine survives it, but not by design:
direct reclaimers eventually fail and start unreserving highatomic blocks,
until the allocation succeeds or the reserve is gone and the OOM killer
runs.  That reserve exists for high-order atomic allocations; here it is
destroyed to bail out a GFP_NOWAIT consumer that was never entitled to the
memory.

Remove ALLOC_NON_BLOCK from ALLOC_RESERVES.  With that, the GFP_NOWAIT
burst is stopped short at the min watermark.  No direct reclaim, no
stalls, no failed allocations, and the highatomic reserve stays intact for
the requests it exists for.

__zone_watermark_ok() is unaffected, since everything it keys on
ALLOC_NON_BLOCK is already nested under ALLOC_MIN_RESERVE.  Update the
flag comments accordingly: ALLOC_NON_BLOCK just means the caller can't
block; the reserve math belongs with ALLOC_MIN_RESERVE.

GFP_ATOMIC order-0 requests have a milder version of the same problem.
Through ALLOC_MIN_RESERVE they also count the free highatomic pages in
their watermark check, but rmqueue_buddy() serves them regular pages first
and only falls back to the reserve once those are gone.  They can still
push regular free memory to 37.5% of min minus the free highatomic pages
before the reserve is touched.  Unlike GFP_NOWAIT they are entitled to the
reserve, so this needs the watermark check and the freelist order reworked
together, and is left to a separate patch.

Link: https://lore.kernel.org/20261028171719.2043421-3-hannes@cmpxchg.org
Fixes: 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Salvatore Dipietro <dipiets@amazon.it>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dgc@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_alloc.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 9c3c2830acb0d..7097ea1805f6a 100644
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
2.53.0




