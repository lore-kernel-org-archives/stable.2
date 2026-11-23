Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451606;
	b=LSCAq0DyogL9nd9nUG50xGWfXtkgQlrwwZ3k0ffP1wqucdwcCx5h1TwM4+R3Sa6BwYr6
	 FDQ/u2movLj7wI+kguhmf74LmN/W2L+J6j7/BeJrFaZfO2BvGjazGhf44OHJnBAUl6K3A
	 oRwxjbbgfP+4VO6IkMzrpZA9BXIXtyYYRXR6aRyCk0gPJVFmlVCjKeaEoPgfJNCEDNhlq
	 EiD5bu8r8zM4QO0POlIfE5mN5suONoiEXPtmLgcVls6+pX/1BcliCeCgIZnEkzYIwtFRD
	 oMbjBbLGBjg795SaoeiDag7ItlUgjxRrHUhFFayxj1rBDYBc5lOYWMcjmkBxMuyYihg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451606;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F9eDeeGHvneVcVHv8eGQt7NvP+yVebJ4M1jCjgOsIRo=;
	b=eBVl0QwBZ9y2I/rbHQhhaDi1zwnGHzs1IX/39kBS+ZAZzkWgR7W/LChwfFz5bKSEbQJc
	 alJWBL5BhbscBqpx6Ncp8E6135KABnFNmQapG6Rf6ECfkiZAsCnvPWwLjxHr3HnN0nxzb
	 qC/+hL9Dqarlfc9UAmvjuNjiNaklAH7Dy0k/BTIFJseTQqdixlNbbygTcB5F0wJRivN6j
	 vWfWNrATTii75Fy0JbQ5cofNKhKOrxXXBZwW3rlc2In3xOLNNxvw1CBikspL86pZMLszy
	 klAtOB7/3jRnhf4SovXl4sCAE1tPpV22tYsnQOTtraD716FbsADIrwAVAB9QOqeXg8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MHRRfQJ5;
	arc=none smtp.remote-ip=91.218.175.235
Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A8606A337
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 364A8606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MHRRfQJ5
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FR+hMBYFdGTc92+lBnUmV6i3ZQeVFjYBAQzvw8UUU0k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795451604; v=1; x=1796056404;
 b=MHRRfQJ5DL0JlWl4tSD2UU5w3myXa04MuxoHRu4N892v1qNS9VlWoVYfjvlqF3B5Fbbivrn1
 41CYtj7vf8uih9IbM1aWPr0ZYCLG2UHK3Wh3X8i3T+3mpb4hHGypsUVBqAGgztUUdcw1/Yej5u3
 93aPJZ7FSeipr5x8t2ySBrxA=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 90a87193e6a8bd2f;
	Mon, 23 Nov 2026 16:33:24 +0000
X-Mizu-Trace-ID: 90a87193e6a8bd2f
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/5] fs/proc/task_mmu: don't read young/dirty from a non-present PMD in smaps
Date: Mon, 23 Nov 2026 08:32:10 -0800
Message-ID: <20261123163301.1568240-5-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261123163301.1568240-1-usama.arif@linux.dev>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
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

smaps_pmd_entry() passes pmd_young() and pmd_dirty() to smaps_account()
for every PMD, including softleaf entries (migration and device-private),
where those bits encode the entry rather than accessed/dirty state.
smaps_pte_entry() only reads them when the entry is present.

On x86_64 the entry's offset is stored inverted across bits 9-58, which
overlap _PAGE_SAVED_DIRTY, so pmd_dirty() returns garbage: a clean 2MB
device-private mapping is accounted as 2048 kB dirty, and lazyfree
accounting is suppressed. pgtable_64.h also warns that the hardware can
set the accessed and dirty bits on non-present entries by mistake.

Only read the bits when the PMD is present.

Fixes: c94b6923fa0a ("/proc/PID/smaps: Add PMD migration entry parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 105c4998eef48f..34aaf80cd46cc2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1020,7 +1020,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
-	bool present = false;
+	bool present = false, young = false, dirty = false;
 	struct folio *folio;
 	pmd_t pmdval = pmdp_get(pmd);
 
@@ -1028,6 +1028,8 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		return;
 	if (pmd_present(pmdval)) {
 		page = vm_normal_page_pmd(vma, addr, pmdval);
+		young = pmd_young(pmdval);
+		dirty = pmd_dirty(pmdval);
 		present = true;
 	} else if (unlikely(thp_migration_supported())) {
 		const softleaf_t entry = softleaf_from_pmd(pmdval);
@@ -1047,8 +1049,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	else
 		mss->file_thp += HPAGE_PMD_SIZE;
 
-	smaps_account(mss, page, true, pmd_young(pmdval), pmd_dirty(pmdval),
-		      locked, present);
+	smaps_account(mss, page, true, young, dirty, locked, present);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
-- 
2.53.1-Meta

