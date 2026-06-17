Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89C37F728
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684302; cv=none; b=nYEEozOCevpJmv3717bo1Dzn6JO0Bx6C01wWKQOsUKzChIm8PIzLcqL8a+AA56ZFtsMA7qYV4WJZY72ohlEvscP1eX1t77q6OZQpVmU+AyugVBK3GN5QiCRYsIOotYp8ljUUx3LYjAHdJY9YqyMq0LR6Ph/V05HRH1qjXeZ227U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684302; c=relaxed/simple;
	bh=uF3VdkJi997nPHVtxLNNvBW3BxT6N21zlvRllgJ806A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quLOT+NVHFYfbcwSm/7b3XmFv+DjYzYJP/4ZzdRo/uzgO1/jn3vR2c67QwNv4WBzBLjnXcAo7dJ48VR+mxOj5SiDIreNq4bOwd6Sgb1SIpxH7uoZNodymABH9WojaVBCwhVgY1foTciwHxsLeAmyjydkxJm4WL54ln79VbnCiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1ry47gL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1ry47gL"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec429c2bb1so787504966b.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781684299; x=1782289099; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhalDeiPKafuB6dh85e27yohyG4zdlphxrEzu0htw90=;
        b=L1ry47gLXRoy3NvNcabZZJNqj5FqMfqq3gXO12Cip2+x9NuU5CCfmO00XqBrTBrVq2
         DkBzC4uglaKGoYAshHA/fdOhDpUs4naRDwBtRG8onvjturyrSvR1WZfhA3gyuSkYYSeR
         B/J3nfyJM9xRE4mID80UfopNywgRzGsdvyfBZ1XPMbF4L3Z8MUzUc/e6LbqNpIa36vSu
         1ID0QsijCtd8eWIk15vAed3bN+M/CajCc0mErvEYshmnOKftdWa4drIXF0Lycz5Yq7wU
         4MOhqIJwJbSzLayRm7/sHBojUDJXIUEXOtxPNb/8zKaxJbi65q4RQape9rA++rbDuQ4o
         0pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781684299; x=1782289099;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhalDeiPKafuB6dh85e27yohyG4zdlphxrEzu0htw90=;
        b=dJRdnSOa+5JdiA6WoQV05tmO7mTcS0epe2DhiS0R1ZhodaStvsbTkDwfD+YTIL1e9q
         GL9uxYvWvsvWXEoCXOvhRPkg7QMr3EovwlDUp3fI92740BtmfLz0mZBD5bmNOPVwPI7W
         do+u1nwk/GY3WByeWAuGmUKSKv9Ax5VBHRaxjWXnD+/0iLS8sL6ml6CpAPL8KYGZJO7B
         BF3loy2acb7uN8qkUp+GufPnRro3HOdo7K7VeW+VazENRTdcwLZ8bPYgi+WPgEYUbks/
         CSqSjd8vOrFfoeH5OmHwGnKhqhKqFSN2QzR0pStMBPO0jO1ypcw6dPIdrJeh+0giU3TY
         CDBQ==
X-Forwarded-Encrypted: i=1; AFNElJ86BPe0RD5T8p3Gt5PJGAYyB41TvLPu/Vej5Jld4rzvBZ9kAZODzlxiVdsgbdLSCUCYHmiIg2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VF3mh5qQIhw30pImZxivygNd/NcEZDiTtNSQZYOpQsc2cN3v
	RWSLqgRKRvoOMlYDKBVoNOeNUo8BKW2OyZuhUWpy1ESdD2oZyUFirm/S
X-Gm-Gg: Acq92OE7CQQ2WySky0UV23lE3Y/XapKSEFSV4mp095n5o41AWFNLb6LVyS7ytef29B7
	tm1/BAIMFJWw0vVihDHT+KB19FRwZYFJPRRqlZbyokKTn2N9t+5ljVMi7kVF01WbIIOyIis6KlP
	wNUPoXnTJyg7oufzAtElAh8TSqmcHEY7HDho68B3BN74F9aN5826H7bJViFeQbFiST8voTEwriq
	kqAKRduX+O8CfL413PiZsYvK6ttNlAYxQDHh4pU3VJ2K2tEtTbx5jgJugrEWDooCA6tEIUbIdcl
	uLG7UvDnyG9QEDg7bhPZchAkkpwCYStNIE4VGKniRZZGryvL7ryH2hOtHQdwzJkvQVOkmwc/3sp
	+S4PmDW1KcTWKBt62APthxgS1ZCJqFQuxE1EnQx6EZNw6WrXetmnh6Kjaxv1shYiUwJDwG4W27b
	8mIiqd3ko0uN4=
X-Received: by 2002:a17:907:9805:b0:bfe:ed06:5a16 with SMTP id a640c23a62f3a-c05a7bb59c7mr155753266b.52.1781684296405;
        Wed, 17 Jun 2026 01:18:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c063f9b2470sm33268266b.62.2026.06.17.01.18.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2026 01:18:15 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:18:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: richard.weiyang@gmail.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260617081815.kq6g3rjtomudxca5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260616235022.iesy2jeb2p7zof2l@master>
 <20260617023211.80409-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617023211.80409-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 17, 2026 at 10:32:11AM +0800, Lance Yang wrote:
>
>On Tue, Jun 16, 2026 at 11:50:22PM +0000, Wei Yang wrote:
>>On Tue, Jun 16, 2026 at 08:30:01PM +0800, Lance Yang wrote:
>>>
>>>On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>>>[...]
>>>>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>>index 2ccbabfb2cc1..21635fab209c 100644
>>>>--- a/mm/page_vma_mapped.c
>>>>+++ b/mm/page_vma_mapped.c
>>>>@@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>> 		 */
>>>> 		pmde = pmdp_get_lockless(pvmw->pmd);
>>>> 
>>>>-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>>>-			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>>-			pmde = *pvmw->pmd;
>>>>-			if (!pmd_present(pmde)) {
>>>>-				softleaf_t entry;
>>>>-
>>>>-				if (!thp_migration_supported() ||
>>>>-				    !(pvmw->flags & PVMW_MIGRATION))
>>>>-					return not_found(pvmw);
>>>>-				entry = softleaf_from_pmd(pmde);
>>>>-
>>>>-				if (!softleaf_is_migration(entry) ||
>>>>-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>>>>-					return not_found(pvmw);
>>>>-				return true;
>>>>-			}
>>>>-			if (likely(pmd_trans_huge(pmde))) {
>>>>-				if (pvmw->flags & PVMW_MIGRATION)
>>>>-					return not_found(pvmw);
>>>>-				if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>>-					return not_found(pvmw);
>>>>-				return true;
>>>>-			}
>>>>-			/* THP pmd was split under us: handle on pte level */
>>>>-			spin_unlock(pvmw->ptl);
>>>>-			pvmw->ptl = NULL;
>>>>-		} else if (!pmd_present(pmde)) {
>>>>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>>>>-
>>>>-			if (softleaf_is_device_private(entry)) {
>>>>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>>-				return true;
>>>>-			}
>>>>+		if (pmd_present(pmde)) {
>>>>+			if (!pmd_leaf(pmde))
>>>>+				goto pte_table;
>>>>+			if (pvmw->flags & PVMW_MIGRATION)
>>>>+				return not_found(pvmw);
>>>>+			if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>>+				return not_found(pvmw);
>>>>+		} else if (pmd_is_migration_entry(pmde)) {
>>>>+			softleaf_t entry = softleaf_from_pmd(pmde);
>>>>+
>>>>+			if (!(pvmw->flags & PVMW_MIGRATION))
>>>>+				return not_found(pvmw);
>>>
>>>Looked at history a bit, and I wonder if this changed something old
>>>here ...
>>>
>>>Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
>>>migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
>>>including not_found() cases. So lockless PMD read was just a filter ...
>>>
>>>With this fix, true case gets final pmd_same() check, but this
>>>not_found() case happens before taking PTL.
>>>
>>>So a !PVMW_MIGRATION walker could race with someone, e.g.
>>>remove_migration_pmd(): we make the not_found() decision from old PMD
>>>value that still says "migration", while real *pvmw->pmd may already be
>>>present again. We return without ever taking PTL :)
>>>
>>
>>Hi, Lance
>>
>>Thanks for take a look.
>>
>>I am trying to understand the scenario you mentioned. Let's say A migrate a
>>pmd and B want to unmap the pmd.
>>
>>            A                                        B
>>
>>  try to migrate a pmd
>>  pmd is set to migration entry
>>                                           unmap the pmd ...
>>  managed to finish migration
>>                                           ...still see migration entry,
>>                                           so skipped and unmap fail
>>
>>Would this be a timing case? Even B grab the PTL, it still could see migration
>>entry if B visit pmd before A finish migration.
>>
>>Maybe I miss something, look forward your insight.
>
>Right, seeing migration entry while migration is still ongoing is fine.
>
>What I meant was this ordering:
>
>  CPU 0: pmde = pmdp_get_lockless(...); /* migration */
>  CPU 1: remove_migration_pmd() restores PMD to present
>  CPU 0: returns not_found() from old pmde, without ever taking PTL and
>         rechecking *pvmw->pmd
>
>So issue is not seeing migration entry itself, but making final
>not_found() decision from stale lockless PMD value ...
>
>Before this patch, PMD migration case took PTL before making that
>decision ...
>

Yes, this patch changes the decision making condition for pmd entry. Thanks
for pointing out.

Hmm... I took another look into current pte handling and find for pte entry,
we did two phase check:

  * map_pte() without ptl
  * check_pte() with ptl

While check_pte() do extra pfn range check, map_pte() doesn't.

This means for pte entry, we may face the same situation as you describe: 
make the decision before grab PTL. Till now, it looks reasonable.

But one thing jumped at me, PVMW_SYNC. When this flag is specified, all check
is done under PTL. But now for pmd entry, we don't have a chance to do so.

And as the comment says in try_to_migrate_one()

	/*
	 * When racing against e.g. zap_pte_range() on another cpu,
	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
	 * try_to_migrate() may return before folio_mapped() has become false,
	 * if page table locking is skipped: use TTU_SYNC to wait for that.
	 */

I tracked down to commit a98a2f0c8ce1 ('mm/rmap: split migration into its own
function'), but not getting more detail on reasoning. Not fully understand it
yet, but it seems there is some race between migration and unmap which is
protected by PTL?

Will look into this to get more detail.

>>>Not sure about practical fallout, but should these PMD-level not_found()
>>>cases also take PTL and restart if PMD changed?
>>>
>>
>>-- 
>>Wei Yang
>>Help you, Help me
>>

-- 
Wei Yang
Help you, Help me
