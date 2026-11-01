Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793507109;
	b=37KKCPP6qzyS9LV445+bHlt1O2rdw6gMb7aBi3taQNmEplRZPtuu0WF9+hE9cXweDxQz
	 mnAubKt2fxO5GnBp4qg4P0L46eC3Udps0+TYPK+y503r2dcZwPW/BS8IqJ5OWBwMmQk0E
	 LXWTZWimwHTA7BXtKqPvikAP1GIgT3jYyLEr0DtHtjXFy70EjPH+1RMe7m8l+VslsRASc
	 NJSMIllVAIQHM2b5lRZvR2BolSZKCZuUHccwgPRky/9mLZbL465O16tI9buYiFKgqbgLI
	 x3nakRpoIiVqWAdv2VcS8EDEGQOJ1UEH32ZnGUvI6OyurCnwsB2J4Vp3ahue41TXsBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793507109;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AaJPl9a9qhxWoN0NnjUzfzvyBJovsF7rWwGHYOTv9cA=;
	b=v3P1qpM8LLi0qnWuiy2F/Nd3zflUA01CDNSO+zpc7ffDPZQyfkZpi/irR0e1VWFsAia0
	 b4Wqz80zdeaFZ11DgtrXiiWHN60asVOcd1AET1iopIQdtKt/wVwP21FQC25rnubU86Ow9
	 lRWFqFifIT5+8PRy0XM0cREzXsCbMcCEROW9BOiUz7etAYGLpha+c1ch5+NU9KxJtuxRZ
	 dNAMZJyhjp7oxOqfisOupOjc8Un2BmLIEd3Y5oU4elO5pkuKsQwDTcUsB9fUCBXvZh0+s
	 PdZBKHmiwc6PuiHVYsImOuv4orvHG/yKTbZEVRgSg5AgJZqxKChoEnJXlEWdovV4Nww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b="XPTW/R/H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B6606A324;
	Sun,  1 Nov 2026 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=XPTW/R/H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9C91F000C1;
	Sun,  1 Nov 2026 04:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793507108;
	bh=AaJPl9a9qhxWoN0NnjUzfzvyBJovsF7rWwGHYOTv9cA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XPTW/R/HdyZBfz+1MYvVMhTd7exeqadSGQnqrCnmq3Bk1dfSl/sDytOqoQpiSmGMV
	 w6UIZQnaIrYx5uviPDZFwtdPCywav27UzXlhJdvtV+A/BkrEMrMOa1hjuO168/CGxh
	 i+gq4WFy6pDFSKYdAEfeJYecWAOdsknlcn3kHk34=
Date: Sat, 31 Oct 2026 21:25:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Hildenbrand
 <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard
 <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Chris Mason
 <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/gup: check folio->mapping under folio lock in
 memfd_pin_folios()
Message-Id: <20261031212507.31609e7ed27de35253b226c3@linux-foundation.org>
In-Reply-To: <CALCETrU76ThzLDbUfpoota5=xcoOS4aZrwgK2B3ELkYcFOjGJQ@mail.gmail.com>
References: <20261031203540.2282507-1-skhawaja@google.com>
	<20261031194058.d3bd25ed950e5340ab595f07@linux-foundation.org>
	<CALCETrU76ThzLDbUfpoota5=xcoOS4aZrwgK2B3ELkYcFOjGJQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 31 Oct 2026 20:20:03 -0700 Andy Lutomirski <luto@amacapital.net> wrote:

> On Sat, Oct 31, 2026 at 7:40 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Sat, 31 Oct 2026 20:35:40 +0000 Samiullah Khawaja <skhawaja@google.com> wrote:
> >
> > > memfd_pin_folios() pins folios from the page cache without taking the
> > > folio lock. So khugepaged or MADV_COLLAPSE can replace the folio after
> > > its refcount check while memfd_pin_folios() still pins the old folio,
> > > and the caller ends up with a folio that is no longer part of the memfd.
> > >
> > > Lock the folio and recheck folio->mapping before pinning it, like other
> > > page cache users do. If the folio was removed, retry the folio lookup
> > > from the index that was removed.
> >
> > Can we please include a clear description of the userspace-visible
> > runtime effects of the bug?
> 
> It's straight-up data corruption if you manage to trigger it, no?  If
> you manage to race a memfd_pin_folios() against collapse,
> memfd_pin_folios() will pin the wrong folio.
> 
> Fortunately, there are a whopping three callers in the whole tree.
> You can hit it from udmabuf or iommufd or memfd LUO.
> 
> The former two will direct DMA to the wrong folio.  Fortunately it's
> not UAF as the DMA will be directed to a folio that is still pinned,
> but it's the wrong one.  DMA reads will read potentially stale data
> and DMA writes will overwrite that stale data but not update the live
> copy.  (The DMA will not be directed to some other application's
> memory, just to a leftover copy of the calling application's memory.)
> 
> As far as I know, the effect with LUO would be for stale data to
> reappear in the memfd after handover.  With the patchset that started
> this whole discussion applied, I think it might result in misdirected
> DMA to freed memory (I do not stand by that claim at all), but that
> patchset is not applied.

Thanks.  How's this for a changelog?

: memfd_pin_folios() pins folios from the page cache without taking the
: folio lock. khugepaged or MADV_COLLAPSE can therefore replace a folio
: after checking its refcount while memfd_pin_folios() still pins the old
: folio. The caller then receives a folio which is no longer part of the
: memfd.
: 
: For udmabuf and iommufd, this can cause data corruption: DMA accesses
: the detached folio rather than the live memfd contents. DMA reads can
: return stale data, while DMA writes update the detached copy and are
: lost from the live memfd. The detached folio remains pinned, so these
: accesses do not constitute a use-after-free or target another
: application's memory. For memfd live update, the stale contents can
: reappear in the memfd after handover.
: 
: Lock the folio and recheck folio->mapping before pinning it, like other
: page cache users do. If the folio was removed, retry the folio lookup
: from the index that was removed.

Samiullah's patch assumes the presence of Chris Mason's "mm/gup: fix
clearing folios in memfd_pin_folios()" which is in mm-next, so... 
->David

