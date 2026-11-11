Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385752;
	b=Iru3jO5dNPmN+lWv0V1PmSyN38llzEy2loNaH6DOSKARA5UY/rnJvCtZ7uQ1JIzNj7pQ
	 iA4cTE7dBr71bDwbHsWeKnj/hITNjy2qWsMElxqyRD0GCLUCD9DXpPcweVIQqAbXCLFhS
	 rnvq54yw4TSBvoGREGoZlLW3rmPyoevW1WC3dZ7ZZ5dSel5B5Co/hllhv0Fx7tmx1HmMZ
	 4Y1DQ2Isnt/KVffb3Xc2fzAGyysL1ACBaRdOuFAeRlzAeDJK60Jrg0a7B+dBmk8x6dCnK
	 dnKCS2HGjqL6DHwiK9U+opGE/bYfkJQSoJH/NgKOClrzCGrC1mQL4C9J2cazRmsMhAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385752;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CEpwVWh2KyTSQS5Lg6c2VNlL65GWjKFiwbc5LVZSuE0=;
	b=NOS/hv0JveQiIzh7CzgYT9UY4270BCkm3fGu3cEINUrD1DRZRPsYUcgrWtE+psxHq40o
	 AxYqC292OEax79yPmTorHB7kW9zSJt03N4SMPFbViCdwTftTw9lrtoI20zARIS4oo0HSL
	 GeWOB4zTvcN8LcB52gTESNnhFphdpmS+qy0I3gg5uDP735CQjXoR/iWXmoBL+K2XAXJYK
	 y5gByoKNit6Z9sFx3+2q/O866JOApR9KapbMeHecxBvrAklu1Bphr/uA9RJrlEwkOe56T
	 vTOXgqjl3WOX/NrYDM1oX5CEhUKOEoX83Rwbp5H74/tyW2CdTZeZzf5fq0MZOu37avQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wFa5az3m;
	arc=none smtp.remote-ip=95.215.58.24
Received: from mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0C606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF0C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wFa5az3m
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wcnRcEdpm56Ouj6aujuxTCfZr3zsZDP6P/NN4kneqWw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794385749; v=1; x=1794990549;
 b=wFa5az3mitG0+EEwfd8LedazsxZ7uczJaRQDW8Xdm4gqECprNJg8b1M8uVHPujsT9FY2gr/1
 FGODv1jWzzUzBX9w6mnAb7X2cTwou8gZbb2kpR8OxbUKItF1AgozQ38imhSogExRtj3aGxEelh8
 Z68BJYjbLpOjhjNAfYe2/h18=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bc9112bff3cf2259;
	Wed, 11 Nov 2026 08:29:09 +0000
X-Mizu-Trace-ID: bc9112bff3cf2259
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Lance Yang <lance.yang@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Brian Geffon <bgeffon@google.com>,
	Denis Plotnikov <dplotnikov@virtuozzo.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Martin Cracauer <cracauer@cons.org>,
	Marty McFadden <mcfadden8@llnl.gov>,
	Maya Gokhale <gokhale2@llnl.gov>,
	Pavel Emelyanov <xemul@openvz.org>,
	Rik van Riel <riel@surriel.com>,
	Shaohua Li <shli@fb.com>,
	James Houghton <jthoughton@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	SJ Park <sj@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH 6.12.y] mm/ksm: fix userfaultfd protection during merge and unmerge
Date: Wed, 11 Nov 2026 16:29:01 +0800
Message-ID: <20261111082901.32704-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261109200758-failed-6.12-990d6c2194a9@kernel.org>
References: <20261109200758-failed-6.12-990d6c2194a9@kernel.org>
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

KSM loses userfaultfd protection when replace_page() builds a new PTE from
vma->vm_page_prot.  Dropping its uffd bit lets a subsequent write go
through ordinary COW instead of userfaultfd write protection handling.
For RWP, a merged page also becomes readable without faulting.

Keeping the uffd bit and restoring PAGE_NONE fixes merging, but we also
have to handle unmerging.  An existing KSM page can be protected with RWP
before MADV_UNMERGEABLE, so unmerging already needs fixing independently
of preserving RWP during merging.

Unsharing replaces a shared page with a private one and should leave
userfaultfd protection in place, as do_wp_page() already does for write
protection.  Currently, an unshare fault reaches do_uffd_rwp() before it
can proceed to do_wp_page().

- With synchronous RWP, handle_userfault() returns VM_FAULT_SIGBUS.
  break_ksm() then reports success with a KSM page still merged.

- With asynchronous RWP, protection is cleared before unsharing.

Preserve the uffd bit when merging, and restore PAGE_NONE for RWP.  Let
FAULT_FLAG_UNSHARE skip RWP fault handling and keep PAGE_NONE on each
private copy as well.  Unsharing can then complete with RWP still armed
for a subsequent access.

Link: https://lore.kernel.org/20261026130054.91461-1-lance.yang@linux.dev
Link: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
Link: https://lore.kernel.org/all/20261020055518.36087-1-lance.yang@linux.dev/
Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Co-developed-by: Samarth Narang <samarth.colleges@gmail.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Xu Xin <xu.xin@linux.dev>"
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Bobby Powers <bobbypowers@gmail.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Martin Cracauer <cracauer@cons.org>
Cc: Marty McFadden <mcfadden8@llnl.gov>
Cc: Maya Gokhale <gokhale2@llnl.gov>
Cc: Pavel Emelyanov <xemul@openvz.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shaohua Li <shli@fb.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: SJ Park <sj@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: <stable@vger.kernel.org>

(cherry picked from commit 990d6c2194a938a19a8cf94c6cfd75171345089b)
---
Backport to 6.12:
- Use the older pte_uffd_wp()/pte_mkuffd_wp() helpers.
- Drop the mm/memory.c changes. 6.12 has no RWP support.

 mm/ksm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 15f558f69093..cbc666343b39 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1407,6 +1407,10 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
+	/* Preserve uffd-wp when replacing the page. */
+	if (pte_uffd_wp(orig_pte))
+		newpte = pte_mkuffd_wp(newpte);
+
 	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
 	/*
 	 * No need to notify as we are replacing a read only page with another
-- 
2.49.0

