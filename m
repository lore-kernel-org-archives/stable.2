Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640472;
	b=DW/qnikbEaZpsFDPE/3rgTMtzxWo/NBeO0m12b71tcjRKek2BacxiTBqHduNpRWZ8Ts9
	 8ahKab2s05mwwmxTz+pp7iytgxpdzs5fCnqj/X8NA34mVdbVph63TDRYAZDtRZVylRAlL
	 XgGIal+XQMGpd05OcUncIwjNXuG4ZDXhIt5FlJQ0Zsb2FRFsdYt1xRif8v8AhUEOPDrhs
	 Ed8IlzrNjyclhjeFet10sMrkx8ekk1xpLkSciy3Z0aj9Prx3HvmOmWxdOdg5atDcVbizG
	 ru8IDkDIMSYShYipvUTqQWSS18GIWIxK22e+fq9BoMMXInjcSrEYmx/5R/yG+X4POpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640472;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=leKsCN/AW0CIMV0Z58FExykl0a+UkP/KW/e3nsnHLQM=;
	b=rdwiLKn12cNY+JrxpyLDoD97vnpWGpmcwny4KVSTLNvhnhXBKnYEg0yXsQfOqAud+Dcf
	 deWgoVaOKKFvFFGACy3e7DllXLYGR0MWomSBDHGwxFphlighiFgnsU1so4iSxpTKnwqb5
	 GihGHMAIkpmFKLVwSX9LTl9+x/bsu0EgoUkw9kGHGHRFyLKyH2U/6U6/R3hOpk7TJNJDl
	 qERgkcmHI6JJ+wUlb1MvODr0pswX5Uk8HoIriYTHCS1ZRBebUe+H8iysCLgGhv/JySVGp
	 hkV8gdNfK50IK3/gd4eAhY39d5EJOJrLPnWV4kNLG8dEcaVlwwJm1v9VKxk8PVHCljw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=hCGUwl5E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F063606D82E;
	Mon,  2 Nov 2026 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=hCGUwl5E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D29A1F00A17;
	Mon,  2 Nov 2026 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793640471;
	bh=leKsCN/AW0CIMV0Z58FExykl0a+UkP/KW/e3nsnHLQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hCGUwl5E2q8xC3fuwYjC4VbJ0KmGUnWBIucbBnmAQ1vd3ngEy7yXbM4BCpaxwfXNj
	 IhAZLA/WXHfX9ARMw69lYseQ7Vc5+vSFUh7v+FhlXPadvqEAr2T9l+RQI1sK8KSBM6
	 PseChT1NMSI3bz7QCXmm5cSTyDOiG6BIlu/XVPuQ=
Date: Mon, 2 Nov 2026 09:27:50 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara
 <jack@suse.cz>, David Hildenbrand <david@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Krystian Kaniewski
 <krystianmkaniewski@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps
 back
Message-Id: <20261102092750.e53073b2c7b872f9d70c0711@linux-foundation.org>
In-Reply-To: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Oct 2026 04:33:59 +0000 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev> wrote:

> filemap_map_pages() can dereference a PTE pointer outside the page table
> it locked. KASAN has reported this as a use-after-free read [1]. The
> same path can also write out of bounds. When the stray entry reads as
> none, the fault-around loop maps a page there with set_pte_range().
> 
> Its fault-around loop walks the page cache and moves vmf->pte by the
> change in index. A lower index moves it back. xas_find() can step back
> to a lower index when a multi-index entry is split during the walk.
> 
> [1] fixes xas_find(), but the loop still relies on the walk never
> stepping back. Stop the fault-around when the walk steps back. ->fault()
> maps the faulting page if the loop did not.

Thanks.

Can I add your tested-by to [1]?

> Link: https://lore.kernel.org/20260904121301.200049-1-krystianmkaniewski@gmail.com [1]

"xarray: fix index jumping backwards in xas_find()".

