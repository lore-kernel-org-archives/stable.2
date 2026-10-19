Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7BA21D5AF
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372335; cv=none; b=jzTRXiLI9BSorpsQp1N9kdFbjMKv0qgwAIPAJbDBSN32+SdNix96KKRYooUgJCHsFOtXHpp7Y3JQuqAbzuAFjZdQEWsnebakyPi3bFm4OKaPpR6H+Ags1Q9gV7lqHflIT0sVU4u1QeJ6IbDoNyNloPX4kxeYSpjcpd70Vn2u6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372335; c=relaxed/simple;
	bh=YuNuB52kvQgcX349nqKkv4i/2o2bUEHQba83Zru1I+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inJVOPseio87xnGbnhLAdo1AgSyjo7FNTejz8QTNLAKVoDS9DxkiQ3HFlkkZ8kYExH3o/ZGuA0Uq/Qj/jACudbtne3gzPwuYxTBxUi1SFKAAgj6Qp8ILaw8x6+7l8Es+/eAwjxURsYgUrmMgb/e1Isb8GZRGecIN1WVxlQRim00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSfTWYOU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSfTWYOU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6d28aa26cso5813495ad.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792372333; x=1792977133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9iMW1/+hYAmRNDgdBSskmyjNh4Q5P7SaRq2YqDn9vmg=;
        b=PSfTWYOU5EUIVR1NV5JpVqiAK4657QXW4DL7WbAH7p+FW1e9huBC8x05Oysc3pbuw6
         8QLZIQlseAOICPW+tzujajx1uVcGqLn2kEbXeRk4mOfAfF2B24sn9jXPnRAp0Qq7nYIi
         Lf/ArIDXjFqsU3ZGM26D0dPWx2kLD+D634Vhv1fgPIbiGxSvGUzCt7GaeS4Xh7FqSL09
         Ws/hdqYNyze7iy9/cVurRg1zjHUowD/8iNnQBa9Soztry5hKs6V/P3N+Kz4bv5XcHHXG
         T+gdoBXJ0r0LM3AHwu/GB4vPgxXZFK5Q9z30OhTQoPaRj/B3OJgRgHW4qs6mOO+UC2cA
         y18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372333; x=1792977133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9iMW1/+hYAmRNDgdBSskmyjNh4Q5P7SaRq2YqDn9vmg=;
        b=aLmayoCadUJRofuDUydAll+asJ3TJLov14WUOGlYI5Aqf2NfX5lINeZirXiMNdqLJH
         odkR5csL3I0hBrlqM3xFa81oxD0BznbojNg5Oyswq4LZycP13IDvVc5aw3dp3Ba4rdWO
         5ALIAZrfqxrsmmTNbD3hM+dxED5HhCZPEpqvHzJ+RvXKTz6ZyVZmagqibdQ1ygm+ULft
         6Uaq+5kEaq4hP3Qi9ce9gZ22xuEAmh0ybFQ6wwAnwwCk5ifB/giWsaM+1CyUKELAlcw4
         InxTiDGl7BTdqK6c9sBLKeYfvQFRWFAKp+z37Cwosn0ysmErIcp7EToo8UpncAbtSMcV
         wp3w==
X-Forwarded-Encrypted: i=1; AKwUvBwSbgyUr9LSH8lbz4t23CdDQqwD5t2gdCSY4JNcZjTUH9ZT3KpICyQp/7RxnAze9WNejZaApTU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAIuQSQJjxoppW/g0ygsLm+J89TWKIMDdBcso9eViPn66Hvsgb
	aZKed88UNDiIDW+ujUAQCbU/kpn+hhZovqoXDLjYDTfwdff4/lleNH6L
X-Gm-Gg: AYBFou0NzBdHTHkCtEuZud+dgkes+Pojreiv3loPoPBi2Fzv5HiAz7rh7kgQ+kSbca1
	whNcFcgHEl22NXJOLL3jPzU68G5cnlks/BXdd1K58/D1PowFgb/a2hksBMrWlxaVuk5LRWMoehN
	3oGqJkFOqi1pNaR/aUNxg27XC9okuOuzVnDxxBqtrJglCtKeuQfMG/RqFf6Vsnl5UOwvygg7Rkz
	fMX2NQWgN5jz4uevLJVKc6dzwAHjm3P+GB1hcIoYrqne0UCEDkb264VswFtGYcxZfDuwNbJ/3dK
	cPvbc5DizUjV0D2UO2+EUfOTz4LhXX8f87u1B0T8S9lCpaet+KDdnRPSLDjRa5kby17aWTXqf9U
	nSUc5IXS7BPH4tmGEOanWPVcV3+0mxLi1YsMPAaUmGSiePq8ef7zdREmq2BoE2UX6TrCm57OgC4
	EBzpZH6LRy2DGcSV0gIxi7e0bWPrBFVBW227BXQT0+S5DgDPHUiTuwhKfJW+BlZonTNFo1V0WwN
	9o5YrUjoLZkNmu8XCJMFmClfwYdbKLWIvO6rWdCs2QCUavAQ8fXfMYy
X-Received: by 2002:a17:90b:390f:b0:3ac:8897:7ba5 with SMTP id 98e67ed59e1d1-3acef5f5bd8mr5441712a91.59.1792372333228;
        Sun, 18 Oct 2026 18:12:13 -0700 (PDT)
Received: from 1u1g-b650-0212.nvidia.com ([72.25.70.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9d266d6sm7011793a91.1.2026.10.18.18.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:12:12 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/ksm: keep soft-dirty and uffd-wp when merging a page
Date: Sun, 18 Oct 2026 18:09:34 -0700
Message-ID: <20261019010934.697895-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

replace_page() maps the KSM page with a PTE built from scratch, so the
soft-dirty and uffd bits of the PTE it replaces are lost. Due to this, a
write before the merge no longer shows as soft-dirty, the next write to
a uffd-wp page raises no write-protect fault, and because the page is
mapped with the VMA's normal permissions, on a uffd-rwp VMA the next
access raises no RWP fault.

Copy the soft-dirty and uffd bits from the original PTE to the new PTE,
and restore PAGE_NONE for RWP VMAs, as try_to_map_unused_to_zeropage()
does.

Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
Cc: stable@vger.kernel.org
Tested-by: Lance Yang <lance.yang@linux.dev>
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---

Notes:
    v1: https://lore.kernel.org/all/20261018122957.526467-1-samarth.colleges@gmail.com/
    
    Changes since v1 (thanks, Lance):
    - Fixes: point the uffd-wp and RWP tags at the commits that make the
      registration modes reachable (63b2d4174c4a, 2d427bb01639).
    - Shorten the comment; the uffd bit carries RWP state too.
    - Add Lance's Tested-by.

 mm/ksm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index dbfb8f98b189..de144fa07c49 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -34,6 +34,7 @@
 #include <linux/memory.h>
 #include <linux/mmu_notifier.h>
 #include <linux/swap.h>
+#include <linux/userfaultfd_k.h>
 #include <linux/ksm.h>
 #include <linux/hashtable.h>
 #include <linux/freezer.h>
@@ -1463,6 +1464,17 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
+	/*
+	 * Preserve soft-dirty and uffd bits when replacing the page.
+	 * Restore PAGE_NONE for RWP-protected PTEs.
+	 */
+	if (pte_soft_dirty(orig_pte))
+		newpte = pte_mksoft_dirty(newpte);
+	if (pte_uffd(orig_pte))
+		newpte = pte_mkuffd(newpte);
+	if (pte_uffd(orig_pte) && userfaultfd_rwp(vma))
+		newpte = pte_modify(newpte, PAGE_NONE);
+
 	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
 	/*
 	 * No need to notify as we are replacing a read only page with another

base-commit: 48fe11c8d0f1e4e59426a3606f20ac1130b6d8dc
-- 
2.53.0

