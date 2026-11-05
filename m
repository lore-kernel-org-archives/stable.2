Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.193
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793889425;
	b=EMIEjRgv2CkFyj4s2L8VlLmnvtDWbZNdQ/IEz4yLemgyNYUnHsvnqkVLGfdGHiD6uohw
	 1wbMMh2lEIp0EQl94eKvO+5SPmInUfaqHz6EFURKjZooFdYVm4ewJ4Y3J4OyoDP1LGrVJ
	 MzFoszBOERPCHn8gGIHu5otEjiX1QUupzR07wH9V8zWONPXecirwO+14h5892B4RNOsyT
	 QhO4V3xkOILAYlXRQG9/l1Ihez+vFSURqfs2irA+hNMYndFp+GXtn4zbDLrDjLvFdv6hF
	 ft1589Xp1a/UhjjeCadm8BBRsHTXSDLIpmMcwjEhKVtPh8Gi1qAZyyIlfWbZSaAd4WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DHeTUVuiTBjbauI8dLmk022PX+e33Fq68ZaAqyfLd2I=;
	b=mXdoW1VkElyH9s8/1Pf/Y9/Gh0aP8hW/vIbHtumCgs0P7SxayEyXxdZQXRMGUALFbs/S
	 XOtZbFZXz7siOz6c7gICTA08Ay0yETUHNur8u7TJ50KkGhCxr3KmnX0pckHi7aUWbjv38
	 XC3fJ8FItG3uFwVi/IvCSZqpvB5m1hQzySk56Eqqd+j7CjTxFKuXTPNHu3cZek2RfVYPe
	 XwqkUn+2XlHy6ldJ2q3nvmvnlx8bmzajZkwjfRnslBu5O1t2Ht5pZzzx5DzVaoTJfCO1S
	 oBuaOJX3pzSFxVOC5j4tO4pYJkWeaD2C+eLEVoDB8nc9wy+66log+OnYlPAcirePpfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l+UMVme4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.193
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20E606A335
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A20E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l+UMVme4
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-3ab28f3e4dcso5564471fa.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:37:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793889423; cv=none;
        d=google.com; s=arc-20260327;
        b=jS54UR/IfWjCqPkvN7Yd67dUZVReJSWpY/NMiaeRQ9COVct3MHbzJoLiDs0dvEUxr4
         5Hg6J/1QsdauVCbiGsOUVJgAJu76jKsqZR9lBnHFVGahD18b2ZtIp6E8kkd0TYyvJtI/
         hm8US+vA9tWc8xXyR+61t0RkgeLxCG+p7DD5MGaxWnnPd9hX31RviMJQKhghqgJ3WOF4
         yf2k4vfy02aHe/OnLuec043IxJYYQXqsFaVfK45hVAnfuUnlMR0Fqym7G4Hyv+6afqRf
         OWqj5ozmgHpAcG7rEgjVhzAvqxAGXtrrGk0Bw5QJlFV3imB+CFG+PYhnUTYJuW7SXQyU
         gTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DHeTUVuiTBjbauI8dLmk022PX+e33Fq68ZaAqyfLd2I=;
        fh=RCTBX5/gIJaz9n1u4fOfoUSmC9LVsFGpqnAjRM/jroI=;
        b=IyVRVWPDjktNyovFICyTyMdsqeMNRa2/dJ1zG/aqI1XwxLAZxlG+zAoGOE7qbE5tZm
         kVQB9ol+OkRqqgE5lHy28vZTmKyWtFfmR7UvZOemvtFKh6MA/ikDsoYWbr8XoHlj1g9Q
         VPLbYDyvMwlvD2uJpvRaQID6BA9ED+T54pa+5rW0+WTyjrw1LaC2fM2iaNbiiYzwHRa4
         KoxmYL1BOaAfY/9t0a0kxEzEhuZajnQJZp/p/DXEN/TeKMY1i/J6oz0QvyM1P5lseaxg
         Cn36QfDnc/sNlROdI1/On1M3Qj03L0u+NuFRCYoApir0LF6nbrvWUli5NhYOGhbWfLr9
         oPPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793889423; x=1794494223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DHeTUVuiTBjbauI8dLmk022PX+e33Fq68ZaAqyfLd2I=;
        b=l+UMVme44W7mXhW+n4bs1ZvUk7K/XFSgtTNuZb6aKWq4tZP0RNoeShij6xbvrpPla8
         +I7bKYX2HxC5gAC5metDT7Egd6ikPoCa8LVpdA4blXbtUQg+qTl8eHC6VidtZ6rXsSfR
         lepnkAP+eawhfj/Yx5Gpb55zjPf4MS1FzrM2/5MAGeffbklBXvY3LQ9HlVMUFSyGXajR
         aBRQVSLoHDhIXOU9yoVCzKyYbpCeuE8hMFXleSNtf7UJbRtEA0+9CYpX/6Qp9fhLRhNU
         Dm3ujHItYkyIDcGkq7W1sTRdNjrqBUXV5F8GVsc5l5DsMhDw7+96FBZb7cU3PPIAXAJC
         VksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889423; x=1794494223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DHeTUVuiTBjbauI8dLmk022PX+e33Fq68ZaAqyfLd2I=;
        b=PRk9V14dGC5eIRr8+GDJ+weiNx8mSW5dolcfVH8y+D/f2F1UnaUMSsyy3QNUUJwDzF
         s+wcf0BIlv4ybDwLFD+groe6ouTdL18X9Opthktz8HaGPOiIvEbXeiCIt2VinjurGP6z
         Wl5on4KXa31usXteFyQJpOmNbGnFTvvLrJfIKlQNGPApEtLNvWYlk0ZMdGNJVwlvCA0Z
         69j/nTPbfJyhUujxngHa/0lHANdF/XZ5weTz5qF9xgnrSMZmqlmb25jannNQJl12Msev
         uNS/iZqgyTXUFZT4EvjQnrboCRQ0NpJRfpOleV6mvYsahWPhHUkWE6TY7sYTwlE/wkc9
         oJ4w==
X-Forwarded-Encrypted: i=1; AKwUvBziwyvXSjR8rseDtC1RPIhElZGUFVC3O1CO4S3ZyFQrCKMP/+5qCzUy8POfxNgDe8/vimTR+U8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/I/KVaWIZhr6UdNV65300QftkRgMmnjS3sntrogNVkNQ2fuIAC
	FGQfuJfnnuI0kRLIAp/0N1YnXAj79VdFhVe09eE8Hlq8xdKxb7bEYvoUCCsreIUu/fRZtFwDgFM
	mVOvmijZhUQWe2qi7uzSCYVqoibdtG2k=
X-Gm-Gg: AYBFou2NUrwwn0UHTUlfUoHq2Qb6XnOg1KnaMKliVXBESGaQpLolh9fE3E1P6xlUymE
	e4C+fyOohBgrBrCkGhC7wnT5nFJ78VkeE698bCcjNQwj5xDCRWe6B9pl1VgfKqGBwLiG5ga5MMB
	GY8mwEwNrzZ9TgWDjHN/23qHa2pGT8rZOs9lMBHULy4+ty/aGabpd+QcY4+Zm1lWdqbM8Sikqoj
	lsNSqugwYEpnPZUW2RRsQti5EbvKWc4xzO9ZFLy5+CCyOHIGuOe7jZgMvucs6xGZ6CaGup+LYib
	m0Gk0iR9PjO2e8H4Zvs8Numc73baSMQYVbMB8QbnFN2hdEsq807/4UcKnBUmWRzu5Qacgc7Rlcg
	qwRVjG1yUg2Wm4KH3QA+cYFUAcgPmEKz9+QIu
X-Received: by 2002:a2e:a90d:0:b0:3ab:4e70:6959 with SMTP id
 38308e7fff4ca-3ace317682dmr6372091fa.19.1793889422899; Thu, 05 Nov 2026
 06:37:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105114707.3030737-1-bsdhenrymartin@gmail.com> <CAL4Wiiq4AoNzymK0F+q34rVfsBM=0-cioH33ETqO=O8soNQPWA@mail.gmail.com>
In-Reply-To: <CAL4Wiiq4AoNzymK0F+q34rVfsBM=0-cioH33ETqO=O8soNQPWA@mail.gmail.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Thu, 5 Nov 2026 22:36:51 +0800
X-Gm-Features: AclHuK9I-wsuPMwQzskfQ12tiNDT6JLC96NbaEUE1ZdMyUTkEUYmTHnIvUnxl_8
Message-ID: <CAEnQdOo7vFQbO9O9nLnK3FBmEVq2a6K0c-vRZgp57qtoi5A52w@mail.gmail.com>
Subject: Re: [PATCH] nexthop: fix null-deref in nexthop_flush_dev on
 UNREGISTER rebroadcast
To: Eric Dumazet <edumazet@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>, dsahern@kernel.org, 
	idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	namangulati@google.com, kuniyu@google.com, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Agreed, thanks for taking it to the core. Your fix covers the whole
notifier class - happy to see it land.

Thanks,
Henry

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=885=E6=97=
=A5=E5=91=A8=E5=9B=9B 22:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Le jeu. 5 nov. 2026 =C3=A0 12:47, Henry Martin <bsdhenrymartin@gmail.com>=
 a =C3=A9crit :
> >
> > A device unregistered outside its netns teardown can be stuck in
> > netdev_wait_allrefs_any() while the pernet exit handlers of its
> > netns run to completion.  nexthop_net_exit() frees devhash and
> > sets it to NULL.  The rebroadcasts then hit nexthop_flush_dev(),
> > which dereferences the NULL pointer, e.g. on mainline v7.4-rc1
> > (KASAN build):
> >
> >     Oops: general protection fault, probably for non-canonical
> >     address 0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
> >     KASAN: null-ptr-deref in range [0x0000000000000020-0x27]
> >     RIP: 0010:nexthop_flush_dev+0xb8/0x240
> >     Call Trace:
> >      nh_netdev_event+0x250/0x330
> >      netdev_run_todo+0xaa2/0xef0
> >      rtnl_dellink+0x35f/0xa90
> >
> > The faulting task holds RTNL, so the network stack is left wedged.
> >
> > Skip the rebroadcasts, which are the only NETDEV_UNREGISTER events
> > delivered with reg_state =3D=3D NETREG_UNREGISTERED.  This mirrors
> > commit fd0909e963ed8 ("netdev-genl: ignore NETDEV_UNREGISTER
> > rebroadcasts").
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Fixes: 8a4fc54b07d75 ("net: get rid of rtnl_lock_unregistering()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >  net/ipv4/nexthop.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> > index 42e55b5a755ee..1eba7026abcae 100644
> > --- a/net/ipv4/nexthop.c
> > +++ b/net/ipv4/nexthop.c
> > @@ -3996,7 +3996,16 @@ static int nh_netdev_event(struct notifier_block=
 *this,
> >
> >         switch (event) {
> >         case NETDEV_DOWN:
> > +               nexthop_flush_dev(dev, event);
> > +               break;
> >         case NETDEV_UNREGISTER:
> > +               /* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGI=
STER
> > +                * while waiting for the last references to be dropped;=
 the
> > +                * netns and its nexthop pernet state may already be to=
rn
> > +                * down by then.
> > +                */
> > +               if (READ_ONCE(dev->reg_state) =3D=3D NETREG_UNREGISTERE=
D)
> > +                       break;
> >                 nexthop_flush_dev(dev, event);
> >                 break;
> >         case NETDEV_CHANGE:
>
> Thanks for the report Henry, I was able to reproduce this crash.
>
> Your patch is correct for nexthop: the first NETDEV_UNREGISTER already
> removed all nexthops using the device, and no new one can be attached
> to an unlisted device.
>
> But I would prefer to fix this in the core instead, for these reasons:
>
> 1. This is the second instance of the same bug after netdev-genl, and
> it will not be the last. Any netdevice notifier using pernet state of
> dev_net(dev) in its NETDEV_UNREGISTER handler is exposed. Adding a
> reg_state check in all of them is whack-a-mole.
> 2. The NULL deref is only the first symptom. Once cleanup_net()
> completes, struct net itself is freed, while the stuck device still
> points to it. Following rebroadcasts then hit a use-after-free:
>    - netdev_wait_allrefs_any() itself: __rtnl_net_lock(dev_net(dev))
> with CONFIG_DEBUG_NET_SMALL_RTNL=3Dy.
>    - Any notifier reading dev_net(dev) before checking reg_state, for
> instance ipmr_device_event() walking net->ipv4.mr_tables.
>
>    A reg_state check in nexthop (or netdev-genl) does not help there.
> 3. The root cause is my commit 8a4fc54b07d7 ("net: get rid of
> rtnl_lock_unregistering()"). The barrier it removed had been added by
> 50624c934db1 ("net: Delay default_device_exit_batch until no devices
> are unregistering v2") precisely to prevent this situation. I only
> considered the loopback dependency when removing it, and missed the
> notifiers one.
> 4. Restoring this guarantee in the core is cheap: a per-netns counter
> of devices sitting in netdev_run_todo(), and
> default_device_exit_batch() waiting for it to reach zero once all
> devices of the dying netns are unlisted. In the common case the
> counter is already zero and there is no wait.
>
>    Then all NETDEV_UNREGISTER handlers, including rebroadcasts, can
> again assume that dev_net(dev) and its pernet state are alive, and
> nexthop needs no change.
>
> I tested this with a KASAN kernel, using your scenario (a nexthop on a
> veth whose peer is deleted from another netns while a reference is
> held, then the netns is deleted). The crash goes away.
>
> I will send the patch shortly, with your Reported-by: tag.
>
> Thanks.
>
> pw-bot: rejected
