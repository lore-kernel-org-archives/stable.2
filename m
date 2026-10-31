Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438704;
	b=BN+79szQXj0P1JjLDuxpFTkoC15Wh/sgW5PB9cT9q0p2tCBd2TWH1YG8//B2yZ+JMMQE
	 UdM633FYxBK3sNgFRj0Pfo33dRGf7UZ0YiXP0oxy29ng1DJhPbAOyahzMQa3YbXStXAav
	 R3bWxnXXI4fez5+vBUnrKsxgP2zJuGaEbf42KkwVqmBZsOWxvs8YSj5QB/bDxO8RKw+8p
	 sYjetLoT/U6wX6ueK6FAT+WqHKXBa4XzR53NxoLKBQDPyjuBTUq2dwFrPnm9OhEhIAs7c
	 i1RJbGWm0WBElOAAddTMNP+SddhB4Dw3D47v5+gd5PGdFF4GZbuWhlCOqILYOlPuBeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438704;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6ddbghh+GfDs4/40hw5vuqqvhvtdwHg1BQEEwOE8XoY=;
	b=j2sroKQO9q+IgFAqVxevV8iDTQk5Ke8pebVXfxzzyoVq6y+lRtbP1MfX7fiP44NmMLhV
	 vFz8gF90MhYI3Ub/1hT/MgtW4N0436RBtPiEq3ZgL1Dszx8yQl923YorUEUR0B1z5Wb3B
	 JcTfU9QhtSkNmcv9HIqah7GAGNVyWHlhahgowt7XbXfK5yIN/w3GIUK5lZqC5+Ju2oFWf
	 /AjJnft0LO3+43VF0PZxfkt0StHoZc//VyEmYLtoTKGj+GNN7thAk8fjGBlEegamAHbvA
	 9WB9DY0LCoj7D0OH7V1jeSAYh5NqtJI0iitTkweci61nW6gzN/voMNDuYd033jrzmIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYPNGH2Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1396606A31A;
	Sat, 31 Oct 2026 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYPNGH2Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE791F000C1;
	Sat, 31 Oct 2026 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793438703;
	bh=6ddbghh+GfDs4/40hw5vuqqvhvtdwHg1BQEEwOE8XoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fYPNGH2ZYtOvoaAQ03Tvi8VZSPWRGf3MWSEuKFNhwtahi4NJoPuPpuJXAbxCp8PNP
	 NgRc2BFrvT11+wK5fqZPsZbuURmWiN+6LmVfEr/urwZ9gNa9ZhcRwiRiXY3EG7NeWp
	 BSlRAaPj/ZlNx2efqm44KbrB+DCMNwYK9zPklv7Mks7oYdSOk7XGkRVyDl8PNA+79c
	 ggTL19zxrx+YoPdMDUw/qu22q/eSCVTSBwiolk5kTOnUTcdR51ZgvgVGD+TVd5uBkE
	 G3i0SIhqpTNgu4GG8xSJH+8EDQR5KKkg/amJxfWptsDlwPtTf6XPbNlymC7/zSXSRB
	 ocSTZfwDPdO5A==
Date: Sat, 31 Oct 2026 11:24:54 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/userfaultfd: recheck WP registration in the
 hugetlb UFFDIO_COPY retry
Message-ID: <auWz5tAzi0p6NMou@kernel.org>
References: <20261029221129.89068-1-azpijr@gmail.com>
 <20261029221129.89068-2-azpijr@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029221129.89068-2-azpijr@gmail.com>

Hi Jose,

On Thu, Oct 29, 2026 at 11:11:01PM +0100, Jose A. Perez de Azpillaga wrote:
> mfill_atomic_hugetlb() drops its locks to copy the source page with page
> faults enabled and then looks the VMA up again. The retry doesn't check
> that the VMA is still registered for WP, so if the range is re-registered
> without WP in that window, a UFFDIO_COPY_MODE_WP copy installs a uffd-wp
> PTE in a VMA without VM_UFFD_WP. That is one of the leftover uffd bits
> hugetlb_fault() has to tolerate.

The "leftover" sentence will be confusing for future readers
 
> The non-hugetlb retry goes through mfill_get_vma() again and fails with
> -EINVAL. Do the same check in the hugetlb retry.

No need to reference non-hugetlb path, just describe the added check.
 
> Fixes: 6041c6917903 ("mm/hugetlb: take care of UFFDIO_COPY_MODE_WP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

With those fixed:

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3b71712edab4..a70ecfc8a998 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -810,6 +810,10 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
>  			goto out_unlock_vma;
>  
> +		/* The range may have been re-registered without WP meanwhile. */
> +		if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
> +			goto out_unlock_vma;
> +
>  		/*
>  		 * If memory mappings are changing because of non-cooperative
>  		 * operation (e.g. mremap) running in parallel, bail out and
> -- 
> 2.55.0
> 

-- 
Sincerely yours,
Mike.
