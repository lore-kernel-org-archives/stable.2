Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AD46AF17
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039605; cv=none; b=gqLzoC/BGbK3EBLMCvKwH6HLfQD4xjrRQJtsATDoQudesx+XVDGM9bQiLOBoSMrBjiUqv1y5/9340JLrSNlMbRa2v4A3APvsc5VY9kIskT00j1ejKyNzHkx7wSdquDzAQy83yi1XFe6Sq+4+hzO7Iq4NJzC0Rf7vmsfR1Mttowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039605; c=relaxed/simple;
	bh=t3+FgGxIANUdTs4dodfcPA0vqCjpmZzzbODy8MT0F5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrSyeUqueIPjbITDMuXPYWeAyJkYRkpaLyuySIKsCz37qAt6/AM8LH2LXIxIZ7Q8T9hp+KjsWi8IrTDa6LeO5ZMuz5prJPqDQGgocXk4d1vMOFtP0tAwKjMDCVlfUYAxPaVe1qcJgPEImtrj+EJ5Sjj57tRj9xSd6df22qpLWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7paIVOD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7paIVOD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso34011805e9.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784039602; x=1784644402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yqr76+rJ8iwHayK7NjLGqhPMmOMQyjm2NesJQTgS2Xo=;
        b=b7paIVODVxIpb40kzN5mRJBFqqVsZcioNrHpT1aNmYqxF8tVuz2kyfOREywwF1RHFQ
         7tEi//lXOT01O3qB0l/BU6dC55LcgsIScWk3TXPB8FxDnCVGCZxlu+Gbl0wBvweX/LIj
         zChGMtezvGI1H+DeGyD+toHJ1qteKG0Wq4EAiMZ8aXlTITdgcC5hpg7/a2ZwA4KiGRDu
         Cts/RJ1FcUJo0FybUBGRuiT/DGIbIVL/rgRiD7dnDig+Dc216f9HNuaUcWjxiwsbHXel
         UZcsedff2r/R2Sci3a2Be8y2Bul9M57oqQclxArFE54HcbUddHPFJ6KPkoVBlWAQm6JM
         6emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039602; x=1784644402;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqr76+rJ8iwHayK7NjLGqhPMmOMQyjm2NesJQTgS2Xo=;
        b=St3SBPZlubGf+sVVWgrGj+SUkTcdBKrrxKcDYXk9gGFVSas4q17KaagfwHbJCzH7NS
         7OymFIYjYGPlc29yhjHWSwx0sPJXWH80V52wGZpETn+vrv8I6c6CUhqEOqgQvT3lJWt2
         fFtSdYvwhxa1YRn3KEPna0xW3JmrVX7O5C2P2T//B29lN//9vWF4nBCtmP9iobkE/w+7
         qlY5gPrLt0iaqS4bJLc68YPELXMKk9hS0oHBMQIeasXBaavt9MuUVxG/LkoD9w6dRs6w
         8okivC5UcFnU/8enqlYbL5bmuynhA5KNeWZNbiisfH3Oqp1f2TXNXZ3fkIeF6R/RjqHE
         7xOA==
X-Forwarded-Encrypted: i=1; AHgh+RoTr+stUL35mWogMl/rUMPbXGNWmnsRCpQA+n3WoVUyeAMM19fbnliM4qmvTTsVdgpSG+uVvKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHW8zYnwwcyJWlWKuh8CfxN+2gKPI7lH1XrwFA4/OupQEaMuwx
	wGOk2MlePWqofhtTF0od7W1trnZeoNo5Rs+iJYq8j2t/npp2uvdRZ7PS
X-Gm-Gg: AfdE7clw/IzR6iVRqU+8sIMRipQujJu1BN1E1Rr+rmjSOkYpBYcFVi904e1GwecQadt
	DDMPfsY4aUp4qU9R+gTO0193IiKY0ENzuEuYq2aOa1FtggUnghu2xK6wMIktZonZh00GRxxuOze
	3rpspRSHeoeoaL4AbLZxBf5zMnhrC/H6rdgtxYPKinvC9HRTUWWTeMqYyXFoF9unZWq9Qi0BrHV
	fcAaOoN6rw3iQm5kEG7jDKa2m9V2UTqDaRxxBv75LBJVZXkBOd45s6WzTyS9BwZ+oDlMxS24QZx
	+vsIrcG67OVd6L6k2gA9gJUZgc2DCo6afKfdbexPNC1zL1BMuICtZyhOEppCoThXf4auRMi6coz
	bAFjNke7mNAR3e1KFpXARsgKLy8Q2orpYniEZsI3Gt2k1kqitZwDFqNpq99IvBYvTEIZpU33dc4
	VK1yQLwovBa4C5iqmQEY4Lq3LxrAivj8lH0kLa01WVutCgcJcheA==
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id 5b1f17b1804b1-493f883157bmr144382565e9.26.1784039601550;
        Tue, 14 Jul 2026 07:33:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e0f165sm270374515e9.0.2026.07.14.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:33:20 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:33:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?5a+/5p+P6IO9?= <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, Sandeep Patil
 <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla
 <srini@kernel.org>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
Message-ID: <20260714153319.07b2b1e1@pumpkin>
In-Reply-To: <CAGCp47zPkd6MWcMpxobphJp6giufpnJL46iFQMt9p76gb7OtKA@mail.gmail.com>
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
	<20260714114654.3885457-1-shoubaineng@gmail.com>
	<20260714114654.3885457-2-shoubaineng@gmail.com>
	<20260714141359.7758575d@pumpkin>
	<CAGCp47zPkd6MWcMpxobphJp6giufpnJL46iFQMt9p76gb7OtKA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jul 2026 21:38:07 +0800
=E5=AF=BF=E6=9F=8F=E8=83=BD <shoubaineng@gmail.com> wrote:

> Hi David,
>=20
> Thanks for the feedback.
>=20
> The concern is not just about the EFAULT return =E2=80=94 it's about the =
race
> window between fd_install() and copy_to_user().  Once fd_install()
> returns, the fd is immediately observable by other threads in the same
> process (via /proc/self/fd, SCM_RIGHTS, etc.), even before
> copy_to_user() has a chance to fail.  The triggering condition is a
> deliberate mprotect() flip, not a corrupted heap.

That is what makes doing the close wrong.
But that is a program aggressively trying to hit the timing window,
not a normal program that has managed to pass an invalid pointer.
The most likely reason for a real program passing an invalid pointer
is a corrupted heap (assuming the stupid coding errors are fixed).

It is really no different from the sockopt code that receives
SCM_RIGHTS messages.
In that case once you've removed the FILE from the socket (or similar)
you really don't want to have to put it back because the write to the
sockopt buffer or length field fails.
The chance of correctly reverting the kernel state is small - and won't
be tested.

	David

>=20
> The fix itself is small and follows the standard kernel idiom:
> get_unused_fd_flags() reserves the fd without publishing it, so the
> window between reservation and install is entirely under kernel control.
>=20
> Baineng
>=20
> David Laight <david.laight.linux@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=8C 21:14=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > On Tue, 14 Jul 2026 19:46:53 +0800
> > Baineng Shou <shoubaineng@gmail.com> wrote:
> > =20
> > > DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
> > > caller's fd table via dma_buf_fd() -> fd_install() before
> > > dma_heap_ioctl() copies the result back to userspace.  If the trailing
> > > copy_to_user() fails, userspace never learns the fd number, but the
> > > fd (and the underlying dma-buf reference) are already visible to
> > > other threads in the same process and are leaked for the lifetime of
> > > the process.
> > >
> > > The obvious "close it on the failure path" fix is unsafe: once
> > > fd_install() has run, another thread can already dup() the fd, send
> > > it via SCM_RIGHTS, or close() it and let its number be reused, so a
> > > subsequent close_fd() from the ioctl path can operate on an unrelated
> > > file.  This was pointed out by Christian K=C3=B6nig on v1 [1]. =20
> > ...
> >
> > My 2c:
> >
> > The other option is just to leave it as a 'problem for user space'.
> > No reasonable program is going to handle the EFAULT return by doing
> > anything other than exiting.
> > Even getting an EFAULT is really an indication that the application
> > is already in a real mess - most likely with a badly corrupted heap.
> >
> > Anything else leaves error recovery code in the kernel that is pretty
> > much never executed and open to a variety of bugs.
> > While the recovery here is probably ok, there are some sockopt calls
> > where it is all more complicated.
> >
> >         David
> > =20

