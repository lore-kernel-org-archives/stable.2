Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1E45D19A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822843; cv=pass; b=X5pxP9FKtisJTisQCeptXuJFlWyiPNL4+vhcs84LTk3adgY9PLTqtr/uMOCtVAwb2EO7ipXrZKSCMgtRJ50OwrchszG0S5QR+/PpaFvBZVA+vEDZ7BbO7zIzXBLH2BFkkw56KbfRXQCqTID7E+KE3M5UQh3MkHm+JROtp3ELO9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822843; c=relaxed/simple;
	bh=UTDry1jdeZi0acfJhI/YdJG0G3QhaI+y1iFKk3Eurwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgZR54t+8idy8zROdn6tkP92ThL7YGSfpyVSqi4/G/W7v6sQpSHeF/gJmgMXSotu2QU6s9AKkuUuskkPf2O5at0Z+RhfZmNknVsf57k7ygKpsp0Hyprh5SsaI3ln7VHD40AVxCPHWsfLKhmt346VmALEUt3Xiq5A7iuuc05g40Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ks0L75RX; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ks0L75RX"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b2a8173142so8159e87.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822837; cv=none;
        d=google.com; s=arc-20260327;
        b=KgfZ5eeUfT2xvZ8e/rGpvKXHtvnapDoXbHNtdxYr0Su/l7nrzcRXGiHimqTH2gXtLT
         Z9eNbqan57b0keNsP8O+Jhin07Xj2dwAVE3neyt/ZQzXUb6qAx5kBaYSZ21B1j4+FwSr
         oZbeWwxO1cnjvYMee4sfECadodWRpN8bx2bqlFTIzo0pZgZ6w3eanwVepez/g/HmJ3ba
         q8cbS+JpO8btfQXwVfLUQZ8bKXDedPL47q998nmkh8Nm8YTzK0i9EBFG4VfUrKJe/8Tg
         gSOBJPyyKd7B+P/6Nbf48HWEKEkH+6crCIjuEa3tzIncGch1P3aMaqL5qe8M1MZYSA1Y
         2gBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lLj8QIPDjw+wrnYmjqmWidOihzraKtluDpbS+qkgPXU=;
        fh=Db+M80tUZtjmfH8XeXl8rQXwARP51ry4tcUyjft9HRs=;
        b=MxS+0rjU0IISCQqR4MkKwaXiKLs2ldD5miq/nMExGVYD+prZgrvbiH4lvW3+yTcYHV
         NbBD3vBUtBmMfv6lYToENdAca0AYxg4pUnpPjOiGYlwDlJji01I9SUNjKhWsC2RAhG9o
         lHSFCRmjxRNusBbpHel8tT/AtagajGFjYqXmVMUP/Xgy8GZWUnRcYcE9hCEicNFlJ20P
         8YYHtRFE+NrzMfMW7Ev6VWRTFzn/jggf8ViOBGq3R3Rk1SAJBE1q96zGgvn5tSxp70qt
         vk5Mf5YHtoSBo7LG93yQtWRwYA8vfEXv3X+LbnG4MKVm2HL3j2xNlJ0BZ5l39dkuPXBB
         LDOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784822837; x=1785427637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lLj8QIPDjw+wrnYmjqmWidOihzraKtluDpbS+qkgPXU=;
        b=Ks0L75RXYNwqbMpypXzI8wrm7yJGNKZVMSKLdyfd5qrsYhodAJwDqkvcrjC2CUNiUT
         kJQx4ujxuSR21U0O31P53+fQkRPMUDKvs9BcYvPJL5ddOhlQUNapjM5YK99aItX5vZrE
         CTnfGss+7gkvgp8qH8rKWGeIABSP/GvbR3QjeCagn2hvlT4Y2OZxTKJbXkTI7xULTkUS
         CoyH5yYQcBaWST+bg59H67RrA7fBTK+FfKVokGdpAnheoY8o7Srd4Dq+va0xN4c34MES
         d3cwO5S87A/j27c8Lm7ftosa/fP/3faJ+NqJxDXWbZD6CKBfldrL17aHC9MoZV5jhEhk
         vczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822837; x=1785427637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lLj8QIPDjw+wrnYmjqmWidOihzraKtluDpbS+qkgPXU=;
        b=k0Ox/vabk/GYDpQ+OWSLSRk0srGrSPKASbK0llIpZqWfnTRWcRNIrh7Q61VFWXsvOi
         tg3CxZBRAcTLlVnyGrYS9ufpgc9eloxMMfT+O4UKX20GiKCI/DedquCyNljmfCAOKPJ4
         iyIEd4uu7t45/Ul0HEPLoA7pZC2EN7ONqX1eCgNknnO/EH5u4zMa8p87P3uNJHvz0A0n
         PQjg5gTBTifpNphiEMLfNMMMPat7cW6FFc/LneZH8cyQOAuOs+Nr4G5YVDz99HG3WVla
         UDpMSt0LhDxjCaimBude1umBXhmVCY0THByHzLZbG77rzth9Cb89H3fugDNzb5YvzxdM
         Zn2g==
X-Forwarded-Encrypted: i=1; AHgh+Rq8MEOSQ14Y8lfMrWtizgoTmbqloY9vLhYSh3lw6trHLAoNWU13WiEmbVJ50RlMLOmgqa75s9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/uxQlZj+h5rong6SOIydp4eC7pAB+1nBoymRpW/DGqNslblzH
	CAEX7kJOXyvOV4Ej46eSeUT2sTO9enGn68XIGJNcltwymZ06afrfmv2udsN4C3CeXPJUEZbrdA4
	eReO3+B5gBdFIKBlyiVxGyeue4YqzbN1hJCFDR4U=
X-Gm-Gg: AR+sD13x8XH/U4PejtPef51Swr7Bv9LZqjoZBIjiOWFFOKUQJdcT1nDAQthHSd0Lsxi
	lYJTnM1kQeLjCxirhU2AX9qepCZhPy+bCjFEYw6S+JsrvrRwqGZ6jyJw9ZeNbGbXhhkuMXCCNrI
	836wgh++nuIch/i47CAbgRGJ8A/e57bDIo7jPbX3xJg22hTAvTVYhQMJfpvWZW9vN/O6KTmpXtw
	nQriss01dtuHuG6z54ugKwc0BYnFRFKEkBCV5j00D7poiDJ/8GqRzYcFdbO3Kd4elMWGpB0Fnjb
	2nmwMPC6aNYA1co=
X-Received: by 2002:a05:6512:3c8f:b0:5ae:a4e8:47be with SMTP id
 2adb3069b0e04-5b2b2968164mr196065e87.7.1784822836866; Thu, 23 Jul 2026
 09:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623015459.1153884-1-xuehaohu@google.com> <20260722233932.3997681-1-dhu@x6u.co>
 <20260723094625.GE110966@unreal>
In-Reply-To: <20260723094625.GE110966@unreal>
From: David Hu <xuehaohu@google.com>
Date: Thu, 23 Jul 2026 12:07:04 -0400
X-Gm-Features: AUfX_mxZfBk3L4aJdDJNuS21FbP4tt0j-EIQJVeIi7KxTXcs6-s6PmQ53scVb6g
Message-ID: <CAPd9Lg9ZL9VwubYbn350pdUbQnnfc7FwXoPU3nPgvBHWRxLOyA@mail.gmail.com>
Subject: Re: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
To: Leon Romanovsky <leon@kernel.org>
Cc: dhu@x6u.co, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Laight <david.laight.linux@gmail.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	Pranjal Shrivastava <praan@google.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org, 
	jmoroni@google.com, kpberry@google.com, chriscli@google.com, 
	viursachi@google.com, sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:46=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Jul 22, 2026 at 11:39:32PM +0000, dhu@x6u.co wrote:
> > From: David Hu <xuehaohu@google.com>
> >
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
[ ... ]
> >
> >  drivers/dma-buf/dma-buf-mapping.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
>
> Could you please avoid sending patches as replies? It severely disrupts
> the reading flow when using mutt's threaded view.
>
> Regarding the patch,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>

Hi Leon,

Understood. In the future, I'll start a new thread for new patch revisions.

Thank you for your review.

Regards,
David
