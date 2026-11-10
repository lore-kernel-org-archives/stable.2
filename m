Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351195;
	b=2TCfCie3DhDORgznH8/gWrw2jWhNDv2yvaBibwoLqW9n/ixHLJ1yEu7n0sJN6ti86lm6
	 2lZF64kwRcgfelAmYzYnTkPZqh9ssFwT2e5yi8WnV3nVai4ElDM0gyRWpdAWQuUGf+cyA
	 3tPBCUd2h902qkUb7OqENuJH4edbfXWiVbXIER8XdcIi7K2HaYTyikbG8A3WL9oopZoeg
	 w+Pq80dt83wRXn+99uuI+sFjHUiBKm9wxISNwTKtgeOE9+qg35Ue9zbKMWgqRyaEWtRQo
	 Eg32WBWsteIdt1+EOV8PP4NRuwNl35DZzgWvH2Q6x1QkGn2npmFSTB5u/koSfjlF6mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351195;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zpNbtuPAByFmfs1SZ0VPEDSa+rjep9K3tD5D8ZNStNU=;
	b=QTeoMs5Udkb6bapYr2YDhE2PjayhMbo8J7gi6sDvHAseiDR7OHxSQ7QgmlPbiUHyGbkZ
	 DYHZVpHuafd/S4RbXtBe+xVroXrpV5q4drU9SRW9xJt6Kx1VibfLigaWjF5j7x/BwU7Cy
	 HP/AuPgWLWyWPTWfCAzhuJeg2i0egJVk1AxZy5jM2DgtV4ciImZ3PJ7iaIwRC9ttfxJ5a
	 goH0NAju7mh9b4i110yMxy8aPgXUgqR6LMpJLxX1Fsp9ye9CfwYc6HAuJcsd+N6RWqWCk
	 4uaiMD58spDEQE6rHboM3OAPlRww6E7Wu7qvz/SXxRa8Zk0IZ4W9B61T3u34S0VkStw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Naspeqem;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA918606A339;
	Tue, 10 Nov 2026 22:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA918606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Naspeqem
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3288514BF;
	Tue, 10 Nov 2026 14:53:11 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE97C3F85F;
	Tue, 10 Nov 2026 14:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794351194; bh=un/IQBbksKXsB3Pu9IX4OmSWdn3NPEIzpFQoRSFYVs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NaspeqemBgPiDtjDssaFV0lv9CsQ3xLiFOGP7avtVwuP/9uooxstfLCgEErCDpxEY
	 k9ZzP7Cj685xVVuHXNpsGc/f7LkUK9yr9aA1QbEoddKhbT/ZCeucizo3VKyDBDGwSA
	 5fhBlk7X8X0bRkBq1zdzeNZoroFwCF4+4Mx8kQIY=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Tue, 10 Nov 2026 22:52:51 +0000
Subject: [PATCH v4 1/6] mm: khugepaged: ignore MADV_HUGEPAGE for shadow
 stacks
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
Message-Id: <20261110-refactor_gup_fast-v4-1-e779a7674274@arm.com>
References: <20261110-refactor_gup_fast-v4-0-e779a7674274@arm.com>
In-Reply-To: <20261110-refactor_gup_fast-v4-0-e779a7674274@arm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Yuan-Hao Hsu <aa9736195201@gmail.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2302; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=un/IQBbksKXsB3Pu9IX4OmSWdn3NPEIzpFQoRSFYVs4=;
 b=kA0DAAoBbdXD0VrFMTMByyZiAGrzoFKj+16o9hXh+iUvEHeS696tCnaqaDSUDfs1FECpmRVLO
 IkBswQAAQoAHRYhBC2D4JLdBTO4WHWknW3Vw9FaxTEzBQJq86BSAAoJEG3Vw9FaxTEzJH8L/RG/
 GMcKAY3gf4lDO6k+Jv4GEaHmFyeXBxNLmNNLozApZhPm5IciHwHh4sb0lxu/xavFXG3HTlnVki8
 Z2XIBuByoh9A3B+94eKje0gFUpwrgQVAKcY17A1AyVsitX9bKb53Jy5nhOy9QxQK+UBgxMO9oXF
 RHtHcvDgC1SJEwguVlxtR0XrJgDKY8V8doZwX265BjQBeIDN4CsZS3oGAk/W47Ng/TdeEG4g6dN
 keZePpipeNEplpw5PJG17iIHdzNh1de21HwHetf7CkPcihUhddB4yf7U6NpVZm7uDqwjrrhrv/a
 bP0qDf2TCugS1HPpymyhCrM5FglEOE/S8JQDaFPrpo4LO68HT9MB1qQFkLPRkrQirmlNhDzAXMC
 xjHpS9MHl/Cq0HmFFbc+aHM5rXShBS6MkNN0vbKW/MXNxwrRidXrbT2Cw/Ew+oohrjsvlparj2V
 xxTdFp4gDR2oUUw1bQCdYyAKDqYnlUhv4mkt5mogmPcaX9/LvL8AUDH8t5rA==
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

commit 3efb9800557b ("mm: do not map the shadow stack as THP") makes
shadow stack mappings default to VM_NOHUGEPAGE. However, userspace can
still clear this flag and set VM_HUGEPAGE through madvise().

Allowing large folios in x86 shadow stacks exposes a limitation in
folio_pte_batch_flags(). For example:

  1. create a shadow stack mapping.
  2. apply MADV_HUGEPAGE and populate the mapping with a PTE-mapped
     large folio.
  3. apply MADV_DONTFORK to the first base page of that folio.
  4. call fork().

In the parent, the first page remains writable and anonymous-exclusive,
while the remaining pages shared with the child become write-protected
and lose PageAnonExclusive(). These pages can still belong to the same
large folio.

On x86, writable shadow-stack PTEs have _PAGE_RW clear and _PAGE_DIRTY
set. Write-protected PTEs have both bits clear, with the dirty state
preserved in _PAGE_SAVED_DIRTY.

When FPB_RESPECT_WRITE is set without FPB_RESPECT_DIRTY,
folio_pte_batch_flags() normalizes PTEs using pte_mkclean(), which clears
both dirty bits. This loses the distinction between writable
shadow-stack PTEs and write-protected PTEs, allowing them to be grouped
into the same batch. GUP-fast can encounter such a batch when walking
across the VMA boundary created by MADV_DONTFORK.

Since there is no practical use-case shadow stack with large folio,
ignore MADV_HUGEPAGE for shadow stack mappings, preserving their
VM_NOHUGEPAGE setting and preventing large-folio allocation.

Fixes: 3efb9800557b ("mm: do not map the shadow stack as THP")
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: <stable@vger.kernel.org>
---
 mm/khugepaged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4bbe319ef86f..510e66d82379 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -367,6 +367,9 @@ int hugepage_madvise(struct vm_area_struct *vma,
 {
 	switch (advice) {
 	case MADV_HUGEPAGE:
+		/* PTE batching doesn't work reliably. */
+		if (vma_test_single_mask(vma, VMA_SHADOW_STACK))
+			break;
 		*vm_flags &= ~VM_NOHUGEPAGE;
 		*vm_flags |= VM_HUGEPAGE;
 		break;

-- 
2.43.0

