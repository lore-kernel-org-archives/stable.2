Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380075;
	b=D8hZXh/irw4KqjPgkxo7SJQyExn4+8KuFhAd/vzEXoIKLG/2NF3IOXnJUUS+ODHApjY0
	 CyJkUBKro5L8qPHcS+I8CHkyrqGlTEudNdt8x/xJrTx5Ho/tQ9WDD5feUyWoKGlOrrncC
	 z7+cvNVBaL4KKCkdQukZK9/EboUYORqqRuUnuaClwMuvZ2uinTcVkIr4a9B8ZXE9p/wo1
	 lB3LlUwuH9f8PKTRXtonVlhZrxcRz6pSEK9BlKKlQ19pnOSf1L7M8uQLnGz5ECv0pdV17
	 mSyFfgUWo8S8azu3nZv33m6MlKbOGRQlR+u/bbQyvX27gjg5IKeHQVsWbnzvdyuoNng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qob3acME+/uuwxiwUET/rYXw51dpGRAJwWeO+kYwEXg=;
	b=sPKFmVdgJXf7k4InXVsaq+sA0mT0As6CK7QKuzorldRxPkA2fWERMWY+8MQHJasPeEbY
	 p3/RrDiXD8rIM50y8vnSqqOIUdNt6C4i8K+1FjeuUSGobJ+1XLob88Z1pbUOVz8b30/0f
	 a9IUlQaeqH1Y3px938IuMDH2YNtWQq0kXizuae1ZVCeqIqsa/OY23gvQF2XMONnfo9NZQ
	 xwMfiN43/ZZ8gRBDKuPEswYb6qs/yP2KgKa5w36E2blpVVdEJpbzdSnM5MoVsnDFv/Ss7
	 nq+SV4GVB4PLwtfm9DqC1QLswn3mM2rqyovKGhxBM6CudYkZMWFaLSNwNbzdbutlXrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=VKpR58mA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5FA606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC5FA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=VKpR58mA
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c418e215671so123454166b.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793380072; cv=none;
        d=google.com; s=arc-20260327;
        b=cNuuBfscSWSUyHZUDn3F0+tq83AI8teTzfsvjenhHR5SaklIph4VAK7D4nGCewFT+0
         vDKUKukblki/R2D3+9Ny9wMf+PCIYgbIkWqghm7b0KI79nWXQIp7LHu5/ChcWolqMe38
         jmp8idnSU3fAKdj1R7MznsCtLyh8t6FJvrt+/FYjhtQUMGlv0tGbV3LLMWWQ66J0GpAf
         nyjksbKPH38qDmaHjhgeQeef4xvLwG0pi5amYzARw8Pnf7y/eiPMLwSv4V/Q3cDSiW3z
         SD5HYNxlU/0d9CkBbl4MCeeXNh0xTVWyU3nteeUMR5ts75eF1/McYE1sgkVUxrIA/UEt
         fgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qob3acME+/uuwxiwUET/rYXw51dpGRAJwWeO+kYwEXg=;
        fh=ez8Q5KUF4onqwt3B/p7QEnH72PzLS5aFKQvGA2ib3Ck=;
        b=sqcAKt4tcCtG9AoFqgBNg+cUstebNx1NTPsS6kfUV1O9t0eX1a/h6B2j7UzA4qOANr
         qBDrHKmqqXV58HptNFayvsEb6YF53rv0i90s07Oq/xoVzdA6uh4atVQMZM82DZ3PEQTE
         LxO8CnTI/365HekBxmvFti3GIQZfpBMtvHZFJ/L0VGKMxuayMtWHcseA2IIXu9wQT8Oj
         U98ogB9VVzJbw2rvye35BfqPbxXzF3lvbPiaBazZ91s468gBx8q6LWnxMjUwI2YLaf3g
         sa5A+wnC8ihv89UN3XB4DOBCBlm2XdYmWHufMLOOQ8hyfrHrCpJB3jUADRAtkAXr+zOm
         lvBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793380072; x=1793984872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qob3acME+/uuwxiwUET/rYXw51dpGRAJwWeO+kYwEXg=;
        b=VKpR58mApdXvWNJTEvtEi1xVLi2JLTQc671av8hr0+KgnoidMZyEH0u1IUeg+Y3EIU
         4B/DrBBt111eScqZOtuvkmymJtUO/ejeBgMneMFisL4rbPFo/ubFrOZxJOqwQvhqW6Mr
         HIFSP2Dn4MGi2O5/MXNrBb7Zag56z9CBNh62tGocFAN5k3cnNycFXqvCXRDwH5aPGbUx
         zzz6xO9J5S8Wa0rj8FVFzEtfm8YGno5ebQ78UXtwRrhLo4xZ+8SKZfZyYalMtlZaHqST
         Hj1MHF4OP1TqsuyxdbGlj1d87pnme5W+bU3J3M2BMpSkMVMA3u+36pYJQGvApnQ8lk0E
         a5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380072; x=1793984872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qob3acME+/uuwxiwUET/rYXw51dpGRAJwWeO+kYwEXg=;
        b=OSfUXHSbezSWH8TYtizHbvw9axobZeHT+65vPmzRsfJqEYmTVLplx1wQnyGqw26f9N
         6Ht4e8VTRsZIYE0ijISntu/pauITyaZRDPJv5y8WvYcRGCnQQbBpy88pY2+Za32DFUer
         wJ+FCoBxpQpHpH4y3OUteAMiaJqDFc9D6m520Q+RcG9Sc/wEmmU3Olg5DqbXBK6WkPWK
         0CKHqIBf9ZhCd9ljMCfWhshHCK7DgCTcy6JEFVY8etPbUbVtpVxDmQ81NSBRkLLbVfSz
         3Fm70AMjXvMVwu8KuvAuArvVhLIuA/1pjNgdrpGOhDQlL1HGpiHXBUojNBQTG5i+Oy4R
         VWxw==
X-Forwarded-Encrypted: i=1; AKwUvBzp+2pxkPxE7/HIvZU3zJ0tXyU/IznLAXDOux97e1p10nsh5dQQr8eVkBd9+AA/H9IJygWC0o0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQwzCa0iAQsA2ZdunGBuf00TJUV2ekUhauNgqehMjFcogOdF1d
	gf7KGe8VkMUwYSqaLa2voppc8Q/asgMc2Dv+0ADlN8RDYK58ARPV+JTsEWXck2hBq09EH5qxS6s
	eCdyPlVGFt6Rs95VLssXxQLm/bEatj8LTjOrQsbI34kgV8tElyWEGXIJI
X-Gm-Gg: AYBFou1DW4es33TPUyJRvimFVUpfTRh3RkeKm+doDRjaiVYnSfqtGHOnTWT7S7xvqOF
	MNAExuO4fapf7YyUkdl/MpqY+YJwwVsQHSONVd1DW8AgmVlURcrKtvo5PYijEgHJXUJVy6tbAL+
	DvqHPX1/fyVJFVeQVm6GT5gJmWPF7dlSU58zyKq95yKRdTO8NjZdO2NW4T2BuSgkVSjO2oMcN6z
	Q+cTIEFWEnfK2o1EM3k/FDHhvHZGFd3ToSosDLqlJcWzhaNBrmg7cFK/G5E7L2vqjI2xaDYOLNy
	yuwSritS+Le5rLmq5kNKzwTVSnl0Wr01TyhDWu7HjfjlDioVR5PTYUg+Fjz9O9DsVctYaM6P4La
	rFdNmDBHVOhnFRbGaj2HaB2gwTgvgjlcrHomr1ClSYPTgMXnn99ihUQ0lojtIuRzL4uJTZA==
X-Received: by 2002:a17:907:1b1e:b0:c46:9d50:8af0 with SMTP id
 a640c23a62f3a-c4ca7ad10cbmr261267566b.36.1793380071989; Fri, 30 Oct 2026
 10:07:51 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027024635.366900-1-prasad@arista.com> <20261030101535.GN257209@horms.kernel.org>
In-Reply-To: <20261030101535.GN257209@horms.kernel.org>
From: Prasad Koya <prasad@arista.com>
Date: Fri, 30 Oct 2026 10:07:40 -0700
X-Gm-Features: AclHuK-iy31HWG0hImZ2B5mI-iSu54uMUj-w_Tlsie6i_umsKnZ4WLRajsinLec
Message-ID: <CAKh1g57V4xfLiXk68SMGnUGiAbXdnyEpxUz27bONxNyOQtT4OQ@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: fix allmulti reference counting in passthru mode
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Thanks. Please use the following Fixes tag:

  Fixes: bbeb0eadcf9f ("macvlan: Don't propagate IFF_ALLMULTI changes
on down interfaces.")
  Signed-off-by: Prasad Koya <prasad@arista.com>


On Fri, Oct 30, 2026 at 3:15=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Oct 26, 2026 at 07:46:35PM -0700, Prasad Koya wrote:
> > Enabling allmulticast on a down passthru macvlan, bringing it up,
> > then toggling allmulticast off and on can underflow the lower device's
> > allmulti reference count.
> >
> > macvlan_change_rx_flags() only propagates IFF_ALLMULTI changes while
> > the macvlan is up. However, the passthru path in macvlan_open() skips
> > taking an allmulti reference when IFF_ALLMULTI is already set.
> > Clearing allmulticast after opening the device therefore decrements
> > a reference that was never taken. With no other allmulti users, the
> > unsigned counter wraps from zero to UINT_MAX. The next increment
> > fails with -EOVERFLOW and reports "allmulti touches roof".
> >
>
> Hi Prasad,
>
> A Fixes tag should go here.
> (No blank line between it and your Signed-off-by line).
>
> There is no need to repost just to address this.
> Replying with the Fixes tag should be sufficient.
>
> > Signed-off-by: Prasad Koya <prasad@arista.com>
> > ---
> > Reproducer:
> >
> >   #!/bin/bash
> >   set -euo pipefail
> >
> >   ns=3Dallmulti-test
> >   host=3Dam-veth0
> >   peer=3Dam-veth1
> >   mv=3Dam-mv0
> >
> >   cleanup()
> >   {
> >       ip netns del "$ns" 2>/dev/null || true
> >   }
> >   trap cleanup EXIT
> >
> >   ip netns add "$ns"
> >   ip link add "$host" type veth peer name "$peer"
> >   ip link set "$peer" netns "$ns"
> >
> >   ip link set "$host" up
> >   ip -n "$ns" link set lo up
> >   ip -n "$ns" link set "$peer" up
> >
> >   ip -n "$ns" link add link "$peer" name "$mv" type macvlan mode passth=
ru
> >
> >   ip -n "$ns" link set dev "$mv" allmulticast on
> >   ip -n "$ns" link set dev "$mv" up
> >   ip -n "$ns" link set dev "$mv" allmulticast off
> >   ip -n "$ns" link set dev "$mv" allmulticast on
> >
> >  drivers/net/macvlan.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> > index afad90b9222a..e20d587453d1 100644
> > --- a/drivers/net/macvlan.c
> > +++ b/drivers/net/macvlan.c
> > @@ -643,6 +643,14 @@ static int macvlan_open(struct net_device *dev)
> >                       if (err < 0)
> >                               goto out;
> >               }
> > +             if (dev->flags & IFF_ALLMULTI) {
> > +                     err =3D dev_set_allmulti(lowerdev, 1);
> > +                     if (err < 0) {
> > +                             if (!(vlan->flags & MACVLAN_FLAG_NOPROMIS=
C))
> > +                                     dev_set_promiscuity(lowerdev, -1)=
;
> > +                             goto out;
> > +                     }
> > +             }
> >               goto hash_add;
> >       }
> >
> > @@ -713,6 +721,8 @@ static int macvlan_stop(struct net_device *dev)
> >       dev_mc_unsync(lowerdev, dev);
> >
> >       if (macvlan_passthru(vlan->port)) {
> > +             if (dev->flags & IFF_ALLMULTI)
> > +                     dev_set_allmulti(lowerdev, -1);
> >               if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
> >                       dev_set_promiscuity(lowerdev, -1);
> >               goto hash_del;
> >
> > base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
> > --
> > 2.43.0
> >
>
> I'm unsure if it matters, but the order of initialisation of multicast an=
d
> promiscuity differs here from the non-pass-through case.
>
> Overall I think the approach you have taken here is appropriate
> as a minimal fix for net.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
>
> But I do see that there is growing duplication of code in the
> pass-through and non-pass-through paths. And I believe that
> is due to the approach taken by the existing code of using
> goto to control flow (other than for cleanup in error paths).
>
> In the longer term I think it would be nice to address that.
> I took a stab at that. Perhaps I'm overthinking things.
> But, FWIIW, this is what I cam up with (compile tested only).
>
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index a48c9e662fe9..f2a3cf540e4e 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -631,24 +631,31 @@ static const struct header_ops macvlan_hard_header_=
ops =3D {
>         .parse_protocol =3D eth_header_parse_protocol,
>  };
>
> -static int macvlan_open(struct net_device *dev)
> +static int macvlan_should_set_promisc(struct net_device *dev)
>  {
>         struct macvlan_dev *vlan =3D netdev_priv(dev);
> -       struct net_device *lowerdev =3D vlan->lowerdev;
> -       int err;
>
> -       if (macvlan_passthru(vlan->port)) {
> -               if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC)) {
> -                       err =3D dev_set_promiscuity(lowerdev, 1);
> -                       if (err < 0)
> -                               goto out;
> -               }
> -               goto hash_add;
> -       }
> +       if (macvlan_passthru(vlan->port))
> +               return !(vlan->flags & MACVLAN_FLAG_NOPROMISC);
> +
> +       return dev->flags & IFF_PROMISC;
> +}
> +
> +/* Initialise acceleration or add unicast address.
> + * Skipped for pass-through ports.
> + */
> +static int macvlan_init_vlan(struct net_device *dev)
> +{
> +       struct macvlan_dev *vlan =3D netdev_priv(dev);
> +       struct net_device *lowerdev;
> +
> +       if (macvlan_passthru(vlan->port))
> +               return 0;
>
> -       err =3D -EADDRINUSE;
>         if (macvlan_addr_busy(vlan->port, dev->dev_addr))
> -               goto out;
> +               return -EADDRINUSE;
> +
> +       lowerdev =3D vlan->lowerdev;
>
>         /* Attempt to populate accel_priv which is used to offload the L2
>          * forwarding requests for unicast packets.
> @@ -661,40 +668,71 @@ static int macvlan_open(struct net_device *dev)
>          * populated we must add the unicast address to the lower device.
>          */
>         if (IS_ERR_OR_NULL(vlan->accel_priv)) {
> +               int err;
> +
>                 vlan->accel_priv =3D NULL;
>                 err =3D dev_uc_add(lowerdev, dev->dev_addr);
>                 if (err < 0)
> -                       goto out;
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +/* Clean up acceleration or remove unicast address.
> + * Skipped for pass-through ports.
> + */
> +static void macvlan_uninit_vlan(struct net_device *dev)
> +{
> +       struct macvlan_dev *vlan =3D netdev_priv(dev);
> +       struct net_device *lowerdev;
> +
> +       if (macvlan_passthru(vlan->port))
> +               return;
> +
> +       lowerdev =3D vlan->lowerdev;
> +
> +       if (vlan->accel_priv) {
> +               lowerdev->netdev_ops->ndo_dfwd_del_station(lowerdev,
> +                                                          vlan->accel_pr=
iv);
> +               vlan->accel_priv =3D NULL;
> +       } else {
> +               dev_uc_del(lowerdev, dev->dev_addr);
>         }
> +}
> +
> +static int macvlan_open(struct net_device *dev)
> +{
> +       struct macvlan_dev *vlan =3D netdev_priv(dev);
> +       struct net_device *lowerdev;
> +       int err;
> +
> +       err =3D macvlan_init_vlan(dev);
> +       if (err)
> +               return err;
> +
> +       lowerdev =3D vlan->lowerdev;
>
>         if (dev->flags & IFF_ALLMULTI) {
>                 err =3D dev_set_allmulti(lowerdev, 1);
>                 if (err < 0)
> -                       goto del_unicast;
> +                       goto uninit;
>         }
>
> -       if (dev->flags & IFF_PROMISC) {
> +       if (macvlan_should_set_promisc(dev)) {
>                 err =3D dev_set_promiscuity(lowerdev, 1);
>                 if (err < 0)
>                         goto clear_multi;
>         }
>
> -hash_add:
>         macvlan_hash_add(vlan);
>         return 0;
>
>  clear_multi:
>         if (dev->flags & IFF_ALLMULTI)
>                 dev_set_allmulti(lowerdev, -1);
> -del_unicast:
> -       if (vlan->accel_priv) {
> -               lowerdev->netdev_ops->ndo_dfwd_del_station(lowerdev,
> -                                                          vlan->accel_pr=
iv);
> -               vlan->accel_priv =3D NULL;
> -       } else {
> -               dev_uc_del(lowerdev, dev->dev_addr);
> -       }
> -out:
> +uninit:
> +       macvlan_uninit_vlan(dev);
>         return err;
>  }
>
> @@ -712,21 +750,15 @@ static int macvlan_stop(struct net_device *dev)
>         dev_uc_unsync(lowerdev, dev);
>         dev_mc_unsync(lowerdev, dev);
>
> -       if (macvlan_passthru(vlan->port)) {
> -               if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
> -                       dev_set_promiscuity(lowerdev, -1);
> -               goto hash_del;
> -       }
> -
>         if (dev->flags & IFF_ALLMULTI)
>                 dev_set_allmulti(lowerdev, -1);
>
> -       if (dev->flags & IFF_PROMISC)
> +       if (macvlan_should_set_promisc(dev))
>                 dev_set_promiscuity(lowerdev, -1);
>
> -       dev_uc_del(lowerdev, dev->dev_addr);
> +       if (!macvlan_passthru(vlan->port))
> +               dev_uc_del(lowerdev, dev->dev_addr);
>
> -hash_del:
>         macvlan_hash_del(vlan, !dev->dismantle);
>         return 0;
>  }
