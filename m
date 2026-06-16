Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF4332EC8
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613037; cv=none; b=AoFjaD9m1WW8mi9UHdo9AAVHHgYBYmBYt07fRu57kfpYYvBJyxQnQwX1QSKBVJIlNvx2d7qkQ5k4NwsgwuUoQyqjKUmIiVPBRv6E6atnU5quUeWPRjZyUYeGWvugNH2jcxzkK5+D7X5Tgpmm9K4hiwJasT6aBLiikMpcZaOFClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613037; c=relaxed/simple;
	bh=YsKACnlHGhYMGIrNxKW8NtTOdQvRuWNhLEkjh8lv0mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dnevjr0RuUhguDZ+m4qflxoZdd5dT/OFp4D2FXP5Ev4e1cegTqx5EqAvqLml945f4kEjAvmE3KTwmjl3xmibkHcNfTlsRNkta7AOsA5JpLrMGd8Eg+BrD/t1E7WymnXCBuMdn0ClD7u7mnvtR1pKY1m8QMOoZaCg/60lTvT+Les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BDLtvHYb; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BDLtvHYb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781613032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7Yshx7diMX1O/OKyuwR/SBp/Kaw8zYRlyF2SsJvqRA=;
	b=BDLtvHYbtbBl6jCK8W2J5U0MaZ+1oaEDCCnJQ5XN2nOHOb6aWrop/Ja302qc7D7mNgSFTC
	JhIIPs9BWClMLzVyKktOsLn4D0CWfbprCz/ctP+BoNqWfwJ0yJmum4cSwIH2ADDPypw0OF
	nlVgsdz7pcnHRW7oy9djaeQRtFiomBg=
From: Lance Yang <lance.yang@linux.dev>
To: richard.weiyang@gmail.com
Cc: akpm@linux-foundation.org,
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
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
Date: Tue, 16 Jun 2026 20:30:01 +0800
Message-Id: <20260616123001.6501-1-lance.yang@linux.dev>
In-Reply-To: <20260616063436.20455-1-richard.weiyang@gmail.com>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
[...]
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index 2ccbabfb2cc1..21635fab209c 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 		 */
> 		pmde = pmdp_get_lockless(pvmw->pmd);
> 
>-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>-			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>-			pmde = *pvmw->pmd;
>-			if (!pmd_present(pmde)) {
>-				softleaf_t entry;
>-
>-				if (!thp_migration_supported() ||
>-				    !(pvmw->flags & PVMW_MIGRATION))
>-					return not_found(pvmw);
>-				entry = softleaf_from_pmd(pmde);
>-
>-				if (!softleaf_is_migration(entry) ||
>-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>-					return not_found(pvmw);
>-				return true;
>-			}
>-			if (likely(pmd_trans_huge(pmde))) {
>-				if (pvmw->flags & PVMW_MIGRATION)
>-					return not_found(pvmw);
>-				if (!check_pmd(pmd_pfn(pmde), pvmw))
>-					return not_found(pvmw);
>-				return true;
>-			}
>-			/* THP pmd was split under us: handle on pte level */
>-			spin_unlock(pvmw->ptl);
>-			pvmw->ptl = NULL;
>-		} else if (!pmd_present(pmde)) {
>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>-
>-			if (softleaf_is_device_private(entry)) {
>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>-				return true;
>-			}
>+		if (pmd_present(pmde)) {
>+			if (!pmd_leaf(pmde))
>+				goto pte_table;
>+			if (pvmw->flags & PVMW_MIGRATION)
>+				return not_found(pvmw);
>+			if (!check_pmd(pmd_pfn(pmde), pvmw))
>+				return not_found(pvmw);
>+		} else if (pmd_is_migration_entry(pmde)) {
>+			softleaf_t entry = softleaf_from_pmd(pmde);
>+
>+			if (!(pvmw->flags & PVMW_MIGRATION))
>+				return not_found(pvmw);

Looked at history a bit, and I wonder if this changed something old
here ...

Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
including not_found() cases. So lockless PMD read was just a filter ...

With this fix, true case gets final pmd_same() check, but this
not_found() case happens before taking PTL.

So a !PVMW_MIGRATION walker could race with someone, e.g.
remove_migration_pmd(): we make the not_found() decision from old PMD
value that still says "migration", while real *pvmw->pmd may already be
present again. We return without ever taking PTL :)

Not sure about practical fallout, but should these PMD-level not_found()
cases also take PTL and restart if PMD changed?

>+			if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+				return not_found(pvmw);
>+		} else if (pmd_is_device_private_entry(pmde)) {
>+			softleaf_t entry = softleaf_from_pmd(pmde);
> 
>+			if (pvmw->flags & PVMW_MIGRATION)
>+				return not_found(pvmw);
>+			if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+				return not_found(pvmw);
>+		} else {
> 			if ((pvmw->flags & PVMW_SYNC) &&
> 			    thp_vma_suitable_order(vma, pvmw->address,
> 						   PMD_ORDER) &&
>@@ -286,6 +274,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 			step_forward(pvmw, PMD_SIZE);
> 			continue;
> 		}
>+
>+		/* Double-check under PTL that the PMD didn't change. */
>+		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>+		if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
>+			return true;
>+		spin_unlock(pvmw->ptl);
>+		pvmw->ptl = NULL;
>+		goto restart;
>+pte_table:
> 		if (!map_pte(pvmw, &pmde, &ptl)) {
> 			if (!pvmw->pte)
> 				goto restart;
>-- 
>2.34.1
>

Cheers, Lance
