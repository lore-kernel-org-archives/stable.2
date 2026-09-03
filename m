Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553935677C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404685; cv=pass; b=izp92gsNZZpdaApvXkmZcWktCrONlRZc4Zxd+9vSrWfA19+ZZPK0c963AO2NCrgJe625fX471JwfZEgSOUzX2OYbNh7bkNbr02yS+f3aKwJ7wci33AhJ4M29U5BsRMxPJ62BQI9Lct94tPxLDcR8CDC+awh1EfO9PtLSXg/m6aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404685; c=relaxed/simple;
	bh=QQYTUemsDne+BYSAP9dnTyI3rj9XcbDoRLebNglDc/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvNmsX2BK2KeTVzDebT+fgoR/QKunDy7HwrCeAYVl5zmZ1YSMgvnZpzj/7Zq6Ldl8priGguRzAkHGGkLYoK0AuD0cQg9YFAUHPE/gR/YGVMbfFkddE14sTal0/4+ABWYzgSFAsug5VoKB2wKVWOqPkdofEviWekudlDDwtnwwq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MANcOnQ9; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MANcOnQ9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so11159525e9.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 20:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788404682; cv=none;
        d=google.com; s=arc-20260327;
        b=fOud1jl2zmEKnPaZ9S0Z0tvM8S+rSv8iHUg9LcPeRjPBNF9eVppQ6FnBH6sPpQ1B9F
         iJ+eTj3LToFjhSez/rKKmLWYRXafFHHwy4YnlriC59haGcnfWLQKmQyQ5mAFPZhSxAVM
         xsPjO2lH/9Z30lqEYOzgOHpRpne+kORAuNB0AoTeeXIQEmsOEQ5asjQjM9gVNIz3xZO6
         XEYEDTmyCREsaBvE2p3fX6jurFmsFDa5PvysIcb2P7M6E4NpcJVF86r4H5qXUqL/c5en
         GSgIipeW04+YXTmFfLE9pnHMHv4MKbJKvvT+RpQIjFWuwyWQIcwVKLkqbDWhqcFgUNLh
         UCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kp5kiEjY56bVt+cQGrCKMjWcI/IoAXkJImRk69V/Bb8=;
        fh=qDJkA/crIVWjx1NqatQJyU+13FIpNM3346pDkcuBXsY=;
        b=nLauNOGFu3Qp0OZGVb9Da4XSpWqR0BAp3swYS4p/PnHBgS0oooUlH7V31cpSJOncJQ
         wFnTDIjaIfp0k95Q9Q7PdAXZEO4hCEwFmkEtZKqI7AxZ8jd3pfvFNiSyYc4Qa1lHGTSQ
         TZjKmnw7C+a16Skx92mXPL20nw4qRCku0gPMZ707ps5f5L3dcWiow5q+zgUMsZr4Pif3
         S7GKwAc1Ezr/Md8hETPlwIn/SJPI5vfT7zeNO0FD8FYXAcy5rRHlV+4/I3dOQXuzrvG3
         VzCEEnKUQaUyKBJU5ADcBFKtdMsNCkHknISwdmc2WXVccE5ka6hFU97TN45zVheExfly
         qZLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788404682; x=1789009482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kp5kiEjY56bVt+cQGrCKMjWcI/IoAXkJImRk69V/Bb8=;
        b=MANcOnQ9GeWgXxYPg53GrybZsbkDTdD6tHARQ5LWvHVtnA53hZb1OMz8J/gYlB8nX3
         XqN9wlePMJcvS9d9A9BbRSKtX3s8PzjlU0v8eoRVOxRjU2N4nh3FGXv6GSymVhJ/nOFg
         yvd9LChLh5+he7FqHvHxeAgwa42EK+KQ/FfB2fuYXuxNfnLvxbbWRZHgXtrPM5I8yYwc
         uLePJe6t28CklkV17FAKQTcEzo5LOuFx8fSfHCG5GGMifQ4SNX9Y3S5akTYZ/fr2D30W
         G3CUbRkRSDCEBdURh+816BYhWW9wOi3IVNaZwQ1oxr2wsRQDvroh9n4nPN9wJqVk1Zxr
         1+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788404682; x=1789009482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kp5kiEjY56bVt+cQGrCKMjWcI/IoAXkJImRk69V/Bb8=;
        b=hVS0oTyZaUaasCCSJVpVZKZ0GeS9ScoKroo3eMKm/HSPiM187NDYa7irj8j7Jrmjg9
         GvEEEL3mdCV4XhSP+04pEnstTBEeTR0SWD0UVyd0IJdPN+tWibmrjmzcVRMNakxoWYrj
         Vz/HwPKsuD3Hi1R1zc2aXDXVY6AVLI41mFztMy7cYXiU9vSqwcuIk99jpRQ/J9pJ5NTJ
         glQIuQ+szfRwduwfQOFlAHsywN4/9P1d1YBwUZBMexIo0MURdjVZcbH+W2lCfOrlTQhi
         132Nt7PET55ZM8tR8XJ9kLP9FHsqLSPhAXv67idu7N1OWol/tyZW8y2Xyvh2jfCzCMYE
         Y0Cw==
X-Forwarded-Encrypted: i=1; AKwUvByqh58UYt/3E1HkzflLgjxuTHezBw2STBfZUPnF+kdfVODhVN2mys75dQwcBew6U9kVimS6kxs=@vger.kernel.org
X-Gm-Message-State: AFuF++kFneuGlvWFNO2jEb5asSuNeyly1zBAiHwEyTMKM3my/ajipDmK
	UGun6oXtMDyeOIyOkl3tijZy4yL6gdyEJ+bQ2IQbgbzidJDCgH7V3v4mIQLAZEnD14Y97wtzwsF
	dpiRRmjKtTHRv9XMBfwnAHhzFnAM9BFEtaokiiM7NlwFe
X-Gm-Gg: AYBFou0v5+nppEaqU/q9Clvnj7j9/gRZcJwMnmnQMD3ZAQ9fr4xD4GSE2bT/Y2n5LOY
	3z91b3Pmp+OYSUbyI2YROCiDeiCyvOh/GCydMGM7JjuvteW8Lnnq54Z11rQyMn5PPuJtMDEDYpU
	pfTKLqdtfRO2zfir/Ify/CyJ4gLowesSquMqyZa2pSlY9zj3HtLfx5nObeMnCzKdqX7cZUKD3OS
	3ssDmLQYLMd5f7P4c5MmF+/Zn6SJwFIG2yHS8gYKutuUbNG/PGDJY5haWDht27oPisUQ0Hv++Bg
	ySyZLpxNlvz8zqyxY0LoOpvxgWTCbVXRT9sMW1g3ZNHW
X-Received: by 2002:a05:600c:8b86:b0:49c:d27e:8f7c with SMTP id
 5b1f17b1804b1-49ce5843b42mr158801755e9.12.1788404681727; Wed, 02 Sep 2026
 20:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902022552.1890610-1-ljp1205831794@gmail.com> <871pbb7jqh.fsf@mailhost.krisman.be>
In-Reply-To: <871pbb7jqh.fsf@mailhost.krisman.be>
From: Jiapeng Lin <ljp1205831794@gmail.com>
Date: Thu, 3 Sep 2026 11:04:30 +0800
X-Gm-Features: AcwNN1Xev_k7J9nlKujPtipk9X2OZQxab9Uv8jnqbiEPEiDziqp2e25ShUhAhs0
Message-ID: <CAP0_7L1Tmoww7_gprbP0naNevsh=Crvx7iBfDrbW92dXfjuPUA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/net: commit all consumed buffers on bundle recv retry
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk, 
	Aohan Mei <henrymei@tencent.com>, TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

Yes. The trigger is deterministic (no races involved) and needs no
privileges. Recipe:

- AF_UNIX SOCK_STREAM socketpair; register a provided buffer ring of
  4 x 4KB buffers (bgid=3D1, IOBL_BUF_RING)
- submit IORING_OP_RECV with len=3D16KB, IOSQE_BUFFER_SELECT |
  IORING_RECVSEND_BUNDLE, msg_flags=3DMSG_WAITALL (and no MSG_DONTWAIT,
  no IOSQE_ASYNC)
- peer writes 1KB, then 2KB, then 13KB with ~150ms spacing, forcing
  two positive partial completions (via the io_net_retry WAITALL path)
  and one final completion
- after req1 completes (res=3D16384), read the ring head via
  IORING_REGISTER_PBUF_STATUS

Unfixed kernel: head=3D1 (only the first partial round was committed)
while 4 buffers were consumed. A follow-up 4KB RECV then completes
with buf_index=3D1, i.e. the kernel hands out buf[1] again although it
already holds data from req1.

Patched kernel: head=3D4, and the follow-up RECV fails with -ENOBUFS,
which is the expected behavior with all buffers correctly committed.

Verified as uid=3D1000 on v7.2-rc4 and on current master, KASAN builds,
dmesg clean -- consistent with this being a buffer accounting defect,
no memory-safety violation fires.

I have a self-contained C reproducer (~200 lines, raw syscalls, no
liburing dependency) implementing exactly the above. Happy to send it
your way off-list, or to reshape it into an io_uring selftest for
regression coverage if you prefer that on-list.

Thanks,
Aohan


Gabriel Krisman Bertazi <krisman@suse.de> =E4=BA=8E2026=E5=B9=B49=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=B8=89 23:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Aohan Mei <ljp1205831794@gmail.com> writes:
>
> > This leaves bl->head accounting for only the first partial round
> > rather than all consumed buffers. Buffers that already hold
> > received data stay visible in the ring and are handed out again
> > to later requests, corrupting or dropping application data.
>
> Hi, Aohan. Do you have a reproducer for this issue?
>
> --
> Gabriel Krisman Bertazi
