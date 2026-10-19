Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB3723BD17
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792371755; cv=none; b=YCP48JmZJlAfwqr+5kJBHptstoRCd2hChyV/bwcpcfl4ET9b+EXCVv7WYziSPjbuO2b+RG72FEAgoiRciL0VYtifb5rYNv5e4LwetCc/zIpoIdtbdRofFTIpLbIe0tYBRq0vQ4QYpNgawzIs4/60piPaH26gegWdolmXis+koaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792371755; c=relaxed/simple;
	bh=7SU2HNON/BqLq2bv/cBKuk5LpU1ziW+Kvf5YYswTIMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBOJtyXTodKsJIyS20pc1LkbOlQrI2WWrFc7rENh5l1WpT4Hcy3EThms+f/mQu7FNvEgmDxMGzA3QtS1hD/FahcqSsRCKn3rfm1vPEbp5yRMZ5KpodjsB5lSEq/C40TB1dwqBk5hGM/jJx6TcJy1Ufk2gQijUmp2klJDcrXVPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V5Q54Or0; arc=none smtp.client-ip=91.218.175.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V5Q54Or0"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7SU2HNON/BqLq2bv/cBKuk5LpU1ziW+Kvf5YYswTIMs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792371750; v=1; x=1792976550;
 b=V5Q54Or0jGTuNpPsKosHfm8ybonnXKSHjGN7wJImYDTyrcP/Xby+C5jLIuLAf5LCl05iBLMf
 0yL5M1HVZdvW72E79PTFS+k4U3IHx01WtNMlVWHeZvqs9dtDEAsUNf2lMVw+l6PlWMPUtVy8zEm
 GR//fK5+cBH7JPr6hLb46adA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9ff5fbd1b53f1ea9;
	Mon, 19 Oct 2026 01:02:30 +0000
X-Mizu-Trace-ID: 9ff5fbd1b53f1ea9
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: samarth.colleges@gmail.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org,
	lance.yang@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/ksm: keep soft-dirty and uffd-wp when merging a page
Date: Mon, 19 Oct 2026 09:02:24 +0800
Message-ID: <20261019010224.69153-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261018122957.526467-1-samarth.colleges@gmail.com>
References: <20261018122957.526467-1-samarth.colleges@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Oct 18, 2026 at 05:29:56AM -0700, Samarth Narang wrote:
>replace_page() maps the KSM page with a PTE built from scratch, so the
>soft-dirty and uffd bits of the PTE it replaces are lost. Due to this, a
>write before the merge no longer shows as soft-dirty, the next write to
>a uffd-wp page raises no write-protect fault, and because the page is
>mapped with the VMA's normal permissions, on a uffd-rwp VMA the next
>access raises no RWP fault.
>
>Copy the soft-dirty and uffd bits from the original PTE to the new PTE,
>and restore PAGE_NONE for RWP VMAs, as try_to_map_unused_to_zeropage()
>does.
>
>Fixes: 292924b26024 ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
>Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
>Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")

Shouldn't we use these two instead?

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")

At 292924b26024, WP registration still returns -EINVAL. RWP registration
isn't enabled at 763f43865fc4 either.

Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")

As for soft-dirty, the tag looks fine to me :)

>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
>---
> mm/ksm.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/mm/ksm.c b/mm/ksm.c
>index dbfb8f98b189..b0d0555aa1b5 100644
>--- a/mm/ksm.c
>+++ b/mm/ksm.c
>@@ -34,6 +34,7 @@
> #include <linux/memory.h>
> #include <linux/mmu_notifier.h>
> #include <linux/swap.h>
>+#include <linux/userfaultfd_k.h>
> #include <linux/ksm.h>
> #include <linux/hashtable.h>
> #include <linux/freezer.h>
>@@ -1463,6 +1464,18 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
> 		dec_mm_counter(mm, MM_ANONPAGES);
> 	}
> 
>+	/*
>+	 * The old PTE may carry soft-dirty and uffd-wp state that tracks writes
>+	 * to this address. Make sure to preserve these bits in the new PTE.
>+	 * On a uffd-rwp VMA, also restore PAGE_NONE.
>+	 */

Nit: the uffd bit also carries RWP state, so "tracks writes" doesn't quite
cover it.

Maybe:

/*
 * Preserve soft-dirty and uffd bits when replacing the page.
 * Restore PAGE_NONE for RWP-protected PTEs.
 */

Otherwise, LGTM, thanks!

Tested-by: Lance Yang <lance.yang@linux.dev>

Cheers, Lance

>+	if (pte_soft_dirty(orig_pte))
>+		newpte = pte_mksoft_dirty(newpte);
>+	if (pte_uffd(orig_pte))
>+		newpte = pte_mkuffd(newpte);
>+	if (pte_uffd(orig_pte) && userfaultfd_rwp(vma))
>+		newpte = pte_modify(newpte, PAGE_NONE);
>+
> 	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
> 	/*
> 	 * No need to notify as we are replacing a read only page with another
>
>base-commit: 48fe11c8d0f1e4e59426a3606f20ac1130b6d8dc
>-- 
>2.53.0
>
>
