Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCF3A640C;
	Thu, 13 Aug 2026 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613063; cv=none; b=FGypTYSYxJqdnhEvSo5n3f2uK/Ue/d7+eUaLH4XGn121EdeHljfJdd8RBFIqS401oQIwjzPPd0W8OTlZn5gUgjRyAZizYS91F5FWpphK4seEPc2zjnCrF3OqjuAmXNDZQraxroiqj6b/Y+fLJus3XrY+fhrRZ08s2c2c+AXnU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613063; c=relaxed/simple;
	bh=QXI5fJmyAVrjjh6pg49MWzlN+T8dCb5xmjxbtmshjVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlUmuGiSSl5q0kKthI7Srx1RHFSHEojc/tG4Ff2m48D4L+LcYAMpK5+rXYI1QdVop4zKY96WPuH52JKXisRp/RE5Q+7yzI5MeTIKRA5K2bFBNLsWHaHwV08QJCYx+aDkwkSdkBdSnNym01Gd1aNtp7Kps6ltBRbabWTjEp3otuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omdXoTrc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omdXoTrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4211F000E9;
	Thu, 13 Aug 2026 09:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786613062;
	bh=M9U0BwCwOlA2q71JSGR94TVR71so4Y5WWmqxkhrxnts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=omdXoTrcdHsNFbdpmr+nH8KapdBZLg20P32XW68CN35Qw/yi47HqzWe7UnaEo09F7
	 DjBX+0/SEXz8rEJiffc/BKCLjU+IK6cMW+8SN8F+ApLdfhGShIciGVTJ2RMzbj0oeQ
	 /yZuCV2V4cJVCNOJeunr8tweiTSIDm3lQfwUOCV6pCMTXXlkLAESrBVeKM4iHUeBwa
	 t2lQwQcO/fDNi4wiUIYYb+nIqZV9QSZjdtNGWwHzLkx6tRZwp6b1DerpmcwK2D+UtF
	 6zAfWcF4HAj+WKRIcF76jj00LjO2mDgOiWVNxqJHpiLW5CZc4f+LHcgFy7KGh2T/am
	 HrLl8ZAGFcBDQ==
Date: Thu, 13 Aug 2026 10:23:56 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Nikunj A Dadhania <nikunj@amd.com>, akpm@linux-foundation.org, 
	baolu.lu@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org, 
	den@openvz.org, devnexen@gmail.com, hpa@zytor.com, iommu@lists.linux.dev, 
	jgg@ziepe.ca, jgross@suse.com, jirislaby@kernel.org, kas@kernel.org, 
	kevin.tian@intel.com, liam@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lists@steffen.cc, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, pfalcato@suse.de, shakeel.butt@linux.dev, stable@vger.kernel.org, 
	surenb@google.com, syzbot@syzkaller.appspotmail.com, tglx@kernel.org, 
	toshi.kani@hpe.com, vbabka@kernel.org, vishal.moola@gmail.com, will@kernel.org, 
	x86@kernel.org, bharata@amd.com, Ananth.Narayan@amd.com
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <an2KYgqMIoy6VloV@lucifer>
References: <anXvODEvV4f_Taj7@lucifer>
 <20260813055544.25567-1-nikunj@amd.com>
 <an2FdPPOWT50lLD4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an2FdPPOWT50lLD4@kernel.org>

On Thu, Aug 13, 2026 at 11:51:00AM +0300, Mike Rapoport wrote:
> On Thu, Aug 13, 2026 at 05:55:44AM +0000, Nikunj A Dadhania wrote:
> > On Fri, Aug 07, 2026 at 04:36:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > +static void poke_vmalloc_pages_safe(struct page **pages, void *addr,
> > > +				    bool cross_page_boundary)
> > > +{
> > > +	guard(mmap_read_lock)(&init_mm);
> > > +	poke_vmalloc_pages(pages, addr, cross_page_boundary);
> > > +}
> >
> > Tested just the proposed patch from this email (without the rest of the
> > CPA fixes series) on the 512-guest concurrent boot harness (details in
>
> For this fix to actually fix anything, the patches that add locking of
> mmap_lock to CPA are needed still.

And just in time the fully respun series (based on tip tree x86/mm) is in:

https://lore.kernel.org/all/20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org/

Please do try with the full series applied.

>
> > [1]) and still see the memcmp BUG, I havent hit the first BUG though:
> >
> >   kernel BUG at arch/x86/kernel/alternative.c:2727!
> >   Oops: invalid opcode: 0000 [#1] SMP NOPTI
> >   CPU: 1 UID: 0 PID: 485 Comm: (udev-worker) Not tainted 7.2.0-rc5-pokesafe+ #42 PREEMPT(full)
> >   RIP: 0010:__text_poke.cold+0xdb/0x2af
> >
> > The instrumentation captured the following before the memcmp BUG:
> >
> >   SMP alternatives: __text_poke: memcmp failed at addr=ffffffffc06ce1bb len=4
> >   SMP alternatives: __text_poke: expected (src): 2e 2e 31 c0
> >   SMP alternatives: __text_poke: found    (dst): f9 b8 9b d3
> >   SMP alternatives: __text_poke: pfn at poke time (vmalloc_to_page): 8ece
> >   SMP alternatives: __text_poke: pfn at readback time (vmalloc_to_page): c6ce
> >   SMP alternatives: __text_poke: page table dump for addr:
> >     PGD 2f042067  P4D 2f043067  PUD 2f045067  PMD c6001a1
> >
> > pfn acquired at the start of __text_poke() (0x8ece) differs from pfn
> > at readback time (0xc6ce) in the instrumentaion.
> >
> > [1] https://lore.kernel.org/all/20260812063316.21371-1-nikunj@amd.com/
> >
> > Regards,
> > Nikunj
>
> --
> Sincerely yours,
> Mike.

--
Cheers, Lorenzo
