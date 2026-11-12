Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794472429;
	b=mIX0sWjDeG6F0WgdAmZqIKAO87794z4N7V773WvR+xSZe66TDt24If39XHKvBKYvdoS0
	 EqLSbSzZ3WahZvumTY65rlXacgzwLdvkXKS5F193yjBHUlOcQUrfcoOVhB82py2X0c5rf
	 RsfTY4SevioGf+Ozv0mfnKqOo8mgKtsvHI9W3fxaY4WLQue81LIGcBSc4Vwt+ENvvZU1u
	 JA/NT20YDE3L3MCECN6njEsisyKriRaochyCxUnxDUuhmfSKuiUHAoEg0pHKG5aXLAgz6
	 1NeYkbrkm3d4dUp+Ec7yIcZXhfZaxa9FHaHiWdoIDII4ASe2af2LNi8rOOh71Jyf6OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
	b=ANFL0YxGF5VkmfdOJtX6aKoG83llAiM2g+2rWNjPv+gbbAqwFjUQo3ia7GIM/AQPWao5
	 u0FQpngitp6s0Gjwr9TuccPrjPPxpzsWppABTtfYHPuPSHcaxLXSTyj4ugRkelJu+uriP
	 WRLBAQdJ27RI8JhFUujxLCHZrIdL3DGbik6sH8MsuosdAM5hLM9LDWifV5nQCyz884+f0
	 rb/Rz2CEhIZVv0RkN6BSN/UX3AhIQUvlOlUehnMA8G0xMRTjgmCB4JU22pr3/F7JdmYA9
	 9XIrbxXSpc6oyEc0FAhldirgIuVqsTu1vzEtXX5rAvgq7aacNSLuBWkQcTRoh0FU3fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi8b8PLn;
	arc=fail smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5060734AC
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE5060734AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi8b8PLn
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-702dedeb70dso2209131eaf.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:33:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794472428; cv=none;
        d=google.com; s=arc-20260327;
        b=PJas8AULBLnTve7SRHUACas2sZNoI7gzouMkgtBE4PjwEt+RfrgSsMcjIsDLkCqSj5
         GvCIpt6JK01McqEU5SgAzlWTByzWNqsetwpu3ySrg1H6nAVabO9Ij5dABWLtPPmGmNXL
         cn+knLRxQbsION8KwTf1vR8JTkzXveMV1sT9JxNXL0s98nyIHWR90KCJLnL6Mb62wAED
         46UD4SyDo+l+3VmvUGWMFkFlXODfKA3pQCXWvyDxphyU3PiF67HI4LVsavBnqLO3UhkR
         7saNjauUWRF6Tkj8T9IOOgEC4AChdRDxgzWbVLg833BQHFh6e03g9SA2/tqo/vMA6vUI
         bFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
        fh=5q5+b32ss8ueoFUiHqklT4NqsAOrDABRgBSEam6lEvU=;
        b=BlVb3D6sss8DOC045kM2agpiwsJVJqjy/YY7MYUVK7ZYAtjWOSVtEV9MhOARmrKvaZ
         oznPgJuJ6c6Ux/+cBuAQchYOyLtvozi9F+ib5IaA9Zmd5rxofG+R9QElhICidqmGQGIl
         s+VRcReiBJisl7fs+CkIH3RoH7p28gtW+6ORqS4kx3Lfb5Z8kKj7AELXPD2LhdVjqFdR
         wdJvkj7b6aSVesV8yUMyXz5Z+BikETcmvFuUzScmOZZueCjAPX3z+zCm6f10zInysNEW
         foKgYkIRffz+bxyDkk9FsO1aLJGvpwOaXu1nmfNofvGiIGdW5piuN2fQvDymXnhGij/P
         iSUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472428; x=1795077228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
        b=Oi8b8PLnrmaQ64bFFPurb/0NRJSzOTgERT3w52aHLchDiGE24NvNc053MGzsM+qWdL
         ab6xBre0Y27SWz0NmrywKH21t/466fyW7knd2Doyzxy9qhiNmu8hkmno4/lsE2WZxlzH
         22p9C4gSoYQpEuV2L4h42JiLHb7tpw27dm67IQiaIuePmeBEJg6W/XbL5OHHBuPAlJCI
         tu8qeYoLlHJf4HiWDS3uu5OIG+pmyFXb+l1gKtpZgQdPdyaeJLe6UZf8HBUW6dA3vAfS
         gdzKhEwM4a7ocp3W88w62eMBgYlyvTCne/5bB0mwVJwyZ0Rx5kM1dCLfo8OxSdQh7aZp
         ba2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472428; x=1795077228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
        b=Fo8z3FhRxjll8lUS6Nf7WuCon8ht8UoE+nVFYrI9QgghqjPfKAwFjfeh6hoApgL0t2
         jZl4GSJa7BoZSj33Ot8kQGKO5bBBGlDJysNXsR1SeSbo1bhCxDYsfPgy/4MF4ISO/4xy
         80u1iv88GPtCGtDg65tIMQzoI31mgaCk+YL4pSd8cXkfnMaI+YmGmQcpZxetzlJy8291
         SV86ev63t7WM5rm1CnMxPJk4L3HoVMLwp9OZunjFAjSyiZnUA4bmeqFm+NUb4fxfRGUV
         N3S1IhxHgI2fssI/Y1oithLqByHwwkqTrN30FLSkhwPLjxtgLbWluqpfuQ0DHOhclIiv
         8v5g==
X-Forwarded-Encrypted: i=1; AL+hErHGDr+i/ummBdFvtxUbKypIbhQSVjbJmLqAuAXdCz8jFFqqsemgOq9uqPI6gQbm4vvUrJuOpLQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/B6MMNTRR+MrmnBi4fYaxAt2lVG/6p41h9zWkLcwWnb9uGNjqW
	VXq8DykRcqyWX6E2AoHnTG3F+j7aSqkh+xJy9qMuem82cVLOlxKfFB+dJWY6sKVDURe9AUHNsnr
	fxdOkhfkIPKbc26FknvG3L4CRE6z7M9k=
X-Gm-Gg: AYBFou3gCgeUcnVM7JA9GioL8aLeGW8pAXNVOlyYnT0CWBPazWEhA/NvjEbe316m9Mh
	bB94ZsN7b/1geRR/K+fjTDB4Nqw2L/1zBOFOPBwCkENC2A1E5DGQk6LQa3tNO6batRD4sSAGe5S
	urzEm52tsPdk0IUjLLKqZeNHeNw1jk/apFZxL0JgKn0ieqof6hMC78m6wQrCT27UKSDxJSetQSX
	m7S4C9L6OiHH+LB2CNnFmKnb3BmaDMWCsy9S5RygYW/j5iFfhdsP7fsQADF6KamCqaQJcqfE7w6
	e1M6f4DL0/FMgWsIuGeXkqxfPb9qSEEn62pt+AEi5ww9AbzG3M4f1ZLbjFmpv5qW9c1g3qqC9t2
	3oiAzrIaQKV9Lgct3HHaPc1wPqBjxUKfMsz6w6fDxg/9oMU/DiEp+QLdyFYsY4wTaASAb2bQmey
	00w5vfbrbbLH120A==
X-Received: by 2002:a05:6820:8912:b0:70e:78ba:1193 with SMTP id
 006d021491bc7-71917852a66mr2642193eaf.27.1794472428165; Thu, 12 Nov 2026
 00:33:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109100437.331423-1-amaan.cheval@gmail.com>
 <20261109100437.331423-2-amaan.cheval@gmail.com> <CALuQH+Uee+=2NyhCXVmmESwXxSqDYKY3Foj70KM2qY6g5UsOXw@mail.gmail.com>
In-Reply-To: <CALuQH+Uee+=2NyhCXVmmESwXxSqDYKY3Foj70KM2qY6g5UsOXw@mail.gmail.com>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Thu, 12 Nov 2026 14:03:36 +0530
X-Gm-Features: AclHuK8jw0nrbYX6MTsSZqQlwj6_5UHh4mClUVm7LQtL7_VDZNXktjTz3rcpg6s
Message-ID: <CAG+wEg1fWbnaWmEBeCA0RcwYvMDrAcacX4qCO++bsNK98FS=Vw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	maciej.fijalkowski@intel.com, pkaligineedi@google.com, maolson@google.com, 
	csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:16=E2=80=AFAM Joshua Washington <joshwash@google.=
com> wrote:
>
> On Mon, Nov 9, 2026 at 2:05=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.c=
om> wrote:
> >
> > Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> > RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> > verify_xdp_configuration(), which until then refused every format but
> > GQI-QPL. Nothing replaced it: gve_set_netdev_xdp_features() advertises
> > no XDP features for DQO-QPL and gve_xdp_xmit() rejects it, but the core
> > only checks that ndo_bpf exists, so a native XDP program, and an AF_XDP
> > socket on top of it, can still be attached on a queue format the driver
> > does not support.
> >
> > The DQO-QPL RX path was never written for that. Its page accounting
> > assumes the driver keeps a reference of its own across every handoff:
> > gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> > recycles it with gve_reuse_buffer(), so a redirect target that releases
> > the buffer synchronously, such as an AF_XDP socket in copy mode, can
> > drop the page's last reference when pagecnt_bias runs out. The page is
> > then freed while it is still DMA-mapped and registered in the QPL, and
> > the driver posts it back to the device.
> >
> > Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
> > advertises no XDP features for the current queue format, which today
> > means DQO-QPL. A zero-copy XSK pool bind is already refused by the core
> > for the same reason, and a copy-mode bind never reaches the driver and
> > is harmless without a program.
> >
> > Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ R=
DA")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>

Thank you for the review and guidance!


>
> > ---
> > v5:
> >  - Check dev->xdp_features instead of queue_format, and reword the
> >    subject and message around that (Joshua).
> > v4: https://lore.kernel.org/netdev/20261106114551.212675-2-amaan.cheval=
@gmail.com/
> >
> >  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2437cd8ba633..fe560f5c5408 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct n=
et_device *dev,
> >         struct gve_priv *priv =3D netdev_priv(dev);
> >         u16 max_xdp_mtu;
> >
> > +       if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
> > +               NL_SET_ERR_MSG_MOD(extack,
> > +                                  "XDP is not supported on this queue =
format.");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> >         if (dev->features & NETIF_F_GRO_HW) {
> >                 NL_SET_ERR_MSG_MOD(extack,
> >                                    "XDP is not supported when HW-GRO is=
 on.");
> > --
> > 2.47.3
> >
>
> Thanks!
