Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3C501F3F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897472; cv=none; b=GWVKZq10IA2aII+B/tDcrN/vyRhpBIpjKCWSvscLdlznuTYZLG1NuPU1RZfglB2Z2yzV8EkMYwsuP+Uk/z9VkbnuqysfvIOSP7jG2HKO5exFeXhMxwB6hJ+k7b2dxVLIERYpz6uuESsSxMJUqOXq+5OeHkolgW9JYiCfHLg7yIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897472; c=relaxed/simple;
	bh=u7P34VXTVrZeRHCTgOSJ39iptX9DGQzvBLDeL4ULINw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwmcDWSyg0U6KTSGeJaq+vvu549lI6MdQTXnTvbasp7hn308lcNq93n5IbNLHobdq88suUOrFpCwRqCcJLAsyo/4J3ergu9b/voSGxdOdUZN45RkTEtsllh2hKUkZUTT3Hiaks8AfaR9eHG346DyZhTw/ZPup0EblavHaIXc2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0JfCusr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0JfCusr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3CE1F000FF
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897471;
	bh=IPrWbjd6nlCGQgcl4vkfUhJWd2/tw6kriYkWa0oA5aA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i0JfCusrums781dzuimaRkDiw69YSLDenNcPkMtStbdprggrX8A0gZmpFPim6Kx3r
	 nyWF5cYYX3aiwI2UJ5hpkmXW2KRzNQ+StdA7uf1L2Zh8GgxpMWjzZQHkWxcYajVV7g
	 9vuvFCLqItpCWOSFPxBXdw/fqbRRC5N/OGYBIeRJpAM//sSzhSc4CCiQywUwI36qNI
	 YRdTVuWG+BQHpWsu5r+yQqP54nZlVAzUR4wzfS4A7shpCmGLkiBfU78RNy8iNa1sci
	 giCVODBBZe371VXgAk+qdMIByl2x0sKuxXfwi7OJxsA8zl+cky6p4G+ajlioLl1846
	 ysGRiJEjz7cSw==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso30765816d6.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:17:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzJ3A0x2tHfomhNjvTtYLQUj89dILiVskZiK0EHGnTVVSMTelNIqZ4zF4hYujFwPurtc9NbizQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs4kc+r3SbCMpBxVlBCW0ve+S8RUV/5c5pXEKvcrGVKyW5wtFd
	lZffyVW53BmKpl5dIcBz+HY+k09lnoc2RD7NlkRLZ3UYS/UOuHmEGzak8TFFGYuVSmB1NWA47Fj
	I7gXmZNb4Rrz7y1LtmrM3SJsNqAm7ZLE=
X-Received: by 2002:a05:620a:6487:b0:93e:4c1b:a06d with SMTP id
 af79cd13be357-93ebd1bac2bmr2200083985a.20.1791897470973; Tue, 13 Oct 2026
 06:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org> <as4qKLx_XwQ6qY3p@thinkstation>
In-Reply-To: <as4qKLx_XwQ6qY3p@thinkstation>
From: Barry Song <baohua@kernel.org>
Date: Tue, 13 Oct 2026 21:17:19 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y5j+p0-VdEzpnS-Q31vhvBZRa96VJtA6+HyNj=+r+Ufg@mail.gmail.com>
X-Gm-Features: AclHuK9MQ_S043rSI_HtPCWrZsAEX4W_aIKduLBdZpTWuX0GQiW4Y22oKWiSD_0
Message-ID: <CAGsJ_4y5j+p0-VdEzpnS-Q31vhvBZRa96VJtA6+HyNj=+r+Ufg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ying Huang <huang.ying.caritas@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:57=E2=80=AFPM Kiryl Shutsemau <kas@kernel.org> wr=
ote:
>
> On Tue, Oct 13, 2026 at 02:30:37PM +0200, David Hildenbrand (Arm) wrote:
> > numa_rebuild_large_mapping() and do_swap_page() can be tricked into
> > generating an address wraparound, crashing the kernel. All that's requi=
red
> > is to map a tail page of a large folio close enough to the start/end of
> > the address space to e.g., make
> >
> >       unsigned long addr_start =3D addr - (nr << PAGE_SHIFT);
> >
> > to wrap around.
> >
> > Let's fix it by providing a better helper, folio_pte_scan_range(), that
> > takes care of staying within VMA and page table boundaries while
> > handling possible wraparounds.
> >
> > Reported-by: Kyle Zeng <kylebot@openai.com>
> > Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
> > Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swap=
cache")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
> >  mm/memory.c | 43 +++++++++++++++++++++++++++++--------------
> >  1 file changed, 29 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 1f5d5f7d39cd2..a3823010aa981 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4933,6 +4933,27 @@ static void check_swap_exclusive(struct folio *f=
olio, swp_entry_t entry,
> >       } while (--nr_pages);
> >  }
> >
> > +/*
> > + * Get the address range in which a folio might be mapped, assuming it=
s pages
> > + * are mapped consecutively and the folio page at the given idx is map=
ped at
> > + * the given address.
> > + */
> > +static void folio_pte_scan_range(const struct folio *folio,
> > +             const struct vm_area_struct *vma, unsigned long addr,
> > +             unsigned long idx, unsigned long *start, unsigned long *e=
nd)
> > +{
> > +     /* Stay within the page table and VMA boundaries. */
> > +     const unsigned long pmd_start =3D addr & PMD_MASK;
> > +     const unsigned long pmd_end =3D pmd_start + PMD_SIZE;
> > +     const unsigned long lower =3D max(pmd_start, vma->vm_start);
> > +     const unsigned long upper =3D min(pmd_end - 1, vma->vm_end - 1) +=
 1;
>
> These -1/+1 gave me a pause. I guess it is for pmd_end wrapping to 0 in
> the top PMD? A comment would be nice.

Will pmd_addr_end() make it better? I mean

upper =3D pmd_addr_end(address, vma->vm_end);

nop?

Thanks
Barry
