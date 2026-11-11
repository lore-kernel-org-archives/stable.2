Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397161;
	b=mCYJhiC/O6fAlpFkYaEVwaE+q1tXkN6n4VKwz9Zj7TNxkuyziKqa5EPGMc/kTK5/oPUK
	 dEfersF0c/b3psr9BNcaa6wdU1+/cfcWA4DdCDT5Foo9kV1MkNVabsC1PtcZrbLJtg8Ks
	 d8QZ0nGg/f15tKUv7rY3xjJWmpK3Xuu2bCoKvvu4kjROwzIHit/K0dbYbjQc0RavMMZqK
	 Ix8BVqNrbTy6YyG5tlOAss1/ZgqhxTin+aaXuyksrKWPlC2OAecXX2OPuHQZEIoe1Pv9y
	 I4FqVmLGweijkjhXYzr9/9JHpt3J/rWd17UDcAgvGBumd8VOQs+Cv237c1sNZ3GvnCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397161;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2saoVbYFwvaTsDZ1OYoBWs5gUVifzn045/gtvbvuIH4=;
	b=g+XTkeXkDiU68w7EqjW3HZm7GQdr9pfHMAyEnn5lmlJNAbfDxJRY9J52BnM6VNhjlCrz
	 ydG43MHXygMxDrtOqenGsP6qdIHCIXxTMQPiD+dK1B6xoUeELa3mWywa/KkHewavZp7sp
	 VMBAtLcRtxnBrFwWdU74O8065COeAsLINtQy/fJKQ94Mvk3umucD0kUsc3r2JVoOhixau
	 eClU5sLmHN9SvOHrqon/AJAwjmFrUaIRtrjnuXjQgXAnhxX5qkM2jN3B3SuxikMfnSf7s
	 PFWHLvtoC91b8KPlIZxh/PwJsDV8IDsylfjZVCgyeqRNX2JIBtucsxJt18x2xs8CTxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ol4gTM4U;
	arc=none smtp.remote-ip=91.218.175.155
Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC24606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC24606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ol4gTM4U
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RMq5jEADKeGNruhLoquiDuSfixBjLOzms6+A0cUPnr4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794397158; v=1; x=1795001958;
 b=ol4gTM4U5KHxFLvbS+cFMtU47Q7/IWQU1DlbzZnCaIGuqvVwK8Gm6MEkpVq4G7ECizDEl9E3
 uqh1sQmp0WJI5PGBncqlTXnpqiUpo+twikOuRi1Oi/DbxH7fR16Pyb9NWc8P1ZJinvi/KAEdaFq
 TeNsUe9L0cjn8h0t+pXt6vpw=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 2797f348b581f3be;
	Wed, 11 Nov 2026 11:39:18 +0000
X-Mizu-Trace-ID: 2797f348b581f3be
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
Subject: [PATCH 2/3] fs/proc/task_mmu: don't read young/dirty from a non-present PMD in smaps
Date: Wed, 11 Nov 2026 03:38:30 -0800
Message-ID: <20261111113904.650722-3-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111113904.650722-1-usama.arif@linux.dev>
References: <20261111113904.650722-1-usama.arif@linux.dev>
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

smaps_pmd_entry() passes pmd_young(*pmd) and pmd_dirty(*pmd) to
smaps_account() for every PMD, including migration and device-private
entries, where those bits hold part of the swap offset rather than
accessed/dirty state. smaps_pte_entry() only reads them when the entry
is present.

On x86_64 the offset is stored inverted across bits 9-58, which overlap
_PAGE_SAVED_DIRTY, so pmd_dirty() returns garbage: a clean 2MB
device-private mapping is accounted as 2048 kB dirty, and lazyfree
accounting is suppressed. pgtable_64.h also warns that the hardware can
set the accessed and dirty bits on non-present entries by mistake.

Only read the bits when the PMD is present.

Fixes: c94b6923fa0a ("/proc/PID/smaps: Add PMD migration entry parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 22361607020d1..c0d391186c2b8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1019,13 +1019,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
-	bool present = false;
+	bool present = false, young = false, dirty = false;
 	struct folio *folio;
 
 	if (pmd_none(*pmd))
 		return;
 	if (pmd_present(*pmd)) {
 		page = vm_normal_page_pmd(vma, addr, *pmd);
+		young = pmd_young(*pmd);
+		dirty = pmd_dirty(*pmd);
 		present = true;
 	} else if (unlikely(thp_migration_supported())) {
 		const softleaf_t entry = softleaf_from_pmd(*pmd);
@@ -1045,8 +1047,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	else
 		mss->file_thp += HPAGE_PMD_SIZE;
 
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
-		      locked, present);
+	smaps_account(mss, page, true, young, dirty, locked, present);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
-- 
2.53.0-Meta

