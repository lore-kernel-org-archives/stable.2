Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D024D3D47C5;
	Mon,  3 Aug 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748768; cv=none; b=ZwKizn6WMeNBLztR8CWVrEVV17gaq7yqWbe0dlOtsbfsREoWvavSP2EGDN2TxU4nG1qRmaw3mKZrkBpr72L0754Ra8jNVuPHpkP4NUB2z5rVrjwaE3rgilNh2tXJMFslYzAxxN7KRW3B1JejDXkBykn8AZfVITvR4ecXbcVmN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748768; c=relaxed/simple;
	bh=LB4FJQsY1IKCjtbKoVcQLFkgQMcPvpd2ST9kc/l/qhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9fX8rIC2z5xGq0A1umZRcM8fYz+5ignkBAS211RCO+E9GtSBYwhUMfYZBdsGTIe+hVoST0M1QH1TQH92l/hvvF/2WoWXLWGzGaa2inJlBzOsqWCtR7enkVYvoK6YvkmxUanzYWET63QTOOZnt2OtbFUp3mRIWhccKSzE18zLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JesergGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JesergGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5741F00A3A;
	Mon,  3 Aug 2026 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785748764;
	bh=cdDQILORMQ8A5KFOekP98a314EWXtxrYKLqfQJeDADU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JesergGZSKI+boCbMxRVMl5UmGIgB/amcI2tVOY6n5Mj9P7k5444Z+OMQYXfZ2ciF
	 8hWgGu6eVFv4F0q9ArGh8HPaTjsF/rpyH1zTO0xty1nZpRMpY6PXNmFAUb+UCAMHkQ
	 uojekA5uZJqWTx6NPyvLK57S77g+ftn+8/l2OLKJx6aj4zwutuQq5/qcnFCIpoYRLV
	 S5GfoWt5mmue6IQOAGSyha6/Vh8O1zYfPs3e0JaU7QkZyPzuTQt9bcnJnMVJOecgWH
	 M+4xPZ+xRwrVk9vRFg+ByQ3LUQBelz1KzUjBSva4gzuxBnFaxFXRgnKeWifN1XDhf6
	 RBtwECo/SbacA==
Message-ID: <7308cc99-1d1f-4e81-ada0-f0541aca12c7@kernel.org>
Date: Mon, 3 Aug 2026 11:19:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: fix always draining LRU caches in
 collect_longterm_unpinnable_folios()
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Hugh Dickins <hughd@google.com>, Ackerley Tng <ackerleytng@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org>
 <CAGsJ_4x3MQVU7_Npxf3JQ8Q27TsAW1Tx5-ifH8c6+gKtg5QkuQ@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAGsJ_4x3MQVU7_Npxf3JQ8Q27TsAW1Tx5-ifH8c6+gKtg5QkuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/3/26 11:17, Barry Song wrote:
> On Sat, Aug 1, 2026 at 4:28 AM David Hildenbrand (Arm) <david@kernel.org> wrote:
>>
>> folio_may_be_lru_cached() is currently only true for small folios, and
>> for small folios FOLL_PIN adds GUP_PIN_COUNTING_BIAS references instead
>> of 1 in try_grab_folio()/try_grab_folio_fast().
>>
>> Consequently, our
>>
>>         folio_ref_count(folio) != folio_expected_ref_count(folio) + 1
>>
>> check in collect_longterm_unpinnable_folios() will currently always
>> identify "reference mismatch" and first drain the local LRU cache to then
>> drain the LRU cache on all CPUs, as collect_longterm_unpinnable_folios()
>> is really called after pinning the folios with FOLL_PIN.
>>
>> Add a comment because the current code is not quite intuitive: we used to
>> drain only to make sure the folio_isolate_lru() would succeed. But then we
>> also started draining to make later migration more reliable.
>>
>> We'll refactor that code soon a bit, to also make it usable in other
>> context where we really want to remove any references from LRU caches.
>>
>> Let's add CC stable, because having an easy way for excessive LRU cache
>> draining on all CPUs does not sound right. In common scenarios we
>> don't expect to every have to drain.
>>
>> Fixes: 98c6d259319e ("mm/gup: check ref_count instead of lru before migration")
>> Fixes: a09a8a1fbb37 ("mm/gup: local lru_add_drain() to avoid lru_add_drain_all()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>> Found by code inspection. If someone has a testcase that can easily
>> trigger this and result in migration problems, please test! But this
>> change seems to be "obvious the right thing to do".
>> ---
>>  mm/gup.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 99902c15703b0..41c3317e0f0f4 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2273,6 +2273,7 @@ static unsigned long collect_longterm_unpinnable_folios(
>>
>>         for (folio = pofs_get_folio(pofs, i); folio;
>>              folio = pofs_next_folio(folio, pofs, &i)) {
>> +               const int pin_refs = folio_has_pincount(folio) ? 1 : GUP_PIN_COUNTING_BIAS;
>>
>>                 if (folio_is_longterm_pinnable(folio))
>>                         continue;
>> @@ -2287,15 +2288,20 @@ static unsigned long collect_longterm_unpinnable_folios(
>>                         continue;
>>                 }
>>
>> +               /*
>> +                * We drain not only to make the folio_isolate_lru() succeed,
>> +                * but also to remove any other folio references from LRU
>> +                * caches.
>> +                */
>>                 if (drained == 0 && folio_may_be_lru_cached(folio) &&
>>                                 folio_ref_count(folio) !=
>> -                               folio_expected_ref_count(folio) + 1) {
>> +                               folio_expected_ref_count(folio) + pin_refs) {
>>                         lru_add_drain();
>>                         drained = 1;
>>                 }
>>                 if (drained == 1 && folio_may_be_lru_cached(folio) &&
>>                                 folio_ref_count(folio) !=
>> -                               folio_expected_ref_count(folio) + 1) {
>> +                               folio_expected_ref_count(folio) + pin_refs) {
>>                         lru_add_drain_all();
>>                         drained = 2;
>>                 }
> 
> Not regarding the fix itself, I agree that the fix is correct. I am
> just a bit curious why we cannot simply do:
> 
>                 if (folio_may_be_lru_cached(folio) && !folio_test_lru(folio)) {
>                         lru_add_drain();
>                         if (!folio_test_lru(folio))
>                                 lru_add_drain_all();
>                 }
> 
> Or at least the following diff?

Best to read 98c6d259319e, which documents why this is required.

-- 
Cheers,

David
