Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB658397338
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878496; cv=pass; b=JCX7eV4vmetQs3norFj+9xTEBfN1kC5jPKd7zIsWGiIaPvhQamN/HnkDCexMvfnRdHFDR87askqZXNRIb/4yWT4yzjzSUZmZjcpb4nYPz+TA6y1RmZEQSB6I7ZxvUpIxl+AtB5sOxXjUkp4rOvz6/mMeaG96lcLiXbK5XTFauKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878496; c=relaxed/simple;
	bh=KFFRxFxAH5AteS6INOuRURvfggPbMI9GON1e33BH2eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qndvEhSjwRJ/wcME4/kjgq95IIVF6fcZF+4h80glcA6E7j4mxZMbBHoUzMK4i1on24Us5+QgKmPwwguQKN4RH60SfmGqV2pUFkFzFvG749OIXWWB4SX8te/O133w1qPuUgV8srNHygS37Cgj6x8FsGkA9JDmZas6iIa4jSgkirk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxyXFq1b; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxyXFq1b"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c33700b6435so38234766b.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791878493; cv=none;
        d=google.com; s=arc-20260327;
        b=XcLsgAkJ1bFzfXQZrwVQJpPgMQFdtlBcVDX2gE6tBILPI/CQbWK9EMJmSzDDKZjcrH
         cy4pyltT2GgJ/tpisczjUQgWX0aLKyt3eQ1m9yPhlxvYEHnTCMBmzJi2DlKcdJe9SsPh
         xzX0EmF9LTYc5YpD0U/68z5/JHgzjAUycMlmRtmWb38IhNdCjRe18t5qrbn0rF5bwHot
         36QiH3c2ETI1i5ULmgqsh8MVLf/eHsM58GuixtUcv3ONFK5Mw/flo57Hg/A4YJwi6WfB
         vRK+A34mpGUFGWyWeCzjhMKEPFWGlqQGu0dsyivCmzh2/TVpuDJg9MetzPXM2ihvIMN7
         S32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PqPcad7Yc6oLW4/1CPglWS7qsNLhjHruOO8KWIE39Fw=;
        fh=Eo0Dj49uePQmq12sdX0rj3GFRmZOdeu+lBFRQ9dcTFE=;
        b=iOu7uDQxNpYRcdlIFKeZfSqIWAeaeKSrfnFl3JOnvvUvbUZxUG83Al279L/zTTUMcu
         PResDHtIvt9XrClqwSnz0+oMqWPzDBvQ8kfBZPfQbhEkarkEMXrKiujFBYdQhJQwGkKz
         aKshqd0Q7quBRxkLPjzryIfd6GIPaFxrdr+SxCcy9FvCjIoo0AvYWjGGQ3fhN3MWeaX1
         sYQv53x95j2229nxgRohgUkbeTtzL+X/Nh/nXhGwAjHcXkdVdws9pEvsvPz9JZ9MY+Jx
         RX2rjIeUoHaSeWPdV3roF/SgBiAw9rpWv0diZkClyshu4Tm789y9LW8YMOevs4luQXvf
         ozZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791878493; x=1792483293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PqPcad7Yc6oLW4/1CPglWS7qsNLhjHruOO8KWIE39Fw=;
        b=qxyXFq1bkcx3ruf2GbgzoDHzEi3foh5FTPhb6eDIfq06WFvDo2cU3f/JgloT1j0w01
         CTW9wzFWZqWX14s4r59kfu2qRfSu9BuslmOQrano5rW+nlNthebikB8Ylgn6uHj15cVe
         0drtlcRZbc2Z1U110MccU7QZxa6YHV6xveVrfz0hvqsKdjo3x/PTjWtZdqe4vSV0yNiF
         FEIi2DlNxUWrUS9XQGfC0a+CkGBVLeXQ8pz84PO9Z0xHdcci/DvxebVkU1dby1DX2Frc
         ZgFIx/OMQCtvBdGZh7hJSinVlH2VbPN7jR/uLZqv2HSsjv8MvrDU0pDWBFCFLTHnlGm0
         z1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791878493; x=1792483293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PqPcad7Yc6oLW4/1CPglWS7qsNLhjHruOO8KWIE39Fw=;
        b=cz0Dsnul2vkiKuyIhvj3vq/8Hc5gJHE4ZO2gM8f5s5JOs3gO2pReZVvBm6s5f5Ae5Q
         WQ/AhNFmFuPKXKBKaoIK5cam8LjNB7A/eXDOvKzTeyplTMzXawxQMpmZZl80sYY0T+SF
         yg9wzwu91BwuUj9HpRzYEAOBXMN0VErXHJfbry9bKhw8tJIea8kiC59DUEzS1CbmAq/T
         ERJSIsr4nlqCIdMVjvhLqARZr4W4Dad8lOvuDLz1GEBUIX/ye2AtG0YZIe26LccOVeEw
         zoZnfvHpqyKyX/a3A4B5uimAokHlTZJZ2FSUVmBwPUG+dV/1eflYqaxsrZiBAo0Tokkv
         +WRA==
X-Forwarded-Encrypted: i=1; AKwUvBxvzUtSUitV8Cwbbb5CkFfbrkw3a/8LluTyiFE4Sp6NcCtpshwC3NkiGNmqte+G7FckEQa0/Nc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKJ+v5Gpmn3ydF+lHFxre9bCbxdLaKHnIc7zr+q6f5PsGbfIuB
	Jajr1XdGvNdU4+xlu5HrUqQuQnQCw2s1k6EIT2Ucp6dFgyFtfeWlcF2Rpj37D3PRmchXfUKra2a
	fP8FQ/qvb0K+xYRLrcpuVsmHVuOSpvmoW2XzlBt5Afz3g
X-Gm-Gg: AYBFou3FiD3sSWHAwJYKCOphyy5Fu7MbZTMVUJQSmXEo+KUcSi2d1hf77344AZNZ45P
	TmjRv9UuHu2e48cExd2R7TlIpjWCclkHXim7LBdwoIgOD6nklqcjrZ3FlFqXLTFirgyfNgyICQ3
	74YtPfs2r+jhH0GfcoBG1VsVZRi+37SYvpwdBWND1SKPyBljavKdPtRW4qMJl0uocEQhAAl0JXL
	+ztvPL3Nb64GnuqmWl/K1FXII6+1eKgvn5+zYSTF5gsbWh6s2ZsGpX5GcS/YkLiYDUzZzlbZJYn
	mLTe/yp+JiCd0Gh7QOTudlalPFEPzsZBsa8nVR7jN1G4OWdHgE0q1zKKupGhVSKEXebO9AOP3v2
	oVFO6AR5yNmnArRT7oD4=
X-Received: by 2002:a17:906:2092:b0:c34:d75b:ddd6 with SMTP id
 a640c23a62f3a-c34d75bea07mr278330066b.3.1791878492661; Tue, 13 Oct 2026
 01:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002173844.3537111-1-nicoyip.dev@gmail.com> <20261012200752.3771786-1-kuniyu@google.com>
In-Reply-To: <20261012200752.3771786-1-kuniyu@google.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 13 Oct 2026 16:01:20 +0800
X-Gm-Features: AclHuK9knlLJpyn2NKb20q7UFVWoMrjulr9UbG2ELaElJRyP4Qnhyg0dvU7dqcE
Message-ID: <CAAo+4rXMefUoP3BwwK20remeQ=qrS5fj-9y0w99LDu0mY0eJxg@mail.gmail.com>
Subject: Re: [PATCH net v4] net: pin protocol module before inet socket allocation
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuniyuki

On Tue, Oct 13, 2026 at 4:07=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Chengfeng Ye <nicoyip.dev@gmail.com>
> Date: Sat,  3 Oct 2026 01:38:44 +0800
> > inet_create() and inet6_create() look up the protocol under RCU, then d=
rop
> > RCU before using the resulting proto. A concurrent module unload can
> > unregister the protosw, wait for the RCU readers, and destroy the proto=
's
> > slab before sk_alloc() uses it. sk_alloc() may sleep, so the RCU read-s=
ide
> > critical section cannot simply be extended across the allocation.
> >
> > The reported failure occurred during concurrent L2TP socket creation an=
d
> > module unload:
> >
> >   Oops: general protection fault, probably for non-canonical address
> >         0xffff1108974182a0
> >   KASAN: maybe wild-memory-access in range
> >          [0xfff8a844ba0c1500-0xfff8a844ba0c1507]
> >   RIP: kmem_cache_alloc_noprof+0x63/0x370
> >   Call Trace:
> >    sk_prot_alloc+0x74/0x2c0
> >    sk_alloc+0x2b/0x6c0
> >    inet_create+0x2cd/0xd40
> >    __sock_create+0x1c3/0x430
> >    __sys_socket+0x116/0x1d0
> >
> > Cache the proto and its owner under RCU and acquire a temporary module
> > reference before dropping RCU. This prevents normal module unload while
> > the proto is in use. sk_prot_alloc() takes the socket's own reference;
> > drop the temporary reference on every exit after allocation. Use the
> > cached proto for the IPv6 backlog callback as well.
> >
> > Use try_module_get() with its existing initialization semantics. SCTP
> > creates its kernel control socket during module initialization, so
> > rejecting MODULE_STATE_COMING would prevent modular SCTP from loading.
> > Failed module initialization can still unwind published protocols despi=
te
> > module references; that separate publication/unwind lifetime issue is n=
ot
> > fixed here.
> >
> > Fixes: a79af59efd20 ("[NET]: Fix module reference counts for loadable p=
rotocol modules")
> > Cc: stable@vger.kernel.org
> > Assisted-by: GPT-6-Astra
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> > Changes in v4:
> > - Remove the MODULE_STATE_COMING rejection. SCTP creates its kernel con=
trol
> >   socket from module init and must be allowed to use the published prot=
osw.
>
> You can filter the case by @kern.
>
> sockets created from __init_net functions always have
> @kern=3Dtrue otherwise we cannot tear down netns.
>

Thanks for the review and suggestion, v5 adds that @kern checking and
adds back the STATE_COMING rejection in v3

https://lore.kernel.org/netdev/20261013075604.868273-1-nicoyip.dev@gmail.co=
m/T/#u

Best regards,
Chengfeng
