Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004972;
	b=JXG1PBX5RP0RCe5wt7Br4pwh4Gpy39HiJ7uI/WdwePoHLRshk1qCu7erRiiT4W0tfvFM
	 1NqHuc9JrkOB0C78+xN74Z0shHZ/agYDgUMbLy0cf+J19QdQF/BRPDbd/8Qa4uy4sSRuO
	 MAogBlNcfdQytUOgainsj6PvJTSB0UVNlUmvtaCr2Xq+66keRYxqWTstjTUhUoOiUt294
	 N2hAPhWI2tnpX0BN3w7+WHRI6uwMZn8KD58AM/9myu3yrg/u5e4cZ1fM+oj9IV8AXF1rl
	 oj/D2X80WkLvrt46IJ0VIKiXmNg5pDPtdpOkp2D+GdFI5DYE1OdeqVfJ00KGK84TIcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004972;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=xrGWYrqGixJhZjc6cA3u15ineEoMPVTqbCNBS3vO/E8=;
	b=1mIslP96p1kLHlqhA3763SVe9k1E0Nxjp4PLV1S4ICSUa/TT9KM4+L9cIF/YXhHoyuSA
	 oIDkh0mkqEJPT64SMM+2VZMLbnCCOKzseejPjc7mV2VFkouCPVQe7N8q6YRj5h0CnOsnK
	 45AYZxbf+vaYqhuIiZ0k0TL6BbeS0nEzYwwpeqHlUKa0BAXbexxACHU0QwFP5NT4t7EpB
	 NR5bJR0SEb1t/6jBmGhKxAVct4T+dPAG8Exp4+1Oi/7vP78fN5Oo74CHCY7VRavgpOlE4
	 09RKMHp3w4ZbA5MHzVX2V0a60xi15Nf2MA92g5Xi9ayYLw8tzzWC3HnjbF1321mn5Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L63UwzrP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA998606A326;
	Fri,  6 Nov 2026 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L63UwzrP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019D31F0089F;
	Fri,  6 Nov 2026 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794004971;
	bh=xrGWYrqGixJhZjc6cA3u15ineEoMPVTqbCNBS3vO/E8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L63UwzrPS2ataztpBxby6ngbB/ads9+t+yjRipL316Dhw0VSCOCocujlpDrXQuR92
	 8cHpI5LF473Ryale/9WffhFi44DKGSYK/ZKvCx/DE/l3c1ItJmN6w0NuBhoDgnTVim
	 R0DJ5yQCaHR1w6HEmo9gpud9qnI/d42WwKGteXUoEtngqrw8LxtvSBXHqCXAOCRQK8
	 DCWqGNxp8pGnD9fk5PGtMcnSu4BYj3TXiWyH31as3EUW4+fGpL7NWJmAsPyq4O1QVu
	 UWgmOZlW8cQq63VBB2npIDRUKf9QYGivudLkoE0YWyW/Nw19B2w3UDUxxAcWiNZ6/d
	 Zm3KgmdtNVSrQ==
Message-ID: <9c86902c-b942-4641-aee0-672adcc84823@kernel.org>
Date: Fri, 6 Nov 2026 23:42:17 +0100
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
Subject: Re: [PATCH 5/5] mm/gup: limit pagecache folio refcount when grabbing
 references
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
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
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
 <4763a039-60f8-4263-8124-beb0f9ab3366@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <4763a039-60f8-4263-8124-beb0f9ab3366@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 11:13, Jose A. Perez de Azpillaga wrote:
> On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
>> Let's replace our existing safety check by the new
>> folio_ref_count_over_limit() check in fast and slow GUP before acquiring
>> additional references or pins.
>>
>> Keep it simple and use the check for all folio types.
>>
>> Drop the WARN_ON_ONCE(), because apparently these things can currently
>> happen with large pagecache folios.
>>
>> Keep the zero-refcount rejection if the refcount is 0.
>>
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/gup.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 2ab42fc6834e5..db9db6b2a4662 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -77,7 +77,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
>>  
>>  retry:
>>  	folio = page_folio(page);
>> -	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
>> +	if (unlikely(folio_ref_count_over_limit(folio)))
>>  		return NULL;
>>  	if (unlikely(!folio_ref_try_add(folio, refs)))
>>  		return NULL;
>> @@ -140,7 +140,11 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>>  int __must_check try_grab_folio(struct folio *folio, int refs,
>>  				unsigned int flags)
>>  {
>> -	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
>> +	if ((flags & (FOLL_GET | FOLL_PIN)) &&
>> +	    unlikely(folio_ref_count_over_limit(folio)))
>> +		return -ENOMEM;
>> +
>> +	if (WARN_ON_ONCE(!folio_ref_count(folio)))
>>  		return -ENOMEM;
>>  
>>  	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && folio_is_pci_p2pdma(folio)))
>> @@ -1482,8 +1486,8 @@ static long __get_user_pages(struct mm_struct *mm,
>>  				struct folio *folio = page_folio(page);
>>  
>>  				/*
>> -				 * Since we already hold refcount on the
>> -				 * large folio, this should never fail.
>> +				 * Grabbing more references can fail once we
>> +				 * hit folio refcount limits.
>>  				 */
>>  				if (try_grab_folio(folio, page_increm - 1,
>>  						   gup_flags)) {
> 
> this can fail now, so shouldn't the error path below return -ENOMEM like
> the first page does, instead of -EFAULT?

Hm, indeed, that's inconsistent. The issue is that we have this -EREMOTEIO check
mangled in there. But the ordinary path would already have checked that and
failed with he same error.

So this hunk would become:

                                /*
-                                * Since we already hold refcount on the
-                                * large folio, this should never fail.
+                                * Grabbing more references can fail once we
+                                * hit folio refcount limits.
                                 */
-                               if (try_grab_folio(folio, page_increm - 1,
-                                                  gup_flags)) {
+                               ret = try_grab_folio(folio, page_increm - 1,
+                                                    gup_flags);
+                               if (ret) {
                                        /*
-                                        * Release the 1st page ref if the
-                                        * folio is problematic, fail hard.
+                                        * Release the folio reference we
+                                        * already took.
                                         */
                                        gup_put_folio(folio, 1, gup_flags);
-                                       ret = -EFAULT;
                                        goto out;
                                }
                        }

-- 
Cheers,

David
