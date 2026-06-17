Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB11CDFCA
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663549; cv=none; b=GeeEqsuy+KHqtzoG8eyOe9BZS/tez3Zk8nXemTE2jxNtewg1yx4POKLES1pjV/6b+51RmbadzXE8NijxS/4CJ1WnkjDb/X00euznwFxlXZzP/Hvc+nWtUaU+4A63NfuJvQENAeLwF+PH0aPGY2TRW2/Zz0rgtfAexYIO691bIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663549; c=relaxed/simple;
	bh=8Jkg4hWaGSgxim555NVdr/IGldICyHHu0eKJiB7qjp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTlJU3C3dgLfm5AxiSVfWCEPAL4nFy3QlJeAlg+b2VrfHlOwmzzZDRJiNn/A39dWPDauWxfrENRmEXdVPdRuzePtrKY2wAoqqpySSQx/tYXp9orDlONjmZ78ewf+W6Yj/GwbjA1iXiTqfVFszVGjsa8fBz/4uH2CQWiYlDONMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EOPnEcRo; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOPnEcRo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781663545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWSwI0JSp8IpusvL17b7isqNuxgesNcqyUkzefJ+C/g=;
	b=EOPnEcRoyEvrckUiMuG+/W56AB0fjfv6Ssjj7zOAWHhVtqtmbkqSe23THUbNf4yk623rCB
	KKdaBgxBn6yPULoRDg3R5eb4fJrpdPUYPyraPTes0TevoJqpC4OX2BKnX0fcH8iJrheN1q
	4tQ8m/GCPRbWd9hOjxwAnPooOewsAx0=
From: Lance Yang <lance.yang@linux.dev>
To: richard.weiyang@gmail.com
Cc: lance.yang@linux.dev,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	balbirs@nvidia.com,
	ziy@nvidia.com,
	sj@kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
Date: Wed, 17 Jun 2026 10:32:11 +0800
Message-Id: <20260617023211.80409-1-lance.yang@linux.dev>
In-Reply-To: <20260616235022.iesy2jeb2p7zof2l@master>
References: <20260616235022.iesy2jeb2p7zof2l@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Tue, Jun 16, 2026 at 11:50:22PM +0000, Wei Yang wrote:
>On Tue, Jun 16, 2026 at 08:30:01PM +0800, Lance Yang wrote:
>>
>>On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>>[...]
>>>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>index 2ccbabfb2cc1..21635fab209c 100644
>>>--- a/mm/page_vma_mapped.c
>>>+++ b/mm/page_vma_mapped.c
>>>@@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>> 		 */
>>> 		pmde = pmdp_get_lockless(pvmw->pmd);
>>> 
>>>-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>>-			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>-			pmde = *pvmw->pmd;
>>>-			if (!pmd_present(pmde)) {
>>>-				softleaf_t entry;
>>>-
>>>-				if (!thp_migration_supported() ||
>>>-				    !(pvmw->flags & PVMW_MIGRATION))
>>>-					return not_found(pvmw);
>>>-				entry = softleaf_from_pmd(pmde);
>>>-
>>>-				if (!softleaf_is_migration(entry) ||
>>>-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>>>-					return not_found(pvmw);
>>>-				return true;
>>>-			}
>>>-			if (likely(pmd_trans_huge(pmde))) {
>>>-				if (pvmw->flags & PVMW_MIGRATION)
>>>-					return not_found(pvmw);
>>>-				if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>-					return not_found(pvmw);
>>>-				return true;
>>>-			}
>>>-			/* THP pmd was split under us: handle on pte level */
>>>-			spin_unlock(pvmw->ptl);
>>>-			pvmw->ptl = NULL;
>>>-		} else if (!pmd_present(pmde)) {
>>>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>>>-
>>>-			if (softleaf_is_device_private(entry)) {
>>>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>-				return true;
>>>-			}
>>>+		if (pmd_present(pmde)) {
>>>+			if (!pmd_leaf(pmde))
>>>+				goto pte_table;
>>>+			if (pvmw->flags & PVMW_MIGRATION)
>>>+				return not_found(pvmw);
>>>+			if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>+				return not_found(pvmw);
>>>+		} else if (pmd_is_migration_entry(pmde)) {
>>>+			softleaf_t entry = softleaf_from_pmd(pmde);
>>>+
>>>+			if (!(pvmw->flags & PVMW_MIGRATION))
>>>+				return not_found(pvmw);
>>
>>Looked at history a bit, and I wonder if this changed something old
>>here ...
>>
>>Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
>>migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
>>including not_found() cases. So lockless PMD read was just a filter ...
>>
>>With this fix, true case gets final pmd_same() check, but this
>>not_found() case happens before taking PTL.
>>
>>So a !PVMW_MIGRATION walker could race with someone, e.g.
>>remove_migration_pmd(): we make the not_found() decision from old PMD
>>value that still says "migration", while real *pvmw->pmd may already be
>>present again. We return without ever taking PTL :)
>>
>
>Hi, Lance
>
>Thanks for take a look.
>
>I am trying to understand the scenario you mentioned. Let's say A migrate a
>pmd and B want to unmap the pmd.
>
>            A                                        B
>
>  try to migrate a pmd
>  pmd is set to migration entry
>                                           unmap the pmd ...
>  managed to finish migration
>                                           ...still see migration entry,
>                                           so skipped and unmap fail
>
>Would this be a timing case? Even B grab the PTL, it still could see migration
>entry if B visit pmd before A finish migration.
>
>Maybe I miss something, look forward your insight.

Right, seeing migration entry while migration is still ongoing is fine.

What I meant was this ordering:

  CPU 0: pmde = pmdp_get_lockless(...); /* migration */
  CPU 1: remove_migration_pmd() restores PMD to present
  CPU 0: returns not_found() from old pmde, without ever taking PTL and
         rechecking *pvmw->pmd

So issue is not seeing migration entry itself, but making final
not_found() decision from stale lockless PMD value ...

Before this patch, PMD migration case took PTL before making that
decision ...

>>Not sure about practical fallout, but should these PMD-level not_found()
>>cases also take PTL and restart if PMD changed?
>>
>
>-- 
>Wei Yang
>Help you, Help me
>
