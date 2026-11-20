Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154669;
	b=g7eY3vOTOKNn8HtFajTJYFOdqQThqyZzTto+Lsdo4s9dr2xFRJoRJ4vtoCkZU+A2FK4i
	 7enHFuKcJB2VyF2EKG3xdsZT7ycJAHOgc9lcAlppCm1Eo4WsoGjPw8zGWCcEgkz4LHMvz
	 vAtfF3yyeBXQ16gj4ml3ZuPwPnPcb28pgL9NgVqG3oXl+jbT3btwJm+OjuP4cS7YDRXKQ
	 qPM8KJAymxJfepvjYqmtF8Q/nrNDReJOKYdrUiBecnb/R7sDVRkyQ4Ra7q0mGNx8zI0vZ
	 8oxGDPO2zxUaBUGHwgFm3btkzVuc3D3R/QstengABYYjMlwCFnqkJnJaOseNsjbfj0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154669;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iNo8yliNdouUktBX46FmLDoA4S8B6QiUkCM4qwHf0Vk=;
	b=AiWTut4ViIS7SY34nSl9PTiVnBP3ptmiQAqIegX/RR1SAMBYKxQu+XFi9RYL2EmZ4QMH
	 ZgNQ/IzEYRzsxAro8XWppbFP55Huad8i1/VrE6hlcNclJPoKJ0pHcvGPa43k9fx2DZSdg
	 a+unNRJx/bKIv+iEGbJGobAUbR1Ng8x99EflNyDHa12LDW+6NrCjfeYPsvkgrL+635iKs
	 9MLcpY/jx7HFLQ9By/UyhhfQ4JRpq6dWBQ9ie7qXBrtpo3Cw1QdvYDQ0Z2RtESNvi+eul
	 mJgzeExwhCXUiEKL9g8UPjrd8TJzyMGy5j7bZcar6+th8T+vIBu8ZQUPAJwqgmqb+IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN29lo+k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A2606A516;
	Fri, 20 Nov 2026 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN29lo+k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D471F000CA;
	Fri, 20 Nov 2026 06:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795154669;
	bh=iNo8yliNdouUktBX46FmLDoA4S8B6QiUkCM4qwHf0Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YN29lo+kKvCpoPcXXBE51pZ9MlGx2ZtxPeJM06PUnMQAI8HJaZzBCnhs1XDRrHg9+
	 ufcJhGmSiExYJqKlDrC6ulxKS2Pa0b0ytUlbjrtFzj/kD4NPD+E/Li9qN0UY3w1K8t
	 nHz3NmYRZeqg1LSzYRqnT2zlo6b0C70PGUtgdth4dK6iRYbmhuhmxF0SuxGLr2H+v+
	 ordNpuCkrhex/7u9TtQZXHdeopEndlAbDO5clsBP8XDREHcj7rTibmIRid61FkMg/R
	 cO5zPr04/STnhssCv6obIWuetp4cavUttZx5SKxSkB/5JdvIA8t2fz0nhlP7iefaZ3
	 VjTDdJLk1xvxg==
Date: Fri, 20 Nov 2026 07:04:22 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Usama Arif <usama.arif@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/memory: don't map hardware-poisoned pages in
 finish_fault()
Message-ID: <av_i5hZYLZAbkPgZ@localhost.localdomain>
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

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
