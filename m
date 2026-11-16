Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853193;
	b=Dq3qG1oWjqoP5jxXtLLXRWlWiY8s88CW/6GD2oGs7LlAAD8pWtqMO4y09rVUmbVl0pZt
	 Sh/r1nCobNB9xaj0zMZ1tOecY2p6Wmq9q7aK951ptmPESd7GiOvg4FtysBRWRideexzEL
	 x39nWk09v1SGB0W5MXiKIwknhIBNzwrho9yr4FLHk9YwDgWoXMKuhTffdq4xzxa7sUcyL
	 eYrAb8qzF7PdjS9NhHGD+2etrBSGiiwTN/scPLZW4/XOwNfgS+AUHwstOCS1Dn/6lYmt/
	 E7W+VnoDmhsvEn4WA8w8hJcyv88HnXeLz2bcT1S4cpKua11j/uZq/9n+FLCbiy4R0LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853193;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=N3OaimYL9k1G6LS1mBgzQVa/tv/0aRmfS2iYV6WufZ8=;
	b=ViGdqjVLdBjOpPRBYh1TO4SjHg+a+9gl5nJBMdNT9JfIMcytFk36kExZdgxs9H0nKXsT
	 +rW6lZbyqD4I5iujwYBVa7AAfP+HbZoSBpoWuiRv8YZl7BMzadrOBb61RGto6oJVOv/Ux
	 Ifj8AKZlyodNT9MeC+WJv2xeeWgzA8ctbqHJgy/qtvwXht8PvxY31VdPLGrI9IGPEP1fG
	 i+NgYG9egEYsdnYsQ8Ow/X5vi1zkcy66N7PrFQVJ6f5qVophKyJ4B7+GMMKie1ORQc9uB
	 Up6R3cW25nAO/uJ8+1XEAtpULTaWZ/lt4G9LrkbFih+/Mizju/aE86ickkoNzgE9rbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pyS4iHQs;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24300606A31C;
	Mon, 16 Nov 2026 18:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24300606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pyS4iHQs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N3OaimYL9k1G6LS1mBgzQVa/tv/0aRmfS2iYV6WufZ8=; b=pyS4iHQsYBlpVL5Wiy/LAPlUuW
	hUlhWSGDvmWqMSdcn5Uw4R8M3wvOiUHGK5ZRc+lAGLDSFYg8bjwMb9RlQut8zHL12ugEI7ZbB+cAh
	D6sndl7Il9aP3iPHhK6zUBvCvPB1avmPrSaIo+AC6U+l+rTlLb9S7DVRWus9DUyHEgsCdfcPOozdm
	7HHytR7E0MRyvJKwNhLdSC4pl+wrvBRiBCJzcMaA8n6DlLfwsDBQnkBLlWyiK33/3Rdj13yH/do0y
	K4d3IXahESUj4S4xLv/vF1ZRr0eS8q/xUQO/svTw0ilbGw3XZ39taI9VIgRZ9DKs6WwRNqm3aFwZ2
	litlaUHA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT1J0-00000003Vzm-35rs;
	Mon, 16 Nov 2026 18:19:50 +0000
Date: Mon, 16 Nov 2026 13:19:49 -0500
From: "Liam R. Howlett" <liam@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: correctly uncharge accountable VMAs in error
 path
Message-ID: <yki3kpqx4bhek4zit2txtt7z2crfropbamcvnciornj5dp4eu2@45qlnjuowq5d>
References: <20261019-other-mremap-charge-leak-v1-1-d94477fe6545@kernel.org>
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
In-Reply-To: <20261019-other-mremap-charge-leak-v1-1-d94477fe6545@kernel.org>

On 26/10/19 04:57PM, Lorenzo Stoakes (ARM) wrote:
> The mremap error path is a fragile and unwieldy beast - it reverses the
> page table move then updates vma_remap_struct state to swap VMA, length and
> address between old and new VMAs in copy_vma_and_data().
> 
> If the mremap() operation didn't specify MREMAP_DONTUNMAP then its caller,
> move_vma(), invokes unmap_source_vma(), which unmaps the new VMA rather
> than the old one.
> 
> For accountable VMAs when MREMAP_DONTUNMAP is not specified,
> unmap_source_vma() unsets VMA_ACCOUNT_BIT during this unmap in order that
> only the delta of a VMA expansion is charged (performed by
> vrm_calc_charge() earlier).
> 
> Therefore nothing uncharges the expanded VMA size, and there is a permanent
> leak in global Committed_AS.
> 
> Resolve the issue by uncharging when MREMAP_DONTUNMAP is not specified.
> 
> Fixes: fdbef6149135 ("mm/mremap: don't account pages in vma_to_resize()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Liam R. Howlett (Google) <liam@infradead.org>

> ---
> Issue was found when I had local AI check the other mremap() fix from today - it
> raised that this pre-existing issue was present.
> ---
>  mm/mremap.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 6970783fc445..1620006028c4 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1338,6 +1338,20 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
>  		pmc_revert.need_rmap_locks = true;
>  		move_page_tables(&pmc_revert);
>  
> +		/*
> +		 * When copy_vma_and_data() returns, the new VMA will be
> +		 * unmapped rather than the old one.
> +		 *
> +		 * When an accountable move is being performed, this unmapping
> +		 * will not uncharge any expansion, so do that now.
> +		 *
> +		 * A move is accountable if the VMA is accountable and
> +		 * MREMAP_DONTUNMAP is not specified, so only do so if the
> +		 * latter is true.
> +		 */
> +		if (!(vrm->flags & MREMAP_DONTUNMAP))
> +			vrm_uncharge(vrm);
> +
>  		vrm->vma = new_vma;
>  		vrm->old_len = vrm->new_len;
>  		vrm->addr = vrm->new_addr;
> 
> ---
> base-commit: 4dbe24720eb3811563cd56b35d87ddf3f9beed2a
> change-id: 20261019-other-mremap-charge-leak-b426336c0299
> 
> Cheers,
> -- 
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
