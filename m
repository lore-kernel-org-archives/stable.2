Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793470684;
	b=nE90nbX9TXPgLR39yOrUuqVzZnhdLgf5i/AYWODkX13dk8wcZSwWNKOtyhJQMYbGnYqW
	 JnZBXI1yZCS/CksZqfXK/AWfGKEaJqlwTFRNPrqgcIYrttwh/bxS7HQm4iaivnPXGNjr0
	 uu+/NNhkTJ5sV+67Z4BSln3wEnzVXmqOmA4Xf4aieIn6bjl4CFQvh5OhXxihIZJs+kR1p
	 nDNXkOZ8s2kxfM9BR3EH1m7CFl1yI2z5/T/zG0X/mk2iAjD5gPMYCbPj49Chuy0sbfNby
	 v+aCTQ5rsFOsXsm18Ri5+AD60tHfDTNHwHs/dQlxlkTJRy6Oed8g4ZKsCJCHqqrbJcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Xf+2jr2yCEKrSYu/5k7hH7BT6BJHrV0c3wg3u2rwgjQ=;
	b=ZY2diNQaX3d8ufXzpOJDcRO3u2/hpx5Yxo2VdFYIw8TjtCWcm3IEwATIiWriqQLZsj/b
	 miVbN49dIC5iA9j8cd8XZ+pPMeqU/2Wyo9zgHCajoMD3ciETep+8byGALdyoMblYZRq/Q
	 qGrPiEWt8B3Nr1sWdCSTcvKjyJTa0EY9QQufGoJbXQaYRStW1xngHzVSNK+2asTpLG6sw
	 MnO+/sg+NdeQJl2MhtrPj41JTn57yN7VmQdtqE2P54ft+PrfVLejC/GlenxHW2WfLpwXA
	 0iebrJ6G1RGG3C7kNRroo+f31i/cNmZDnTmhcMxdOFdy3rKxmXVdtqW0ZoK6nSlryqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rZBvgQKd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C28606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 18:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C28606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rZBvgQKd
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso695873b3a.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 11:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793470683; cv=none;
        d=google.com; s=arc-20260327;
        b=pv/kRFAi0qPx+BLRHbvmp0O8oDyM5P/lJm8YWMGfjWAyoBhFmc7kCf2ZS03ClymGVS
         PMzYD2crRhtSHyoXRjiQV6FlyY+yV6Qi5R/V4boKXsw9C2/6NouREh/KBYau5obPx7fp
         yz53MZSFeG9rc0L3fkxNPMtdc6aiRcAOQ4MRotzxPa9nho3veo4VR/v6DlByxNWXs1yv
         MDitmuo17cuuu6NFUbKJwzRAtc3Si1MCHfU+YmwySp78Cq3MvZ4D5aIWsVCP+mhD1lki
         +BQK18F1dVVKxS85A9XKvfek6yKKpnI6HlrcnjbViCEwxAW1LsQyzvWeOK3sYnFPpWG9
         VvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xf+2jr2yCEKrSYu/5k7hH7BT6BJHrV0c3wg3u2rwgjQ=;
        fh=J0zCb5BvGGrHY6r5Nmkw19GAgaEzDsYDrt29rURvkNA=;
        b=TsbnUU7idQP7QMwK0YKPjN/GsHstAOTUVlyE5KlflIHp4xYfZZZX7v/P1MexyRM2WP
         /hMwTGroryGgAzngt2elMLtIbqLpw4sl56nhn+s86nOiYgyDXH2vMVymM2ptmz9ZTuMK
         8clSLlYtE9Uu2r9GEsyMRy9XFGKKcbad6MrAVmbldwNoK1VpjnPTcWwuXknR8j75HXDr
         szSGZf1TqMTmhZdX66mSoVXysu15wGjJGewfZlzKrBo8ovZT8cTyuVmB4SZk1X3DanM+
         l7ugdU2cdO+owfpRKijlTrWc9tr02Kjhwp84nlMMzlx32oDHo6HNbu1ikh1XaDZThdhZ
         RSHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793470683; x=1794075483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xf+2jr2yCEKrSYu/5k7hH7BT6BJHrV0c3wg3u2rwgjQ=;
        b=rZBvgQKd87Txw/Gs3OoRgvbztT8csNg6OK5eT2Ppu9DAGr2tA1RhVR5uYTjP8OhkK8
         JjVCXXcFz7XhJjFI4/WcHzKPKnrbTejPRe+FKpSVDx2e6jaNxktbzQybNqC3FlJffqEM
         EhdW7Ht+n6Ev3PNFP3x33p4MeNhG4noxkCggQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793470683; x=1794075483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xf+2jr2yCEKrSYu/5k7hH7BT6BJHrV0c3wg3u2rwgjQ=;
        b=wg4FwYPZ5AL5Z0FKV7HSqzLkL42vGOUdDauSS315BXKc4p4mJGrQQt4vEfkbwINXj/
         fh3eNukR7N4zlqJUzLP11ZU9g/XzFOlbsNbg9hXkzs4Y8qXFs+nIYTZfokHs5oW4B1cd
         KF5+yBMTeCyvTbgDPi7f8/gkPAYDaxs7cQqJg4DzeVu6eHo0y38tIcdL6buvXFLNUOHK
         enG4Q/x1AoWO4NbijfcjH0ChOZqSblW5psmr1L0nXZOoKoTEWvbkzkIr+OSu4teGRQDM
         PcjNiRQyDSs36mrieMjCyKexD9cQd9WUaqwOYB68pA3wQlkDWrVcZ7UOTyuaZUVnmRtn
         L2BA==
X-Forwarded-Encrypted: i=1; AKwUvBz7Ozp86KUFeopFzxEMEtO8SmylPyJ5TMTeeZfq9bcCoAbM66qo3bk7/Uldwie6M1xbbBZlLb4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6qbhv0OWAqJ5h320C1RNAxgn+3M7vxy4LSaYxuYQoWTUq5uxP
	vesl+gtM2PYnw80eUImQ3FdFhANKU5ua1J5h25VEVYGM7lhKrF9YkZxuzeyY7zMW8YtGbhmcD0U
	KRTnQYcsn83eKQE6fcWMf1jFp0W3Kw2S6h+AJ4WCh
X-Gm-Gg: AYBFou1MPIrOfEBr7oJiLe2hKsXToqh1Hp7+xEJq1Hh6vjHYNzOIbnuVSDj1z1U4MIO
	JosVinmnGmql4KbLrlPqW/KswVAK7yZzuCFmNu+X7YXEVCN8abUtnFhFZKowmzeaARN8hRShGYz
	Y5EvLZveyYQuc3uTlXIMFfO/UvQoTFdeSaR/nmvJpB9sg/D0XVVe2HpnHL59Vvu1E1oVTPeGzij
	LNOx7jc2HJ0LS3GcDDGt2bgtHWf3Heqb31cbGMrEmYOj+HED7Hms2EQBgcefsEs3+qZpwV+aYUn
	sIwWqi74s/ZcC6oHK7Uh6Np/bzYI9wJueUlDBsdk6LeGLLz3PuHxGcw8PzcJ9YwNesXLPabFZCN
	GfSj4Qw7YI/uiQRqTnCmnPpHV0eSUDGXMuVKufe00/Stllgo6k9zfsu+Pmtacewbn2tpa6gJfoW
	Qwp+lvFRVeCK+gJRef
X-Received: by 2002:a05:6a00:12c2:b0:8a9:95d6:31f4 with SMTP id
 d2e1a72fcca58-8a9beb69affmr4990553b3a.32.1793470682913; Sat, 31 Oct 2026
 11:18:02 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r3.20261027034729-2@mojatatu.com> <20261031165925.780930-1-horms@kernel.org>
In-Reply-To: <20261031165925.780930-1-horms@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Oct 2026 14:17:49 -0400
X-Gm-Features: AclHuK-iYfsqzRZDDx_HCRa4NQIrG7hm6ImBp8-ZBw71JJWJs4Y8qK7bbqFbMzQ
Message-ID: <CAM0EoMkDCpxtN6EqUMjQ_s7+F--JJQWXviE+wBQjc3vx-+HUjg@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost3] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 1:00=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email says "Sorry Jamal, another round of AI-feedback for this one.
> It is superficually simliar to the \AI-generated feedback for
> repost2, but does raise some specific points that I think warrant
> you expressing an opinion on. Thanks!"
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC=
-6HS9.v1.r3.20261027034729-1@mojatatu.com?part=3D2
> ---
> net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
>
> This patch makes teql_master_xmit() set skb->dev to the slave before
> calling teql_resolve(). An skb parked on the slave's arp_queue then no
> longer points at the teql master. It also makes
> neigh_update_process_arp_queue() set skb->dev =3D n1->dev before it
> reinjects queued skbs.
>

Man, this thing is relentless (double edged sword, i like it's
improving the code but on the other side it's sucking my time with
more pedantry than I have ever been subjected to by any human, and i
have met human pedantry).
Like ive said in other emails: No good deed goes unpunished by this thing.

To be fair: nipa's repost2 review was on the mark already - i should
have invested more time analyzing.

cheers,
jamal

(I am finding myself using that word now and other annoying words like
"shape", etc)
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
>
> > The master can be freed while the slave lives, so the
> > queued skb can dereference freed memory.
>
> [Severity: Low]
> Could the commit message say how the master gets freed? As far as I can
> tell, teql_exit() is the only place that frees the master net_device, and
> it only runs on module unload:
>
> net/sched/sch_teql.c:teql_exit() {
>     ...
>         unregister_qdisc(&master->qops);
>         unregister_netdev(master->dev);
>         free_netdev(master->dev);
>     ...
> }
>
> teql_master_setup() never sets rtnl_link_ops, so rtnl_delete_link()
> refuses to delete the master:
>
>         ops =3D dev->rtnl_link_ops;
>         if (!ops || !ops->dellink)
>                 return -EOPNOTSUPP;
>
> default_device_exit_net() moves devices like this back to init_net
> instead of freeing them, so destroying a netns doesn't free it either.
>
> That leaves one window. Every teql qdisc has been removed from the
> slaves, an skb is still sitting on a slave neighbour's arp_queue with
> skb->dev pointing at the master, and then sch_teql is unloaded. The
> unload needs CAP_SYS_MODULE.
>
> This is the justification for a stable-bound change to shared neighbour
> reinjection. Would it help to describe this rmmod-only trigger in the
> message?
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index d6e9c7c59a892..120c3369406fb 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1339,6 +1339,7 @@ static void neigh_update_process_arp_queue(struct=
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
> This runs for every neighbour user, not only sch_teql. Here n1 isn't
> always the neighbour the skb was queued on. It comes from
> dst_neigh_lookup_skb() on the skb's retained dst, and
> ipv4_dst_neigh_lookup() looks it up on dst_dev_rcu(dst).
>
> Two existing parkers set skb->dev to a target device B but leave an
> original route dst whose device is A.
>
> The first is bpf_redirect_neigh() with explicit nexthop params.
> __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() replace the dst
> only when nh is NULL. bpf_out_neigh_v4() and bpf_out_neigh_v6() then set
> skb->dev =3D B and call neigh_output() on B's nexthop neighbour.
>
> The second is nft fwd ... neigh. nft_fwd_neigh_eval() decrements
> TTL/hop_limit, sets skb->dev =3D B and calls neigh_xmit(), and it never
> touches the dst. nft_fwd_validate() allows NF_NETDEV_EGRESS.
>
> In __dev_queue_xmit(), nf_hook_egress() and sch_handle_egress() run
> before the IFF_XMIT_DST_RELEASE skb_dst_drop(). __neigh_event_send()
> also calls skb_dst_force() before queueing. So the dst is still attached
> when the skb is parked on B's arp_queue.
>
> The resulting sequence looks like this:
>
> egress on A
>   bpf_redirect_neigh(B, params) or nft fwd ... neigh
>     skb->dev =3D B, skb_dst(skb)->dev =3D=3D A
>     __neigh_event_send() on B's NUD_INCOMPLETE neighbour, skb queued
>
> B's neighbour resolves
>   neigh_update_process_arp_queue()
>     dst_neigh_lookup_skb() -> n1 is A's gateway neighbour
>     skb->dev =3D n1->dev;    /* now A */
>     n1->output() -> dev_queue_xmit(A)
>       nf_hook_egress() / sch_handle_egress() on A again
>
> Doesn't this run A's egress hooks a second time on packets they already
> handled? With nft fwd neigh the TTL is decremented twice, and a packet
> that arrived with TTL 2 would hit this in nft_fwd_neigh_eval():
>
>         if (iph->ttl <=3D 1) {
>                 verdict =3D NF_DROP;
>                 goto out;
>         }
>
> Counters and quotas would also count the packet twice. Tc egress BPF
> programs would run twice and could apply encap or NAT twice.
>
> The second pass might not redirect again, for example if the first pass
> changed a mark the rule depends on. In that case, would the packet leave
> on A toward the original gateway instead of the nexthop the policy chose?
>
> Before this patch skb->dev stayed B. These packets went out on B with A's
> L2 header. That was already wrong, but they did not go back through A's
> egress path.
>
> The bpf_redirect_neigh uAPI docs still say the packet is redirected to
> ifindex, and NFTA_FWD_SREG_DEV is still documented as the output
> interface. The commit message says only "This is a behaviour change for
> those paths", and the patch is Cc: stable.
>
> Could the skb->dev restore be limited to the teql case, or handled in
> sch_teql itself, rather than applied to every neighbour user here?
