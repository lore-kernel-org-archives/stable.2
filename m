Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD113E40E3
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144396; cv=pass; b=Ey9r3M4xaZiAFbmlgtj7yaX0P1Vm4cNLnayL7jo9xCvxn+WVohiPxA6nXSDzkkvGdkeL5O1r0do4Gks6wka3dtGcsjulHra0+SwOO5rDPPpK6awIQ9b08qWZEMWC/yrYLuPYvroAbYIz4zM3T+1KD+hvbmAicbyaVXJIyQ3T5H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144396; c=relaxed/simple;
	bh=xqN3pfb0UkR3DIFYcIuV6kM3FHfjO1La5ULm2s3cbLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfttKUBrd0MYcq5x3aWMIvXfjg5Bp1CFC1Dc5cZ3PFqyYPZ1MDgy87HH/cvzFIAv+MBT/m586+Luj5DX/FSDJUCQEa4lxORvmD/YxrBaVYeptCyUoXIP2CIS8onTEMHuLTQpv/Q167dF0wqn6ecHUzCjS6fpErYg18RLLMyGjgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDLdGiMx; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDLdGiMx"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48df54150dfso1002805f8f.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792144394; cv=none;
        d=google.com; s=arc-20260327;
        b=Df0FUmNHdbtLo0vAXHs9OfBfbrByK/VCX+Q865ofyCmCwltOLN5fK8+lLAmafWpQZB
         CgxKR0LQ2DMEnKkhNrLunwXuIIkdd05AScBw9q9CBDA+lASIqxt6ZJ+KoiNHKitkPE19
         QQB3Iq35D3NBhswmyEByAz1NvFEsfcq+BhQq45axwCA1vElwTZ4JhtfzZ1T7es6OZSsC
         hT4Cp41fF/IjjEzh25miUDVbjQUx8GaUgnBxOc4Knfm26bDeDkbTeiCI8/yEfBzj6j43
         /ROFu81cmdRepF2loTCiSTZ9rSgXkA9D09M9rGQrmIWsGTz9Nv5aS1pz3v/C3w6uCePj
         ieiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xqN3pfb0UkR3DIFYcIuV6kM3FHfjO1La5ULm2s3cbLs=;
        fh=fUDR5z7KTKm8QA4IT/vaVgXPyqdvJMFpE2HQiPN3b7U=;
        b=gcdsCsWOoEXtJlzbO0OursjTQ81IEQaQOlpoz9aeha69pQEEvpMnaOFb+Y0KZoEfL6
         C3BJNBKsQjoUZmZq/9Uoc7G7Y0IFl9kKFygoeeljc2S9srEmfhNyrvEIQ4NcT+NFEGvo
         rVo8z2zaZTO5xJD1IKbIp3A/aEN1bwFs8nnsg2HOfxzDBrhqO3j4539gdB5Uukl7CS7/
         i+Z4nUFVoH2qjGr1/3GkOc9uP6saf5eHjkl5AEu8+yBLpGwteJ4RFBU8D/3KJzTNo8mY
         Eeso3AaR6DpziA21oq5qZDd2GJyPzt1Dbga1JYjUOOkIiu+amVHnS6HciEbC7ZoAPah7
         tuWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792144394; x=1792749194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xqN3pfb0UkR3DIFYcIuV6kM3FHfjO1La5ULm2s3cbLs=;
        b=jDLdGiMxcaIIYMRGh+/GvHB/GA2RtVlZ9FADMtj0vAbP1wEoVOK7yf3/RVrUvrDISp
         VX0yHYOzbdKZcvVJsyuWYoY4XZAv0gvp7jTfkw/ugOH9FabPwKKShjq+4zlue1ycatq9
         gRDJmIn2wGsrvvmrHrTaEoNjNB0Pkpt53izXaa2uy9tMrAyFIqxJgFT/jJfeTLyDdlaJ
         4DdblAtnRZRcaEarLArRz0AsacuUKRHccW8hBc9PDkygzNlKcBfTX2UPx9I1CLVKBpFK
         otx1NuO8dCubfeszmS42aeEKkZi2lRAw1PGcVypZUVBjrf3huKHaNd+mXA9wZ0zYANM6
         ESsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144394; x=1792749194;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqN3pfb0UkR3DIFYcIuV6kM3FHfjO1La5ULm2s3cbLs=;
        b=zvSzOErPKDDPqgf2qd3WkHSMN9V2rYRBV579QvIUzqNpcnfLEJWskb2ALNEErpcyiV
         ZaO3AVSqkcQaSkbe1/Gco3HTyWsTcm4bwAmNsN1/eUCm8QTS4drzPQeuaUDbgzUMQqHI
         pdstB+5wKGBzBNrK1l6g2VMZD3Md0XHkEddbkngo29Ub5mPhX/h61mcgPaqccHqCgvfO
         wNMcZmKIToXcKquiZqwo3Dl8D9qpeLEt20vj9lg+hdo2JrmXKm2+I/RqbDYvXXGcQ76q
         WKeHYLkRpNc4tWGXb4eNug0gkLarGFVIMnT4d9GrTkTGpBl7D/rOR+r7xy8oloPtEhuj
         Mkzw==
X-Forwarded-Encrypted: i=1; AKwUvBy30wlV+B0wOgiEShNRLbJ7KNK5A2tZI/w9nv4/KtVtyKdJO3whRwX/Fl+UaiolAtuk63/C8kE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaYUojWieyEaVQZlmNDaJodFRC2rRYs6FJ1jrMaLNznpzjR48M
	lujjw29oGVcjzSpjLXYwh1MpoOKzkv64CaCFjopcpMK788kL9LEbz3UYp325Sh23ZP7K15CUMEO
	jyee66pXYwceRhlZg/1rZVngdMDIXl904F6frQvQO
X-Gm-Gg: AYBFou2a0x9UPKtB9022whZ5nP1K7LM9a+ftB4DG8lpfw26xAMuH/NnULZBgCvhTdTT
	RaPGG4yNRux+KrHrt8rsmogslgJie13C9Va5bETR523Q7Q9Aoxp5eKG5JVz17+jG/kFS/FJPhNR
	z4Uc7bl8pWjU+RhzjKWGEQFkv6x5F/v/EhPV5r2PCHLU0cXY8UZyZfK/b14d5VBr1+dL2ZKAxg2
	MNSQexheGikYk3oW8vA/Bc+Oc6o+OxeWAjee3vy9WIG/yhBoHPuMB2UWuxredF1kCdTz5+zokAD
	aySA2rkKQqE3h5MgjRaYMj1wohfwmirPDK3rUM/5RtkOzaY5vdOhym+NL1vXNX/XBIFKP24PLc6
	qFLVZe4aW6iaWaUWSfjS3GHLeFDcQ++As4aXGyGqnx0NiXR4dYrk1
X-Received: by 2002:adf:e64c:0:b0:485:8ee5:5ffa with SMTP id
 ffacd0b85a97d-48dba9de8f4mr35213414f8f.38.1792144393256; Fri, 16 Oct 2026
 02:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009140946.008206689@linuxfoundation.org> <20261011111313.27648-1-ojeda@kernel.org>
 <2026101124-rethink-craftily-cb25@gregkh> <CANiq72ndhLush3bugar1YGPnsein8min1k3_NucBxzFwCWe9Ug@mail.gmail.com>
 <2026101103-fling-stipulate-084f@gregkh> <CANiq72kjJ__OnsTjmsuQZH8+U-cRDCNnRpSuHU3PwYYT07Xf0Q@mail.gmail.com>
In-Reply-To: <CANiq72kjJ__OnsTjmsuQZH8+U-cRDCNnRpSuHU3PwYYT07Xf0Q@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 16 Oct 2026 11:53:00 +0200
X-Gm-Features: AclHuK-KZrzl8buAxw5--JIrQ3Q2GlG4ZFRpXT7mWgEiCKlqaDvBAHdKaEgr_aM
Message-ID: <CAH5fLgjjPmL-hiQ7R5zFG9BwWbxm6j+GnahoC11AiNxM7iyGJQ@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/428] 7.2.10-rc1 review
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 6:39=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Oct 11, 2026 at 4:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > If that works, can you, or someone else, send an updated version of tha=
t
> > commit for the next round of stable releases as I dropped it for this
> > one.
>
> Done (I didn't add vger).
>
> Alice: please double-check, thanks!

Thanks Miguel
