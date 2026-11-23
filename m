Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440263;
	b=MyVcysMIuBoGTFjMdVj38czlhpp2zJ7GHZOPHP9TODRGTi//7IZajdqUffdQaCMRDM0/
	 kIHW4wQasLTLHadUKJexkugXXYbYh2AMu/I5yNME1rO/fn8eSOkfEiZRtkodAaTt1oWVG
	 8iIwvmPGWeFJmCavX7yLJ+1dvpUeE6hYHSz2RNw2Src668yf+ZSlo8VduCSgqvKq9VnZR
	 MZp0UMS1204CYuNe4ZEEtAmd10si8ARQKjoLjDsEaNhiYr8kzXElJpzHW8brryxQUxFQ0
	 9avAnnb7uXvqj6QvIOeCbERvmIZWWAwMsbX5DDo7d3anNPQhtqnJpbDx3XpJiXf7Kog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440263;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e6BslsgsPqSWIJMgEULA7wCu8NLMlP7oHM2O2iiUPEg=;
	b=QMN/lr4ytYXwtsVbQa7Mxrk1cYCNJG5jTRqeBxjfX4BW+30EMBuF8RxZtvszzjVcgMaq
	 oAj3rw+07vO+f7JyM3mgFjnklfOMQRxSfrRpqY6z/0U0RAQJpHSc+QZiJL5bs7utIWVAF
	 vv368THkNQl5ytXtVKUIFTznSoo1y4oPr1TS0q3V4j0u6hM2OvbS8fQSWUmnPAv8i4+r3
	 ZgN1uIRKGIxy2GlsB8nFtEe1dhDKVUyIhiG+5xbA0VmwNXNJXNip1yhXi32j72Niy/qyg
	 pSjjEcP6+9dxgOxIF6lM+Tc48h5x2Zzu/+ptOsPfx0u6U2zK7tu9k6ya2ezUbredkog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4vkk2Zd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C408606A31A;
	Mon, 23 Nov 2026 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4vkk2Zd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5C91F000C4;
	Mon, 23 Nov 2026 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440262;
	bh=e6BslsgsPqSWIJMgEULA7wCu8NLMlP7oHM2O2iiUPEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n4vkk2ZdbLxRr+qFwmGGl1tUmdzFPOCqfjqV527Khs98rUNvAbury3Pu6tX9S0aIh
	 wwDeFoeRdYZ5Gf0mzFczTWp46CP6nJmEmsIS8jOcsvCpNb+ceLccvdtJPsFdx64Apv
	 9IyplPVmPHiUCNGgaw9F7tgKqNqmtclOtnJITScivtN6uHZxCMOR8hl5CKcWorbyNj
	 wLtSJYEsTkVsPY0ebBUi7zS/Y/FXp5tZuTss95pDlm8PBqByLDPZbY4BIsY5ivSakv
	 cYS1RznMsIKzb6FsqYydGr3MqyfnOA9XZGm/Ihyc5ijephLr4GGrKiJsYa8VSTLUKH
	 gyjA6LFsUMMqg==
Date: Mon, 23 Nov 2026 13:24:20 +0000
From: Harry Yoo <harry@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Usama Arif <usama.arif@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/memory: don't map hardware-poisoned pages in
 finish_fault()
Message-ID: <awQ-c38H1Eh1iFoy@thinkstation>
References: <20261119134236.3745231-1-kas@kernel.org>
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
In-Reply-To: <20261119134236.3745231-1-kas@kernel.org>

On Thu, Nov 19, 2026 at 01:42:31PM +0000, Kiryl Shutsemau (Meta) wrote:
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
> A process that touches the poisoned page takes a machine check instead
> of SIGBUS from the fault.
> 
> Map a folio with a poisoned page one page at a time. The poisoned page
> then takes its own fault, which __do_fault() turns into SIGBUS.
> 
> Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---

Looks good to me,
Acked-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
