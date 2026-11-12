Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474070;
	b=vLGNOkcC66L3Pnsb3+Tv5NGx/+VZlp/Xl9S62o4AyFXTirlXiyW/729ieGv4KQ9ZosHL
	 Ysb2AXMHe/bGuhr++kHeNjM5Pp6432yl2/la2nviHyf9ojLihZWd6oz0SkJ9bRanVh/sb
	 KMzinlouZOQRUBUlwKjZVK5qROBNcrpPX3915EMdavKYti8P9WfMya9QmAkyifUt55Fow
	 X9n8x9NeM93VyKsQvSb9YBuvzHzN80qn9ozrMmcRWBBfMhfSTB4FeMnijPc6FAsIfq48f
	 ADzoKyfxKd6m+h8d0SFG6nueuQZG/sMjhG5U1GpbLPMqHN67TOCRm7wJMYkK1KFjPoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474070;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qciPwLaBZFP6o7YxCmllxM7jttEflMmVhO8zxQVZp0I=;
	b=sn5hUDsXjO5U9TTHWB57GNqQ8GV51YjeWj9Cb2h6y4XWF/oR/YxoirRaA53LNlD+8QxA
	 Ej2aU/qL34VY8sFpy8itAyZC1129L59bVHjnGCuF6SdDsdzksmDJMzI5kUppHPbtQzUu5
	 A1ZYfqLM1iqRO9fjt3vcPMgBOi5PepjrOMHYjsXdFYUa1YLfxOGTbJ2JSgn3ay/JwO8Ld
	 fJDrsFg6BhOC0SgiPclP2XJBQfOPeE4pBpzr5yDbUlXBXexRzprFvhCLc7tq0f97bXazM
	 ETH+ECw6CWYLbxZMmufHqE4OAe2yq91QUuxBiIJiVzaXNkGrwZDS8ozL2qWMKXlr48A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqJ88WTF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DD606A33C;
	Thu, 12 Nov 2026 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqJ88WTF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DADD1F00A05;
	Thu, 12 Nov 2026 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474069;
	bh=qciPwLaBZFP6o7YxCmllxM7jttEflMmVhO8zxQVZp0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eqJ88WTFS/snVoxu58sVmq8uHDu4I1OkqM4vdWANTNKIIfmJ1w9MYYdR5HV8jJcZH
	 awsHKGx8ThOvURM6nxnrnHV1waU8nBFTufG1MQgkjzhaswCWgtLDy1DTkNFm1APez6
	 YdGKg5ohl5wbpwSAhPTVn16WRnYJcpu+zlmt/RCLWUyHmrbmtN+q1BIWJ9zmKRmPve
	 +BAGtRBaDKPyAa2bDbG4wPHi8H9u8uE+tyrm+xvYdnDwBD+QFa0hRPnBC8v6qQpdo+
	 JUAU3QMzAwXA4wz0gIWW4+cYjfb1iQR/S+6XQKUvmIg8xOJVgPy5r/mNZqrALRZppw
	 T4X7xZAwEYhVg==
Message-ID: <d74a277f-f14c-436d-868f-2566d90bc144@kernel.org>
Date: Thu, 12 Nov 2026 09:56:39 +0100
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
Subject: Re: [PATCH 1/3] mm: don't PTE-batch a swap-in over a
 hardware-poisoned subpage
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 byungchul@sk.com, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
 mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com,
 vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com,
 kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, baolin.wang@linux.alibaba.com,
 Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-2-usama.arif@linux.dev> <avRqaatdOUunxrcZ@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avRqaatdOUunxrcZ@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/26 14:18, Lorenzo Stoakes (ARM) wrote:
> On Wed, Nov 11, 2026 at 03:38:29AM -0800, Usama Arif wrote:
>> do_swap_page() checks PageHWPoison() on the faulting page, but the
>> large-folio batching path then maps the rest of the folio without looking
>> at the other subpages. A poisoned subpage that is not the one being
>> faulted gets mapped anyway, and the fault that would have reported it
>> never happens.
>>
>> Skip batching for such a folio and let each page take its own fault,
>> where the existing check catches it.
>>
>> Scan the subpages rather than testing the folio-level PG_has_hwpoisoned:
>> memory_failure() sets PageHWPoison() on the subpage first and only sets
>> the folio flag much later, and the bail-outs in between - for example
>> get_hwpoison_page() losing a page lifecycle race - return with the
>> subpage marked and the folio flag never set.
>>
>> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>> ---
>>  mm/internal.h | 15 +++++++++++++++
>>  mm/memory.c   |  4 ++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index cd3675c044e0a..e61c02f4019b0 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -28,6 +28,21 @@ struct folio_batch;
>>  int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
>>  		void *buf, int len, unsigned int gup_flags);
>>
>> +/*
>> + * Check every page of the folio for HWPoison, rather than relying on the
>> + * folio-level PG_has_hwpoisoned, which memory_failure() can leave clear.
>> + */
>> +static inline bool folio_has_any_hwpoisoned_page(const struct folio *folio)
>> +{
>> +	long nr = folio_nr_pages(folio);
>> +	long i;
>> +
>> +	for (i = 0; i < nr; i++)
>> +		if (PageHWPoison(folio_page(folio, i)))
>> +			return true;
>> +	return false;
>> +}
>> +
>>  /* mm/workingset.c */
>>  bool workingset_test_recent(void *shadow, bool file, bool *workingset,
>>  			    bool flush);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d477a4f986bc8..4b7d456332200 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5158,6 +5158,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>  		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
>>  			goto check_folio;
>>
>> +		/* Let a poisoned subpage take its own fault. */
>> +		if (folio_has_any_hwpoisoned_page(folio))
>> +			goto check_folio;
>> +
> 
> Hm, isn't scanning every single page in the folio potentially quite costly
> here?  I thought the point of batching was to improve performance overall?

Yeah, we don't really want another helper to check for hwpoison.

If we race with concurrent hwpoison, bad luck. The slapped on memory-failure
code is full of races. That needs a proper long-term solution, not more pain to
core-mm.

So let's please try reusing existing helpers that test the large-folio bit.

-- 
Cheers,

David
