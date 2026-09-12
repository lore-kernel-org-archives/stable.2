Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49B330D25
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789184922; cv=none; b=rSdMfITI5/UZzSI2ZJ+4I1qfhjHdhqEHF+QbUESaUCpycMyOcOFnbl6avIyHOjrQ/6uWgwRWPCa/hZ8k8OF9LwcEGmVRm3orv2ZQpEKjKdT2QLR+RLXBdTt08w2nShupdDIIxpi47WQcaqvZQpz+8gAUTGLuX5PNPHbekzUjZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789184922; c=relaxed/simple;
	bh=zSuNyhA8z6CuADMjjJbueqDpMT37tnxyY9ZERde6xgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ve1IvzToPei+qwOGkZCNyXU+oDO07OIeqdTXRAgcArsojNz0OyieM55P3ham7NlrrPxzwRQkxpTKYIMv8pgjkKbf5ZxfmyLNYk5gMmlJJHuek2tAWJGYLs+x+1neXVbCIFq92jHhhQjOnoZZbPkD5y0N3Rh01BtTjVvTJXNJebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=a4EGe5/1; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="a4EGe5/1"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe207so3482496d6.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 20:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789184920; x=1789789720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwin+KqMEV68jY1s8XlWs9NOlkNCNlU9QmB5425skrY=;
        b=a4EGe5/19wlf/LCg1zi3K3IX0xD2Fwg3ZfB/alo1MwEGSGe+dh/mj+E0SwhYR/mYZ2
         y0ZvJPZ3Wp3DGNry7egpC19h1GZBWhI8lZZki5tT+GfLX6Bw5rntQTd+IxYNOCYdS7zZ
         iylS8VpISeqnfYnnY/iXYCvavexr8W7w3uigtstqJpu19A8Ff7IBu1ZedeTsPPRTr2HZ
         6EgtdyVaERJQlRc7rqQpT+fg4WYcOAUIYg+j4a0W5ZXqS7WaS5eIZN7Q5pnkPkU0qK43
         F6Bej37FJAB+zxSWs5YhQJSBm1v8NfIcI/wMbNQILEA08XpvXajQ9XX6XalOHlgG6t9x
         APNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789184920; x=1789789720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gwin+KqMEV68jY1s8XlWs9NOlkNCNlU9QmB5425skrY=;
        b=XIarLmz4NdDKGKybCe20efSszzfpw+s8BT32eF/JCDC1tn3a8xgZgAqS81YFus97gy
         MMRBZRRZVgFn//oDi9fLLh3XqmtftWvKHnlnDEa667suY4ZSiSckNf+FWt/tIel6Mz4k
         HR4K9NNsRZtyyHMCfI544EytsNOxFtSh+Dz5mNtz0Vzk4KePpjZtmdiddf4ve6RUBhpt
         5G/j374njlRkxdPF+QFfmhyKeps2lVpbg37ebNb6RkIumwd+nftjFnM0gnnytMSppAtY
         +YgnRg7sd2VHz6/uHwNRZrtr/ekYyImWSTbnjG7xojmYPUpLz5UbhNgSaw9lhtVz1p0q
         krFA==
X-Forwarded-Encrypted: i=1; AKwUvBxB8XQL8qNEMywVjlNtDarCrQihPGoF+1SIR6vnxCUORLuLuugIgcW1jKgF80g08Ns4Ypwc6eU=@vger.kernel.org
X-Gm-Message-State: AFuF++nEG23n63A+2KgAiAMaFVV6AuSFzFs1NFkfftxmfnLNcx7bKn0T
	7zIZFAGqd2qlfrMyzVJSehIhxPcZ5q07mZ7zQiOff5xzixi/KaG6tZYIOvWxjsx+qts=
X-Gm-Gg: AYBFou2EVE6I9E1DIjHYZRPcS3SmaMyrRJ0yWlE0Cl0j51H4NdfG5UP7ITiFr1HvMl6
	S6tdca3907jPzrwVUZEX1e/hMs5bpB97KHCsQnkjLrqY7PS1OazW5IwwVhI5QA14VX54VTeqRMa
	xwhDuZuSaVjC0n0/RMZKiIUhG6Pwje+OnT1XgcCUr9Q2vvWMEOfJi/BkhM9il2I9afm+Hh2NL56
	FkaljwuZNtTFSfGnB974b5/p1W/aZ7A2tsn4LG8LnWIx2wk/FhG582NBEwl8eg5LogE2UGzXjZ0
	zBogQRLHu5Mpt+aJvoFhGtOH2icVL49V0WWfj3lxojqdBgSsBQBkdlAoptk2AaQY41pkf4pcEM2
	hLPdYD3030At3GURZCb9WHPNyofd5yEro0tvxSMf1+nIxJB+bzDvgzRAcXpSV/8LNYROMh1X3eT
	RwuZeEs7q0juNGs/FejS9LFAMb3uW/bMbK7qXebulnRQnRhRCCguIpmx/xCToPP11ivrMVXiEpw
	blWKwRYOTDMW3fYwSf8IYlUkmgov6VLKm/pnlTBjL4Dt/TY2d1v8iqIarlD
X-Received: by 2002:ad4:5ae9:0:b0:910:46e1:7bac with SMTP id 6a1803df08f44-9121dabf7b3mr19465126d6.26.1789184919640;
        Fri, 11 Sep 2026 20:48:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f494620sm36252476d6.28.2026.09.11.20.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 20:48:39 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	peterx@redhat.com,
	jgg@ziepe.ca,
	sashiko-bot <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] mm/madvise: use vm_normal_folio_pmd() in cold/pageout PMD range
Date: Fri, 11 Sep 2026 23:48:33 -0400
Message-ID: <20260912034833.2952750-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912034833.2952750-1-gourry@gourry.net>
References: <20260912034833.2952750-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmap a VM_MIXEDMAP region whose ->huge_fault installs a PMD through
vmf_insert_pfn_pmd() - mshv_vtl_low does this, and needs CAP_SYS_ADMIN
to open - then:

  madvise(p, PMD_SIZE, MADV_PAGEOUT);

With a stand-in module for the driver:

  BUG: unable to handle page fault for address: fffff587c0000008
  RIP: 0010:madvise_cold_or_pageout_pte_range+0x410/0x9b0
   walk_pgd_range+0x52b/0xaf0
   __walk_page_range+0x6a/0x1d0
   walk_page_range_vma_unsafe+0x8e/0x120
   madvise_pageout+0xb2/0x180
   madvise_vma_behavior+0x46b/0xa90
   do_madvise+0x108/0x190
   __x64_sys_madvise+0x26/0x30

Nothing validates the pfn on the way in:

  can_madv_lru_vma()     rejects VM_PFNMAP, but not VM_MIXEDMAP
  can_fault()            *pfn = vmf->pgoff & ~(mask >> PAGE_SHIFT);
  vmf_insert_pfn_pmd()   no pfn_valid() check
  pmd_folio()            pfn_to_page() -> unpopulated vmemmap

Even with a valid pfn the path is wrong.  The mapping carries no rmap, so
folio_maybe_mapped_shared() sees mapcount 0, and the walker goes on to
folio_deactivate(), or folio_isolate_lru() plus reclaim_pages(), against a
folio this mapping does not own.

Use vm_normal_folio_pmd() and skip on NULL, as the PTE half of this same
walker already does with vm_normal_folio().  This also filters the huge
zero PMD, so its separate check is no longer needed.

Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
Cc: stable@vger.kernel.org # v6.19+
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/madvise.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index f75a9d139980..fbb72ab49aa6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -395,16 +395,15 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			return 0;
 
 		orig_pmd = *pmd;
-		if (is_huge_zero_pmd(orig_pmd))
-			goto huge_unlock;
-
 		if (unlikely(!pmd_present(orig_pmd))) {
 			VM_WARN_ON_ONCE(!pmd_is_migration_entry(orig_pmd) &&
 					!pmd_is_device_private_entry(orig_pmd));
 			goto huge_unlock;
 		}
 
-		folio = pmd_folio(orig_pmd);
+		folio = vm_normal_folio_pmd(vma, addr, orig_pmd);
+		if (!folio)
+			goto huge_unlock;
 
 		if (folio_is_zone_device(folio))
 			goto huge_unlock;
-- 
2.55.0

