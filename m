Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732066;
	b=jI4aZX8LkYWe2MqZaYXtshindNEDkkG0sdyXWw2dx1GsivXCEB/XgLDvS6xy+t49fZnh
	 qYxY2KTdn7NWgRF4orpLDNIwZo0yFFjKzCU5hfQ7TnhmTr4MDFbuZc+4uTMTzyDmhpBVu
	 aGSnt6nbgR9dtA9BUT/8B1JkGSuZ2sltvD0aZugokWzWMEqxlZhJcFJcR2wcmxjqccAmx
	 h4TV0TjNeoJyRYUTksjKv8Wv1Ud9gWaOvOT39xEjbJQHmTxhcMke11zPfYg+MbnwC5KUq
	 Yf/KY4OBhXxpmtsC+RvqENbUY/iN0cpBXKREMGe1htC7m+4eMSI+lTvFBeIldVSWkUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732066;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JPljfIGYRDg6q52cSpwt94ZpPrzmAsejEq2y2BXIXP4=;
	b=qxJIvfIVxCuO3EXZV9aPZObsTtONAclQ8e6kr3ZLeU9FOC4je/ZqUpl0LUD8SADpaQ1m
	 XfZZJ2nGXog+Piexw24tGa9aGmkIrQ4p3kjo73rNSzAZHZQMPVN4KCmY4RhS4VzFb+Psz
	 5h4eIQTIglVoUZlFI+PXW+nKEQoJ9OAtN5qPPhwP9fz23hDlj29IvjtKKvBSDn8Bwnjox
	 rbv853vaUY2bCPTFQ7owrvnWyXeniWjuZYnGM64OBcMFdtPcw8YS/VtN37eSTbFSx7dkR
	 lpu/K8Ef+e9B9l497tSmVpxsNZwPcpK4UobCPD9QZHzjrCSMiz6R5Lu2/Oy+6XjE+Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jC9C5R9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D9606A32C;
	Tue,  3 Nov 2026 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jC9C5R9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A2D1F000C1;
	Tue,  3 Nov 2026 18:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793732066;
	bh=JPljfIGYRDg6q52cSpwt94ZpPrzmAsejEq2y2BXIXP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jC9C5R9C/AIcfymo/OgR/5QSN9tRRJhOrWZZ3Ql64cmS7m2RytoQaDU1OOEFjiI1+
	 LUmcdiwRvFuMNeeOYl6DX5oVQ9GcYX/ijn0V0CXkUrebK6h8Lzg27aVbUF3FFQJInW
	 ga+3CMyMi7i/WATmUjAQcRfeLz+nDG2yy0i6cyCqLHJXGgQbKiaWqIK1mVnTGbM6e9
	 xzHQK/m6ctGPw56Mki0ZFtWQ6Snkvt7dFuZQjKKPaBFcoHz8Aiaa2lARbnzTQ1p189
	 tsM8fDrTcFvS8KTGv5Jao1uv80MSSY3BSv4GdKf90dbSmYvQuVQVqPFc3bOYcF3Wz9
	 RNt3GxHOfeKvg==
Date: Tue, 3 Nov 2026 20:54:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Umang Pokhriyal <umangpokhriyall@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] userfaultfd: validate the whole range before
 changing write protection
Message-ID: <auot2ZVM5YjyFlZZ@kernel.org>
References: <20261102103621.156928-1-umangpokhriyall@gmail.com>
 <20261102103621.156928-2-umangpokhriyall@gmail.com>
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
In-Reply-To: <20261102103621.156928-2-umangpokhriyall@gmail.com>

On Mon, Nov 02, 2026 at 04:06:20PM +0530, Umang Pokhriyal wrote:
> mwriteprotect_range() checks each VMA as it walks the range.  When a later
> VMA is not registered for write protection, or is a hugetlb VMA the range
> is not aligned to, the call fails after the earlier VMAs were already
> changed.  When unprotecting, userfaultfd_writeprotect() then skips
> wake_userfault(), so threads blocked on those pages are not woken although
> the pages are writable again.
> 
> An unprivileged process can trigger this with a range that spans an
> unregistered VMA.  It hasn't been seen in practice; it was found while
> reviewing the userfaultfd range ioctls with an LLM.
> 
> Validate the whole range first, as mrwprotect_range() already does.
> 
> Fixes: a1b92a3f1498 ("mm/userfaultfd: support WP on multiple VMAs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Umang Pokhriyal <umangpokhriyall@gmail.com>
> ---
>  mm/userfaultfd.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 87da92526..b8a9d9574 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1105,21 +1105,31 @@ static int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
>  	if (atomic_read(&ctx->mmap_changing))
>  		goto out_unlock;
>  
> +	/*
> +	 * Validate every spanned VMA before changing any of them, so an
> +	 * invalid range is rejected without changing part of it.
> +	 */
>  	err = -ENOENT;

Nit: this assignment is now redundant, isn't it?

>  	for_each_vma_range(vmi, dst_vma, end) {
> -
>  		if (!userfaultfd_wp(dst_vma)) {
>  			err = -ENOENT;
> -			break;
> +			goto out_unlock;
>  		}
>  
>  		if (vma_is_hugetlb(dst_vma)) {
> -			err = -EINVAL;

Same here.

>  			page_mask = vma_kernel_pagesize(dst_vma) - 1;
> -			if ((start & page_mask) || (len & page_mask))
> -				break;
> +			if ((start & page_mask) || (len & page_mask)) {
> +				err = -EINVAL;
> +				goto out_unlock;
> +			}
>  		}
> +		err = 0;
> +	}
> +	if (err)
> +		goto out_unlock;

If we a breaking on any error to out_unlock, why do we need err = 0 and
this check?

>  
> +	vma_iter_set(&vmi, start);
> +	for_each_vma_range(vmi, dst_vma, end) {
>  		_start = max(dst_vma->vm_start, start);
>  		_end = min(dst_vma->vm_end, end);
>  
> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.
