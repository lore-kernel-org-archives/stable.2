Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910573;
	b=tu7FiMcqVh0ANt4RoOhDxdcpSBymsDRrRkj5Mk5An5tZyBPnceDVrTEDqFK+bQ/R9tYE
	 1BN1SuvYJuigRZ7RKM5pEZgXuEZ+Rq6VaKwccsISC8CzBusP3FfhiTKpzHyYqzMRIaDyj
	 rQZ1GroL5Ic/UZZ4BwEd662hW+jRzWA19xcR7h/DsW7oa8MLjYDY5ZwQTZmUVTtFV0ApB
	 w9IU6DUl05Qcw7wZrA0pqkNX7Lqxw8QiCSRREsfTkIhE9tXJTGgd69BfciaXSbtGaBrrg
	 /Hp4cfD2BsSqTTRX0mQHNFRejX4ePhzl3GKEn0K/I9i+NTX3mEGZv7qzlYSIJC+ETxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910573;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=l3F7MsaTa0dMzD3OO4ezzHyvu2AXC5WZNHSTj7ej3LU=;
	b=P2OZDX5ttdh8H9VMRuWjyqabxcCci0VScEkp6Zs6B8KYB6jEOiEHWyJo4qACrI0MTMYO
	 EPxEJivnYtr/T2N4ZrgfTpFB9xVfsdxJdcoB67xzt9B6htvrt664w7xX1/+ddOL8djC18
	 N17nXETo7C3rdUezg/seZwRlG7gQBSnHXgVPxpaV0CYG0V+FYS/VumIJDjGSfVMluHDAu
	 ouvFSL2pjgERk/2koDyFcDvU5QiXu9cIn8U9qgmPLRMVEc12fvoggo4Jzk4hKscI8CCfk
	 d7zPlkiIZjPgRKZybicC8h8trs+5chVeA4KNseSzT8NIAF57gM8q8bw/aLnnbwzjYHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2SAuhWs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4C606A323;
	Tue, 17 Nov 2026 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2SAuhWs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D7E1F000C4;
	Tue, 17 Nov 2026 10:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910572;
	bh=l3F7MsaTa0dMzD3OO4ezzHyvu2AXC5WZNHSTj7ej3LU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V2SAuhWs8jAcWpSSEzf+Io5Tcac0gW/AhhhNyfA6nts77Ei3uaIMdN4gRYHnZMPan
	 ftAY8MITi4XIgLRDI+dRH4G2SzzBi75VqPfmylclgxlvpa2ejhLONEH0zRYOi0yqVp
	 Gv4WheQs+UDBnYPyBaDYTF+xqD9O5Ton+drdPueX48pF2nt8BNhSOQ34VTUAa/4FcR
	 36qcNgKZZvIO6BRiC4i8jLr/AYGdpKFlmrJCf2XRGoBRwF7Pw3RvQNGdvsw+kPwXuG
	 swjG0CMWFRVlePqeMq6yGFM5Utu1nfnHaTIF3YOhCX23kWkEtJ+MbUXKFbl4vw5kri
	 s2mpECBMWW/aQ==
Message-ID: <1ad7a1b3-3bea-4cc6-bad9-c400046a6a88@kernel.org>
Date: Tue, 17 Nov 2026 11:16:06 +0100
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
Subject: Re: [PATCH v2] mm/memory: mark unshare copies dirty to fix MADV_FREE
 data loss
To: Daniel Wade <danjwade95@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20261117100622.807-1-danjwade95@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261117100622.807-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 11:06, Daniel Wade wrote:

Please don't send out stuff that fast, especially when the discussion is not
over yet.

> wp_page_copy() only calls pte_mkdirty() for write faults, so the copy it
> makes for FAULT_FLAG_UNSHARE comes out clean. Nothing marks the folio
> dirty either and there is no swap entry.
> 
> Unshare faults come from R/O GUP pins, like process_vm_readv() on a page
> shared with a child. If the process forks after the pin is gone,
> MADV_FREE in one of them marks the folio lazyfree and reclaim frees it.
> The other process then reads zeroes.
> 
> Mark the copy's PTE dirty. pte_mkdirty() also sets soft-dirty on x86, so
> take soft-dirty from the old PTE in both directions.
> 
> Side effect: smaps and numa_maps count an unshare copy as Private_Dirty
> or Shared_Dirty rather than _Clean.

numa_maps still doesn't expose Private_Dirty or Shared_Dirty. So this should
probably be be

Side effect: smaps counts an unshare copy as Private_Dirty
or Shared_Dirty, and numa_maps indicates it as dirty.

> 
> Fixes: c89357e27f20 ("mm: support GUP-triggered unsharing of anonymous pages")
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> ---
> v2: set the PTE dirty instead of the folio, as David suggested. No atomic,
> and the dirty bit then also survives in the other mappings.
> v1: https://lore.kernel.org/all/20261116111245.28871-1-danjwade95@gmail.com/
> 
> Tested on mainline b3dfbde62cf1, x86-64 with KASAN and PROVE_LOCKING, as
> uid 65534. The test gives an unshare copy to a child, has the parent
> MADV_FREE it and a control page it alone maps, then waits for reclaim.
> Without the patch all 4096 bytes come back wrong in the child; with it the
> child's page is intact and the control page is still discarded. Same on
> v6.12.117.
> 
>  mm/memory.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index ec3d9d99ccee..113b305854d5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4130,8 +4130,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		entry = folio_mk_pte(new_folio, vma->vm_page_prot);
>  		entry = pte_sw_mkyoung(entry);
>  		if (unlikely(unshare)) {
> +			entry = pte_mkdirty(entry);
>  			if (pte_soft_dirty(vmf->orig_pte))
>  				entry = pte_mksoft_dirty(entry);
> +			else
> +				entry = pte_clear_soft_dirty(entry);
>  			if (pte_uffd(vmf->orig_pte)) {
>  				entry = pte_mkuffd(entry);
>  				if (userfaultfd_rwp(vma))

Apart from that LGTM

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>


I'll wait for more review before picking this up.

-- 
Cheers,

David
