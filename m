Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66142CB05
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323813; cv=none; b=SJWEbmYY0O2JrLL0DJdwfIRLCQ/UDzIRp52iLAklc7rZD7YOTrRqGyulPWdFKQDscZR0/LR3s8vTn+ZtkIz7qr9Dg5eBr50rU+4IP3icC8TJDtZzMwvfjQlQafFrkbb9imPuXKanm7NYTAfc8g1e78hDS2mwE1TOhJ557uLPQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323813; c=relaxed/simple;
	bh=iklPJf6SRkdTgIf0pIUi3KtDJ+NhLLaqrV1rClnN86I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFZmaTht89XUixDVZehKRP64zMvwpInR2CeBO8VQxaNdLrI6ULYl2JZtr0G3yG6UQhzYfO2QX+JA06NVbUCHE3ZyFKrkyYQY13msRDte7u8ms0vWmDr16knBKIKbWWucdPAvJ8deRIsBcXKMxk1ryM7Q85tXkUps1MK1PGMyWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mIfkXN7v; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mIfkXN7v"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e6a434cabso57099485a.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787323809; x=1787928609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xsVHSsNBVmunDbjw2peBUvjMtVALhYSkX0xXozMheRU=;
        b=mIfkXN7vCh0Fr9TLCuumrtWEMWt+/1WoES3IW4MAuZO0l0FRW2Gy7n6y1jTLO+N9U9
         1bW77xLNKE0PYMXFAjHFEgtPfdXuUwMU+5O422gI/QZk3DHWmanLxuiInN9JrTP7bKYe
         koofAGVLXohTxvARlaQLd8zpAvrpOluiwiXv4TQEY/9L3VUmHrIzwSg8nfMjE6HNP6EH
         hAcwyE6+neK2Ec5FOUUdM7ip2y5vBXkJKK0cW1SzEOpQAGyrOTe9we8R0gJmRRrWvJRc
         rP78Gg1LpZzDbEZgRvO3y0Gz+MG8jMu5HOC0+9nTSjL8ACAXxuqtsceSsJBunyuZjfTB
         b1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323809; x=1787928609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xsVHSsNBVmunDbjw2peBUvjMtVALhYSkX0xXozMheRU=;
        b=HlK4od+GFYKnCt/D/t3upKin4rMYICPneey8+oR513rSFmrY4u6qjaJWng4gKUXWuD
         3+Ow+mdTE7HSNcsBxMStcELfIf8a5dJ28bLF4Tephk8xGODF2VfzIRSVauFUkCxCtGxo
         psV4b2JlMPiUoLv8W3N0T7flw5xagAiXRCD10eP/I/7d4kM1fgquqU4hmvI++CpcmhA1
         ZTTuIrXqfM2FkS+hGnMc4qMrFR7fKvNi/9m0uWgrp01PYVX2tYOFkyy/wL1/9gXU+Qye
         ChF/g2lqCevLePsfgb8JdAqrMdOvalh8iORUyhnhAFFPUA5+S3EPyY1Kj1dYh4Cnkb9S
         uH/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqa13Rb7mvLS5wwOhNuI/Cn6K21gZzlrGKFNbSSI8NskzMn3zc7yB+VjDlxiLYRSlYhBJxebsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt7WBP/yj+reF1DJT9Xq1DsKqwiRz9/NZNjdAZOIZ4e8Aca3W7
	QLkcS4LLeQjzQTZb9hynmKu9o0Czoglif51DJgZmKpWJmYTZa+otG7NEfleXpJbm4RQ=
X-Gm-Gg: AR+sD12QCq+mHUaYQA49vLvfR76PVymm2CzQGQQGMirWhSL4xhnGcdqbs7OZygJvRe6
	4mxAQvC+dYv1BQ8Rx/5Ib8HlX7Jra4BYPmnlTb+SoGNoZhTSiZEmfiJjNUWAJS0fMWdlCucTkpX
	56mYMv0+L5msXgwoF9sOAsMdltTlBS37N2cp9i+wRNnRpFGyt+mCE3U73OzoLhVegtCFz00qxLv
	S8zlOQzAUbVFwY5RBW3eHPb+PtDcNSy6K4+cYxoppYRXCy3zEIi4OFa6FeBPhNCMqUA8s1s8svF
	HUiuODZYpNiy4X9KncgoQivVRI1RdknA5sVUMf/YeMFM3blbVXFIWrGSMQtHdQhEwHo7pZwoYvV
	WwPdZbp8qQFhQslCec9N4/ilYub0UTuDlIvpcz0XjvlTYp9Bitrm3qz5EqPGScaksnJvf3Nb1P6
	u1tMZxqB4g48mNIJPI9F9DWSfqZnl5PkIAFQVlWZfp9FSVBQoFuIy2syXKiZ8iGY4EJWPT4Iv0c
	qVBYPkLtsqhkSy/oXrVlvFM+Fl1RbWPz7wwz0uETfkPvz88Mg==
X-Received: by 2002:a05:620a:70f2:b0:92e:603f:1f20 with SMTP id af79cd13be357-937394e9257mr431611785a.2.1787323808787;
        Fri, 21 Aug 2026 07:50:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720493f35sm609512385a.9.2026.08.21.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:50:08 -0700 (PDT)
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
Subject: [PATCH 2/2] mm/madvise: use vm_normal_folio_pmd() in cold/pageout PMD range
Date: Fri, 21 Aug 2026 10:49:47 -0400
Message-ID: <20260821144947.167382-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821144947.167382-1-gourry@gourry.net>
References: <20260821144947.167382-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmap a VM_MIXEDMAP region whose ->huge_fault installs a PMD through
vmf_insert_pfn_pmd() - mshv_vtl_low does this, and needs CAP_SYS_ADMIN to
open - then

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
walker already does with vm_normal_folio().  The huge zero PMD is already
handled further up by is_huge_zero_pmd().

Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
Cc: <stable@vger.kernel.org> # v6.19+
Assisted-by: Claude:claude-opus-5
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/madvise.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index ffd6a68320a8..ab362bc482a5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -393,7 +393,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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

