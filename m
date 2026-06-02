Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF203BB10C
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387240; cv=none; b=iPx7g8ON00+SM5hfhlQ1KEi80jJhWLmcbacQGoM36SrvdtbinwatPgtOgqR6EKbfGjhj0lJWwHFhPtzip2wjVKVo70WoN4g8I+O55HMg0M/3ZngEonSex7Uk+G9oSQ+VLWV6mVROwArvLdu24d9Ig/EqvCOR+35+dW7UzAEuJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387240; c=relaxed/simple;
	bh=ABDmoAvjP05kv7u0OeLlAtHWL2O1SJOEplteGzR9Ptg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/27fqYOyihXtXrFSu79pp2GFo9ncm4WCp1r/lZZpEng0xRsh76/Xk7lgpTLM9yv3AWhWX/LwI5+OyYhNp7K36H5qsA7/ISwdRduCM7fHe9iNwm+a2qn4b1JouXV+CpZtnfQX9x3c29HNFsvjLE2M+OMkUzuJ5PV4ZARJaVkacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YalpdgoA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YalpdgoA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49041e84237so89798765e9.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780387237; x=1780992037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j+2PtZRo6SPy8FA5buPLCnnYrJlwwHwsl8orB3/M8g=;
        b=YalpdgoAj6SIU0gm2yey+MrsRcVuyFVvqS96ueSafNZnemOKeAZB+f4dhfkRH2PgL5
         psLEt2OqKmPfgHFsXKKuT8W+yAY3xyUc4P3IOstRPZhVaFmcxw6umEs9DqvqbxYs2uY4
         SLFeDNP4A5+O6UcrXh4DcDThxIVOe86LUR4XIU82ffHhO1SWuZE2CSMr0ANvy1BQVGnB
         8ecbWINx/KwPrMw5hfzGF87L3kttMz0kQIoDgwMw5TQzLw6OLLrAf9kXBKa8iUvC5mdP
         L/brUv0lVGh03DSzethLk0EtmDcGpGGCu2LD7pAgiwT06OckxgflnoCGkCBe0PLk+yA6
         DL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780387237; x=1780992037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0j+2PtZRo6SPy8FA5buPLCnnYrJlwwHwsl8orB3/M8g=;
        b=R4iYjv9gcG4srXV3ukIWDywSy88Y+ZO3xNjBYndO2g9G0fu+/1cR56FN8abxSETd21
         4kRlW1FdRALFCarmSDziwSQ4RlGwiiOtOX82gC6N2BVJ0ZOmG2oe+n5ztAQ3JcUDOiVZ
         uEGJ8FdmmpYRsAtkmqYyRDWl1D0W3vgZc/yRRWUGhixvIpX7AGRfG2TkMm43QuMERDpU
         PPeAeVHXdDesT7A5llJmX7BAU3BcaRJyNWGyTP6R5/BYcIl5jng29bumMoyKzTkOIRLW
         WJAeHjBbq0kfsCUv05Kcpd2C1xXq9IWgDojSS6tWx/R8zWtyp0IXNBGynUPf74yJg51W
         CENQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2/BkESkksa+YlIt/x9wIM62JFsu4nian0ui970raOAVhrxblOJCwS/r98Egc1ETBQYP3T+us=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJqLWCxD9NwKuN9XfeKo+0qYy5aGKispDlO5R75u4icy/dAkU
	DhmBSOArXqq04xgQZOYPBv8s+hzhA4XWn4IKw8ZQXMqJ46n1Ocb7UH1T
X-Gm-Gg: Acq92OEWWvw0DZc4okopL3+6edaYzaJvem1+IYWUj+dxawf0Q0MctnpC1g+8Zl7aNyL
	INLySltABBFgTR7LYQkYaoEydMsCKdJo6w1/9xfC6bwft1d3b9KFnBlLpjxOt0L8LgeUx0U/hvi
	N82bMrBrPkYH4nrdtFFBJkmWPolSF6uk9CagmpkvPuVq+e5klSPsPPRJxKH54cIPi7WOeVXcp7l
	zo1Hj0n3B0l5NK0qhlhRvragiWGdKhYpRBlc3POFBDu4D6Jg2V8xE+TaJn2TQG4DnepNZ35eamH
	bSpaZr91Q3tnmmXLH2yIlBJLnabznatgjBl2mlqA8KUQOwfAjJJNcKnuvfCBXWtDSmpM4XDxdEW
	UVl81I7xS4X75+BMZA46n+OqpzsZFt0TDLEHyhPXWcypOa1+q+8vqnwpThay5Q3/3ukyu+MddOa
	uvyQOOV7Lc39+i+ZdbUHfNTp27DxZMEAJuZP7Nz5+Neu2HWHgiCtIg8Ru7FRJkGoO8grrjYDw=
X-Received: by 2002:a05:600c:c84:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490b0e9f45cmr39048035e9.14.1780387236616;
        Tue, 02 Jun 2026 01:00:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm82684755e9.0.2026.06.02.01.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 01:00:36 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:00:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, jianhao.xu@seu.edu.cn,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, runyu.xiao@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Message-ID: <20260602090034.7a5c243e@pumpkin>
In-Reply-To: <20260601231546.3407019-1-kuniyu@google.com>
References: <20260601223122.63c0d23f@pumpkin>
	<20260601231546.3407019-1-kuniyu@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  1 Jun 2026 23:14:44 +0000
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> From: David Laight <david.laight.linux@gmail.com>
> Date: Mon, 1 Jun 2026 22:31:22 +0100
> > On Mon, 1 Jun 2026 05:36:37 -0700
> > Eric Dumazet <edumazet@google.com> wrote:
> >  =20
> > > On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
> > > <david.laight.linux@gmail.com> wrote: =20
> > > >
> > > > On Sun, 31 May 2026 23:39:46 +0800
> > > > Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
> > > >   =20
> > > > > ipv6_flowlabel_get() still reads the shared per-net sysctl fields
> > > > > flowlabel_consistency and flowlabel_state_ranges with plain loads,
> > > > > while writers update them through proc_dou8vec_minmax(). These ch=
ecks
> > > > > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads =
leave
> > > > > KCSAN-visible data races and can make the policy checks observe s=
tale or
> > > > > inconsistent values.
> > > > >
> > > > > The race can be reached on a running system by toggling
> > > > > /proc/sys/net/ipv6/flowlabel_consistency and
> > > > > /proc/sys/net/ipv6/flowlabel_state_ranges while another task repe=
atedly
> > > > > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > > > > state-ranges flow label.
> > > > >
> > > > > This issue was first flagged by our static analysis tool while sc=
anning
> > > > > lockless IPv6 sysctl readers, then manually audited on Linux v6.1=
8.21.
> > > > > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KC=
SAN by
> > > > > concurrently flipping the two sysctls while TCP reflect and UDP
> > > > > state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KC=
SAN
> > > > > reported races between proc_dou8vec_minmax() and the two plain-lo=
ad
> > > > > sites in ipv6_flowlabel_get().
> > > > >
> > > > > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side repr=
oducer
> > > > > also hit the inline ip6_make_flowlabel() reader through
> > > > > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
> > > > > fixed in this tree by commit ded139b59b5d
> > > > > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The rema=
ining
> > > > > plain readers in this tree are both in ipv6_flowlabel_get().
> > > > >
> > > > > Use READ_ONCE() for those remaining sysctl reads so they follow t=
he same
> > > > > lockless reader contract already used by other IPv6 sysctl reader=
s.
> > > > >
> > > > > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> > > > >
> > > > > Representative QEMU/KCSAN reports from the two target reader path=
s:
> > > > >
> > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minm=
ax
> > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > >          tcp_setsockopt+0x72/0xb0
> > > > >
> > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minm=
ax
> > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > >   read:  ipv6_flowlabel_opt+0x129/0xd20
> > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > >          udpv6_setsockopt+0x21/0x40
> > > > >
> > > > > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > > > > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > > > > ---
> > > > >  net/ipv6/ip6_flowlabel.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >A
> > > > > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> > > > > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > > > > --- a/net/ipv6/ip6_flowlabel.c
> > > > > +++ b/net/ipv6/ip6_flowlabel.c
> > > > > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk=
, struct in6_flowlabel_req *freq,
> > > > >       int err;
> > > > >
> > > > >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > > > > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > > > > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistenc=
y)) {   =20
> > > >
> > > > That can't actually fix anything.   =20
> > >=20
> > > It fixes a KCSAN splat.
> > >=20
> > > If you think you can fix KCSAN instead, please do so.

ipv6.h has:
	u8 flowlabel_consistency;

KCSAN probably shouldn't care about byte reads.

> >=20
> > It is a false positive. =20
>=20
> It's not.
>=20
>=20
> > (Which I think you also said in a different email. =20
>=20
> I guess you meant this one ?
> https://lore.kernel.org/netdev/20260601074201.1186061-1-runyu.xiao@seu.ed=
u.cn/
>=20
> This is different because, in addition to Eric's comment, IPv6
> address is 128-bit and data-race is inevitable without locking
> unless CPU supports native 128-bit read/write; we already do
> load/store-tearing of 128bit with u32/u64.

But the code isn't looking at a 128bit value, it is only doing a check
for zero (and READ_ONCE() doesn't support 128bit values).
If there is no locking the value can change just before/after the test.
Even if it were subject to read/write tearing absolutely the worst that
could happen is a zero being detected when the value changes between
two non-zero values.
That isn't relevant here - it is just a boolean.

-- David

