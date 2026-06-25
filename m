Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1392F7F03
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387771; cv=none; b=fsntfMcyqUQTnbjQcW08SwUq6BX7BAuXEkJnvDkG1AOBQfTfNaBvLyQFCBeoG9o0b24vZOvf3e1Uo/vax/fZ6aTpBRp7G0FZYkTLXBORyPiqZI40gSdkqNaGHiQU7ody1U68XctUdxWhOlQ2jK5Hrqf5gELDD4V5/rsHQ6Safjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387771; c=relaxed/simple;
	bh=RlbUG+Pc+Byy93Ly2d81Q/P7bwU30F/oK3PSYJP3ap0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omt1r24jSpNAQsNItZQ2XNLY1AlmxqUxHuWVX2pYjCYPpcIZ+5UFlydXJJhheAqZonKzCL9WgSULuI2XbW6fEzNbcNLhIDwIeIwDu8eXi0PW6/KYnLcpNHdTUedbKixqHjzXM05UH7QwtHc5HFes+uJ9ILrI9/0Fm0o29bnqjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dzqAtWAy; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dzqAtWAy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782387766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIWPblH51guS5xkGlOLDh1Cowk9hcXc97vRIu7QXNA8=;
	b=dzqAtWAy92LgGrBYUpeYiyI+geAzdk11MZAp61pXhyjOW+4UHgXuszSfFsuexOdLAE7LLH
	AdcRSiXLKwnKLA5WszKWa+glQK0zPNce2XBAUrvVV1C8k1S/weKOAyR7Xw2a8u8N96JA7c
	nuXUz7AQcNVD6DOeb49LJs6nv991Wec=
From: Lance Yang <lance.yang@linux.dev>
To: richard.weiyang@gmail.com,
	david@kernel.org,
	balbirs@nvidia.com
Cc: akpm@linux-foundation.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	ziy@nvidia.com,
	sj@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private PMD handling
Date: Thu, 25 Jun 2026 19:42:35 +0800
Message-Id: <20260625114235.40611-1-lance.yang@linux.dev>
In-Reply-To: <20260624085756.6598-1-lance.yang@linux.dev>
References: <20260624085756.6598-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Wed, Jun 24, 2026 at 04:57:56PM +0800, Lance Yang wrote:
>
[...]
>>
>>Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>>Cc: <stable@vger.kernel.org>
>>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>Suggested-by: David Hildenbrand <david@kernel.org>
>
>Shouldn't we add
>
>Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
>
>as well?

No need to resend. I think Andrew can add this when applying :)

>v4 mostly follows Lorenzo's comments, code bits included. Feels only fair.
>
>>Cc: David Hildenbrand <david@kernel.org>
>>Cc: Balbir Singh <balbirs@nvidia.com>
>>Cc: SeongJae Park <sj@kernel.org>
>>Cc: Zi Yan <ziy@nvidia.com>
>>Cc: Lorenzo Stoakes <ljs@kernel.org>
>>Cc: Lance Yang <lance.yang@linux.dev>
>>
>>---
>>v4:
>>  * refine subject and commit log based on Lorenzo's suggestion
>>  * put pmd device-private entry handling in its own if branch,
>>    suggested by Lorenzo
>>
>>v3:
>>  * remove cleanup part, only fix the issue for device-private entry
>>  * refine user effect description based on Lorenzo's suggestion
>>
>>v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>>  * specify the possible error case of current code and user visible effect
>>  * besides fix, cleanup the pmd entry handling based on David's suggestion
>>
>>v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
>>---
>> mm/page_vma_mapped.c | 20 +++++++++++++++-----
>> 1 file changed, 15 insertions(+), 5 deletions(-)
>>
>>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>index 2ccbabfb2cc1..17dff8aab9f9 100644
>>--- a/mm/page_vma_mapped.c
>>+++ b/mm/page_vma_mapped.c
>>@@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>

Never mind my race comment below. Obviously missed folio lock there. My
bad. Don't have a caller like that. Nothing else jumped out, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

Cheers, Lance

>
>Hmm ... looks like there may still be a race here ...
>
>Current code picks the branch from the lockless PMD value:
>
>		pmde = pmdp_get_lockless(pvmw->pmd);
>
>		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>			pmde = *pvmw->pmd;
>			if (!pmd_present(pmde)) {
>				softleaf_t entry;
>
>				if (!thp_migration_supported() ||
>				    !(pvmw->flags & PVMW_MIGRATION))
>					return not_found(pvmw);
>				entry = softleaf_from_pmd(pmde);
>
>				if (!softleaf_is_migration(entry) ||
>				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>					return not_found(pvmw);
>				return true;
>			}
>		}
>
>But after taking PTL, the PMD may already be a different non-present PMD
>type:
>
>CPU0: pmde = pmdp_get_lockless();   // sees PMD migration entry
>
>CPU1: remove_migration_ptes(src, dst /* device-private */)
>        ... via rmap_walk(dst) ...
>        page_vma_mapped_walk(&pvmw /* src, PVMW_MIGRATION */)
>          returns with PTL held for the PMD migration entry
>        remove_migration_pmd(new = dst page)
>          installs a device-private PMD
>        next page_vma_mapped_walk()
>          drops PTL via not_found()
>
>CPU0: takes PTL
>      pmde = *pvmw->pmd;            // now device-private PMD
>
>So when PVMW_MIGRATION is not set, current code can return not_found()
>before we even decode the locked PMD as a device-private entry.
>
>Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>device-private entries") made the
>
>device-private PMD <-> PMD migration
>
>transition possible.
>
>set_pmd_migration_entry() can replace a device-private PMD with a PMD
>migration entry, and remove_migration_pmd() can restore a PMD migration
>entry back to a device-private PMD when the new folio is device-private.
>
>Maybe decode the locked softleaf entry first, before the migration-only
>checks? Something like this on top:
>
>---8<---
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index 17dff8aab9f9..97babd408dba 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -249,10 +249,18 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 			if (!pmd_present(pmde)) {
> 				softleaf_t entry;
>
>+				entry = softleaf_from_pmd(pmde);
>+				if (softleaf_is_device_private(entry)) {
>+					if (pvmw->flags & PVMW_MIGRATION)
>+						return not_found(pvmw);
>+					if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+						return not_found(pvmw);
>+					return true;
>+				}
>+
> 				if (!thp_migration_supported() ||
> 				    !(pvmw->flags & PVMW_MIGRATION))
> 					return not_found(pvmw);
>-				entry = softleaf_from_pmd(pmde);
>
> 				if (!softleaf_is_migration(entry) ||
> 				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>@@ -266,7 +274,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 					return not_found(pvmw);
> 				return true;
> 			}
>-			/* THP pmd was split under us: handle on pte level */
>+			/*
>+			 * THP pmd was split under us, or device-private PMD
>+			 * changed under us: handle on pte level.
>+			 */
> 			spin_unlock(pvmw->ptl);
> 			pvmw->ptl = NULL;
> 		} else if (pmd_is_device_private_entry(pmde)) {
>--
>
>Anyway, that stuff is getting kinda messy now. Feels like it really needs
>a cleanup on top before it bites us again :)
>
>Cheers, Lance
>
>> 			/* THP pmd was split under us: handle on pte level */
>> 			spin_unlock(pvmw->ptl);
>> 			pvmw->ptl = NULL;
>>-		} else if (!pmd_present(pmde)) {
>>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>>+		} else if (pmd_is_device_private_entry(pmde)) {
>>+			softleaf_t entry;
>>+
>>+			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>+			pmde = *pvmw->pmd;
>>+			entry = softleaf_from_pmd(pmde);
>> 
>>-			if (softleaf_is_device_private(entry)) {
>>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>+			if (likely(softleaf_is_device_private(entry))) {
>>+				if (pvmw->flags & PVMW_MIGRATION)
>>+					return not_found(pvmw);
>>+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>+					return not_found(pvmw);
>> 				return true;
>> 			}
>>-
>>+			/* device-private pmd was split under us: handle on pte level */
>>+			spin_unlock(pvmw->ptl);
>>+			pvmw->ptl = NULL;
>>+		} else if (!pmd_present(pmde)) {
>> 			if ((pvmw->flags & PVMW_SYNC) &&
>> 			    thp_vma_suitable_order(vma, pvmw->address,
>> 						   PMD_ORDER) &&
>>-- 
>>2.34.1
>>
>>
>
