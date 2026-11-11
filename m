Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434420;
	b=nK+tousIVKymXuaGT+hGMBjMpCti4trJjLb69hxiBzdftiOzOkasg7vYgFJZKDlyrIlh
	 Or2bEUJ72gHdyO7UFHq3wrWNYFmYCVFXeIuNl5ZdmrYyG1XnrjlxdoIYQ+453GHdsg4vH
	 2evtacmDKUE+yLPAK9ZovUZTvQcD2DmEOIayD8wWkg6HJJnqtZTmAL9k0E0r3kS76siJa
	 U1MJ4BVsxRWD0nYzVg6DEHf8LG02Dd3EH+LHr7AnlVbaZr73yORDjUGODRGtch0nyt6pD
	 WMgSCUetAJRLnst1D4ZmdjtFWTYyo9c+HMCDK/dlYpR8UZEIoyPrBOuNZYCltOs4aoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434420;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dsExlSronX8FZ2ybTbfKUty77l62irOlolHhcJPSkxw=;
	b=vNXh4W27aQ6tQNzww0aEPMix+KRcBV7IeQfT19ItgeZfUgaek64n/ucun+1de6ghbvnh
	 TR96rOvXXl1sSQkZ3P+oP8YyNx0NAMegoQv7rto2AcVQ8w6fd3OadHxsidKOLlL/PkQY7
	 Ow+1Y/nOY27pAbx8GMfTaTv+GWPdXyr0Zx5jVWa77Vt4lEktED30jQAoTEjhy/o+fokr7
	 hLvvq6Wd7dc7znPJsC520pXl+qIeqW+m/IUFqqAMOlRjq5tbmMnhfOkJYFGaKn5zGUMF2
	 N5yPI3hAWb+63+H6DFmYiCAZTZKqpEi9SC//jlk6+YQOcKGtBIy+kES0Pj0/JCSgPVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDIVWdWa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5E960A382A;
	Wed, 11 Nov 2026 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDIVWdWa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6884E1F00A07;
	Wed, 11 Nov 2026 22:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434419;
	bh=dsExlSronX8FZ2ybTbfKUty77l62irOlolHhcJPSkxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YDIVWdWavpLnnBM/PFAhd6PZr/mwm7ExUTFbVqWP5Ajf+PUDNv3s2IdtQhOTxpBe8
	 aPFJA4v1lMdr6S/XNQiknu+li2y8nXgZvpzj+1kpwTZT5bnGRJnymA60DoVgQZu7kv
	 inKony10gi/xVZAHVoAacAuibhztE/uJzhPWaaGIYI6FLeyzVFRsI4LUzuj2V+EsMp
	 SNVRhLKFkwWclKwXMBM48JiYIZPCKpwxIQw5mpS+nkvsA/TGR9IizyqbWdbs6Mea5q
	 rVyKST/Axw6CqnU68kKHo5LfMht1VWevDU6mmcq/f0yf+kc7dAvMtBE1ctSAYTWVzz
	 LT29YrgRgxWYQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 11 Nov 2026 23:00:00 +0100
Subject: [PATCH 2/3] mm/rmap: fix PTE table overruns during batched unmap
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-pte_table_clamped_end-v1-2-2dbe339c487a@kernel.org>
References: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
In-Reply-To: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Peter Xu <peterx@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, 
 Barry Song <baohua@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=david@kernel.org;
 h=from:subject:message-id; bh=NCRqXSs2UWcZHc60tsEtuDGoKWTuIDJIrKjK6A4XeBY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+PE2deoJdQX9NVHVyydSpX9bPvrvqK1Pl5/I3s9mNg
 vdt9DI41FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEFrAwMvxln3TllKr3j0OT
 vWbI6X3n6Djgs7tRwsI/8b2hRt7E9fMY/me2SHBI+D210wyfE8j8y0L28wwHTbVZa+7wuuxlDjd
 R4wYA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

With a folded PMD, pmd_addr_end() simply returns the supplied end.
folio_unmap_pte_batch() can therefore walk past the PTE table when
unmapping a large folio.

Folded PMDs are uncommon, but can occur even on arm64, for example
with 64K pages and a 42-bit virtual address space.

Use pte_table_clamped_end() to clamp the range to the PTE table and
VMA boundaries.

Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 0faef46806e5c..491a954b7fa44 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1978,7 +1978,7 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
 		return 1;
 
 	/* We may only batch within a single VMA and a single page table. */
-	end_addr = pmd_addr_end(addr, vma->vm_end);
+	end_addr = pte_table_clamped_end(addr, vma->vm_end);
 	max_nr = (end_addr - addr) >> PAGE_SHIFT;
 
 	/* We only support lazyfree or file folios batching for now ... */

-- 
2.43.0

