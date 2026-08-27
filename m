Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3187471276
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852388; cv=pass; b=cFlkdA6LvsLYHm6zFEqM/c0DYVGbIaYMGIlSZ8jlaJ7ycAce98948CMnAy4LojdW17F8urniOk64BPWq434uwS1RaCaVOn2ZYbfOJ9E/uF+yAIVP0fASggRRovet2cCzAPFB3NlT5MHWVVYZZb5IYNAbx4t7IcEV7m49zr2qEIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852388; c=relaxed/simple;
	bh=X9YbJ6QofxnPh7gMvJb/TbnUGqOGkcvag5nMxtHriUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzquMmZs5I74nKshaTy6Q77U8IS629LJno4VDAdFvXwIn7lbRKZPwzMhEMDACXGzBo1ii5mOQFdyO++spGcDZeabxF4u+t4R3yUE9eOBmNv/oycieZ3Rt6cxytN4eGiTxv7rF5BOstHqmiVg74TU3XmdJlSPvPXQJdikpL5jIAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=H5Ej5MRc; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="H5Ej5MRc"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-852c481415fso225436b3a.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852386; cv=none;
        d=google.com; s=arc-20260327;
        b=baQ9842SAEmNVSniK2Smobj66psmiZTNdLCIbFRc7VKD8JxHF7i/U4VVW31jxtvpRK
         sGSXApQZuEmNYsmCYm9ml2Z9A83Fz/e91exRrq4558nNNOf32xzxmTFi22zX7OIDzEfC
         HsUrGv7b759ycwMKTe6q1QbkiOVcyS74uzEfP8XH1FbDo/RhMgbcuKL9ogebQ/dsTVLo
         5LYpkM8LCLxmPNEW50DlmrdzqP3z/RgzW1bZZW1y5+n42vs8eivPGAPU+RQipHzCSJQ0
         7W6wz0XPNGDQwCEC0lMLpzcnBnaVFyqF355x3gu5pomhYJJ+5hdk8jaPHbqEy4g9E+T5
         MHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTGdWxptOrtcajv4oSEp2WQDMzQSokE8vUw0BxvLVgw=;
        fh=b/Aas1GQ8ao7RQeKADR8s9nA0hfLPfFfX4uHg//CJzY=;
        b=HwcQrUx3JJpiUkxQGvp+PuBQC7pwdzn6wG/hhjWepknVYtfioMmEv51Bx9zeiFVSu+
         mL6FNKgEOJ/4T9R/7LMl03B+Im+8XPhVyoJPvN5WN2si3ps0QPR0aRHMQkF3g9Jd7giB
         p8ykM8RzXwHkgbEqGuXZgmYuZFKuDkae80RmTvNIIAS+ApPnzAGftUPx/r4iZ2PgaUPG
         fVAEbyZCtclBUoeICEJ95MnNvTaXh9paKFXeOtuGAdlNefJ9qEhc8mIL+NnoUF3V+m6I
         LAwQBePNk15L8bSB71erBg/lkO2dbEoB8MZBeZPXH/fihVE0AJLKKNad91a9AcoFcOKk
         xvPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787852386; x=1788457186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DTGdWxptOrtcajv4oSEp2WQDMzQSokE8vUw0BxvLVgw=;
        b=H5Ej5MRcbCFm43xbSIY2iBvU3AsJUs7VIG17yhTndTAMiIq4n3+V+iEH0OjqDVaGSZ
         S9ue/dA5ipXwFdXyJOC8ICjga7xK8MH5qU3bjUe2ucxhdBtjiKmcXE/vwSdwqJACyhLJ
         jYrJU/n5/7KHD5ytqwL43+6vdoqF5Szktd7BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852386; x=1788457186;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DTGdWxptOrtcajv4oSEp2WQDMzQSokE8vUw0BxvLVgw=;
        b=sqawAuF9Q/h/RZ1lBqzrnfn06dHXPDfK/oB2Mo6jywEpyVQ4DeLV5SBOWvzAxCd26C
         br5upWsGwXbhKgOogy7yBMacJL72NeHh8znkDsRbr251R4U/jom55WplrWFDNMoYueBr
         ebEUPqMpXdyiftHOLeWPIkn6PExY9NFBcuSSISJUSGm7QeJ36kVEZhYIIfQar2TGrDoy
         Kq/iUcdZr4wUa90cm+aOd7wrRMiAFnydRwL+IqujX4K/2oGr8P9/DQXporP+GNoFrP64
         SQtx+/9ZgOOx9A/ngma74lxzk6r3NqszqUS1tvT+crCxMdL5wmMcTdycUnchYjbLCk5u
         FceA==
X-Forwarded-Encrypted: i=1; AHgh+RoGLBND7v4ZGidNWCO+H9emQQhb/mDL1tpJMQdCiQzlPxm6fyazSIZMk2ZU+e3mD4zW9L/pewQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n0vIdncg8mCHZbMZGOWJuer2nAYhXO4KQ1xO9yFm5XYdC4KA/T
	nvkPykp9voGrleG6xYq+bmzLJ/V51ibktl27+PUlw951d8vc+N9aQkkKP5jz94xDGIKAVbcuNub
	ldXXhjLLt7a0neCvJjOD0BDZRs4/mmpiqtI2fCtFu
X-Gm-Gg: AR+sD13lZI675fr4t9H1kZnp4oUfLAg7oEPoGCxWQfVUHCqlvaGCMF8RIx5tswV6EXg
	SS8tA5czJRgtc8rf+gqSL+z4shHTSrT6EPgkA5+spJHktd2RRQrnRmDDWnA5KDzBrN3/leUk83w
	KZc3PKhPqfxDyH2Xnc5YvMtMNtz/nRZ5quZH5gL6CLtutH8CAbYNLcAe6eiHxxmGZnA/g2KhKbp
	DWtfC0M3BqmONEqtxSsjTsV1tZcbf2CZwOzPD3YfhekvxntA2M5npthrEheFTu7PnoWKDvM1MRj
	eGttJTdz34WCOdZ00PteuZh15V49gJ/sdHoZ+qZup2qp2Q==
X-Received: by 2002:a05:6a00:1143:b0:852:131f:b9d2 with SMTP id
 d2e1a72fcca58-85626f06db3mr1663965b3a.2.1787852384661; Thu, 27 Aug 2026
 10:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825081751.134086-1-jhs@mojatatu.com> <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
In-Reply-To: <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Aug 2026 13:39:32 -0400
X-Gm-Features: AcwNN1XdcbmgV0dvtYrOQWsFkN2ugg8bCS-hzROqjekOwutDYlvFA_wJO950OTo
Message-ID: <CAM0EoMkJdo_e5VYPRcPN2mZpNyrTQ43FxNvkqFSNDjyV9x45dA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net/sched: pfifo_fast: reject oversized ring
 and account to memcg
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/25/26 10:17 AM, Jamal Hadi Salim wrote:
> > pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
> > ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
> > bound. An unprivileged user (via unshare -Urn) can set a huge
> > tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
> > memory, causing a system-wide OOM.
> >
> > Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
> > in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
> > Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
> > via extack whereas for the resize path, the error propagates to
> > netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
> > the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
> > are charged to the allocating process's memory cgroup.
> >
> > S16_MAX is the virtio virtqueue size limit: the virtio specification
> > stores the queue size as a u16 with a maximum of 32768, so 32767 is
> > the largest tx_queue_len any in-tree driver can meaningfully use.
> >
> > Conditions to recreate the bug:
> > - CONFIG_NET_SCHED=3Dy, CONFIG_VETH=3Dy, CONFIG_USER_NS=3Dy, CONFIG_NET=
_NS=3Dy.
> > - Unprivileged user in a fresh user+net namespace (unshare -Urn).
> > - Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
> >   while the devices are down.
> > - Attach mq at root, then replace each child queue with pfifo_fast:
> >     tc qdisc replace dev veth0 root handle 1: mq
> >     tc qdisc replace dev veth0 parent 1:1 pfifo_fast
> >     tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
> > - Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_array
> >   rings of tx_queue_len entries (~12MB per qdisc at QLEN=3D500000).
> > - On the unfixed kernel this exhausts global memory in ~28 iterations
> >   on a 2GB guest -> OOM panic. On the fixed kernel the oversized
> >   tx_queue_len is rejected with -ERANGE.
> >
> > Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v1 -> v2:
> > - Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE) (Ja=
kub)
> > - Changed cap from 65535 to S16_MAX (32767), matching virtio's
> >   virtio16 ring size limit.
> > - Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_MOD
> >   already prepends KBUILD_MODNAME).
> > - Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
> > - Fixed tdc teardown to use JSON list form for acceptable exit codes.
> > ---
> >  net/sched/sch_generic.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index ef2b4bf51564..eb5c0d3f67c2 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdisc, s=
truct nlattr *opt,
> >       if (!qlen)
> >               return -EINVAL;
> >
> > +     if (qlen > S16_MAX) {
> > +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > +                                    "ring size %u too large (max %d)",
> > +                                    qlen, S16_MAX);
> > +             return -ERANGE;
>
> Sashiko noted that setting a large tx_queue_len to a down
> interface gives an inconsistent behavior:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081751.134086=
-1-jhs%40mojatatu.com
>
> (all other comments are IMHO noise and should be ignored)
>
> I don't see and effective way to avoid that, short of falling
> back to v1, WDYT?

I changed my mind on this. See this thread and let me know what you think:
https://lore.kernel.org/netdev/CAM0EoMk8fAACt11fe1pUsFeG9np3SdsV0YUNmEevLu=
=3Di=3Db+xKg@mail.gmail.com/

cheers,
jamal
> /P
>
