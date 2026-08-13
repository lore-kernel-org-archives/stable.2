Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541746A5E1;
	Thu, 13 Aug 2026 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633683; cv=none; b=fXLpEcTt76iLkwMybSlYXiaR0lgDrzu1n/cxeR+L1buQY5Jwq4hTegCj1n2GWoFU5zFtxisN2BZYtPMyXdCh0zFP6np9PMA2VKficcLfLRzmz9GsBZ68RRu6tZVUmDerhciGyrdO7DVu8V1agM0byCy+5lxb63D5Tl6ROIIaWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633683; c=relaxed/simple;
	bh=DuvsC0v3gfLMYoatlirK2NMPyK4TJLODE4O6bX/vqiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UciT6i4GrFK+qRjnL9UK2UeK+WWeI2K82+xPsbiGsTmwwzTo1x1hHCw0ag7RhHRaeqGAKXL1c0iMRw+pVpQtKxtipJvO/LGkHygjFStwR2nrWhNwW2g+16YjWtzVh4Nmt+nl/EuQ7W0Th0QWu7UOCbNkTr0xHVzlhoJdgp0iXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvQcKO32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvQcKO32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F34D1F000E9;
	Thu, 13 Aug 2026 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633682;
	bh=gK6DwwQyRxxtNH/mIa8gsX3rT0/0H+8bKrZeyn+zATw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OvQcKO32Z34EbBDZ7Fmm6iJqwa8JrzLpYamuED4Ikir1Pw7RlZVOSfq5IJkOI5ECk
	 tKv7ErghU4m6GMZ4UEv5wSWNr1ZNIEbrPMhPR1f1OADutH9q0SJqOvcGQgRKTZzuM8
	 gsH4RDVb+EQ2ANGYB6x6VTeAshDoGy0D3cwKNcs4hdkILLULAZeao7G6JpR2tVilK5
	 tYCAWTaaq+91ijjcI4C/aN2jrl56giBrfuRwbfCGxRyiZej+PMPI/elszx5ggQhNzW
	 J4mMAYl7T2drPQwR0MHquB6X3kMk7e+A+9YxmEtPY4y2ilpSbN03ebo4QT2Q712dES
	 SYi8olOhLB1Og==
Date: Thu, 13 Aug 2026 16:07:38 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Pedro Falcato <pfalcato@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Steffen Dirkwinkel <lists@steffen.cc>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>, 
	Vishal Moola <vishal.moola@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, syzbot@syzkaller.appspotmail.com, 
	x86@kernel.org
Subject: Re: [PATCH v2 0/5] x86/mm/pat: CPA fixes
Message-ID: <an3dkOKWdajK09KN@lucifer>
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
 <9cfaa5d1-83b4-4b88-bf3a-05d2e074cadf@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfaa5d1-83b4-4b88-bf3a-05d2e074cadf@amd.com>

On Thu, Aug 13, 2026 at 08:35:21PM +0530, Nikunj A. Dadhania wrote:
>
> Tested v2 on a 512-guest concurrent boot harness across 200 iterations
> with no splats. Both crash signatures reported in [1] are no longer seen.
>
> Tested-by: Nikunj A Dadhania <nikunj@amd.com>

Thanks so much for the testing!

And all credit to Pedro for reporting and contributing the key commit that
resolves this issue :)

>
> Regards,
> Nikunj
>
> [1] https://lore.kernel.org/all/20260812063316.21371-1-nikunj@amd.com/
>
> > v1: https://patch.msgid.link/20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org
> >
> > ---
> > Lorenzo Stoakes (ARM) (3):
> >       x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
> >       x86/mm/pat: acquire init_mm read lock on attribute change to avoid UAF
> >       x86/mm/pat: allocate split page tables as kernel page tables
> >
> > Mike Rapoport (Microsoft) (1):
> >       x86/mm/pat: fix effective RW computation in lookup_address_in_pgd_attr()
> >
> > Pedro Falcato (1):
> >       x86/alternative: exclude text poking against change_page_attr()
> >
> >  arch/x86/kernel/alternative.c | 39 ++++++++++++++++++++++++---
> >  arch/x86/mm/pat/set_memory.c  | 61 +++++++++++++++++++++++++++++++------------
> >  include/linux/mmap_lock.h     |  2 ++
> >  3 files changed, 83 insertions(+), 19 deletions(-)
> > ---
> > base-commit: 7da514d819a0afb148634aac92b3d190f34947c3
> > change-id: 20260727-cpa-fixes-d3c73c075672
> >
> > --
> > Sincerely yours,
> > Mike.
> >
>

--
Cheers, Lorenzo
