Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200204;
	b=wKByS+fciH2qKGOmLcBX8xU+inKqNC/L2GBHUqM03zwnwFNMsEzMDEkhwQhjZ9ScXv8Z
	 yk0g5UrS4bTxUijJecDkhFcGMfnS23X6UQvawEhnaHbO6esnMQZ1y8P/7Xu6YykvuquGj
	 ChF0+hErd2Cm48KfiHUJRAP2qXinv6RwImh6RcdYeXkkvzV3BLZCGyD5M+ijg2RHwhG+P
	 NM/uq2ffZbA2I8CcrD+D4xx3EFRsF8A4I8pwoMdyeLZHCWaVmcNYGIvLGz/fEAjeYrCLa
	 FO4SY65t4BQx4EdavPa3hVckGi/2UuXeT62NutdL4aa5Emh6r/I42Uygk8ipumIhbPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200204;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DKgJKWTBOJzl2PJZHSD17HbgcFOWBXCXBURY+ctwIP8=;
	b=IfHu7xh1yx2fg0sln0AD6sMRe7E1InS/EFrNihch3hrrIV5V/NNxrM1sT6IRc446YrXD
	 TDsKvwrXsCQ+NfPWi4jM/tqLrIMG6CoYgobbDkvOt5vYTe788UNRF2WZdCyKiw0aPnbty
	 yFMPK6GqMqJKPybWyofdItxqnOo0AaFoMw65pkG4/L8ITGUd/IRrPjz9QsZRtF5ZLxIUQ
	 4e2IckSI3LQIZBdQmFcjdAYg4u5XIQM+FFPyGJaGYbko0UnbmC95Ree8TkyLIXIGMMj8e
	 Apqk6Yqi8NlUdzHz2z1RG05kifMvm/mDjsvG1z6O1GR7A4Ifu+KYD4bKxecMH9GgVZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KES7eykU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A04606A31C;
	Wed, 28 Oct 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KES7eykU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093A41F01828;
	Wed, 28 Oct 2026 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793200203;
	bh=DKgJKWTBOJzl2PJZHSD17HbgcFOWBXCXBURY+ctwIP8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=KES7eykUL+zeWVcVO1skU8I0d52Ib30WHpZ9YCxGj0MVaBt1znSoXAttcUK2mTMJV
	 8mXHsKjiSoQkWQ+brKDsuhLMVMz/36Zkj/UYd1BSbQxpM6h0TVaz+aEtfbDS7O9CK8
	 /MHalScRJSfZpJdXd6s1JRmuFxHhOZgjujKcJkMdhYd5PfOV54WPLaNkKx5K5vAvPu
	 y1IKgg8CgsR68JTHAvyCSjn5Z4STBz0Dl/6LxMOXOdw7ErIj3BN977WmNZm9EL51tW
	 YgPuLxmgdrqX79Y183LOW74kPEJgOKh2LMbgw7lFpcyjUvVHsrOWw8KVsDvv7uLPOQ
	 EJHrU3wxZr3hw==
Message-ID: <477298f9-59cb-439f-a4ea-b662bdb3154d@kernel.org>
Date: Wed, 28 Oct 2026 16:09:59 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix max-only subpool accounting on
 alloc_hugetlb_folio failure
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: Zhao Li <enderaoelyther@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: mawupeng1@huawei.com, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260427145247.84157-2-enderaoelyther@gmail.com>
 <20260428030712.66256-2-enderaoelyther@gmail.com>
 <20260428113037.88766-2-enderaoelyther@gmail.com>
 <bb2a67db-fb38-43a9-b50e-38e078ad2d1f@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <bb2a67db-fb38-43a9-b50e-38e078ad2d1f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 17:04, David Hildenbrand (Arm) wrote:
> On 4/28/26 13:30, Zhao Li wrote:
>> alloc_hugetlb_folio() calls hugepage_subpool_get_pages() when map_chg
>> is set.  For a subpool with max_hpages != -1, that bumps used_hpages
>> regardless of whether it returns gbl_chg = 0 (rsv slot consumed) or
>> gbl_chg > 0 (used_hpages slot only).  If the allocation later fails
>> before a folio is returned, the unwind must undo the used_hpages
>> bump.  The old cleanup only ran for !gbl_chg, leaking used_hpages on
>> the gbl_chg > 0 path.
>>
>> For gbl_chg > 0 on max-only subpools (max_hpages != -1, min_hpages
>> == -1), hugepage_subpool_get_pages() took only a speculative
>> used_hpages slot.  Drop that slot directly under spool->lock.  In
>> that configuration hugepage_subpool_put_pages() cannot restore
>> rsv_hpages, so the direct decrement is the exact inverse and is
>> race-free against concurrent puts.  This matches the used_hpages-only
>> part of hugetlb_reserve_pages()'s out_put_pages cleanup, but
>> restricts it to the max-only case where no rsv_hpages restoration is
>> possible.
>>
>> Mounts with min_hpages != -1 are left unchanged for now.  v2's
>> approach (hugepage_subpool_put_pages() + h->resv_huge_pages++ to
>> back a restored rsv_hpages slot) double-counts global backing under
>> concurrent free_huge_folio() and creates phantom reservations under
>> concurrent hugetlb_unreserve_pages().  Safe cleanup of that quadrant
>> needs a coordinated fix across multiple call sites.
>>
>> Reproduced on size=20M hugetlbfs with the faulting task in a hugetlb
>> cgroup whose limit is exceeded.  Vanilla leaks 6/8 hugepages of
>> subpool quota; this patch leaks 0/8.  Verified under QEMU.
>>
>> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
>> Cc: stable@vger.kernel.org # v6.15+
>> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
>> ---
>> Changes in v3:
>> - Replace v2's hugepage_subpool_put_pages() + h->resv_huge_pages++ on
>>   the gbl_chg > 0 branch with a direct used_hpages-- under spool->lock.
>> - Restrict the cleanup to (max_hpages != -1, min_hpages == -1) where
>>   the direct decrement is the exact inverse of the speculative bump.
>>
>> Changes in v2:
>> - Skip the gbl_chg > 0 cleanup when max_hpages is unset.
>> - Add hugepage_subpool_put_pages() + h->resv_huge_pages++ on the
>>   gbl_chg > 0 branch.
>>
>>  mm/hugetlb.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index f24bf49be047e..cfdeaf6394c5b 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3025,13 +3025,24 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>  		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
>>  						    h_cg);
>>  out_subpool_put:
>> -	/*
>> -	 * put page to subpool iff the quota of subpool's rsv_hpages is used
>> -	 * during hugepage_subpool_get_pages.
>> -	 */
>> -	if (map_chg && !gbl_chg) {
>> -		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
>> -		hugetlb_acct_memory(h, -gbl_reserve);
>> +	if (map_chg) {
> 
> 
> I agree with Muchuns comment about removing the "gbl_chg > 0" check.
> 
> You could consider the following structure, which reduces indentation and avoids
> touching the existing handling.
> 
> if (map_chg && !gbl_chg) {
> 	...
> } else if (map_chg && spool && spool->min_hpages == -1 &&
> 	   spool->max_hpages != -1) {
> 	...
> }
> 
> But the code would read a lot nicer as
> 
> if (map_chg && !gbl_chg) {
> 	...
> } else if (map_chg) {
> 	hugepage_subpool_XXX_pages()
> }
> 
> Whereby the spool checks etc are handled in there.
> 
> Muchun things that we might just be able to use hugepage_subpool_put_pages(). It
> that's possible, great. Otherwise create a new helper that wraps all the logic
> below.
> 

Any update on this?

-- 
Cheers,

David
