Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770838;
	b=eIaGDNNKtZnz+kFDhpIqW6Abhh0Z6UWHTpx/WU8K6/lXlDfLxBhcTUD5APPR4+XodP6I
	 /8KoEIeysGSpIhcmtc7rrrYjDBBtN3zw87pUR8X0x27gEiTyGUDW6SOBFofn4N1RHwZdM
	 n2Iwvtj4OAEqLMNnAjx0QlOItD9LAb0QVy5gZ+8/SZ4oQ3NGRiXyLrJymlmTuQOAeY9vy
	 rN68JdO67WiEYbCsE3YFn4BlP3Vc7It5/wmyHpjhwmGEJsZTsT0XuBwUK+YxRjEYBXgyy
	 WPt+beAuhrrRnWCYr9/WgNzGVacZ9Ht9sM6qs+0fxWUZEgAoc/xaZADz3TD6+yce4TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PbpBQncRyADmzwyT+DIGCOcxAB+kyUykQ1z1tEvlyxs=;
	b=eWpMVbrFqOd9l+gsT2bnz/41O6uo4IHgj4FDLwTUpGAUheoU8XrMfD+IoMZvvbO9zT8Y
	 FqkzYaPzohSL52YHJ6eIcrj1pCt6cFqTUoqcpBt6L6oiFLdNCp+CtuHGa7aT5jdVWL0Qd
	 FltmMHNlf28CoIotswjUcaXEsU4VA0GHcB40QX0ygfLoNZ9H+E3upxThXPEdpRItw7Uw4
	 NNfQVp7xsLelkO623J0DiU1ivktMp1Nx+ot9gFCuZ4D/q8rZQNFxvwrmR02rTb+tP6HUj
	 1MG623FMy26TNadSfcCXHmkpUPb6RO0rqmdH8iLJf+6iaqNvOcB/jm0IY0bS9prMlog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vl+mrKI2;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1C606A324
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D1C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vl+mrKI2
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b8a2518f7cso9202880a12.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770837; x=1796375637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PbpBQncRyADmzwyT+DIGCOcxAB+kyUykQ1z1tEvlyxs=;
        b=Vl+mrKI2phVb7UBD2dDnwkcEm87oSwu2TJUA7Kzq4ru9ChmjHJzW+FlRFTb3JMhj4F
         yUL0obJ+90rI/BLxv1rHWKrPppQvB8RxNKJ60L78UJO0oZaH66xfiuc+2w7fvgNtpufk
         k9QZ6TNp6dIL0BCw0J/iaIlHIudROlBinGhEHPb+yGoDpCYxpTsToKCIGYvcXWUhVSPr
         GR6IxROwrCu4GiHJx9r4leWega28tGch5vhv5tDFrdK6Hp9gCY6to8M4xLTSpPUc9CTn
         5KvIzDDHrZlmhMIbmMjNKc7FEHnr9pbD6GdYPm7tBjuw3rmTEfVLFYncH8MPBo66K+9e
         p8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770837; x=1796375637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PbpBQncRyADmzwyT+DIGCOcxAB+kyUykQ1z1tEvlyxs=;
        b=BR6nxnhIqhywW/WWqa/3xn60tKIt50XkUzGW2xTlWUJqI6JwKV9VmIRqHNiSoRV1Tn
         P5qNb3fqqhhUnnXvQJjLFn4jbNgtAKklL4Qz+TUP9gX7xx3Eg4fnahOcYVMLJUw0kHzD
         w1rEGRC3nyla/OcjEQNxmLavj9qZVh8+Sq3swzRjm4R/B2QOojUFpirNd7w5PrTdODLR
         5R3w0RuYtFh8X4//2GSAp2snFjFbLtCJOXNuxtlfBWWlRbVwUt5Zf1oVRnMuISmGHeqj
         /Qxe5ew4veCwbTkoiz8d4sfgVpKgzz7/nYVMNarr2jQB6+gzeiTSXerhp6cuJ1HiZkTx
         lpSA==
X-Forwarded-Encrypted: i=1; AL+hErFAYHX+SyqCCdAuxqmkpg2nvmZrwLcl7NHnUCu2Ik+7z6Lmp7rALuoy2IaziQDw3QluYxJm7xE=@vger.kernel.org
X-Gm-Message-State: APuU4Z85ALZO2/d8mpyrykY4HkuPeL10P+cts95GRJ2Ovbw7K8m+1JWm
	Z+t47hHQysq3wOOeuUq1S4Ea2iWiNEKKYISsf1lkG25lZD0jfU00vLXe
X-Gm-Gg: AZFdTZfxewMrQN0bLt04sSrMSKubDoQv1i2AI7BuzOSv1awiFrZfUZWKkqyZicNsU0w
	b5wIOhAfrw0KoqXkssCipIqiv+4+PiHPuVq8vKCFyCyiVZ9Sm+ZGOdl2dy1iY4oRgOXHeFas+l7
	ZlrQ7Ga8akXr496XI58U3Oz718pSdc7CRenw9uqTphbJSS3LUas+HlBam4RZwpC9+UpWUnGUj1k
	m37ALY85zcb/U04lDFOfyZWxOV/nKgp+qToxqmIpupnOM/ynm1ObnwA80bd/bNMV/I8NlQOQXbN
	8EfSISA8xIsdnt62eyIur5VKNUS0WUTSb+sgD5ZP+8YRw2YwBrhErW4RDxqsg2D021GPEyzu3Tt
	ZbwUwic/HWsaasMW/qrmfeqIpVqs8ESX0tfUv8SLzdqr5kiamHbBllFmpfau7ThDjEWRQCmOj/b
	TMSXI8rw2Xm6B6j57QVUJdChARDao4DEJmondralV3mag3cEMm89j0yqhy7EvIiR+5eFBwRQJH6
	Mga1+4KbiQu3s2rca2FLuT2h5PwQumfYABPUUL9bkcxso3x9ijLFxyiebSNtwqmNF4V0lQryhMN
	r1gseWOJoeq5CN6PYJc58fWeLTF8uPBFFUY=
X-Received: by 2002:a05:6402:2744:b0:6ba:4ca9:86b7 with SMTP id 4fb4d7f45d1cf-6ba4ca994e3mr17362328a12.21.1795770836265;
        Fri, 27 Nov 2026 01:13:56 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm26067087f8f.43.2026.11.27.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:13:55 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Hugh Dickins <hughd@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Rik van Riel <riel@surriel.com>,
	Song Liu <songliubraving@fb.com>,
	linux-fsdevel@vger.kernel.org,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] mm/khugepaged: allocate page tables with NOFS in set_huge_pmd()
Date: Fri, 27 Nov 2026 10:12:15 +0100
Message-ID: <20261127091344.113688-3-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127091344.113688-1-azpijr@gmail.com>
References: <20261127091344.113688-1-azpijr@gmail.com>
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

try_collapse_pte_mapped_thp() calls set_huge_pmd() with the folio
locked. When there is no PMD table, set_huge_pmd() allocates the
missing p4d/pud/pmd tables there.

Allocating with __GFP_FS while holding a folio lock can deadlock in
reclaim. For example, memcg reclaim on cgroup v1 waits for writeback
that may be waiting for the folio lock we hold.

Allocate these page tables in a NOFS scope.

Fixes: f8a01513f574 ("mm/khugepaged: do not fail collapse_pte_mapped_thp() on SCAN_PMD_NULL")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v2:
- allocate in a NOFS scope instead of before locking the folio (David)
- the deposit table is handled in do_set_pmd() now
- new subject, was "mm/khugepaged: allocate page tables before locking
  the folio"

v1: https://lore.kernel.org/20261125100058.15200-2-azpijr@gmail.com

 mm/khugepaged.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 93d4a6f159e8..2ac8b5621db0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1839,14 +1839,18 @@ static enum scan_result set_huge_pmd(struct vm_area_struct *vma, unsigned long a
 	mmap_assert_locked(vma->vm_mm);
 
 	if (!pmdp) {
+		unsigned int nofs_flags;
+
+		/*
+		 * The folio is locked, and reclaim or compaction with __GFP_FS
+		 * could deadlock on it.
+		 */
+		nofs_flags = memalloc_nofs_save();
 		pgdp = pgd_offset(mm, addr);
 		p4dp = p4d_alloc(mm, pgdp, addr);
-		if (!p4dp)
-			return SCAN_FAIL;
-		pudp = pud_alloc(mm, p4dp, addr);
-		if (!pudp)
-			return SCAN_FAIL;
-		pmdp = pmd_alloc(mm, pudp, addr);
+		pudp = p4dp ? pud_alloc(mm, p4dp, addr) : NULL;
+		pmdp = pudp ? pmd_alloc(mm, pudp, addr) : NULL;
+		memalloc_nofs_restore(nofs_flags);
 		if (!pmdp)
 			return SCAN_FAIL;
 	}
-- 
2.56.1

