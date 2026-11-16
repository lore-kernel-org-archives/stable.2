Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844787;
	b=UzSsfZtRTQL/a43R9h8gYalHP3SfrmrGnoTE5Okios8023gwC54qqCe4Pvan0Q61kXgO
	 vo0bGySDT4cnoaGTGE/cYi8praUoRAhKHK5gMMFwJUPqmQPckZqd0R69xZqDblCYfNTkM
	 u6vWjrUum1G0XhF+H8QdBPN9MX0czqCXfJ61jipf4RxUxJ0jPDHENVRxTFbFF3H10DEUQ
	 9pSCVrKRg8CYc/tNEtAvu+65zNc6dFhPjd/Fbe7L/lH552dFXcxePdHRiANERuxta8ivZ
	 FzyMJrdNU637GM9PdIuiCeskMoCZFdUwXALJVdPz59p7LaTs2V5bFUUPN2x9wssM8lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844787;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=rPuQ6bDq+bHaxXx2EXaHE7mmeJ4G+Lo+ePLONXnHoeM=;
	b=DI4embfO1CL/i9htOQqjWWUBxpDwxVHb2coYJzgqVZT7LA3+NysJi42RRYUYqoP4Y9BJ
	 p2A+dHXciyfOZaoeGe8iD6In9dMsrk2MM/eBWNJHDVGeU4/KdvQUMMALtA1PiSqw8Vx4N
	 aaEQGUoQuQCQwBULWtgse2z+pCeWKAB9KRKfwd8G68BVLbnLegRgXXnBKfYNQLpECfx9o
	 jkuc32CyNeOD9qtGrlztyKGj/WAdJJ9HGXewfuFYviCiedGPW7VpTyWoNSZFV+kteuo7K
	 4aBIWGD+h3T4JdZ9eohq82UZRSWZBQGOLPezsk7UPHI1lgqLyTZxvMmHYVTd/jwvOcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0nblKbg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6186606A33E;
	Mon, 16 Nov 2026 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0nblKbg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608301F000C4;
	Mon, 16 Nov 2026 15:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844787;
	bh=rPuQ6bDq+bHaxXx2EXaHE7mmeJ4G+Lo+ePLONXnHoeM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=e0nblKbgzV4P3b0kR2fFA48E9hAuNB+9Zuck8t4/ha0330rK3qUfkjdA6CMzWccZB
	 ktTzsjjkJSWl1EEbPQP0o4CAhTA1brXjKsIvv3YsWbAmzODXhbxq6QYUPf06Qy7Xvz
	 7z22a7ufvcmvd1kI+eSVIKFQ4NUmHjZTjnuTNL9gE6kDgjkLaaDA0947VMw3bO++Ca
	 CbCRIrBSwPaB/vEaTkty09rva5eHpXZF8qyr5XELVWDeMED6ibyfJi5sSsl6ouF1/q
	 TFMTnucDLSDDuIeqfZnRMamCWZbUkE9orgTOz/ip0aitjXpUybJjfppwTxI98tqM9O
	 /t0JQ8uIExHcQ==
Message-ID: <998b00e3-bde9-450c-b50b-069e65d00c49@kernel.org>
Date: Mon, 16 Nov 2026 16:59:35 +0100
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
Subject: Re: [PATCH 2/3] mm/memory: do not report OOM if insert_pfn() races a
 huge fault
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org,
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/26 21:58, Lorenzo Stoakes (ARM) wrote:
> From: Eliav Farber <farbere@amazon.com>
> 
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> This is not currently safely handled by insert_pfn(), however, which
> obtains its PTE entry via get_locked_pte(), and treats a NULL return value
> as an allocation failure, returning VM_FAULT_OOM.
> 
> The issue is that get_locked_pte() also returns NULL if the PMD entry is
> not a page table which can happen if a concurrent huge fault installs a
> huge PMD entry between __handle_mm_fault() observing the PMD entry to be
> empty and insert_pfn() being invoked.
> 
> This can result in VM_FAULT_OOM being reported incorrectly.
> 
> Address this by proactively checking whether a page table allocation
> actually failed, and returning VM_FAULT_NOPAGE if the NULL indicates that
> we were raced instead.
> 
> The same assumption is made in insert_page(), however only DAX implements
> ->huge_fault and can reach it, and it serialises faults of different orders
> with its own mapping entry lock, so it does not require a change.
> 
> Target the commit introducing the first driver able to do this.
> 
> Link: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> [ ljs: rewrote commit message, trimmed comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/memory.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e03110906aa8..cff39eccfd42 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2866,10 +2866,17 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  	struct mm_struct *mm = vma->vm_mm;
>  	pte_t *pte, entry;
>  	spinlock_t *ptl;
> +	pmd_t *pmd;
>  
> -	pte = get_locked_pte(mm, addr, &ptl);
> -	if (!pte)
> +	pmd = walk_to_pmd(mm, addr);
> +	if (!pmd)
>  		return VM_FAULT_OOM;
> +	if (pte_alloc(mm, pmd))
> +		return VM_FAULT_OOM;
> +	/* We may have raced a huge fault, if so let the fault be retried. */
> +	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> +	if (!pte)
> +		return VM_FAULT_NOPAGE;

Same question, what if we would stumble over a PUD entry, how would we handle
that today? I'd assume we'd also want to return VM_FAULT_NOPAGE instead of
VM_FAULT_OOM.


-- 
Cheers,

David
