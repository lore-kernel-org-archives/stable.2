Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5B372EDE
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809935; cv=none; b=VkAOVMoWNoagFF+sKVHlOKaWMkTXXNEbPH+cIPTfdaEugWrG/0e6uRqYicZveDguZkd98/LZq6lni0AeAd3hQX5p2uVUFRhEfklYAX8kI3tZwIBngUEyYXU5aw7Y5CZknhA9UXhVPIoiXFUrtRJFmEKxuvyg1ujXCioiagajymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809935; c=relaxed/simple;
	bh=pf6zTKGCUG2r/SDqwRlXEi/NTcBnp7QXAChz7BaPvrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePGqlCk7lFuhJvexkp4xv6Ha/Bv4TTZMk6EXE7UrmYUpc8ZMXh0HMit4i2H33SIxHkvAx3fqEE2RoNXy3DbBFJXWgBxpuz3LJK3LEY8VDwwISOM1D0ZmzeF3kMu1dLZbhagRjCwPQOwvReeBJc6OrrV0FZ0MLpN3QiG16ECH2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrgEMC1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrgEMC1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBA01F00A3D
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 02:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785809934;
	bh=fBGKAE05xJKKiYIOYKeypVavHcHnoSNrfvRL+QYpZOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RrgEMC1EMnhNXw99Hbu6DsDJlmu5Y3X8F1ErJMke0IA4B3r7HoShqkBJTWgR6BhVV
	 k8dmPyKBZC3Y84e6tayzMvxsd/EiCGxy5KzWW/XEc+TghWcx/zXVY8OxV8KiUvcnFC
	 2qEhQQxnYvw9Iv3OH4NFiqq38L/6zZ5lHacse2M1tMAGzcuF31iU7BUJsmqBi/MEtX
	 u6AFtCX2bXTvpNOILRJm/91Yj7CCqzQfbpA6fVyjCOY2i3g01vkWjJEX20V8UsDR+M
	 OT2YTbWTAienRaw9oaexc0S5+BaYLSNsAqU4g7tvY11GWETaRHRNFdIxmOJOdRornY
	 KKefdeEEAwXdQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so2228941fa.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 19:18:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrRMommZbBvRtNir8n4gYWDwfdHwpMwK03DsYBbeF2CGFe7wee6JL2ohv051AvXsjUmnd8TdQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxriA+qeGpVARBTG46bGdj4znsPUyop66JJ1dt0YQ0Zyl9F4bOv
	0V0Ehc9WmdzhIn4iNjeR7plG431MYCnBCjtrYJgFyh4A/GBdm5p4x1u1opQZ/2ll0PcPQE/1h18
	G5xlPIGYl5EV8g9mGnfZDQxWIc32eGvPokkw+9MDI
X-Received: by 2002:a2e:a88a:0:b0:39c:828a:ec28 with SMTP id
 38308e7fff4ca-39f864562a9mr27536451fa.31.1785809932740; Mon, 03 Aug 2026
 19:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804003708.49830-1-luto@kernel.org> <20260803183032.7cc1fb1007d309c2431855ea@linux-foundation.org>
In-Reply-To: <20260803183032.7cc1fb1007d309c2431855ea@linux-foundation.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 3 Aug 2026 19:18:40 -0700
X-Gmail-Original-Message-ID: <CALCETrVxtFyMoOrpTckrs3HU7evczytau0fGgyCWidt4oFS=CQ@mail.gmail.com>
X-Gm-Features: AUfX_mz1zN5nkOVZ7C7UnstYQ8n2S9i8_HR-owWrYtZZxw5U9nyHOpOlZpXyzv8
Message-ID: <CALCETrVxtFyMoOrpTckrs3HU7evczytau0fGgyCWidt4oFS=CQ@mail.gmail.com>
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
To: Andrew Morton <akpm@linux-foundation.org>
Cc: luto@kernel.org, linux-mm@kvack.org, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org, 
	dfoxfranke@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:30=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Mon,  3 Aug 2026 17:37:08 -0700 luto@kernel.org wrote:
>
> > From: Andy Lutomirski <luto@kernel.org>
> >
> > When zap_pte_range reclaims a page table, it does:
> >
> >     pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
> >
> > and this is unconditionally wrong: if this code executes, addr *always*
> > points one past the end of the range covered by the table.  The addr
> > parameter is used to flush the TLB (really the paging-structure-cache)
> > to drop references to the to-be-freed table, and any architecture that
> > cares about the parameter will flush the wrong address.  (But they'll
> > still free the correct page).
> >
> > I think it's worth contemplating why the kernel works at all.
> >
> > If we hit the offending line of code, we will first clear the PMD entry
> > (line 1954, zap_empty_pte_table), then we will issue pending flushes if
> > force_flush is set (tlb_flush_mmu_tlbonly(tlb)), then we will skip the
> > retry on line 1979 (phew!), and then we will do the offending
> > pte_free_tlb call.  *Or* we will clear the PMD entry immediately before
> > pte_free_tlb (line 1983, zap_pte_table_if_empty).
> >
> > If we have any pending flushes (i.e. we actually zapped any last-level
> > entries) at the time we clear the PMD entry, then the flush really ough=
t
> > to flush all references to the table (Linus certainly seems to think it
> > will on all architectures [0]).
> >
> > The condition under which we have no accumulated flushes at the time of
> > the clear is very complex (the whole zap_pte_range function has absurdl=
y
> > complex control flow).  If we do hit the bad case, then we will end up
> > clearing the PMD entry after the last time the range is flushed, and an=
y
> > CPU is free to cache a reference to the (empty) page table.  If this
> > happens due to an ordinary read or write, it would segfault, so it woul=
d
> > be rare.  But the cache could be speculatively filled as well.  Then
> > we'll flush the wrong address and then free and possibly reuse the
> > table.
> >
> > On x86, even flushing the wrong address works on non-KPTI Intel systems
> > because INVLPG flushes *all* paging-structure-caches, not just the ones
> > for the target address.  But INVPCID does not, and flush_tlb_one_user
> > will use INVPCID if it's available.  And then we're toast.  AMD systems
> > are more susceptible: we set the EFER.TCE bit, which makes even INVLPG
> > only flush the target address.
> >
> > P.S. IMO zap_pte_range is a mess.  The control flow is excessively
> > complex.  The direct_reclaim variable itself has a confused meaning --
> > for the first part of the function it means, approximately, "we should
> > free the table if can_reclaim_pt".  But, later on, it means "we ALREADY
> > reclaimed the table".  And the goto retry on line 1979 is IMO just
> > asking for trouble if the condition ever changes such that it might
> > happen after clearing the PMD.
> >
> > I think this might fix an issue in ripgrep reported here:
> > https://github.com/BurntSushi/ripgrep/issues/3494
>
> Huh, cool.  Very recently I was scratching my head at Daniel's ripgrep
> report.  Upon which he obviously did a ton of work (many thanks).
>
>         https://github.com/dfoxfranke/ripgrep-3494-analysis

I'm pretty sure that's AI-generated.

>
> Daniel also pointed a finger at 4c640eb4181c ("mm: move pte table
> reclaim code to memory.c").
>
> The manifestation is that a tiny race window causes the zero page to
> magically appear where an anon page was expected.

The analysis says:

pagemap reports the page present, soft-dirty, with PFN 0 =E2=80=94 the
kernel's zero page.

ahem.  I would be quite surprised if pfn 0 is the zero page.

If whatever code the AI wrote that generated its trace is actually
correct and there was a PTE entry with pfn 0 and the present bit set,
then maybe we have a genuine race that corrupts a page table.  But the
analysis seems quite sloppy and I'm disinclined to trust it too much.
(A quick experiment suggests that even GPT-5.6-Sol high (which is
supposedly pretty good) will rapidly go off the rails if you ask it a
leading-in-the-wrong-direction question about the kernel.)

In any case, the original reporter was using an AMD system, and the
bug seems extremely sensitive to tiny details, both of which are
consistent with the possibility of a narrow page table caching bug
like this.  I'm frankly a bit amazed that he and his AI were able to
reproduce it as many times as they apparently did.  I wonder if the
specific offending assembly caused the CPU to somewhat reliably
speculatively fill the paging structure cache during the narrow window
after the last correct flush and before the PMD entry was cleared --
if so, this would be consistent with the AI's observation that even
tiny changes to the asm seemed to make the bug go away.

--Andy
