Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475271;
	b=4/JmOALMgqDGJEdpX9ZPOr4UUkZ6/i3SCidfvpk+Tp/XlOHUSZw3fvKMSxVH7bJepPle
	 U2CpPOaT9gJCzQ6btFuCSEbs2pXa0DN0uP44k2XK/rBXKC3vSYeTv+OsctBKWcbpqNNmd
	 Qhgi5pKTqBFfQvBGj8efQKhouwoJjV6ak+w2RKGLhH5sDTZSTTVUbX9QdbzG4000n8fT+
	 17kDAvioAhiHqSjEJgHgd98LGvpx29qUpI+ipeLTh4OrFC/abgM2ian+bezzVlgRZv+pf
	 woqdKgZ05LXsA3VhsCtyk1GmQWHUPT6bIfaGm9QtrBdlStC6SIUxxHnOvCHQuSYBhfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=N35mGn3V7LG3924eRYreFRpH4QakgRq0bchwvUBzg3U=;
	b=SlEZbVhmS/9G1c1p6XzxpT6Xkc0P9sUX5kZuArfqaCEylRP/3pLIN+MGdIj2rPighEJm
	 uNq7wy/uWHcj7eHqZM1LgrtSKHBkYzeS5Uy6XCQzf6aNfCJFrGuEkforE6FaocKCH7fuk
	 rlRJUu40dGjj5rlbPIbwMH5/gYRTaYb8t3ygenK/lbNBC9/Ue3x1dbJ+FW4BhlHYkHe/V
	 gJkRv+SZ0iifHXPMJPRuM+mctoIISq4bNUrBE9mKOeYA67a147RTGAD83FhDfaUjim1q3
	 4A2bsVxuC6lODjiU4OaMu9EIrxHNZNSAT4Rpxh7Aa1TJTA8MhVPiemT2AWrt1s7Iisw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=J37sXjX3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2585606A322
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2585606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=J37sXjX3
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso2670835b3a.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:07:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475270; cv=none;
        d=google.com; s=arc-20260327;
        b=lFXXAgou9b7lK+1C4Z1PdyrPJx0p9lLTcmIcwEptdvUMc0F0jMPpYNF6+wD8vFaPPp
         eoHX+rWjhOkinNqqiUXa7Hhhkr5trXcUaFkYtCe4XVd5ICn0oQbLi7THa+glrlOzC3jc
         d2XQ8zZSPJoWckDXiWRaQFuzbLUnbmtdj4Iiah4KeAf8NqT4XsEi9vw7/TACFnsYe+mx
         +QO7G0DAZUc5wiTavf5psg3vb6yMxdH7WOOdM/OUxF4qI4/QSeKqGmk6GFezpFt9a8jI
         p9SJ2oDA7e+NGsooqFVbY9AlbFyIuDHk6lUvJYnyjnJHKbCo7hAyQTYCV2tCMEkhLsoV
         nKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N35mGn3V7LG3924eRYreFRpH4QakgRq0bchwvUBzg3U=;
        fh=KwmIEBo9xQ0dfIuieLiN6GL4nYYQQjSQos+8o/KtJDE=;
        b=fQ3x/3m1Ojnza4z/r34MLa2e2rpO5vFdVmK3UPfFUm913Zv1hKDlvzV9MsrUEahQqe
         sS8kTcktYAacSvWeSbXrM3HiDGwltEbkrvXNtESWSo8TJJUZ4YwspixBY6RcpVtZ4ypk
         7yYBtpbgAHEfycizaXZ1/km6uCxlt11WWN/MyOI1vWCYojFUOrYP9Vqa95aahdjeuzjm
         4qsBwZyyVrlB4zp1ygWizblqXuFot/xPoz1XBX5W8nzCMcOJUrUXBgXvndEGwQS1LkVC
         yBx0yCl+VhPGsLIHFCxHSXaIh4nzowgpRAxsKyaKTSLVtde7KBS82I6OGKWLcb3jLPS9
         xzcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795475270; x=1796080070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N35mGn3V7LG3924eRYreFRpH4QakgRq0bchwvUBzg3U=;
        b=J37sXjX3lwbifbcFUA15lGlik+cJgtHjX919vbiA7vrGyBos09O972DzpojX0kFOSx
         KBT+aXQuYKqlNY63tMGWZu9k64eSV6gJicT5Rdv901EyxXWl8qJvi6K1EVjjTkYxYN9X
         /KIqs8KPfx3RR2Y0WYl38S1ZwZ1p+tLFKRhkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475270; x=1796080070;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N35mGn3V7LG3924eRYreFRpH4QakgRq0bchwvUBzg3U=;
        b=vIxZNlAThZrkhvXcySbZj2bD7SJEchsGvfP01c9xfD56Na//27YY1UdF2pp1dkamw3
         KdTC0KvVFtGWOX9iZG02zNBR5excb5smV9Zhdqt8UZj1XwahfiXrJJ7I7aYVYroSl0XU
         Lj/Y+9/e5agYvQO5HmA6FqCcaGJhKgjf7cWgS6v4R88VtLtiLWYtzAh82g9BlfFNJ/l2
         gBi7GjXvrECtmfE9iWjejEEEgKVTmxIGa8l6CWBcF1UyA7WUGuJBy/K1JW9q6EXSlZHd
         R/RMc0Q3RYYK1yCwqJi9qydkI8OjTc1IrF7iXoU18ZCk4PJLLhy4TYSTNKFXmfx4jz7H
         NHDw==
X-Forwarded-Encrypted: i=1; AL+hErHjMFwDPVBQFloeZUdlIeUvyP7ihxEAgZSv+5FcpgePJn+hoiEVGgFJCihqlVeHGDuwCeON5lc=@vger.kernel.org
X-Gm-Message-State: APuU4Z82C33IBbeyYhsSJ2GDgdqSUz3b7UdAlCuI8HwAyMiBZaHmELqU
	L8S1GvZeEWIGcNnynjGpUdaJN0gzK20mWVeX07qxUvuJ7Mgx+tKTisSqEw0iqy9TVv1a1XfPVBM
	1XeWR7GEvBYVNguLBQaLuhyjtZoQKHDMhVVgk27zc
X-Gm-Gg: AZFdTZcW1pLrMfYBNieyUKhCX6uKCv9GDqOWQQ6mqWZ70qLkbQNjOlqGf5r9fRW1aAb
	0asH+86UL4/5BlnFm3H3EXkPPblzDABScJ8bcow+Wtk1MiZr/zZt7l647YGE9vS91AFmNWSuAvB
	hkVYWj7ZGY6/zZbHq0qTt5ZVlDDGpvyagXtQSWm+iOFCV60lUr8eQV8VPpqE5omcKx7Xw3T8+h3
	h18YyxdZR1+uvHD0JbzQspFhxCGO2XxY55PXvCiQs1Fs2l9s2MrSHsW+zPbzaNJhThwh9lz/7hC
	oFF1arVUCysZs8IL9q6BDQiPpaIbQ6K+i8zjcPtPGWiAWRGMvbxV5UL1SMpOvznj/zRdEvEI7iD
	mV6c+w5sNOsPlkal4ZTwPtnzh/sZPj7EHolu0zH3x4z5AqbHxgAS36BFUmVLO18XF009QdaTcTd
	QMCKaNoQ55DyYnWL8=
X-Received: by 2002:a05:6a21:e089:b0:3d8:e57a:5a5b with SMTP id
 adf61e73a8af0-40149f7bc79mr11477810637.5.1795475270226; Mon, 23 Nov 2026
 15:07:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v6.r0.20261119070330-2@mojatatu.com> <179543888245.3135.17083845108187483466@kernel.org>
In-Reply-To: <179543888245.3135.17083845108187483466@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 23 Nov 2026 18:07:39 -0500
X-Gm-Features: Aa3M54q1ZQuOurGholQMRf5y1rqpOByOjJUneEMlFyPEGEHyFGCPb2ATSExZVIc
Message-ID: <CAM0EoMmaaamfTm8R0N6fzcv2FhnJzjACPzwcJQRps47OHJpSrw@mail.gmail.com>
Subject: Re: [PATCH net v6 2/3] net: neighbour: reinject a parked skb through
 a headerless output device
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 8:01=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
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
> - [Medium] The new gate in neigh_update_process_arp_queue()
>   (net/core/neighbour.c:1345-1347) trusts the neighbour found through=E2=
=80=A6
> - [Low] The patch carries 'Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")' and
>   'Cc: stable', but the commit message says it fixes nothing reachable=E2=
=80=A6
> - [Low] The new comment ('headerless output transmits on skb->dev, not
>   n1->dev') and the commit message ('Such an output sends the skb out=E2=
=80=A6

Ok, i will withdraw this patch and the next one. Sashiko doesnt have
semantic knowledge of other threads
(https://lore.kernel.org/netdev/CORE-J9UK.v1.r0.20261120103344-1@mojatatu.c=
om/)
so it could get infuriating pointing other patches to it; a human
would have ended this a few postings back.
This may also (i think) align with what Alexei was probably hinting in
the other thread.
Once 1/3 merges i will send 2/3 and 3/3 as net-next.

pw-bot: cr

I will send tommorow am.

cheers,
jamal

> --
>
> net: neighbour: reinject a parked skb through a headerless output device
>
> This commit changes neigh_update_process_arp_queue() so that, before the
> output call, skb->dev is set back to n1->dev when n1->dev has no
> header_ops. It is the neighbour half of a pair with the sch_teql patch
> "net/sched: sch_teql: keep skb->dev consistent on the arp-queue path",
> which moves skb->dev =3D slave ahead of teql_resolve().
>
> Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
>
> > exists once the second half, "net/sched: sch_teql: keep skb->dev
> > consistent on the arp-queue path", moves skb->dev =3D slave ahead of
> > teql_resolve(): until then the parked skb still names the master, so th=
e
> > assignment is a no-op and the recipe below does not reproduce on this
> > patch alone. The two are taken together.
>
> [ ... ]
>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org=
/
> > Cc: stable@vger.kernel.org
>
> [Severity: Low]
> Do the Fixes: and Cc: stable tags fit this patch when it is applied alone=
?
>
> In this tree teql_master_xmit() in net/sched/sch_teql.c calls teql_resolv=
e()
> before it sets skb->dev =3D slave:
>
>                 switch (teql_resolve(skb, skb_res, slave, slave_txq, &hle=
n)) {
>                 case 0:
>                         if (__netif_tx_trylock(slave_txq)) {
>                                 unsigned int length =3D qdisc_pkt_len(skb=
);
>                                 int rc =3D NETDEV_TX_BUSY;
>
>                                 skb->dev =3D slave;
>
> So an skb parked by __teql_resolve() still names the master. The master h=
as
> no header_ops, so n1->dev =3D=3D skb->dev and the new assignment does not=
hing
> for teql.
>
> The stable tag carries no prerequisite note. Could Fixes-driven stable
> selection pull this into a tree where the sch_teql companion patch isn't
> applied? In that tree the only visible effect would be the nft fwd /
> bpf_redirect_neigh() side effect that the commit message describes.
>
> Would a stable prerequisite annotation naming the sch_teql patch help her=
e?
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index ae2db3912454a..d36d86cfc441c 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1342,6 +1342,9 @@ static void neigh_update_process_arp_queue(struct=
 neighbour *neigh)
> >                       if (n2)
> >                               n1 =3D n2;
> >               }
> > +             /* headerless output transmits on skb->dev, not n1->dev *=
/
>
> [Severity: Low]
> Is this comment accurate? It reads as if only the headerless output
> transmits on skb->dev.
>
> neigh_resolve_output() and neigh_connected_output() use neigh->dev only f=
or
> dev_hard_header(), and then call dev_queue_xmit(skb):
>
> neigh_resolve_output():
>                 if (err >=3D 0)
>                         rc =3D dev_queue_xmit(skb);
>
> neigh_connected_output():
>         if (err >=3D 0)
>                 err =3D dev_queue_xmit(skb);
>
> Both of these transmit on skb->dev too, the same as neigh_direct_output()=
.
> The real difference is whether n1->dev's link header gets written, not wh=
ich
> device sends the frame.
>
> Could the comment, and the matching sentence in the commit message ("Such
> an output sends the skb out whatever device skb->dev names, not out
> n1->dev"), say that instead?
>
> > +             if (!n1->dev->header_ops)
> > +                     skb->dev =3D n1->dev;
>
> [Severity: Medium]
> Can this gate send a redirected skb back out the original device, so that
> its egress hook runs a second time?
>
> Two producers steer an skb to another device but leave the original route=
's
> dst attached. nft_fwd_neigh_eval() in net/netfilter/nft_fwd_netdev.c does
> not drop the dst:
>
>         skb->dev =3D dev;
>         skb_clear_tstamp(skb);
>
>         nf_dev_xmit_recursion_inc();
>         neigh_xmit(neigh_table, dev, addr, skb);
>
> __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() in net/core/filte=
r.c
> replace the dst only in the !nh branch:
>
>                 skb_dst_drop(skb);
>                 skb_dst_set(skb, &rt->dst);
>
> Suppose one of these runs on egress of a device A that has NULL
> header_ops, such as the teql master (teql_master_setup() never sets
> header_ops). It redirects to an Ethernet device B whose neighbour is
> unresolved:
>
> neigh_resolve_output() on B's neighbour
>   __neigh_event_send()
>     skb_dst_force(skb);            /* A's dst is kept */
>     __skb_queue_tail(&neigh->arp_queue, skb);
>
> B resolves:
>
> neigh_update_process_arp_queue()
>   n2 =3D dst_neigh_lookup_skb(dst, skb);   /* A's neighbour */
>   if (!n1->dev->header_ops)
>       skb->dev =3D n1->dev;                /* skb->dev =3D A */
>   neigh_direct_output()
>     dev_queue_xmit()                     /* A's egress hook runs again */
>
> For nft fwd, TTL/hop_limit is lowered a second time. A packet that arrive=
d
> with TTL 2 would then hit the iph->ttl <=3D 1 drop. Stateful nft expressi=
ons
> and BPF map side effects would also run twice.
>
> If the second pass does not redirect (a quota or limit is used up, or a
> conditional rule no longer matches), the packet leaves via A instead of B=
.
>
> The commit message acknowledges this and calls the producer fix "a
> separate change to the producers". That change doesn't appear in this
> series: after this commit only sch_teql.c changes, and nft_fwd_netdev.c a=
nd
> filter.c still keep the dst. With Cc: stable, does this patch ship that
> behaviour on its own?
>
> Common L3 tunnels such as ipip, sit, ip6tnl, vti, L3 tun and wireguard se=
t
> ip_tunnel_header_ops, so the gate does not match them. Before this patch =
the
> same path was already broken in a different way: the frame left B without=
 a
> link header.
>
> >               READ_ONCE(n1->output)(n1, skb);
> >               if (n2)
> >                       neigh_release(n2);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-6HS9.v6.r0.20261119070330%40mojatatu.com
