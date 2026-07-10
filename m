Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519C426D29;
	Fri, 10 Jul 2026 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684693; cv=none; b=iNAa3py5ckp5GZrnHAuXn2V/vWBoqDqhnLaQ69Iw3FykoRDJ/idA7zNGz5dV6u+Ig+YovkveMpkUKW905OyO1bevcJV6r5MaqKC8UeTRQ3ZU0Fohmc22R+AwLWH9qQLHckUY3BCS5f75ps3j/iIC2BPt9ZD8uoVxkWLWiS11lZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684693; c=relaxed/simple;
	bh=hKciZm915bJYzdl/DFU0eneGXBw6w/af0wOeuPei2iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egy3Ccy3lCenbquazmAgF7OXJ9ADKDttgARKNN++OYMBwgjlZZLVy2K/yFJA4FO9xot6vP0ZNFqdBKnd/LCHoJLGOXkB3l23lE7T2390FaE1cX85gSIiejMxMVdFaXoxvNVeI4A448VhIt55yLSzLYW+f3iv8dBtSUmrrFz0v7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAkxgwXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAkxgwXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF991F000E9;
	Fri, 10 Jul 2026 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783684690;
	bh=kDw4uHkrjrH2i/wDdxHnoRQvhH62dpRg5r0nrYMHl8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dAkxgwXT/R1DI7L+qLyNgdOAeakrAm08Pe6X6aqix0XakuDCSCOZnAqHQ2gRE0t9F
	 h3ZdKHfNDjgo97EBH/Aqec4PzZNwGJAd3zSq1wv6qKfoBcrGvys9ohsuamv/yuQqtL
	 IHh+n7NktbReynKyVPSjKL7zpmcAmDyw3Vf6MtiYXyeievv5tNFZ1ESTOMO9THH8mq
	 bs9g9tjQUWl554Yh5sw1nzgLe/RZ8R/BLPik3sr+gTdFfU/iUatq8IkUVk6xz7c95S
	 U7/08M6TK1ft8TrJ3DhiH4nyvc/SsXkVo/NzMdILO0bGEILpZKpcB4RJSfIJZox+Co
	 auVbqGEDaiSRw==
Date: Fri, 10 Jul 2026 12:57:56 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: David CARLIER <devnexen@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
Message-ID: <alDeMJZdhbKfS023@lucifer>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <CA+XhMqwpDGYSQvDKrFz9XuQFiaz8_rgW0LupEzFhehSrFvUZaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqwpDGYSQvDKrFz9XuQFiaz8_rgW0LupEzFhehSrFvUZaw@mail.gmail.com>

On Fri, Jul 10, 2026 at 12:44:20PM +0100, David CARLIER wrote:
> Hi Lorenzo,
>
> On Fri, 10 Jul 2026 at 11:50, Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > Kernel page table walkers fall into two broad categories - those ranges
> > where no exclusion is required via walk_kernel_page_table_range_lockless()
> > and those where exclusion is required via walk_kernel_page_table_range()
> > or walk_page_range_debug().
> >
> > The former category is used only by arm64 arch code operating on ranges it
> > both wholly owns and does not concurrently write.
> >
> > The latter category consists of kernel page table walkers operating on
> > ranges that are wholly owned (but which need exclusion against concurrent
> > writers).
> >
> > The lock used for exclusion is the mmap lock, and for kernel ranges this
> > the mmap lock on init_mm.
> >
> > ptdump is a special case being both the only user of
> > walk_page_range_debug(), and the only case in which it walks ranges it does
> > not own.
> >
> > This presents a problem, as page tables may be freed under ptdump. And
> > indeed there is a use-after-free bug in the kernel as a result, which this
> > series addresses.
> >
> > vmap promotes page tables to huge leaf entries where possible, freeing the
> > lower leaf page table when it does. It does this with no meaningful locks
> > held against concurrent ptdump walks.
> >
> > As a result, use-after-free can currently occur. This series addresses the
> > issue by having the vmap huge promotion logic acquire the mmap read lock
> > while both setting the huge page table entry and freeing the prior leaf
> > page table.
> >
> > The ptdump code already acquires the mmap write lock, so by doing so we
> > ensure that the ptdump walker only ever observes either the huge page table
> > entry or the existing page table entry, and nothing is freed underneath it.
> >
> > A mitigation for this issue was already applied for arm64 in commit
> > a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), which this series
>
> seems it should be fa93b45fd397.

Yeah oops, I typo'd that.

Andrew - could you fix that up for me? Thanks!

>
> Cheers.
> > has to deal with carefully.
> >
> > This mitigation resolves the issue by acquiring the mmap read lock on
> > init_mm on vmap page table free if a ptdump is in progress.
> >
> > However the fix in this series would cause a deadlock if we were to simply
> > apply it for arm64 without also reverting the change.
> >
> > This is because vmap may acquire the read lock before ptdump attempts to
> > acquire the write lock, which then gets queued, and rwsem starvation rules
> > mean that the (unacknowledged) nested mmap read lock in the arm64 code
> > would also block, meaning the original read lock is never released and thus
> > deadlock.
> >
> > This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> > lock in vmap logic, then partially reverting commit
> > a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), keeping the
> > enablement of huge vmap support, and removing the ifdeffery with the
> > partial revert patch.
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> > Lorenzo Stoakes (2):
> >       mm/vmalloc: acquire init_mm read lock on huge vmap promotion
> >       Revert "arm64: Enable vmalloc-huge with ptdump"
> >
> >  arch/arm64/include/asm/ptdump.h |  2 --
> >  arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
> >  arch/arm64/mm/ptdump.c          | 11 ++---------
> >  include/linux/mmap_lock.h       |  1 +
> >  mm/pagewalk.c                   | 22 +++++++++++----------
> >  mm/vmalloc.c                    | 41 ++++++++++++++++++++++++++++++---------
> >  6 files changed, 51 insertions(+), 69 deletions(-)
> > ---
> > base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
> > change-id: 20260710-series-vmap-race-fix-2a4cac988938
> >
> > Cheers,
> > --
> > Lorenzo Stoakes <ljs@kernel.org>
> >
