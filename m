Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984163;
	b=mjIg1EG1fGrR+r2wJ4KANnn9Nn5mNsAjSuYNDze8eSvHrICnasMRXJfBmrFWGtdxr78h
	 R8w6bif/EL3RDD2WIYoBijbp2tryjxECPURl0sfNuJEVH/t/cGy9CJsY6qtckkm5QqUzi
	 k99tyeUActSYbr3EUc1lgb5wACIRVjJNnY/F77rSQ2KHII40Je05wE9uKRIH6feMPTqqt
	 qTWw2yUra2xK6bzuJjAzd/PR84ALTeOnCmpndUBBUosor/p67uPiTkH2hKoflRHr2cCnQ
	 UcwHsecturGZaQeyowRqpgytfjT5p2D80iAJta7CBxwBVIMtaUcqVcWh2ePTpu7pYeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984163;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=NhLiqpRhYR+jbB7aXfZbX1GKQMokOJpkHTiOlAJk1JI=;
	b=d1wb1yg6gIIsAVF4Z5ihRcsHu2kzaTvDFuMKhA5klBrxTdh/vAwj+H2TiOc+KXz0qI+l
	 US8no/n5kr1BOTDLNSVo7qG8UK/Ac2vs8hiVrJVfEGu5Qk95ZsTqrafJIzS91W2oTNXg/
	 PHeUpkPJr9cZoGtGszuFSaDVT0+yoIN00eYdNXMCRdjloz375X3pQcfEasNtwVL5Hqouj
	 BJvGuhxi4fHwinEl2c6AKCBcslb654Y69BectkGTCwhPBEsTccFXAU3Ma/Xi6dVJHaRgG
	 TcheLCGPS0IHQN+QRgXD+cT5F0v0MXr6+6HF+G3qt216rvNnNYFeD3WNzfkScp1YXBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=npP161yt;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE22606A31C;
	Wed, 18 Nov 2026 06:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFE22606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=npP161yt
Received: from [192.168.1.70] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5762B20B7169;
	Tue, 17 Nov 2026 22:42:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5762B20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794984161;
	bh=NhLiqpRhYR+jbB7aXfZbX1GKQMokOJpkHTiOlAJk1JI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=npP161yt+2NqKpdXWKorUJL7rANBYxWfjlN+h2ZbAyLjzQjgrjBc8bK7FKPd4cdZJ
	 rIfGZpG4BEXgsWY4PZbmQpQTNfsy6RLgBXQVFrZUO9MbyosSoz9Ynb6Czw9ucNI+6q
	 p6Dhyso0ZZNTaFoYDykV1L4ZmO1DiMEPmP23Q0Z4=
Message-ID: <ba47e0f4-d076-4680-93e2-df4d673f742b@linux.microsoft.com>
Date: Wed, 18 Nov 2026 12:12:32 +0530
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
Subject: Re: [PATCH 3/3] mm/huge_memory: only compare PFNs of huge entries on
 huge fault insert
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
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
 Michael Kelley <mhklinux@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/16/2026 2:28 AM, Lorenzo Stoakes (ARM) wrote:
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> insert_pmd() and insert_pud() have issues with this as they both assume
> that, if the page table entry being populated is not empty, it must a
> present huge entry.
> 
> This is problematic as if it is a write fault, it compares its PFN against
> the one being inserted, warning if they differ, on the assumption that the
> entry is a huge leaf.
> 
> Since the entry may be a page table, this is invalid and can result in
> spurious warnings.
> 
> Equally, the entry might be non-present. Nothing can install such an entry
> in the VMAs that reach this code today, but there is no reason to rely upon
> that.
> 
> Therefore only examine the PFN if the entry is both present and huge, and
> otherwise simply return VM_FAULT_NOPAGE so the fault is retried and handled
> at the appropriate level.
> 
> This is what already happens for a read fault, for which the existing entry
> is not examined at all.
> 
> Target the commit which introduced the first driver which both mixes fault
> orders and passes the write flag for the fix (since this commit, both
> drm_gem_shmem and panthor are prey to this issue).
> 
> Reported-by: Eliav Farber <farbere@amazon.com>
> Closes: https://lore.kernel.org/all/20261112051440.16140-4-farbere@amazon.com/
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>   mm/huge_memory.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0d589be136d2..da632c3e834b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1643,6 +1643,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>   		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
>   					  fop.pfn;
>   
> +		/* We may have raced a fault which installed a page table. */
> +		if (!pmd_present(*pmd) || !pmd_trans_huge(*pmd))
> +			goto out_unlock;
> +
>   		if (write) {
>   			if (pmd_pfn(*pmd) != pfn) {
>   				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
> @@ -1770,6 +1774,10 @@ static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
>   		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
>   					  fop.pfn;
>   
> +		/* We may have raced a fault which installed a page table. */
> +		if (!pud_present(*pud) || !pud_trans_huge(*pud))
> +			goto out_unlock;
> +
>   		if (write) {
>   			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
>   				goto out_unlock;
> 

Acked-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman Jain
