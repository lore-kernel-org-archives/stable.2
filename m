Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859750;
	b=OjAMgSZ2wRm2o/84q9qupYzFude3JJaonIFqzkh2dSi7Q1sxN/Foppr1EQHxOLPtQeS1
	 BgN9GKE50nqvrPvBlnhg2KAaiqc2wGIJ70elomxrW7ixQGXBmrQRQIvH2kQnpUsz+1lCj
	 NoCI9DKeEXa00fR2jLMfLEOPi1VhBWe5DjQHLxQlu4yUDmoxYzI5pq5gKQK6SEqmFGzbD
	 ItGn9XWbz1yUfKBxxGFHkd4XZQt9FSOA5NhcwSKLBw39uHkm/c3HDXF9LVIbsHSchQ0lW
	 dvyHS2Ox3N1iTKKlXc7aZXsxzecR50kHa5J162tGVVmoC3f+TL4odX1Ok/h47Tu1w7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859750;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=rzKNYZ9/Wem0fAV5vHkWqEBhTbAs/OylY7gdTFQ8NN8=;
	b=KkIg5TDftbNmDXo/RSTYWAxAn7o9qiR607gHRwgqKMakyC35jykatrAjCJQS8zz4n6x4
	 FxRSEEKBwIncBkwIj7wg+s2KcZRWQ4sMpt00iED5SYAD9uu5ErdMYZmLh79whuKLXFcKk
	 ZigCGM4wQYvzztRkFNdCxJKcG/feMM58ieIwBNQqlc11nwkGkk2TX9QAYqYWCkpkicDfL
	 YuNJdKiR6qvwQMXnhH82ecXv92kVIT8+5NpwKgcz2C1z2SKmdwArVUn0nU+NgHddA6F4t
	 ao/7vdUmlQS1LXntvdnX1y76DDEwGfP6dpUgfu72l2vaxzhKUgO5ufbc6FB0Fksa3cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEXaY7Z4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D00606A31C;
	Mon, 16 Nov 2026 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEXaY7Z4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B011F000C4;
	Mon, 16 Nov 2026 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859749;
	bh=rzKNYZ9/Wem0fAV5vHkWqEBhTbAs/OylY7gdTFQ8NN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JEXaY7Z4qPWvi6j6ABBzHSqBQ0UeRC3gRR6zAet1hLukS6wRFQKhucP9ooMEUftv9
	 FsCKm4xm3uRrlxnabyK9CWRVhjo5tFqJkCIVG22pEHyHiO6xuk0t3Q7OGFJONj8/69
	 3pF80vwAK+ms8PpIpsAdbRX0WPKglxSXwqWjwZhTmZYgbeI0Xp3vopQwoZB2qbBT5d
	 w6S+B8ReYy0lYKPDhh5mBiCxQhKs423XbLNdcClfTIdtRBCdv+Lj814kx46LPuFcRj
	 nvEnzOkPZ+4DV0F2vKSOObaYlvWSs4yuBQtrMhM+NqfmFgrIav6zjk2o7PhKpgH+H6
	 nIsrJcL1jPA5g==
Message-ID: <c9ac9557-70bc-46f1-a231-2d2a6e3f8c3e@kernel.org>
Date: Mon, 16 Nov 2026 21:09:00 +0100
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
Subject: Re: [PATCH 3/3] mm/huge_memory: only compare PFNs of huge entries on
 huge fault insert
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>,
 stable@vger.kernel.org
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
 <e13044a0-871b-4033-8a79-22cb9653b6b1@kernel.org> <avsz6Op6mfkF4y1x@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avsz6Op6mfkF4y1x@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 17:55, Lorenzo Stoakes (ARM) wrote:
> On Mon, Nov 16, 2026 at 05:01:52PM +0100, David Hildenbrand (Arm) wrote:
>> On 11/15/26 21:58, Lorenzo Stoakes (ARM) wrote:
>>> A driver that implements both ->fault and ->huge_fault must anticipate
>>> concurrent use of both.
>>>
>>> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
>>> concurrent with faulting, as that only holds the mmap write lock and thus
>>> does not exclude faulting threads stabilised by VMA lock.
>>>
>>> insert_pmd() and insert_pud() have issues with this as they both assume
>>> that, if the page table entry being populated is not empty, it must a
>>> present huge entry.
>>>
>>> This is problematic as if it is a write fault, it compares its PFN against
>>> the one being inserted, warning if they differ, on the assumption that the
>>> entry is a huge leaf.
>>>
>>> Since the entry may be a page table, this is invalid and can result in
>>> spurious warnings.
>>>
>>> Equally, the entry might be non-present. Nothing can install such an entry
>>> in the VMAs that reach this code today, but there is no reason to rely upon
>>> that.
>>>
>>> Therefore only examine the PFN if the entry is both present and huge, and
>>> otherwise simply return VM_FAULT_NOPAGE so the fault is retried and handled
>>> at the appropriate level.
>>>
>>> This is what already happens for a read fault, for which the existing entry
>>> is not examined at all.
>>>
>>> Target the commit which introduced the first driver which both mixes fault
>>> orders and passes the write flag for the fix (since this commit, both
>>> drm_gem_shmem and panthor are prey to this issue).
>>>
>>> Reported-by: Eliav Farber <farbere@amazon.com>
>>> Closes: https://lore.kernel.org/all/20261112051440.16140-4-farbere@amazon.com/
>>> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>>> ---
>>>  mm/huge_memory.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 0d589be136d2..da632c3e834b 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1643,6 +1643,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>>>  		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
>>>  					  fop.pfn;
>>>
>>> +		/* We may have raced a fault which installed a page table. */
>>> +		if (!pmd_present(*pmd) || !pmd_trans_huge(*pmd))
>>
>> Ok, we hold the PMD lock, so that cannot change concurrently.
>>
>> Given that we are in THP code, I wonder if we could just test for pmd_leaf()
>> instead.
>>
>> Same below for PUDs.
> 
> That's what the original did, but as the commit message says I don't want
> to rely on the entry not being a softleaf here, in case we do something
> later that changes that.

Oh, I was talking about:

	if (!pmd_present(*pmd) || !pmd_leaf(*pmd))

Which is our common way of saying

	if (!(pmd_present(*pmd) && pmd_leaf(*pmd)))

	"This is not a page table".

Anyhow, getting rid of pmd_trans_huge() doesn't have highest priority right now.
-- 
Cheers,

David
