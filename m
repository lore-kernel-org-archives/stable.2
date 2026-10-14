Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DF3955EC;
	Wed, 14 Oct 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989830; cv=none; b=E+kOHWD7UAg3bL/DdkTi9PcfFjkUGbB+BuZ0887masjrC3ljXEQdaLElW60J1I7xqU8gKKi9gahuiskwlrzHCXFegvWiNYIUfGPCtwflMBcHmMBnI65U55LYWDBy/KrCPEO/v+BWYwH8hzpXzkomu8NDSLhPmoiHXOAWB3x9eFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989830; c=relaxed/simple;
	bh=Z+vD7VXNgNFJo6weu2uJN9q2+WKofWwfJto6olB75os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEkZREIA/1WdVJi75rezUE1ShXCax2PgOBbYSkBdJdjUd85IovyESUWabmgju5IabAI4JmxQw7w5AG+AdrFSfJ0CHwD0RKBdCfXoGgvTVYdxjVWiv89mBnNZQEb+VvcX/da1MUANxB83+gyVFaUlbPxxeYsViVOWJ3cvj4DIkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbMvOooE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbMvOooE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79231F000C4;
	Wed, 14 Oct 2026 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989827;
	bh=dMSlHyjUU02bSE6X5r7bmxpu4G21C9qfseYw6MgAPQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EbMvOooECTvm/Ipx8SAwgZIMtCfZihKqt+i5jpyRsbYq1Tke2SaGkP6ka1W3LCa2x
	 hudVD7+nufM2VAtPfxpv3a4CR1d4yQjgpm7+r/lPFOkCOfT3W1CZgESrLlWQTqq4S4
	 DipzIM9r/24kdNAjhUEK7p3omVzWLrhAaKn3jbiSuM2cqeuBqwEam/Tm1R4I252ORA
	 rioZLKupo3RlFRG0WwWB1yCYhTq9en5eeHDETNKdXBnOgPCkUl556Iiergz0QHWHlR
	 eSr3MRBI4uI2VDMFk95c/T0BOPwwG6JRSsaQWoE07NSvw4TPE+5Tfp6WI6vD+bln6B
	 TA9Ib1VaXhiiw==
Date: Wed, 14 Oct 2026 15:57:00 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
Message-ID: <as-YFIBeupNnW8Pf@gremlin>
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
 <as4kvHe9IFZH5qrC@gremlin>
 <9add8400-66c1-47e9-b5af-7a4081ebf3c4@kernel.org>
 <as-BZibPscw4cxsD@gremlin>
 <06930044-4bcb-4478-8a6f-2dd3cf6d290e@kernel.org>
 <807e8d2e-e7c1-4491-a3e1-21d84cc58946@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <807e8d2e-e7c1-4491-a3e1-21d84cc58946@kernel.org>

On Wed, Oct 14, 2026 at 03:49:05PM +0200, David Hildenbrand (Arm) wrote:
> > I think we have to assume here that with NOPMD we will never end up in this code
> > because large folios will not apply (each PMD table has exactly one entry as of
> > today, so we cannot map large folios .... I think).
> >
> > I can try condensing that in a comment and cross my fingers that that is the
> > case. I tried that now. and codex review already tells me:
> >
> >   • [P1] Folded PMDs can reach this helper — memory.c:4948 (mm/memory.c:4948).
> > The comment’s assumption is false: arm64 with 64 KiB pages and 42-bit VA uses
> > folded PMDs and supports THP and
> >     NUMA balancing. Here, pmd_addr_end() returns vma->vm_end without clamping. A
> > large folio remapped across a PTE-table boundary can therefore make
> > numa_rebuild_large_mapping() walk beyond
> >     the mapped PTE table. The previous code explicitly limited this to pt_start
> > + PMD_SIZE. Cap the forward distance at PMD_SIZE - (addr & ~PMD_MASK) as well as
> > the VMA and folio limits.
> >
> > Let me see if there is any truth to that ...
>
> Ok, the PMD table as a single entry, but the PTE table obviously has 2k entries :)
>
> So large folios are possible and pmd_addr_end() would be wrong in this context.
>
> pmd_addr_end() really only works in page table walkers ...

Ack!

OK yeah, I missed that it gets redefined when wrapped, so forget about that.

A quick comment should do the job re: understanding.

--
Cheers, Lorenzo
