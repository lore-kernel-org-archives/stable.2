Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221628;
	b=D7dOFl/l5RhP9XsDNXo+ErqvX4I/mg5sQRdppC66HAsM/YvYFkie8TXCbw3pzvA3bsoS
	 2zddtITu2WpXO6s7qm/pLD8bHmS0FpBuIMTiLYWjKMABsw5hleUS5HCRJccJeohrfuKEG
	 cL4ty5d/DsEIaHsD/c/Rfx8LGtlt6D6OKye7ecalp25WWVN9ePubjl/9wy88mmhl3uWw6
	 mKuksK9kK3YlItLsKvwSCSKm+bePGSzZ9leRFPo3BUT6iewTLNbkUHKUYYMvUR5Nmsnnp
	 wo29TOf8jySbutEHWujJVTyoC+OZEGwYyrq83iMl3SutYNU7LGI/uTsz9GS0+AeEIhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221628;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=xxZoPiTulvdMTGEYFvoIZ44CCQijO9eunuLg0kQXxFk=;
	b=WAp++ILAbWJcRAcA7+lKgzLN/CAw47qhHh/E4bdS64UG5FOBS2608RjTj/15iE1ipAOT
	 10uQQaz55XD4LdS3ure11IG03/Tr5zm41Jc8FTfOq0UKmGzwch/hZoOFAmrPApVfzVMYq
	 DBQhHuIq9qwc8sTQYPfPpwQ36XKUW8G8/EW5sK0NIvM94fg1hT6nr+kZQYXnvLmiupPps
	 S6dO3sC3VtczuMuJCjlbG96K/xsR56o+F2iYY3rWhAM+W5fK/eTHl4YHmp5RJfHtHVDHY
	 I0Ty2Ki6X3pAHCOD3ZBC9iZgNy4kZzch3BZ4/p6L8r7Ph6NAvpsM9cfrC9oxWxV7bXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LN/bo96W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01340606A31C;
	Wed, 28 Oct 2026 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LN/bo96W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C600A1F01825;
	Wed, 28 Oct 2026 21:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793221627;
	bh=xxZoPiTulvdMTGEYFvoIZ44CCQijO9eunuLg0kQXxFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LN/bo96WZvsiQi1qe+JR9nlcD/dtIGQ3FMfkNtmijuD8fjEQvKUZbveUSkvBFTpiT
	 q6Edde755VLLwfbtDICVm/OW4Pm+/etk4qBGkfzt7OHtDuZ3eCdxBEwg9OirXuns+M
	 XsvYfyUNxV7GxmUXhpEDJCqSSig5E7leSPceajxOCaywHlCdhCxFMwskHRcKuUXv06
	 PDthkCr7ALLRll2jP+OhkIKbt46NDpsV5HResmFBVneLOSa8AjHiykgI/EVkjCB6+y
	 im/ok434xapBK6Jzyew5LWXpxM6m7VRgE7Je11/Pjst7rZUdUqcoFHcm6G7+s6AIdF
	 R9o+fP1ANqrsg==
Message-ID: <d709fc9e-1940-4e73-92a1-09ab36ae16c5@kernel.org>
Date: Wed, 28 Oct 2026 22:06:49 +0100
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
Subject: Re: [PATCH 31/46] mm/mremap: fix moving PUD leaves
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
 Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-31-6f74bec9a5bb@kernel.org>
 <auH0bgdchd6DyCbU@pedro-suse.tail5790ac.ts.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <auH0bgdchd6DyCbU@pedro-suse.tail5790ac.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 14:20, Pedro Falcato wrote:
> On Tue, Oct 27, 2026 at 12:17:51AM +0100, David Hildenbrand (Arm) wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> pud_none_or_clear_bad() only really works on page tables. PUD leaves
>> confuse the check and make us clear the page table entry and print a
>> warning.
>>
>> Since commit aed877c2b4257 ("device/dax: properly refcount device dax pages
>> when mapping"), this also leaks device-DAX folio references, mapcounts
>> and RSS accounting, resulting in "Bad rss-counter state" warnings on exit.
>>
>> Allow PUD leaves in get_old_pud(). If a PUD leaf cannot be moved as a
>> whole or the move fails, split it. This unmaps it with proper accounting
>> instead of treating the leaf entry as a PMD table.
>>
>> Keep using pud_trans_huge() for now, in the future this code should be
>> cleaned up to just check for PUD leaves.
>>
>> Fix generated by an LLM and sent by Josef Bacik in private.
>>
>> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> [ david: fallthrough after splitting ]
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

> 
>> ---
>>  mm/mremap.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 91f0865f6aeea..1237718848f5c 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -87,7 +87,7 @@ static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
>>  		return NULL;
>>  
>>  	pud = pud_offset(p4d, addr);
>> -	if (pud_none_or_clear_bad(pud))
>> +	if (!pud_trans_huge(*pud) && pud_none_or_clear_bad(pud))
>>  		return NULL;
>>  
>>  	return pud;
>> @@ -847,11 +847,10 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
>>  		if (!new_pud)
>>  			break;
>>  		if (pud_trans_huge(*old_pud)) {
>> -			if (extent == HPAGE_PUD_SIZE) {
>> -				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
>> -				/* We ignore and continue on error? */
>> +			if (extent == HPAGE_PUD_SIZE &&
>> +			    move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud))
>>  				continue;
>> -			}
>> +			split_huge_pud(pmc->old, old_pud, pmc->old_addr);
> 
> Note that, if the HPAGE_PUD move fails, we split but miss the opportunity to
> move at the PUD level (right below). Is this on purpose? Am I missing
> something?

I was mirroring the PMD code, really. There, we also don't seem to move a PTE
page table when moving the PMD leaf failed and we split.

I think part of the puzzle is: move_huge_pmd() / move_huge_pud() only really
fail if there was some race with concurrent splitting. So it doesn't really
happen all that often I guess.

> 
> ... I say, realizing I am missing something, because split_huge_pmd (and
> consequently split_huge_pud) just decide to zap if the VMA isn't anonymous,
> and split_huge_pud() just hardcoded it to "of course it's not anonymous, lol",
> and just zaps. So there's no point in moving what isn't there.

Right, we don't support anonymous PUDs and file PUDs/PMDs are split by
effectively zapping them (no PTE page table prealloc required).

Can I hear that you are interested in cleaning up this code? :)

-- 
Cheers,

David
