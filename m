Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D683FD14F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463719; cv=pass; b=VEph8V7nvQKunkQsFQIlc9PJn5cL9M8eAqeUWBVmoG26J9OzhWU/42vkMovbO/AmcLBrfXO3H1vwZ1N613aapz5NsQEgLmrMENg8bEojmNLPAIy+P4oarr4ZE230ZVFXqtetFOH3vdIiNwS22JMEYgGxJ2KWGQ5to12+ORTZBFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463719; c=relaxed/simple;
	bh=QKxqZ3eMMR2X39cJ4mp4AJOBcwz2/Hm0JMLEa5hv45w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6pLlgUaMCvDnu7ZkeEGOBJtnzFHKxPFhPBeRum6yutAGI9D+Y+9fH80tkpmH2OM/1qRl899Q343Q42cdOXDIurfNkmFREYrJPL5y79mzhLIVdj3J2wjkVNJp32ga9FXzx+DvnWzpPLFQhD2Z2ZuQySjPfc8ydoV9mC4K8wSJzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHxCsvaB; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHxCsvaB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d9db539a54so1951365ad.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 12:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788463708; cv=none;
        d=google.com; s=arc-20260327;
        b=pVUHoU5GE1C+SQH0jTAFaI/mEtMt6UW8EvKOfGJAnV9ieDgthRzBbM3DQjbvGRnvoH
         C0emldUImTOQRWzw7yYVlYh2cm70KVxALZFjFDQ8BQ6D7qccQtxXfKlsojOBZTrdf8Jl
         3wHSWR6dna5FmM2vMYo1VTnUa/TDu17anKtj+akHYqtKZ1+SwvffkPN8xe2lvpBAhOF6
         fcE6Z1NN63wvTjP2zCHweMv1MVopF4dCyFPFM93cwjSBOLKSomP5mxX4svU1/wEhPQQH
         HtnW5Tuvd1qc1iqpKaLx/gkdYv9EP/9OWpZ3Tz6uM5bMs+J5YwED+LAXsKNSwfZD4arJ
         y91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKxqZ3eMMR2X39cJ4mp4AJOBcwz2/Hm0JMLEa5hv45w=;
        fh=l5jV14KdFA1YTtZq80MuTZ7wg9IFTX0GIda7qEz7jVE=;
        b=XIPUO7heR/ftgKXenoI3rYsn3e0O+NBy3PmVuT8lREJpSlWdcCQgihm82OjsnnW9Hu
         J4AZiuGxeBSHXT8Wj8/tsiDKn6V21L/ek6uxV0cLE7mqJ5PtfGOZqJt7qGqNwy0kKVm7
         hQ5WaVMI4i5ltfbQbfLxAK5X/NyxGEON3jL2LFp5l7Y6EbQOH/j8BE++s6wew5r/NHEw
         MKUW4RpNKtHBBa70zAjMtaMYHjeX0olLfDh8IvbCXIpnZZr0yp36lzfFh1LHpGXJRcQb
         A+pY0IKAcM6qvzEtuhrRWPEHI5XuvX0b6DmwKOHtfl8v1YQoPjAUArSmDzRqhWBjUb13
         DL0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788463708; x=1789068508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QKxqZ3eMMR2X39cJ4mp4AJOBcwz2/Hm0JMLEa5hv45w=;
        b=IHxCsvaBn8xIxK2o1/5GqkXTcdPiKYubmDrI4T/kxrBOOuVGa+jzaBcfGVMyQOHWJK
         TTVWOGkoW0jj3AQ6REnI5C2zHKh/GIAiijcjq0Yq4qzSn2M1D6vixfoTvlOWMEqWZIz1
         w0NU4xKrdcNsGGD277i7cSWqwfIAwjGKKCb6Ju5cHJu5wlTAyGuKIofRUlDlhb9EbglE
         6I/6E0f8d+fusjqQDd0xWGd+CKYSdmc5UdQFoXP2IwLEnyp69kpSgjucZ6MGvHdtFqTw
         rIElbQ6zbsPYsqBzQqodRoEk1/9um0ZxPSJcqp6HSJeJxwxMIWihgUfkEpW3hPCn7kvN
         d0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463708; x=1789068508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKxqZ3eMMR2X39cJ4mp4AJOBcwz2/Hm0JMLEa5hv45w=;
        b=kWmfAYuA9Ivoi25qDC2cHO7PnC6yOuOFO/wAQLAMcvzf6xCs8+cZZSRX9oRqXfwPtN
         Imox2xMk1X4s5/DgeFLlvlZ9J5x/m0r9x0BO6BRZyFVmGJ32B7u5YmqJkD1TiPjjlw4J
         dSVcXFQ5nC0xAlCxPmVCZsIzkfiLUNYqr7vEI699JDwGPtkIx/AJ7LXP7Jy5B4/Sf4rn
         6HLvDZv9QEo5Zglbp7w1wcK/szjf3+IQ7WCRMWOs9c5UZCPM1C6PXgiczcdmrBSoRyrC
         Dz2PVZsLevWRY+659dV4QKrdyJDKmL+MDTNmCvmOCI4n/oFOfNyrRGCUp3/sYhIcn2EA
         qQWA==
X-Forwarded-Encrypted: i=1; AKwUvBwez+Mh+UI7CWXsFdny1KOlqSVvEeOzT0bydh37bWe1EVAhe+4pua/nW4eupbk0kMVGOVyzLTs=@vger.kernel.org
X-Gm-Message-State: AFuF++nAaMdtG+noIPiSKfhIACjdq06AHjzLLN0C6qp615WT6m8kTPWc
	TIEnmT5E5HlirqQsdIQhxzPkxn5fOKtGPvktUE/dtKlOAwDJ4NU9x5J7VfCybMX0lJ7zguai/H1
	yDgNBFExhJje75Gdi09QqKhV0KoAiP82cX/e34era
X-Gm-Gg: AYBFou1r73tsRLWsLISNjEmFvE9Wd94qtVBxC2qhxvoHYvCX9AUmrwZD+YQ2x61v1M4
	kcTlPE/+nUmPPSP8Vdeq3mMerRasXdKTUfWyrQucbYUqpNtWD/AfYNJ5lxfPU4gZTZTIPaLpIMM
	OqreJA39TjShvB3e0CvEVV7QIqGkU7CENlxfFjwYD6SmaZeVzxb2Qy6wHdPOdt0iRNWP6/DrFxy
	i3yJ5B2a4cAhyRxIklNHrUOeN20QwUuf8o7leAELeMCSgMlC/WJeG41GNcZWINTz7uNBBFHmvtq
	hcl5Wuf8NcvBbuCNAj4ObjEYs0cgb+lEiwG6UKUuckNeypkgRdXKzEK6qGnUD35KrMc3lYXK9jo
	wu3JKr+AUwjVeRb5WgpgQyLZQ1T+MrQiSLU/uQBxfuHvHAP7N8f1ief++BCjFsvNz+ZuGwtQLnB
	seQXifXpDnMsff
X-Received: by 2002:a17:90b:2784:b0:395:4de5:1054 with SMTP id
 98e67ed59e1d1-39b26272bdcmr1062522a91.16.1788463707201; Thu, 03 Sep 2026
 12:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824033331.1084971-1-imv4bel@gmail.com> <20260824033331.1084971-7-imv4bel@gmail.com>
 <apaAskNL-IvdcR7h@v4bel> <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>
 <20260901085102.5c58a5b0@kernel.org> <CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com>
 <apnHqmYZQ4yzOP4N@v4bel>
In-Reply-To: <apnHqmYZQ4yzOP4N@v4bel>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 3 Sep 2026 12:28:15 -0700
X-Gm-Features: AcwNN1U6zY6LZ3oh1KYqCMuclwz2vgIWYpsKBP1jBBoFZoxWBAYwuULPqKemveU
Message-ID: <CAAVpQUAVXFrRuxPCKW_4qqAAdjTpv+arijYODeFMfXshKqajHw@mail.gmail.com>
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, ncardwell@google.com, 
	dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, willemb@google.com, 
	andrew+netdev@lunn.ch, kees@kernel.org, jiayuan.chen@linux.dev, 
	kerneljasonxing@gmail.com, ij@kernel.org, martin.lau@kernel.org, 
	shakeel.butt@linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:17=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> On Tue, Sep 01, 2026 at 05:57:04PM +0200, Eric Dumazet wrote:
> > On Tue, Sep 1, 2026 at 5:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Tue, 1 Sep 2026 10:03:51 +0200 Paolo Abeni wrote:
> > > > > Looking at this further, unhashing the listener and then calling
> > > > > synchronize_net() lets the disconnect path handle it. MPTCP needs=
 a fix
> > > > > too, though, because it closes and reuses the first subflow direc=
tly
> > > > > without going through tcp_disconnect().
> > > >
> > > > This looks like a more palatable approach: this patch in the curren=
t
> > > > format looked way too invasive to me.
> > >
> > > I likely lack context on this, but I was wondering whether we should
> > > potentially disallow the transitions between listening and data socke=
ts
> > > instead of fixing these endless bugs?
> >
> > +2 I think I mentioned this at some point.
> >
> > Same for IPV6_ADDRFORM : we should not allow transformed socket to
> > even use tcp_disconnect().
>
> So.. do you have a plan for this work?

I'll post a patch to disallow the buggy transformation.
https://lore.kernel.org/netdev/CAAVpQUAWjBuF1Rgze0Vt_XvkUT=3DAjw-F+Kh+s2iHk=
38c8iAapg@mail.gmail.com/

>
> Or should I send the v3 series first? I am still looking into related
> problems, and it looks like this series covers most of the "important"
> ones that have to be handled right away. What is left seems to be the
> UDP side and other minor problems.
>
>
> Best regards,
> Hyuwnoo Kim
