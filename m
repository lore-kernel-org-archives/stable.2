Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794725231;
	b=X+uS+SuZZO3MnAvFPPqnuIllrEGKAS4LNh2HecQNbsSBitYhyWEppLbsY7mXrdK5epaX
	 sLcTSId3Z9w9EyL/dal0sd6qm9QvTxB+i15FuY2M4vmUos2pBjexVtNoOTZcXnI4eDR7J
	 p2lB6LhVA3kIn2GT9ecmUantLYs/KxfnDeIkEtHS00HwFEMYEau5cHFuBLJKV6thy53fF
	 cCx+/0gg5lkjEqgJNDpY8kBDME0p4VVlSK0S1LXdBmIsYpbD29U8UbOc9UVZtgGbxzYdJ
	 MD7LZcC153LBiUFMAkB9Qqhw5TjhcsC8NwURJbrbE6h4/R2LYoAYJvmJYJeJHqE1xiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794725231;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=jwh2VnCoRYNWSpJavB3/olcfSK9xBV/jM+pUQtOBE9A=;
	b=MQj4x0f93NLG+Nio/zPbKHTO/lrNmLaCL8PbQl8dcBNO2GtiQV87WEmhhUEXmPTqM9kQ
	 UWTDCxqxard2a1/BiRqsUwGb0e3NoRx0JQs+r1o3UGo46mOIlM4Y6ba7V/PUUygKBxiew
	 gQ/HlPV1eolQ852eixnYVKfL8UbZyFAaZQ5XM9ywO++4SKDN/J3pKK+Wy8kj9ozaf4lZX
	 UUL+Fz9ccR01ijRaOySbAELBtz3hxvcNGMWZB402YnHyUcwp8FDAZ0wQ43IHNXPQ78vQ9
	 gtROySToA/A76UJpKk2c5jE6mkrZiez+z2A4UmP9wTpvLwx7p9zvVR9yoR666ObMlWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQc88LIF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D15606A329;
	Sun, 15 Nov 2026 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQc88LIF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168E31F000C4;
	Sun, 15 Nov 2026 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794725231;
	bh=jwh2VnCoRYNWSpJavB3/olcfSK9xBV/jM+pUQtOBE9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iQc88LIFJYlWRk3x+jUkZv57DqD6Zr+Qi/bjvEAx6dsX0FyX0S6lwk5ssflsR/o8q
	 L14BShrB8yCWC1qdswhGpATgsyOV8akcA3ZMu/82XdeGgiJt/9OF9kPNqo+YMkfT57
	 Cda8LpkOvH59RGcnzmo/VfwIa1Myl3kIXSPqFx/aZY5QuFYwzhZ9/jc2VoG3eh44ip
	 0ZeYVP9n/yUTogA4bJF/Jo01UXxbS8p1XgamlSKGMQnAbXpw6/Aa2iM0N1gdgBDnKe
	 qRiQYpm/Lla8FEkImBmQmUc2AiqKt61MV+5B7glgUOmoOp8jSZa0TfUzpuB2cjqTCx
	 M83DKc/z/VjxQ==
Date: Sun, 15 Nov 2026 08:47:03 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ivan Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: use PFN_PHYS() in phys_mem_access_prot()
Message-ID: <avlVZ9d-TqQKrJBw@kernel.org>
References: <20261113193812.1239880-1-ivanrwcm25@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113193812.1239880-1-ivanrwcm25@gmail.com>

On Fri, Nov 13, 2026 at 04:38:12PM -0300, Ivan Ezequiel Rodriguez wrote:
> From: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
> 
> phys_mem_access_prot() stores "pfn << PAGE_SHIFT" in a phys_addr_t.
> The shift is evaluated as unsigned long, so on a 32-bit kernel with
> CONFIG_PHYS_ADDR_T_64BIT an address above 4 GiB is truncated before
> uncached_access() compares it with __pa(high_memory).
> 
> mmap_mem_prepare() already shifts in phys_addr_t, so the mapping is
> accepted and then left cacheable. PFN_PHYS() casts before the shift.
> 
> On a MIPS32 XPA Malta guest, mmap of /dev/mem at 0xf00000000 without
> O_DSYNC used the boot CCA. The same mapping with O_DSYNC was uncached.
> With PFN_PHYS() both are uncached.
> 
> Fixes: 7e6735c3578e ("/dev/mem: use phys_addr_t for physical addresses")
> Cc: stable@vger.kernel.org
> Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/char-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/char-mem.c b/mm/char-mem.c
> index c5761ddedbd7..53ce0034a4c1 100644
> --- a/mm/char-mem.c
> +++ b/mm/char-mem.c
> @@ -272,7 +272,7 @@ static pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				     unsigned long size, pgprot_t vma_prot)
>  {
>  #ifdef pgprot_noncached
> -	phys_addr_t offset = pfn << PAGE_SHIFT;
> +	phys_addr_t offset = PFN_PHYS(pfn);
>  
>  	if (uncached_access(file, offset))
>  		return pgprot_noncached(vma_prot);
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
