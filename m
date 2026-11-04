Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783714;
	b=QC61tCnQIf7jQFCSJEsH1GM7CvGGih0gpchBXaxS5yQI1vGklGpXIzDMlKYAEJmWZjD8
	 yICg8jRpIG1gPyknZXl9kQl2rDlDwNOiJdwMkU0udOn2+If+OrCAP3zoTNuj2lZx+IQE1
	 bCBK06kZmMqjrvfGteqUDLIpDUF4PiwzvHhmVcR2jQ0Vh5aT28Gab/Uloju0/umZj1qmJ
	 lO2JWxU8lyvrTB0NpjrvjyqLGX2h3yZ048O1/gHDpydG9jrFwLUr8oxb/boYTtM6YEJDd
	 soRWuWdVeW9p5QQhRsdKn7bQ49jx+3KG5DiZMhN/s71QbbSBqqwq/eqxFCnQY0KUTxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783714;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wozQOH0rL+df2ESKnkoR9U756io00+MftNixJAyhy9s=;
	b=VnR4O7aCwwBMjjp9YP/QE8doJaqK31sXMFRbkDy9nOppAjv12jkSyLYFiiKt7CX10RYT
	 2pDFOymbi2JfhzN2wnqr77O9G/8rPTJGYDc/vBNmgf920svl2rQN7mQMgE8NxvmpcSgsO
	 YyX7XOFkOCiKXFVjG7Ok7EuXE42+tJKzVPbHd60UmnYZ8USfHxAA9D5C81g6xTU1KzwnQ
	 Iiwy44cUveW+eYODF+4kCiQbN3OCFCDtfjfyGibiK+F0WNqXFGMxOuAPZmOZj0cKlxHCl
	 yfhC6tWsuYKzIAKCuRvUn4fdt0ynpIZdGo6YRZbVmIznhnAF5q/+yODnqQJd3OiZzHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjA2xqeY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C101606A328;
	Wed,  4 Nov 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjA2xqeY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53D41F00919;
	Wed,  4 Nov 2026 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793783713;
	bh=wozQOH0rL+df2ESKnkoR9U756io00+MftNixJAyhy9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UjA2xqeYEK80i7Ppq03lQvL9aj7w7aCpnwjVlKlY4qACwWrO1xNZH7fqcg0/XQYXd
	 0XIL1G57zMHPcLqouikUAlFkvwGNnm8TEe+24IPTE2jQRZRI+rAZV8LmaK1RNpS6CY
	 VgMsB/z+HEkEgNNiR4S3FJ+IcrvX5Lhj9lHuDF3O1rEdd9gcSgRk2fkShoJcQeaK1R
	 G8h5IWb1O1KAkMem6coEO1PTX2M3tQxZGkQyvjwPTBLfv46F0G9+q8RqQrcNpjeHNM
	 I2ikync2oN5s0Hu/SoQvjlVGu0ChAoqqCFzQdaQFzUwb8DVF/4rYw9Mm9jkHtbz6Ug
	 g1OvXpMbmC3ow==
Date: Wed, 4 Nov 2026 09:15:06 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Rheinsberg <david@readahead.eu>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 1/2] mm/memfd: handle GUP pins more reliably when
 write-sealing
Message-ID: <aur3R_3_oz4Isjr4@gremlin>
References: <20261103-fixes_core_2-v1-0-f332954f1df4@kernel.org>
 <20261103-fixes_core_2-v1-1-f332954f1df4@kernel.org>
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
In-Reply-To: <20261103-fixes_core_2-v1-1-f332954f1df4@kernel.org>

On Tue, Nov 03, 2026 at 07:31:44PM +0100, David Hildenbrand (Arm) wrote:
> memfd_wait_for_pins() detects GUP references by comparing a folio's
> actual refcount with its expected refcount. As spelled out by
> folio_expected_ref_count(), obtaining the expected refcount when there
> can be concurrent folio (un)mapping is racy.
>
> So it is possible that a changing folio mapcount can race with our
> check for GUP references, and F_SEAL_WRITE might succeed even if there
> are some, allowing file contents to be modified after sealing.
>
> For folios with a reliable pincount, detect FOLL_PIN references using
> folio_maybe_dma_pinned() before falling back to the refcount comparison.
> For small folios without that, the 1024 pinning BIAS makes it very hard
> (although not impossible) to misguide the refcount comparison.
>
> This improves FOLL_PIN detection for folios with a pincount. Handling
> FOLL_GET and small folios requires a more fundamental change.
>
> Fortunately, most interfaces that allow for GUP'ing such pages use
> FOLL_PIN, in particular interfaces using FOLL_LONGTERM. However, we
> still have some FOLL_GET leftovers ...
>
> Fixes: 05f65b5c7090 ("shm: wait for pins to be released when sealing")
> Cc: stable@vger.kernel.org
> Cc: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

All very delicate stuff, I wonder if we could somehow make the logic here
generalised in a follow-up?

Anyway seems reasonable to me so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/memfd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 0f6fff004f5e4..9eda4c3eeaca5 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -32,6 +32,13 @@
>
>  static bool memfd_folio_has_extra_refs(struct folio *folio)
>  {
> +	/*
> +	 * Use the precise pincount where available to avoid racy refcount
> +	 * comparisons.
> +	 */
> +	if (folio_has_pincount(folio) && folio_maybe_dma_pinned(folio))
> +		return true;
> +
>  	return folio_ref_count(folio) != folio_expected_ref_count(folio);
>  }
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
