Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115998;
	b=VRx2PQ9MR3Y82L4UVrSpvZUnPAmqza8QcoYJ8kb4BE/FB5/lCkGcBcNAdZ0n9Fv9jb4p
	 faePGDNr+XPLdOauno2cjih30gXVd9SNqZWIgBYcq+LRbRLBFa8HjTJxZJy9FxbwVVuIO
	 oh8Rzq7S1Qx/Ls9UmjhXtYYiHPMAzr5TBfEKyztDWUgJiPe7xBuaIxxW7va9YNfcKmOj2
	 2H+o2R8BBsmB/Doj7ftYq+OxVBcygtAubGZ8uDo9Q/Oh25x6h/gV31z1os4NW0nTqHxFk
	 KIzwToWB9+lYG3aCHK/A/cUBgFnXZS8/IN8hdv9GwIubYxXOIeIArRftLp/+iDOCJmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115998;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=TkajPyN/GH0NQa9nfHgSYQX1lDjcrGhWefwdVdOd9cw=;
	b=ks/1c1RwEb8CMArwMYFhyPzn2NUk5O70uazt8z+rQTlfW0ftDxUXv7S/fWxgJw9GikEL
	 k8iVuc4s/PklV88LE1Ky+KLxbMUVVyhKKfPxcl1Vmjzti+WSyF7dDLhhtbd8XeaDD+9nq
	 faM2V2k5mjJ2aNjZ1INIgRsKK2whW1aQJGjhSIdHjdpWO9JZxyVdutFJ8Ich4IdxG+y9M
	 K9XVd0kIbHRLGoyw1NUO5Adq5+Q+iN9FA7QaxrmTxe7rRHr7FfAyAEhLn1lnYPx7fuWF8
	 OXGqOwCj601CU9vSfIW6EKGfcOtbFM+z5grZyZ1EVO2ATOUXc+0qDfmb1YrNMsVoPuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnFG75xq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87AB606A31B;
	Tue, 27 Oct 2026 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnFG75xq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D06E1F01828;
	Tue, 27 Oct 2026 15:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115997;
	bh=TkajPyN/GH0NQa9nfHgSYQX1lDjcrGhWefwdVdOd9cw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cnFG75xqYOPouaLfdO1n3+9x3mvKVPPbTb75zL0Ve7ybnZEI0um1yk8fTdE8c0aTO
	 OchixKsbFVVX9pkhfU8QMXnYDWso5w6BCnYha1Sc5cjQItWdP9kCGEJkuxqUSqePjL
	 8uU4jMMYQTDh78EtXMcWaOSkSScCWe82+YcgniY0LjTDdjXyI1E/hCu0k06rsimkpT
	 elPFWaqr76SXEb3wdjqlKb+VHRwzdYLtCJHhySzu2ULW+0xXwC2q5cW86ssKv6nXWb
	 tCxzDMabgmXHRPakFeCLbHumw2TLgD2ng4t9qmDjk4xTEUCqm85kercIRwu0+TqsEW
	 rS9xwAW23dcUQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 27 Oct 2026 16:46:27 +0100
Subject: [PATCH 1/9] mm/page_alloc: don't undo a racing
 start_isolate_page_range()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-pgalloc-ai-hotfixes-v1-1-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

From: Josef Bacik <josef@toxicpanda.com>

start_isolate_page_range() fails with -EBUSY if one of the pageblocks is
already isolated, i.e. if somebody else is working on it. It restores
the pageblocks which it has isolated itself before it returns, as its
kernel-doc says:

  We then clean up by restoring the migration type on pageblocks we may
  have modified and return -EBUSY to caller. This prevents two threads
  from simultaneously working on overlapping ranges.

alloc_contig_frozen_range() nevertheless calls undo_isolate_page_range()
for the whole range in this case, which clears every isolated pageblock
it finds. The only ones left at this point belong to the other user of
the range:

  CPU0 offline_pages()                CPU1 alloc_contig_frozen_range()
  start_isolate_page_range(A)
    pageblock X: isolated
  migrate ...
                                      start_isolate_page_range(B)
                                        X is isolated: -EBUSY
                                        (own pageblocks restored)
                                      undo_isolate_page_range(B)
                                        X: not isolated any more
  test_pages_isolated(A): -EBUSY
  (again and again)

offline_pages() repeats the migration and test_pages_isolated() until the
latter succeeds, which is now impossible and the task spins until it gets
a signal, while the free pages of X are handed out by the allocator again.

If X is released after the last test_pages_isolated(),
__offline_isolated_pages() takes pages which are accounted as free off
the free lists as MIGRATE_ISOLATE. Thus NR_FREE_PAGES stays too high, or
hits BUG_ON(!PageBuddy(page)) if one of them has been allocated.

For another alloc_contig_frozen_range() or cma_alloc() the result is a
spurious -EBUSY.

Return the error, like the function did until it was reworked.

Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 36079e092875..ee013db45ed1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7329,7 +7329,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 
 	ret = start_isolate_page_range(start, end, mode);
 	if (ret)
-		goto done;
+		return ret;
 
 	drain_all_pages(cc.zone);
 

-- 
2.56.0

