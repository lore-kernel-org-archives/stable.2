Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04F3DA5C3
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944916; cv=pass; b=aFHsONNKup2Jvn27HNDQrXczYO1OR/kp64G6b9ljKldrs3tNugvcjHGLfxiBt8vet1gUUZA2BwxOES65gE8wEdkNqHo73AZ2+76BnxZJ9iuXQoqAIjvqzXg6n5Gr4zIoDhpW4GfRcgCCipUya0bGJlFixcO5NkHGge4O+WBVEt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944916; c=relaxed/simple;
	bh=zKNEWyIdx6AUnE+D5RSyECXmUt7mDFTSd+8dDxmh9dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPDWzpAClYk5xd/SsUpJMdvatyT1YAaQUuaLl3iIdQbQV8/1Nhwk0CezRB9UtohWcU4cZUBo7BNI70fuP38OcYkYKHbd6QN3+A6lbrA8ug/FjuGBvnaBJvDNwDJHq7zDqw/Gksgz0EBLxiM0RaUhVDuyk8l+9Mkzkg/5ZlBV2ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqKSegmZ; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqKSegmZ"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa64afcfdfso20257e87.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 11:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780944913; cv=none;
        d=google.com; s=arc-20240605;
        b=Jp8AVdAeuiH3r1zup+4yvtxdr4BwI7bgKFn9S3D6psFPHEIsJIWdZDamlZVW9QOcEl
         t/wSVvotkq87XQN0Eq7/16u9NPvKH2Hhksp0ASwn/pElXn6rEr9pnPZMgMD5V75jYfdc
         +bzDCLQW/7M17x9zBog7He7h8HFKM5Un6rlZh/ahHSYZg2NrLGAjJAVV09eoUzjN26zx
         z02r362DnOVvjQBysbwweJn2j6MhQEHrW5XB89fWJwbXM4wYzVbWYUFVe8xfAwzZLePw
         7BHFfyZaROQeLPsOk8u4W8GMq7XlNo7j5CQJRlIjJuhR33HJbrX98K3l4xogtPkymQZg
         DBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dw+WR3kgPsmomU5BDy/wi1DbnucrDq50YuLE+lo/Shg=;
        fh=sI9x9kzj+IIudlq6/14BlfEPJnfsFwzurYuMdMwT9E4=;
        b=FrNv0Nd2SR8talmiSl9z+DpMFM8/TP3o6+VgyT10jmcmuzI34YUIz1GyWo1DGmwOFP
         kyHcpu7nv7xt6kH2pAWT0D0UItTLbH08cAUQi+xsZXLsAhYLuZL4TBv45ETm/GKRGNP/
         SeuY1GuGVVSZ1HWJhD0h8dVnFxmdB4reTNYqGoDvUc+QnDIqYvqc/9vLu/ecdp6eZ656
         PCS+LoacOvC0EKJsxe+9QbkBTe8vCfIkpwDjH8NSupRTgVbbM7igKdB7tFNrrJebkSQk
         zCjNf1GYzkBVFIKdboLGkalT4PxhguwWgjHh60P55EokzSgnrwkL/7ZOPLZQYpVo6kTv
         J85g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780944913; x=1781549713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw+WR3kgPsmomU5BDy/wi1DbnucrDq50YuLE+lo/Shg=;
        b=rqKSegmZLQBKD5b5RRvE1G8hxE8ZwYnoCRtkoB2UGzazOQAkOQnkcMjyOlFqK9ufj/
         B00giIS7FS2ZbyfkjmmrUow+Ie+rsHr7+FcL9gRpOYrzNnPQgOswrvhwLIKEg9Himntb
         isOwldfThEYz2/B2x0EiOVAlkHNSc3ntvhg9xXGX5Z6vTOceSXGGMS9l2Nq++mBmHtj1
         fBWlTGcFu98noiP/SApLU+XBWslhTs9XyXj9IadpnETbuw3hvCd8dUNoF1CMkxYpHQfD
         sxODVy09d7xYRl/0pk6P2yGs86EJ/DV2uNScbbp4AyIAUnp8fHQBJfFg1EANFzDTu/K/
         TK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944913; x=1781549713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dw+WR3kgPsmomU5BDy/wi1DbnucrDq50YuLE+lo/Shg=;
        b=jFOLINcbbpW4ZFmGKTuaiTLlL1OuMnh08WbD8606/tukaHFLhEVmOmdxPcK+423AaA
         i2V1f1Ti7rHFCxAg0pYkC+tbey0OAs0q1xiDKQcwQYQyXVO9IgqaE8I5kxeruMHz4piP
         LCBmwsHjGzNrwIb3XQr/Ug8V1WFnln64c/uTtFGIzT2wTRX+SiHd9No7UtXVnd1vXEie
         E9J6Zqd+e8uNonZLg+w2KNaaf4rJFbmj/iSmtQf0uy/BccNP8dyhIIbKr8Osvg3dkkAG
         8neOEG+0pCeMdj4ww/+7CtBy88Ca8zOTq2BRe6PQ9PIGgEd/vUj1e4L8AOIcx5EcQCOv
         BSiA==
X-Forwarded-Encrypted: i=1; AFNElJ/w7XXRGBrLon6LY5mPgtkMmyZgzQoINVBO/tExNPeFaCS/maxj712BU27LS4/RjPMlrhvOR+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx32/sdAr/wtBs7kESJt5lmUG35YjgGTUbfPP0IrsNDBaAActkJ
	9Ic+Y22xZTcH91ohnh/XHJKNyNTCO4Q+qqVme4TGLCeVDtuT531t2f74+7JhhCLyX17anE+bMSO
	3dD7YabiXMeZaGiyuUP3TebOAIHtX5W1BpHBpQ60=
X-Gm-Gg: Acq92OHSEiDYRxBAZFbBBD39QPdQBX6un7ePbNMZ/sjzISfdByaVPic4axpCPv6tl3F
	FXfDfgBHG3WVUWDMbi5ur4GgLuUNkuY2xH0pmY9KJNdYYhrGTO3rFJqnwmJLSqaqumPZ9BSzNHC
	X0fyMvg7JhejQIaa9A2iLubiH0GJpl2RX2/kr9AlTiPdlSMqloFzMKMZUfFnbYP0n1A1rfmmZ0I
	xaqbGHCAH45t5F+/WfSe9nHVOBlgFanMhnmh6WgM3nmkLG3kX6RVl2wjDqRlK+bSpteOQ+aMnln
	cv+TzEY8dKNwcjshdfgIrF7O2rvjpadarQp96ZoIZjQ0R1ZBG26Bl4c=
X-Received: by 2002:a05:6512:3341:b0:5a1:274b:de2b with SMTP id
 2adb3069b0e04-5aa88640402mr537440e87.9.1780944912435; Mon, 08 Jun 2026
 11:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601200012.3872274-1-xuehaohu@google.com> <20260604094344.GB245424@unreal>
 <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com> <20260607080244.GA327369@unreal>
In-Reply-To: <20260607080244.GA327369@unreal>
From: David Hu <xuehaohu@google.com>
Date: Mon, 8 Jun 2026 14:54:59 -0400
X-Gm-Features: AVVi8CcrgIqNX---JRMNN-9SsXpCXMWpb_Y08c-v1_nrKhDd232Ciz6Ae661o0I
Message-ID: <CAPd9Lg94nGnn7HQPNiSS7w2QQjVAuJ_FkMggR=JfSGVJyAsgeg@mail.gmail.com>
Subject: Re: [PATCH v5] dma-buf: Fix silent overflow for phys vec to sgt
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 4:02=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Thu, Jun 04, 2026 at 03:36:48PM -0400, David Hu wrote:
> > On Thu, Jun 4, 2026 at 5:43=E2=80=AFAM Leon Romanovsky <leon@kernel.org=
> wrote:
> > >
> > > On Mon, Jun 01, 2026 at 08:00:12PM +0000, David Hu wrote:
> > > > @@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struc=
t dma_buf_attachment *attach,
> > > >       }
> > > >
> > > >       nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size=
);
> > > > +     if (!nents) {
> > > > +             ret =3D -EINVAL;
> > > > +             goto err_free_state;
> > > > +     }
> > >
> > > Technically, this hunk is not necessary, since sg_alloc_table() will
> > > return -EINVAL when nents =3D=3D 0. At least, that is the behavior I =
relied on.
> >
> > I originally added this explicit check in v5 to address Jason's
> > feedback, and to make the
> > failure explicit rather than relying on `sg_alloc_table()` failing
> > silently on `nents=3D0`.
>
> I prefer explicit checks, but I am not in favor of duplicating them.
> Since sg_alloc_table() already validates this condition, we do not need
> to repeat the same check in dma-buf. A comment should be sufficient to
> inform future reviewers that nents =3D=3D 0 is already handled.
>
> Thanks

Hi Leon,

Thank you for clarifying this further. Removing the duplication here
sounds good to
me. I'll drop the hunk, add a comment for posterity noting that `nents
=3D 0` is
handled by `sg_alloc_table()`, and send out a v6 shortly.

Thanks a bunch,
David
