Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE82E06EF
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041581; cv=pass; b=TsjVXf+HlyznM/02tLNishV+yAuYJDmChqCZc0Pv00Rntb5Y4pR89MQHRW6I68dT9WASmUX0lQdqoqye/q9+GGZc2nhMIJxht7CZxKfCOxMTXAADV2C5U0272V9aQJ7yrcLIA8naxwJom2wBtrsL/XdZSfnZ3uMmDJ7vHe0d0Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041581; c=relaxed/simple;
	bh=pfOAB7MYMROfo5498xDO1h7pY/r3KP7/Hy1QpeqQUSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKnQN3d6SCOMycgxoqDq9Fbio35j/c1GArhAMDxU0AGcId0AXT83OLAwfKo1H8csRwrJkmkTjIZwjlfk6x/WAWL5a8bXXrv9A6K8jv3sWFlFBRMO6lTZRN16vgAzKyXKs/fuIsefANTZmvl8I2nR0co5L2N0+IbsW/fpvczAQjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=okDMR+YC; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="okDMR+YC"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84830c774a0so2747327b3a.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 11:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786041579; cv=none;
        d=google.com; s=arc-20260327;
        b=hnMj+lLYeRA3RRZtyHTJ0heGCxHFcXfT1OS3cEllqbGX9WTsr9rpZ1fT3TrJX8XGZs
         nhskJFiW1WE/jtrxUb2LD3+NlcvRZXz/i3UZTyQlnP0X5O1NxX5Httr9GQ+GHv/H7sa6
         XnnitSI9mKlfTqiimks09A+0Zz4w9tVxtqdAW3uUPZ6LLOYEDKhr5NHMFPelvRqtzSfD
         Y8joZfLoTsYbW9Ph70a05evuPEcVyGjQ2Jhyxc0FYU1KEaVxR0Xngw93KUT0avTganae
         rmUnSP5MyEaaQz9EiIliOKYEk7LIB0x/LAoIaoXhEmgLszTebtpL47eQxIXPpzH1FG74
         kumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BRHjZhbdz4WOUONSDd4bnXv2txqD1N3uSMMQ8P4FTQ=;
        fh=ONNESWSP1x9Q/NX6IB9dmJeLgxbZdljuHbUJaXH2bPE=;
        b=imVCHSuBSW9YByFeLXqlHVAvJYbR6PJJrhiweWGlVxMq6LS1ce0sELxT7vfsjQU+gq
         OqONjyusD5gQUck8Dg2/ylBf6Za6l5L4LBjDQFw1IzDDr23uVnoh0pBfdStUoACXAtKn
         SMTpHdh2hK0Lr1dLzChnzh5SbpzLIUKvI7y7B+++DTV2tXu2Cp3kNxHpBruQT48lWhAQ
         tX54eER+67g91eT38dCsh04cmos7zoLYH4DXAXYuuR5M0z9XK4Ah0n33cI5rmF4GdJ4P
         Of3X2gqB4k/1QY4VBXfDce4A5mtWrKgHr11JoSVeAs4xpTUge2CickOXfYvYKnwoZ87k
         qh4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786041579; x=1786646379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3BRHjZhbdz4WOUONSDd4bnXv2txqD1N3uSMMQ8P4FTQ=;
        b=okDMR+YC3r/K6ebLDdh1fDkmFho3lzO1GiizEYaTOe4F5JGo/YBpmaKGAAXZjufHMh
         Ucn77prweppmaHEEcNh47R2ZUWbKFytLb2XMRqvdzyCukpqYV8wsA6yjaczGgcUV2Pht
         PDWtW6oySKeT+AkY6GS3McRkn07sU+7UL3l/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041579; x=1786646379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BRHjZhbdz4WOUONSDd4bnXv2txqD1N3uSMMQ8P4FTQ=;
        b=h7OTs96hJNHd5MrMm7nS8GF4XiMNaiUOoDJFVbLyIdV//Y4WffQxVYm5dKk+PY/JAa
         sfL9Wp8vcfGURm95J4XAq1yGtRMO/oCkXMrTnZxVQQzAcpEqKFoaI57nfp2DVfvpit3p
         D98K0LRmIxyH2LspdsKAoUVElZ64aP2DaUlRGoCBJWZtj1aUVlpD14brnyFEny2Y98Hr
         /M4yob8Kl+A4k+I8YSsDrSpa5/4AyBzZYNtjALc5xbgfKSOQR5KbGUo0JrgDpkgsnCHQ
         J3BtpF5E4+9HkyswDoIcZEpqJkENVDcR5n4hYsbsOTqXVh2UbE/FTMbzrydNSV2BJnFW
         nNyw==
X-Forwarded-Encrypted: i=1; AHgh+RqPoO55N7PN+bmevaVbGhoObeoPzNrcXGxkgipk2+3KVNK4x+ppYXRzJP5+Y68MijxHWtksMkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EimLjMp7006u5OBhVpLs1d3AboNSDG+504FdHppQm/hHQGfs
	4ojWYS50if+D/pfdfaQF6QefWkEuxSwLalsN89RWkYHGilh+L4485Dx6fr5B8BhOhWA0wocrkII
	OW4BJMLy5X4AcyoM0q6BttphkU0A0RHKPJtRYTwLg
X-Gm-Gg: AR+sD11BL4gW3zf2ePxni/W88jfnPZmRrZ/6ujXAyvZW//MnOlUy8UBUx7fPNqVlzZM
	bpwcACtcqbYP1okiTRieM5LVAQ503MpGG0Qh9KOl+7kZa519pJhQDQoeeWH06Zcnt+Bb8jbG9D3
	Kvz4iVsGchRGiXzPoFI3AOZ4E7OwcXlydC4Elu7VXUsraLkPZTuIh0lEfc+Bzap4vSgB5hswscm
	0jQ8IEy1Hf2rGz5VJfCfeFfx5NZDb9d/brFakS3q+x51nB7z9+ve/WvV8TroUt3PUaWHLpRpf0+
	T6OdU1rfGkbb/wjedtipiaMjhp1YhXXeuhOXiz5/IBA1hA==
X-Received: by 2002:a05:6a00:1250:b0:847:97a4:d6b3 with SMTP id
 d2e1a72fcca58-84f2e05124dmr17666312b3a.16.1786041579110; Thu, 06 Aug 2026
 11:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806101235.809370-1-hj351016@gmail.com>
In-Reply-To: <20260806101235.809370-1-hj351016@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 6 Aug 2026 14:39:28 -0400
X-Gm-Features: AUfX_mwGGPywD_1dowwU0s_efYIn1MurbHEiZqupPcf9R8cv8u4CnYQDZq14Uho
Message-ID: <CAM0EoMnj4egE+MnjgqzLxPzucbKnuOJFvEBkcrfSnREL=02tHA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net/sched: act_ct: fix sk_buff leak when the
 header checks reject a packet
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Tao Liu <taoliu828@163.com>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 6:12=E2=80=AFAM Hyunjung Ko <hj351016@gmail.com> wro=
te:
>
> tcf_ct_handle_fragments() runs its header sanity checks before handing
> anything to the defragmentation engine:
>
>         if (family =3D=3D NFPROTO_IPV4)
>                 err =3D tcf_ct_ipv4_is_fragment(skb, &frag);
>         else
>                 err =3D tcf_ct_ipv6_is_fragment(skb, &frag);
>         if (err || !frag)
>                 return err;
>
> tcf_ct_ipv4_is_fragment() returns -EINVAL or -ENOMEM;
> tcf_ct_ipv6_is_fragment() adds -EPROTO when ipv6_find_hdr() fails. None o=
f
> them frees or queues the skb, so on that path the caller still owns it.
>
> tcf_ct_act() however funnels every non-zero return into the
> ownership-transfer exit:
>
>         err =3D tcf_ct_handle_fragments(net, skb, family, p->zone, &defra=
g);
>         if (err)
>                 goto out_frag;
>         ...
> out_frag:
>         if (err !=3D -EINPROGRESS)
>                 tcf_action_inc_drop_qstats(&c->common);
>         return TC_ACT_CONSUMED;
>
> TC_ACT_CONSUMED means the action took ownership of the skb, so no caller
> frees it - sch_handle_ingress(), sch_handle_egress() and
> tcf_qevent_handle() all deliberately skip the free for that verdict. The
> skb is therefore orphaned: one sk_buff plus its data buffer is leaked per
> malformed packet, unbounded. Note the drop counter is already incremented
> for these errors, so the statistics claim a drop that never happens.
>
> Three different ownership states reach out_frag: today - the skb may be
> queued by the defrag engine (-EINPROGRESS), already freed by
> nf_ct_handle_fragments(), or still owned by us. Tell the caller which of
> those it is, and free the packet ourselves in the last case, which
> restores the TC_ACT_SHOT behaviour that predated the Fixes: commit.
>
> Reproduced on v7.2-rc6 with a 54-byte frame carrying a 40-byte IPv6
> header with nexthdr =3D 0 (hop-by-hop) and nothing after it, on a
> clsact ingress chain with "action ct". kmemleak reports one leaked
> 232-byte skbuff_head_cache object plus its 704-byte data buffer per
> packet; with this patch it reports none.
>
> Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo fr=
ags")
> Cc: stable@vger.kernel.org # v6.8+
> Assisted-by: Anthropic-Claude-Code:Claude-Opus-5
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

I actually have tested and reviewed this. So:

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  net/sched/act_ct.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> v2:
>  - add a tdc selftest (patch 2/2), as requested by Jamal
>  - add Assisted-by: tag
>  - no functional change to the fix itself
> v1: https://lore.kernel.org/netdev/20260805095539.204356-1-hj351016@gmail=
.com/
>
> Reproducer needs CONFIG_NET_ACT_CT, plus CONFIG_DEBUG_KMEMLEAK and
> kmemleak=3Don to observe it:
>
>   ip link add veth0 type veth peer name veth1
>   ip link set veth0 up; ip link set veth1 up
>   tc qdisc add dev veth0 clsact
>   tc filter add dev veth0 ingress matchall action ct
>
> then inject at veth1 a 54-byte frame: ethertype 0x86DD, a 40-byte IPv6
> header with nexthdr =3D 0 (hop-by-hop) and nothing after it, so
> ipv6_find_hdr() fails with -EBADMSG and tcf_ct_ipv6_is_fragment()
> returns -EPROTO.
>
> Before, one sk_buff plus its data buffer per packet:
>
>   kmemleak: 50 new suspected memory leaks
>   unreferenced object 0xffff888103ed13c0 (size 232):
>     kmem_cache_alloc_node_noprof+0x2f1/0x3e0
>     __alloc_skb+0xe5/0x860
>     alloc_skb_with_frags+0x82/0x750
>     sock_alloc_send_pskb+0x658/0x7e0
>     packet_sendmsg+0x1833/0x4860
>     __x64_sys_sendto+0xe0/0x1c0
>     do_syscall_64+0x102/0x5a0
>
> After: kmemleak reports no unreferenced objects.
>
> Note /proc/slabinfo is not a usable check here on a KASAN build -
> skbuff_head_cache active_objs still grows because the quarantine holds
> the freed objects. kmemleak is the reliable signal.
>
> Patch 2/2 turns the same case into a tdc test, using the clsact drop
> counter as the discriminator: before the fix act_ct returns
> TC_ACT_CONSUMED, so tc_run() never reaches its TC_ACT_SHOT arm and the
> counter stays at zero while the skbs leak.
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index be535a261fa0..e250969c84ac 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -840,8 +840,15 @@ static int tcf_ct_ipv6_is_fragment(struct sk_buff *s=
kb, bool *frag)
>         return 0;
>  }
>
> +/* On error, tells the caller whether it still owns @skb and must free i=
t
> + * itself.  @skb is ours only when the header checks below reject the pa=
cket
> + * before it is handed to the defragmentation engine; once nf_ct_handle_
> + * fragments() has been called the skb is either queued (-EINPROGRESS) o=
r has
> + * already been freed by it.
> + */
>  static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
> -                                  u8 family, u16 zone, bool *defrag)
> +                                  u8 family, u16 zone, bool *defrag,
> +                                  bool *skb_is_ours)
>  {
>         enum ip_conntrack_info ctinfo;
>         struct tc_skb_cb cb;
> @@ -859,8 +866,12 @@ static int tcf_ct_handle_fragments(struct net *net, =
struct sk_buff *skb,
>                 err =3D tcf_ct_ipv4_is_fragment(skb, &frag);
>         else
>                 err =3D tcf_ct_ipv6_is_fragment(skb, &frag);
> -       if (err || !frag)
> +       if (err) {
> +               *skb_is_ours =3D true;
>                 return err;
> +       }
> +       if (!frag)
> +               return 0;
>
>         cb =3D *tc_skb_cb(skb);
>         err =3D nf_ct_handle_fragments(net, skb, zone, family, &proto, &c=
b.mru);
> @@ -977,6 +988,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb,=
 const struct tc_action *a,
>         int nh_ofs, err, retval;
>         struct tcf_ct_params *p;
>         bool add_helper =3D false;
> +       bool skb_is_ours =3D false;
>         bool skip_add =3D false;
>         bool defrag =3D false;
>         struct nf_conn *ct;
> @@ -1012,9 +1024,18 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *s=
kb, const struct tc_action *a,
>          */
>         nh_ofs =3D skb_network_offset(skb);
>         skb_pull_rcsum(skb, nh_ofs);
> -       err =3D tcf_ct_handle_fragments(net, skb, family, p->zone, &defra=
g);
> -       if (err)
> +       err =3D tcf_ct_handle_fragments(net, skb, family, p->zone, &defra=
g,
> +                                     &skb_is_ours);
> +       if (err) {
> +               /* The skb is still ours only when the header checks reje=
cted
> +                * it; returning TC_ACT_CONSUMED for such a packet would =
leak
> +                * it, since no caller frees an skb it was told it no lon=
ger
> +                * owns.
> +                */
> +               if (skb_is_ours)
> +                       goto drop;
>                 goto out_frag;
> +       }
>
>         err =3D nf_ct_skb_network_trim(skb, family);
>         if (err)
> --
> 2.43.0
