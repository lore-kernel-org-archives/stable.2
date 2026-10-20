Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501389;
	b=osCls2W24A01d4yKdcF/Vfk2ekicUGB7hC6dfGN/ajDTiw083pxp2wDejzKAkn5UdUXF
	 LqrwD/UNNNjAsDLHl711cgbB6mjrVe63C9mAgLtaEIRVw7lU/9VYWEZVauQOA5q123oSv
	 hYNdCQAtTKGwHD3kxYRe3lEc/dIGOvcZi5+4FnNfxF7E4PQrX6XiPLaEYsQDmrr0MbGXp
	 P6Zc6AHw87WOMfxjK0pMlzLhGWCRt/D2gI/N2zhA/8YjOIvfl//ff6CC9n8HXLI4OBnaS
	 sMIR7tYA4T4INIzaw938jjTdMrz6TMhNsxe5TXBngASwRrXNi2npqls7i2NHXnM+7Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501389;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=tEmyuwwBP5h6VHskzhMh1ibGlyjaFPqUcfMhfCdbwJ0=;
	b=rF0lgGj5jS0fs/EEGOpF8DUsQIuI5moZNu5coGUAy/q6KmVElG3poayX1ARSkFT8OuNK
	 69+a+ZKbyvCQ3OHBG5d7qOBReG2G0zImJp9uKlrGsDInVG/ey11KDjMTFqAXpVA2RCPDD
	 cJ65PcQVEpdDgZoF5yRHcj9FDxIiNXRUstIRjXaOCmB+7vEYUe7dgcOhyOijHjOd0o14m
	 lQJUDEg5zOsxkmqPXiWSzzME93fRddByKIB3Pi4JDbmVzQxnRRobw86LZIGlZc5amwqpy
	 ZDJ0eVe5J4y81wuh75PzVaZXY4N3RLyXoR3zJ7Ci25tDr5gIc/5JnfKDFglF6tjP3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLSV491R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6660A260C;
	Tue, 20 Oct 2026 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLSV491R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF01F000C7;
	Tue, 20 Oct 2026 13:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501388;
	bh=tEmyuwwBP5h6VHskzhMh1ibGlyjaFPqUcfMhfCdbwJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WLSV491Ru7w72mk0zSnIqlf/OJS3QDaMV9+FAzqrGloAMREpXMmBZg31sC+qx91IS
	 inh+8XsWEQRyRlumwqWMjF7Al/KO10oKmI3oh0BlRB4Z61CAq+DbLgKbXGxHUgwnmD
	 tzVK2c3Ysyh9E5aFSg2y5Fh2Tk+5nwLCP+JjuD5Hpg5RazTurCrdJClH1h/YRk8VHO
	 4m2PEgdB0FmFAs/HBxEH+gqmeqIntnu8zA9tNCDPeNgx35u7bKQKWZ9MloSQCw8Je1
	 xangINjWXa2UmPgEUG2ZVpbiBooIwMGQgyC1ddjEqAu2wG/+FDbi5FxhgY/TNG3rsh
	 tAGp+YGHDnyow==
Message-ID: <3da45e6d-2b46-4fff-9ff3-241f70d68296@kernel.org>
Date: Tue, 20 Oct 2026 15:03:04 +0200
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
Subject: Re: [PATCH v2] mm/ksm: keep soft-dirty and uffd-wp when merging a
 page
To: Lance Yang <lance.yang@linux.dev>
Cc: samarth.colleges@gmail.com, akpm@linux-foundation.org, xu.xin@linux.dev,
 chengming.zhou@linux.dev, peterx@redhat.com, kas@kernel.org,
 rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <efa6a28c-f0f9-4d1e-9cce-fec2c08e7d9f@kernel.org>
 <20261020055518.36087-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261020055518.36087-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/26 07:55, Lance Yang wrote:
> 
> On Mon, Oct 19, 2026 at 03:24:11PM +0200, David Hildenbrand (Arm) wrote:
>> On 10/19/26 03:09, Samarth Narang wrote:
>>> replace_page() maps the KSM page with a PTE built from scratch, so the
>>> soft-dirty and uffd bits of the PTE it replaces are lost. Due to this, a
>>> write before the merge no longer shows as soft-dirty, the next write to
>>> a uffd-wp page raises no write-protect fault, and because the page is
>>> mapped with the VMA's normal permissions, on a uffd-rwp VMA the next
>>> access raises no RWP fault.
>>>
>>> Copy the soft-dirty and uffd bits from the original PTE to the new PTE,
>>> and restore PAGE_NONE for RWP VMAs, as try_to_map_unused_to_zeropage()
>>> does.
>>>
>>> Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
>>> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
>>> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
>>
>> I would actually split that up into separate patches.
>>
>> Over-indicating soft-dirty (as raised by Sashiko) is in general not a problem.
> 
> Right.
> 
>> Losing WP bits is.
>>
>> UFFD, the gift that keeps on giving.
> 
> Haha, yeah, I stared at the code a bit. Say we arm RWP on an existing KSM
> mapping, then do MADV_UNMERGEABLE. We're just replacing the shared page
> with a private copy. That shouldn't count as an access to the mapping ...
> no?
> 
> But the protnone check sends us to do_uffd_rwp() before the
> FAULT_FLAG_UNSHARE handling. No FAULT_FLAG_ALLOW_RETRY here, so sync RWP
> gives us VM_FAULT_SIGBUS. Then break_ksm() does this:
> 
> static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
> 		unsigned long end, bool lock_vma)
> {
> 	vm_fault_t ret = 0;
> ...
> 	do {
> ...
> 		ret = handle_mm_fault(vma, addr,
> 				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
> 				      NULL);
> 	} while (!(ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
> ...
> 	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
> }
> 
> So we report success with the page still merged. Async RWP does unshare
> it, but only after clearing the uffd bit.
> 
> I'd let FAULT_FLAG_UNSHARE skip do_uffd_rwp(). We'd still need to carry
> PAGE_NONE over in wp_page_copy(), though. That PTE is rebuilt from
> vma->vm_page_prot, so the uffd bit alone won't stop reads.
> 
>> How to deal RWP properly is a good question (see Sashiko review). I feel like
>> some more stuff might be missing there to handle this correctly.
> 
> Tested, this is what I had in mind:
> 
> ---8<---
> diff --git a/mm/memory.c b/mm/memory.c
> index 976cd03954e3..d99f5ef1dd8c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4119,8 +4119,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		if (unlikely(unshare)) {
>  			if (pte_soft_dirty(vmf->orig_pte))
>  				entry = pte_mksoft_dirty(entry);
> -			if (pte_uffd(vmf->orig_pte))
> +			if (pte_uffd(vmf->orig_pte)) {
>  				entry = pte_mkuffd(entry);
> +				if (userfaultfd_rwp(vma))
> +					entry = pte_modify(entry, PAGE_NONE);
> +			}
>  		} else {
>  			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  		}
> @@ -6656,9 +6659,12 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  		 * VM_UFFD_RWP VMA, a protnone PTE without the uffd bit is
>  		 * NUMA hinting and must still fall through to do_numa_page().
>  		 */
> -		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
> -			return do_uffd_rwp(vmf);
> -		return do_numa_page(vmf);
> +		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte)) {
> +			if (!(vmf->flags & FAULT_FLAG_UNSHARE))
> +				return do_uffd_rwp(vmf);
> +		} else {
> +			return do_numa_page(vmf);
> +		}
>  	}

Looks like a reasonable direction (without looking into all the details).

I've been also wondering whether KSM should simply skip these uffd regions, they
it never worked properly ... but I'm sure we'd run into issue with leftover uffd
pte bits :(

-- 
Cheers,

David
