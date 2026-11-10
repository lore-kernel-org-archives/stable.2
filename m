Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335457;
	b=ltckZX/ZuMURQvCXMVHJIEarpm/UeDoEQpUiTVgiMDNibFw7Jp0GxnuzV/Un1Gx+jVu8
	 8bU1lUjYJ7yXOP5UDRhgeUC6OxKYp4LjgxDKpdLd4Y+2NmhDzPVw0AaxjM1atp7y/q8eN
	 xXsP21qPwcoK/qAFTYBp6qz78kBoi6Eeqr3m4xXsEtSPRWlYWniKXXaTgTLK7lUhqQ660
	 nublvbYPyE0Wv42ipbvdoBeyoge13eSHHi63JSz8XeWOouX73A0XeDuvJ+SuhjJXA7wv0
	 /YB1ugJY0kilCbF5ulXMc2dlV+7gnPDzRGtNbErMvTKxhQHqXJV/cWDyaCWwrrcOy8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aGs81ife7P2XKdJnJe+ITtf8ewdiKwUtHvpzM9J6Hj4=;
	b=XAbKc7bmKEuIix0WaQURdjmjPL3dLRgz8KaNnZbfb+asu+gy8t5FGiDc73T5r218AHLe
	 i2b2hAQCSYL+JHc7zp7kE175l+pvjeQr4tlXFokGUGHD1GEf/3hQUpb8YV70WWamAtQNd
	 uAA102uvmf8I81R6UJKUqy/x5266DtFLcnhdBny6JIxm9zb3u1Eh1cvrjF60rVokRX87L
	 1RBYdodSENJsU4lThBXMALLFghorkxBvZqXpqo0qHay32VIPMeRsYHDz0Kqky7KUlbDiV
	 i0TL5yGQkE6JQzr17KfHNaTLTCg4w5pZXlxPIqv6C0lJSpNFKSq1SfH3cwv+a3nxMLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzEQhZ49;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzEQhZ49
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD0C1F0089F;
	Tue, 10 Nov 2026 18:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335457;
	bh=aGs81ife7P2XKdJnJe+ITtf8ewdiKwUtHvpzM9J6Hj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzEQhZ491kpLSUAm65o+PWLZZR5tXTH16g1v9T94guvjRoVMV7px7NSx0l2+Q7lOW
	 d7tF30LRh2u6X4ayO3+UNLZJiKMWi02EELJyjqaLv4PMHPHEX50+KeB8IN2Li85xPv
	 boSwLiffhfQxok5SsyUCpwSXw0JXMNCLZP5MST99H6qqVJYihDTigdqOdnjWX7qSBH
	 xAulGV9EynPSy6c7CxiGygkVYF1qr6Mtw5B0H+sCA8OqUV408CWUvAUg/BfWQYFRYj
	 dcW2J6rT2BXiHk+2lApBi3QX3Bmv4kuuDRPasR3/f0O4sVGy454o3Qm0dRMMdutBP9
	 I/jk1gHPG8/RQ==
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
Subject: [PATCH 5.15.y] mm/memory: constrain generic_access_phys() to page boundary
Date: Tue, 10 Nov 2026 13:30:54 -0500
Message-ID: <20261110183016.3265890-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060319-failed-5.15-ae0298a5fbef@kernel.org>
References: <20261107060319-failed-5.15-ae0298a5fbef@kernel.org>
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
[ sashal: adapted to the existing follow_pte() implementation instead of follow_pfnmap_start() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index e5c54f39e7e04..cad3566f5651e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5158,6 +5158,12 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
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
@@ -5170,7 +5176,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if ((write & FOLL_WRITE) && !pte_write(pte))
 		return -EINVAL;
 
-	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
+	maddr = ioremap_prot(phys_addr, PAGE_SIZE, prot);
 	if (!maddr)
 		return -ENOMEM;
 
-- 
2.53.0

