Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8539FCB5
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138068; cv=none; b=TfvlTnqR/8JZNExEF3TEgCzD/efSxt4F5BDe4DKgNSKQQK4/8BnTT93CL6kBS0tNcR0q6Yw3KKffYyYYNPx1JmhzEiDbbvP7KodlPK9KJNp65RA2dL0oassLEt++XfV6qtOkGVoVhH49dgda4I0WoyToJvHDO52pIp0pBw7GraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138068; c=relaxed/simple;
	bh=hhrf5kckJPGvrVr5eOHuluzTAdUadjuAXSKK9Iq25SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax7KbOh5k2kpKdGb1CZI6XohORhlmzUWH4unWmZNWJRLjvmxVINywQadyg5EodISed16rE60oAupBdUFNkq+GVpjzIQFjqy+53z9TNrRT5MCtJgyRUtr3cO0goguOIb9aZZnHC6wWHNn+1uXvsHizG9yRdqAHWNrZsEtPNPjGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHDwpZK7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHDwpZK7"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6977dc206afso3874628a12.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782138064; x=1782742864; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTwUN8Q/4wLdeKzilYCyv8Ge+JFMwxPAhYfNtl9tb/Y=;
        b=oHDwpZK7TElnH1skkZjQU8cK+UjN2gBVodjRB6J6PFT2eb0EHpTQ7cd0w/aiN1unQA
         0wFEpSV7ky5ZFRgpgVPxcyiJFSUp72nQtGkvJJDYHVYajNSRbV99uBUCmPjkZRfeqR8R
         IUNJrk06/fiEOZn3CfI4VF4rhQfCjgSH3M7xhxhPS3d2zcgfkZM/wvcs+8zySZT2z8+g
         g3evfWLVwtX804Aq5W7cooQGgfJzJ552tY3ngaYaHpadYmhiSku4tf+p9jI4ugvVdsfU
         Wf9VLD/xZ6diZEKjCaF8adc/E1g1+g2B3/gb2xtfBoQC7K/xfwBGyWHnnRDANWRmJ1+M
         COsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782138064; x=1782742864;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTwUN8Q/4wLdeKzilYCyv8Ge+JFMwxPAhYfNtl9tb/Y=;
        b=ZkzGvZNXQiNRRMOi1cYVDP+tILJEp+uRmP3MhUjxFBufg4/W8jKWFZ/m+2Nmq9bphi
         IX4xlIPeaJmR096LUI7mRMd58ks+CVEsw1eAjaXLWQ5DcPgYfGgs4LkNEDPszNxxE9n3
         jBRmtD1jV6/yTrLFbetNtbt482kK/fCVx97xFfjCy44fQ0NnHW1zPXiI006qUJ/jB9eW
         dUng1jvBgmkDlTBeKR+fdCA0MWj+kRl2lLtD3m3o9z5qqS9tSD+2Gunr0okrfM8aZ6cH
         fCyYaAnJsLLZHn2pqOAv4F6mBNc/oNq133+Xnxej8etSde2z44WCFZQzeAJqr3wmRjUM
         F3Fw==
X-Forwarded-Encrypted: i=1; AFNElJ/nMw6y1dywmM0m9xIhbSxITC0RYBF/AVWWrn1lszMu3cLwFowOJvkoQnDxM1HvzJq9ZYDeUlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuiTTC9G/qVSxcLJhbyzgEsDKoe8opV1ekrsPk54l3H6QXt68
	ppDwbZ2buo0vgfhZg7ibmGXhPgDP1CFHRRr5H/k/EZRn0n/9TiYnW0YT
X-Gm-Gg: AfdE7cloHwRjHPhbzl89Gao+eGi3qbD7SD+Q/mCDtjR/n54jtvHOJlNkwjCl4SSe5DL
	HjPOFZigJI2SjN1rxEFBN3Et/9IS5h1HrEGdP0Hseoohu9dq8ygUjqnh14lFcKekGkaXmSl0INz
	3mea0R2PLZ0HPeM4oMfTVJtKfnRDJdyC1YBynTkMqiddtgj/sEkVTz7UZ/Lr9dlYsksilqOfImY
	iKW2NFz+RVsDTQrsfSl4Q/dovgUcmzmCTrsNKLCmavBRcp3uc942STS8k0AKzznK8UJcxocmJHf
	cyXZ6lSgOHHj6+pHLLIypR/kv+1BQPXOwp6C9VcY0u8bPHdfCAMkM3AmbtiHkdiaytFBHS4Na/f
	Joj7IpJsHOyGKPKEgc6cKpknxwffJ8LF9V6f2AaAYQ82IO1X6unpyp+8fOA5kPek8fZVBE6FGGD
	MP1hslaSTSez4=
X-Received: by 2002:a05:6402:550f:b0:695:df86:d774 with SMTP id 4fb4d7f45d1cf-696dde43a4emr5830085a12.9.1782138063649;
        Mon, 22 Jun 2026 07:21:03 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b84f362sm3136005a12.10.2026.06.22.07.21.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2026 07:21:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:21:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	sj@kernel.org, ziy@nvidia.com, balbirs@nvidia.com,
	linux-mm@kvack.org, stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260622142102.pcmr5pftshj5lvju@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
 <ajk0N3Aekapljaoh@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajk0N3Aekapljaoh@lucifer>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jun 22, 2026 at 02:46:40PM +0100, Lorenzo Stoakes wrote:
>+cc Lance, linux-kernel
>
>Your subject line is 83 characters long and is way too detailed how about 'fix
>device-private PMD handling'?
>

Got it.

>You forgot to include linux-kernel@vger.kernel.org on the mail, lore seems to be
>a bit broken atm but in general it's helpful to include that.

Got it.

So usually we send a patch to both linux-mm and linux-kernel? If so, I
remember is later actions.

>
>Also is useful to make this [PATCH mm-hotfixes] to make it really clear it's
>intended as a hotfix.
>

Got it.

>Some commit msg language nits:
>
>On Mon, Jun 22, 2026 at 01:06:51PM +0000, Wei Yang wrote:
>> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>> before return the pmd entry:
>
>Sounds better as:
>
>	For PMD entries that satisfy pmd_trans_huge() or pmd_is_migration_entry(), we
>	perform the following actions:
>

Sure.

>>
>>   * re-validate pmd entry after PTL
>>   * check PVMW_MIGRATION
>>   * check_pmd()
>>   * handle on pte level if split under us
>>
>> But for device-private pmd, we just return after pmd_lock().
>
>->
>
>	However, for device-private PMD entries, we simply acquire the PMD lock
>	and return.
>

Sure.

>Also can you please give some justification here as to why all this also applies
>to device-private PMD? Right now it sounds hand wavey.
>

I thought below paragraph explain it. Not sure what justification is preferred.

>> If a softleaf entry is present, e.g. device-private pmd, the existing
>> code simply acquires the PMD lock and returns success even if
>> PVMW_MIGRATION is set (indicating a migration entry is sought), meaning
>> that the caller can incorrectly interpret the entry as something it is
>> not, causing data corruption.
>
>This is repetitive, you already mentioned device-private PMD, you already
>mentioned that it simply acquires the PMD lock.
>

Ah, I copied your suggestion from [1]. Hope I don't misunderstand it.

[1]: https://lore.kernel.org/linux-mm/ajUXNjRMraKb6k2n@lucifer/

>You should talk about what issue it caused and why:
>
>	This is particularly problematic when PVMW_MIGRATION is set (meaning a
>	migration entry is sought), as it causes a device-private PMD entry to
>	be returned with a different data layout, causing memory corruption.
>

This looks good. I would take this one, if you prefer.

>>
>> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
>> support device-private entries") by following the same pattern as
>> pmd_trans_huge() and pmd_is_migration_entry() for device private entry.
>
>This is pretty useless. We see what patch it fixes in the Fixes tag, and you're
>just repeating things you said above, I'd drop it.
>

Got it.

>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Suggested-by: David Hildenbrand <david@kernel.org>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>>
>> ---
>> v3:
>>   * remove cleanup part, only fix the issue for device-private entry
>>   * refine user effect description based on Lorenzo's suggestion
>> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>>   * specify the possible error case of current code and user visible effect
>>   * besides fix, cleanup the pmd entry handling based on David's suggestion
>>
>> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
>> ---
>>  mm/page_vma_mapped.c | 32 ++++++++++++++++++++++----------
>>  1 file changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 2ccbabfb2cc1..8de3c6b82df6 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -270,21 +270,33 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>  			spin_unlock(pvmw->ptl);
>>  			pvmw->ptl = NULL;
>>  		} else if (!pmd_present(pmde)) {
>> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>> +			softleaf_t entry = softleaf_from_pmd(pmde);
>>
>>  			if (softleaf_is_device_private(entry)) {
>>  				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> -				return true;
>> -			}
>>
>> -			if ((pvmw->flags & PVMW_SYNC) &&
>> -			    thp_vma_suitable_order(vma, pvmw->address,
>> -						   PMD_ORDER) &&
>> -			    (pvmw->nr_pages >= HPAGE_PMD_NR))
>> -				sync_with_folio_pmd_zap(mm, pvmw->pmd);
>> +				entry = softleaf_from_pmd(*pvmw->pmd);
>>
>> -			step_forward(pvmw, PMD_SIZE);
>> -			continue;
>> +				if (softleaf_is_device_private(entry)) {
>
>This is all very horrible. You have an example of how pmde is re-got in the
>pmd_trans_huge() branch and pmd_is_device_private_entry() exists...
>
>We can just make this another branch and do the re-check more neatly.
>

I plan to keep the change small, but yeah it is ugly.

>I enclose a patch that does that (untested, please check).
>
>
>> +					if (pvmw->flags & PVMW_MIGRATION)
>> +						return not_found(pvmw);
>> +					if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> +						return not_found(pvmw);
>> +					return true;
>> +				}
>> +				/* device-private pmd was split under us: handle on pte level */
>> +				spin_unlock(pvmw->ptl);
>> +				pvmw->ptl = NULL;
>> +			} else {
>> +				if ((pvmw->flags & PVMW_SYNC) &&
>> +				    thp_vma_suitable_order(vma, pvmw->address,
>> +							   PMD_ORDER) &&
>> +				    (pvmw->nr_pages >= HPAGE_PMD_NR))
>> +					sync_with_folio_pmd_zap(mm, pvmw->pmd);
>> +
>> +				step_forward(pvmw, PMD_SIZE);
>> +				continue;
>> +			}
>>  		}
>>  		if (!map_pte(pvmw, &pmde, &ptl)) {
>>  			if (!pvmw->pte)
>> --
>> 2.34.1
>>
>
>Thanks, Lorenzo
>
>----8<----
>>From e6a3c1c782714ed831c4d46a14bb99226423bf59 Mon Sep 17 00:00:00 2001
>From: Wei Yang <richard.weiyang@gmail.com>
>Date: Mon, 22 Jun 2026 13:06:51 +0000
>Subject: [PATCH] refactored
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---
> mm/page_vma_mapped.c | 20 +++++++++++++++-----
> 1 file changed, 15 insertions(+), 5 deletions(-)
>
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index 2ccbabfb2cc1..17dff8aab9f9 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 			/* THP pmd was split under us: handle on pte level */
> 			spin_unlock(pvmw->ptl);
> 			pvmw->ptl = NULL;
>-		} else if (!pmd_present(pmde)) {
>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>+		} else if (pmd_is_device_private_entry(pmde)) {
>+			softleaf_t entry;
>+
>+			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>+			pmde = *pvmw->pmd;
>+			entry = softleaf_from_pmd(pmde);
>
>-			if (softleaf_is_device_private(entry)) {
>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>+			if (likely(softleaf_is_device_private(entry))) {
>+				if (pvmw->flags & PVMW_MIGRATION)
>+					return not_found(pvmw);
>+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+					return not_found(pvmw);
> 				return true;
> 			}
>-
>+			/* device-private pmd was split under us: handle on pte level */
>+			spin_unlock(pvmw->ptl);
>+			pvmw->ptl = NULL;
>+		} else if (!pmd_present(pmde)) {
> 			if ((pvmw->flags & PVMW_SYNC) &&
> 			    thp_vma_suitable_order(vma, pvmw->address,
> 						   PMD_ORDER) &&
>--
>2.54.0

If we prefer this way, I will check and take it.

-- 
Wei Yang
Help you, Help me
