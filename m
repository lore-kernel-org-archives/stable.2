Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775D3F1052
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787866633; cv=none; b=jMVgAZG3zFVtYMKkYmeo2ImIurGb0/JYXC2r3O7/VrHSYXE2lcXK6xEHWmLWhQ+d+cp9k+YZgGYTWl4sKYs+tmfNSb5i8f87HKVqLkzj5MA15UKigM3cUSlIOlPPxBND9D/CNRjcYKi4UzmFhoIro6ACdNswqUVmVdEEORRUNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787866633; c=relaxed/simple;
	bh=MVS3MqFQf5nOYO111RQGfP3Q+5aQrHBy/oQoaRuefpA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FMxU7pdXJVbtTpnDBoo5wM1u7uO2M9MhP1Hp4SPB/DOZTwJ6vkdYFoiaqxmnm7d3qJzRsoGjMU7jOBkpvEdismKeGWFTrk+K1YT/G5agMxxPMMYNOzF9xxtb2gtRREJGBK7R0MfBTPrYcRLziU3l5tQ+kzXjgHlH4UWUvAM3Icg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKT+hZBJ; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKT+hZBJ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66bd7857841so548608d50.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787866631; x=1788471431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iKxmLE9hf6MpMQY4pzmqs7Mwfr+fiaYlyEs/OaHa80g=;
        b=NKT+hZBJTnrCcM1XptRmFWGP3z7r6/EkzoPRpextYixq1CZaOgeEiPfCoe1Yfd+Gnw
         Ywz41dTbjPBt04bar8zEkuHgAmb6UVkJpLDX8gisWivh05vNPWpJQ88/DahHcdIL5vSk
         6pvP/VA51mhvvNq4P6uVpP7wcFEOmLdmEiUxtn4f3vJCDuT9TcyHYMmapuU7eaH0TEyV
         aPyb9rFTd8rVofcy92xvlE8uclyocE9HwKRWTmYV9LRmBkqD6RE5o7TkSJncck7+imMG
         2fwjsjiBuQG6Zt5eEtok9W4GC6xgc886f1c4hxN646O43GX3mFavxn4rxm2Gqq0kA5yR
         XtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787866631; x=1788471431;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iKxmLE9hf6MpMQY4pzmqs7Mwfr+fiaYlyEs/OaHa80g=;
        b=Rqo46BTwZYWJ37gE9YGc8SK+DxCA7oCJ0ZkeTPLMfqF22pvVaNlZfD5UiIkPgQGlU/
         QbxKijO7BrZ+8M3qo6+SlRHe/7mjiwocFC6w6RprP0LlfD0diMGkUgMK2RXidqt8GCIu
         +jiB553fohg33afaqxxDtDHSFHqhZHFXy9vc11IJYDdSqtyYmQti2rRHvzepgx0MII9V
         sDgfazWEtq4gDcmB9unSUe2JAe8A3z7g0vZwHUTPL8B/JR24sOymP+XvehXEucW8goDm
         2ScjRfi0BuYRJBUAa2zbC0Tps93BZVbrkZ53ZJ+9Puo1FlXod4JOELa5tg2z8n8WEZSC
         pxbw==
X-Forwarded-Encrypted: i=1; AHgh+RqnlUH/Y1qz9Hqw/zRVq51V6Bq3ReulC2yhT9JsEMsHsoh3MnCFwtZiRrlCyeGzAVrcY3+yc/4=@vger.kernel.org
X-Gm-Message-State: AFuF++lQjxYPrXKgzIBl7GudXE+FtE2LKavA862CLylq/8t5u4HiTbTM
	sbdDluoH7Q5M3yj15xW8nX+bEJuVp0V/kpvZG2TPpDSTx55j4BAIKmpu
X-Gm-Gg: AR+sD12NOItJ76yfgOL+QvTnvG5pUfxa+lERx0NCq89WZ0FBAdzHmgikxX6lE4TmUtZ
	1ArIyGbY/jNBqfW7oBdDH0eBirLcBsJs0p8GBCScG5H2AhQ+VIlVEBbv6j9kYgYDN8xhXoyWZSS
	5ftxd/+Y/v2AAr4+ZZ5LJupN0/jnZyzOPetqUxZSX0hUS1Nkkj/OoOE6UW+mXwGmeaD7GSeHdcs
	Z1Vt4JAtbijXCHX0XFD4KU9gtgTd+oyS/7PK9bBbD0nsGyi3+U7ceEAIkmRlGLRngKIFvNlPjpR
	SpIGKMFpNWuq+rDaczRvKQVNWQkSqu+xz5tXo8CUaW33uiu/bGfHg0uMi0GSLVtN0AGITysBgMg
	f9xbyJkbOyIzYeA6phs/azioB6iWy368Med5IUwpW9gpllzU1v8BS9BCewCocEQTLgJCsMdMN1G
	ktU2iyCZLlnOliOaHGUrxN/6WL1Tp9Q/lxMWpIHLQuzbY/A5rmsRxU2YSauYUYELsYSkaQU0kOW
	AK2yuGqRiKvWj3pm6rBvkGv3NG5J4OGFsnKAiJkVA==
X-Received: by 2002:a05:690e:30a:b0:66c:f20e:4e93 with SMTP id 956f58d0204a3-66e4c662ee0mr455399d50.5.1787866631021;
        Thu, 27 Aug 2026 14:37:11 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b624f8249sm16819347b3.45.2026.08.27.14.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 14:37:10 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:37:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: jv@jvosburgh.net, 
 jiri@resnulli.us, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 stable@vger.kernel.org, 
 Hangbin Liu <hangbin.liu@linux.dev>
Message-ID: <willemdebruijn.kernel.361c9e585560e@gmail.com>
In-Reply-To: <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.2ec10017f4836@gmail.com>
 <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qihang wrote:
> Hi Willem,
> =

> I'll resend this as v2 with a cover letter.
> =

> On scope: I grepped every header_ops->create.  Five devices delegate to=
 a
> lower device (bond, team, macvlan, ipvlan, 6lowpan), but only bond and
> team re-select that lower device under RCU -- the rest bind it at netde=
v
> creation.  So bond and team are the full scope.
> =

> Re Fixes: I used 950803f because it introduced bond_header_create (wher=
e
> this check lives); before it the type-confusion BUG masked this race.
> Happy to point at 1284cd3a2b74 instead if you prefer.
> =

> On the fix location, I'd rather get your read before writing more.  The=

> options I see:
> =

>   1. per-wrapper headroom reject in bond/team only -- small, safe,
>      backport-friendly, but not generic (the next stacked device needs
>      its own).
> =

>   2. central check in dev_hard_header on dev->hard_header_len -- one
>      place, but I think it's unsafe for bond: bond_dev->hard_header_len=

>      only follows the first slave (bond_setup_by_slave),
>      bond_change_active_slave flips curr_active_slave without touching
>      it, and same-type slaves can have different hard_header_len (two G=
RE
>      tunnels).  So it can under-reject.  Would need bond to maintain
>      hard_header_len differently first.
> =

>   3. resolve the effective {dev, ops, hard_header_len} as one RCU tripl=
e
>      via a generic callback, so the caller never cares which subordinat=
e
>      the master picks.  Truly generic and race-free, but it's a new ndo=
 --
>      net-next material, awkward for stable backport.
> =

>   4. make header_ops->create() take an explicit headroom contract and
>      fail cleanly instead of pushing blind -- cleanest long-term, but
>      touches every create() in the tree.  Too heavy for now.
> =

> My v1 is option 1 (per-wrapper).  Want one of these, a combination,
> or something else entirely?

Thanks for the analysis.

I agree that 3 nd 4 are too invasive for the scope of the bug.

It's a bit odd that bond and team just take the hard_header_len of the
first slave. And that bond_create_header just passes to
curr_active_slave, while various bond modes like LAG will have
multiple concurrently active slaves.

That indicates that the intent is for all slaves to have the same
header length and header_ops->create callback.

But this is not enforced.

Given that this seems a bond specific issue, that was copied in teams,
fair to solve it there. Doubly so as due to RCU we have no easy path
to solve it elsewhere. So +1.
> Thanks,
> Qihang
> =

> =

> On Wed, Aug 26, 2026 at 10:02=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Qihang wrote:
> > > From: Qihang Tang <q.h.hack.winter@gmail.com>
> >
> > Thanks for working on this Qihang.
> >
> > Minor: a patch series should generally have a cover letter
> >
> > > AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
> > > bond_dev->hard_header_len.  A concurrent bond type change can switc=
h the
> > > active slave to one with a larger hard_header_len between that snap=
shot
> > > and bond_header_create(), so the slave's create() pushes or writes =
past
> > > skb->head.
> >
> > Are we certain that bond and team are the only devices that implement=

> > header_ops->create?
> >
> > > The hard_header_len snapshot series that fixed the SOCK_RAW send pa=
ths
> > > deferred this SOCK_DGRAM race: dev->header_ops is the stable
> > > bond_header_ops, so snapshotting header_ops in the caller does not =
help.
> > >
> > > Reject the frame if skb headroom is smaller than the active slave's=

> > > hard_header_len, before delegating under the existing rcu_read_lock=
.
> > >
> > > Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_=
slave()")
> >
> > What's the rationale behind blaming this SHA1?
> >
> > > Cc: stable@vger.kernel.org
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
> > > ---
> > >  drivers/net/bonding/bond_main.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/=
bond_main.c
> > > index 522eab060f9e..9ec663610dfd 100644
> > > --- a/drivers/net/bonding/bond_main.c
> > > +++ b/drivers/net/bonding/bond_main.c
> > > @@ -1524,10 +1524,24 @@ static int bond_header_create(struct sk_buf=
f *skb, struct net_device *bond_dev,
> > >       slave =3D rcu_dereference(bond->curr_active_slave);
> > >       if (slave) {
> > >               slave_ops =3D READ_ONCE(slave->dev->header_ops);
> > > -             if (slave_ops && slave_ops->create)
> > > +             if (slave_ops && slave_ops->create) {
> > > +                     unsigned int hlen =3D READ_ONCE(slave->dev->h=
ard_header_len);
> > > +
> > > +                     /* Headroom was reserved from a snapshot of
> > > +                      * bond_dev->hard_header_len that may predate=
 this
> > > +                      * slave (concurrent bond type change); rejec=
t if
> > > +                      * insufficient for the slave's create(), whi=
ch
> > > +                      * pushes its own hlen.
> > > +                      */
> > > +                     if (skb_headroom(skb) < hlen) {
> > > +                             ret =3D -EINVAL;
> > > +                             goto unlock;
> > > +                     }
> > >                       ret =3D slave_ops->create(skb, slave->dev,
> > >                                               type, daddr, saddr, l=
en);
> > > +             }
> >
> > Ideally we could fix this in dev_hard_header or PF_PACKET itself,
> > rather than in each implementation that's in scope.
> >
> > But there seems no way around holding this rcu reference on the slave=

> > device while re-checking.
> >
> >
> >
> > >       }
> > > +unlock:
> > >       rcu_read_unlock();
> > >       return ret;
> > >  }
> > > --
> > > 2.50.1 (Apple Git-155)
> > >
> >
> >


