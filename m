Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793703864;
	b=yJ56C7pbZgIfevECNTxuysdnJmobZ4bblLhg93WSEwA+QLvKJYLQwpq2fSrpzV9WHDjV
	 MOy5+hBET9t0XCiS94FmVxcKLc0xM/Ds692FThiv71IcSkFBZgquRjIoziYiI8ppZB/RY
	 coY4sTC9cnEM0DNch/TOb9GJO1FRBXFPMPnXT+Szj0vuw+Nbesb1rHnI/E2Dj4bvFOAa7
	 A/Rd/piUG2+T7PaVICOdLhbYimulv+3x6evLFbaad0XWFg+hH9NpV+7GwrBzZoFfsv08Y
	 WZu/HgLMBu9LVgTRehjHjjc79rskWKHhZAW/zY2BlwHBO9lLg9X4aCExR/oFyNAHQXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ihq6fFi6/Py7vQ5miYBdO3v37BD8vmOxVL3kmQ5hPfA=;
	b=EU+xhda1JMxK2hHpxxRYFglGql7I9iRHASww4xvjzs1tDsSH52afMJcqv9NKMSJtWHNQ
	 5bbTZPNZPtFBXvQms7xppzYV4w8mzq36F5PSYL9E93M3Em/8bg4yPj4+CEf2DRxHb1yFk
	 tAbY7csyEEDSvp8ZXC5UePG3MssGNHNXhrDxdsfhHm+7gd4FOvIIEiFr/izwEGHjBtI0M
	 2FKn7qsTXixB9Dn1gMPfHFWsbTR9Wk4iCy5hnyERgZbUloQvFDqiEUduqTcSOUE+1jcZz
	 XhgE1AWEFyXU3tmUSJhQQvP3GS+bY89J56T2rH7FvWsbvQl7BRglzrYCm8JlBHimBww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cEIk6BUK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEA4606C544
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EEA4606C544
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cEIk6BUK
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso2152668a12.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:04:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793703863; cv=none;
        d=google.com; s=arc-20260327;
        b=sn2YmHGFMpfBSxxrc230Iu/IB7F1BPUw5fGF4KLd7E83auIwyKRQ3Vyr/9CRueghWh
         IoavxkPw2tmA08Sl1y3XDye3GscAdTv1NSGnLYTb4D69cFTPke0CDqO8MSYmuWxx1xbr
         4u1o3xnf+1lwUTYIjYXNcXBt/kk/7yP9FnK/p5q8qxUng8bs90ETO6wbSykuemrQoymF
         3FO3Q6eGFr553J6gLFx7OjHvYO/oE6tcytpRyOrAa/2ykrbTBSIdEhJ5kSWYVTDNEjtp
         BhQCmBLgd8KBYM+9T67g+7hx5c67uhcGCk0BPR0FEzu1yVn3tZjcn83aU0qXMwAuoKiP
         pK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ihq6fFi6/Py7vQ5miYBdO3v37BD8vmOxVL3kmQ5hPfA=;
        fh=M4EiYFk8mpNqVAfdZ4Aq7fTQLcRjohqfMqohuJ8k3Ns=;
        b=cI2ZWDFllkmiMe6fcrLjCLrahgTQkSwS+TKt8hhoPeGCExUo2uZjbnmZLD0owE7qLy
         nKyhQUGoE6ECV57O0wFzcCVv5IYvLOqbYYY79Q43Y3Z/V1Ry7cRDu66DquFOy83jKL8+
         pfddHhcxJpvcNorAmADJ3eesmaI9Bvx/0dYJMbO/kcwN0VoikPstM08it2miUug8lK5G
         DWzgpSMU1BO/g0XKIjZdE4yypyEPPFmUY8XKJvBwfypVLuwOQoFIhWTaqH5R8+AG8DkG
         zUs3TOcHJYNt7UOGjXJmO2FLcJBGHmp+bz+DpDWMPMNT/hSDWbyDhlyF3tt3H9AT3aZk
         MddA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793703863; x=1794308663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ihq6fFi6/Py7vQ5miYBdO3v37BD8vmOxVL3kmQ5hPfA=;
        b=cEIk6BUKNNrstBnq1gVT2sp/ppmTqr6iugiER4Sl8QQ1Iw95mgVDmfaEBP2WMoYaPG
         Hr7IV54AUpbjPO/goo6B59UyzKdLt6qHE3MS/zyi9oKHGd7IumnPTnxaEiP5zkMOGTAx
         qLOeJ18yrdFVAP+pyPqbDEM7dD4oDU9xcZP44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703863; x=1794308663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ihq6fFi6/Py7vQ5miYBdO3v37BD8vmOxVL3kmQ5hPfA=;
        b=JF+KUGVFoNhBm3gP4B9yYgfMmXujZywJumSbDZuwjhuvyCXVDuukFA2Y9Tc7eRbpxJ
         nzY6akI8k6fUJ0bjl1neEVvFthpFoXoxxlBkC5MM98ywXxegFfLALL5oOrO+sLyxQ2iQ
         PRr3rFkWBcpn5le8Tziiu3SX3fwggfUkE58F7moYENG8lO/TbaBjqytZdmITFvzA2IgX
         1FS08eLu6DxO/kZxDmK02xmbRQzacRJjoofecAhaX4KZ60T/1PMVY3P9/3roX1QC/biZ
         /lffwQNR7g0O2LK/1ej1g1ipFrAjkFdhqTfJOybKHG/DTnh7fH/TQCV/C4rpq8sQ0KZL
         pBhA==
X-Forwarded-Encrypted: i=1; AKwUvByNl0zWlfZa+oYWowsoJ9VC7ZirRA87P7qicTb+IfKkbNdAFrhH6a25ln6PZVTTmDdz9Yb9Qvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OWqanMsOdaFqbQSeLQS3bQ4oEjN98QN4HQQWkIy/5CWiYo/8u
	ym1m/uvYz2Nvah9nvl7+8YM2W0SfR5F1ZhSBJRJUm6g/m9VjpdrxyTEoQPmrlnWtWvwUFq9lL3H
	Q63k0VWPK3JatH6cL+2mx+lNM5eK7TJH2ZvVqPSLPR7lHhxpQD1hyKQ==
X-Gm-Gg: AYBFou3AZMldAs2hY5d9QvkbuM42JNh4W5cLmuhH/6PxitRPBXCUtuq803mFi/+22Jy
	ljoBJE39VEr9YdRTMXliggoLTE6R9cq8O5pcY3tALZWPggGlYOrUJUlEFltLyKkm24MWko9kGZg
	vgSA5jib1ZNUZo/BvzRmS3g4LWXKEWMoIVGAwY5CQM48E1bODc4CGxBv/CiuTDZW4Yn8ElC8fCY
	AMcf+L3Q7oiI5MzQ4y7oQF/DlsUTnZXCSuKFoAX+FnlkfGivBP3jSHojufr7lLWlCmZgWIvATS6
	0UGHbPZP4vDooJcLIZ04d1tYPPnnlD6fVR29FdXb0IAnRm0bowBzEttRYbYNcD350qifDuDQG3d
	94kV9XqZLXfpImehAWbWSTDVhTNgQQW7gCBSLTLIGUKMHJsA3BuYBgyGzJwf7yAjwdyi0SIfheA
	MQN+2HfMrYEMgSd90=
X-Received: by 2002:a05:6a21:8809:b0:3e1:4527:6350 with SMTP id
 adf61e73a8af0-3e928e16ca9mr8996830637.64.1793703862587; Tue, 03 Nov 2026
 03:04:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v2.r0.20261101171325-3@mojatatu.com> <179366641863.488856.17368571591466000274@kernel.org>
In-Reply-To: <179366641863.488856.17368571591466000274@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Nov 2026 06:04:11 -0500
X-Gm-Features: AclHuK_7WMAkLafIRWU2ORlMWzjxOnh31UgwAxu8axG1fGQl-__VNHwZVi8gZuo
Message-ID: <CAM0EoMnaxs4h5jRGX8Fw_oXh608WdEJo_9QAFTgmTbHcgN-BgQ@mail.gmail.com>
Subject: Re: [PATCH net v2 3/4] net/sched: sch_teql: reject qdiscs from
 another network namespace
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 7:40=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The fix only enforces the master/slave same-netns rule once,
>   when a slave attaches.

Nothing to do with this patch - preexisting. Captured for a followup.

> - [Low] After this patch, tc-testing case 124e ("Try to add teql as a
>   child qdisc", tools/testing/selftests/tc-testing/tc-=E2=80=A6

True - 124e is now answered by either check, so it no longer isolates
the root-only rule. I will send v3.

pw-bot: cr
> --
>
> net/sched: sch_teql: reject qdiscs from another network namespace
>
> With this patch, teql_qdisc_init() rejects a teql slave qdisc whose
> device is in a different network namespace from the teql master. It
> returns -EOPNOTSUPP and sets an extack message. It also moves
> skb_queue_head_init() ahead of all validation, so every constructor
> failure path sees an initialized queue.
>
> Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.c=
om/
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.=
20261031160050-3%40mojatatu.com
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
> This checks the namespace only once, when the slave attaches. What keeps
> the master and its slaves in the same namespace after that?
>
> teql_master_setup() does not set dev->netns_immutable, and sch_teql does
> not register a netdevice notifier. So the master can still be moved with
> "ip link set teql0 netns X". __dev_change_net_namespace() only refuses
> the move when netns_immutable is set, and it only shuts down the device
> being moved:
>
> net/core/dev.c:__dev_change_net_namespace() {
>     ...
>         if (dev->netns_immutable) {
>                 NL_SET_ERR_MSG(extack, "The interface netns is immutable"=
);
>                 goto out;
>         }
>     ...
>         dev_shutdown(dev);
>     ...
> }
>
> The slave qdiscs sit on other net_devices, so teql_destroy() never runs
> for them. m->slaves and NEXT_SLAVE() still point at devices in the old
> namespace.
>
> After the move, teql_master_open() takes its MTU and flags from those
> slaves and teql_master_mtu() checks against them. teql_master_xmit()
> also sends the master's traffic through them:
>
> teql_master_xmit()
>     struct net_device *slave =3D qdisc_dev(q);
>     ...
>
> Doesn't that bring back the cross-netns master/slave state this patch
> is trying to remove?
>
> There is also a way back into init_net. teql0 has no rtnl_link_ops, so
> when its netns is destroyed, default_device_exit_net() moves it back to
> init_net:
>
>         err =3D dev_change_net_namespace(dev, &init_net, fb_name);
>
> Suppose root gives teql0 to a container netns B. The container could
> attach a slave in B, move teql0 to another netns C that it owns, and
> then delete C. teql0 would end up in init_net with a slave on a
> container-controlled device in B. That looks like the case the commit
> message describes.
>
> The first move out of init_net needs CAP_NET_ADMIN in init_net, so this
> patch does close the unprivileged reproducer in the commit message.
>
> Could teql_master_setup() also set dev->netns_immutable =3D true? Another
> option would be to detach the slaves when the master changes netns.
>
> [Severity: Low]
> After this change, does tc-testing case 124e ("Try to add teql as a
> child qdisc") still test the root-only rule?
>
> 124e requires nsPlugin, so $DUMMY is created inside a per-test netns.
> teql0 is always in init_net. The root-only check and the new netns
> check both return -EOPNOTSUPP. 124e only checks the exit code and an
> empty matchJSON:
>
>         "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 2:1 t=
eql0",
>         "expExitCode": "2",
>         "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:1",
>         "matchJSON": [],
>
> If the "teql can only be used as root" check were removed or broken,
> the netns check would still reject the command with the same exit code.
> The test would still pass.
>
> The v2 notes say:
>
>   The cross-netns check ran before the "teql can only be used as root"
>   check, so every case it did not catch was answered by that check, maski=
ng
>   the assertion that tc-testing case 124e makes.  The root-parent
>   validation now runs first and the namespace check second
>
> The new order only changes which check fires first. Either way, 124e
> cannot tell the two checks apart.
>
> Could 124e run in init_net instead? It could drop nsPlugin and create
> $DUMMY in its setup, as 84a0 does. Alternatively, it could check the
> extack message.
>
> >
> > -     skb_queue_head_init(&q->q);
> > +     q->m =3D m;
> >
> >       raw_spin_lock_irqsave(&m->slaves_lock, flags);
> >       first =3D rcu_dereference_protected(m->slaves, lockdep_is_held(&m=
->slaves_lock));
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/SER-NSBD.v2.r0.20261101171325%40mojatatu.com
