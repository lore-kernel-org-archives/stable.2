Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04443F39E2;
	Thu, 16 Jul 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195705; cv=none; b=uV3jOhKpWVmEv8dTSjyMLhrsGoejCGVLBI2Ihk1/EOT/NYrcxPXkIGs2/cuh7PNllJuY167PcHFEj6EwUQ6PToFcDLJCl5G4+QSOlu28jWKLIvmSoVLV3/2obAg89GS0rewrA5Q8i819OE2v4o65pfSuM2UcSf5q9aZJMxrkE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195705; c=relaxed/simple;
	bh=a3CCqUij9CeairDpkpveB5vWdZj6OHQzdpzaVSurYpQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ONp/TVdql3Jo1qo8HeAOmycNyzDOvPKR/aPJ+f80yPPIYJshY54DTnDSvwUwq0G+ua8EojRlFW/Klurb5MpyhOtoPZvf5QKjRG4R8iYHuzTap8IjvwXltTNe62JrpZXpi/yl68dEZmcjmOC99YuwBodibuwRpCr4hxtemZns5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox/bS8GO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox/bS8GO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9905A1F000E9;
	Thu, 16 Jul 2026 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784195702;
	bh=0/SyxMPIaPUuP8evJ5FrQ+d3a/rGOBD7f2mYFAW4BZY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ox/bS8GOAiz3ddOEb5s6tXfBT47YKSkPHImeTD5McWUIQJirA93UP+YdQ+CCxYrK2
	 XadnBH1n9BEZu6pLviso5nDeoDyb5gOcCHLglh0iALbqqZIJtRIXhjeom4dIyqFJ/y
	 lXBichlZN0LXLt4LEVvE03cOWN2fcl+R6f2M6pvJpiXppA9EjknjVsmlbEfngNR8YR
	 p3GPYWk11s9QCNhy6RyoZ0mxvIYPsRbrdczK9NJJ1XeUHWBjKGIt8nfaBNo6wM6T+T
	 YCBfEGG+CUxhcq/+psTJ5H3Nc0rnt60cd8gRWf1EdOLExy4mkNiuxOEimRxbP3sPXz
	 k8iCp344bixkg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mm-hotfixes v3 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Kiryl Shutsemau <kas@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
In-Reply-To: <20260715121452.3e8047663eeaaa3048f80985@linux-foundation.org>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-1-b812eccfa0f9@kernel.org>
 <aldhVdwj9oMRN1Lk@thinkstation>
 <178412496800.59347.11482869717348078349.b4-reply@b4>
 <20260715121452.3e8047663eeaaa3048f80985@linux-foundation.org>
Date: Thu, 16 Jul 2026 10:54:42 +0100
Message-Id: <178419568212.59347.281101439296944826.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3870; i=ljs@kernel.org;
 h=from:subject:message-id; bh=a3CCqUij9CeairDpkpveB5vWdZj6OHQzdpzaVSurYpQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIiViXLzvfdvWpHXm8JowZLd/gCGQaViuLTDDPKU/ksu
 sW/7D/XUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIvsZWSYO3PrIh6mG7LObzIv
 HPh0fdN9HnOOArWtLj9q3VIWL7rTwMhwm88zw6rY416zv/DxR1f+PW27sGV/znlhyxOv5CXOWpW
 xAgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

On 2026-07-15 12:14 -0700, Andrew Morton wrote:
> On Wed, 15 Jul 2026 15:16:08 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > On 2026-07-15 11:34 +0100, Kiryl Shutsemau wrote:
> > > On Tue, Jul 14, 2026 at 06:24:23PM +0100, Lorenzo Stoakes wrote:
> > > > Currently there is a nasty race between ptdump and vmap when attempting to
> > > > map a huge P4D, PMD or PUD entry:
> > >
> > > Nit: that's a strange order of levels :P
> >
> > Ha, seems I couldn't decide on ordering so went with something random :P
> >
> > Let's try 'P4D, PUD or PMD' instead :))
> >
> > >
> > > > Fix this by holding the mmap read lock in vmap_try_huge_*() when freeing
> > > > page tables.
> > >
> > > How about adding here something like:
> > >
> > >   The read lock is sufficient: ptdump is the only walker that must be
> > >   excluded and it holds the mmap write lock. Other holders of the read
> > >   lock may run concurrently, but each exclusively owns the range it
> > >   operates on and cannot reach the page tables freed here.
> >
> > You mean maybe I put the commit message on _too_ much of a diet? :)
> >
> > Yeah sure, sounds good.
>
> I made this changelog alteration:
>
> --- a/txt/mm-vmalloc-acquire-init_mm-lock-on-huge-vmap-to-avoid-ptdump-uaf.txt
> +++ b/txt/mm-vmalloc-acquire-init_mm-lock-on-huge-vmap-to-avoid-ptdump-uaf.txt
> @@ -103,6 +103,11 @@ walk_page_range_debug(), vmap takes no relevant locks at all.
>  Fix this by holding the mmap read lock in vmap_try_huge_*() when freeing
>  page tables.
>
> +The read lock is sufficient: ptdump is the only walker that must be
> +excluded and it holds the mmap write lock.  Other holders of the read lock
> +may run concurrently, but each exclusively owns the range it operates on
> +and cannot reach the page tables freed here.
> +
>  We also hold the lock while assigning the huge page table entry, which
>  means page table walkers observe only the huge or non-huge page table
>  entry.

Perfect, thanks!

>
> > >
> > > > +	/*
> > > > +	 * Kernel page table walkers either walk ranges they own exclusively or
> > > > +	 * hold the mmap write lock on init_mm (ptdump being the motivating
> > > > +	 * case).
> > > > +	 *
> > > > +	 * Therefore, acquire the mmap read lock to prevent use-after-free when
> > > > +	 * freeing page tables.
> > > > +	 */
> > >
> > > Same for the comment, maybe:
> > >
> > >       /*
> > >        * Acquire the mmap read lock to exclude ptdump, which walks
> > >        * kernel page tables it does not own under the mmap write lock.
> > +	 *
> > >        * Concurrent read lock holders are safe: each exclusively owns
> > >        * the range it operates on and cannot reach this page table.
> > >        */
> >
> > Yeah that's better agreed.
> >
> > Let's replace it, but I think (being super nitty) with an extra blank line as
> > above.
>
> This?
>
> --- a/mm/vmalloc.c~mm-vmalloc-acquire-init_mm-lock-on-huge-vmap-to-avoid-ptdump-uaf-fix
> +++ a/mm/vmalloc.c
> @@ -163,12 +163,11 @@ static int vmap_try_huge_pmd(pmd_t *pmd,
>  		return pmd_set_huge(pmd, phys_addr, prot);
>
>  	/*
> -	 * Kernel page table walkers either walk ranges they own exclusively or
> -	 * hold the mmap write lock on init_mm (ptdump being the motivating
> -	 * case).
> +	 * Acquire the mmap read lock to exclude ptdump, which walks kernel
> +	 * page tables it does not own under the mmap write lock.
>  	 *
> -	 * Therefore, acquire the mmap read lock to prevent use-after-free when
> -	 * freeing page tables.
> +	 * Concurrent read lock holders are safe: each exclusively owns the
> +	 * range it operates on and cannot reach this page table.
>  	 */

Yes that's great thanks!

>  #ifndef CONFIG_ARM64
>  	scoped_cond_guard(mmap_read_lock_try, return 0, &init_mm)
> _
>
>
>

Cheers, Lorenzo

