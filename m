Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C540372057
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163590; cv=pass; b=kpRUD9PYTdJ34sxsoHw0W4e5Pxp5hWAcgxDDnNPCQ7C4++ISdfDLFJIxh3ValEVxPxlcYZlMF7tRoxHHmNjvS7lJEGvF7upSt3KKnkv/3gyqASMiyVb9/iUYrsjWZ/YO8TGKD0NrY7lpStmfD0Trgi29k5RNeMUiU7pfQL96whQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163590; c=relaxed/simple;
	bh=NflH0Gfezb1XneHPVcE4Mia9bSbDbmEspl/+r5JrR50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqgbDOXBcae3HwePqdk9RQWoKoWE841Xa+SZU2QJGnuq8jh43gy37SPanBR71T1qD+lLmoQ5DJmRRTFWBTNZ4Dhq5/TZuOYKHiFkz4iQpB4Y+rPbnoHFzZa4vgHzdgSjRKY02+vX1XxSI5jYDoMsKEWu67iwfr/jUaeSmSI069M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QEbmW7J6; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEbmW7J6"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5ad2abf31aeso825e87.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782163584; cv=none;
        d=google.com; s=arc-20260327;
        b=h9Mg29juCpB6KYMUszxSzf6EeBvCzSGwygDk7iEm7lRFzcluzT2PBtiVG0ENN9UTpE
         cBqv7yB4TFgW0mqKMdxrpHQk9GhAdDy3Hhn/lLX7iiR/U24h4C1Xq0M5EcJ+172L4GWB
         ZH48GxesbQLXd+SakHNJchH7gqOURqWh2hASfCvjbjbkyd4m9zPOx8MxukIZMIZtuiPW
         rQwScGJ6z1h/jkx5O7ERJqW3nKkGmiuruL9uoTWdlmgbbXmQCLfy+XYNv9Pbzh9dWDOY
         fI4h6fJNuNcr8+FmJ4QuHUNpCqcJp0ZVOKGlJu2L+JJR43P/c+juxCCIVmyMS35rHUaY
         cyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ssE3TLUG/7J9ufeN9q/DrGgYY9Z2q4mT+HtG/803YCc=;
        fh=nE9CNcdjmND50bi+OVaedoRFQlTkNZII7g/poXkueis=;
        b=j9nXls5mFyz0idlRMmILl2HfQla1IuCEVtcosq3Tet8TyC5r5JWwRoY+PuKyylus0O
         Dr1I6KovKVQGPUTVPDDUchIzS8dHRLEtx5DlaBSxgPsKmKz+c8skUOLk3B+heAWluZJp
         A4+JKvvmubWW9eOLi3tXqKxvJGvhANzbFT1H3Vg6wa6SbxZzcmmFEHfgZNrR9XMgrxTb
         mYEWzTdf6KdTNwl7J/ArWeyon8GO4vrxqF74YMOSdvmlx/pX5IwGHv84p41iL74jwENc
         2fG3Ty+IEtble6srAMNeBjB9UjfsoSxjVFlg7l403mT/QWYH0kYQoSkQUA6a9E4v8ui1
         Xutg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782163584; x=1782768384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ssE3TLUG/7J9ufeN9q/DrGgYY9Z2q4mT+HtG/803YCc=;
        b=QEbmW7J6VqWb0VWbxpiT5WWeXJnmex/IKF43rVscjY7n6uPCabJqx7PiN3F6FiIytu
         uTxIX5zPXgx+EVcWSnf7J3a9hYWdKtEMi+ElZocEyqpmLWUS80w3qBGZmCikbwRLfMXD
         50ovAvDSr5JYGmBCx9f7tD4UX+Nb4dYwVhW4oh8zU8SztHkflRJhj78h4UvSeMFuznuB
         hdAB9tDwpYMkYSkWeATuG56s4fOk1IMRDKtQOUX6nrk3D7t15HjMzmeOn6YdZ9sHB21h
         AiFh05bLIWmQWgGsHFWbDkA+7OkdEIexoAB2QzPnD75gDC0RQ5ITGhfn/D6adKtaBa8H
         HaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782163584; x=1782768384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssE3TLUG/7J9ufeN9q/DrGgYY9Z2q4mT+HtG/803YCc=;
        b=BTa6CCYlCDjhZb25qHctTGK8MDhG+Iuj4GjzFhJoRuMGgvQ6hL7jYPD9BCfY3SlcUl
         6MgLwSPln75G0/CbtaV2RTP+Ltjn5WGUZafBgz2MTAbNehfozDtJuJElaWYQo12p4ctU
         eVUX4yRkrgP9//IVneVLT3Lo7NoDsp5HldPjYo5US4E+4o963ErxYHZbV+lt4Wlb9G29
         I04gKDdZQKA3uv61BpQ+w0KPHvyMgNHrM730+f2te6GMco9gTC4fJb0g2ZKPMxerMxh/
         kCskiFtZYYGb6thQrDgD5/7ZttoTofscbptjHrvfPk+kWpv/k+RAzQFQMgo1uNHz1grq
         FeIw==
X-Forwarded-Encrypted: i=1; AFNElJ/7MPKZq8isXzXZKUX8nj6NslNtJVFMU28EcidfWo/aO9LHpyv8WNsGtWLH/XgTwh0diL28gLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNd1TaOTEt8q1AUKDzJWsTNOU++NgovuhZ26VMaNaCEANNj3D
	QQfEQr2sYGLwmJHq/U/64K9ty94fVG/Xm0ReesutVKvXXGVsbmgnD0RwR7Sx6p04gVOmwNr03kK
	IqFrExnpA8uNAOsDESS1iW3j1PkThXgzuKYq96HA=
X-Gm-Gg: AfdE7cnoUcp6N50A3l2m3iKLBgETO/mP3dPXmVK/D2H8uPIyXfMbAAznWMssyYefIF2
	44cz9ZogUTXK0W6xxC+pKhN6wmqfouhkwUTLgLITy3YhMbzYrVDNPHrmONf4rabRxePE4ANXuKQ
	vAYKSNyt/X5TwYqJcVWnKmpCUEmQ8NF+okEyv/DxZsCCOBPYXy4EMU7w/YrkH8ldHut+1SC9kZk
	3r9AMYzUJOSr0cedMK3cMAwYzRUeSd8zNL3RaixFQbM3sGsQB9Efep9wR3YmUGCLKKkIi1YGwV1
	WXI=
X-Received: by 2002:a05:6512:2302:b0:5aa:883f:5da4 with SMTP id
 2adb3069b0e04-5ada9edb8famr21097e87.11.1782163583717; Mon, 22 Jun 2026
 14:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com> <20260622091344.794e0d74@pumpkin>
In-Reply-To: <20260622091344.794e0d74@pumpkin>
From: David Hu <xuehaohu@google.com>
Date: Mon, 22 Jun 2026 17:26:10 -0400
X-Gm-Features: AVVi8CfJIbyQ0LZKF2B9vVNXYGGvbzr3GZ2ukEdWP929fB_vPszHbNiUlAHw-3A
Message-ID: <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
To: David Laight <david.laight.linux@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>

Hi David,

Thank you for your review. You raised many good points regarding
optimizations here. I'll switch to using 2G as the max entry size
(`SZ_2G` from `linux/sizes.h`), and remove divisions and
multiplications. I'll also replace the `for()` loop with `while
(length)`, and drop `min_t()` in favor of `min()` by casting `SZ_2G`
to `size_t`. I'll send out a v2 with these changes shortly.

Thanks,
David

> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
>
> How did you find this?
> It requires a single buffer over 4GB - seems highly unlikely.

It was observed during experiments with buffers over 8GB on an accelerator.

> >
> > While the underlying IOMMU mapping may be contiguous, hardware
> > DMA engines often require explicit address alignment (e.g., page,
> > cacheline, or storage sector boundaries). Passing unaligned
> > addresses and lengths can cause explicit failures in DMA descriptor
> > creation or silent data corruption if lower unaligned bits are
> > truncated.
> >
> > Fix this by splitting the scatterlist by the largest possible page
> > aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
> > This ensures all scatterlist DMA addresses and lengths remain page
> > aligned and satisfy hardware constraints.
>
> It would almost certainly better to spilt into 2G chunks.
> That removes any need for any divisions.

I agree. 2G naturally aligns with most hardware boundaries, while also
allowing compiler optimizations with simple bit shifts.

>
> > Page-aligned entries allow the system to cleanly chunk payloads into
> > PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
> > As a result, this may help reduce TLP fragmentation in P2P transfers
> > and alleviate potential congestion within a logical PCIe switch
> > partition, especially when Relaxed Ordering is not possible due to
> > hardware constraints.
> >
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.ke=
rnel.org/
> > Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mappi=
ng routine")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Hu <xuehaohu@google.com>
> > ---
> >  drivers/dma-buf/dma-buf-mapping.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..f2bde38fdb1f 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -5,6 +5,9 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/dma-resv.h>
> > +#include <linux/align.h>
> > +
> > +#define MAX_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
>
> >
> >  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size=
_t length,
> >                                        dma_addr_t addr)
> > @@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatt=
erlist *sgl, size_t length,
> >       unsigned int len, nents;
> >       int i;
> >
> > -     nents =3D DIV_ROUND_UP(length, UINT_MAX);
> > +     nents =3D DIV_ROUND_UP(length, MAX_ENT_SZ);
> >       for (i =3D 0; i < nents; i++) {
>
> Why not change that to 'while (length) {' to avoid the division above.

Sounds good, will do.

>
> > -             len =3D min_t(size_t, length, UINT_MAX);
> > +             len =3D min_t(size_t, length, MAX_ENT_SZ);
>
> I bet that doesn't need to be min_t()

Agreed.


>
> >               length -=3D len;
> >               /*
> >                * DMABUF abuses scatterlist to create a scatterlist
> > @@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatt=
erlist *sgl, size_t length,
> >                * does not require the CPU list for mapping or unmapping=
.
> >                */
> >               sg_set_page(sgl, NULL, 0, 0);
> > -             sg_dma_address(sgl) =3D addr + (dma_addr_t)i * UINT_MAX;
> > +             sg_dma_address(sgl) =3D addr + (dma_addr_t)i * MAX_ENT_SZ=
;
> >               sg_dma_len(sgl) =3D len;
>
> Replace the multiply with 'addr +=3D len'.

Will update this as well.

>
> -- David
>
> >               sgl =3D sg_next(sgl);
> >       }
> > @@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_s=
tate *state,
> >
> >       if (!state || !dma_use_iova(state)) {
> >               for (i =3D 0; i < nr_ranges; i++)
> > -                     nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX=
);
> > +                     nents +=3D DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_=
SZ);
> >       } else {
> >               /*
> >                * In IOVA case, there is only one SG entry which spans
> >                * for whole IOVA address space, but we need to make sure
> >                * that it fits sg->length, maybe we need more.
> >                */
> > -             nents =3D DIV_ROUND_UP(size, UINT_MAX);
> > +             nents =3D DIV_ROUND_UP(size, MAX_ENT_SZ);
> >       }
> >
> >       return nents;
>
