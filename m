Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089603;
	b=h1EUxMf9bKYSoat7LdNmKDM8pwic/VQkv9aAedCghtBtOyJLz1LBcFJftsixgg6vLAXc
	 BSPPzihAQ69bZysi3/Ni1AyOpC7qDk+8VGtXdv16cJxwVakLEIKU844pUjalzh89tuvmC
	 pn9VeETAGqcsEGbGgIre6yOP4UkahpXRQMlxNigerFSQaVtF2cRG27DdGe6FLU3uuTUVt
	 Mi6IzCxoEKdc4iHnz8MZ6hBS+nR+0HCKRaq0wXVP2gStwOOAngtyuTQgzNYVuq4M/NfWR
	 nADR4NBIXRwS3b210wPVbcFMtmt8KrRnf7KHeFwDO8xCe3rHiZuT+D/fnHOZqi8A1Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ri5ORY3eJx7Dxs5dHTw0DMoceR4v2VXZ5izkz0UQP3A=;
	b=aKGeS/7RQ7oW+OwbtCGd5MSeNXPS4i7gdlofrOrKQxRO+nBviczVred/508ZeXL5bAwX
	 VvFN14Y6FYOqHAFoRHRgeKfFcCIB/zITBZIU4PDyyLjPZnXleZ31HwjYxb54DOBzPWNAY
	 e1i+cCygfkuqsrtC45Sb3Fn7ymbVmI1KJupGXjdcooBdQKdi1vwTlPXldUIV//acMtKF8
	 qJ4fMbF6duJ5SRkRjUv+Ap5sgjgBHYQacRQqVlva++72NgqeEVXaBJfeqEIG6Q84TK+R+
	 9eglFev7WN4gBcdbdSFYDz4fW8xU3nt5tV8vOj+4PE45MxjpI7oFv/AVlmVRNLvE66A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XJmhDb1+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE10606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 22:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BE10606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XJmhDb1+
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so19894b3a.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 14:13:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794089602; cv=none;
        d=google.com; s=arc-20260327;
        b=BOUdixkV7R3rLP40+RMt+fNVwI2A8vS6h6VzgdxBDY99OQohLltvguIW7ZBJXyeV9o
         j3PCZPnV8fQCDi9dCnjUmIOS2VVZeZgFIdKtyfCY0CuJtTBK4MJexPRCOy/PKhpKXF2Q
         a0T270vxMFAqBDc8RMUMRPqm6ZOAZ6qP57mYVSEenTOLZqxsyxLbg1oDBABfQ0JKVSTw
         0vkr2nv55RtVnPWQCjHK2E7OQ29eZbv36UZvq8z2KEORCMtRpXoVN8G7u4fPtSpjr20l
         bAPYWKLgbwYpxm26Ene+BWINB10WSIFYXdgrst8zM6etlkNMHbZSme+f1terdlo6Sc25
         shGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ri5ORY3eJx7Dxs5dHTw0DMoceR4v2VXZ5izkz0UQP3A=;
        fh=Z2BHYi5cjKfJfvcgvKEMCGRLAL3lhkLl51IHjTh5YAg=;
        b=N8lctst+G+tiE4Jvsi7YTvuvAL1oVESb3Ou8u1zCiJKVmooGT19RfPRx9TBWsgSq9f
         l3ALIdva/v//fSLGp5WQDfBO2kDxD4JIhdJADu+XRViue2V3BKG8AwlQPyRBgp5aW96B
         kEsBtaxlyns9pB68Go6LdmixfjnA7sQgoAcq3YvVkxeElBacGU+uC/Qm+IZcwoIotONG
         4ENVl8dDkFU8fMYJZ+hMHLO+PuSZy9RzBm0xRhcmsIpL6CnMwP0itDTDrumeci6kUUWx
         2uCPgpzqYpwZFNOmAG3YENkso2sd5s1pX3CE5mRnhOJyz+vgH3xadhYufJDlMYCoJ82k
         FRdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794089602; x=1794694402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ri5ORY3eJx7Dxs5dHTw0DMoceR4v2VXZ5izkz0UQP3A=;
        b=XJmhDb1+YdoXCsxpJ/S44gGck8KS5crPC19DOevfgL7KXi4xY5ul/Qw9sV0uPvEazc
         BaYVdahO8EZhvdGdmVHatq+IvfjpGEjU9A+jia196v+3ocfrBu3FKnmmbzoe70eCVErZ
         HkmrKcspsgDf+Das7hUVwqdfpl64ooRseyl+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794089602; x=1794694402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ri5ORY3eJx7Dxs5dHTw0DMoceR4v2VXZ5izkz0UQP3A=;
        b=0MiBFRE+RaYGyMddD+OfOKhIYm34QdHRjHq3YRWu1LIVm+V2cO22GX/Ah3rPgONfOy
         AR+/Oj/Qob5wzS2ICXnclqexp6Mn3ZD3wb/NOFCUscrTwTTs8aHncpYzOAPLmmRax1lq
         +GsIcq5HmFGV+8G4JWKbl17dAe/InswFRO6c98LHCsN7ogx+KEIX0JepWV5l0D2TXwgE
         xK2Fj+Y/alwpi3q97H7cnjr1z+f5IlcJIppbYNgTrzOyc3MX+/Gnn5MfNSkKnzbUUGgY
         fvmJ4zrkxFp178EG2Zn3KZiZVgRtLiJD5XwHL3VpWm8MF/WwSZAWliOLPLCpxQby0xwo
         FYcA==
X-Forwarded-Encrypted: i=1; AL+hErFXyROQyRL5i27GRjWqs3gYsdcyJ54LeghRAZvWnqsxiTPoY37vWU2MHLuOBuBB31Q7DJY36DI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8L67VEdIEuJJxkIGbQzEH5Ww9ASv1/yUqi/p0w/B6/YUheoVdL
	G69M4BU+9/CavbCTgYgF8zJqXDeHAXWhsIsSNXoF9NIaUkN8tMBmzNIPtSEB6uZYJUJ8atnCDW4
	Imhm0fhc5CcscHcW9YWlUXM8JJ5k9POsW0/MXuyN2
X-Gm-Gg: AYBFou0YMluW/jccZB4fQKEiSQN7ct1s3U3tmK6sjeaP6H7UFx7qEGBSo/FzRrVW7Su
	j9SIN4QvgbUbDV7wJrcoBpBCi3SK1byeqiM83jZXHh+jaw/OBPKN7N0l+pVFt8rPenS7rKcL2PX
	qVCjcBkODlU3kTuW4avUkTUkyTEXcmSAT2RAv4TU2D4LzP7nng4Jf16QGqTV5bFa/19VhFkVPqy
	10SO9BXVui00U8ZUxMoHjlXWJ562LANBom2KpL9/lyjBNMn9HPjqtbutIvR8ISlJT9VOoqYNbzz
	lb3g152/hSuSwMsbKy8/EULAlz1BjPZd/008fgkrz2quD3x1RnfrCXekQpGhLTlhe+sw18vRsef
	TM9TfR7a/KLV/H5N+FcfxXxnshFha526wefhyyscZ/vrky3pUzC3Yt52a4lGPpJSS6CX8jl1pzQ
	Zywap2KUunkF2OFnY=
X-Received: by 2002:a05:6a00:430c:b0:88d:20ff:15c9 with SMTP id
 d2e1a72fcca58-8b66c3ee757mr60184b3a.17.1794089601977; Sat, 07 Nov 2026
 14:13:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v3.r0.20261103064310-3@mojatatu.com> <179406301946.994134.7212801896124135602@kernel.org>
In-Reply-To: <179406301946.994134.7212801896124135602@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Nov 2026 17:13:10 -0500
X-Gm-Features: AclHuK-DdyhjEwGSmkn65EuH-Exx6Vi4NCxhfLsT3bmzjz441IxX6sjyxKbhEI0
Message-ID: <CAM0EoMmZ6msUa_HDx5511GYPpKiaWFw+G9OAJFB61hGvVm1D3A@mail.gmail.com>
Subject: Re: [PATCH net v3 3/4] net/sched: sch_teql: reject qdiscs from
 another network namespace
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 9:50=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The fix checks that the slave device and the master are in the
>   same network namespace only once, in teql_qdisc_init()=E2=80=A6
> - [Low] The commit message says only that a qdisc from another netns
>   could attach to the init-net master "and change its MTU and flags".
> - [Low] Moving skb_queue_head_init(&q->q) to the top of teql_qdisc_init()
>   (sch_teql.c:203) is presented as groundwork for the new netns failure=
=E2=80=A6
>

Again, cosmetics i will fix if i have to resend.
The netns_immutable gap is pre-existing and needs CAP_NET_ADMIN in
init_net, so it stays the net-next follow-up.
The reorder keeps this patch's Fixes: because the namespace refusal is
itself reachable through qdisc_create_dflt() -> qdisc_reset() ->
teql_reset(), and if i have to resend then I will state the
interception impact in the body...


cheers,
jamal
> --
>
> net/sched: sch_teql: reject qdiscs from another network namespace
>
> This patch makes teql_qdisc_init() reject a teql qdisc whose device is
> in a different network namespace than the teql master. It returns
> -EOPNOTSUPP with an extack message. It also moves skb_queue_head_init()
> of the private queue to the top of teql_qdisc_init(), so every
> constructor failure path sees an initialized queue.
>
> Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.c=
om/
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.=
20261031160050-3%40mojatatu.com
> Link: https://lore.kernel.org/netdev/179366641863.488856.1736857159146600=
0274@kernel.org/
>
> > The issue:
> > The teql master devices are created once in the initial network
> > namespace and their Qdisc_ops are global. teql_qdisc_init() takes the
> > teql_master embedded in the registered sch->ops and uses it without
> > checking whether the new qdisc's device lives in the same network
> > namespace as the master. A qdisc created in another netns can therefore
> > attach to the init-net master and change its MTU and flags.
>
> [Severity: Low]
> Does this description understate the impact of the bug?
>
> Besides changing the MTU and flags, teql_qdisc_init() links the foreign
> qdisc into the master's slave ring, or makes it the first slave:
>
>     rcu_assign_pointer(NEXT_SLAVE(first), sch);
>
> >From then on, teql_master_xmit() round-robins init_net traffic sent
> through teqlN onto the device from the other netns. There is no netns
> check and no skb scrubbing:
>
>     skb->dev =3D slave;
>     if (!netif_xmit_frozen_or_stopped(slave_txq))
>         rc =3D netdev_start_xmit(skb, slave, slave_txq, false);
>
> If teql0 is already up with slaves, the attach still succeeds as long as
> the foreign device has compatible flags and an MTU at least as large as
> the master's. A CAP_NET_ADMIN holder in a user namespace can set both.
>
> With a veth slave, the netns owner could capture or drop part of the
> host's teql traffic. It could also answer ARP that __teql_resolve()
> sends on that device.
>
> The code change closes this path as well. Since stable and CVE triage
> depend on the stated impact, could the commit message describe the
> cross-netns traffic interception?
>
> > Initialize the private skb queue before any validation so every
> > constructor failure path, including qdisc_create_dflt(), which resets t=
he
> > qdisc before destroying it, sees an initialized empty queue.
>
> [Severity: Low]
> This isn't a bug, but should the commit message say that this reorder
> also fixes an existing NULL pointer dereference?
>
> Before this patch, three returns happened before skb_queue_head_init():
> -EINVAL (hard_header_len), -ELOOP (m->dev =3D=3D dev) and -EOPNOTSUPP
> (non-root parent). On those paths q->q was still zeroed. When init
> fails, qdisc_create_dflt() calls qdisc_put(), which leads to:
>
>     qdisc_put()
>       __qdisc_destroy()
>         qdisc_reset()
>           teql_reset()
>             skb_queue_purge(&dat->q)
>
> skb_queue_purge_reason() sees list->next =3D=3D NULL. That is not equal t=
o
> list, so it treats the queue as non-empty, and skb_queue_splice_init()
> dereferences a NULL first pointer.
>
> This looks reachable with net.core.default_qdisc=3Dteql0. mq, mqprio and
> taprio create children with a non-root parent, and
> attach_one_default_qdisc() on teql0 itself returns -ELOOP. Setting
> default_qdisc needs CAP_NET_ADMIN in init_net.
>
> Would it be worth calling out the crash fix explicitly, for backports
> and Fixes: attribution?
>
> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index 70c948a26f809..dc21cd9704a25 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
>
> [ ... ]
>
> > @@ -211,9 +213,12 @@ static int teql_qdisc_init(struct Qdisc *sch, stru=
ct nlattr *opt,
> >               return -EOPNOTSUPP;
> >       }
> >
> > -     q->m =3D m;
> > +     if (dev_net(dev) !=3D dev_net(m->dev)) {
> > +             NL_SET_ERR_MSG_MOD(extack, "teql master is in a different=
 network namespace");
> > +             return -EOPNOTSUPP;
> > +     }
>
> [Severity: Medium]
> Is a netns check at attach time enough to keep the master and its
> slaves in the same namespace?
>
> teql_master_setup() never sets dev->netns_immutable. That means
> __dev_change_net_namespace() lets teqlN move to another netns while
> slaves are attached, because this is the only guard:
>
>     if (dev->netns_immutable) {
>         NL_SET_ERR_MSG(extack, "The interface netns is immutable");
>         goto out;
>     }
>
> The move runs dev_shutdown() only on teqlN's own qdisc. The teql slave
> qdiscs on the init-net devices stay linked in m->slaves:
> teql_master_close() only stops the queue, and teql registers no netdev
> notifier.
>
> Once the master is in netns B, three things can happen:
>
> The owner of B, who may be root in an unprivileged user namespace,
> passes the new dev_net(dev) =3D=3D dev_net(m->dev) check. It can then add
> its own devices to a ring that still holds init-net slaves.
>
> teql_master_open() takes the MTU and flags from the init-net slaves.
>
> Traffic sent through teqlN in B reaches teql_master_xmit(), which sets
> skb->dev =3D slave and calls netdev_start_xmit() on the init-net slave.
> Through __teql_resolve(), it also calls ipv4_neigh_create() on the
> init-net slave.
>
> Moving teqlN out of init_net needs CAP_NET_ADMIN in init_net, so the
> unprivileged user cannot do this alone. After this patch, though,
> moving the master seems to be the only way a container can use teql.
>
> Should the master be marked netns_immutable? Alternatively, should a
> netns change of the master be refused, or detach the existing slaves?
>
> > -     skb_queue_head_init(&q->q);
> > +     q->m =3D m;
> >
> >       raw_spin_lock_irqsave(&m->slaves_lock, flags);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/SER-NSBD.v3.r0.20261103064310%40mojatatu.com
