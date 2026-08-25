Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930C23507B;
	Tue, 25 Aug 2026 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643125; cv=none; b=W+phSJpoCW0YBdqmPyWDLP8fUDRS1RXb9nDcqbcvXlIShZ0n6LrMWZc9Uh2zT2fsI6qETPMkI0HB+WsfGCN1jtDJhGdt91K4XfD33o4BWi4HTRyyj/GhXosLainoAHhrXSCQj6cV5dLdhWrKHBbYr/iWAkrCvprTZbFWcpdGFbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643125; c=relaxed/simple;
	bh=pOEToaHFZ1KezTVQLT895r8MTCYw9JPZrUoSp64NpPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcQQ6pH+Ot7ZfhQj1gK8YGneD8EYQz6TRKbXgmifnWglZX7U1L9AY1FWFkUkwpk8u9WyCqQ7TNfNoq4Fkj+nmgV/AxzsDUjnrnLApr+t7INtNf2Ve1QtW+C6BpPL6CIbi0lF1B16x3sXPqsw2T7aVgjZvdeK1mr4WUAfBQg7E3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4g/5Wuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4g/5Wuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6908D1F000E9;
	Tue, 25 Aug 2026 07:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787643124;
	bh=pOEToaHFZ1KezTVQLT895r8MTCYw9JPZrUoSp64NpPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z4g/5WuuSrT94p10shBVAIXPmRKgbAf3s/fvhs/4tFk+uVYx28S171DpFdj0a9Xtu
	 yTgAB0qfoK70a2ye7WIOmkKuqCjxINjcN0eExJDTuRNBqiinabd9CGUcwpYxZmIH3s
	 A0kNWY2SdjirMgff3v1e0bjg5Zda8IR7ORCKEQrBFZoKCrT/hCqjtKapvjkQ2xpfVN
	 aAnIT1hGn9XvE3sPxICXKO90JPq+Dics4zTCwjz0acMygp6SMe5XJ/h3sRF6PIVSHA
	 ijnfHH3HK2dEqvm36yUHge9E/WgJxljCqXRw85kpAtXpDM/79/D+YtvABmbSMjvNJU
	 LC6rJGO/S2iuw==
Date: Tue, 25 Aug 2026 08:31:53 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Atish Patra <atish.patra@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Pedro Falcato <pfalcato@suse.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Steffen Dirkwinkel <lists@steffen.cc>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com, x86@kernel.org
Subject: Re: [PATCH v2 0/5] x86/mm/pat: CPA fixes
Message-ID: <ao1EtJG_Gj8f90WQ@gremlin>
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
 <556337a8-5e2b-45fe-a1ba-90a90c1f3c4d@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556337a8-5e2b-45fe-a1ba-90a90c1f3c4d@linux.dev>

On Tue, Aug 25, 2026 at 12:12:32AM -0700, Atish Patra wrote:
> Reproduced and verified this series (patches 1-3) on 4vcpu guest running two different kernels
> 1. mainline (commit: 77ae27fd98f3)
> 2. Ubuntu Resolute 7.0.0-26 (production kernel hitting the issue in a VM)
>
> The Reproducer consisted of
> 1. A debug patch a cmdline-gated stall between the two *pmd reads in vmalloc_to_page()
> 2. One taskset-pinned insmod/rmmod worker per module over stock cfg80211/dummy/veth modules
>
> With the above reproducer, both BUG within seconds in unpatched kernel.
> 1. Resolute in 0.71s at alternative.c:2564 (BUG_ON(!pages[0] ...), RAX=0)
> 2. mainline at alternative.c:2473 (BUG_ON(memcmp(addr, src, len))).
>
> With patches 1-3: zero splats across 10 runs each (600s/11,378 module load/unload cycles on mainline and 1200s/55,980 module load/unload cycles on Resolute).

Amazing, thanks!

>
>
> Tested-by: Atish Patra<atishp@meta.com>

I guess should be applied to patches 1-3 only strictly? Or perhaps 3/5?

>
> > --
> > Sincerely yours,
> > Mike.
> >

--
Cheers, Lorenzo
