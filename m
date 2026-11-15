Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794745667;
	b=1qdaJH2GCmLx9KeaCgtSUKvJqb3m2Q0k9/UlTQuY0InCbkGjMxm9cfgk0DerYR+ymgHu
	 KBqzMzy3bYVkiCQB/x6C8m6QbWrjQNzUT6H3WevGvRaoaF++zTGf3FEnNTXd8ERb2uZ0I
	 1LtIkEkx1zggSKXwtN6H6l6PH4RTzshXLXMVjn/33ystj23mDxE9epAVCahZ7Ye+jZH6j
	 SAejl4grVpGQz/jtUlu8yGFEud0vehnPKLojzKNFLfHP5vGPQGUG1+quF5VMe2M9EpNsW
	 /kIxvZXAhzDaIvtyYi4KOuCyCNyj7Rtur6HlYIkCo98SPPdWwgnqQ0RNPNrOwdIPZXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794745667;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=UAPUreepg71t27uA19huNdBMN8SZC5pl+gBBNOjrEpE=;
	b=NcAVzKADAVwk8+STifjgUT30gvpQWYznkMKnDW5tMwTmbgjVVUM/oM9i9Sa7LRfHlEzb
	 gaEVuUPYjQP3AmLeGwrsdtmT3f6sKskODMbfjg0xCFQSx2shpsDDnIpknL7D4fxUHuTYC
	 t1R7OmQtCiWyuB8kAyzovv6BVUXdohQ/PrQEGiRb0Unv1YUKtnTXxSpc+v+aYKW3VKvMN
	 AgYkxW7qUBAaiYnuPfUdNNCxIokwWkUjue/SaM8vWK1BAycorOdHY0akQ628rEoKe+X2Y
	 uZPlkMyAyEPJMyEhsiMWnEY4CivzsK8grKd+/+SBN+6sEzB59XlGBdYlEDyJba0E9Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lg2tJ8Zf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFF606A31E;
	Sun, 15 Nov 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lg2tJ8Zf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E8E1F000C4;
	Sun, 15 Nov 2026 12:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794745666;
	bh=UAPUreepg71t27uA19huNdBMN8SZC5pl+gBBNOjrEpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lg2tJ8ZfrKmdiIKH0xpR57qGsXXfv2F5ghS97GTxNPBYY8aqMOGx2U30AnaIf0OtU
	 BwGhDNlCMBUsrfabSbufGfLT3OaR1RYjS9nwKVDAWL8J6AdVpnXLSgwdCGgl2bKeHP
	 VgjCDvrJZoBkLyNSrBbJDQlRKdaGGexyelqo55KgE7EzB9xk4jwa8rwl79TQccZyvz
	 RmmlZGwya6TYgMfbALzKyzOkSeGtq+99zbwJcdGmtM/laJI+bxnQD+irqZdTHdrtQ3
	 0/6lM2cuN6kAuj4g3ho77thhIa6vswDZPy9tONnIb9v3gpmpvoP3zqyMcal8rxA3qM
	 R3BmAszLUtkkg==
Date: Sun, 15 Nov 2026 12:27:42 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ivan Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: use PFN_PHYS() in phys_mem_access_prot()
Message-ID: <avmlN3K0CYl2yDP-@lucifer>
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

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

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
Cheers, Lorenzo
