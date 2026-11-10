Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334685;
	b=TH5H74Mn2pUzy59x8dve9zl2u/18twNvFmrggSyV5ZKnZJ4x3Lp6X0tsCy+o7UNvgcyF
	 SuPPdhwCdBsyGjXM9L+y8iWEW/uhOEICBrAazgTUkUFaFh3FberXNoZys3zqFaP2b6Qfi
	 CpYczZrFfVdYBYBgGPjtR4hysiNT1i1QOjYzbPD7xhhpdAL7Tb8Opjyn/ONgB/RnuLias
	 zVpawS0E40qriAgmMUMkX2o8mZ8toG6s58tKYurhr+Ehi2Xl+VRRCnEC4om38gCVMCuwu
	 uv7R1hVpKWLNrGp7eDvS0ojTHz2x1P2r5ksGAaUpIacJA6B1YMRMl0HGji8fHoWJGqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2HBScDImKLLrptw2BEy4ZGq37EdQXn1yF7qYMsudvN8=;
	b=dQjBqK44Et4ppNiKb2sFYeWvpEplK5yUpGRthlyPS8/LS0J0gl5an4wqvmX1fx4esTWg
	 1x1WtfZVrPImiDAPxe2wXgXI8DjhnFGDM7tPJCTXKQKMPCQyL/uJf+cAIlqjxT+oihbHE
	 vsdU1ZO510R8AbYc091zFj9K67KdSZ1vWfyx/KBisr9bWEeOQny2Di8PzMU3pgTAbtvRm
	 qDV3yJxo8kOsRIQSTnYlye03RftcLUUan3rfeBMAawwyKTCa6Nr3ci+OxvtNVl2LF+GTi
	 Ji3yyk8ur2AupWVG9434ZiEsWj2xFuB/LFEKC+zBN/aXKfoSvSkOrgtFV02OwBdYRjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2JGqN5N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC259606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2JGqN5N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DA71F0089F;
	Tue, 10 Nov 2026 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334684;
	bh=2HBScDImKLLrptw2BEy4ZGq37EdQXn1yF7qYMsudvN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L2JGqN5NE4Pbwl5jS7DvqT5Yc5iSQgHsVPao83rx/y0l9ZnuPCd55lzB11ePUS84S
	 pjsY83rFco74tYI0OhtH4bVymJtqjnRHrvcmFu4B6uTn03fVoD19slerOwyW5Uh+Pl
	 DypMOEZ3c5XP9NB5DBPf3Z2mSoYw+TgeaRsqDf+DqlRs2KfTeHb01V34WAj4LFnNXl
	 YSiq+FQv4TqJTUjBYrBVwkIkM6HT8HHQHSOXHj3W09JEx1GVeHHJh9sgdIO63WFtsW
	 9gfQsnM4gVuVsCxcHZRjJqfNAkngGNp80ZbGhys7/q0ee6tNUUkzjmMnl5TTYlPOqO
	 5ZavN5bzXilTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luxiao Xu <rakukuip@gmail.com>,
	Ren Wei <weir@nebusec.ai>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vega <vega@nebusec.ai>,
	David Hildenbrand <david@kernel.org>,
	Grazvydas Ignotas <notasas@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/memory: constrain generic_access_phys() to page boundary
Date: Tue, 10 Nov 2026 13:18:01 -0500
Message-ID: <20261110181736.3124997-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053258-failed-6.6-ae0298a5fbef@kernel.org>
References: <20261107053258-failed-6.6-ae0298a5fbef@kernel.org>
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

From: Luxiao Xu <rakukuip@gmail.com>

[ Upstream commit ae0298a5fbeff32951c0d31398ccec97ec6aa0ea ]

This patch addresses an issue in generic_access_phys() where accessing
memory across page boundaries in PFNMAP VMAs assumes physical pages are
contiguous, which can lead to accessing unintended physical memory or
exceeding VMA boundaries.

generic_access_phys() improperly validates the memory access range: it
only validates the start address using follow_pfnmap_start() and passes
PAGE_ALIGN(len + offset) to ioremap_prot().

This poses two problems:
1. In PFNMAP VMAs, consecutive virtual pages are not guaranteed to be
   physically contiguous, and individual PTEs may have different access
   permissions or writability.
2. The mapping may cross VMA boundaries if len extends beyond vma->vm_end.

Constrain the access in generic_access_phys() to at most the current page
boundary (PAGE_SIZE - offset) and map only a single PAGE_SIZE via
ioremap_prot().  Since the caller __access_remote_vm() already loops over
the requested length and handles partial transfers, it will naturally
iterate over the remaining pages.

Also add a missing (resource_size_t) cast during PFN re-validation to
avoid truncation on 32-bit PAE systems.

Link: https://lore.kernel.org/e06e28a46c2a176238f03b5740df0913e57c2861.1788842306.git.rakukuip@gmail.com
Fixes: 9cb12d7b4cca ("mm/memory.c: actually remap enough memory")
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Grazvydas Ignotas <notasas@gmail.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: Adapted to the existing follow_pte() lookup and pte_same() revalidation instead of follow_pfnmap_start() and individual mapping checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6d4a1032ca61a..58e02166955d3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5765,6 +5765,12 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
 		return -EINVAL;
 
+	/*
+	 * Limit access to one page at a time, as that's what follow_pte()
+	 * guarantees; expect the caller to retry to read larger ranges.
+	 */
+	len = min_t(int, len, PAGE_SIZE - offset);
+
 retry:
 	if (follow_pte(vma->vm_mm, addr, &ptep, &ptl))
 		return -EINVAL;
@@ -5777,7 +5783,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if ((write & FOLL_WRITE) && !pte_write(pte))
 		return -EINVAL;
 
-	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
+	maddr = ioremap_prot(phys_addr, PAGE_SIZE, prot);
 	if (!maddr)
 		return -ENOMEM;
 
-- 
2.53.0

