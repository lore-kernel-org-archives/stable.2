Received: from mta1.migadu.com (out-109.mta1.migadu.com [95.215.58.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0E515993
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983998; cv=none; b=JQXnPnWfTmb5wwFx7q9MMiWsmmwxMiL6zqk8aMPS5IaTKeNt/RB5Yhd75mZoSHvIflD2vWWta81uJoOhN6IoaFH1gCnVx77AIgXEZp2eVa4O623b5hyOnZtwPjYepg45qaai0yrRq+Fb5oj0VzZC+gJdK+C7KvHUlKbsW580D+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983998; c=relaxed/simple;
	bh=m7HcPUAMizid1DX3lRG9Tzw1zddlCTzU8zWnOAtnnRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNrC4UxvoDHKGBMZcY5b13kImnWRYDPeZypmiMZlM0ifo+Leg3bHItVAq9b9gT2V43Ixx9UIfGPPX4UXlHgQIzdd9zqdGzwnpdCC2iyKPEfZrjvityfeKUlFuaY/FlOumdEnoEGxsXyCplD63dgb2dd3Rxle0biHPlEoE1TFdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kRRCaIoJ; arc=none smtp.client-ip=95.215.58.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kRRCaIoJ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m7HcPUAMizid1DX3lRG9Tzw1zddlCTzU8zWnOAtnnRg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791983994; v=1; x=1792588794;
 b=kRRCaIoJw0sJTJ/tOBQljz6AT/gufciBi0m1KrH8rJZGBnpa3mkxfjwGQPb+ELUw7hsBdCVU
 mmxqIxcLYn0+K+Zux9JnBzXzRsy69peQpfNnW2jSJ4q0+GnbK8U14BbNpbbi8550m/0hof2d0ZT
 ASh7FEPzd7j6QUveg7i6TzX0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b774b44408666da9;
	Wed, 14 Oct 2026 13:19:54 +0000
X-Mizu-Trace-ID: b774b44408666da9
X-Migadu-Flow: FLOW_OUT
Message-ID: <58e8d79b-f7c3-4ded-9272-07c309917055@linux.dev>
Date: Wed, 14 Oct 2026 21:19:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: recheck a special PMD under the lock in
 copy_huge_pmd()
Content-Language: en-US
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Alex Williamson <alex@shazbot.org>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Nico Pache <nico.pache@linux.dev>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, dri-devel@lists.freedesktop.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Usama Arif <usama.arif@linux.dev>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, Peter Xu
 <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/14 19:57, Konstantin Khorenko wrote:
[...]
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1e5d68acf62a5..fcea98f0d8865 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1965,13 +1965,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>   		src_ptl = pmd_lockptr(src_mm, src_pmd);
>   		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>   		/*
> -		 * No need to recheck the pmd, it can't change with write
> -		 * mmap lock held here.
> -		 *
> -		 * Meanwhile, making sure it's not a CoW VMA with writable
> -		 * mapping, otherwise it means either the anon page wrongly
> -		 * applied special bit, or we made the PRIVATE mapping be
> -		 * able to wrongly write to the backend MMIO.
> +		 * The mmap and VMA write locks of the source keep faults
> +		 * out, but unmap_mapping_range() does not take the mmap
> +		 * lock and may have cleared the pmd since the lockless
> +		 * read. Let copy_pmd_range() skip it then.
> +		 */
> +		pmd = pmdp_get(src_pmd);
> +		if (unlikely(!pmd_present(pmd) || !pmd_special(pmd))) {

Why not just check pmd_none(pmd) here? We're holding the source mmap/VMA
write locks, so the PMD either stays special or gets cleared, right?

Cheers, Lance

> +			spin_unlock(src_ptl);
> +			spin_unlock(dst_ptl);
> +			return -EAGAIN;
> +		}
> +		/*
> +		 * Make sure it's not a CoW VMA with writable mapping,
> +		 * otherwise it means either the anon page wrongly applied
> +		 * special bit, or we made the PRIVATE mapping be able to
> +		 * wrongly write to the backend MMIO.
>   		 */
>   		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
>   		goto set_pmd;
> 
> ---
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2
> 
> Best regards,
> --
> Konstantin Khorenko <khorenko@virtuozzo.com>
> 

