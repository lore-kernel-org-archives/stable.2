Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793058706;
	b=DT4Mw0qtDlCq38mNW74drMDSZPsd0nsdQbAYsQn4YOVDIrh7AmbcS9r6Qp9G0aCGeItr
	 SJY1xf7uJHAuWytiFIFCaMJI1ZvUZqA68HTFzKjBV/ztFOG3GJsKhYwtbzDXcD+MjZTIW
	 cptjLNgvkHD69gchTjVPv9VH9oDmjg7WMF/LKqHTCp2EbPeR9gj+1jeMHpyY6C14hsjPZ
	 YD6BvFtkGi0U1xjdNeYnRrAyO4n/UsHpkp1WImm1hk6mcb9kxC6nmc0t3OcXutov9Qi8O
	 Kj4TMSaQzfZrai4BwvcyQorzaEBvj9C9oEigxi/NWOY97b/5E6dMJAHYTyjNWhMUAUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UaoOtljsZiSqMBuHcOa8fGzQ5BRPIrVZWD/hL3QGdlI=;
	b=S8LwvLWBYriGYmjYVNmEttZ5uqeRPO+QahxRRDqyD+hSmmVc+UvkGXQY9bLdFEq0mukt
	 23/GSwnq1D22FF4ChPPAzWY17daMPXlI5DWrn3iWUdS8D21uhn7e6y1KEiojOxDUc1e+3
	 pChEnT4S2svntEamrBxsHjp3wlVhEt2ovcEa1TkhN/yKnF2RMbC8LEpbPs8lr5PFCHx0J
	 cIDRvSPGH6YJma+hkt/qsOJfjB+QgVWlnX2ECkRRWhPbYkgX8rzGu+vVbLeG+u7tlICNg
	 4nq0v1mK8vAzcm1RluTZoBZ3Z7AouDtJqbm62MYrAa4GY+kr2m5bKZ7NAgqk1gTmp7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="goXIMrx/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A43606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 23:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A43606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=goXIMrx/
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06454116eso1500878b3a.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793058705; cv=none;
        d=google.com; s=arc-20260327;
        b=baFzuaoGFeUsNdoufm5xowF5bmQ1E3eufH9vkTuEcQd1rj6D8MRXj2WjC8IE84U8D0
         O9pQrv+x2wAoPx4TJiuQ1ZNXt4snQ8ve7/aC3dn1pw1dmD1jgnsZo0w0g+3oJ7HWLAoc
         MsvzlsMyjd61xT/xD/y2zMZxAEvRH733j/XVDW4Ew28d29KqPKx2Xx+pLCwGb4JTfy1L
         gF4v7oSERc3/xEb1EIKVVpMtOTVLlUssikgg5n5mM5WdlVupVj9zF2NdygdYTIGpieAI
         pHhbWKKTu3ExKylEdVTCzeSo+S5FL4LVVCMV0IoFZ62KhxFltLHlNpcyl8B1i/wnI3MZ
         DZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UaoOtljsZiSqMBuHcOa8fGzQ5BRPIrVZWD/hL3QGdlI=;
        fh=li3WVtYmgpy1Oc2ZV/KOVeFuI9wNo7lAK36iKpDGck4=;
        b=eLPR0Wa4LxLAJN7tkKdsnOYMmoFYzfxcpA2wd/sUlQp+iiNymx0yjdHVpDx5/oXkVa
         NOsYRn17l2o16U79mR1Pmn2uMVyjNqKaeo7oQ5w+QSahH8ELgCYO1SKE/DnJwaZN4FMe
         aL9UrqOoVwvSp/POFQzEyS+Vh49g2RGDMSI//7W+oaBsLt605RDTJ1emVRQjjiGvVJSg
         uvctqzeOZD2r6YWOyUtW/uTuuJ4J3vvEQv/BsHTv7OjpGcPr7KPdFZ6uUYrErtBPW7DN
         Df+oanpAcG4zSCy4iTigcwkBesFYtfMToKs6cPxQipiTiBaKn63lLX+lhvERJ8trKJVp
         1x9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793058705; x=1793663505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UaoOtljsZiSqMBuHcOa8fGzQ5BRPIrVZWD/hL3QGdlI=;
        b=goXIMrx/3XjAcQ+cSW5YwfuTirY+Lh7JxbdW58R8kt1vFWyozoutudfzR2D6O9b81T
         aBKVERFm4MQfqvpA84tGp/IMkXsnqTLkcaP7XfmQ7JdID12qo1BiSQq24NBwNAHXNUaS
         7/cT3PhJvsUmJx1OzbX7vo0jQDiXumfPGHvf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058705; x=1793663505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaoOtljsZiSqMBuHcOa8fGzQ5BRPIrVZWD/hL3QGdlI=;
        b=BwP1RQ1lWAV1XyJo2lq3lWwUGXz3gr12ptXC/nRxQXYqY00Gt7gy2Yu+w3Ht83r/Jq
         gWdG9QE+l5nvwU2dUyZd9GKV9h5Yr3B2J9LqblKj1XoKQGxBGpmck5UqsULwd/iBv0wT
         d8iBx2MJVglzvBXEcIuT79EJFrPO9sOesgbvUitiooiz7YwvrCnQyAKgFILcGUB+OHxz
         4yF0ROzJ987sUATFtGTWblSishfIPhsVKQ3WqiO0snmudL/nc3ASF9AOsIFrm28PDlaM
         qMaWD/1hHPmYZ58WlH+EpmvyClnO2ZyYyu3YPwa0fUPflKcvemkcUVGcwwqgncBTS7ms
         wa6g==
X-Forwarded-Encrypted: i=1; AKwUvBxFLqGFCuJ2S9iNbO6YnUDW8x53H1A3evITmDDUqv/GMLRrxhngYMDDAvYJYaIfNZzpoPHBiRo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN+S+MJPJYYdSFZcXv8IkZnIV2tIqs+BMbhsrcQKvnSnYA1+i6
	ehGatmI06ZSlXb7kHHvy/4yrC8DNoGBxVlQMYMaI/7F9fPBDs6fkZ9NmEridq5nRyzoF8Rm3xJE
	iSgOfcNWiSLXHDr6NXseqzUxl16B9NIJ0EPLjmCgf
X-Gm-Gg: AYBFou1oyjeXzEpMiVwqTzC3euLDOldB0UlT6ue+OHjClSkNzZLIK7yitTQDVULboIR
	OAJ+7Gz5pTcwDDRBEp5skK1G2B6si5AG6ymBD6OP2bPBuqmfgvIZW4xSojv+DjM8t0MB9OaX+1m
	CegpFgJLeNBmGJNz68/8wspWOj3NX6nra+MYd2BaYrbSjixi+3Z5GhJlwaCRmN15iy7YnHxrYAD
	A1cFPe6kJ80ymxIv0CbGk2ddpZI8/c5a8r57qzC/kZvnPjec0zVKDifwVLO6YxE6CDuGWZokB2a
	M1LFbGuFMuksN47BOJFF54DXL8tn3COdiscToDForqpN6ceIkyIcVDqNlFX8RSc71lVH563nRnz
	Ov31GdgGkFiTnE9p4gd6+v6R4hUpzeQuhxvkgOBiLTCrJKuda1NyBdorfNAz5zKbS+1H+BoYaQf
	yi4r3iDw1IQJFv8aE5RkDySOhovgsJOE0nCxvu
X-Received: by 2002:a05:6a20:549d:b0:3e2:2b76:bf23 with SMTP id
 adf61e73a8af0-3e7cd5034b0mr9457553637.68.1793058705580; Mon, 26 Oct 2026
 16:51:45 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com> <20261026160747.283702-1-horms@kernel.org>
In-Reply-To: <20261026160747.283702-1-horms@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 19:51:33 -0400
X-Gm-Features: AclHuK9KOrZqBCdN7DDV5_e9NiBiIHJYcLxYj0JIq2lJ37Nc28lxMC77niZb0Yg
Message-ID: <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 12:08=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email says "Hi Jamal, passing this on for your consideration as it
> seems to have got stuck somewhere."

There was nothing wrong with the headers this time - so not sure what
is going on. A bit frustrating.

In any case these are complaints about commit messages in both 1/2 and
this i.e there is nothing to change in the code.
If necessary, I can resend repost 3 with the fixed commit clarifying
the "identity for every other parker"

cheers,
jamal

> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC=
-6HS9.v1.r2.20261020051718-1@mojatatu.com?part=3D2
> ---
> net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
>
> The patch sets skb->dev =3D slave before teql_resolve(). An skb parked on
> the slave's neighbour arp_queue then names the slave, not the teql master=
.
> It also adds skb->dev =3D n1->dev at the reinjection point in
> neigh_update_process_arp_queue(), so parked teql skbs go back through
> teql_master_xmit() when the neighbour resolves.
>
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 7448320f7ad52..5823f5007812b 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1336,6 +1336,7 @@ static void neigh_update_process_arp_queue(struct=
 neighbour *neigh)
> >                       if (n2)
> >                               n1 =3D n2;
> >               }
> > +             skb->dev =3D n1->dev;
> >               READ_ONCE(n1->output)(n1, skb);
> >               if (n2)
> >                       neigh_release(n2);
>
> [Severity: Medium]
> The commit message says this assignment "is the identity for every other
> parker (neigh_resolve_output() parks with skb->dev =3D=3D neigh->dev, ndi=
sc
> probes carry no skb)". Does that hold when the skb's dst points at a
> different device than the neighbour it was parked on?
>
> If the dst is not DST_OBSOLETE_DEAD, n1 is not the parking neighbour. It =
is
> replaced by n2 from dst_neigh_lookup_skb(), and ipv4_neigh_lookup() looks
> that neighbour up on the dst's device:
>
> net/ipv4/route.c:ipv4_neigh_lookup() {
>     ...
>         dev =3D dst_dev_rcu(dst);
>         if (likely(rt->rt_gw_family =3D=3D AF_INET)) {
>                 n =3D ip_neigh_gw4(dev, rt->rt_gw4);
>     ...
> }
>
> So the new line is only a no-op when dst->dev =3D=3D skb->dev.
> skb->dev =3D=3D neigh->dev is not enough.
>
> At least two parkers seem to break that. The first is bpf_redirect_neigh(=
)
> with explicit nexthop params. bpf_out_neigh_v4() moves skb->dev to the
> redirect target B and resolves the nexthop on B:
>
> net/core/filter.c:bpf_out_neigh_v4() {
>     ...
>         skb->dev =3D dev;
>     ...
>         } else if (nh->nh_family =3D=3D AF_INET) {
>                 neigh =3D ip_neigh_gw4(dev, nh->ipv4_nh);
>     ...
> }
>
> However, __bpf_redirect_neigh_v4() only replaces the dst in the !nh branc=
h,
> so the routed dst for the original device A stays attached:
>
> net/core/filter.c:__bpf_redirect_neigh_v4() {
>     ...
>                 skb_dst_drop(skb);
>                 skb_dst_set(skb, &rt->dst);
>         }
>     ...
> }
>
> bpf_out_neigh_v6() follows the same pattern with ip_neigh_gw6().
>
> The second is nft fwd ... neigh in a netdev egress chain.
> nft_fwd_neigh_eval() changes skb->dev and parks the skb without touching
> the dst:
>
> net/netfilter/nft_fwd_netdev.c:nft_fwd_neigh_eval() {
>     ...
>         skb->dev =3D dev;
>         skb_clear_tstamp(skb);
>
>         nf_dev_xmit_recursion_inc();
>         neigh_xmit(neigh_table, dev, addr, skb);
>     ...
> }
>
> In __dev_queue_xmit(), nf_hook_egress() and sch_handle_egress() run befor=
e
> the IFF_XMIT_DST_RELEASE skb_dst_drop(), so A's routed dst is still
> attached at these hooks. If B's neighbour is incomplete, the skb is parke=
d
> on B's arp_queue with skb->dev =3D=3D B and dst->dev =3D=3D A.
>
> When B's neighbour resolves, n2 is A's neighbour. With this patch skb->de=
v
> becomes A, and n1->output() builds A's link-layer header and calls
> dev_queue_xmit() on A.
>
> Before the patch, the frame still left on B, though with A's link-layer
> header, which was already a pre-existing problem. After the patch, would
> the packets queued during resolution go through A's egress qdisc, tc and
> nft hooks a second time?
>
> That could mean nft_fwd_neigh_eval() calls ip_decrease_ttl() or
> decrements hop_limit again. Non-idempotent BPF programs (encap,
> adjust_room) would run again, and counting or stateful rules would see
> the packet twice. If the redirect is not applied again on A's path, the
> packets would leave on A and bypass the configured BPF or nft steering.
>
> Since this is a change to core neighbour code tagged for stable, could th=
e
> reinjection fix be limited to the teql case? Alternatively, could the
> commit message describe the behaviour change for these other parkers?
