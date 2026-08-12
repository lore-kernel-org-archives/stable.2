Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710B46E006
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546206; cv=pass; b=ULC14pShjBpM18rCg2zZiBtZ3I4bU1ZA2eQgCKy+KTMCNysx0chF7ueRzHQEPZ9fMerpnRvHr4aiSxkXCKMEEcWabr3n0Q53/8kYxD7gdYIjikdj9wofYcn42bVx+rrRRKHuHjmXIv4CQRpT7BbZSP7M2PPVFKp/rFuvqN1LiZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546206; c=relaxed/simple;
	bh=9++DEyhWIDbR7vGF1FPZPJTciFPAbeer9QqFVsQum9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ons+f4ssx1QcS/uDzWZsLuk/tb0rdFQA4dsnBuFwdRUZ35icr5zm4ESp2roidI88qh1XUAuC+mMAVZz4wq5qWWZGvGD0uJ1cYfmS4ZyyemtSnhlvbswpzuVA5m8ZZjddxUmAUk3DHz5b6F+8TtZxe/CBinCF0s5xIddb4moMb44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvqNFaz1; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvqNFaz1"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbedaf975a3so43011a12.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786546196; cv=none;
        d=google.com; s=arc-20260327;
        b=Rrk7NZtq5IfdgvgmdWJJ/ZZYLaPXlM3eMiov86W8rB+aZC8iTUf0Zbegdvs5LLHsMg
         00LTQoH9yzaT+tsJi8wdtICF9dttHrutispR/GD57D1sNZq2zBoE3v5zUB2I3rWdOp5Q
         xO0QJqYvUtCp2xaSwHdCguKRIrCDpsbDLP3AWl4zuJ2/sAkP7t5ZM6XOwWwB7UAnvMEi
         c6vmUXSVjFT4w5t2w80q82nql/YbHx5iFPSSNa3d4V56TB7EbA25YYxCHr5QsrLst0sc
         CIl5L6W10gpD9wxU+SN1EAHz9xU1UWUt0JCN4yfakLCfwde2YT7gW8JQiK8zMZXLImZL
         eLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ot/f134CaNd2ZZh1uYzIr3IyXzUgXu59DTxBXmvb+90=;
        fh=+p5nlspSutHQ5HAOhTZmVNWddBVrWJOHYxYSI5jn1QA=;
        b=RkDVW1Gop69cecwLQrQTqH4ydAE8Y4KYsMn89KPaqEw8EYeIw1Tuh/QNgVNHbMytnW
         fuvCCNLmEkUi1eXBGUTAMguHjS7BsgDC2GSorldvwltZGx5SsyXsc8UBR5dBs2GJROoh
         gusSJV9ueqk9nKRJK7HPQ+fopjzQblALDRmTmhAWHYNLEP+r973vbQ5BZ6ititHtnFLi
         bk6l+wuLVxUiATp1d6teGKYKFQFz2Ii8LHvBpa6ydLXSgg/9YqhSZsBYUM2Qm1Tknt5h
         xr3PjInMUlKymbq3jwBh1oDFVqHuqPMHBN6DpoDoDr+5RkPV9PoRiG6Qfii3gmmkT+FG
         zpNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546196; x=1787150996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ot/f134CaNd2ZZh1uYzIr3IyXzUgXu59DTxBXmvb+90=;
        b=EvqNFaz1K/V/0FbBIzpO5dG0u6XcGuDUP7Kyp5GqFufy5/mTLC9LSC4tchP9kwdtFi
         YWUAJ4O5o8ze8yG6jSgljklUZ70OXbYFbbaHoVWvgX751bu4KhdzNbVdsyeeX9U/8GKK
         qTQddAq6z5jQsEN9u1kzo3GEFFphLR5E480KrZSAMWzwVjeizYq+XWPAX82/C/lg8NcT
         VvY5+ET+oZRvBYwfzWkJHTgaiJwZ6ULUHbX/t+ysjDsSCsYn7JU4hlUpcVAeZDmFxLH4
         SaruXIcKUZwdXIv/ZFHh2Vv7E7Tfz93bg0RvUcvdzWZghHAe97jRh6pthO0z31IFOdT7
         NuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546196; x=1787150996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ot/f134CaNd2ZZh1uYzIr3IyXzUgXu59DTxBXmvb+90=;
        b=DSwli4Ec85zxTwZJboh/3TmHfjVQz167ykaBTzRS7KTPOSG2jVjYJRAI8YtxQehTNJ
         OGP49cWMOPo/p+vEb17aWjtnQmq+o1VXuXs5TcOxUPdNOB2HYa3/Dx3EqiFmKdQI0Rtv
         SRk+qDMiZWBnk9P7oQHkImJ55KDeIbSRZ626khWkqeIONCzHuiDCh8jquKRONjemXqPU
         /U5sg9vzHvN6ykW/XKP72ePR+UZBm3fAGdE18nZ/z6pomB18M2Md7Vz5s7gxn+rWjwO/
         BmqquQdq+UpoHeMCuxfx6qZpOL/MjgRCBxV9lyYGlcjp1IOcH485Z0/vVunn7JyvrgGF
         5gjA==
X-Forwarded-Encrypted: i=1; AHgh+RozBE8PtCO7YqlIwZbtNnJprxf71RkpBmmgyGL1fp2NES52PFmZJQIRiWuPGcjz9v0yMk1FkbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7I7q9JLKEo8tUqXgzALMNryrPz7OqAJSDTYo3qlOrwKm9rI2
	3vAcM8VmY7I03ad43nFw3fN2fDaQdbH2XdtMocT2wTnwiVpcTUYmRLsFQPmPqUL9sEuBhfz+DB+
	x94iWaWMqK7tq8jQgbZkYtjwsm+nEXsk=
X-Gm-Gg: AR+sD1038Y21S1qL3ST0G5js6MJH8nIqGWttVAxQbci7mB75dMOJxWIjUA1yo0exp66
	YwbOagSVV1l/KvZMk/1g9+VamUmfWFuYtd1I+YzMAx75y66s/j/a3OXwKycIbYUl40uEdun+zvD
	dWGgVZ/Qrc5sXJgRIM4HMmkI+gJ1bOinLnOekVeRQ+nWgASojOh3vm9E3V5aPt3szbbpwJEv8Q9
	m0/XNT/ok3PY0efAssTairKXUDmP23o2FY8Tpm7J8OG6zbvC0hHoatCgoYJfcBCGLZL3DCDubK5
	F6ZKeC8j+qNDXhpU6KXyye0zZeSTMEgzmn2ny8FGEzdeUx9wOFQgKDFniKbtqyXJTawG1QbwWzE
	F1olbyiIK6FdUYDlT0MMHZVWLO3PxjgQ=
X-Received: by 2002:a17:90b:1c87:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-3930165d7ebmr4278871a91.4.1786546196340; Wed, 12 Aug 2026
 07:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh> <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com> <2026081151-reabsorb-calamari-7442@gregkh>
 <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com> <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
 <2026081216-goon-nicotine-6d62@gregkh>
In-Reply-To: <2026081216-goon-nicotine-6d62@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 10:49:44 -0400
X-Gm-Features: AUfX_mzj2HCarj37nq6qUUz4-f_2TcoeI2QeBqGSJvYG-vDLTLtMkqvEmu0fq64
Message-ID: <CADnq5_OySMeizELEwN7Okjc-SKRJMvO6dN7X-zwPp_eQuz67hA@mail.gmail.com>
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sergio Callegari <sergio.callegari@gmail.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	George Zhang <george.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:13=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Aug 11, 2026 at 01:25:14PM -0400, Alex Deucher wrote:
> > On Tue, Aug 11, 2026 at 11:25=E2=80=AFAM Sergio Callegari
> > <sergio.callegari@gmail.com> wrote:
> > >
> > > On 11/08/2026 10:08, Greg KH wrote:
> > > > We aim to be "bug compatible" with Linus's branch, otherwise the
> > > > "pressure" to fix those bugs goes down.  But I defer to the maintai=
ners
> > > > of the code involved if it is being worked on, and they want it
> > > > reverted, great, we can do that.  Otherwise we prefer to leave it a=
s-is.
> > >
> > > I understand. Sorry for asking about things that might be obvious to
> > > most people here. My expectation was that only a selected subset of t=
he
> > > patches on the Linus' tree were to enter in stable, so do we really n=
eed
> > > to have stable "bug compatible" wrt this bug? The original behavior w=
as
> > > not free of issues, but they were rather minor (a reporting issue). N=
ow
> > > we have this very bad behavior where the display remains dark.
> > >
> > > To make the matter worse, on systems that have encrypted root the scr=
een
> > > remains dark also on that password prompt (observed with plymouth).
> > >
> > > In any case, I managed testing 7.2.0RC7 and it is fine again.
> > >
> > > Looks like the Linus' tree has more changes wrt backlight, and the
> > > interesting ones are probably those in the cumulative fix
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D973fd9493ec21f12e760fbbedeb7b0b2317c02f4.
> > >
> >
> > Thanks for testing.  It sounds like we should revert the change from
> > stable.  There must be some dependency we are missing in stable.
>
> Great, can someone send a revert?
>

Just sent.  Thanks.

Alex

> thanks,
>
> greg k-h
