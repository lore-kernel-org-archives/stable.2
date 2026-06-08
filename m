Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661539B489
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950972; cv=pass; b=sDdE5R4G2tHmXMdVboPToQ5nY+F9pc26ZpOKWHAUjxRBfL7y5nRjd1bxbs/29Tc+A31INN0qtYHkXCT/HPVw4HdxruZMIUumvPuFOBIRGx18H8b8mekLUAfJwyurJX925PxTn14bNDDcctqK/xzoZxt1WeSFuBQ6nDL5NXORgSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950972; c=relaxed/simple;
	bh=B2tN+Ldk/5pCXIYwJUJf0VGuPcRdSjXr3Cs1XxacmqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQbJ0K25my8BGhyOAXBRjRFiizousMr1eCHloOg0vy/zALd7y9xP9jy9pPMZqeN7oejXLWWptKR+rvZshDghQDJxwGk+KdpILkbTvO5hOeta0PUus/Cgh9dKw0pEMtG43d2RPkXn2wIGJ4c5elRZXvyHkFGYu+GH6cf5IgRX/MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cVdgS4eJ; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cVdgS4eJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842273a2c4dso3197760b3a.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 13:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780950970; cv=none;
        d=google.com; s=arc-20240605;
        b=lCXE1bG4OyT4d+bWwaJOt0hrwBhVn30nP6GHoEeRmcpm+AIMPky4V6ZhKDy3e1e1AS
         2dNL3pbk/JHeON47kiPOUWLZ81jNpV/fSCfNEsxfU/UqzyMeCiWT4DtfQeFsW4IJblgg
         5yjduLMhliFyej6hptFpN+IRA0vqxNTO8RpuMEuZB2xFAw9Ky760a+JdPvqvRT1hUivT
         eNT/1AeV0ud5QhjBTBa34ddp02BqekoC+/wcCMJzymhgtsT0RC7wDXp+4XiQXycTFy6z
         Z24LVz5scbODwWZOMsD4O286vg1nOKaClz6VxLzpshyDZJKbrmqIDTdDpWelTxnEX8E9
         VHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oVe+ITC2ml8n3gt+xHvgBn+FPMhVSI7g98/qjcMm7ZU=;
        fh=Bb0YFrvYxOCQgOGidtexoXOomHrkJ6mXJ+UfPI4hI20=;
        b=QnRcQzqr9nd4T26MSy0r0HN3R+JhphzFfD/lRINrEJnrmBL/gkuTlAFtZQJgWawqHA
         a1HcaeSMGKPDrw13nyFTdmOuJ7rL7X70X8UnnkVKHCTDRAqJinFRfPMBoxaW9Q3NZH/F
         F0N0mDrj8cw4B76ik9YIAzmcId2RYjA2vhpjsrTjllMIdMjkYPCHid07hsGBIguVFxyj
         ZKYMor2ILcUcCZduKBjCBzFbbBpxT4iwF9fIkr+0TEhQAjhfx+YLv3Cqj2G+UrBrZeN9
         3BH4cc1OHC+PjSBdnqgf60/ljgq6rmLJrFap7F+lvXhrN7kN+29oziwr0czhnovz+7ho
         Hbaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780950970; x=1781555770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVe+ITC2ml8n3gt+xHvgBn+FPMhVSI7g98/qjcMm7ZU=;
        b=cVdgS4eJeN5HgZl+w4tI8DIit6ZRbVnjIJdVdral+2FhJrH9jMnq0s4E+LSDmDBgbq
         fUY/ezY7NKmPj1/rjBo4ZI1Rw/IEClbaFo2l2nLOavxm6wcsyNuJqGKaMNKIvrBMt+/s
         P+hm39Fwr2/RO11GTlal4Q1glmgKfkNFnwsKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950970; x=1781555770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oVe+ITC2ml8n3gt+xHvgBn+FPMhVSI7g98/qjcMm7ZU=;
        b=Jgl+45hvspBxsSY2Q3pkpa+1s/R5+rWUv/qGT/Y+0434vPcT5qW9kHXM1CyVW0Rloq
         BPuOc8Jrsh5i0COLHLQXI8uzlXRcvCjjq5EPlhIc7X9jATeUU/YFXyK2PCPV4c9/lxX0
         joaDbZBwSw0v13U0Jyofl6hfF8NvktzmUwy2I8aB/tRqAOIvFpIrHrGcP+TYfxKtDSEV
         yRvrQ3SixHTqVE0ZzmWh9HloLkp+S6Z1RZAOny2+IdItfzV7OrtkUYb+7aalWj4pgZfN
         4NC6hSJQvOOHF259ECVIqSyItKmMAdMJ9AsPemF9S7buRJXWiqL/KLXZoKL0M+Ad6WQh
         u68w==
X-Forwarded-Encrypted: i=1; AFNElJ89dCarS1IwZXl29Ry8FAdY+1vmEmOwr58iroqw2FCkV+c1ym+ElUiypZmjWBP23tyO5FtD6UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKbEg5RcCNYR6AcxQ9CCuWxLUs+SpteE67YJN47KYw7bjPdOO
	4IaMx2n0qGmLPs6EsDKhAVD/MOb7JPDS1yUnUh4kK5q8LWHiyiM4KJKRhj65MSbynNKrr+FYW/m
	fbYdwtqbFQP0LCQl99YF+f+VGKBDcAazSQRU2B5N0
X-Gm-Gg: Acq92OFtMjw4FXf7+zCRH8t7DX5St8MbBuw9Z+/32xX+WCX5zgo1g5rSdBuBI3aful5
	uHDAgUepoDYJ1uqbsBOLuW87mCE0t7sWB2y6ok+UUMr8moc7jG1gugTdb7lpOH1oag82/ItZGHv
	vKDws5r1pI5A3zAVUqKA49BI24GK4wBtWBtO7XDUTnMD291gMRMgjgQ3Cy1IZifRlRaMSvakyu3
	Q3GEO2LRfHscMfLswK5npDxuOf3K1OYg2FOsq0hA4xc4YJI8Zrrlwzj4tKHjugXyUlYUT5apE32
	e/DpCeC8lMsl7+3nURM=
X-Received: by 2002:a05:6a00:4b04:b0:83e:d427:9817 with SMTP id
 d2e1a72fcca58-842b0db7dbamr16329172b3a.11.1780950970140; Mon, 08 Jun 2026
 13:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
 <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
 <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
 <CAM0EoMmHd10iivCpDoEd3h+eae9fSnoGWAH_AkwFhrnS6PN63g@mail.gmail.com> <CANiq72k6J7FYT89svtX5qbCUWg-MKuhUHaT07cjk8o7PqaF8+A@mail.gmail.com>
In-Reply-To: <CANiq72k6J7FYT89svtX5qbCUWg-MKuhUHaT07cjk8o7PqaF8+A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 8 Jun 2026 16:35:59 -0400
X-Gm-Features: AVVi8CekC54iinBDQEVgU-dJ9AL5uhMqEzLEARHoPqKy0ZaeCQmHeP3rPtW0Dmw
Message-ID: <CAM0EoMn9EA_TS80QzXsTscBpCgfJHssq0GHtiNbrMU3FAiP2mw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, "Kito Xu (veritas501)" <hxzene@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Mon, Jun 8, 2026 at 7:16=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jun 8, 2026 at 12:57=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > I believe this bug slipped in during a small window but was fixed very
> > quickly. Probably some fix never trickled to stable.
>
> Yeah, as I mentioned above, I think commit a005fa5d7502 ("net/sched:
> act_mirred: Fix blockcast recursion bypass leading to stack overflow")
> is missing (at least).
>
> I would suggest reviewing the entire chain to see what needs to be backpo=
rted.
>
> > If you can point me to the exact tree where this happens i can take a l=
ook.
>
> This is the 6.12.y -rc tree:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi=
t
> linux-6.12.y
>
> The stable kernel team puts the link to the repository at the top of
> the thread too:
>
>   https://lore.kernel.org/stable/20260607095727.647295505@linuxfoundation=
.org/
>
> > Still curious: So only the arm compiler catches this?
>
> It likely gets caught by other arches too, i.e. I just happened to
> catch it in my arm64 build.
>
> This is Clang, not GCC, by the way.
>

I think it was too early AM here when i was looking at this.
The answer was right there all along in what you said: The missing
piece is commit a005fa5d7502

cheers,
jamal
> I hope this helps!
>
> Cheers,
> Miguel
