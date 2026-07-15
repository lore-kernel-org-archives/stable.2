Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2743990C;
	Wed, 15 Jul 2026 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142900; cv=none; b=QKifNezgJ/dpgn/RVs368AdgWJ6BQviOONVyuNhXjgZiZJ1PbZYzEj1sv6Rpy3Ec22w8WVjLzHbLQdBoZRIpjn1lBTB20Ihui6f1ych5lj6Gu9W/blM6j8USIyKRCJpOfHk6Qd7Grmm0PFrlsgedc7OTRUrLYIAkipKuQn2hNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142900; c=relaxed/simple;
	bh=BitMsdpYlmRsQ+WtZPj/BVpz8gGVy0hDB0gnkgD3yus=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tdrgYshVQnjSHkuX9BYlKHHLOQMMPGJLhPSEsfW+Rdx78/AySJwv7+EW/J5v/PdEnOYdItNinv0WnCqpzT/8z5FLfgLcd80cHBUGy1r3xndBzbXgjhysNmxRZ9kmQjliL4PVET0angoArlAn5jW9AfuO7RjIQ1oKjVt9G52LrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wM3fu0hQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wM3fu0hQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D151F00ADB;
	Wed, 15 Jul 2026 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784142893;
	bh=ViHw0i/Ol3YgTRIw9C4EDJ0sBKCT3F9/+wZKL98nwYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=wM3fu0hQUE2ZXeszCzbkXLBbR0dCG5bwf0UQtBQA7nGKj9H0vkzsdRCLcRDBHDRvl
	 oW/UCFp1zjFYwiluqA8Anl7AliHSWpMayahnYCHmlv73JUX7cea0fqZAmvYU/9P40A
	 C3SsVY8UUbuFctRY81KY8OGqMm6+JX0KWy6eVf38=
Date: Wed, 15 Jul 2026 12:14:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, David
 Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal
 Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>, Toshi Kani
 <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain
 <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, David Carlier
 <devnexen@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v3 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
Message-Id: <20260715121452.3e8047663eeaaa3048f80985@linux-foundation.org>
In-Reply-To: <178412496800.59347.11482869717348078349.b4-reply@b4>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
	<20260714-series-vmap-race-fix-v3-1-b812eccfa0f9@kernel.org>
	<aldhVdwj9oMRN1Lk@thinkstation>
	<178412496800.59347.11482869717348078349.b4-reply@b4>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 15:16:08 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> On 2026-07-15 11:34 +0100, Kiryl Shutsemau wrote:
> > On Tue, Jul 14, 2026 at 06:24:23PM +0100, Lorenzo Stoakes wrote:
> > > Currently there is a nasty race between ptdump and vmap when attempting to
> > > map a huge P4D, PMD or PUD entry:
> >
> > Nit: that's a strange order of levels :P
> 
> Ha, seems I couldn't decide on ordering so went with something random :P
> 
> Let's try 'P4D, PUD or PMD' instead :))
> 
> >
> > > Fix this by holding the mmap read lock in vmap_try_huge_*() when freeing
> > > page tables.
> >
> > How about adding here something like:
> >
> >   The read lock is sufficient: ptdump is the only walker that must be
> >   excluded and it holds the mmap write lock. Other holders of the read
> >   lock may run concurrently, but each exclusively owns the range it
> >   operates on and cannot reach the page tables freed here.
> 
> You mean maybe I put the commit message on _too_ much of a diet? :)
> 
> Yeah sure, sounds good.

I made this changelog alteration:

--- a/txt/mm-vmalloc-acquire-init_mm-lock-on-huge-vmap-to-avoid-ptdump-uaf.txt
+++ b/txt/mm-vmalloc-acquire-init_mm-lock-on-huge-vmap-to-avoid-ptdump-uaf.txt
@@ -103,6 +103,11 @@ walk_page_range_debug(), vmap takes no relevant locks at all.
 Fix this by holding the mmap read lock in vmap_try_huge_*() when freeing
 page tables.
 
+The read lock is sufficient: ptdump is the only walker that must be
+excluded and it holds the mmap write lock.  Other holders of the read lock
+may run concurrently, but each exclusively owns the range it operates on
+and cannot reach the page tables freed here.
+
 We also hold the lock while assigning the huge page table entry, which
 means page table walkers observe only the huge or non-huge page table
 entry.

> >
> > > +	/*
> > > +	 * Kernel page table walkers either walk ranges they own exclusively or
> > > +	 * hold the mmap write lock on init_mm (ptdump being the motivating
> > > +	 * case).
> > > +	 *
> > > +	 * Therefore, acquire the mmap read lock to prevent use-after-free when
> > > +	 * freeing page tables.
> > > +	 */
> >
> > Same for the comment, maybe:
> >
> >       /*
> >        * Acquire the mmap read lock to exclude ptdump, which walks
> >        * kernel page tables it does not own under the mmap write lock.
> +	 *
> >        * Concurrent read lock holders are safe: each exclusively owns
> >        * the range it operates on and cannot reach this page table.
> >        */
> 
> Yeah that's better agreed.
> 
> Let's replace it, but I think (being super nitty) with an extra blank line as
> above.

This?

--- a/mm/vmalloc.c~mm-vmalloc-acquire-init_mm-lock-on-huge-vmap-to-avoid-ptdump-uaf-fix
+++ a/mm/vmalloc.c
@@ -163,12 +163,11 @@ static int vmap_try_huge_pmd(pmd_t *pmd,
 		return pmd_set_huge(pmd, phys_addr, prot);
 
 	/*
-	 * Kernel page table walkers either walk ranges they own exclusively or
-	 * hold the mmap write lock on init_mm (ptdump being the motivating
-	 * case).
+	 * Acquire the mmap read lock to exclude ptdump, which walks kernel
+	 * page tables it does not own under the mmap write lock.
 	 *
-	 * Therefore, acquire the mmap read lock to prevent use-after-free when
-	 * freeing page tables.
+	 * Concurrent read lock holders are safe: each exclusively owns the
+	 * range it operates on and cannot reach this page table.
 	 */
 #ifndef CONFIG_ARM64
 	scoped_cond_guard(mmap_read_lock_try, return 0, &init_mm)
_


