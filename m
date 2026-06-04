Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041983C2769
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601825; cv=pass; b=OYx7OUKHX13tuCruHwyZiH2dy3RMLLKUU1sLHkabRBKxOMyHsmz9V/jlYojKkeSFBYGc8XGi3sB6Bq6hGs3QIHYlkBVdvpfZH6My62PqEQ6cx6ZzZegYe/oDUI02SLhLpH6dyvyp/4iZITXT4YKaRqydkqA1AIwwfnMzm6YAEgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601825; c=relaxed/simple;
	bh=4ny8mDdyqCfb4288ejqLKiubk6+o7RxTB1IiqZu7ppU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h63sl0D+jZUS30bE92AokYzTLY9eTC+Kv6pAb59wbU8GaSw05L+AFMsgA4M+5mg6iEQJ1plVZacBTxcHtLJJLOajoZAFT182ClgHVCBDT/wwgZpZEmjm4hKhbR/2Ti/O0DUNzBuLaM18Uy0Uaw27UHU/CAEaVplU1ZofeqtbzX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCynVXi0; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCynVXi0"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa62bd04fbso2017e87.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 12:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780601821; cv=none;
        d=google.com; s=arc-20240605;
        b=TiVjLxHw6cls1F2KCfQii5TMt1zxOweNWTVz19YqOF4EK4S+Lgm6JtUH7fxohVox8W
         qrzZmCkXNTyFQvtAXkURXKkxgYXHWeS271JW6UZbu1LpVoMob3Qg0uJHekcJRD9zmIvb
         vjqmpgtk/wovjT3fsodCUVDVwvEmxoPI3xtXSMHliyPf3l/BXHltrGPXMXGFGwdhudKo
         /CGpi0GfrWEFhjun6Hv8bGuBmHpmChMD3NJeaFecQNynzpMqyP+4cnmTi2EJDHCA42Ts
         sb6a9RXUOt4bAOH5gNiFoTt8YWXiesc3V3vqMj/Xw9IFcODJ0SAkUv6idq4ggCOYKA7b
         qH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KUiC23PK8EOFQC+N7GaZpdkePm+wStyLtAYgas7c/7M=;
        fh=g0mYxkqlNFUBbxq3u4A/61LULr5WO2GH8gydyL22tuA=;
        b=LG7Lp4sLldjZJYBK0YSuUk5eNeDS74fLpRq104FDGJvxVRSHFsLqGyPYAH7oxFDurm
         zXIx0MGy9Zf771HTnNAhSzfxeUWPRiXFk+dNvdnMwEifWboShg0e6WIjPz5Hf+MvJvm1
         bKoLCkgjkbUFMX+j5/X5TUHfTWXzYTW71zQ2zjn3JXRQpsCLntz6V5aRh4Qd8zYdBVxD
         qHL+7kyz9l/GwP3OosBBmieGxwKECF17AZ0AWMQxpctiIulq2To2RvGxhppNKpOP+u0v
         uNzQLvGGXluAZ19gTZO3jfzoeaWgIc6i24EUC0BM6szg0eQnOujSuNhbfkoDSLQyEAg1
         6qYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780601821; x=1781206621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUiC23PK8EOFQC+N7GaZpdkePm+wStyLtAYgas7c/7M=;
        b=eCynVXi0KEova4WZPuxCJP0NaAKAr28HbFIpn+G+vPRJjsOZAvt8ZjNvAP3qn1SsR/
         UO61UwC4BKmTCLUjVSuHLfAn3kfoE+rz7GnIZJO8/9aopLnXL4f6S/gFm3XJykqVQ6Kq
         bO7fx9QSlfoZTV+J19TdvGRjy/XyDZdv0GrWk5hCkoh/dluFutN0qOGLnspbsvqe2eNb
         PdeXxoera08OFf5rGTMCk7gLM5pcjSIvvJBpiCWidHD1vsN+0nwFU6ZFFWzuiXGkdEjl
         FvJhfEFmPsmEkrt1NxCAr2U5ze58Mhi0V8wxrC+CzdRkjQom+PXMd52WRyIIrktYWq2S
         a1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601821; x=1781206621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUiC23PK8EOFQC+N7GaZpdkePm+wStyLtAYgas7c/7M=;
        b=Xfs4MlfivvRYMaL0TA7kIk2vtwfIeujX+8U33EIWEAuEAUac0Udtz70FSFcRetgLrj
         MRYOMZMFGrqEGey2P1qvB3aDHO7wrJqW5Smd/aETb4JCyZ8pc//vgoMWoFovZGA1zs0R
         TbNINeRgmfqCU11kHi3nV9ZviCZotahlpAQR/HLaiU8slJ51gGye1m6MYz9WkHS86ha8
         v3PXThwA7IGTwpRPkYFTw2nJ4iGvsOij51wqjsW/SEZa9s8+lfDqVE2X0mV93VaRrVdy
         cNSFIEuFRwvBv1NEsNs8u66FKXOMTURE1eorqxdLW1xc5+RwEa3yfysxQxhtb+PAQ6nh
         ozdg==
X-Forwarded-Encrypted: i=1; AFNElJ9mF5HtvFr1qFGg2VMtR7ImiHhmSGS22tSZBsNORfsNTiMVW/89t9sADbUeBHNk9qBvp9xaoos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVQTiYMFenUkHRRs1CPnJ+8IqYUcqOaTzrqAwPXlHy77thwPe
	NTi5mc257C+y4pFyd3Ngs6yzZyfr9IpNo4QN2fU1gz0bV+Mbp/ZFm0kAK949OpibXnS+D7n3PIz
	1+nGj6XddiZ512BtAGR64Cqizo1JyBty9iE/0OEU=
X-Gm-Gg: Acq92OFq336FJlg6VN5ndOlXS9a5+rij5koM9+EraVNOMAxqrrIbjp2tJZUy4HWhOCM
	zO1dxS6pgK0+6tyvij85wEKbphGFVy5L8a/JfX/wLhhRa3+R+aRldMovu1LGW7ZjFzUPau34mPq
	lcP/S9WPi3sNnhSCwiylqXRwlIUb0CRs2xOhNrYbRlRIJ7/AUgymr2kYtmsD9Obdf3uKb47nrZs
	qWZQfH5ClUxogAO1yPTJEKD8yFdnvBATXaD7HlIpAeMHFNXIc4abPTvwe9CUvEC51aMZWHiPJm5
	4rdjXEElPalChXMGcm2U931X1gnsYGzGKbbWmWqir3OPZao=
X-Received: by 2002:a05:6512:2446:b0:5aa:6ede:1a68 with SMTP id
 2adb3069b0e04-5aa877c6752mr44886e87.10.1780601820811; Thu, 04 Jun 2026
 12:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601200012.3872274-1-xuehaohu@google.com> <20260604094344.GB245424@unreal>
In-Reply-To: <20260604094344.GB245424@unreal>
From: David Hu <xuehaohu@google.com>
Date: Thu, 4 Jun 2026 15:36:48 -0400
X-Gm-Features: AVHnY4I667s8Q-kTs7E7YlSR5Fzg5WrO7fnNQmow9VUJtwR-GDJeAyWDhu8beOk
Message-ID: <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com>
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

On Thu, Jun 4, 2026 at 5:43=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Mon, Jun 01, 2026 at 08:00:12PM +0000, David Hu wrote:
> > @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> >                                 struct phys_vec *phys_vec, size_t nr_ra=
nges,
> >                                 size_t size)
> >  {
> > -     unsigned int nents =3D 0;
> > +     size_t nents =3D 0;
> >       size_t i;
> >
> >       if (!state || !dma_use_iova(state)) {
> > @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> >               nents =3D DIV_ROUND_UP(size, UINT_MAX);
> >       }
> >
> > +     if (nents > UINT_MAX)
>
> I would suggest to use check_add_overflow() while calculating nents
> instead of this check.

Hi Leon,

Thank you for the review. Using `check_add_overflow()` is a great
suggestion and definitely
cleaner for the accumulation loop. I'll update this for v6.

> > @@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dm=
a_buf_attachment *attach,
> >       }
> >
> >       nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> > +     if (!nents) {
> > +             ret =3D -EINVAL;
> > +             goto err_free_state;
> > +     }
>
> Technically, this hunk is not necessary, since sg_alloc_table() will
> return -EINVAL when nents =3D=3D 0. At least, that is the behavior I reli=
ed on.

I originally added this explicit check in v5 to address Jason's
feedback, and to make the
failure explicit rather than relying on `sg_alloc_table()` failing
silently on `nents=3D0`.

Jason, do you have a strong preference here? I am happy to drop the
hunk and rely on
`sg_alloc_table()` returning `-EINVAL` if you are both comfortable with tha=
t.

Thanks,
David
