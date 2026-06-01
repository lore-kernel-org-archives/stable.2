Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184DE3438BF
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349488; cv=none; b=uarKGBXkYMK6zPVwwakvI62ol19Qyfl8WCi/iIf5/32zyb0g494E/ImOCY/R/mRzqJ/kPvXJj489Fr7ey5bXDCjWH/TEK0FTGtae83fQq+OWC0EZT0vHv+H3oZcHyVsY/aX4qGnFrN1GzFITUN5BZ/vVscR5y7VV59QJj5qUXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349488; c=relaxed/simple;
	bh=Q04HHqCNMvuz+9/io2PQGUaUhDGXaJOQ++RaknZ+Yj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nW/nmzP8HFAsj3I6pVriwi9I3w9qRbh0n2/lj2khauqAuJ5B0hcRzbYGFGv+Ut7TBNqk1b19A2IuyJg19UmovKxSi9DqrmQ+JIU+gRLZBG/Y5ICuGaN3L5lPwO2WiiypjoI2to08lEw9UzKs14KmRQi3ehmwR6Vq+YFyFMXn298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruwNycYg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruwNycYg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so118697025e9.3
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780349484; x=1780954284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aps6S5lqWxgw9ER0P66xSnHFOS5VJXJLk5UkrjHU5Mo=;
        b=ruwNycYgZzJCx6l+sTUPDIIvrsmLjiGsM7anTYS2cOWTBQ7Ry9TAlngSoDuznkdFUH
         6BNSO/QX6VtxtXOJ6s61AXLKlBA38yH5ZEtSM/tjIYNWaEQFi0/nORHZjVsb0ZTDei/N
         X2MBY+0uZwmxpdpZgEVnaZFxnsand/vKPGwCk9G05OJitYRsdXuvN7TBf4g5X7xqbq55
         pu1NFa2PgcOh28uRygIbhThTPMLJnxHOCftgWx+OFqxpBMHCykW7Ekw9onJk8kdzNMnF
         bd4jWIf8mxopdJKCLltWMNqtAYL8xJQ2eSf0x9bH9V/mxHEneEoq54teYqkD4+lo3vcB
         aemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780349484; x=1780954284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aps6S5lqWxgw9ER0P66xSnHFOS5VJXJLk5UkrjHU5Mo=;
        b=UOfIP29/9PYFNq+EuNPoo7T0DvhiF21hoR0tllata5lg8lrpjOwJW2cp9hLmMRjSn/
         X5NDeRaAM2CJaRWLxD7L+73TiypjpLmuepUcJ8FwkzoDH3upCVD7Iy8I6sx9LJJkCz8Z
         G8scVsNDj5VJh9ZULfggCCYtKNULIjcAjXBgjOb4SIjyPx9m+ZLltW42rTNElBYJFVbt
         kn5PlbIUiaKj3/Ovs3ekLojDViGCS/r2py4Q5vIIVaYBg580fJrV4yPj00I+QVBvQ3nG
         zi6Ve5rUBlNMfMuTd9BVk9NY/liM0MxSumaCHRSuY5NMmwd30XwpKDTkE7verBZPX0Ts
         5tbg==
X-Forwarded-Encrypted: i=1; AFNElJ+J6d+HUg40b7rDW2PU8LdpaKAUh79MWtj+Rwkn7GSIwvdpgxvP7yIBQ/FAI27F59oL7NkTEqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIltk3wQoJ6Y0nx4jLJIBt+XKzcjULfMV/3chdOA7/c/UyDls
	dI5aWsvg3TjihzKrIW/31SaW7nqrwapSCrgHaTiSeNnIqHeGDMmDkEgI
X-Gm-Gg: Acq92OFkIn7v8fu/6j4AyjQoSgDpaQG+5zhsglBw1Y7HAqrAEfxFflWfEfFJgswiOaE
	qrzvA6/zj5M2/Idb6kExJAcL61kzJ9GaPbnwWUwGjKvcGFRW5HpgC6tNyKpgdsBK+9Z/8U6wGeM
	qchiwP/dljrAXG1ah1vGp2Cgdb4PpH//FPK6MWuHMEgKMxrfVy/IAH1O1IE8dbgZPeXdIcVI+gr
	tMHO5+nrC8QREBwJGkdM/ymShqTdeD6hWc/J5iEvraC6e+qLCvt6VsT6S4lQqmzsPPdZdFlLeRA
	IPllqcVpcCO0DDaZ9o+oJeSOc5+epRvF9Yr2r+xV4TAxIJgviwRYofHbJT8gNHyyy5zx/xBVQGq
	SNQ51qBoxsNbMLh88gbzi7HrfIAGlk49P0nYnOuTC9YwLIF6YpbRBSAdGJPNjoO+ZoPrI5jusB2
	QH5WdY5BSnVisriheVpT8pNxS+VHzubPb3QST2EJi1YlGinEwDj80NlOL7g3JRWn/QTvImOK0=
X-Received: by 2002:a05:600c:8582:b0:490:48e2:5618 with SMTP id 5b1f17b1804b1-490a296046dmr181264715e9.22.1780349484313;
        Mon, 01 Jun 2026 14:31:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c128dacsm83516355e9.32.2026.06.01.14.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:31:24 -0700 (PDT)
Date: Mon, 1 Jun 2026 22:31:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Message-ID: <20260601223122.63c0d23f@pumpkin>
In-Reply-To: <CANn89iL5RYPYWPnwdiB2db+5bkgFt0_atBLHw4hopOq3KUK9Rg@mail.gmail.com>
References: <20260531153946.1627418-1-runyu.xiao@seu.edu.cn>
	<20260601132245.4be1b32a@pumpkin>
	<CANn89iL5RYPYWPnwdiB2db+5bkgFt0_atBLHw4hopOq3KUK9Rg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Jun 2026 05:36:37 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sun, 31 May 2026 23:39:46 +0800
> > Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
> > =20
> > > ipv6_flowlabel_get() still reads the shared per-net sysctl fields
> > > flowlabel_consistency and flowlabel_state_ranges with plain loads,
> > > while writers update them through proc_dou8vec_minmax(). These checks
> > > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads leave
> > > KCSAN-visible data races and can make the policy checks observe stale=
 or
> > > inconsistent values.
> > >
> > > The race can be reached on a running system by toggling
> > > /proc/sys/net/ipv6/flowlabel_consistency and
> > > /proc/sys/net/ipv6/flowlabel_state_ranges while another task repeated=
ly
> > > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > > state-ranges flow label.
> > >
> > > This issue was first flagged by our static analysis tool while scanni=
ng
> > > lockless IPv6 sysctl readers, then manually audited on Linux v6.18.21.
> > > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KCSAN =
by
> > > concurrently flipping the two sysctls while TCP reflect and UDP
> > > state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KCSAN
> > > reported races between proc_dou8vec_minmax() and the two plain-load
> > > sites in ipv6_flowlabel_get().
> > >
> > > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side reproduc=
er
> > > also hit the inline ip6_make_flowlabel() reader through
> > > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
> > > fixed in this tree by commit ded139b59b5d
> > > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The remaining
> > > plain readers in this tree are both in ipv6_flowlabel_get().
> > >
> > > Use READ_ONCE() for those remaining sysctl reads so they follow the s=
ame
> > > lockless reader contract already used by other IPv6 sysctl readers.
> > >
> > > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> > >
> > > Representative QEMU/KCSAN reports from the two target reader paths:
> > >
> > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> > >   write: proc_dou8vec_minmax+0x206/0x220
> > >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> > >          do_ipv6_setsockopt+0x873/0x2220
> > >          tcp_setsockopt+0x72/0xb0
> > >
> > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> > >   write: proc_dou8vec_minmax+0x206/0x220
> > >   read:  ipv6_flowlabel_opt+0x129/0xd20
> > >          do_ipv6_setsockopt+0x873/0x2220
> > >          udpv6_setsockopt+0x21/0x40
> > >
> > > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > > ---
> > >  net/ipv6/ip6_flowlabel.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> > > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > > --- a/net/ipv6/ip6_flowlabel.c
> > > +++ b/net/ipv6/ip6_flowlabel.c
> > > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk, st=
ruct in6_flowlabel_req *freq,
> > >       int err;
> > >
> > >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistency)) =
{ =20
> >
> > That can't actually fix anything. =20
>=20
> It fixes a KCSAN splat.
>=20
> If you think you can fix KCSAN instead, please do so.

It is a false positive.
(Which I think you also said in a different email.

-- David=20

>=20
> > If the value can be written concurrently it will still be zero or non-z=
ero
> > even if the write gets split.
> > So it can only ever be the same as the write happening a bit earlier or
> > a bit later.
> >
> > There might be a real bug if the code looks at
> > net->ipv6.sysctl.flowlabel_consistency again.
> > But a READ_ONCE() in an if won't fix anything.
> > =20
> > >                       net_info_ratelimited("Can not set IPV6_FL_F_REF=
LECT if flowlabel_consistency sysctl is enable\n");
> > >                       return -EPERM;
> > >               }
> > > @@ -633,7 +633,7 @@ static int ipv6_flowlabel_get(struct sock *sk, st=
ruct in6_flowlabel_req *freq,
> > >
> > >       if (freq->flr_label & ~IPV6_FLOWLABEL_MASK)
> > >               return -EINVAL;
> > > -     if (net->ipv6.sysctl.flowlabel_state_ranges &&
> > > +     if (READ_ONCE(net->ipv6.sysctl.flowlabel_state_ranges) && =20
> >
> > Ditto.
> > =20
> > >           (freq->flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
> > >               return -ERANGE;
> > > =20
> >
> > -- David
> > =20

