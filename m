Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68624BAA0A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447659; cv=none; b=U0J/O6pPPDM7gnbhjyaT4XTBDSGyHzEsDSTh8ZVFWJ6Ad+Sq20hMrI7kWTDEJNgFc7QNXonNhCtDUWUXf5yZswfSy7/A55FrJ7KgujXotoh+zV7xHKPylZRC4r4GTrTRFtFK/WxTOdC6c6hB0OohInhKY25DrXoTokZsz8cFyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447659; c=relaxed/simple;
	bh=aiZmlPThmjnfNycKyzF+LD50hViMsZ6n3C6rWQmC5yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hStWgEnrTwzffW1eDhWgr+Ptq1L90HYkbJTigEplSmOOeulZYBEBF6kFdUvxtRO/kFg2lxcOaf1sZwD8peNeLxUfuQD5I1wKZJ2ZPrH3gHSaKW2s1s1dRo8wmA3JrnrPsYCA9l2vwXn82sESYa0fpbFcSSmYxh528BTX3UNat9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8GMQRtm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8GMQRtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0191F00AC4;
	Thu,  3 Sep 2026 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788447657;
	bh=kItj9vrdIbBkW/oFMvUvGtn6+bm4dsGwHN/3BUePNr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8GMQRtmKIQalXDl1/TSAsq3MjAaCEsDJbHiOfk9aC8Aihb/aSR9ifaUWdN2ybg+B
	 Yr2N8XXj0diWaI5ObZjhh+NEg0VgQ6XBXO6/31MO48OkcoduzVhILW+rGt1AnITwNF
	 S7qGMEvi+eeAlkpH0hNnK9DHF87pgppI0oV5Dn/79G88IbVwu3AQhY81fxlMLF2cpg
	 AMRKZr1BDQVc5k19XVyrHTSJBd+6U7EYLDvD27PByhM8WbkvetaRan+0ZN45UwC2y8
	 bVgiDlGm90uT3ENSjGXnr+gMxaCI239dqWRf+hBEwN+at/toB2HQM9Dv7owOlp2GcW
	 4GmUQXv+aQeXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Andy Lutomirks^H^Hski <luto@kernel.org>,
	Borislav Betkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lance Yang <ioworker0@gmail.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcow (Oracle)" <willy@infradead.org>,
	Michal Koutn <mkoutny@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	tejun heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zefan Li <lizefan.x@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mm: move _pincount in folio to page[2] on 32bit
Date: Thu,  3 Sep 2026 11:00:50 -0400
Message-ID: <20260903150051.856389-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903150051.856389-1-sashal@kernel.org>
References: <2026090322-cucumber-clumsily-daf5@gregkh>
 <20260903150051.856389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 31a31da8a6187f1e5448ec73222e01d7d3fed4aa ]

Let's free up some space on 32bit in page[1] by moving the _pincount to
page[2].

For order-1 folios (never anon folios!) on 32bit, we will now also use the
GUP_PIN_COUNTING_BIAS approach.  A fully-mapped order-1 folio requires 2
references.  With GUP_PIN_COUNTING_BIAS being 1024, we'd detect such
folios as "maybe pinned" with 512 full mappings, instead of 1024 for
order-0.  As anon folios are out of the picture (which are the most
relevant users of checking for pinnings on *mapped* pages) and we are
talking about 32bit, this is not expected to cause any trouble.

In __dump_page(), copy one additional folio page if we detect a folio with
an order > 1, so we can dump the pincount on order > 1 folios reliably.

Note that THPs on 32bit are not particularly common (and we don't care too
much about performance), but we want to keep it working reliably, because
likely we want to use large folios there as well in the future,
independent of PMD leaf support.

Once we dynamically allocate "struct folio", fortunately the 32bit
specifics will likely go away again; even small folios could then have a
pincount and folio_has_pincount() would essentially always return "true".

Link: https://lkml.kernel.org/r/20250303163014.1128035-6-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Andy Lutomirks^H^Hski <luto@kernel.org>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: Michal Koutn <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: tejun heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ sashal: Reduced backport -- upstream 31a31da8a6187 touches 6 file(s), this
  backport carries 1. Not backported here:
  include/linux/mm_types.h
  mm/debug.c
  mm/gup.c
  mm/internal.h
  mm/page_alloc.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 078e1a0fc41a ("mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad38239294640..1728dc3356089 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1905,6 +1905,8 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 	return page_folio(pfn_to_page(pfn));
 }
 
+#define folio_has_pincount(folio) folio_test_large(folio)
+
 /**
  * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
  * @folio: The folio.
-- 
2.53.0

