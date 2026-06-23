Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372213AD52B
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248622; cv=pass; b=HAIiZHW40BIp7GtDZJOqXOsGqyFoviTDHjsdTiqqwZCmudo8+kj4uar8NojfjNbBgMyGmmxGIGflvTVAGe3PBiVUxYz2udDDO3VUldf2Q4B+uGglQn+RKSrphNwecA1POShvA4bKIkmBBRo0NV5JIQMWC1gQ5mlMkqV+dQv/mwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248622; c=relaxed/simple;
	bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBqS51mgWBVzcAHSpcg7AfXZTolZZD4ce75wl+C/0FGBWK8gHpeacHz6z+C8DeweACmYHkA0qWmxuCXNwLZsq8xuBI7i97vwiOIzCyOKMzJEKztUF9Jn3mU0N/8VdSMRqNBVwR6tCe80BZkcdY1RLBAz8aYxF6JIjMS6huTcpEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1VjIJKu; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1VjIJKu"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4924933d072so3435e9.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 14:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782248620; cv=none;
        d=google.com; s=arc-20260327;
        b=monfsxc5Rkto0QWXDtpI27k8SemrsxPTde/t4nSYXArwhlPYxilUlu2nzoPXODQiZ6
         7QbC+H7VZdTsSbg/oAh/gMRtpEIcvdm+8kFi88NnkCJl4WtMZrzz2VMqRo6Eut6Idz/F
         7tIZMRNpk/ZaeN7S/kFLC4g3EEQH5wMIJHpChTtEpZoufqaPFtkZ/FX6Tc3tbyg0Gp9W
         SPDfoxVh2tkC/XE7d2u+FAoIhhNDac2vOZBqQLFYzzRa0PN/qeRjoSb4xTRMsF8ICGD0
         k/VcHdO8kG1X1tmKTdgtsyOtMaJShfSWSpPsmHkSs4t3KD0I44BEdiCtIAMuWiO3stSo
         /XqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
        fh=Gj3gJjNUymGm1NGCCDmmWPEqSecDr2F2NcO5oKj5aI4=;
        b=VUtYd8NXoFyzR3pvCViee+AOhq4KqfeRgQPG3poi0u8k+sNA66pxBlkYa8l1tPXZxx
         CCI3Dq5FGg6u7NGLT9O1gxc3A2qIhZC8B6woXNk6Pz70I/W4Nu65RQ9KSOYYAjRN/YLM
         QKr2n/yej9zTMDFOQ1vpR6NYa4gK32t5WyK4duBmdHAlrsv/Zzl/KPoMCr1/bUHUxC6c
         cMITd0OyaNzNDBVI4z4iQLLH4a3JUmsMw7oFizb2RskfqWM/0SWQs2L/E5WoJK4ssXz5
         VqXaEtNMLeaVVxlFUgwjC0sYlaWexhjK2/gH/8GHRfxDDwl5EwoNunc1ZEt86sC7Urz6
         e7/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782248620; x=1782853420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
        b=r1VjIJKu1K5s+oYfjdyDVKmK4r9yYbYWdhkZu8d3o32S6K8OSR3WL0EWD0EtwlRaEf
         syTm2y0spGghzKNrD7i2OJxzqxT5sPAFEeWqcuvx1wzsvfRgMowXW274uZiYX6iv2iwQ
         RW36Cxixt8bYsueXeEK2BIf+ySBzHQqYuaJDGy62HNYd/jUMjpzodx70MsCXCBd95HJE
         zoGZzqRnS4GZHXlLOSyPs+FrJXGaZZFFvJtLZLXbtMQv1wgNvqHtVg6hnx8Ox9d5STrw
         ettlJJG9N1e1feM00IHWdbKpuryZBRrz8X5Ngb0tHNf7siGbxBO/ZUoH5gX+2PGGYNmE
         1LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782248620; x=1782853420;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
        b=INVEu9TxR3yv8qOJjDfT8dSWiM0HvbVQgY6DwRTWWLd2sx+N598ZG6jxcEmbAOAQbJ
         oXxrwoEfEPtg6nvdGk4vfOdP53SKi6xUF59Qca9XhCsJFvpPHWSNaIcxPZeYbwLU9OVb
         Kf6yJwqIi85/KkS19y4GhCVRTidj/lp0nx+mdNixjxN67q3CmwfraCukaiInkOuVcBav
         +02+LasqxILCfz5WIxOrk9MiA0h/nY/xvCBedSq9dDPi1/lZ/L2zWGiNEHsdgR2MI/v0
         WPwPXjW7NLnyd1IaoDAGLsOW34UXlwczG11xhCHPtAmaq55VpTMkvWda/fMw6h619m9W
         JoLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mKRfF42kC21G2lAx6j4IaCcakT6osTT6F3wmdJe3IUoG0g3FRUSr1m7jcpX32JvwzxGRfLfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydIkbPicksWyf75e/690ywl6jQect6fSlFUTV9wJ6mfM1DhWou
	rm7HAJa/UbDY0I84BYNulnmkBT0ZlbTNTWRRDVJR3lHebuNgOXTQOHDHgo+GMw18mBMRZiRp6Tq
	mr8u4ITY12D7qz95bDwezRqgerupuhSQmntmoo9g=
X-Gm-Gg: AfdE7cngL7tV3SAn8On+sUxYkWXyYFxjBUBcXr5N9p0MX4tMSDEPj64k2/5Kauf4o9X
	eN/XhmFjQPY/rrr9r8pR6W7fAFAob6NCY+jDoA4+Kk/AOZSN9CFO10bkpiaBzWAwE72fMEOr3IZ
	jz40sXsHnG3nCao+WccNEWaJgm8u3AENp0rXuPd3JMWIh6T9/e84YQl61jsMMwCny28MOeLp+t8
	Ux1/yt+wj4MNP4jdqErVAq3CZGuKGr+XJZNPTyn9fTvq5+YFybNiRP9YWCGMqpf1nT+phpFb1uG
	btI=
X-Received: by 2002:a05:600c:16d3:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-492603072camr290785e9.0.1782248619190; Tue, 23 Jun 2026
 14:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com> <20260622091344.794e0d74@pumpkin>
 <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com> <20260623092501.17bef195@pumpkin>
In-Reply-To: <20260623092501.17bef195@pumpkin>
From: David Hu <xuehaohu@google.com>
Date: Tue, 23 Jun 2026 17:03:26 -0400
X-Gm-Features: AVVi8CftE4Qz-bzNimcxnNDxPCuT9w5jszdF7jgeQ4PkwmMrpP9oMduQaXpAyA0
Message-ID: <CAPd9Lg-i8Agh7_E5cd2CmtWww1cM2PW3A243qtQaHxhvHdjCQw@mail.gmail.com>
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

On Tue, Jun 23, 2026 at 4:25=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 22 Jun 2026 17:26:10 -0400
> David Hu <xuehaohu@google.com> wrote:
>
> > On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> >
> > Hi David,
> >
> > Thank you for your review. You raised many good points regarding
> > optimizations here. I'll switch to using 2G as the max entry size
> > (`SZ_2G` from `linux/sizes.h`), and remove divisions and
> > multiplications. I'll also replace the `for()` loop with `while
> > (length)`, and drop `min_t()` in favor of `min()` by casting `SZ_2G`
> > to `size_t`.
>
> You shouldn't need a cast at all.

Hi David,

You are right. It looks like `min(length, CONSTANT)` works well here
without triggering any type mismatch warnings, regardless of whether
`CONSTANT` is `SZ_1G` (`int`), `SZ_2G` (`unsigned int`), `SZ_4G`
(`unsigned long long`), or larger. I'll drop the cast and send out a
v3 shortly.

Thanks,
David
