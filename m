Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973293;
	b=EM6K1lJKCFzuvs9nvS5zrbZ1Y7ljA2sHUqDGHLTMPPOX0zt2Y3Ua3WdrVxfAwy7qBj4I
	 co4FhLu/7pPVbOtc3EAhCF33f/1X79E7U0/UnjZoqCsYPGzzvO39gZKO0TFMWj/BltAnf
	 ZjKdg3OEsVUjCTYse4TmfRABy9YmHsW8V8HP63R5926CymV/SICVEPK7L1nrLlpxB/ptJ
	 LmjvxFqpqmu30RTKum2dKzIXdXuxj99maYO/rS+EG1Wjl6qmJsAWCUSujdAJwGCqgwWXS
	 sUtdtetW/SUQrQae4CUaOYgaXgugfS8hH1FqPBWRbyYYWMhZeAvYAW/B2eEkaCiq1uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973293;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=34mQdD+b5YZ6XAjM1LZE1WQBn5OVOW6NRSCCNvZHD7s=;
	b=HyNxoEfcwi6EfJccAUVlGOgL+Y7+Bfg4Bbfxxhbo4s6iJWcXdk96wasxpjF1z9xO5AhZ
	 NyNo0tSugdohVFXFISFOq5xwrU4ueceiw8mG8/WqwHttZkMwCCWGRscKYjPzndvcRytZw
	 tiqAvIKOS8VzzoFy76WNj0ruNLdmuTET7068luVpvfG46RmrBPS4RKxYjmo2vgoUxl9Ip
	 ktg5BjixvVbPMpwaiOIEPcaMcgKORvQMBowTMgT4BcZahistcpoDR4MSJbbr4t0wC6nVz
	 ABnRWk6QT7VD9OsMJhH1/23/fmd6NVTb08tViYmW9mY3O61+yDsTvMVIvUR9HqCCOkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjuKuYCY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED13606D802;
	Fri,  6 Nov 2026 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjuKuYCY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA351F0089F;
	Fri,  6 Nov 2026 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973292;
	bh=34mQdD+b5YZ6XAjM1LZE1WQBn5OVOW6NRSCCNvZHD7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JjuKuYCYc+1Mx7nL0LE9YfXxydZve4TxL2sCZmkw3PvNaVeRMcK0S3+qk3K1QdcM6
	 EITNbtqJU8dVj1nHvyFj0eRNmSyiN9Fb+vo5OlbeKKORB01Zb4oe5VEsyxkbWNnMP5
	 6GuiLetqoMgPqmHZvKo6ASeFi5vxUvgzeYQbZ2d9G9c5fATAn0DUmOQPECHqAMqTcj
	 ozwW7x6FtyzpJUsjalnHsI9fatbD7T0XNoH9hernaArn2uyW3OTgswysrIkgl6iLPp
	 +sZkpb1boQixmQaET3jzS+h6KHF+1KZZ05qXOcXGeT30EWihR/4lGwRN4vkl2CXR3U
	 a6bjcBhxSeiGw==
Message-ID: <cc803a06-f6a1-440b-9752-917f3698da6c@kernel.org>
Date: Fri, 6 Nov 2026 14:54:45 +0100
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
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate in
 MADV_COLLAPSE
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
 <au3C8lNElGg4LnR1@thinkstation>
 <254c6f0a-9353-4806-a5ab-a071cd59c64f@kernel.org>
 <au3YD92l6BwCQIPJ@thinkstation>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <au3YD92l6BwCQIPJ@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 14:41, Kiryl Shutsemau wrote:
> On Fri, Nov 06, 2026 at 01:29:31PM +0100, David Hildenbrand (Arm) wrote:
>>> Separately from this fix: nothing on the mapping side catches this.
>>> Every caller checks uptodate on its own (next_uptodate_folio(),
>>> filemap_fault(), shmem_get_folio()), and khugepaged was the one that
>>> went straight from filemap_lock_folio() to do_set_pmd().
>>>
>>> Should do_set_pmd() and set_pte_range() assert it? Something like
>>>
>>>         VM_WARN_ON_ONCE_FOLIO(folio->mapping && !folio_test_anon(folio) &&
>>>                               !folio_test_uptodate(folio), folio);
>>
>> I think so. But looking at these hard-to-trigger but in the end very nasty
>> problems, should we actually reject the operation and do a pr_warn_once() or
>> something?
> 
> Yes, rejecting sounds better.
> 
> Not in set_pte_range() as I suggested, though. Fault-around only gets
> there with folios that next_uptodate_folio() checked under the folio
> lock, and for CoW it maps the new anon folio after do_cow_fault() has
> already copied from the page cache one.
> 
> Checking the folio ->fault() returned in finish_fault() covers PTE, PMD
> and CoW; do_set_pmd() covers khugepaged. Both return VM_FAULT_SIGBUS.
> 
> Something like this, only compile-tested:
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 6fe0b7dab927..ff2f2deff761 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5674,6 +5674,22 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>         return ret;
>  }
> 
> +/*
> + * A page cache folio that is not uptodate holds data that was never read in
> + * or cleared, and mapping it leaks stale memory to userspace. The callers are
> + * expected to check, so treat a hit as a kernel bug and refuse the mapping.
> + */
> +static bool file_folio_not_uptodate(struct folio *folio)
> +{
> +       if (likely(folio_test_uptodate(folio)))
> +               return false;
> +       /* Driver pages from ->fault() never get PG_uptodate */
> +       if (folio_test_anon(folio) || !folio->mapping)
> +               return false;
> +       WARN_ONCE(1, "refusing to map a page cache folio that is not uptodate\n");
> +       return true;
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static void deposit_prealloc_pte(struct vm_fault *vmf)
>  {
> @@ -5714,6 +5730,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
>                 return ret;
>         page = &folio->page;
> 
> +       if (file_folio_not_uptodate(folio))
> +               return VM_FAULT_SIGBUS;
> +
>         /*
>          * Just backoff if any subpage of a THP is corrupted otherwise
>          * the corrupted page may mapped by PMD silently to escape the
> @@ -5849,6 +5868,16 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>         unsigned long addr;
>         bool needs_fallback = false;
> 
> +       /*
> +        * Check the folio ->fault() returned. For CoW that is the source of the
> +        * copy; DAX CoW has none.
> +        */
> +       if (vmf->page) {
> +               folio = page_folio(vmf->page);
> +               if (file_folio_not_uptodate(folio))
> +                       return VM_FAULT_SIGBUS;
> +       }
> +
>  fallback:
>         addr = vmf->address;

Can you send that as a proper patch? I think this is the right thing to do to
catch more of these things if they ever pop up in a better way.

-- 
Cheers,

David
