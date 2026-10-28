Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223954;
	b=cRNU0llln46bbBOu8iS+QE4efA+s6VsfyQED9A9qp02/VpTeyfbK/C02mepTNW5mLjAr
	 CBIVdIVaTUK33evfOdMLxO6ErC6C4GEakHp15+ofxIdPiiXeGO6VncFL1GlnYXiqr26Gf
	 0euEBEGugvxEo+ztNq7TOEczGqsS6j9WfVUpcEZKgpPrpA823yg7gbA84/vm1tk/kQwTR
	 xgBz8H2pE3DkrPp4E+6Aje1Tf0rYllOqCKGh6eG3gYl94GQT1zM0OjsFgPAiFxW48tdo5
	 hNU6zzOI//66+pSoVEjTKKQQRPRY9jmHeMtbHMRy4HnskVDeYZuCIrdPtc+7XcCF2UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223954;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fbrRyxoimymYWhLJDCrGjtIVJ2fCjNVZxRXAPG71cWM=;
	b=voM5OtyqsKtUminbs+kCs8LPPDVm1gvVbr+6zqZlnjE0bYm2gHwsnCBN3R7WVsMkI+XJ
	 SM3n1Nvzu0MNGdWCjWx19+4loFoTAhD3STY0eVtR1ZtD/BtreL1pf/wGnCPcgZRhwULj3
	 5y46nSNSzmXmeLJzkLrYb4WZTLgx0GqmozF6M7TuB7nEOJo9YIKLA2mtEvjFFRb/JkNRk
	 xNsDVBcOc2P10FV9Ba3bKAyoEu2iwZYsKQmeNHBU3fGoKUw4reK/iCAcuNk/uvHvr3qy7
	 eN3gL4BIm8vRSBJraQNyfww5Rlo4xhRnajDSzlOZc6UFAlMsFr8ZEhrhi9PKyeD5rPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UmI/Cm2S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE192606A31E;
	Wed, 28 Oct 2026 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UmI/Cm2S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAFF1F01825;
	Wed, 28 Oct 2026 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223953;
	bh=fbrRyxoimymYWhLJDCrGjtIVJ2fCjNVZxRXAPG71cWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UmI/Cm2SrjBwj1BQYLo3s5sb7BMvx3t0fFbpR+mnITEWqKp5wlIiQPLln6BkXC9rt
	 m6RZcvbkbKhA9qmDG4og48sVDa+PZnbyZkQMFjd/pOyk7PvFVJGwxKxmmGk3y4VKPW
	 r2JDXQHZuX8Fv0WEovG6xsUoSWzKG1qoZx3iP1IdmN4kwUKF7gtBwhyTc6yUCKAP9Z
	 tncWISQ22ZSz7AEGqiuFHP15FaJB7aOWP6s0aM9o3U08JKSaV3w1w5r5Gyr1Sq97Fu
	 XkskqqkTDrcPRQNfM87sfV+bHscqsB/Uf8B1Ourx7X22qLn5cpDzeSEB1WAvR51lNH
	 luun1fqwX46mg==
Message-ID: <2f2ef336-2186-4f20-b7f5-565e60471bda@kernel.org>
Date: Wed, 28 Oct 2026 22:45:34 +0100
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
Subject: Re: [PATCH 05/46] mm/truncate: look again if a folio left the mapping
To: Kiryl Shutsemau <kas@kernel.org>
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
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, stable@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-5-6f74bec9a5bb@kernel.org>
 <auIniV8YSpA4_oxg@thinkstation>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <auIniV8YSpA4_oxg@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 17:54, Kiryl Shutsemau wrote:
> On Tue, Oct 27, 2026 at 12:17:25AM +0100, David Hildenbrand (Arm) wrote:
>> invalidate_inode_pages2_range() skips a folio which no longer belongs to
>> the mapping by the time it has got the folio lock, on the assumption
>> that somebody else has removed it from the page cache. But the folio may
>> have been replaced, and then there is a new folio with the same data at
>> that index.
>>
>> For most cases, like folio migration, that is impossible. However,
>> collapse_file() only checks the refcount of the old folios, under the
>> i_pages lock, and relies on their folio locks from there on. That works for
>> users which repeat the lookup when they find folio->mapping changed.
>> The following scenario is, however, possible:
>>
>>   CPU0 pwrite(O_DIRECT)               CPU1 collapse_file()
>>   kiocb_invalidate_pages()
>>                                       read the folio (old data), lock it
>>                                       refcount check
>>   the write completes                 copy to new_folio
>>   kiocb_invalidate_post_direct_write()
>>     find_get_entries() -> old folio
>>     folio_lock() ...                  xas_store(new_folio)
>>                                       folio->mapping = NULL
>>                                       folio_unlock(folio)
>>     folio->mapping != mapping
>>       -> continue
> 
> The diagram reads as if the folio lock should have closed the race. It
> might be clearer with CPU0's folio_lock() after CPU1's folio_unlock(),
> since the reference taken after the refcount check is what matters:

I'll use that, thanks!

> 
>   CPU0 pwrite(O_DIRECT)               CPU1 collapse_file()
>   kiocb_invalidate_pages()
>                                       read the folio (old data), lock it
>                                       refcount check
>   the write completes                 copy to new_folio
>   kiocb_invalidate_post_direct_write()
>     find_get_entries() -> old folio
>                                       xas_store(new_folio)
>                                       folio->mapping = NULL
>                                       folio_unlock(folio)
>     folio_lock()
>     folio->mapping != mapping
>       -> continue
> 
>> In that scenario, the collapsed folio with the data from before the write
>> stays in the page cache after the write has returned.
>>
>> This used to be impossible, as khugepaged only collapsed files that nobody
>> had open for writing.
>>
>> Restart the lookup at that index, like shmem_undo_range() does. The same
>> problem seems to exist in truncate_inode_pages_range() as well when
>> truncate_inode_folio() fails, so handle it there as well.
>>
>> Fixes: 1b6444331beb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
>> Cc: stable@vger.kernel.org
>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/truncate.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/truncate.c b/mm/truncate.c
>> index 733d2713a875a..6d8c0ec4623fe 100644
>> --- a/mm/truncate.c
>> +++ b/mm/truncate.c
>> @@ -499,7 +499,15 @@ void truncate_inode_pages_range(struct address_space *mapping,
>>  			folio_lock(folio);
>>  			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
>>  			folio_wait_writeback(folio);
>> -			truncate_inode_folio(mapping, folio);
>> +			if (truncate_inode_folio(mapping, folio)) {
>> +				folio_unlock(folio);
>> +				/*
>> +				 * Folio might have been replaced: look it up
>> +				 * again.
>> +				 */
>> +				index = indices[i];
>> +				break;
>> +			}
>>  			folio_unlock(folio);
>>  		}
>>  		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
> 
> This hunk looks unneeded to me: its second loop restarts from start
> until find_get_entries() finds nothing, so the new folio gets truncated
> on a later round. Or am I missing a case?
For truncate_inode_pages_range() I *think* the "index >= end" might prevent
another lookup that we would need.

Assume we have a large folio with 512 pages for simplicity, and we want to
punch-hole the first half of it.

The whole partial splitting logic (truncate_inode_partial_folio) will first
split that folio buddy-like into various folios.

Now we want to remove the split folios in the loop:

index = 0;
end = 256;
while (index < 256)
	if (!find_get_entries(mapping, &index, 255, &fbatch, ...

	-> Returns our split folios from the buddy split, the last one should
           cover pages 128 to 255
	-> Sets index = 256

Then we have the concurrent stuff happening. We wouldn't re-execute the
find_get_entries() even though a folio was replaced in the meantime, as index =256.

My brain hurts, does the above make sense?

-- 
Cheers,

David
