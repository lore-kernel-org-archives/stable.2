Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007518;
	b=MbI63vkcmtIG1HYk052BmlbMvCsJykVyX2/EYRlF3eOG2EbA2TtvMIiYLqFq0mLbzwQU
	 h3/Daxdb8/FYF9bbujd5vRS7Q22NSHtZLSRMqSpPeGLPE7xC/CUR88sLTLGkEQPKocKMq
	 QJVgep0aDsLHgtoobt92iWRXQT+CPJv6StmTunJkCGiRi3mUJuUQHlsbkFvGMoxqm/1Fs
	 BVaT1x7oAmybyng60cSdpPQ4KlMuUOcs1BygF10KnWy6IQFV2jCoEGuysy5r/dvEFXRJA
	 dyWq0vbm+0lwUkfqHwryUUamCWzVXz5v5Dh5+mFy4oONm8BMyGC23YRWK25bVePLR8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007518;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=OS/+VLIvLCclNI397My8q3LjXY/Yk5vw3CEic1mr37c=;
	b=bRGGRj+9J5Tq1YWUfOfv1c+zSjRjWocfzLAaJF16xpGiuLjWjlT8ppNaN+BRYPzcCC+v
	 0S1luN6qyb/1ofYZSR7RIdH0f0hO1Tgj67pCezYbGOoUT1C44druiiJdgBBx2WMsI/agn
	 eoDSAwd/kQYv75HqV+2zfwBnNYlLSdR02PEAGxQhip2RI39ffJGc8Z5WGncK/kLWPWLl0
	 cEBvbFMvVdYeRnYHMPeFiJ0uEp4epT6UDjJzzOwutGK6BkFuXBFjaP7HAm7qFkdLQt4cQ
	 /+Hevo2yZ1KSHto7IovtNOZchwoVymtanaFg0Ty3iMU4xO+YQ4wH46330ptrNl3JOFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NceyAkCQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B47606A326;
	Fri,  6 Nov 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NceyAkCQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF931F0089F;
	Fri,  6 Nov 2026 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007517;
	bh=OS/+VLIvLCclNI397My8q3LjXY/Yk5vw3CEic1mr37c=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=NceyAkCQmMG4b/DAanRIqf+RGeQZ275A6btG9R6Jeyvow7he/aODMZmg+NZa03Z1N
	 xwdHlCdI8opWflHq/tbeeJQKWfeF9FydRg8c+gDukJ1up2XXQ2K5Gb1m/pCeQawlLr
	 CP+jgbKTf0kv4gunItcSesSP4mw7Z3WWvBgP+a/OA3XLqEoRibzLSa9ZiMgkzR1vaQ
	 2YBcXelmsslr431xNQx19YBll30Rfeb/rTKd7mqhwFt6da6naDqjofspumCgK2OoIh
	 A055sIERzPUYeoOEFVkiYb81xdiAOhbc2eo5cdzcCmmtmPrzKwCVa11NafBmZzyP1E
	 BxxHvrFsUj+lQ==
Message-ID: <7948ffce-9062-4362-b191-984368bfbaca@kernel.org>
Date: Sat, 7 Nov 2026 00:25:03 +0100
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
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
 <au3JT5QXbcOFXCp0@thinkstation>
 <323500a7-ffca-4285-929e-f667415589a3@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <323500a7-ffca-4285-929e-f667415589a3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 21:54, David Hildenbrand (Arm) wrote:
> On 11/6/26 13:38, Kiryl Shutsemau wrote:
>> On Thu, Nov 05, 2026 at 02:10:10PM +0100, David Hildenbrand (Arm) wrote:
>>> With large file folios, overflowing the folio mapcount and refcount
>>> became possible. For anon folios it is currently not really an issue:
>>> each large anon folio can only be mapped once into a process.
>>>
>>> That's not really big news, but it's about time that we do something
>>> about it because some modern technology might find ways to abuse it :)
>>>
>>> One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
>>> refcounting"), however, file thp support was added later.
>>>
>>> File folios can be mapped multiple times into the same process, allowing
>>> for processes to hold many references to the same folio.
>>>
>>> As a short-term solution, let's introduce two folio refcount limits:
>>> one for ordinary consumers and one for admins. Leave some headroom
>>> before the refcount goes negative, which we really don't want (having
>>> the mapcount go negative is also not expected).
>>>
>>> Start reporting SIGBUS if we run into limits. When restoring mappings
>>> from migration entries, instead zap the pte/pmd entry. We allow for
>>> slightly exceeding the limit to keep things simpler.
>>>
>>> This is far from ideal, but better than all easy alternatives we can
>>> backport comfortably. For now it fixes the big problem: letting
>>> the refcount (+mapcount) go negative and cause trouble.
>>>
>>> This is only a temporary fix, we'll follow up with something better.
>>>
>>> While the refcount checks are not required for order 0 folios, let's
>>> just add them for consistency: each folio_add_file_rmap*() and
>>> folio_dup_file_rmap*() needs a prior check.
>>>
>>> Also, just document -EHWPOISON for copy_present_ptes() while at it.
>>>
>>> Reported-by: Chris Mason <mason@kernel.org>
>>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>>  include/linux/mm.h | 33 +++++++++++++++++++++++++++++++++
>>>  mm/filemap.c       |  6 ++++++
>>>  mm/huge_memory.c   | 24 ++++++++++++++++++++++--
>>>  mm/memory.c        | 23 ++++++++++++++++++++---
>>>  mm/migrate.c       | 11 +++++++++++
>>>  mm/userfaultfd.c   |  4 ++++
>>>  6 files changed, 96 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index a2dd76cc5bbfe..79ae8fc0d6bb4 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -8,6 +8,7 @@
>>>  #include <linux/gfp.h>
>>>  #include <linux/pgalloc_tag.h>
>>>  #include <linux/bug.h>
>>> +#include <linux/capability.h>
>>>  #include <linux/list.h>
>>>  #include <linux/mmzone.h>
>>>  #include <linux/rbtree.h>
>>> @@ -2228,6 +2229,38 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
>>>  #define folio_ref_zero_or_close_to_overflow(folio) \
>>>  	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
>>>  
>>> +/* Leave separate reserves for administrators and concurrent reference gains. */
>>> +#define FOLIO_REF_COUNT_LIMIT		(INT_MAX - (1U << 26))
>>> +#define FOLIO_REF_COUNT_ADMIN_LIMIT	(INT_MAX - (1U << 25))
>>> +
>>> +/**
>>> + * folio_ref_count_over_limit - Check whether to refuse more folio references.
>>> + * @folio: The folio.
>>> + *
>>> + * Relevant for large pagecache folios (!hugetlb). For these, we have to check
>>> + * before adding page table mappings or other significant refcount users whether
>>> + * we are close to our folio ref count limit, to avoid overflows.
>>> + *
>>> + * Checking this for other folios does no harm but is mostly unnecessary.
>>> + *
>>> + * This check is an approximation; we leave some headroom such that concurrent
>>> + * increments, batches and temporary references are not a problem.
>>> + *
>>> + * Return: True if the caller should refuse additional references, false
>>> + * otherwise.
>>> + */
>>> +static inline bool folio_ref_count_over_limit(const struct folio *folio)
>>> +{
>>> +	const unsigned int ref_count = folio_ref_count(folio);
>>> +
>>> +	if (likely(ref_count < FOLIO_REF_COUNT_LIMIT))
>>> +		return false;
>>> +	if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
>>> +		return true;
>>> +	/* Background threads must not consume admin reserves. */
>>> +	return (current->flags & PF_KTHREAD) || !capable(CAP_SYS_RESOURCE);
>>> +}
>>> +
>>>  /**
>>>   * folio_get - Increment the reference count on a folio.
>>>   * @folio: The folio.
>>
>> Does the slow path need to be inline at all 15 call sites, GUP-fast
>> among them?
> 
> It's not a lot of code. Do we really care?
> 
> E.g., in gup.c, the compiler is free to not inline into each of the two callsites.
> 

Okay, I ended up splitting it up. A bit nsaty now that fuse will require an
exported symbol.

>>
>> Maybe only leave the likely() check in inline and move the rest into a
>> function call?
>>
>> Something like:
>>
>> static inline bool folio_ref_count_over_limit(const struct folio *folio)
>> {
>>         const unsigned int ref_count = folio_ref_count(folio);
>>
>>         if (likely(ref_count < FOLIO_REF_COUNT_LIMIT))
>>                 return false;
>>         return __folio_ref_count_over_limit(ref_count);
>> }
>>
>> bool __folio_ref_count_over_limit(unsigned int ref_count)
>> {
>>         if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
>>                 return true;
>>         /* Background threads must not consume admin reserves */
>>         if (current->flags & PF_KTHREAD)
>>                 return true;
>>         return !capable(CAP_SYS_RESOURCE);
>> }
>>
>> Also, should this be capable_noaudit()? I am not sure a refused
>> reference should leave an audit record. cap_vm_enough_memory() checks
>> the admin reserve with CAP_OPT_NOAUDIT.
>>
> 
> Not an expert, but capable_noaudit() sounds good.
> 
> Not sure if that fully resolves sashiko's complaint in the last commit.

Ok, the noaudit definitely seems to be the right thing. But getting overlayfs +
fuse oddities done "better", I am using has_capability_noaudit(current,
CAP_SYS_RESOURCE) now.

Hoping that is the right thing to use now ... review appreciated.

-- 
Cheers,

David

