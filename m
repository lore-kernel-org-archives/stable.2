Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793783690;
	b=tS+7DLo5fpn557jzk8biI+ZC6ZqXkhCkmPP6oN3yFdHgWon3Q05aM2FoV2jvUPsdWxHJ
	 +aI7S5s/3rDNIyTUql8NEfG+WBDpMcGhNYSd4tlwfxEqGNyLCl5733EIFObNLyldKozRZ
	 Jzs30UbPiRv+6np5mhdC/KB86TGgUjMoMMj0/KanxQZigwRdFq75MNE29v7wqTM9XHxy4
	 TlT+h2U3CQ5V6mz62bTOtzRHYimMa8Ysviq9SmTcVpbAU3aV8e+9Mt77IW7OyTtA+Jx+5
	 sARVkEYrjk1x9smFlXCcJrXf8iYH6hSjNv6/4HIhC4+WMTNhpHEJ7K8eelq6LP5En6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=czUbxv5EfuLpmjrkgw21CAlQ/JdV9gdYAJCXYckMMh4=;
	b=5PXdrFXrHlVyMTTRcSle6Mi4m+NcwrQ0pjZj1k/xiCdS80ukfOuhIBe07K4KGOHKyPSy
	 S1v6rY6XUEfX1FWAaaEDeaGYOEJ0gZUvNeD4glW4trCO/yhjMexqACalIDo5QI8pnm0zt
	 5whXs/yXF3ZjB29H1c8rtx6aRNSRd81gsYotIhH/MyyC3AMgVDGfA0LnZbwshWBbSTcA5
	 b+uj2uOMkWNUy7cgZLBOv7ZlCExlFTVgZLdx0FpyFtz5Eht/KqnMYnfgoqgPKiTjvpVm2
	 DuOa5R7OE76BvfUzvIecWJlBIxl1tZMrOobrXlpUTEhAS5mUIZEz5XWCyQok2lbTGQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AQqHQRIl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39777606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 09:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39777606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AQqHQRIl
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89f85edd210so244951b3a.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 01:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793783689; cv=none;
        d=google.com; s=arc-20260327;
        b=HacTQTmAxAc7Y56dCx62nSQoq2WdH3CUzc4doMZ7mWb+z7NREASJG3t1K89ZD0lSyN
         QR4zLZzaUcnvgxkNPPiVL8/53Me5lYlsLZCeQFo4YLvtEReadvJpNCYI6AsEFeXszRGm
         vrM1ECtJCS7gCB8D+HppkYkNhwq88NqmfYqc3hQBbV4dvhggmSER9Qknchi4QsDCicsh
         FXATOGFZX6/rSXiHnoy1hUEOz3E0y2f7R/lqdAvkmLzKUQacNhRAy5jt+i4X9vQeTRYW
         Fu9Z9ja7994dFGDtLuA4NV5xDCDzGfoQdxllGSP2Dwlg+I3dhgmVjqE7qSIvPh0NnUVo
         P3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=czUbxv5EfuLpmjrkgw21CAlQ/JdV9gdYAJCXYckMMh4=;
        fh=y7mmrwKXyHhBR2YEZ9nCzDwuVJSWEGIN5Q6z8kFSWPs=;
        b=i3Qzd1jAwwp+0yGqGAOv6yxQJ+pBvpe3JNllSPb8kxIAFDx/dKBx+AJwrpa6xnpvAw
         /Qr/2/37+cQEqDWJ5+0zxHNODQjUYS3ulOKrfSImsCBqDvhraoqtIzOFDyCl/rN3jteA
         s3AEd7ESyk7UC0wUJpmT/C2tFWJqnwxaa0g78QgOubhR/v4YpanAmfXfMhA4nbLWB4xw
         sWMaSc8YhMq87kslRsVigggHdTo1jY88apxrHhSFq+ygnZAkobSZCWFGbaV0M0e0Cb9n
         OrFm9JXVXhkYfXyDwXrolj/nRyGmnEYh2nuqCbMjecL2tHi/HdCBSad0BbnHcfJe2Lhp
         OzBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793783689; x=1794388489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=czUbxv5EfuLpmjrkgw21CAlQ/JdV9gdYAJCXYckMMh4=;
        b=AQqHQRIlgEz6uzCGkg04TmOJsYG2eT4MvgX8UrzjPyNzZbEQwCB9itFh1O+e74qSrk
         +0mlDibQIRXNWIfyTomgiRrLRHHZOhnGIOrNSSSnZG4tCrSYL9c2r4MFvmFhmfNGTbVg
         UvVj59+PYDAcmXXiru/Roz+PEE2YVAl8Mj9Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783689; x=1794388489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czUbxv5EfuLpmjrkgw21CAlQ/JdV9gdYAJCXYckMMh4=;
        b=RW+NL10kI2jB074jVlztFe7kxCi2RMner590ut+gxuqSjurXK8CUa3TulYjyryceGQ
         Wd4tWcMVRqv0QT+cyC6IhUCIcpqolWf4yUY4AzSSv3FuM17podB+sP9VLecIR95hFg1j
         VdXEk4m8EGb19NdXAJN0JxAExXzaTIJ6Qv/UKqo444dLHJc8QbO5Tc6r4yXN5s4IBe1+
         e1dj7O7q2UgX5qbc3Trr5dLBokXhYaM2EnMfEW5TDTiz9y8ZkCN3mHJQ8N689KuN2WFr
         zOhfG8mZvUjsYMkH95AiTt7rKhQGIBc5JK3C/CiFljtqQ5YBB1p1qdP1qODc67mA94NA
         rVRg==
X-Forwarded-Encrypted: i=1; AKwUvBy4c/oa6H2s1smAoZnMuPjstWkRsS+0DNtBHfAJxN3Q5OVVzCOLTCRUw2HAwmbRsRCCNTTElcc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2OOcM7+ppGt7AiJtp/oOjDv2Mqo/h8yBRAOZ92WEwbiVhTIDF
	nZDscrLPRbDTwvsfSmkQzERKEWrHcVlAW3Q1PLXJnZiUDTwQcIIuNrf5yZaYIPXf/bIks4sK16s
	ZFg1Bgmqv2di6Bl1O7ak2wgH24LFWpR7asoi7k12J
X-Gm-Gg: AYBFou0mbJtq39wic7g9MTiguO1lE2b2AVaioaMBR89oabihMUcHJy/hXBoFB6a+nE/
	erY8KQ16Se1agr5h7A9osUo2xD65whiUgFGfFGR0kc89mK8gSYLuerbMCfWDS1TDclfU5tuI0YD
	zoWXCzd65/txKFREFHwUh+4j92KD4hpStSRnHasPuqE/KdrUGSjUhZgpcCb8pFWcfmAizuQgQM/
	/w4wj3qbBIogs9tGcrA6ANOzepXvPznhMvWC1gQ/CxLPL1XuXqJpUX2GwzOdNFPIgCY/lO6VTru
	J+n3dFb0n4sg9NSw6mN+B9XIJjsgkNa/7Qcwac1+2mWrJXbFGjaQfTQwZuXm+Htqv37kHFWf/lx
	Z0a8wwCIM+k9FjUQk6A8IbbhKG+fDOJaUEMwSbIsIx4e7zWuP95rN48smZ165YkfjuhK/t6OU93
	Uwciovgh0dxlSa+lM=
X-Received: by 2002:a05:6a00:a90:b0:89f:521:8089 with SMTP id
 d2e1a72fcca58-8a9bcff6a9dmr11969821b3a.19.1793783689421; Wed, 04 Nov 2026
 01:14:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030030453.31928-1-cenzhang@linux.microsoft.com> <1e517947-48cb-4733-9e51-8a165d3ba534@redhat.com>
In-Reply-To: <1e517947-48cb-4733-9e51-8a165d3ba534@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 4 Nov 2026 04:14:38 -0500
X-Gm-Features: AclHuK8QWfUruPb5mmDSb_oYTX82loMdqpI8kSB4xjZlQlMEjnsaHJgwVrRB1uY
Message-ID: <CAM0EoMn5ODpLK=OhPTy=0Zq1rgT7Gm6JGKnRs=Q=mzp_6x+JDw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix rate estimator use-after-free when
 clearing NOLOCK
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:10=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/30/26 04:04, Cen Zhang (Microsoft) wrote:
> > qdisc_create() creates the rate estimator requested by TCA_RATE before
> > qdisc_graft() converts a lockless child of a locking parent. The
> > conversion in qdisc_clear_nolock() frees the per-CPU statistics, but
> > the estimator keeps its own copy of the cpu_bstats pointer and its
> > timer keeps reading the freed per-CPU memory on every estimator tick.
> >
> > An unprivileged local user can trigger this.

This is a bit of an overstatement (Sashiko is infecting me with its
pedancity); you should qualify it with "needs CAP_NET_ADMIN in a
userns" or something like that. In general you should provide for
conditions on how to reproduce this in the commit (looks like straight
tc commands).

>> The estimator timer can
> > access freed per-CPU statistics in softirq context and panic the kernel=
:
> >
> >    BUG: unable to handle page fault for address: ff9d8b20ffa47920
> >    RIP: 0010:gnet_stats_add_basic+0x77/0xc0
> >    Call Trace:
> >     <IRQ>
> >     est_fetch_counters+0x31/0x50
> >     est_timer+0x52/0x170
> >     call_timer_fn+0x9f/0x210
> >     run_timer_softirq+0x6e/0xb0
> >     </IRQ>
> >    Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fix by doing the NOLOCK conversion in qdisc_create(), right before
> > the estimator is created, instead of in qdisc_graft(), so that the
> > estimator captures the final statistics pointer. Removing the
> > conversion from qdisc_graft() is safe: a new qdisc is created by
> > qdisc_create() with the parent it is grafted under, and since
> > commit bc50835e83f6 ("net: sched: Disallow replacing of child qdisc
> > from one parent to another") an existing qdisc can only be grafted
> > again under its original parent. Either way the qdisc was already
> > converted for that parent at creation.
> >
> > Fixes: 8a53e616de29 ("net: sched: when clearing NOLOCK, clear TCQ_F_CPU=
STATS, too")
> > Cc: stable@vger.kernel.org
> > Cc: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
> > ---
> >
> > The bug was found and this fix was developed with the assistance of an
> > LLM-based code analysis tool.
> >
> > Backport note: trees without commit bc50835e83f6 (v6.14) still allow
> > regrafting an existing child qdisc under a different parent and need
> > an additional fix for that path, for example cherry-picking that
> > commit as well.
> >

Good note - this fix is not safe in older kernels before bc50835e83f6.
Is this the protocol to signal backporters? My gut feel is they use
automated tools and would not be reading commit logs to backport?

> >   net/sched/sch_api.c | 14 ++++++++------
> >   1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index f36c41224bcc..d89f3f0a3c5f 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1247,10 +1247,6 @@ static int qdisc_graft(struct net_device *dev, s=
truct Qdisc *parent,
> >               unsigned long cl;
> >               int err;
> >
> > -             /* Only support running class lockless if parent is lockl=
ess */
> > -             if (new && (new->flags & TCQ_F_NOLOCK) && !(parent->flags=
 & TCQ_F_NOLOCK))
> > -                     qdisc_clear_nolock(new);
> > -

Please leave the above lines alone; they seem like a separate
unnecessary "fix." Follow up with net-next to remove this hunk.
On current main it is dead code, so it does not help you fix this
graft issue and for older kernels the backporters wouldnt have to
worry about the dependency on bc50835e83f6

The rest looks reasonable.

cheers,
jamal

> >               if (!cops || !cops->graft)
> >                       return -EOPNOTSUPP;
> >
> > @@ -1327,6 +1323,7 @@ static int qdisc_block_indexes_set(struct Qdisc *=
sch, struct nlattr **tca,
> >
> >   static struct Qdisc *qdisc_create(struct net_device *dev,
> >                                 struct netdev_queue *dev_queue,
> > +                               struct Qdisc *parent_qdisc,
> >                                 u32 parent, u32 handle,
> >                                 struct nlattr **tca, int *errp,
> >                                 struct netlink_ext_ack *extack)
> > @@ -1405,6 +1402,11 @@ static struct Qdisc *qdisc_create(struct net_dev=
ice *dev,
> >                       goto err_out4;
> >       }
> >
> > +     /* Only support running class lockless if parent is lockless */
> > +     if ((sch->flags & TCQ_F_NOLOCK) && parent_qdisc &&
> > +         !(parent_qdisc->flags & TCQ_F_NOLOCK))
> > +             qdisc_clear_nolock(sch);
> > +
> >       if (tca[TCA_RATE]) {
> >               err =3D -EOPNOTSUPP;
> >               if (sch->flags & TCQ_F_MQROOT) {
> > @@ -1817,7 +1819,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb,=
 struct nlmsghdr *n,
> >   create_n_graft2:
> >       if (clid =3D=3D TC_H_INGRESS) {
> >               if (dev_ingress_queue(dev)) {
> > -                     q =3D qdisc_create(dev, dev_ingress_queue(dev),
> > +                     q =3D qdisc_create(dev, dev_ingress_queue(dev), N=
ULL,
> >                                        tcm->tcm_parent, tcm->tcm_parent=
,
> >                                        tca, &err, extack);
> >               } else {
> > @@ -1834,7 +1836,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb,=
 struct nlmsghdr *n,
> >               else
> >                       dev_queue =3D netdev_get_tx_queue(dev, 0);
> >
> > -             q =3D qdisc_create(dev, dev_queue,
> > +             q =3D qdisc_create(dev, dev_queue, p,
> >                                tcm->tcm_parent, tcm->tcm_handle,
> >                                tca, &err, extack);
> >       }
>
> Jamal: could you please have a look?
>
> Side note: I'm not sure if you are aware but we process the pending patch=
es
> in this order:
>
> https://netdev.bots.linux.dev/suie.html?delegate=3Dnetdev
>
> And you can restrict the list to the tc subsystem selecting the appropria=
te
> filter with the funnel icon in the top right.
>
> /P
>
