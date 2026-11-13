Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600059;
	b=WC25/w89FLBa3H8wVLIpNSQ1AziNZZvhMXAa0AhUzYcV+ARvpUWWkq0hK9CYbAWgLV/b
	 zaZOZTtalAH7QbHH0g2T2wnn0yWufmCrkgyfPsCi2aQWbMuc3I5o4IM1Rfi8+T4P4BXbp
	 GnhuZ6kvpaluH+Kk6QkA23pKAxFHaQxV6LT9reeHWIhxDPFNaSKrpnciGOkA1Z6hpE9+b
	 xB0UGfwLRl4rBelJYNT+xqhCtvSpwFRBjoL9ODhs5grC/Gxsa9bZzAgsfsP9+CoerqNdn
	 mt1S1dejdqYAIp8FYhoWP1M4uy8aXjkB4yrzNtP5Ck1T8gdnqr6btaTaVYUmzzrDzZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600059;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cVUaiMaz3XMN9uwKkKZrpHW2DyS8HoLv5GhhqXeNd3c=;
	b=HpA7dG5qM3s5sA9gayaROX2UKpq8TZ77uPpsgBJy/3d69EDWdXH0ODfYkxrHrBAD4coh
	 q6qzPL3QPLkNPq56qwSz3sNtKuV5Agjm6X3MohOqrus+OGNIEMoZw+YxJEEmvjimvN9KR
	 c7f8I1GOVnnTiOMsQrYwFZjh26giPcC5yyx9p7IuSZ5WiCDOvyMQOs6UW8QfnPhP2+yxy
	 MW/Wt+1lvpmK0uHA24v9ZtT3PJA9SkFoKYsfVvk0K4J2Vk/yBZLKTm7WxtXFZXupuZAjl
	 L6MR9u+1LZap2ccuT8SwcnHIT2eZKumOmN8azCPpvftbdn3M/+d67x/afkjHpq9V5jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyUCD7Uy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D789606A89F;
	Fri, 13 Nov 2026 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyUCD7Uy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49AC1F000C4;
	Fri, 13 Nov 2026 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600059;
	bh=cVUaiMaz3XMN9uwKkKZrpHW2DyS8HoLv5GhhqXeNd3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OyUCD7UyGbgQkY37EnEigD1L/mrS7PBtAgr+4NmGTZUelqoLujjnkQSl5X8ARX9MI
	 +N/R6NXrTN7PcrCbmG/pn27YFyv29KKY0XQoMMAUfuHO8AlBL7bBkgke2RbJvLRPau
	 gqlZKfWqdyCRLwVmQBvbVLOkIeDne2b24kKHimyfVWs7mXPP0YasHlDFJjkbRUClJ0
	 B/2YPA2lbPXMYhcPkl6S0YHYVWhH4pYxJz/ZIFporIOHnC79l8MpxhfGy+VNxSydkm
	 o5/gV4LFTaPbY5q4iab0I9lC5gCZrC/A7fMlWILAEbgb7ZUXgDiS+PGC1UtJqmTk9S
	 k8m6JJ8gBDoYA==
Message-ID: <6630ec25-3648-4d60-beb7-61572053318b@kernel.org>
Date: Fri, 13 Nov 2026 21:00:42 +0100
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
Subject: Re: [PATCH v4 1/9] mm: limit pagecache folio refcount when mapping
 pages
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org,
 Pedro Falcato <pfalcato@suse.de>
References: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
 <20261112-refcount_overflow_stable-v4-1-ad3deef0bd23@kernel.org>
 <avdovRTVITLwuit_@casper.infradead.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <avdovRTVITLwuit_@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 20:45, Matthew Wilcox wrote:
> On Thu, Nov 12, 2026 at 11:53:20PM +0100, David Hildenbrand (Arm) wrote:
>> Being able to overflow the refcount is not really big news, but it's about
>> time that we do something about it because some modern technology might
>> find ways to abuse it :)

Hi Willy,

thanks for the review!

Be aware that I want to get this fixed now asap. So I will push back against any
bigger changes on this for now unless there are real issues to fix.

I want to get this sent early next week to Linus.

With future changes I am planning, mappings will no longer be an issue. I will
then drop admin reserves (as the chance for DOS will go down drastically) and we
can use the negative refcount as our limit.

> 
> Yes.  My primary worry is actually it finding a path where we forget to
> put the refcount on a folio and that gets exploited into a UAF.  I'm not
> sure the "reserve for root" aspect really helps recover from that, but
> I'm not too opposed to it.
> 
>> As a short-term solution, let's introduce two folio refcount limits:
>> one for ordinary consumers and one for admins. Leave some headroom
>> before the refcount goes negative, which we really don't want (having
>> the mapcount go negative is also not expected).
> 
> I don't think a negative refcount or mapcount is really a problem.  What
> matters is that we don't get to zero from below (for the refcount)
> or that we don't get to 0xf000'0000 (for mapcount).

They are a problems in current code with both negative refcount and negative
mapcounts.

Nothing I want to sort out in this patch set.

So if we reach a negative mapcount of refcount today, we messed up.

> 
>> +/* Leave separate reserves for administrators and concurrent reference gains. */
>> +#define FOLIO_REF_COUNT_LIMIT		(INT_MAX - (1U << 26))
>> +#define FOLIO_REF_COUNT_ADMIN_LIMIT	(INT_MAX - (1U << 25))
> 
> I think these specific values will generate bad code.

Again, we can worry about fine tuning once we have a proper fix in place.

> 
>> +static inline bool folio_ref_count_over_limit(const struct folio *folio)
>> +{
>> +	const unsigned int ref_count = folio_ref_count(folio);
>> +
>> +	if (likely(ref_count < FOLIO_REF_COUNT_LIMIT))
>> +		return false;
> 
> I would replace this with a simple signed comparison against 0.

As per above, this is something for the future.

> 
>>  static inline void folio_get(struct folio *folio)
>>  {
>> -	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
>> +	VM_WARN_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
>>  	folio_ref_inc(folio);
>>  }
> 
> And I would drop this hunk.

Similarly, for the futue.

> 
>> diff --git a/mm/util.c b/mm/util.c
>> index 80f6c714844f2..c9c3dc4b490fa 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
> 
> Now we have mm/folio.c, I think it should live in there.

I can move it.

> 
>> @@ -791,6 +791,32 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
>>  }
>>  EXPORT_SYMBOL(folio_mc_copy);
>>  
>> +bool folio_ref_count_over_limit_slowpath(const struct folio *folio,
>> +		unsigned int ref_count)
>> +{
>> +	if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
>> +		goto over_limit;
> 
> Maybe let this go up to 0x8100'0000?
> 
>> +	/* Background threads must not consume admin reserves. */
>> +	if (current->flags & PF_KTHREAD)
>> +		goto over_limit;
>> +	/* Neither must interrupt contexts on behalf of the interrupted task. */
>> +	if (!in_task())
>> +		goto over_limit;
>> +	/* Capability checks are not safe with IRQs disabled. */
>> +	if (irqs_disabled())
>> +		goto over_limit;
>> +	/* Use the task's credentials, which filesystem overrides cannot change. */
>> +	if (has_capability_noaudit(current, CAP_SYS_RESOURCE))
>> +		return false;
>> +
>> +over_limit:
>> +	pr_warn_ratelimited("folio:%p refcount:%d mapcount:%d mapping:%p reached refcount limit\n",
>> +			    folio, (int)ref_count, folio_mapcount(folio),
>> +			    folio_mapping(folio));
> 
> If it's worth doing folio->mapping, maybe also print folio->index?
> In fact,

I can do.

> 
>         pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
>                         folio_ref_count(folio), mapcount, mapping,
>                         folio->index + idx, pfn);
> 
> might be worth pulling out into a mini helper from __dump_folio()?

I want a pr_warn_ratelimited though.

Again, thanks for the review, I want to get this fixed asap now.

-- 
Cheers,

David
