Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC168379EE8
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317412; cv=pass; b=lZcWsLT8uzVoZFWkJZNksXxyw7tBGv5+JSb3H7+o6zuQ49VTQ/q+2Z+96zksT9Y6Cnr4ucT7mrpkNcUY1zcfLEVpDiSpgOZfNmqIckRuE4GqmhhWjb4Wl6C8IbtBA0hN7Ac9YVzLPFYokpiDNTLW+vw0k473KeMl7gLbVSm4fxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317412; c=relaxed/simple;
	bh=nX0cSKYPDYzlavsu/3QhK11Dd6P7lE5yqKAvD5dI/Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMc1tHdG7APeP1FQi3fcTfQoRHu4X6ISeENmZ1GHv18K63+eTTafwKvSDkaz5umAlY1TB+rFJ5kCtDfOsuNsB0L0mXHblfo1ungHN6xnL1MleuEt49p+/ydb7CEnPlYumpPS0edgc4E1sgSntOAvHTzL7Yppw7LO5vImz2+H+7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoRwrTIE; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoRwrTIE"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5174a1da4b2so12451881cf.2
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 05:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780317410; cv=none;
        d=google.com; s=arc-20240605;
        b=AOTC79yI9tzTvC2C3jg4Y+aXhrWo86EIh9VeqBNhGBJk88zR3/l5x/WZOZYEsul375
         MDEtpcOjuhUi2NqveAGaOVIN2mMP7kX1S9ohqalzpFttpl4YmFl2aQy9YoCmSzisyurx
         l4XnpF/CHKAHOrgPkVFzTVo943IkwcvPhere3qmtlmANoR/HdUPCr8BstIH1k7jwxIhA
         sn31ZtkWGGUJlteMGvAhxKiu5CJfc1yinR0GLUWAYSrgYgGFdLPHGjfMaPKFEVShWNS3
         +9O7dZh6yJAkyRo42BKnRAqPUA5EM2aYvzuu7BukhgmYQPTmD37Me9sJePFtB2RvWdG+
         2EpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27KaSPnwlRAhBIR1/gGhKzFPuNaUV3K3DKJ6kQM+qr4=;
        fh=6NrwV+ui7H5kLn7aVIweSc0lU9P7dF189SEeZ7m0EpI=;
        b=da9kE6QHHtHNCahWXc42IbGUgClQM4OMKo/bMYrCzoO2UYYPvuaeThuSxrua3+5DeZ
         YumIrtAfBRxaGEme9WkJvRuigzpLp9Lnzl21gG7+wQ9Ld6XzxZBBWCqlA0rbDP2tUGsg
         zlW6yF6RUcsCwVnUfDPOZS0uu8YRRbnEaf0HKrerLRUEsZLuV7BluoNXdELpJeQRcjIi
         KKJLOioX1WVz4kD3Sgn+Guobsxzz069qIw9RkYWB5CE09Yc+Od+bP2IC/Li0Mxt2Gh5A
         0cAjnr+o8r3kcI/ArQ36GwB+Eoadj6wJMh7Qu70PbwMCApTR6PMzfEiQ4TEZ6jWSaK8k
         ofnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780317410; x=1780922210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27KaSPnwlRAhBIR1/gGhKzFPuNaUV3K3DKJ6kQM+qr4=;
        b=hoRwrTIEHnOlZRv8INSRXAsF9RY6+173lWJYSdGpcSWLesWZVx8MUdZO5MMjqcnMPi
         LamWbJc9LrTyenFL+MMlhY02lYt7qtQ1UK70f+oVVeQ1GCzzncxxxNAI/bLGmnKRQro2
         WjLFJMLen3OjOAqOkaVYaMRbmsaL1KqLH74WDxD5NjvjwggJY5HfoGIPz4mGHZ+gaeFz
         OA/pz95jKZrj3b//S3tL01CzJGSaroQRIgK0fuC5Ns0QKfFVUztS7UQR2II41lLF+cPz
         wz7rapcmpKzLysNMGwCRLIL2/WeSRb3lVYeJ0YBup7h70QlHCSVN3UDWG6bTuxKmsTfb
         UPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780317410; x=1780922210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27KaSPnwlRAhBIR1/gGhKzFPuNaUV3K3DKJ6kQM+qr4=;
        b=VeUBwtakCnOutRoxzEzFmHvz3ncAyDFR6v/lfIFyUNoTkMePRGWbWR59lQRu6Tyvf3
         uFvrhIw0t9TZNBqfV3blLO0bhFoij5iahtXYQilL6zainOL3lWAMeTbY3Wsk9qCpOvfB
         2u3e9ArsxpZzKq6v+tO+nhPfGdUR3v5BtkuNSLQGBXsxdsyj5h3w6P0y79D40U4dQz+z
         swXVtmrRDNuviYU0OnfK6RVL1GL50Xyjuxo/fZZv25Ir5+AOq9VHlFkrtz6yRjKzktsH
         vVLqjU5veQF/4CBEHcT5KVx3IX2NnMSHTg5oiDqjnKMoVTxNGukxy6GZwaVr1Clfk+KW
         GX3w==
X-Forwarded-Encrypted: i=1; AFNElJ9/mi+MhcrXmoBu+MopqR2r+Pvhcbt4j4078a9CdaaUl5J9gUAqtlKMhJDPOAX2vI5C2JslNEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiuf37ui2pPBVwimSnfwC2hjyPCGAR9qPSn6fMfFL3eopY6SJG
	1NH+BQvdq4MJwNfkNr9ma03mMrjMAswsjteduFc5qRjwBOGaTCMxJtLcv2lHy7kiP3ue9ZxUJok
	zLq5AL02b5/SvmjjGukFjsW6UrrkJ6/OsrVMVw/H7
X-Gm-Gg: Acq92OGiCIx8vLmmLq2xt/q5KnDDGQGerRWoYeWVvW6ITehCHr+f2UAuIUuIvVQyCh2
	UJSZZKLb06qUjvzgzKZ5fJ2xLxR2jES+toKC4Tp3qmA5psbtfTL2x5mWYgbaUBLu2YTxerWjROb
	0ZUCT1czMaAVs7ysACKF05hk4yzJgfrNQyW+ikg/9VRs60EewU6XDBMkX73k9eARMqScpJPA29k
	w40O9DLjEPjne7mTl6QbXs+IwzDU69vBnKgev5MWL6Ee8VrxWBXOx5XgAMLTe9EcSbZZQroP0eH
	BaEFUOujK2q1OmkfZ6FbPqL/trV76Re1WYlkOwL9a5B/+g1meYgYUyl+vCQyQYLbHglrRxZm2u0
	Uy2oe7UnXWsNDICFelpVlD6dETgQE
X-Received: by 2002:ac8:59c4:0:b0:50f:ba44:ce4e with SMTP id
 d75a77b69052e-5173a6197bamr168555841cf.6.1780317409230; Mon, 01 Jun 2026
 05:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531153946.1627418-1-runyu.xiao@seu.edu.cn> <20260601132245.4be1b32a@pumpkin>
In-Reply-To: <20260601132245.4be1b32a@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 05:36:37 -0700
X-Gm-Features: AVHnY4KlUnijWv5Pkux0oZHHU1PNs3xf3C1pnizY3mYdP6D5as5poIPKX1sCnmo
Message-ID: <CANn89iL5RYPYWPnwdiB2db+5bkgFt0_atBLHw4hopOq3KUK9Rg@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
To: David Laight <david.laight.linux@gmail.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sun, 31 May 2026 23:39:46 +0800
> Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
>
> > ipv6_flowlabel_get() still reads the shared per-net sysctl fields
> > flowlabel_consistency and flowlabel_state_ranges with plain loads,
> > while writers update them through proc_dou8vec_minmax(). These checks
> > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads leave
> > KCSAN-visible data races and can make the policy checks observe stale o=
r
> > inconsistent values.
> >
> > The race can be reached on a running system by toggling
> > /proc/sys/net/ipv6/flowlabel_consistency and
> > /proc/sys/net/ipv6/flowlabel_state_ranges while another task repeatedly
> > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > state-ranges flow label.
> >
> > This issue was first flagged by our static analysis tool while scanning
> > lockless IPv6 sysctl readers, then manually audited on Linux v6.18.21.
> > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KCSAN by
> > concurrently flipping the two sysctls while TCP reflect and UDP
> > state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KCSAN
> > reported races between proc_dou8vec_minmax() and the two plain-load
> > sites in ipv6_flowlabel_get().
> >
> > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side reproducer
> > also hit the inline ip6_make_flowlabel() reader through
> > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
> > fixed in this tree by commit ded139b59b5d
> > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The remaining
> > plain readers in this tree are both in ipv6_flowlabel_get().
> >
> > Use READ_ONCE() for those remaining sysctl reads so they follow the sam=
e
> > lockless reader contract already used by other IPv6 sysctl readers.
> >
> > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> >
> > Representative QEMU/KCSAN reports from the two target reader paths:
> >
> >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> >   write: proc_dou8vec_minmax+0x206/0x220
> >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> >          do_ipv6_setsockopt+0x873/0x2220
> >          tcp_setsockopt+0x72/0xb0
> >
> >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> >   write: proc_dou8vec_minmax+0x206/0x220
> >   read:  ipv6_flowlabel_opt+0x129/0xd20
> >          do_ipv6_setsockopt+0x873/0x2220
> >          udpv6_setsockopt+0x21/0x40
> >
> > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > ---
> >  net/ipv6/ip6_flowlabel.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > --- a/net/ipv6/ip6_flowlabel.c
> > +++ b/net/ipv6/ip6_flowlabel.c
> > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk, stru=
ct in6_flowlabel_req *freq,
> >       int err;
> >
> >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistency)) {
>
> That can't actually fix anything.

It fixes a KCSAN splat.

If you think you can fix KCSAN instead, please do so.

> If the value can be written concurrently it will still be zero or non-zer=
o
> even if the write gets split.
> So it can only ever be the same as the write happening a bit earlier or
> a bit later.
>
> There might be a real bug if the code looks at
> net->ipv6.sysctl.flowlabel_consistency again.
> But a READ_ONCE() in an if won't fix anything.
>
> >                       net_info_ratelimited("Can not set IPV6_FL_F_REFLE=
CT if flowlabel_consistency sysctl is enable\n");
> >                       return -EPERM;
> >               }
> > @@ -633,7 +633,7 @@ static int ipv6_flowlabel_get(struct sock *sk, stru=
ct in6_flowlabel_req *freq,
> >
> >       if (freq->flr_label & ~IPV6_FLOWLABEL_MASK)
> >               return -EINVAL;
> > -     if (net->ipv6.sysctl.flowlabel_state_ranges &&
> > +     if (READ_ONCE(net->ipv6.sysctl.flowlabel_state_ranges) &&
>
> Ditto.
>
> >           (freq->flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
> >               return -ERANGE;
> >
>
> -- David
>
