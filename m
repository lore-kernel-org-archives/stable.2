Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115994;
	b=KNz4s/aZ3Ex3CDT3bTpUFLhfSmY4ZXW/qqI+YqR4ozWFj1k5tlWJtpObwIMT+Ku6Jmkn
	 oxwcQ9W20xhSO0NeGXnyfLQWcpxIG7X8puZdXCMkxCBbza1IAlFJ9on54BoNXOWVfRtNl
	 r2d/PdmlMPlXSj2WX7SgA4dmwBfjad85pVc2j+llqJ9xdagzYiwWPtQ56Ekm78jEZkkfD
	 tng4VcwFuYjPFsTi/jc9eGYxvXXqP5AKERX9LWLa6CDEctuTYmJxwuPlWkOO+CzYVjeG7
	 6WicfjIG1hHfaqajn0mcBlu8N+apH1Z/ehZzj1qpkf6VAu3rSZb+JlVzMqqXSUa55Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115994;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=/Ri4iDNPYWxMKwrITsIynrV03rkPdZU8RMGQIDOFcHU=;
	b=jkdD6fI34qN9bOxjjR4JgHlrZCopXFveSNvAE8Xm7Qc9YrSk6C9ZzILP76i6s32+5Bfe
	 YEXzVQUZcJvfoflsOPSt/fHzI6VZNCWC0PR2oeoZiSRsCEW/C4UOInynu+g3us1pwh17Q
	 sm/Xsixflx8hjwGkP5o8kPmMbo0twsoSuwKkQeuvkEXhfOuZCN89sFOTJIqIK7ga04ogI
	 CeYQSBJiqo5k7t7U/FNQ/RmxjZfhVdhYMLgzwG8POYNo74bpALs4BLE5M9lA+IQaWfFQ2
	 tGqFkIOxDCYuCGzCeqwBbCPBh9Ml3x5/bm1R2c7+oG7hI6c5thDV64WM/RbFoIKR4Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwIPF0Cw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F8606A31D;
	Tue, 27 Oct 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwIPF0Cw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CBD1F031E9;
	Tue, 27 Oct 2026 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115993;
	bh=/Ri4iDNPYWxMKwrITsIynrV03rkPdZU8RMGQIDOFcHU=;
	h=From:Subject:Date:To:Cc;
	b=PwIPF0CwnI9H7xVSelgLMbn5NjCKiXO6xpchM797fGekQGKC82jup/tx8n+Sm+XiH
	 /CstMqnfYA6gsDwJp9N15dJ824FzLE+XR6XfUeA4K+49CTbFLHeK9tSf2HuKt2p7vP
	 WpA4Ve1BX4sxvq8WrbwdnfUgU0IXqMtLHOAP0Hg4FFfksGWRljx7ieE/bpZdd/L7D7
	 WghvPiIikWA05KYUb9oRmg7Fg4dYP36rR4pGRZDRYrmZtKNv3tSSgy8G6PyY8qa6Ur
	 ianZLnKBIquNBHSFzwuyGBmjFkwPPxWFOzi6Ftt0ZOMm7MAqvWx00hOoZqiBx+2/x0
	 /CrMA154mVpaQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH 0/9] mm, page_alloc: several stable fixes
Date: Tue, 27 Oct 2026 16:46:26 +0100
Message-Id: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAFLH4GoC/yXMQQqDMBCF4avIrB0wkajtVaSLGEcdCUYythTEu
 xt1+fH43w5CkUngne0Q6cfCYUlQeQZusstIyH0y6EJXqtA1rqP1Pji0jFPYBv6ToHl1rm/q0pb
 GQCrXSPeQwvbzWL7dTG67ruA4TjlyPiZ3AAAA
X-Change-ID: 20261027-pgalloc-ai-hotfixes-59bcd873a355
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

A bunch of fixes from Josef, filtered for page allocator by David.

They seem worthy of Cc: stable to me, but IMHO don't need to be sent
urgently as the issues mostly need root actions (memory offline) to
trigger and/or CONFIG_DEBUG_VM to result in a denial of service.

I have tweaked some commit logs and a comment in one case.

Based on mm/mm-unstable.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Josef Bacik (9):
      mm/page_alloc: don't undo a racing start_isolate_page_range()
      mm/page_alloc: clear ->private of deferred free pages
      mm: page_frag: refill the cache for large fragments
      mm/page_alloc: keep the pagesets of an empty zone
      mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone
      mm/compaction: trust zone->contiguous only in the span
      mm: page_isolation: do not take slab pages for free
      mm/memory_hotplug: resize zones under their seqlock
      mm/page_alloc: check pageblock pfns under span seqlock

 include/trace/events/oom.h |  8 ++++----
 mm/memory_hotplug.c        | 51 +++++++++++++++++++++++++++++++---------------
 mm/mm_init.c               |  4 ++--
 mm/page_alloc.c            | 43 ++++++++++++++++++++++++++++++--------
 mm/page_alloc.h            |  7 ++++++-
 mm/page_frag_cache.c       | 21 +++++++++++--------
 mm/page_isolation.c        |  7 +++++++
 7 files changed, 101 insertions(+), 40 deletions(-)
---
base-commit: 39274b454e9993cea319f4ac342a8082a9ee1730
change-id: 20261027-pgalloc-ai-hotfixes-59bcd873a355

