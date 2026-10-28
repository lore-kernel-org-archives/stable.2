Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187659;
	b=RIqlyxSJujfFwNyAq40ARDV0S+CH1W57LDgoRmv6eHlD+4GEs5x+o5wYLWzbrkHDuheq
	 IFerlYxZyEyXsjZw2BSxmwwucYl8DHbJMcVadbxSn8wcwFYKsaUOlzQFObbsJ1HZV79n2
	 MHbZ2KdweckSaxxKeBFI4r5OH+UOlKkGiKd59Zqxrgy4rgJc3tQ6rwTicmL4Z8ydA2tMY
	 GK6CuilTD6bFgBjnGCFoI4Fb0n+ozbNCfznm3x5XQT+FtsdKzs1FjOuyPdZC6V77X++oM
	 dPFbLby9UZ1whIZ6M1yH1PZGdeockC2H4OObVZPBOTfsHi2YJ0WlWO4YAK+VApqGU5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187659;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=Jlnfz7M1ITZw2qIEVKqbY+WjiMkAWf1Tu97ZUZ93IN0=;
	b=wGvvJ7/j9XGMwhfpGhv0MQtlJN6t3KHirj0fDxG/SpwIMovA2bF7iTF6u5IFMn9iBdi6
	 u8d5MIvTtaRn48n7mVdNu1eCi3QhwNqdpCkB+aGoHsIA8owzfQZCicwMJALNswPibwhWQ
	 GuI4InQHiINYNjx/rs1Cm9CYfmkbD7d0kSE2KlMWqNQbX9GJ2j2+Ta/O5L7dFpALwLIef
	 cz75UEY9QMqp1isuWb+PB1J6nvAdPIfnNAW7xqZ+oLtVKpPY7RVUSd2ywNJMuUnc7DmBc
	 YKb0beieRgj2bAm+7igA15O94DpYHLWPcsj6f26HfGFQm/YbzJo/GAP8T8n/JgiQxWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PiZ+2Gl5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C898606A31C;
	Wed, 28 Oct 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PiZ+2Gl5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41CA1F01825;
	Wed, 28 Oct 2026 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187659;
	bh=Jlnfz7M1ITZw2qIEVKqbY+WjiMkAWf1Tu97ZUZ93IN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PiZ+2Gl5kc0jJSeKMLoj7fOmlVIOFgswoanYFqn1DWdsQBEuhQPix9JVy9oWukGPG
	 +F4YsgXNS1WGjwV30hoP8na9F/N7Eb7122WwInn552HizyxxW3YaCESCfroMU6yjAm
	 VSLYDm5acEbC8X+0g/aR2w/YcyxdJoeMZDvuNVvBD2N8xDX/JIOe5gr86tQJIXfRoq
	 39Z0YQ1Uj9IsiFhECBTs0uTCctxqUM5+Y5krqY7Am0KOxTRvkUfV1a6g8jHytioWqL
	 s93d076CkgIdrXOUk2WhEjj/95/4ACkRiIc76P4JQh7Skxr0Cekil6YVf24aF8v9MO
	 VTNrBK9m2sErA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Qi Zheng <qi.zheng@linux.dev>,
  Shakeel Butt <shakeel.butt@linux.dev>,  Lorenzo Stoakes <ljs@kernel.org>,
  Kairui Song <kasong@tencent.com>,  Barry Song <baohua@kernel.org>,  Axel
 Rasmussen <axelrasmussen@google.com>,  Yuanchu Xie <yuanchu@google.com>,
  Wei Xu <weixugc@google.com>,  Baoquan He <baoquan.he@linux.dev>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Mike Rapoport
 <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Kees Cook <kees@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Jann Horn <jannh@google.com>,  Pedro Falcato
 <pfalcato@suse.de>,  Hugh Dickins <hughd@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Jan Kara <jack@suse.cz>,  Zi Yan <ziy@nvidia.com>,
  Lance Yang <lance.yang@linux.dev>,  Rik van Riel <riel@surriel.com>,
  Harry Yoo <harry@kernel.org>,  Alistair Popple <apopple@nvidia.com>,
  Nico Pache <nico.pache@linux.dev>,  Ryan Roberts <ryan.roberts@arm.com>,
  Dev Jain <dev.jain@arm.com>,  Usama Arif <usama.arif@linux.dev>,  Kiryl
 Shutsemau <kas@kernel.org>,  Matthew Brost <matthew.brost@intel.com>,
  John Hubbard <jhubbard@nvidia.com>,  Peter Xu <peterx@redhat.com>,  Will
 Deacon <will@kernel.org>,  "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
  Nick Piggin <npiggin@gmail.com>,  Oscar Salvador <osalvador@suse.de>,
  Minchan Kim <minchan@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
  Xu Xin <xu.xin@linux.dev>,  Chengming Zhou <chengming.zhou@linux.dev>,
  Chris Li <chrisl@kernel.org>,  Kemeng Shi <shikemeng@huaweicloud.com>,
  Nhat Pham <nphamcs@gmail.com>,  Youngjun Park <youngjun.park@lge.com>,
  Gregory Price <gourry@gourry.net>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>,  Rakie Kim <rakie.kim@sk.com>,  Ying Huang
 <ying.huang@linux.alibaba.com>,  Jason Gunthorpe <jgg@ziepe.ca>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-fsdevel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-cxl@vger.kernel.org,  Chris Mason
 <mason@kernel.org>,  stable@vger.kernel.org
Subject: Re: [PATCH 20/46] mm/gup: fix clearing folios in memfd_pin_folios()
In-Reply-To: <ec55c760-f099-48e1-900b-9f8e2e5315da@kernel.org> (David
	Hildenbrand's message of "Tue, 27 Oct 2026 20:20:43 +0100")
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
	<20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>
	<2vxzbj8fp4sn.fsf@kernel.org>
	<ec55c760-f099-48e1-900b-9f8e2e5315da@kernel.org>
Date: Wed, 28 Oct 2026 12:40:48 +0100
Message-ID: <2vxzld7injcv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 27 2026, David Hildenbrand (Arm) wrote:

> On 10/27/26 16:00, Pratyush Yadav wrote:
>> On Tue, Oct 27 2026, David Hildenbrand (Arm) wrote:
>> 
>>> From: Chris Mason <mason@kernel.org>
>>>
>>> memfd_pin_folios() pins folios obtained directly from the page cache
>>> without checking whether they are uptodate. However, shmem fallocate()
>>> can leave newly allocated folios uncleared and not uptodate. Callers
>>> such as udmabuf can then expose uninitialized memory to userspace.
>>>
>>> Clear non-uptodate folios and mark them uptodate under the folio lock
>>> before returning them to the caller.
>>>
>>> Fix generated by an LLM and sent by Chris Mason in private.
>>>
>>> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Chris Mason <mason@kernel.org>
>>> [ david: simplify description and comment ]
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>>  mm/gup.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index efc9aa2654625..47e7ae152cdf1 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -3516,6 +3516,20 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>>  					goto err;
>>>  				}
>>>  
>>> +				/*
>>> +				 * fallocate() can leave folios in the
>>> +				 * page cache that were never cleared.
>>> +				 */
>>> +				if (!folio_test_uptodate(folio)) {
>>> +					folio_lock(folio);
>>> +					if (!folio_test_uptodate(folio)) {
>>> +						folio_zero_range(folio, 0, folio_size(folio));
>>> +						flush_dcache_folio(folio);
>>> +						folio_mark_uptodate(folio);
>>> +					}
>>> +					folio_unlock(folio);
>>> +				}
>>> +
>> 
>> Nit: this logic is repeated in a couple places in shmem.c and in
>> memfd_luo.c. Perhaps it deserves a helper?
>> 
>> Anyway, sounds like an important fix so don't make my nitpick stop you
>> from landing this if you don't want to bother.
>
> Thanks! yeah, I had the same thought when trying to improve this. We should have
> an easier way to just not hand out unzeroed folios outside of shmem core
> functions in the first place ...

Normally this should use shmem_read_folio() to get all the folios, which
does zero the folios before handing them out. I guess memfd_pin_folios()
uses filemap_get_folios_contig() for performance reasons. It does the
lookup under RCU and doesn't need to take the folio lock. Perhaps we
need a shmem_get_folios_contig()?

-- 
Regards,
Pratyush Yadav
