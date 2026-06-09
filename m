Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DE3BADA2
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022012; cv=pass; b=gS7rCgegklWV5d30ngrnjREJTp7bNvZjY4QthD6nuFzS8nxxnHyHhyhwcVKSwJzfG/+5tTwhw/NshjM9241y8AxBkz/M090C04JoBtl74IDgfuVAFL7/OJmkWfJP002ioINNwRFCdZ/vA/7mGL/MRFw+jaQrpj4K5p9Z3lADbbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022012; c=relaxed/simple;
	bh=/HJPWGicY5u/dlbgFk0C5NmIj+GOioj715oLeRqp58E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA3aQLJw58Iklsi+bu/IbUcnAlSgcclRd073giQj7aebkClsJcuWQf7LTXpIJh+sV3hElMe3GC1WE44deQp2StJAmEj5U+vvbw41D7uAHBpDSUpOxw0hVh3fF6ToGVdMC62zlwKFfkd2QBYHFNt1PYParu1nQhm7CPcYBqf7SpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWDq4LSo; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWDq4LSo"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa64afcfdfso28421e87.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022007; cv=none;
        d=google.com; s=arc-20240605;
        b=Nj3mZJDq4C8REE89hEsAS+4N6Tz1UfcLlHTfybV87Chtxa8lpWsK/ktZzyvZref+oH
         UhPAU2XNaFskNxiJvojIajGTw8Hp815w0JubJjT/bGvi2fygvePAcYdkz+ekHzEhZiZF
         gZHOkcZPPsAyOqWc6Nms3Dr9JicNUAk5aHdWLOyoWDMfKb6MKV+zhuW+k6J1xOVYIL9c
         RdqXdFrpqINwQXlwLfjCJkBq9kNuL4N+OS9i+Mvu4eb+mv13kBaAbk/d9xMb7GqaOk6Q
         t1FJi4dL17xjvORp1Mq9T9fHcH20Ry7nqV2pxHwAWNP7W39U9vqZhbKNA/DIDo7GJXSs
         0KDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pFgomi7XLhEYHICeogk3tk52w0iSafmEFBcU9HzZqyE=;
        fh=oNMYVkmGyoi2juJ/Qms9tKPQfuCS0Na/GvmcfWju1rM=;
        b=PjnkaQSpb6hZB8I78AkxxDKe+n99s4/1GQw+B8AoeMD545RPBvzDPBT8a28osYndtt
         UmK15HgAM3vt60DvgV6H/jel5FHQAglrEeAE4fJEhs/8V446jnM4r8NeyoxNJvqH5dNR
         E43K4NLERqEAOW9lKvFNJNFE6DvfKqIG5QcHZZ8G1xJQ7Xb1iI3YYcmokl5MrPETg/Am
         BH+fOLtCuQhrov/AZrxwZm/AGZ14zpK2UrMzo+YvjBozNJRbgJm1mDWtj+qtr9U5LUhS
         LhnhI/CvvblxDLGIMTZtvt2ZNV4OymUFff7IRt6kz0gl29ixPwmklZ7yppKkgSIfYj7g
         D+5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022007; x=1781626807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFgomi7XLhEYHICeogk3tk52w0iSafmEFBcU9HzZqyE=;
        b=iWDq4LSoq5vma5XB+QXzeHrn+9b1P9U5WFr8yNXNEQnZfc8bhZ9MbWuVPRKYEHihRI
         w9G+zhw+/dI98L5EuHBny4iZuT5Cscje3krB1aDPS7urcaP8HCF2D6gSFPN1/qGFYqLO
         CIriNbTuKeZXZ3KiZKjNTFa8EgjfAaEcJbI7wl56VSDpSb3EVsVv3I2app16P5e62Ocd
         HzxtJj7o5KFeqen/FAsPGhUyAJdj+GbjLzcwqtCCYlgqABs2gQxDtbS7vYv9dY8hXfPL
         vsTy/eaU3L4qXF+oYJ1njH0umij/oCKhoCCFf12IuQUxZdtlesy/bCLybPKKemvYbSwo
         BAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022007; x=1781626807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFgomi7XLhEYHICeogk3tk52w0iSafmEFBcU9HzZqyE=;
        b=qqd8EoKapXfkXiEPbu98G/Mv5sTLFBXNImq0xDRLMt0wcFpNhQsFSS4Vx76p9SRumW
         IuKD4/vZiGV9kr9m6eP3yVosgHz4YpUNOt++jKm79b247VeWiIMO3Nao5sodmrP78uAy
         q9NnFpLK64D8Bo2NCyfjSTJ2xKJy85FDYxg25dqu6NHOTE3O73AVxEOZ9GG85/hObMUo
         bkhhotT121Qe6B73tbiZJTbxDgPLZEB6W1ko52JK7fKEGN4bitMkyAQWfvEYogcsZ4Uq
         EjFKiq/FDGqcPPHtH9R44gb1ZDzbyTabLgY70TFZ8VqLpIUc34dXbzO27SYCFziPhpc6
         U0Ww==
X-Forwarded-Encrypted: i=1; AFNElJ+kxzP286DDGVpDhoRCmvdjYoQRbwjFCdXUv8jWUvMfMtGzbvOM8K2onRLol7KnPk7XjDka3Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrb2HZFLlNvIgjmJVSvtO/FjFB5wqMJxHn0sNRsiOrTFq2lPNd
	NwkXbwlyi2r1+Ymdu6u3pFGiEQZfSHbITbKRADnwgtyjdaXh0DoGr5nYoV5f4X5fhVGflbgeP8l
	UrSy4080ZaDXOLqZU4FnUdclVHbIRleaiJxPyDYI=
X-Gm-Gg: Acq92OFLXkVO6wRP7b585aoGcYiAPcA1FliLbE2b1n1pEttC54ON2VsOlmAWIkyMdax
	tWwW+DsJBAKcEkaFv7+eTl2H52PAsxNh0+AnoFQx4l2tWklOtApAfIs3432vcYjlFFtdVYa9QZL
	tSEsiCbR8O5gCOzIi4KM3EwPtDL2C4TQzoCin5n6ZDskG51wDwp2A2w8aSwscetEfvECvJtrkZr
	rsIQSEY5Oe0iZSeeKeGfwROTWDg/tuIEAdcQdaDa5NJdZlCDk5AA4hSTiTfcBeTv7L68QGjwOKL
	tZCelKQ4/JJ8gPah4NwSFQ+TkV9sICTzk7dcPUwHbKxxPgrLs94r6MKNvA==
X-Received: by 2002:a05:6512:33ce:b0:5aa:883f:5da6 with SMTP id
 2adb3069b0e04-5aa8864f3c8mr624107e87.13.1781022006976; Tue, 09 Jun 2026
 09:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608194321.150838-1-xuehaohu@google.com> <20260609072234.GB327369@unreal>
In-Reply-To: <20260609072234.GB327369@unreal>
From: David Hu <xuehaohu@google.com>
Date: Tue, 9 Jun 2026 12:19:54 -0400
X-Gm-Features: AVVi8CfbRleRRxp7xUhMkzyUOKJRPcnke7OqLp1gc287gSv21XbS3wDiRLvDI1I
Message-ID: <CAPd9Lg8OtW+qekntqcuL_Yz97=e9bD1gacbyB5uQijL6FpFqYw@mail.gmail.com>
Subject: Re: [PATCH v6] dma-buf: Fix silent overflow for phys vec to sgt
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:22=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Mon, Jun 08, 2026 at 07:43:21PM +0000, David Hu wrote:
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..67a8ff52fb8f 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -40,8 +41,11 @@ static unsigned int calc_sg_nents(struct dma_iova_st=
ate *state,
> >       size_t i;
> >
> >       if (!state || !dma_use_iova(state)) {
> > -             for (i =3D 0; i < nr_ranges; i++)
> > -                     nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX=
);
> > +             for (i =3D 0; i < nr_ranges; i++) {
> > +                     unsigned int added =3D DIV_ROUND_UP(phys_vec[i].l=
en, UINT_MAX);
> > +                     if (check_add_overflow(nents, added, &nents))
>
> An additional blank line should be inserted between variable initializati=
on
> and the subsequent code block.
>
> Aside from that,
> Reviewed-by: Leon Romanovsky <leon@kernel.org>

Thank you, Leon, for the review and for catching the formatting
detail. I'll add a blank line, include your Reviewed-by tag, and send
out v7 shortly.

Regards,
David
