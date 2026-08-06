Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA03B71B5;
	Thu,  6 Aug 2026 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025850; cv=none; b=j1ZdEP3R4kbo1U6iBDh+yxsSncPtDgFzxyMbbwY5UrQ79XFIuxhjna0YZ6fDbyMAxH3XnOZRMPd8sQ13LJTV+e+RZNhbrS8xiBYs/e5EKDmWf8mZSHrngGVPPbDb04Zl+CGCiSP8tZc7EzHCgE1RkZzOsIfqPx9smtlyoZclNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025850; c=relaxed/simple;
	bh=PMdLGo64ZyH63NOBDZEKHbWZRkYqF5eByrB22gz8Arc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbjHtUzWjN75eRq8pN7lIKCo78VvUAeVOo/dTfcP6EcoHqfUEEYQl3glOr1iCkJl/N1tsQHoqjePo1Ti/BsGeyv9H7XpBVxmAFQFNiZywYXNWzoQr6N70TH5CzxeV0rhCaKJprxNQoqCu9sEV8Az6PyyL06v7z5xjfDsNDDzBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdYnerw0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdYnerw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12301F000E9;
	Thu,  6 Aug 2026 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025848;
	bh=t1GD69MNdL2Krccft9/mtd7QqmRzRsRy1YD00dFIkeg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jdYnerw0CkZ1v8zKbVpb8lg+5/Cu1a1C5J3KMKf49jA+sxF/FJvIdIzTRESCyxc0V
	 MXkf/75wJEeSvUna6C9cfzeeZSNEBuMZyHjYVLfqLDjW29FxtbWbU1EOEVu8M7yQVA
	 X4+vAFhC1RC8SlukZaR9CGXkWRDqXQjQomb1TNKjJy6VVx4FLjRSXZH9SXENf7YEJF
	 bvi50poZcSv2lQse2elreq+SY6wtqm5HEl21Ymx0ntPAqUaw4wS9zyH7p4avONeLb5
	 ejoFwMT6DC3aUWj59ojbFR5JCjsE5eBzTnpOE9lAaV5U6F7gVLqF4XNSRKVeCk5bIE
	 yimQY/TKgtjRg==
Message-ID: <d6e665cd-08a3-4598-8a4f-1af21eea4132@kernel.org>
Date: Thu, 6 Aug 2026 16:17:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: fix folio refcount leak and
 min_order_for_split() locking
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Li Youhong <liyouhong@kylinos.cn>, stable@vger.kernel.org
References: <20260806-try_to_split_thp_page-v1-1-a259e3387e38@kernel.org>
 <anRv8ngsyOjkgOHM@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <anRv8ngsyOjkgOHM@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 16:03, Lorenzo Stoakes (ARM) wrote:
> On Thu, Aug 06, 2026 at 01:14:38PM +0200, David Hildenbrand (Arm) wrote:
>> hwpoison code can end up calling min_order_for_split() without holding
>> the folio lock. There isn't really something that would prevent
>> concurrent folio split. Consequently folio->mapping can get set to
>> NULL after checking for "!folio->mapping", and if the compiler
>> reloads folio->mapping, mapping_min_folio_order() would try to
>> dereference NULL.
>>
>> While very unlikely to happen in practice, let's just enforce that
>> min_order_for_split() is called with the folio lock held. We can
>> significantly cleanup the calling hwpoison code, and just get rid
>> of try_to_split_thp_page() to hold the folio lock for a bit longer.
>>
>> Just work on folios now, which further cleans up the code. We just
>> have to be careful about doing the page_folio() after splitting, which
>> we have to do already either way. Do not change the way we split for
>> now, this needs more thought and should be done separately.
>>
>> Cleaning this up we fix another issue: in soft_offline_in_use_page(), we
>> would currently have leaked a folio reference.
> 
> Yikes...
> 
>>
>> In folio_split(), document and assert that we need the folio lock.
> 
> You mean min_order_for_split()?

Very right :)

> 
>> Drop the questionable VM_BUG_ON_PAGE(!page_count(p), p) check entirely.
>>
>> The folio->mapping problem was identified by Sashiko, and Li Youhong
>> reported it by sending a proposal fix.
>>
>> This likely does not really warrant CCing stable, but I expect little
>> conflicts when doing the backport, so let's just CC stable because of
>> the refcount leak.
>>
>> Reported-by: Li Youhong <liyouhong@kylinos.cn>
>> Closes: https://lore.kernel.org/r/20260804035828.2684059-1-dayou5941@163.com
>> Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> A typo above and a nit below about a comment but otherwise LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
>> ---
>> v4 of the last fixing attempts:
>>
>> https://lore.kernel.org/r/20260806031958.677935-1-dayou5941@163.com
>> ---
>>  mm/huge_memory.c    |  4 ++++
>>  mm/memory-failure.c | 56 ++++++++++++++++++-----------------------------------
>>  2 files changed, 23 insertions(+), 37 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 9b1f3b24f7e0d..a00df56a68b57 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -4362,10 +4362,14 @@ int folio_split(struct folio *folio, unsigned int new_order,
>>   * If a file-backed folio is truncated, 0 will be returned. Any subsequent
>>   * split attempt should get -EBUSY from split checking code.
>>   *
>> + * Context: @folio must be locked.
>> + *
>>   * Return: @folio's minimum order for split
>>   */
>>  unsigned int min_order_for_split(struct folio *folio)
>>  {
>> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
>> +
>>  	if (folio_test_anon(folio))
>>  		return 0;
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index aaf14608b30e2..f4f3f1fc9eaff 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1705,26 +1705,6 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>>  	return page_action(ps, p, pfn);
>>  }
>>
>> -/*
>> - * When 'release' is 'false', it means that if thp split has failed,
>> - * there is still more to do, hence the page refcount we took earlier
>> - * is still needed.
>> - */
>> -static int try_to_split_thp_page(struct page *page, unsigned int new_order,
>> -		bool release)
>> -{
>> -	int ret;
>> -
>> -	lock_page(page);
>> -	ret = split_huge_page_to_order(page, new_order);
>> -	unlock_page(page);
>> -
>> -	if (ret && release)
>> -		put_page(page);
>> -
>> -	return ret;
>> -}
>> -
>>  static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
>>  		struct address_space *mapping, pgoff_t index, int flags)
>>  {
>> @@ -2509,9 +2489,6 @@ int memory_failure(unsigned long pfn, int flags)
>>  	folio_unlock(folio);
>>
>>  	if (folio_test_large(folio)) {
>> -		const int new_order = min_order_for_split(folio);
>> -		int err;
>> -
>>  		/*
>>  		 * The flag must be set after the refcount is bumped
>>  		 * otherwise it may race with THP split.
>> @@ -2526,24 +2503,25 @@ int memory_failure(unsigned long pfn, int flags)
>>  		 * page is a valid handlable page.
>>  		 */
>>  		folio_set_has_hwpoisoned(folio);
>> -		err = try_to_split_thp_page(p, new_order, /* release= */ false);
>> +
>> +		folio_lock(folio);
>> +		split_huge_page_to_order(p, min_order_for_split(folio));
>> +		folio = page_folio(p);
>> +		folio_unlock(folio);
>> +
>>  		/*
>>  		 * If splitting a folio to order-0 fails, kill the process.
>>  		 * Split the folio regardless to minimize unusable pages.
>>  		 * Because the memory failure code cannot handle large
>>  		 * folios, this split is always treated as if it failed.
>>  		 */
>> -		if (err || new_order) {
>> -			/* get folio again in case the original one is split */
>> -			folio = page_folio(p);
>> +		if (folio_test_large(folio)) {
>>  			res = -EHWPOISON;
>>  			kill_procs_now(p, pfn, flags, folio);
>> -			put_page(p);
>> +			folio_put(folio);
>>  			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
>>  			goto unlock_mutex;
>>  		}
>> -		VM_BUG_ON_PAGE(!page_count(p), p);
>> -		folio = page_folio(p);
>>  	}
>>
>>  	/*
>> @@ -2861,9 +2839,8 @@ static int soft_offline_in_use_page(struct page *page)
>>  		.reason = MR_MEMORY_FAILURE,
>>  	};
>>
>> +	folio_lock(folio);
>>  	if (!huge && folio_test_large(folio)) {
>> -		const int new_order = min_order_for_split(folio);
>> -
>>  		/*
>>  		 * If new_order (target split order) is not 0, do not split the
>>  		 * folio at all to retain the still accessible large folio.
>> @@ -2871,15 +2848,20 @@ static int soft_offline_in_use_page(struct page *page)
>>  		 * preferred, split it to non-zero new_order like it is done in
>>  		 * memory_failure().
>>  		 */
> 
> This comment is:
> 
> 		/*
> 		 * If new_order (target split order) is not 0, do not split the
> 		 * folio at all to retain the still accessible large folio.
> 		 * NOTE: if minimizing the number of soft offline pages is
> 		 * preferred, split it to non-zero new_order like it is done in
> 		 * memory_failure().
> 		 */
> 
> Which references 'new_order' twice - probably need to update this.

Agreed, thanks!

While at it, I'll just drop the NOTE that is not of any value, really?


diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f4f3f1fc9eaff..9f1e547e7b472 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2842,11 +2842,8 @@ static int soft_offline_in_use_page(struct page *page)
        folio_lock(folio);
        if (!huge && folio_test_large(folio)) {
                /*
-                * If new_order (target split order) is not 0, do not split the
-                * folio at all to retain the still accessible large folio.
-                * NOTE: if minimizing the number of soft offline pages is
-                * preferred, split it to non-zero new_order like it is done in
-                * memory_failure().
+                * If we cannot split to order-0, do not split the folio at all
+                * to retain the still accessible large folio.
                 */
                if (!min_order_for_split(folio))
                        ret = split_huge_page_to_order(page, 0) ? -EBUSY : 0;

> 
>> -		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
>> -						       /* release= */ true)) {
>> +		if (!min_order_for_split(folio))
>> +			ret = split_huge_page_to_order(page, 0) ? -EBUSY : 0;
>> +		else
>> +			ret = -EBUSY;
>> +		folio = page_folio(page);
>> +
>> +		if (ret) {
>> +			folio_unlock(folio);
>> +			folio_put(folio);
> 
> Wow, incredible that we had a refcount leak here for ages and didn't know. Ugh
> what a mess this hw posion crap is!

I mean, soft-offline handling is not what runs on ... everyone's box. And the
memory will effectively be dead soon either way (hardware tells us that this
memory is likely going to get hwpoison soon) in most cases ... :)

-- 
Cheers,

David
