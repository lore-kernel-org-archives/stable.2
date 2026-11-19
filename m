Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106747;
	b=vvWX96k3CebCgMSSFvbMN6otKGTBzUqaZdDz4SIFMnTnzP4FT/tOHQLETd3YsKFPvPRe
	 kuuJHKZpxp2jQ59KgYpMM/CyVBYSDbzcmoe/36HOQi29k1E97eAXO4e6spnsItzb74/Ds
	 V8x3o5ivrRvof8FzDygJugfhOLig5YneZEyH2NTmUN8FzXnD99Gte7BL9uomb8PC4pZ9Q
	 XVHtLREjm7h2Z4Ig4E0kPpK0k64W7Ba9ROQ2NVKdIfwfQwsPEpxz1zWhi9EMXlXRHDj8H
	 PmR6anEaz6KRJ954kLQMloYJUgyU5xqmmXVdhUA0FwllwideoEaOTHjap27mDyJxZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106747;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=gZlGQuCX7qTKr4D2OG4zoMh6nRgfrVAsN0lt/KJAFf0=;
	b=xOJyhFbyAM7Gtxl/kWICzJnl7CEhoPl2AOLLzqUBIyVXeDVi5enmmDzLQeZWipEVH1bj
	 wjp1c4m/Jr9N7TXecIb9gxaJH8ddaC0o3hEwpnSBFLhaWYtkevBd4GjPZaut2h5nNJoGX
	 EsuuvUwFj4y9R7MII9ldlo1b+moUS4Ku35LAgd3gqOzgvzxaAi0KjxGoB/XwhoPmuKQfD
	 q9wtBURmK6fBS2F497+aDd3D+SII/ZIrx2FenBj1MqLd3UeUDTrW4BvLsTksEekhtJWhl
	 b89mr9l/O+BwR1RhGg0bZGPj3dmhymxKk367ZMyx+PMEvSjbk/xA3lAyoBcryf2FHag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCAiOHRv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68B606A32C;
	Thu, 19 Nov 2026 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCAiOHRv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B83E1F000C5;
	Thu, 19 Nov 2026 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106747;
	bh=gZlGQuCX7qTKr4D2OG4zoMh6nRgfrVAsN0lt/KJAFf0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GCAiOHRvbgv3EYZiKjEnuFXPB1GLTlBbdCeR6du21xUp3FTJ//T3/k7eO25oh2wHd
	 vMaegGC1QAJnk03tu4gRu3JHade3myeZ6QyTUdLRql3D7Jl3E3Uku/HjI60+wqMIPJ
	 zcWGOE1E4vVRkmFBBiW3yu66wLE4VXU9vkdkToI47ER8mXOptjTnogjmrUdCjWXyhC
	 o4I2kd3FpbKyWlukmU+IiXO457vWi6ji5b3gJ1iTkfWAw3zbx35ti+ydL3DHnwcM8K
	 u5CqY3KAvamjo8NwVXZXTAzIGNwt/GLttV5VSoryR/8cwFCZG7LCE2TLYQM2BfdPBi
	 BVOKChem1XxUg==
From: David Hildenbrand <david@kernel.org>
To: David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Usama Arif <usama.arif@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org
In-Reply-To: <20261119134236.3745231-1-kas@kernel.org>
References: <20261119134236.3745231-1-kas@kernel.org>
Subject: Re: [PATCH] mm/memory: don't map hardware-poisoned pages in
 finish_fault()
Message-Id: <179510674270.3156.17546947206038231492.b4-ty@b4>
Date: Thu, 19 Nov 2026 17:45:42 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Thu, 19 Nov 2026 13:42:31 +0000, Kiryl Shutsemau (Meta) wrote:
> When memory_failure() cannot split a large file folio, the folio stays in
> the page cache with the poisoned page in it. do_set_pmd() refuses to map
> such a folio with a PMD, so that the poisoned page gets its own fault and
> SIGBUS. finish_fault() then falls back to PTEs, but maps the whole folio:
> 
>     do_shared_fault()
>       __do_fault()
>         PageHWPoison(vmf->page)
>           // the faulting page only
>       finish_fault()
>         do_set_pmd()
>           // backs off on has_hwpoisoned
>         set_pte_range(vmf, folio, &folio->page, folio_nr_pages(folio), ...)
>           // maps the poisoned page as well
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: core-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/memory: don't map hardware-poisoned pages in finish_fault()
      https://git.kernel.org/mm/core/c/2c536883

-- 
Cheers,

David

