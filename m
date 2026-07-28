Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A193AA1B6
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220567; cv=pass; b=pMYa9FPdPL4+ogKBAbc4srs2GfhGbq2bdQkcaN186u4eqawbKX5kLFwZIxE53iAob7xxtAXFNxVfox+flqK8NUqaxZIZYv1l4ut5NaYWO8kJjh3iszEGG7Pb8M2v51L0v0MM3DpHxlziULFgKDk7tcYXAf1SMJxfHOdIieFs89o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220567; c=relaxed/simple;
	bh=uKxcPvvi9THW59oy8ygK8tFBpk8FtDiIG2d01vDjCVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzUzd/xA3hesz+nUvD+Epobw4mAJl5LTnLe4RQm68ABFaDWsoQ8xrdm/bDNs1YmTzL5mlVJsf/BDX2BsDP8noOBEohGUWfERDNMOn0xsF75hGWVQSPiuRWFDj95tgmHAB3cWRU8JjpWKPHvVbqUU11bKjPfVZEhswuGHDGQ8z28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HAa9Vfun; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAa9Vfun"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c160420289bso457405266b.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785220564; cv=none;
        d=google.com; s=arc-20260327;
        b=fxEIUNhcpreNtTmgqQ3qXHsg34wfUWO3BJNeOFlfjEoxT4p7hD1E79odrcj4LUKq9f
         75aALqqM3fUqlTn0bfAsuK+iVrQVvwJhLgPMxeaYLrKmBtbBCl/POQ00n0ioeNCb57FC
         ZL8kP/YcKVikhvbOIMdU5FxJ+3ryOYX5rS4LPZT/gmWm29UUm5uFCIgN64N91pobi8ab
         fdkHEZkPrdRlPOFAa+MYOdoTUNJGzgO5qg6pEKP/6auS/yjaICWh2idtW0Et2oEt5L7n
         3w6xu8rlaqrNrAKMgKxi0cH3ohVORADuTp6oqjJo1UYpNnwrcCWMX/PUofdPe98qxrgo
         sRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=duzfZmLmmvJhemX2jMFCmPO9f3XrbkW2eTjJNcX7UWE=;
        fh=h4fEo/SAv9DFFTdPOsCaY/y7GUPyWcRt6zArAUTtQvI=;
        b=Eb1SymmUD4idpwYk3dlptIGElWr5dnxdKjJQDkXN7TinXFvvzXM3K8B5GbF0Q5ksSH
         b5qzy4wD+E15DuPHSO+EZfpn7vJ6NShOO3pCnqnSwzHlafU7Kmfi6ts5tZXU23YyA9/m
         faLbLA1gJ8w4yyiSocPBD7xs1sAaadNFLHjPpfIiO7OO4RI9HrBOCu+MDNPDgs+jZ0VC
         4ufubZBR0KWLko+c8TmJnbr4B6eanInam2IhBHZljj3NilvP2G3sqtzeGnKR2HbThcwF
         XEiMuVVMB63f4ieAS/RdWhP71Ug41hDSchhHZLjJA+tkJqgNeNndjByVkjXLQJbAPXM1
         2BPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785220564; x=1785825364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=duzfZmLmmvJhemX2jMFCmPO9f3XrbkW2eTjJNcX7UWE=;
        b=HAa9VfunyfzIp0v1vTKNufbBGo3uIL/zoJzECyD1g5EZx7aJowIO+IfPQMu/cFtayZ
         BV3RBjaOBcrhfRWk9U27jsHc1VUPCSVfjgWE3Du/B+Z8kMxurDTDgzQ+lEkMclT6pzfx
         4BETg2XcLFfwTeifm7stHwoR8QnuhILBiIDoxonmmYJbLnyjMp7CLIRlOfuGIp3KGnIs
         wYXNCT77IfwC6ELK3Iov4kXqZKjVaQ0YVTBvOQb9UzTv+3M5wchWcGQvswlydQdXSu2I
         R+n91BdsSd0JtysDD6m0j1AbgdPNWpSjLY5vxfeYW9p5IIk8Zb57rqx5ulB8CvCSy4ag
         HI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785220564; x=1785825364;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duzfZmLmmvJhemX2jMFCmPO9f3XrbkW2eTjJNcX7UWE=;
        b=WjCU5EzSNBimfPemK6waovPlaOWXV89cO53IrfS8cGaQRA/cbovveCQICBZbDNFaZO
         yVsSTBSSnuzXFs+AWRvdSC3dTtxV2/MUcnB6v2+TTomopS6jMKjBqQngC4xONn0OhZ2I
         NYdBoKfTr18XzgxmtNZYWE+4Q62sVs/OjXm64yNKYFxPVvZ/fGPL3kJLAvRs87L0ANbc
         ncVNv5TIpgUOdwbPGRs9+gf7dDnm5F8ZzTwLw0t9n7a/1K3upW/TMABpkOZLXzOSbe1S
         CbYu05qRUnSWplNOFCNKmmUzwrckay01IBTYW6gFnBQfVArPqp0iOarHNUkvx2WM305U
         eAmg==
X-Forwarded-Encrypted: i=1; AHgh+RrnJdUx2Pm+AumM41O/9BMXS8Lrz2+K052QI/gU7+UkiOilRa26xV7pLJnbuSS6+9yy9pESkYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxtc37iI88sG14/4aPbkWzKpA8r/gSymvM2Ho81X+vDk6wWN87
	0sTAIgqwqn66WG8+1luMTctBNPxS5V7L6qZrnANc8cRbEqVwO7OAKwMtsc/DXNG38ecQn2+6B/k
	9ogxzK/PVscShskh29pvzgJFT+h1GIOB69a7b4ayYmw==
X-Gm-Gg: AR+sD12iF8C4v+wUxbE1eTcz9frmXi7HhMswGnKMDZm4rAYqa9Q9U9IYmRLsE2gjBz3
	Xf+0x9nf/5NSsE4aPMRtyngHi5DKjbg1Je7Bew8VoK82fgqqxglkgLrGrVQWgJWDf62LwylKC4o
	th/HaXdD4kMepptU1GstsywQNtbgomIYCUGhoPFPXpvpbyt6Qg2qlVLmRCNLDtrb62yHhurIMS6
	RirApCZHGFo2/H5YDx1uE5+OWzQe5uenmcvwu+eEcDJZUoJNW89zILAtWFDDaBU55Uk6Xtru5rH
	7tlYICxoHvPk/xS6Asdyvi7FlK2A
X-Received: by 2002:a17:907:d10:b0:c15:d422:3bde with SMTP id
 a640c23a62f3a-c1f72143dccmr45688966b.32.1785220564048; Mon, 27 Jul 2026
 23:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com> <20260714114654.3885457-2-shoubaineng@gmail.com>
 <20260714141359.7758575d@pumpkin> <CAGCp47zPkd6MWcMpxobphJp6giufpnJL46iFQMt9p76gb7OtKA@mail.gmail.com>
 <20260714153319.07b2b1e1@pumpkin> <CAGCp47wsjwstEebFcKSv+Hox0LJo=oYgt5n-2xfKWgq4WLZK1Q@mail.gmail.com>
 <CAGCp47zxaZsoBKeXz2YdyxbX8QOy_g8dGwnC9gVpJ-Sqng48Qg@mail.gmail.com>
In-Reply-To: <CAGCp47zxaZsoBKeXz2YdyxbX8QOy_g8dGwnC9gVpJ-Sqng48Qg@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Tue, 28 Jul 2026 12:05:52 +0530
X-Gm-Features: AUfX_mwmHSb9ULjRcWMzRfxF5YDIQvTQbS3OokFwfCg21Sudlmr7BMxr4LzKAj0
Message-ID: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
To: =?UTF-8?B?5a+/5p+P6IO9?= <shoubaineng@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>, 
	stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Baineng,

On Mon, 27 Jul 2026 at 08:56, =E5=AF=BF=E6=9F=8F=E8=83=BD <shoubaineng@gmai=
l.com> wrote:
>
> Ping. Any chance this can be picked up?

Thank you for the patch.

While discussing with T J, we realised that adding a selftest for this
would also be helpful. Could you please re-submit with a selftest
added?
>
> Baineng

Thanks and best regards,
Sumit.

>
> =E5=AF=BF=E6=9F=8F=E8=83=BD <shoubaineng@gmail.com> =E4=BA=8E2026=E5=B9=
=B47=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 10:04=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hi David
>>
>> The rollback here is the simplest possible case (put_unused_fd +
>> dma_buf_put), not the complex sockopt scenario you describe.
>>
>> Baineng
>>
>> David Laight <david.laight.linux@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 22:33=E5=86=99=E9=81=93=EF=BC=9A
>>>
>>> On Tue, 14 Jul 2026 21:38:07 +0800
>>> =E5=AF=BF=E6=9F=8F=E8=83=BD <shoubaineng@gmail.com> wrote:
>>>
>>> > Hi David,
>>> >
>>> > Thanks for the feedback.
>>> >
>>> > The concern is not just about the EFAULT return =E2=80=94 it's about =
the race
>>> > window between fd_install() and copy_to_user().  Once fd_install()
>>> > returns, the fd is immediately observable by other threads in the sam=
e
>>> > process (via /proc/self/fd, SCM_RIGHTS, etc.), even before
>>> > copy_to_user() has a chance to fail.  The triggering condition is a
>>> > deliberate mprotect() flip, not a corrupted heap.
>>>
>>> That is what makes doing the close wrong.
>>> But that is a program aggressively trying to hit the timing window,
>>> not a normal program that has managed to pass an invalid pointer.
>>> The most likely reason for a real program passing an invalid pointer
>>> is a corrupted heap (assuming the stupid coding errors are fixed).
>>>
>>> It is really no different from the sockopt code that receives
>>> SCM_RIGHTS messages.
>>> In that case once you've removed the FILE from the socket (or similar)
>>> you really don't want to have to put it back because the write to the
>>> sockopt buffer or length field fails.
>>> The chance of correctly reverting the kernel state is small - and won't
>>> be tested.
>>>
>>>         David
>>>
>>> >
>>> > The fix itself is small and follows the standard kernel idiom:
>>> > get_unused_fd_flags() reserves the fd without publishing it, so the
>>> > window between reservation and install is entirely under kernel contr=
ol.
>>> >
>>> > Baineng
>>> >
>>> > David Laight <david.laight.linux@gmail.com> =E4=BA=8E2026=E5=B9=B47=
=E6=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 21:14=E5=86=99=E9=81=93=EF=BC=9A
>>> >
>>> > > On Tue, 14 Jul 2026 19:46:53 +0800
>>> > > Baineng Shou <shoubaineng@gmail.com> wrote:
>>> > >
>>> > > > DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into =
the
>>> > > > caller's fd table via dma_buf_fd() -> fd_install() before
>>> > > > dma_heap_ioctl() copies the result back to userspace.  If the tra=
iling
>>> > > > copy_to_user() fails, userspace never learns the fd number, but t=
he
>>> > > > fd (and the underlying dma-buf reference) are already visible to
>>> > > > other threads in the same process and are leaked for the lifetime=
 of
>>> > > > the process.
>>> > > >
>>> > > > The obvious "close it on the failure path" fix is unsafe: once
>>> > > > fd_install() has run, another thread can already dup() the fd, se=
nd
>>> > > > it via SCM_RIGHTS, or close() it and let its number be reused, so=
 a
>>> > > > subsequent close_fd() from the ioctl path can operate on an unrel=
ated
>>> > > > file.  This was pointed out by Christian K=C3=B6nig on v1 [1].
>>> > > ...
>>> > >
>>> > > My 2c:
>>> > >
>>> > > The other option is just to leave it as a 'problem for user space'.
>>> > > No reasonable program is going to handle the EFAULT return by doing
>>> > > anything other than exiting.
>>> > > Even getting an EFAULT is really an indication that the application
>>> > > is already in a real mess - most likely with a badly corrupted heap=
.
>>> > >
>>> > > Anything else leaves error recovery code in the kernel that is pret=
ty
>>> > > much never executed and open to a variety of bugs.
>>> > > While the recovery here is probably ok, there are some sockopt call=
s
>>> > > where it is all more complicated.
>>> > >
>>> > >         David
>>> > >
>>>
