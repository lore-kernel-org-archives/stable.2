Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E74570E9;
	Tue, 28 Jul 2026 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250250; cv=none; b=EdSgZI35A8XpZ8XqboAFGdxOIEQYa6SlOar+iYLbW+SJyT1ThfNw2FBjolNGqW8/2F4S2AWeFY5XPiim3CfYYdh6cTqt0knyFqTGVLBO1hLna0ESrAiCSX0TdA3zmDGvTrK6pG9xu7AY0Av+FBj1IS0ORg2Fcr6FEemqh7QMHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250250; c=relaxed/simple;
	bh=2qHjaIBfynZobNDukWlnSCw5PyGYvrfZcaxOhfYQ2ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0NfNBf5taRtgufUk/RUoAmKocAnxQNxdjdeaVYoDVTziDADxcdqN+u0GxjYiAmZJRJmsDyJKz/Ijv/+LUZmOgNiOgKCeUGgvtOTFkqtQnIIFF2QV+6ZE0x5tU0VLQNH1AUUwamkQQ9iK4UgaQOldzO/yexdRPa41mDHXmmvCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzGVKV1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzGVKV1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23D81F00A3A;
	Tue, 28 Jul 2026 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785250249;
	bh=d8aX8+NOKX/9GpYKQyqHDW9REYVeXE4o7JCL3uD1BMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AzGVKV1O6jDCe07R/2Flut5AvRNLGCJJBd1ulPSe/37OmJu20kbCCL9zQsA+hxx1h
	 CUAM7UFq4p2pyNuyJGP7cMnhZQfTYLYJR3tB4pJ/wXuhIPCfz+baLerC6FjIfdb4FI
	 FCdoHLG6jobXHbwWHp91U3am0o9As+OGJwkE8aT2MBUMMOSv4HQsRMRNiIG9CqTek7
	 IGoqQUHVnhtD7ydoT3mY+wbvkzzjXodEYEcTs5urWxgcyizpRL80Vex6QCYnliWrNc
	 4GUrtivP3Unhe6hKxxw001iubuBvu1x1yol/x2PvIkam9r8w05ux8inyMutradFQ4+
	 cLcp1Inz8taIg==
Date: Tue, 28 Jul 2026 15:50:28 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Dave Hansen <dave.hansen@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, David CARLIER <devnexen@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>, 
	Vishal Moola <vishal.moola@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/5] x86/mm/pat: introcude cpa_lock() and cpa_unlock()
Message-ID: <amjBb7djBkzaxcqR@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>
 <20260728142108.GW751831@noisy.programming.kicks-ass.net>
 <adfffb36-9943-4af7-a0ee-0e762e47fa11@intel.com>
 <20260728143135.GG651302@noisy.programming.kicks-ass.net>
 <amjAxhL-IeeJITEv@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amjAxhL-IeeJITEv@kernel.org>

On Tue, Jul 28, 2026 at 05:46:30PM +0300, Mike Rapoport wrote:
> On Tue, Jul 28, 2026 at 04:31:35PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 28, 2026 at 07:30:27AM -0700, Dave Hansen wrote:
> > > On 7/28/26 07:21, Peter Zijlstra wrote:
> > > > There was already a patch merged that removed the shole debug_pagealloc
> > > > exception. Is that not better?
> > >
> > > As I'm scanning through email this morning, there's another issue that
> > > popped up with that patch. It's causing hangs on boot.
> > >
> > > It's looking like debug pagealloc not taking the lock is actually
> > > functional, not an optimization. Although, I hesitate to say
> > > "functional" and would prefer to use much less nice words to describe it.
> >
> > Yeah, lets figure out why that is before we retain this wart ;-)
>
> As Lorenzo said:
>
>   __kernel_map_pages() can be called from irq context:
>
>   < GFP_ATOMIC context >
>   kfree() or whatever
>   -> ...
>   -> __free_pages_prepare()
>   -> debug_pagealloc_unmap_pages()
>   -> __kernel_map_pages()
>   -> __change_page_attr_set_clr()
>   -> cpa_lock

Yup :)

Without the debug stuff you have this issue.

With it you don't...

Also without it Denis's patch is broken.

This series Mike's providing is fairly exhuastively the best way to fix the
various issues, grouped together and parted from mm to make everybody's life a
little easier...

>
>
> --
> Sincerely yours,
> Mike.

Cheers, Lorenzo
