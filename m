Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278C30F92D;
	Mon, 13 Jul 2026 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959794; cv=none; b=jxqXdPTQJUOter5f1KyE8zkoQi8+NXIviD2gS7/OOmvhnCCZ1lf7WXoyOjni00QtL+piMdZhKXLSkuaMYFuyJTIaGtY1O9Ra0a+sGv5zywaGpAQ2E1ozdeMgLHh4V/Csl2mzDuZ2MySHgFiAGArDjxmmvaGFiqY7Zr3MlJ4LnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959794; c=relaxed/simple;
	bh=LGaqXmco4Nvf28C1PHC6jBPldtjIjC782IMn5cORV60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqGaoVX2NJu2ksVrzsare8meChm1SlZ4oQY5knkRniZlILDD7CpAcr9kT0AuT8lONXBIzpINHLzGVO/nwmVnrQuo5DE0COZQ2ZHIIHtC4aJ7agHN/E4STEmp/8tGTauVA5TyU62KoBM9iZVcgXEBrKMGmbKCZzxgaNKhlHAhaL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5tpxXrO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5tpxXrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA3F1F000E9;
	Mon, 13 Jul 2026 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783959793;
	bh=LGaqXmco4Nvf28C1PHC6jBPldtjIjC782IMn5cORV60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m5tpxXrOWnJFtjzJC6UWXb9uBYPk1xIJ3t3U4btW7ka0F0+IeC/Io06pDWQNc7C14
	 uUx+fKcEDYkAh7cGZRWDlaaBufum4Box+EFg7TOASF266NHoE3EVpfoENrLV/4u6Eu
	 MOGgLJKgETuvdBmUPcH/JYosLxwK9mmggugtjSdndOLHGAOfoFUgZa/U2sSV9gIk0n
	 VMNI/2hfKPqPSHyL1pbF3ymYn8VDl+Prz9VEX6rKZyqZCG5qcKcYnTYPxmTaHwiofQ
	 BsWV87bUWVo9apedriWlAx0I4H8kIGgg4DlkKV0tSenSU6QBL9HbWlnlk0Ra32eY3F
	 pdEKtZ7SWeV7w==
Date: Mon, 13 Jul 2026 17:22:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Toshi Kani <toshi.kani@hpe.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	David Carlier <devnexen@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
Message-ID: <alUPbRx3_neT5ioO@lucifer>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <8e320b30-9658-4e9f-ac4c-f99dcf855944@arm.com>
 <alNQccqtx5-QApup@lucifer>
 <alTOCtzQh9RMfWbc@willie-the-truck>
 <alTxUwrkzEx-FEOP@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alTxUwrkzEx-FEOP@kernel.org>

+cc Kiryl as ref'd below.

On Mon, Jul 13, 2026 at 05:08:19PM +0300, Mike Rapoport wrote:
> On Mon, Jul 13, 2026 at 12:37:46PM +0100, Will Deacon wrote:
> > On Sun, Jul 12, 2026 at 09:46:46AM +0100, Lorenzo Stoakes wrote:
> > > On Sun, Jul 12, 2026 at 12:50:08PM +0530, Dev Jain wrote:
> > > > Will Deacon had pushed back on a similar approach:
> > > > https://lore.kernel.org/all/20250530123527.GA30463@willie-the-truck/
> > > >
> > > > Although now when I read back that thread, it feels more so like my
> > > > incompetency to convince :) because:
> > >
> > > No haha not so, I think more like this stuff is fiddly.
> >
> > Yup, not disputing that this is hard to get right.
> >
> > Conceptually, adding locking purely to deal with a vanishingly rare,
> > debug reader does turn my head but I'm _far_ less concerned about it if
> > it's done in the core code, as is the case here. x86 needs it and we're
> > recently running into related locking issues with the set_memory_*()
> > APIs if we want to collapse the page-table on arm64 [1]. If the overhead
> > is flagged as an issue, we can see if it's worth generalising the static
> > key trick that the second patch reverts but I definitely wouldn't start
> > from that position.

Yeah I think my solution is not exactly pretty but it's the best fix as a hotfix
thing _right now_.

As Kiryl points out the nicer long-term solution would be RCU freeing, but I
think that's the wrong solution for a _fix_ right now, rather something to look
at as a larger structural change in the future.

>
> I'd say it's worth generalizing the set_memory APIs ;-)
>
> Since it's de-facto machinery for manipulation of the kernel page tables it
> makes sense to have a common code for page table walks with hooks to
> architectures for checking/setting/clearing protection bits.
>
> Coincidentally, I'm working on a POC that lifts x86's CPA into mm/ with
> the intention to later use it on other architectures.

Lovely :)

There's another issue with CPA too (planned to raise this separately already but
been super busy/distracted lately :) - it doesn't actually mark its page tables
as kernel page tables so we actually have a gap if an IOMMU happens to map that.

I am planning to send a patch for that anyway but it's indicative of this
needing to be shared code, and lifting stuff up to be shared is good in general
:)

>
> > Will
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/799181c3-a1a1-4de7-bc6a-576d3282efb0@arm.com/
>
> --
> Sincerely yours,
> Mike.

Cheers, Lorenzo
