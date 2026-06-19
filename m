Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089822DB785
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781836229; cv=none; b=tXgrU10zYg2hvbWmJR3ZMTpjzJq88fHFWnHEiUy3WtjlsyKT0mnfJq3iS3m4ua9MRLC2Ni/vJu7uqJIwbSJ1vLUSaME8E7x4DaJ3HnQbsD5juCWVMFEmaE1J5fnyuvOpMJqDXuzdMxjzQyzSUKNl+V0rtQJEfG9tVseDX9e0RKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781836229; c=relaxed/simple;
	bh=YqHtpdWA3JTot3VS9rnZO67d4p1Xi3B1iSTpQW+naMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC35WN0Bfw1LIDv9yqRTMc3YQZ97R4xtCvIxEWxltRjWHERQjH8kKw7VzQQPbhzWczmtLhdQCV8Hng9vuzndaWuI0KhDX0KHCzkAB3/X0mSRY6RexIhtAyuaEFSVyRUp8e3mIzVUpcNse9xFvefpBhkSCvHy6h2bb2Vb5yg9/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZpUaZjn; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZpUaZjn"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-517a5cafc3dso16188991cf.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 19:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781836227; x=1782441027; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWxQsRnQ7R4yFYJGO8X5rI9njC1Ydr1XnXNU26v/VMI=;
        b=HZpUaZjn6S6bawCx8ZOwRye60YbBLUJ9QI6hfosWIfvWtv9u1j1LK0v3iL49/k/FAQ
         BJuj94UBkzpBpYNMYHUD44uAxnFzTJyrgZbZHmA1Xqz1j5moHTUteMep1FYqd1yNZKtQ
         0Ti5w6lUvI+3qX6zuS5WZJ20ne+G8e8itWRDNVKQHaYRBHR4mYr8kCrCK7PjHEdhSYjI
         gEYFJl57fP2rB5eP+hD0F1pDeHz0m72cGbK3NjhlgTLnPHJM68T+N+hSjxzt0dlUYXm1
         No5t4NlV3GUnaHdHF13iqBILbVbDPgdlocf4g5qXI1q44RzTDDfUnSzptzT71jbCbeMr
         IVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781836227; x=1782441027;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWxQsRnQ7R4yFYJGO8X5rI9njC1Ydr1XnXNU26v/VMI=;
        b=RVczzFjJib09s33rTs/LflTlBQyvJe2Y8vIFQoYSRKpq7lIlhkdDLtWZRaEVcr/CXe
         q5N9ehLUIKhevsJua74Ds0iKjclQYGolnwN1wkj2NLDKy0bofrMbwtHBsI+mGXoidl0k
         /3U+qDxgzzQgJ9Cuw37bpwESp9mnzTN87pJngwWl8qOaaSa7OgtNeNTdIc5wyEHY5CHg
         rfNKmHEV6xWpemgiuloz5hrpNa4wDzLC7s62zHcCY+DkFJeE7cTwwljj4Xh1Y3/NkTwl
         OFIoTfjDNpfTZ7QEQzwPNyUoxiS3W63hA5z6EOkJp6KwDRSyl5Iak9EyxXL0RZ6V7qtu
         S8yQ==
X-Forwarded-Encrypted: i=1; AFNElJ+a1Y5GC3gsSPrQ2junuBXu/okvznxxpW7cUIpPV4pog9LKcC/KnNgrtSmX44e8aFcC0QQog1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKRE9pZRC7Vl77kBUQ2FLtVr4t9HyK66xu38KNzeJUA4tkms/
	OKlHwvCzVXA7c5ILGE0lw2+xkGfHW44deSKDkxnOcad8AqRdShfZ6XHvgO8dhQ==
X-Gm-Gg: AfdE7cloNx+JI54wRlFBGrppTGpvSEqPkTmYaNcc/PAdPqu8fWDmIrpEb1OUGnCpO68
	uUyN74S2o3dlA1Y8qqYbLMDc0R+wd+IDQOFajAplU9jZn/zM9SVPZ/mik9gbfTd9hvH+FmKakT+
	2myoyUc/D2g3f1z/wu4Ol4oc7NhZscaPW+bnE6BrzWXPdzZecYzQpKD3KLu+ap9YfyIaZJv51tA
	jWPMi5lKzxVJ1DfowCV1r0/MjVxM5mK/VLZ4L3tGkAu5O60LFXLMSVw0t1mdATFmqHR9dyt9Hy/
	0PqmxWAodZbZM0/Ml1tSnpYqp5feY0tuF8K8iV72AtSD8SQiLOCbc2QBj+8pgCPzl/YdODgyPTy
	ALLPsVugOgxcR1NWvKB7MubpxdrpNVe2fpJQsFtR7DMarzOPqsvHWafdVucZxceCNMN8RjmaPeY
	F7CMUsWGf5aWY0ZRaOdTMjRw==
X-Received: by 2002:a05:622a:1149:b0:517:c65c:488b with SMTP id d75a77b69052e-519e45c2d72mr30506691cf.0.1781836226907;
        Thu, 18 Jun 2026 19:30:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-519e60ee850sm9152701cf.24.2026.06.18.19.30.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jun 2026 19:30:26 -0700 (PDT)
Date: Fri, 19 Jun 2026 02:30:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, riel@surriel.com,
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
	jannh@google.com, balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260619023025.vqx2dsitxffuuwh3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260616235022.iesy2jeb2p7zof2l@master>
 <20260617023211.80409-1-lance.yang@linux.dev>
 <20260617081815.kq6g3rjtomudxca5@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617081815.kq6g3rjtomudxca5@master>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 17, 2026 at 08:18:15AM +0000, Wei Yang wrote:
>On Wed, Jun 17, 2026 at 10:32:11AM +0800, Lance Yang wrote:
>>
>>On Tue, Jun 16, 2026 at 11:50:22PM +0000, Wei Yang wrote:
>>>On Tue, Jun 16, 2026 at 08:30:01PM +0800, Lance Yang wrote:
>>>>
>>>>On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>>>>[...]
>>>>>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>>>index 2ccbabfb2cc1..21635fab209c 100644
>>>>>--- a/mm/page_vma_mapped.c
>>>>>+++ b/mm/page_vma_mapped.c
>>>>>@@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>> 		 */
>>>>> 		pmde = pmdp_get_lockless(pvmw->pmd);
>>>>> 
>>>>>-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>>>>-			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>>>-			pmde = *pvmw->pmd;
>>>>>-			if (!pmd_present(pmde)) {
>>>>>-				softleaf_t entry;
>>>>>-
>>>>>-				if (!thp_migration_supported() ||
>>>>>-				    !(pvmw->flags & PVMW_MIGRATION))
>>>>>-					return not_found(pvmw);
>>>>>-				entry = softleaf_from_pmd(pmde);
>>>>>-
>>>>>-				if (!softleaf_is_migration(entry) ||
>>>>>-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>>>>>-					return not_found(pvmw);
>>>>>-				return true;
>>>>>-			}
>>>>>-			if (likely(pmd_trans_huge(pmde))) {
>>>>>-				if (pvmw->flags & PVMW_MIGRATION)
>>>>>-					return not_found(pvmw);
>>>>>-				if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>>>-					return not_found(pvmw);
>>>>>-				return true;
>>>>>-			}
>>>>>-			/* THP pmd was split under us: handle on pte level */
>>>>>-			spin_unlock(pvmw->ptl);
>>>>>-			pvmw->ptl = NULL;
>>>>>-		} else if (!pmd_present(pmde)) {
>>>>>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>>>>>-
>>>>>-			if (softleaf_is_device_private(entry)) {
>>>>>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>>>-				return true;
>>>>>-			}
>>>>>+		if (pmd_present(pmde)) {
>>>>>+			if (!pmd_leaf(pmde))
>>>>>+				goto pte_table;
>>>>>+			if (pvmw->flags & PVMW_MIGRATION)
>>>>>+				return not_found(pvmw);
>>>>>+			if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>>>+				return not_found(pvmw);
>>>>>+		} else if (pmd_is_migration_entry(pmde)) {
>>>>>+			softleaf_t entry = softleaf_from_pmd(pmde);
>>>>>+
>>>>>+			if (!(pvmw->flags & PVMW_MIGRATION))
>>>>>+				return not_found(pvmw);
>>>>
>>>>Looked at history a bit, and I wonder if this changed something old
>>>>here ...
>>>>
>>>>Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
>>>>migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
>>>>including not_found() cases. So lockless PMD read was just a filter ...
>>>>
>>>>With this fix, true case gets final pmd_same() check, but this
>>>>not_found() case happens before taking PTL.
>>>>
>>>>So a !PVMW_MIGRATION walker could race with someone, e.g.
>>>>remove_migration_pmd(): we make the not_found() decision from old PMD
>>>>value that still says "migration", while real *pvmw->pmd may already be
>>>>present again. We return without ever taking PTL :)
>>>>
>>>
>>>Hi, Lance
>>>
>>>Thanks for take a look.
>>>
>>>I am trying to understand the scenario you mentioned. Let's say A migrate a
>>>pmd and B want to unmap the pmd.
>>>
>>>            A                                        B
>>>
>>>  try to migrate a pmd
>>>  pmd is set to migration entry
>>>                                           unmap the pmd ...
>>>  managed to finish migration
>>>                                           ...still see migration entry,
>>>                                           so skipped and unmap fail
>>>
>>>Would this be a timing case? Even B grab the PTL, it still could see migration
>>>entry if B visit pmd before A finish migration.
>>>
>>>Maybe I miss something, look forward your insight.
>>
>>Right, seeing migration entry while migration is still ongoing is fine.
>>
>>What I meant was this ordering:
>>
>>  CPU 0: pmde = pmdp_get_lockless(...); /* migration */
>>  CPU 1: remove_migration_pmd() restores PMD to present
>>  CPU 0: returns not_found() from old pmde, without ever taking PTL and
>>         rechecking *pvmw->pmd
>>
>>So issue is not seeing migration entry itself, but making final
>>not_found() decision from stale lockless PMD value ...
>>
>>Before this patch, PMD migration case took PTL before making that
>>decision ...
>>
>
>Yes, this patch changes the decision making condition for pmd entry. Thanks
>for pointing out.
>
>Hmm... I took another look into current pte handling and find for pte entry,
>we did two phase check:
>
>  * map_pte() without ptl
>  * check_pte() with ptl
>
>While check_pte() do extra pfn range check, map_pte() doesn't.
>
>This means for pte entry, we may face the same situation as you describe: 
>make the decision before grab PTL. Till now, it looks reasonable.
>
>But one thing jumped at me, PVMW_SYNC. When this flag is specified, all check
>is done under PTL. But now for pmd entry, we don't have a chance to do so.
>
>And as the comment says in try_to_migrate_one()
>
>	/*
>	 * When racing against e.g. zap_pte_range() on another cpu,
>	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
>	 * try_to_migrate() may return before folio_mapped() has become false,
>	 * if page table locking is skipped: use TTU_SYNC to wait for that.
>	 */
>
>I tracked down to commit a98a2f0c8ce1 ('mm/rmap: split migration into its own
>function'), but not getting more detail on reasoning. Not fully understand it
>yet, but it seems there is some race between migration and unmap which is
>protected by PTL?
>
>Will look into this to get more detail.
>

After going through the history, I found this:

   commit 732ed55823fc3ad998d43b86bf771887bcc5ec67
   Author: Hugh Dickins <hughd@google.com>
   Date:   Tue Jun 15 18:23:53 2021 -0700
   
       mm/thp: try_to_unmap() use TTU_SYNC for safe splitting

This one fix the race mentioned above: we expect mapcount is 0, but is not.


IIUC, if we apply the change in this patch, the affected case is
pmd_is_migration_entry(). In case someone else has cleared it but not update
mapcount yet, try_to_migrate() would return before folio_mapped() is false.

Thanks Lance for raise the question.

If above analysis is true, I haven't got a neat way to take this into
consideration.

BTW, for a fix, I am thinking to keep it simple and direct. So how about leave
the refactor as a followup cleanup?

-- 
Wei Yang
Help you, Help me
