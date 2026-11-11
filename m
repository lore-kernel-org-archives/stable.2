Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394278;
	b=ZGf9BKFPdjVm6sTsigtbVlaqV3Ln5aqzdBh4OKOy+0ARRAHkVyCenkkL+Ul04C/Xis9o
	 mXwCABzcGRXb+CzzYAiS/X6v/LoMDuEG9Ombu9kvFFWgJgdZRvAbyGi0A2nEwxLxOJaiV
	 mU9hxyhGkx2zWeBeq+qE1QBaB2BQMDesyzfMc89spFJYKN81yTiuk+5xIHPUdhFBdknic
	 aZVYn/+TgLw7V05SM71x2M7cFpC6va6V7a+amuwOl79aXOyyg82gAkPv+4K74zQiarZt3
	 6M+D8D1ouhRPtEu7Zz3XbRyqpEjIkOnkra9ZNilTn/StftsCi7oUptf27HB4/dGmf1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394278;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zlaGDXenXs2WnOuYAO4yuwNGMasd1sp10+9WQn/o4CA=;
	b=LrWf+uoFt4EMjKKx13m/eifgC8Jk9kdblQ8A1xIbeJvWJQPDF0wKmewlxV8oOqkX6MS8
	 P/rJV/bcy8zOpxWiNw4mmpM9Heoz+KpQVzvrv+AbbM7Y0fD41M2Jkc/9g2CBnjP0cwHir
	 KdkWAxrG2KJNi//kiFmhpQXT4p0RpLtI3gdXNwnAYvevLMvo0dh6oXV390Ks7n2qbjxFr
	 +wPyqMrEW1YqK/2rgvilHQVE9yuOt1A6aKhjqy6cGXC8EIhXDhGBHG6+GgN0oUngnr94r
	 htFObyNqCM7YlIBlqKOhL2bTBJetRj/bBXhsELTUD5KEvunRR5uwfoz3Bkshn0SW7vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mmo8Y1GX;
	arc=none smtp.remote-ip=91.218.175.38
Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC943606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC943606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mmo8Y1GX
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fJMpLHXJ3OMWwjsPOjW0na7I13zrAGAWG+nW9/yEEP4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794394275; v=1; x=1794999075;
 b=mmo8Y1GXusPnat7zHzGuHNTZRisJ8E9V7q1g1cUNks1AE+rkYpz+epFX1nb63bw9vTNJvVDP
 B6Q867ry6GAtOxaJptjrcLPPJVOwWB416R+bYaB/Q4n41lw25ux3Yr2Kpbw4mgE3c12WkcUoQ8n
 yG8JxAv1T6p5cGO3WhtNmJx8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c024eae9af748c53;
	Wed, 11 Nov 2026 10:51:10 +0000
X-Mizu-Trace-ID: c024eae9af748c53
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org,
	sashal@kernel.org
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
Subject: [PATCH 6.1.y 3/3] mm/ksm: fix userfaultfd protection during merge and unmerge
Date: Wed, 11 Nov 2026 18:50:34 +0800
Message-ID: <20261111105034.51632-4-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261111105034.51632-1-lance.yang@linux.dev>
References: <20261109201707-failed-6.1-990d6c2194a9@kernel.org>
 <20261111105034.51632-1-lance.yang@linux.dev>
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
Depends on patches 1 and 2, which backport 58f595c66591 and
6cce3314b928.

Backport to 6.1:
- Use the older pte_uffd_wp()/pte_mkuffd_wp() helpers.
- Omit the mm/memory.c changes, since 6.1 has no RWP support.

 mm/ksm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index b052f6141b6e..65da88db632f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1176,6 +1176,10 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
+	/* Preserve uffd-wp when replacing the page. */
+	if (pte_uffd_wp(orig_pte))
+		newpte = pte_mkuffd_wp(newpte);
+
 	flush_cache_page(vma, addr, pte_pfn(*ptep));
 	/*
 	 * No need to notify as we are replacing a read only page with another
-- 
2.49.0

