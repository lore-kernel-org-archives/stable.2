Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221029;
	b=SvnbMzkIPVJtTcqKadTpfx9NafqYC5lYBAT6PneTIPpCAeG78fLiW+KNTCRntzmiPLav
	 E3jUwYmwD2yE4Z5LKo+PFvbgtnayUGNxEiaktFI0Bw6QbGHVSOoY2CUUMfjWzscNCXdwI
	 t+JGSNwD6ejnP8+Ue4lC8WACqj2Y6v40Zr0RuIp6hTGiKwbYmXqr1ek9J8CsQgtyYgj9n
	 +uG0n6nFk8t2lC+EpyXI6+laRNYhNksk/qUeDxu4zJwdGn8HrtMFNqf2o1St3yc8x2MyC
	 A5gkr1U+/XIV0FWWgU9C+4cnEhAf7IGZZ8w6pGHcVHzhqRgluQ76lEGYFkh3vYO0e+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221029;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VBRXJGFXK0qCkmji9XuilGdSC6PWUqjPX0mT1B8+Dew=;
	b=CQPqI6AT/BuiRazp1myyc9Ae1zAuRlqSazuzLPp/5M2e3/x6iywOHPUPTYlDViahmDi1
	 YGDFzwb/Efwx7sbJfTqyidmyIO4Fc970ZcHmeRPG04MtIMKsH1wrwprxTdfAJ5ovXqYzR
	 i7qS4KFJUpl3XHhL6g+2zOqquWMbcL+J50TOlxpdF/vz/td/5oZrDQHy77XMIF13vXN4S
	 ZLUVI+DLvLFMeTYSfvzddH4enMwZZMweZmVPpRoLkKNYWRyxjuRngnRYfjWejHzhJEUhU
	 /5SSpYSZxFVi3UedOR2L6gK/L3rhs4I2wv/k1E8ZAiZ/uPquIIYiycTmK5Q6bUN57vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6++6R92;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44309606A322;
	Wed, 28 Oct 2026 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6++6R92
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08141F01825;
	Wed, 28 Oct 2026 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793221028;
	bh=VBRXJGFXK0qCkmji9XuilGdSC6PWUqjPX0mT1B8+Dew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d6++6R92Y9pW/L7qdwwXGd0u/fINnIlp1NYiXwaft8WuvM2tnh59aB+MIfDwM3CYs
	 7OBmLdZ2yf/hpA8zpc7z5GdDAf3CTGmZVsA0hpoyhtF6kc1L6FM9QY6FPQzJGgCNiM
	 9Gle+WZku0sAgiTcOS5G2JnLcI+qrDvkcNMlVF6RCTWmoNWW7uHd+G1PGIIff8zlHa
	 fPM56Qjn7U5XHgFTGxseW76jmouqIFti8WxpybzmVtUdGoYf7HNRmalUpxMtAY3Qao
	 mgALZ2krEDvrdX6MlU+nCOicB8+IQASXlEKAHYsbgLpoWmWmdQnVWuDP0TEVs7UF1Z
	 xjngcVGllnCNA==
Message-ID: <b90cd9a6-4303-4ea6-b76a-8cece1ca0284@kernel.org>
Date: Wed, 28 Oct 2026 21:56:42 +0100
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
Subject: Re: [PATCH 08/46] mm/filemap: finish fault cleanup before dropping
 the fault lock
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
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
 linux-cxl@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-8-6f74bec9a5bb@kernel.org>
 <auJMY1xFp6EkhXbZ@quatroqueijos.cascardo.eti.br>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <auJMY1xFp6EkhXbZ@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 20:26, Thadeu Lima de Souza Cascardo wrote:
> On Tue, Oct 27, 2026 at 12:17:28AM +0100, David Hildenbrand (Arm) wrote:
>> On a retried fault, a fatal signal interrupting the folio lock wait
>> makes lock_folio_maybe_drop_mmap() drop the fault lock without pinning
>> the file. However, filemap_fault() may still need to release
>> mapping->invalidate_lock. A concurrent munmap() can release the last
>> file reference and free the mapping before that unlock.
>>
>> Defer dropping the fault lock to filemap_fault()'s retry cleanup, after
>> releasing invalidate_lock. If the fault lock was already dropped for
>> I/O, release the existing file reference instead. Keep the fault lock
>> held for FAULT_FLAG_RETRY_NOWAIT as before.
>>
>> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
>> Cc: stable@vger.kernel.org
>> Reported-by: Chris Mason <mason@kernel.org>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/filemap.c | 37 +++++++++++++------------------------
>>  1 file changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 6b5e1d866a9e0..b04be64a5069f 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3308,11 +3308,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>>   * @folio - the folio to lock.
>>   * @fpin - the pointer to the file we may pin (or is already pinned).
>>   *
>> - * This works similar to lock_folio_or_retry in that it can drop the
>> - * mmap_lock.  It differs in that it actually returns the folio locked
>> - * if it returns 1 and 0 if it couldn't lock the folio.  If we did have
>> - * to drop the mmap_lock then fpin will point to the pinned file and
>> - * needs to be fput()'ed at a later point.
>> + * Returns 1 with the folio locked, or 0 if locking failed.
>> + *
>> + * On both entry and return, a non-NULL *fpin means the fault lock has
>> + * already been dropped and the caller must eventually fput() the file.
>> + * Otherwise the fault lock is still held, including on failure.
>>   */
>>  static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
>>  				     struct file **fpin)
>> @@ -3329,21 +3329,9 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
>>  		return 0;
>>  
>>  	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
>> -	if (vmf->flags & FAULT_FLAG_KILLABLE) {
>> -		if (__folio_lock_killable(folio)) {
>> -			/*
>> -			 * We didn't have the right flags to drop the
>> -			 * fault lock, but all fault_handlers only check
>> -			 * for fatal signals if we return VM_FAULT_RETRY,
>> -			 * so we need to drop the fault lock here and
>> -			 * return 0 if we don't have a fpin.
>> -			 */
>> -			if (*fpin == NULL)
>> -				release_fault_lock(vmf);
>> -			return 0;
>> -		}
>> -	} else
>> -		__folio_lock(folio);
>> +	if (vmf->flags & FAULT_FLAG_KILLABLE)
>> +		return !__folio_lock_killable(folio);
>> +	__folio_lock(folio);
>>  
>>  	return 1;
>>  }
>> @@ -3572,7 +3560,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>>   * vma->vm_mm->mmap_lock must be held on entry.
>>   *
>>   * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
>> - * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
>> + * may be dropped before doing I/O or when aborting an interrupted wait.
>>   *
>>   * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
>>   * has not been released.
>> @@ -3728,9 +3716,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>  
>>  out_retry:
>>  	/*
>> -	 * We dropped the mmap_lock, we need to return to the fault handler to
>> -	 * re-find the vma and come back and find our hopefully still populated
>> -	 * page.
>> +	 * With fpin set, the fault lock was already dropped. Otherwise it is
>> +	 * still held. Release invalidate_lock before dropping either protection.
>>  	 */
>>  	if (!IS_ERR(folio))
>>  		folio_put(folio);
>> @@ -3738,6 +3725,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>  		filemap_invalidate_unlock_shared(mapping);
>>  	if (fpin)
>>  		fput(fpin);
>> +	else if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
>> +		release_fault_lock(vmf);
>>  	return ret | VM_FAULT_RETRY;
>>  }
>>  EXPORT_SYMBOL(filemap_fault);
>>
>> -- 
>> 2.43.0
>>
>>
> 
> If I understood this correctly, the invariant is that if fpin is set, then
> the fault lock has been dropped.
> 
> At first, I was confused that maybe_unlock_mmap_for_io drops the fault
> lock, but in that case, it also gets a reference to the file, so fpin is
> set and the invariant is kept.

lock_folio_maybe_drop_mmap() and the other functions here are horrible, horrible
stuff, really :(

Thanks!

-- 
Cheers,

David
