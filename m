Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C153B7763
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912535; cv=pass; b=XbnFxN3UcvjpjVyr+e3GBc91faSfydoy0v9gTeGH374THgx8SjcpI4OUT5r2K/RMUbqOiz+l/i2Qz0eGPDmZHzuxElUKt3uWvLNNUuIjfyGurrg/I42rcelJll1ks7VTjWa/Llz0qXNSfItu3uSCrLb27+gEnI7poI3PFQxAlKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912535; c=relaxed/simple;
	bh=nEe6Hp2P+fr54/g8RIpCfyjhQRc1tqxdIbRPosUg3Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjV/v8X3Xl8lKMP0xK7IAb5qmUhDmrihCd9YfUrCySzJGbju3mZ+sxh8azPe8dlfzauX5bBlB/GqEOXuBkHhSl0Cn9O8BIIFznVJfb213KeoTRKQIJK0smXxGrn4/tGKQkfgDRGcl9p/km0kjS8SYNTo9UlQlrY8k+MzLmLwkbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=i4CYwU/n; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="i4CYwU/n"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8419ab3a297so1679388b3a.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 02:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780912534; cv=none;
        d=google.com; s=arc-20240605;
        b=CaFhfHNwYsLAc6ukcpgo9NxFyet5qWbISav5vJdrDjcssZxOenn/U9y5MUJjeMlQu6
         vFSoFg0rk0q22wGp0u8SVoir6ODTyrr5ygknjcpyqUTJF+5Wf76mIFz5qLYMAofu90Vc
         g7wUF3wjZO6eZtH+ehU3yug51v8hR76vLjVFwD+rYTLmAVFHSkAyUk82BGjRBt2ExSY5
         UTkokMv3CabTpHoAK3l6mJ65g2F0DUV0k1dgwKgLVOtDrRmJ3lH/hl4qRUgUK07f0Ocp
         J11R/WiKsjv33c4F3C8uxAFCYP7Xdzbsbeb/omFweW6NPk7CQaXxCm6egkjHdSA4OV/z
         95NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YhR32XRkG8GtOPOWI9COuVD7tE9ztEbEqFhQoZ5bTrU=;
        fh=ljrwdog4K7gaj8ZlbEcb7Pj+vdmwls/qQqF1sQ0eWQU=;
        b=N+dYTMPCiVPVvUZTTRSjPwkKhQPEviM/C2G1Hx/LxMFv/wuWYq0JIuLYx0sTZa4cbC
         n4c0NHs/1FZOaFFdHfxk9bX36bwWMYtUNlhdEXuT3YhYTq6jC0eMR/qqxuXh6/lcjoA/
         lvfbqdKohWZMxp4TAvhlfkpwkfkbmp9cLpous9ihn/zoSLLPQVIhFVZkoZ6shnR+J68C
         MAGnfaLpBdaZtdYHK1o9Ri6DMCPzete4vRjXICSsNea7nWbi+4tbQn+mMfBw/bKRVc3t
         AQRyIl+qE2vnsW28iynJyE7TwIfG9YnkuLoZZhuH1RxG2kaG4l+kALd4KQlVFHE50akJ
         POsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780912534; x=1781517334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhR32XRkG8GtOPOWI9COuVD7tE9ztEbEqFhQoZ5bTrU=;
        b=i4CYwU/nzgEz2DJ9RMUlC/aTqIq3h769lyqC2PXduc3Cf/mrHk1dF8SVEKi27tzraO
         WQeGWeCP2mtuQpohwOE0QevDyJzDwyh917iNpTWt7FrdMKkVhAdqF43tkNdYIYCPfAjL
         e+z6nda8VPORPYu6KTs5nQa18dbaM5YXXsaus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780912534; x=1781517334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YhR32XRkG8GtOPOWI9COuVD7tE9ztEbEqFhQoZ5bTrU=;
        b=V7OIrC2Cr8c1Qi2p2H5mh3VvrXglX+PdEMGGqEcd86YpPn5xeBkB/vpFkh/3YSBdKX
         ZGiG/Dd8tp/tPbHCI0t2gnMZ8NuDZPeSFuWRRGcSGpz7wmHWpKRZw7vDYHB38sgjNGu5
         Rdr5LD4Rmbnh9g1ZX7BXkpOVReGngBq6W+Ls/oJu63DbhQy+2LTW+sjn9vKdgENeEH5d
         cZ9nSE8jNa6Azw42MeMlwWqZ+zGHYDUnzNLV4FRFF5bay8phyvjqNsdvpi7KSFOGH9V5
         E40JtMirZ0U/0R2LQlmxHFYIrZCzHOdaOBii7c+1YJYXEax4dEL1T7KIJ7hon+/SK43h
         h2Iw==
X-Forwarded-Encrypted: i=1; AFNElJ/p3quz6aE3v4fhLTxcqarcqtDB96/D37jJXreKWgc+G51mQSJEvMellFK2eA+/tOz3LcxRnx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0VR6xcG2Up27ZJ9guRH0OkFQ+8tVHltibnUd+GVdPujy3Bto
	2b8WauUpusmIjGs0qbYr8Y1Xp/qhrFd7u8JMGzhygYiY8B72xDtGVJ3Sja2ayMRhDuphOiXlNWn
	uJkQj2fOgBliwbfins5uL5D2Qc+uhGWwtu3ZZuCZG
X-Gm-Gg: Acq92OEUxB5H7t+cm4V5ZpqZijQ/m9Dx4ev0+UwZqpH/mQRKw93yvnZ392eFlQeW+bo
	l8l345j77QT9FRcXy1Cu8PHhSwtZp07mGtTaDCYnQqQ1/o64ty8rsszmCwsWDFzmJtBzahftW3m
	72uE6tFRDHqp9SS3OIHdCk8JX/ddGHnx51RbcBzm1aleT2W7XAZOeT031VBDZeHSQGB1SM9FMKP
	TLAlYVXKR7rXHnjAaw46EV6QegtARxg7wFyLcivcAwWghpEbAGL//0myovnbkl9vh7dJzNkpl6N
	StNqcuAi/Ynjx7RYVeT3Nqsh0hwa2Q==
X-Received: by 2002:a05:6a00:2d0d:b0:842:5711:9a2f with SMTP id
 d2e1a72fcca58-842b0fb2273mr14704387b3a.36.1780912533858; Mon, 08 Jun 2026
 02:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
In-Reply-To: <20260607173214.92693-1-ojeda@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 8 Jun 2026 05:55:22 -0400
X-Gm-Features: AVVi8Ce0VqPP4wrmrfgQDErKpRLi3Z7rbl8b4dCcmWnRvhi1OSTpE0ZX-2GG1EY
Message-ID: <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org, 
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
	sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, "Kito Xu (veritas501)" <hxzene@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

Thanks for reporting this.

On Sun, Jun 7, 2026 at 1:32=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> On Sun, 07 Jun 2026 11:56:37 +0200 Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.93 release.
> > There are 307 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue, 09 Jun 2026 09:56:47 +0000.
> > Anything received after that time might be too late.
>
> Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
> for loongarch64:
>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
>
> arm32 also builds fine.
>
> On arm64, I am seeing:
>
>     net/sched/act_mirred.c:451:43: warning: variable 'm_eaction' is unini=
tialized when used here [-Wuninitialized]
>       451 |         is_redirect =3D tcf_mirred_is_act_redirect(m_eaction)=
;
>           |                                                  ^~~~~~~~~
>     net/sched/act_mirred.c:429:18: note: initialize the variable 'm_eacti=
on' to silence this warning
>       429 |         int i, m_eaction;
>           |                         ^
>           |                          =3D 0
>
> due to commit a01fbdecc3a2 ("net/sched: act_mirred: Fix return code in
> early mirred redirect error paths") here.
>
> And that one seems to be missing at least the assignment to the variable
> that happened in commit a005fa5d7502 ("net/sched: act_mirred: Fix
> blockcast recursion bypass leading to stack overflow").
>

Unless i am looking at the wrong code version, in the current code i
see m_eaction is always initialized before being used.
m_eaction =3D READ_ONCE(m->tcfm_eaction);
Probably a compiler false positive?
As per suggestion emmited, initializing m_eaction to 0 should help.
Not sure what the process is.
Perhaps, Miguel you want to send the fix? commit should say "appease
compiler ..."

cheers,
jamal


> I hope this helps!
>
> Cc: Kito Xu (veritas501) <hxzene@gmail.com>
> Cc: Victor Nogueira <victor@mojatatu.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: netdev@vger.kernel.org
>
> Cheers,
> Miguel
