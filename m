Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439296;
	b=Mla7o9BCO4Q/w32RAsDL7MtWie7S6EaJjz/lhGN2cdF1FVCJgtXuAdtiNtxV7fE8kvq3
	 H0YOrweYiambqiEc195E+KJ9Q+BLnnATzErugWmd3RISY16t+KLweFjD069u+WCG9nEsX
	 ce3kntiOjX/nr2LkEIXydGcGxA0WB9JUdu6a3EkgQEC16otSgkiDmgvXDEGTax0SjxS0x
	 z3h8zmbFbXY3HBuDVXGMNMuCinvSpKr0AknxwZueBw54MCpobFSKibLJKA9hFN+vIIf62
	 64F1NCy/r1vzmOvkxzHsUk0SWtBpQ6pK0Jt85ZZsOC8/svF+8cLKRvZ1Ip1hDNiaBqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439296;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=P9o1mQzkbmTdaiTKQdIgL8fzuR8hlpHa+FcuDOUlG7g=;
	b=MFEU3drxUGiZ4Nld4T0Y6Ke6xunNJuhCP5Nlx/rNg7Bq/f2dH/3g2dLqqbWesXwV+s9Z
	 ZPrAFewcvNbRcwmhqjqyDJvco1eyEnf0mDqw6FxQvrmDa1e/ZOQOB+3zL4W0xr8CmMENG
	 oMTttUfm+jgtLV9uVHY6+LS+1Fvk6lz0/5KINJj8R2jrmT+riaIHSiYZTkIUGZfUzjutS
	 zAjGNjSsMMcN7kvPNq3GJFOkQGRNhYCKnGTBfWY4qh3NWC4hcz8ibBy1xahAKm3mfrRrt
	 kdKMsJaSAR/4J9A33om2BN230AAh9UeKhjqD0Kq7Aodpm+olS/46E2sLt8PbccT+SdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMeX0QQv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA2606A324;
	Sat, 31 Oct 2026 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMeX0QQv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAA11F000C1;
	Sat, 31 Oct 2026 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439295;
	bh=P9o1mQzkbmTdaiTKQdIgL8fzuR8hlpHa+FcuDOUlG7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PMeX0QQvPBgkOrecOplu7IqNxYMnMEyiD5AjPxAjtugRusW9fJiuNj9IXZNPcnSH/
	 WMqSf4rUuty4Ax+BW2IdK8zetJkUQAMx3/TqvyUINiyjs6NfC0rfqsO3X79DBBi4Sc
	 WhfQaM1PTWd6z3XfFqVDPxoYFuZCr8x+mzLIQ503fxBBUSUX6dp+bH4tgB3FpN4yeA
	 JimfPT0DLgkb4O0DeQsG/FdpYWITpOIdsyvhtAmXLxivSzB4EiIbnVSluZg62j/4Ro
	 txxIMOW7G42uEhpVi6RVyYto7K6f2/WDA2zTfShc/YtXJ3HZghe/m3wXmmC0cGiTT8
	 MG8uqaygp9/SQ==
Message-ID: <04155e81-a88f-4bba-a77f-0aad1ffdcde0@kernel.org>
Date: Sat, 31 Oct 2026 10:34:47 +0100
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
Subject: Re: [PATCH] mm/swapfile: drop a large unmapped swap-in folio in
 unuse_pte()
To: Andrew Morton <akpm@linux-foundation.org>,
 Mani Tofigh <mt4022@columbia.edu>
Cc: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org
References: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
 <20261030155419.b10056c8fb37bc784b0d2778@linux-foundation.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261030155419.b10056c8fb37bc784b0d2778@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 23:54, Andrew Morton wrote:
> On Fri, 30 Oct 2026 15:11:56 -0400 Mani Tofigh <mt4022@columbia.edu> wrote:
> 
>> Since commit f1879e8a0c60 ("mm, swap: never bypass the swap cache even
>> for SWP_SYNCHRONOUS_IO"), a fault can read a swapped-out mTHP range into
>> one large folio in the swap cache.  The folio only becomes anon once
>> do_swap_page() maps all of it, so if the faulting PTE changes in the
>> meantime the folio stays in the swap cache while not being mapped or
>> anon:
>>
>>   Task A (fault)                       Task B
>>   do_swap_page()
>>     /* swaps in large folio F */
>>                                        madvise(MADV_DONTNEED)
>>                                          /* zaps the faulting PTE */
>>     /* PTE changed (F not mapped) */
>>
>> swapoff then maps it, which marks all of its pages as mapped and
>> exclusive, and the next fault on one of the other PTEs crashes in
>> do_swap_page():
>>
>>   [    6.424485] kernel BUG at mm/memory.c:5195!
>>
>> ...
>>
>> do_swap_page() already drops such a folio from the swap cache when it
>> can't map all of it.  Do the same in unuse_pte() so that swapoff swaps
>> the entries in again.  With the fix, nothing is reported.
>>
>> This bug was identified and confirmed with the help of a deterministic
>> hypervisor currently under development.  The C reproducer below however
>> hits it within a second.
>>
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -2518,6 +2518,18 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>  	if (!folio_matches_swap_entry(folio, entry))
>>  		return 0;
>>  
>> +	/*
>> +	 * A large folio that is not anon yet was swapped in by a page fault
>> +	 * that did not map it (yet). It can only be mapped as a whole, by
>> +	 * do_swap_page(). Drop it from the swap cache and swap in small
>> +	 * folios instead.
>> +	 */
>> +	if (unlikely(folio_test_large(folio) && !folio_test_anon(folio))) {
>> +		if (!WARN_ON_ONCE(folio_test_dirty(folio)))
>> +			swap_cache_del_folio(folio);
>> +		return 0;
>> +	}
> 
> Let's not WARN here.  If it hits and someone reports it, what do we
> tell them?  "uh, that's working as designed, no action needed".

I thought harder about this, and it just shouldn't happen.

Something that was swapped in and never mapped (!anon) that would be dirty would
reveal a bug elsewhere.

I think we can just turn that into a VM_WARN_ON_ONCE() and still drop the folio.

(there is a reason we never saw this so far in do_swap_page())

-- 
Cheers,

David
