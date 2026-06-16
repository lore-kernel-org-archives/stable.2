Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03C397699
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602068; cv=none; b=eWtopgO8uDjvEsYJNs+duOi7BmLLgE+cndA6Y4Ewe50lOtT+0U2Yb0itfBT754+kVGM6WciW2QSXGsJborOGko3orbdb0XDEeOx4Otqy2CEP8UIp2GK4kVaiINfcHWamAlBMoxADKcxh7y8hvvatW5JXpeKLs8BH92st5QloyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602068; c=relaxed/simple;
	bh=vQc8JPsgCy5rS7aRYqbhoMRkYcxzNuV82AEkSLczNC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubd+Kaqxot/M8FYF/bsE84lZ9i1Ur7mbMuPB98gI5lnwDjXgwbOAyhSltAZo/ozXsr5dKzwn6Zu+PiZwTYfmzewXD6OnYP7NuMS92ZqBammNiNZs+CfA2mxuG3ravv97x95n7SNlud/waO2I2OLNNK5ScFwxcnMNa1/XEBLE7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ6xa5Oo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ6xa5Oo"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bec3f69d343so631813666b.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602065; x=1782206865; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGUhifIwbizeLq+2E6X1Zz6h5cAG7IwAkNPVZW+1qSc=;
        b=LQ6xa5OogE5f+m4mhIlWpQ6Zetm2y1ZWw7923sBc0kber4OjhLj8M1PLGO1ViYXra/
         WrGXRq8i7k/LmEBCmCYgVmBcIRhL0QPBwZTf8U9z9QOcD0KacGS4cmVjNer4RhmyPAyl
         oJOH374wNSrP9gI+kNdkKoPVriQUgJ5sTrQfpfbvpx6WZz2rNqGM1lr8Sv44CfjSO1Fy
         Y92jlsZPJkJg1xnT7MYAqfFopqqjEBx4ndIaoZ4k3hcgrju3PrqGvsq7bEQ9qlyhwZFA
         Y336ICxqkGZYo8C+YqHO/786UzUEi4L4fvfvrtM4U+HiaVoj2hWaklwLM1f+PA3mRqj+
         X36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602065; x=1782206865;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGUhifIwbizeLq+2E6X1Zz6h5cAG7IwAkNPVZW+1qSc=;
        b=qn1T+GWWq8CFN/SjTDHXSoTM43W+4+kLDZewqhHk5uQJQEFy2UyzK9R37w0NQO+ysk
         VDDcaPqbqfK4wOQi7gIqlnxCJIFuHg9CDKH6qhgWiGVjQUR+RWkeN5jcYrrZlnFgbJMR
         gjzS35pOypMBNFFVNr52kiTpsN8/epuhJHUyl0qzSIRnrcYeSlcXV6eUzdwzKs7ZeT8D
         2K6tfCWSJcrcCPnbUs1EQLokYAaAoqidmQrwpqTmygtF3iBIjqpsA6MQ74qrOqWyxfVQ
         K14fKo/U7hYdrlWqeRpxmAyizafl9XJJnvB3zXx13aguMX/O6d4WWNlxWAF/o8be+s2J
         tpTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WiQLrvHnLbFyOxo+nY4p4RLzKDsf4uSP5Z6D2a9Jm49/Bd6wOuoKQdlVIp8E275bNAdnv5X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmP3GjzOI4kZO7E17rLScRVsbq7mTS6htYmW7NZA+TkFd7xJy
	YyvbhcJbEUsPEe1TWcknzPMf/QfbfNKoGIulV+cvvz5uByLdgSUFu5vX
X-Gm-Gg: Acq92OGxACJI8Cy2POpIbZLsYnp8WuV7g9rB6dp298G/fZ3czEJOkcA2nbbYiebcI7n
	aNMzIsdUYAhRF29C4dJjBvsSl3/oN3GOI/duCecmns+ifjfAgi2ZEQWhO/R+QqkKfXCZJ9R3SdW
	ThbmIxbLJ2rzSjaO9GoA0eI+jMr3wPuz+6BQhWdOIDMN3vs/MO7BiWQnYJTaM+asrXxWlfr7PEH
	i5SPJZpDmGHEgPukteEGt3U0NHRgR8eOwcXyr8LZvXCp/dNvmW8C9Vby/zZLrQx05OzqNMPntJU
	5D/MhhibA0RLYhxNxkssn6akzJMFKtlWl0rVxDjym9Pj6vSwVr5qUPimJQI5wWk/uR0CilfGghz
	tJimdV3C6BbBfW533LE6q9wIJxwsBKBSlJ/EU1ATMZ+ywCkvHSvbhR7RqMonNqLVzdempDVia2I
	fuQmpKLa4UrI8P8q44d/6ahw==
X-Received: by 2002:a17:907:3d4f:b0:bfe:ed06:5a17 with SMTP id a640c23a62f3a-bff4cddba68mr638739466b.53.1781602064737;
        Tue, 16 Jun 2026 02:27:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0463a2d1f4sm92450866b.51.2026.06.16.02.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jun 2026 02:27:44 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:27:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: david@kernel.org, richard.weiyang@gmail.com, balbirs@nvidia.com,
	akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
	jannh@google.com, sj@kernel.org, ziy@nvidia.com, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260616092743.kpzud5vrjj664b7o@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org>
 <20260616091522.83765-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616091522.83765-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jun 16, 2026 at 05:15:22PM +0800, Lance Yang wrote:
>
>On Mon, Jun 15, 2026 at 01:58:15PM +0200, David Hildenbrand (Arm) wrote:
>>On 6/12/26 04:48, Wei Yang wrote:
>>> On Tue, May 12, 2026 at 08:55:47PM +0200, David Hildenbrand (Arm) wrote:
>>>> On 5/12/26 16:35, Wei Yang wrote:
>>>>>
>>>>> I tried to compress above logic like this, hope it could look cleaner.
>
>Emm ... spelling out the present/migration/device-private cases makes
>this easier to review, and avoids hiding future softleaf types behind
>pmd_is_valid_softleaf(), IMHO.
>
>So I'd prefer David's explicit version[1].
>
>>>>>
>>>>> 	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
>>>>> 		unsigned long pfn;
>>>>> 		bool is_migration = pmd_is_migration_entry(pmde);
>>>>> 		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);
>>>>>
>>>>> 		if (is_migration != for_migration)
>>>>> 			return not_found(pvmw);
>>>>>
>>>>> 		if (pmd_trans_huge(pmde))
>>>>> 			pfn = pmd_pfn(pmde);
>>>>> 		else
>>>>> 			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));
>>>>>
>>>>> 		if (!check_pmd(pfn, pvmw))
>>>>> 			return not_found(pvmw);
>>>>> 	} else if (!pmd_present(pmde)) {
>>>>
>>>> It's more compact, but not necessarily cleaner. In particular, I detest
>>>> pmd_trans_huge(), we should phase it out.
>>>>
>>>> if (pmd_present(pmde) && !pmd_leaf(pmde)) {
>>>> 	goto pte_table;
>>>> } else if (pmd_present(pmde) || pmd_is_valid_softleaf(pmde))
>>>>
>>>> ...
>>>>
>>>> Might work as well. But once we add support for other softleaf types, we'll have
>>>> to touch it again. So I'd rather just list what we actually expect.
>>>>
>>> 
>>> Hi, David
>>
>>Hi,
>>
>>> 
>>> I may not follow you. Just want to confirm whether you prefer this goes as a
>>> fix first, or you prefer it goes as what you suggested here as a cleanup?
>>
>>I guess we should just do it properly when we're touching the code already.
>
>+1 to that ;)
>
>>Does that answer your question? Will you send a proper patch?
>
>Copied the diff from [1] below, with a couple of tiny nits inline. Feel
>free to grab any of this if it looks sane :)

Hi, Lance

Thanks for taking a look.

I just sent v2 [2] with the suggestion form David from [1]. So didn't include your
suggestion yet.

If it doesn't bother too much, would you mind reply there so that we could
have the same base line?

Thanks

[2]: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u

>
>---8<---
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index a4d52fdb3056..de6a255cc847 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -242,40 +242,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                 */
>                pmde = pmdp_get_lockless(pvmw->pmd);
> 
>-               if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>-                       pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>-                       pmde = *pvmw->pmd;
>-                       if (!pmd_present(pmde)) {
>-                               softleaf_t entry;
>-
>-                               if (!thp_migration_supported() ||
>-                                   !(pvmw->flags & PVMW_MIGRATION))
>-                                       return not_found(pvmw);
>-                               entry = softleaf_from_pmd(pmde);
>-
>-                               if (!softleaf_is_migration(entry) ||
>-                                   !check_pmd(softleaf_to_pfn(entry), pvmw))
>-                                       return not_found(pvmw);
>-                               return true;
>-                       }
>-                       if (likely(pmd_trans_huge(pmde))) {
>-                               if (pvmw->flags & PVMW_MIGRATION)
>-                                       return not_found(pvmw);
>-                               if (!check_pmd(pmd_pfn(pmde), pvmw))
>-                                       return not_found(pvmw);
>-                               return true;
>-                       }
>-                       /* THP pmd was split under us: handle on pte level */
>-                       spin_unlock(pvmw->ptl);
>-                       pvmw->ptl = NULL;
>-               } else if (!pmd_present(pmde)) {
>-                       const softleaf_t entry = softleaf_from_pmd(pmde);
>-
>-                       if (softleaf_is_device_private(entry)) {
>-                               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>-                               return true;
>-                       }
>+               if (pmd_present(pmde)) {
>+                       if (!pmd_leaf(pmde))
>+                               goto pte_table;
>+                       if (pvmw->flags & PVMW_MIGRATION)
>+                               return not_found(pvmw);
>+                       if (!check_pmd(pmd_pfn(pmde), pvmw))
>+                               return not_found(pvmw);
>+               } else if (pmd_is_migration_entry(pmde)) {
>+                       softleaf_t entry = softleaf_from_pmd(pmde);
>
>Could be const.
>
>+
>+                       if (!(pvmw->flags & PVMW_MIGRATION))
>+                               return not_found(pvmw);
>+                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+                               return not_found(pvmw);
>+               } else if (pmd_is_device_private_entry(pmde)) {
>+                       softleaf_t entry = softleaf_from_pmd(pmde);
>
>Ditto.
> 
>+                       if (pvmw->flags & PVMW_MIGRATION)
>+                               return not_found(pvmw);
>+                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+                               return not_found(pvmw);
>+               } else {
>                        if ((pvmw->flags & PVMW_SYNC) &&
>                            thp_vma_suitable_order(vma, pvmw->address,
>                                                   PMD_ORDER) &&
>@@ -285,6 +273,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                        step_forward(pvmw, PMD_SIZE);
>                        continue;
>                }
>+
>+               /* Double-check under PTL that the PMD didn't change. */
>+               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>+               if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
>
>Maybe worth a likely() here? The PMD normally shouldn't change under us.
>
>+                       return true;
>+               spin_unlock(pvmw->ptl);
>+               pvmw->ptl = NULL;
>+               goto restart;
>+pte_table:
>                if (!map_pte(pvmw, &pmde, &ptl)) {
>                        if (!pvmw->pte)
>---
>
>[1] https://lore.kernel.org/linux-mm/0aab59b8-71c5-4059-8281-5dd876946528@kernel.org/
>
>Cheers, Lance

-- 
Wei Yang
Help you, Help me
