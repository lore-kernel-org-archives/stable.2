Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708133F383
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503249; cv=pass; b=ChB7voJYYLxIPDq3V0FmsubhP9pa6fW82qieYtJss3ne5EKk+mTSEF3/boTxNxlhIs8KyYHUgPtMdUD6tDbP3jI8XQHyvkvnrG1neKlBsD8gtuHyPniZMTJkZjp3TM1jaMN9ca37WEsMxekHL1Q3YY/NLr5qf/mQhLwI5+bscyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503249; c=relaxed/simple;
	bh=2qrJ07HmFhMiDarJWqhbEJyNsikA2+xhGbEddsDBpHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L697GcdILahpajlcgjCmCqDLtu/grlJTU9/vhWK7aKoZfyO1EKWO4GezmkU4/uqx9bCiezZbcCnT8umXHfuAO/paU+sy9SWovyvKa04Kk3VRKO5hB0KdDOG+qq2RftEHRSZK6UW+deMx+BqVqfm1kq+Y6sBSVpeT6qkilApHpUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMdamEA6; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMdamEA6"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1676648c1eso13833766b.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 09:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787503244; cv=none;
        d=google.com; s=arc-20260327;
        b=ntUtWGNXYGyFQQWv3MgvgiM+80nEHg2lHJCy7YTbwZnq2rklTMKHSBFYAlWLywF1W4
         iWNYnzx9IMkuInCriOlNpb34AS7dbHFCyCGn/UZynBNGFisJ48m6D9IGFm/gK1jnbxVr
         8iY/6zhLZVDLwsW00niG2jf0uFSy5/iLuy72QnNIKjPKq6c0AIoyPedC5hDx2OpTK8fO
         A4ZTAWd2KCQKN8AJFsOhf7WFp7bRVk9yw8w3kXzsoAB/l/sjvFvbJExRDdnoFeIE6uV7
         YvvsgdxagGyLU2vPnR6RXQdfK7Ym4u0vLVgRPvsuwZVnHLoNDdE8hFa3g85sV2PgbCUG
         /Q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/sDxPalhg584dD1gtugx9nNfFRP6hf2NhTD5B4YszU=;
        fh=rzC1ZcxhnsCuYS7fMlJ9favGI340JV5pxnNwKirFXvY=;
        b=HCE7+frYUJwrhilrkbj6tCLezyybV+lmDyqVS3JsHw/vMU0u5uVEzRlDmeZeIMqyfB
         3wXSGpR1F+GFcT2QF1Iuf84FVAE5BsFfRbjkz7hqrW6TsDFMD0/TthDNyBZkjzyE9RQD
         XlqHdlhdFoKVyaftRF6VAEGWbgFDVOGPDHmhWc3JRRsK4HdwDbPL/EFfEzqWzjAmNjMw
         s1vmu6FUoAbVnKZ2adz51hO/PisdSmO6w9tp1gX1PFY89L5GqJr2ZSXDIKgcM0yGma01
         YWN4Xi4yieLNR6lcaCH3Bq1LX1TixLSwYoR0JDvXaCmOueMZewOzWfiUzN1KQkbNhjkQ
         754A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787503244; x=1788108044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m/sDxPalhg584dD1gtugx9nNfFRP6hf2NhTD5B4YszU=;
        b=AMdamEA67Y2pefFwgzzT1EqkPGd0eUCauP2Ytvmu2kR3FE0W413s/JHoqavNimSNZD
         NcuTIy0XImGP5o16PxCuT+bhCdyOxanR9OaWZyct2NOmJpQYKaNXL4MT84aIw5rgVElP
         ioBR+1IAA7f8bwpEnOlWrgrQmVaWIko5hSZmEMR/6Wuha96S4DdSzy/nSxdGuX81UvaM
         vtKT72LEuj0yl8ifX6EQMecUMlgXR5yH2d0nytp3Loc7NNpU1w8ZUwdJGsEpzLyKbC9z
         EXJZQqWlmQ5CQpcJOLxrxNOnLgSWdd+31gwthJAUFVSwsnOgcdQoPtYtOKXN5kf+nB8V
         nc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787503244; x=1788108044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/sDxPalhg584dD1gtugx9nNfFRP6hf2NhTD5B4YszU=;
        b=UORtG1h4FqyA4Cw867PkXtmyi8SzqCPYGK2CRDJXXJzHhJ2beu1oe+kRN1h2I3SmV8
         wz5Tg4E3vQRD/pdfeziEBw9sTWd3Z7tWO6eivy7gjSeeS2xR3Hj+zJmmDrlzviz7Awc0
         rdndqZJWZ0FRNYmDGoZ1jMG19I2L/FbmuYBiBenGd7l+Yh3G0/Dvd+gWQvmiOW6JVfVz
         q1Y0lcJhUL2m4xfD7vaXlJ2vHz8graiKUjUw4fMaAFFP2b3WFQSUEJhEZs5qSQtLODCu
         xtwzICVSmlM0XCqheu3XSZE9nivnY6OJJZe7sZZrN2up126uOSTg88knbjiRfDmwhJI+
         Tzew==
X-Forwarded-Encrypted: i=1; AHgh+RpWoaluQpWnAu+49RhOFfGujd+sYOUc2GVRvwDwJ7UZzKbd/iLlkzmCtrhZQqfVplnq5xoI+wE=@vger.kernel.org
X-Gm-Message-State: AFuF++mctdUUtFE+h9LrdbcFDsJSrJtR+GGKpZg+v9xCqWomj960wdEm
	mU8bt82/xPhXc84CVXy275TNH6n28koIQvySZoNqMUMYoCVkeROCZkfED9141lIxHxrYpcmxIKz
	OprZBQWYMhrynE+ljW97IC5XP39KFmXM=
X-Gm-Gg: AR+sD101UURJ3PTveS0uWCvxZW/j2JQ3czJ9jY0ZEvP7J36ec/E6G2hSnhyUp2itzUQ
	r1cZrvPBZuI9N7LxIOVEkO226sSV7T/2PhXlLxp5VjcSIAmmz8ZCQrDILwQXTV6mAQCqHk5OT0p
	/dtJF50iMO95QeI6dRwZyAdPX/iFmcmqZrJG19CqJIfdAmZhNKRFD1GzewRkAHNXDV6Xmtgj/Cx
	W+JEWii1yfFMecHtGnXgd74GFUpQnqiLLzLrmmOflITtUHc7MjmE1Q9/1iC/rhq8bLQ/eTJGzh4
	bibL/yG8IT338LiQ7sxv1jq9ZvvxYc/Gy9WoUmPUgMiR/RFI8LPkUFw6bpZrSaHVX1rXPSNCEqG
	BP+2CQqGs
X-Received: by 2002:a05:6402:450d:b0:6a1:f95b:8cfa with SMTP id
 4fb4d7f45d1cf-6a42f1b47d8mr12742404a12.1.1787503243685; Sun, 23 Aug 2026
 09:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822184658.3787672-1-nicoyip.dev@gmail.com> <aosW-q9G-rQlIXwu@strlen.de>
In-Reply-To: <aosW-q9G-rQlIXwu@strlen.de>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 00:40:32 +0800
X-Gm-Features: AcwNN1U2ZcUxHGp8iN_ot6HPNtjh2GGRM3ivt46qhGCudofB78avg11NKAz3uLM
Message-ID: <CAAo+4rU8b1H3NFBm_OHqmkr-086w2ZAzrWoFZYvbifBk+358rA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nf_log: clear per-net loggers on unregister
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Gao feng <gaofeng@cn.fujitsu.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 11:51=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Chengfeng Ye <nicoyip.dev@gmail.com> wrote:
> > Logger backends unregister their per-network namespace operations befor=
e
> > unregistering their global logger. This leaves a window where a sysctl =
or
> > netlink writer can rebind a per-net logger after the old per-net
> > selection was cleared, but before the global logger registration is
> > removed.
> >
> > The race looks like this:
> >
> >   CPU 0                                 CPU 1
> >   ----                                  ----
> >   unregister_pernet_subsys()
> >     nf_log_unset(net, logger)
> >       net->nf.nf_loggers[pf] =3D NULL
> >
> >                                         lock nf_log_mutex
> >                                         find logger in loggers[][]
> >                                         net->nf.nf_loggers[pf] =3D logg=
er
> >                                         unlock nf_log_mutex
> > Later, a sysctl read or nf_log_packet() reads net->nf.nf_loggers[pf]
> > and dereferences the stale logger.
> >
> > nf_log_unregister() only removes the backend from the global logger
> > table. It does not clear matching net->nf.nf_loggers[] entries that wer=
e
> > rebound by CPU 1 after per-net teardown. Once module unload completes,
> > those per-net pointers can still reference static data from the unloade=
d
> > logger backend, and later readers can dereference freed module memory.
>
> Why can't this be fixed by unregistering in reverse order?

Right, that would be much more clean, I will send the v2 right away.

Best,
Chengfeng
