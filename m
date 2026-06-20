Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92FB8632B
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781920958; cv=none; b=BvchzeMMQfQ90NEGCPC/6nllEIqaabl0D8CxRDSPEeE0q390Eycwy+8/hLmy/Tvac0eiiuWQKxXJ2ahRwf9pcjBatj859KCt1S6bWCBTWq1ouwUgtc26fBToHoiAkLadnxQNKsglLC+S+wnRe6cmvDYRW8E8NSmZcqnVutmeCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781920958; c=relaxed/simple;
	bh=cQRk7LhvxHDRNOechaLLeXX+fAmr+6o6OkKaixTJHRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lACeAFL6hFEa0wHo+/SdU4hrxy2UB5Sz4LjNF5FaRweVianXm1TVTo3zsDkwjCzHvxh1VxbBhwEe353zuzaNwPpZU10cXGvXUNW+FuiIBxHsHEHNODqQigZSnSlvHuwMYhLXPyYEic24mvXr1P4X0fF2ANjH1utjUQ5NHwcb6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chsNhVxP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chsNhVxP"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c07ea058c1aso399595666b.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781920955; x=1782525755; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGv+Ltfx7xpehBvF7h2TbxSb0mrqZVXeNckTo1OWitc=;
        b=chsNhVxPC5dsVw9b1rrHk4WUbHr1nTrjUwwuRZj+G3LbIZRky+5zI4KHQqr9OPiNRM
         0c1/cD6wUOyUfcivPaKIel2HTlRBmAqEpuOS/ebXFeSZ/xMcd/D7TJtxcrxVGBjDc/tI
         pd2CjRA7PiP7s3qBFzUG88WuZ/u4O95/TRJpm62PZIsp8RxuCW7NgqR4UXYk+g/1LBvN
         SlcXZG/Ne9mTqSZTqib0eBIifBkrCO4Mhxy/d0rbQ9eKJaBkE3K8ZQUuHslus2Sh36Pu
         7RnNMps/F7leKIl7/YfAhqiPsPboGGSVTB9mCMm9b/WMgy9Nfi7djuNdPPWemb3zvQ8j
         Q86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781920955; x=1782525755;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGv+Ltfx7xpehBvF7h2TbxSb0mrqZVXeNckTo1OWitc=;
        b=B5WCDtK+gns2GkSLOZea/P2dofWf+7sk2qukFI6ddqJat88SA9RQvIPayuLfpXGMcY
         yibiSaorJluCJCE67LrLnJAcG9xrMKkaj/uM3JfHk3RMNDf6w0fhq51jt+uNIFbXF6it
         S3PAKOIDQLducIuh3iBOUxVDmnWA6v6Rk5MS658Y75QLaWUVMGX7xxxouRcsMNibWOcP
         CD94NuxTPZi/+zR4fvZ7rcz3ABX0BNCAKizM1UY2M1UZ0Yjr9E+0KEazBbHdHOdHPsla
         St+RrgZAkJK4ETWMXm/zoX316KkN9/KusbUetIRa1FfR8O8YBD/BXy0YHR7aV9JyXur2
         a2vg==
X-Forwarded-Encrypted: i=1; AFNElJ/OrHFlstngsVIDNc5C3NfcTjcik6nJc/e7U2IR7dArhRMTPBc+G2DySf7N5CML7Tnw+5jvEVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHglxrcOSm8kukCuvcTe1jrXd7sh6GJBIlRpbHYuMqXl90fZW
	bzyV9MKGKp6hvpGlXRO8QBbUiqLNRuQ1XUTRPnyCMunILxdPg03NDcJi
X-Gm-Gg: AfdE7cmC7G1Q1QGxEb3tJTnrvDG7PfpQU/E+2gn5/ky/HD3QGza0KWfm5kSSyAlzgYr
	jYIlvnxXDG5uDrtJ/eZVXEW18RpcR0hXzsOvs4Ww65Yqi+mJpFt9TKYtwwMMaQWbDaoXvWWacF7
	Un0hSpn0+90nMadZlLr3QX2vrWYNREezJkfOQazo9NmxHdpdj3MknxuF53dehuq0YwCPB5HLZXV
	xW6DsLC1t8HuYsy90IdC0ueqK54sHMOp2CETxmP8d/vaKjDh8GOIox0X7BbzdPPcDHIVtzO8qxV
	0sE+h4KEvw0v0BFkBn4bA4XC/FNoXX2XkQZnT4dSUIotcq9Rb2KunCh60yxug2RYLBKYrxYfl+V
	2dLjv8g5nOk9mE8lRfs115H6/uooZ20jD4iwhX1QR/wgvgg7Wa9KVa4Pl7OoCqFQTePrmd2/TNx
	jBPTsAg3LfyFe9GoSxH+5GqA==
X-Received: by 2002:a17:907:3f96:b0:bec:2a21:785c with SMTP id a640c23a62f3a-c097b080e9amr309603866b.23.1781920954647;
        Fri, 19 Jun 2026 19:02:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e49a9fbsm46361166b.12.2026.06.19.19.02.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2026 19:02:33 -0700 (PDT)
Date: Sat, 20 Jun 2026 02:02:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: richard.weiyang@gmail.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260620020232.53ifdvjnypcz55ot@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260619023025.vqx2dsitxffuuwh3@master>
 <20260619121909.90510-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619121909.90510-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 19, 2026 at 08:19:09PM +0800, Lance Yang wrote:
>
>On Fri, Jun 19, 2026 at 02:30:25AM +0000, Wei Yang wrote:
>>On Wed, Jun 17, 2026 at 08:18:15AM +0000, Wei Yang wrote:
>>>On Wed, Jun 17, 2026 at 10:32:11AM +0800, Lance Yang wrote:
>>>>
>>>>On Tue, Jun 16, 2026 at 11:50:22PM +0000, Wei Yang wrote:
>>>>>On Tue, Jun 16, 2026 at 08:30:01PM +0800, Lance Yang wrote:
>>>>>>
>>>>>>On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>>>>>>[...]
>>>>>>>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>>>>>index 2ccbabfb2cc1..21635fab209c 100644
>>>>>>>--- a/mm/page_vma_mapped.c
>>>>>>>+++ b/mm/page_vma_mapped.c
>>>>>>>@@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>>>> 		 */
>>>>>>> 		pmde = pmdp_get_lockless(pvmw->pmd);
>>>>>>> 
>>>>>>>-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>>>>>>-			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>>>>>-			pmde = *pvmw->pmd;
>>>>>>>-			if (!pmd_present(pmde)) {
>>>>>>>-				softleaf_t entry;
>>>>>>>-
>>>>>>>-				if (!thp_migration_supported() ||
>>>>>>>-				    !(pvmw->flags & PVMW_MIGRATION))
>>>>>>>-					return not_found(pvmw);
>>>>>>>-				entry = softleaf_from_pmd(pmde);
>>>>>>>-
>>>>>>>-				if (!softleaf_is_migration(entry) ||
>>>>>>>-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>>>>>>>-					return not_found(pvmw);
>>>>>>>-				return true;
>>>>>>>-			}
>>>>>>>-			if (likely(pmd_trans_huge(pmde))) {
>>>>>>>-				if (pvmw->flags & PVMW_MIGRATION)
>>>>>>>-					return not_found(pvmw);
>>>>>>>-				if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>>>>>-					return not_found(pvmw);
>>>>>>>-				return true;
>>>>>>>-			}
>>>>>>>-			/* THP pmd was split under us: handle on pte level */
>>>>>>>-			spin_unlock(pvmw->ptl);
>>>>>>>-			pvmw->ptl = NULL;
>>>>>>>-		} else if (!pmd_present(pmde)) {
>>>>>>>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>>>>>>>-
>>>>>>>-			if (softleaf_is_device_private(entry)) {
>>>>>>>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>>>>>-				return true;
>>>>>>>-			}
>>>>>>>+		if (pmd_present(pmde)) {
>>>>>>>+			if (!pmd_leaf(pmde))
>>>>>>>+				goto pte_table;
>>>>>>>+			if (pvmw->flags & PVMW_MIGRATION)
>>>>>>>+				return not_found(pvmw);
>>>>>>>+			if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>>>>>+				return not_found(pvmw);
>>>>>>>+		} else if (pmd_is_migration_entry(pmde)) {
>>>>>>>+			softleaf_t entry = softleaf_from_pmd(pmde);
>>>>>>>+
>>>>>>>+			if (!(pvmw->flags & PVMW_MIGRATION))
>>>>>>>+				return not_found(pvmw);
>>>>>>
>>>>>>Looked at history a bit, and I wonder if this changed something old
>>>>>>here ...
>>>>>>
>>>>>>Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
>>>>>>migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
>>>>>>including not_found() cases. So lockless PMD read was just a filter ...
>>>>>>
>>>>>>With this fix, true case gets final pmd_same() check, but this
>>>>>>not_found() case happens before taking PTL.
>>>>>>
>>>>>>So a !PVMW_MIGRATION walker could race with someone, e.g.
>>>>>>remove_migration_pmd(): we make the not_found() decision from old PMD
>>>>>>value that still says "migration", while real *pvmw->pmd may already be
>>>>>>present again. We return without ever taking PTL :)
>>>>>>
>>>>>
>>>>>Hi, Lance
>>>>>
>>>>>Thanks for take a look.
>>>>>
>>>>>I am trying to understand the scenario you mentioned. Let's say A migrate a
>>>>>pmd and B want to unmap the pmd.
>>>>>
>>>>>            A                                        B
>>>>>
>>>>>  try to migrate a pmd
>>>>>  pmd is set to migration entry
>>>>>                                           unmap the pmd ...
>>>>>  managed to finish migration
>>>>>                                           ...still see migration entry,
>>>>>                                           so skipped and unmap fail
>>>>>
>>>>>Would this be a timing case? Even B grab the PTL, it still could see migration
>>>>>entry if B visit pmd before A finish migration.
>>>>>
>>>>>Maybe I miss something, look forward your insight.
>>>>
>>>>Right, seeing migration entry while migration is still ongoing is fine.
>>>>
>>>>What I meant was this ordering:
>>>>
>>>>  CPU 0: pmde = pmdp_get_lockless(...); /* migration */
>>>>  CPU 1: remove_migration_pmd() restores PMD to present
>>>>  CPU 0: returns not_found() from old pmde, without ever taking PTL and
>>>>         rechecking *pvmw->pmd
>>>>
>>>>So issue is not seeing migration entry itself, but making final
>>>>not_found() decision from stale lockless PMD value ...
>>>>
>>>>Before this patch, PMD migration case took PTL before making that
>>>>decision ...
>>>>
>>>
>>>Yes, this patch changes the decision making condition for pmd entry. Thanks
>>>for pointing out.
>>>
>>>Hmm... I took another look into current pte handling and find for pte entry,
>>>we did two phase check:
>>>
>>>  * map_pte() without ptl
>>>  * check_pte() with ptl
>>>
>>>While check_pte() do extra pfn range check, map_pte() doesn't.
>>>
>>>This means for pte entry, we may face the same situation as you describe: 
>>>make the decision before grab PTL. Till now, it looks reasonable.
>>>
>>>But one thing jumped at me, PVMW_SYNC. When this flag is specified, all check
>>>is done under PTL. But now for pmd entry, we don't have a chance to do so.
>>>
>>>And as the comment says in try_to_migrate_one()
>>>
>>>	/*
>>>	 * When racing against e.g. zap_pte_range() on another cpu,
>>>	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
>>>	 * try_to_migrate() may return before folio_mapped() has become false,
>>>	 * if page table locking is skipped: use TTU_SYNC to wait for that.
>>>	 */
>>>
>>>I tracked down to commit a98a2f0c8ce1 ('mm/rmap: split migration into its own
>>>function'), but not getting more detail on reasoning. Not fully understand it
>>>yet, but it seems there is some race between migration and unmap which is
>>>protected by PTL?
>>>
>>>Will look into this to get more detail.
>>>
>>
>>After going through the history, I found this:
>>
>>   commit 732ed55823fc3ad998d43b86bf771887bcc5ec67
>>   Author: Hugh Dickins <hughd@google.com>
>>   Date:   Tue Jun 15 18:23:53 2021 -0700
>>   
>>       mm/thp: try_to_unmap() use TTU_SYNC for safe splitting
>>
>>This one fix the race mentioned above: we expect mapcount is 0, but is not.
>
>Cool, thanks!
>
>I do want to spend more time on this refactor. It is touching some subtle
>page_vma_mapped_walk() rules, so I don't want to skim and guess ...
>
>One case I can pin down now is device-private: the PTE side gives us a
>clear rule to compare against :)
>
>On the PTE side:
>
>1) PVMW_SYNC set, PVMW_MIGRATION set
>
>  map_pte() uses pte_offset_map_lock(), so it takes PTL first.
>  check_pte() then runs under PTL. Since PVMW_MIGRATION is set,
>  check_pte() requires a migration entry, so device-private is rejected.
>
>2) PVMW_SYNC set, PVMW_MIGRATION clear
>
>  map_pte() takes PTL first. check_pte() then runs under PTL.
>  Since PVMW_MIGRATION is clear, device-private can be a normal mapping,
>  but check_pte() still checks entry type and PFN range.
>
>3) PVMW_SYNC clear, PVMW_MIGRATION set
>
>  map_pte() first does a lockless read. A non-present, non-none PTE can
>  still be a candidate, so map_pte() takes PTL. check_pte() then rejects
>  device-private, because PVMW_MIGRATION requires a migration entry.
>
>4) PVMW_SYNC clear, PVMW_MIGRATION clear
>
>  map_pte() first does a lockless read. A device-private PTE can be a
>  normal mapping candidate, so map_pte() takes PTL. check_pte() then
>  checks entry type and PFN range under PTL.
>
>On the PMD device-private side, before this patch, all four cases go
>through the same code once the lockless PMD read sees a device-private
>entry:
>
>- lockless read PMD into pmde
>- pmde is non-present
>- decode pmde as a softleaf entry
>- entry is device-private
>- take pmd_lock()
>- return true
>
>So compared with the PTE side:
>
>A) PVMW_SYNC set, PVMW_MIGRATION set
>
>  PTE rejects device-private under PTL.
>
>  PMD returns true.
>
>  This does not match. The PMD code misses the PVMW_MIGRATION direction
>  check, and does not reread/revalidate PMD under pmd_lock().
>
>B) PVMW_SYNC set, PVMW_MIGRATION clear
>
>  PTE can accept device-private, but only after locked check_pte()
>  validation.
>
>  PMD also returns true.
>
>  The direction is OK, but the final check is missing. PMD returns true
>  from the lockless PMD classification, without PMD revalidation and
>  without check_pmd() PFN-range check.
>
>C) PVMW_SYNC clear, PVMW_MIGRATION set
>
>  PTE can reach locked check_pte() from the lockless candidate, but
>  check_pte() rejects device-private.
>  
>  PMD returns true.
>
>  Same mismatch as case A: missing PVMW_MIGRATION direction check, and no
>  locked PMD revalidation.
>
>D) PVMW_SYNC clear, PVMW_MIGRATION clear
>
>  PTE can accept device-private after locked validation.
>
>  PMD also returns true.
>
>  Direction is OK here as well, but the PMD code still has no final
>  locked check matching check_pte(): no PMD reread/revalidation, and no
>  check_pmd() PFN-range check.
>

Thanks for the detailed analysis.

>>
>>IIUC, if we apply the change in this patch, the affected case is
>>pmd_is_migration_entry(). In case someone else has cleared it but not update
>>mapcount yet, try_to_migrate() would return before folio_mapped() is false.
>>
>>Thanks Lance for raise the question.
>>
>>If above analysis is true, I haven't got a neat way to take this into
>>consideration.
>>
>>BTW, for a fix, I am thinking to keep it simple and direct. So how about leave
>>the refactor as a followup cleanup?
>
>So for a fix, let's line up the PTE and PMD rules first :D
>

Sure.

Based on your above analysis, looks the change in v1 [1] is the right
direction, IIUC.

So I will send v3 based on this with comment adjust according to Lorenzo's
comment.

[1]: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/

>Cheers, Lance
>
>>-- 
>>Wei Yang
>>Help you, Help me
>>

-- 
Wei Yang
Help you, Help me
