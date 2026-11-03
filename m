Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722614;
	b=Mm7cBqsJeSkSRQSjxPVmslNEFIOsstBSzDA8+jLHnKw7r/4PBFWlgreFa/uZqI5Hj2fE
	 uv1qZSmm9YFHRa1WDpqskkUksS+d5n2VEmB1uuhgYNk8aqA+D/cOCQzzuFUYDRcjERVav
	 grZXiFnTfnOacW9tFO6FkeyyPKy6Q5NQmAvBSEoY5x0T+1jbnGLPbZJY06YDtYCCzfjtx
	 xetudMvG/rMHArMrEbiqkjFPqjcBMLGYKPmMHx13Hk/W1HfYdsa3sWjwshx1jUoQm8ATR
	 viD398qWpy0ZaWV837748J+AROYr2ojV3Ep7zUwO+D1GQAfHE4ZZZH+iEx5Cyu/S7Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722614;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=FafqJiDV3r+YgBt00+egOT7IUnjaF1ZmJPN/zCmRJDY=;
	b=phPkvDMnLqkIErEeumcoBN77wt+GUZSehi/2lUXedQps934JlAyWe+25Mw2Lgx0dVdGF
	 HD1VMGOpGJWIQbvmoDfle2+gmFxNnR+LKZv2+nIoCS9DwcXMYozhqN1PD+ybJFwCYPaO+
	 UVtvyqkN7YVUcJ+RUDPWJsXp/j9JZ/dUsRITqzjWFGUPDiyXApCwF0+xin3nKr6wE1WCn
	 eIc8dIjV17Q0FUWgD+9Ok4UxRrRRNWExZpM9DmNBMfRZ8oDUq9LIpYK5/2COLTTeZ73FK
	 rYLJbK8AhOlWClqdkgnEhn4Ie7tIkn5Qyz0AuE5dbY+LIWYodBQGvI8enKupREbO5TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTt3daFa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75237606A327;
	Tue,  3 Nov 2026 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTt3daFa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E234A1F00A16;
	Tue,  3 Nov 2026 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722614;
	bh=FafqJiDV3r+YgBt00+egOT7IUnjaF1ZmJPN/zCmRJDY=;
	h=From:Subject:Date:To:Cc;
	b=nTt3daFaes2ppvo5vVGTGF2L5pXi7zT2F65h6quSBaxDm5gsmiGbvoz66Pkz7WktH
	 huoswhp6navHAJMrgawDpBw+GlL+uZNP70EURKIe0YGb1D4wHjnYTqhUzAJH/VNCn6
	 awpkzyu9LWLhUY0f9UYdF0h5+mibfqWvSdJvEZDQYbk6vW/e2B4RBfrS9NYx4j62Rx
	 CdUk7HNb0teIruG/JO7jRqcABwgZsLhfjf9xy+/FId+4/VhGWW3zdatr2kFL7QseeN
	 8sFUAsf/q+f+ZCkT8ne2NvZz6sfppvfA/BqdkOR1ljKiuefZGB/4wdIGP2wAlj38TH
	 D8CJKYs37U0+A==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH v2 0/5] mm, page_alloc: several stable fixes
Date: Tue, 03 Nov 2026 17:16:46 +0100
Message-Id: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAO4I6moC/32NwQ6CMBBEf4Xs2TVtSQU88R+GQ2lXWCWUtEg0h
 H+34N3jy8ybWSFSYIpwzVYItHBkPyZQpwxsb8aOkF1iUEJdpFAFTp0ZBm/RMPZ+vvObIuqqta4
 scpNrDcmcAh1BEm/Nj+OrfZCd96m90XOcffgct4vce/8fFokCK1s4aawphaT6SWGk4exDB822b
 V9sFSVGyQAAAA==
X-Change-ID: 20261027-pgalloc-ai-hotfixes-59bcd873a355
To: Johannes Weiner <hannes@cmpxchg.org>, 
 "Gregory Price (Meta)" <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

A bunch of fixes from Josef, filtered for page allocator by David.

I have tweaked some commit logs and a comment in one case.

In v2 some were dropped as they were merged already, the last one was
changed to fix things differently. "mm/compaction: trust
zone->contiguous only in the span" was dropped due to lots of sashiko
feedback. compaction (as a pfn scanner) needs much more thought

Based on page_alloc/for-next-fixes, to be applied there as well.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Changes in v2:
- rebased on page_alloc/for-next-fixes
- dropped 3 patches that were already merged from Gregory
- dropped "mm/compaction: trust zone->contiguous only in the span" as it
  needs more thougt
- in the last patch, remove the VM_BUG_ON_PAGE completely
- Link to v1: https://patch.msgid.link/20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org

---
Josef Bacik (4):
      mm/page_alloc: clear ->private of deferred free pages
      mm: page_frag: refill the cache for large fragments
      mm: page_isolation: do not take slab pages for free
      mm/memory_hotplug: resize zones under their seqlock

Vlastimil Babka (SUSE) (1):
      mm/page_alloc: remove the zone_spans_pfn() check from get_pfnblock_bitmap_bitidx()

 mm/memory_hotplug.c  | 51 +++++++++++++++++++++++++++++++++++----------------
 mm/page_alloc.c      |  3 ++-
 mm/page_frag_cache.c | 21 +++++++++++++--------
 mm/page_isolation.c  |  7 +++++++
 4 files changed, 57 insertions(+), 25 deletions(-)
---
base-commit: 743a99d7e339e81acaf76f3c902b23abb29abc15
change-id: 20261027-pgalloc-ai-hotfixes-59bcd873a355

