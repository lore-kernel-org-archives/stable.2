Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8733655FD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974348; cv=pass; b=RjQsw4EKwmp2AseEY5rbcQ5KaHCy+fnT9BBoqQXcHvUqMVlkZKSEbS2H8Xu50f01NZaoIoVoT6w7rgr0tL/q2fWzXRJ1CtOdUA9Xg4Y/Ic8IsjAn+psKL+KAHJBK9GHRr+e5mBNPqqr4Ox5M81ykhXCOcJqJTSiwf0EpNUkgO1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974348; c=relaxed/simple;
	bh=BQ+Hst8gOUWR37L4XOKGfAUQBTOzIL1QvKMGUdQMdVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwovhHnI8BiZlaGOJ9tJlGMPcySjnZDdC2AP/+x/45c+CaUX5p96L0vJvIhFxdLnJzBPLl/Ti+S3TwSFSKSl4l8VrPprPp73PSYUoxKjIZO2CdarHnMb000jz1ZplbfD9As8fVJal9pPlOQDxponlyXFxvDie+eOxCRovde0KS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=z5hGrFdL; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="z5hGrFdL"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201f9so693426d50.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 10:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788974345; cv=none;
        d=google.com; s=arc-20260327;
        b=LmL0Lj6jKnkFS2cdKrpyQROxD7sNzJAIw2YeHAHaUx8wiX3jz/fPEDJOhMZAsCy0CD
         DEAYF7ptPaVSfYHErG5kQTsux1O178bswpabDAyIBlh3A0H2niyR5Nbp1cWK4YvQ/Bz5
         TUPIdyLLK+IEbVnRnOaRrUkOUPDyjhoFb83flI8ZnbBidganmnCraDkR0spXufPEumVO
         K1hWihcc8TjrJZE+nmw21c5lazO4E6w2eOUOtOuqHwBxJdDfK89UY+kJlrHcOFI7onV+
         q5k5PgCq+kICBaf+3CkQFlUYgMMoKxp54IBIuBwaQMGvw8UupDM/Y44BMeDt4fEQvfge
         WEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6E68RRU9n5lqapFJ2+/cJtqMKWFxDFCie3V1FAMd+4g=;
        fh=P2heMdopN8zoR8qk4NCiHTiG6aaRDuCe7nlTMAiRE4k=;
        b=QnKQ88DTEl6vnKUmItkCxY+xTX9hBSdMe35aicswRaAx9+IBOPAGKu4PUnokxvEEsL
         GvqgzIZRq6wAwd7tA6J3Z/qZ23ubcTblQFedPDKdfGV5uArGQnnxWZhg4Z7qfB0Vw28U
         g5AKPPMDg+ekVB41IONg+YDVGO0Z+pnVh+1GINsgLoCiqeLgZAaiT7GxoyYu7P0o4673
         LClnITYxI2NzezlQINCvHSRxOJGY571yeT6A7QsdAha3KWzVQU0scztZX7mkLprWtn4c
         QBXr8ujxS4nTEa3RDN6UpcIzVpy8zTkwPwDqK0RzM3+eVulZXFmdh3vRTykLLMshh355
         bpCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788974345; x=1789579145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6E68RRU9n5lqapFJ2+/cJtqMKWFxDFCie3V1FAMd+4g=;
        b=z5hGrFdLgDm+Rboba1delLX9FtBlGxiqFqtudICHSpjiuW5vLNEDkDrgXRLUm1PXXg
         kLmD2HNMODCvIVFA8LA/2qGCV2uYXs85B0YZxMcn6U6pToLCx6fw6XKfnjI1NT62uQ9m
         NQcfRaQvAnUtYKnCqle6DedFs4YvKDjGIKJlYdRZJedWgD/D8g37YzjaVGuuvzohaFXp
         9pMU6JoGGgOux4/Fadq7gM+tY8ttdQWnQGyPgBzhHyccVOkEMqNJkVOsQdUqxszwPgoX
         PRv9sM321iDCHK5aydwxCllwGLdEq57cHpyBW70GVCfH2jzsP1wpZLE0afTHdNvqgtv6
         LLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974345; x=1789579145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6E68RRU9n5lqapFJ2+/cJtqMKWFxDFCie3V1FAMd+4g=;
        b=ltAo9egfadxO9wNMskCLz2SvgGZUqTGx9IgFG6buNnTyzC78Ptmopmv3QwZfqV+gMc
         ORmOmAftKJ+PmjeG9BtNXcc7L9i1Hv6VVq7O4Y/1Ya4n9PvDcE+ysVH/a5tA6uFsxXXs
         F51zy+Xj0MEjHFzYxJH8BPvp7Bm+YLiPup5tCaL784SaZkpd1gz8PkF8PW7USlv9m/EX
         yvk3mLmxJX57uot4cms0+ekwZB3GVUAL09pTtDmG2fH6ISpu0q1OlMKgSJFxlhuNGY4Z
         0gxILiEkkk6hrpmNmQCLX62P0tm1w8Qd2i+OZhyRwR7fjn7qciduW8GiOhx+lD+mq2RH
         /QUw==
X-Forwarded-Encrypted: i=1; AKwUvBx9Oo5zeAOKW1GTVDdSD2f232/2xVfCs8l25wWOrN+680O5ZzwS83CpDfRcQWm+q09BaOW33T0=@vger.kernel.org
X-Gm-Message-State: AFuF++kK1wq3U3llAeOr3SXNGyF9Ok5/9KvQf50oNuV0uA/O5jZQAu95
	dMYIRE3j1dVbs/zReqvrG4B3jyAEPLtFXx6cJ6tKiFbvqMzUt0nqGAJDC3IDhY6BA9Wi0FESZnw
	RgrGBZFLiu2A5wQbNJ81IvLSLMDUZ9RMbYBL92J0HbQ==
X-Gm-Gg: AYBFou2vg+se9yNla9yFpkgOOGiNYqSYFxDgAyYlOtZhxa6j3ccs2trI7hGIC0APc9D
	iORylfB6/pN9IrF9UVZ8vf7boX/ldC1Ju7TY3RATBhHUPf8/y9MabniS/aefiqY7N6rKzprzv4t
	YLx7f4ZWR8t0oXOJkI3dSCS5eZWSH8kGEcmdjcuZ2eaVGM3Es0FUwsUS52xtyg1R+fZxzX2R+4p
	F0qpNIVPhTgRJUmD8cPl7jprQadEIUbzzdA+DhF5nRKPlYwjh1XodV2CSjvwhA+6l40tbS+znkR
	vKTN7Pc8XcdzFG1YKxI6RTawvxzPs3UWS9TH1IGsQeOwfnZHORVbyWc=
X-Received: by 2002:a05:690e:1407:b0:66f:c284:4806 with SMTP id
 956f58d0204a3-67110027d40mr1411230d50.66.1788974344494; Wed, 09 Sep 2026
 10:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
In-Reply-To: <20260909024011.1252694-1-nikhilljatt@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Wed, 9 Sep 2026 13:18:52 -0400
X-Gm-Features: AcwNN1U4pDVgjWmRTrx7PuoPtmF0Fx_Otlis6cGINQ1Y-tUySGzn4ekMF7-3TDY
Message-ID: <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
To: Nikhil <nikhilljatt@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, horms@kernel.org, dsahern@gmail.com, hawk@kernel.org, 
	razor@blackwall.org, stable@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:40=E2=80=AFPM Nikhil <nikhilljatt@gmail.com> wrot=
e:
>
> bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() copy the neighbour's
> link layer address into params->dmac without any synchronisation, but
> neigh_update() writes neigh->ha under write_seqlock(&neigh->ha_lock)
> exactly because there are lockless readers.  A BPF program calling
> bpf_fib_lookup() while the neighbour is being updated can therefore be
> handed a torn address, and XDP/tc then forwards the packet to a bogus
> L2 destination.
>
> neigh_ha_snapshot() cannot be used here because it copies dev->addr_len
> bytes while params->dmac is only ETH_ALEN long (an IPoIB egress device
> has addr_len 20 and would overflow into params->smac), so open-code the
> seqlock loop around the ETH_ALEN copy.
>
> Same problem and same fix as commit 57549ab90791 ("net: bridge: arp/nd
> proxy: fix reading neigh ha") and commit b824059a673b ("vxlan: fix
> reading neigh ha").
>
> Reproduced on x86_64 under qemu: a dummy device holds a permanent
> neighbour whose lladdr is flipped between aa:aa:aa:aa:aa:aa and
> bb:bb:bb:bb:bb:bb with RTM_NEWNEIGH, while an XDP program driven by
> BPF_PROG_TEST_RUN calls bpf_fib_lookup() in a loop and checks that all
> six bytes of the returned dmac are equal.  Before this patch: 211 torn
> addresses out of 16300000 lookups (last one aa:aa:aa:aa:bb:bb).  After
> this patch: 0 out of 38060000 lookups.
>
> Fixes: 87f5fc7e48dd ("bpf: Provide helper to do forwarding lookups in ker=
nel FIB table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikhil <nikhilljatt@gmail.com>
> ---

Bot is right wrt possible lockups, please adjust the seqlock
accordingly. Also please
add your full name in the SOB.

pw-bot: cr

>  net/core/filter.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e753552..6fdb85c9af44 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6298,6 +6298,20 @@ static const struct bpf_func_proto bpf_skb_get_xfr=
m_state_proto =3D {
>  #endif
>
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> +/* Take a stable snapshot of the neighbour's link layer address.
> + * neigh_ha_snapshot() can not be used here because it copies dev->addr_=
len
> + * bytes while params->dmac is only ETH_ALEN long.
> + */
> +static void bpf_fib_dmac_snapshot(u8 *dmac, const struct neighbour *neig=
h)
> +{
> +       unsigned int seq;
> +
> +       do {
> +               seq =3D read_seqbegin(&neigh->ha_lock);
> +               memcpy(dmac, neigh->ha, ETH_ALEN);
> +       } while (read_seqretry(&neigh->ha_lock, seq));
> +}
> +
>  static int bpf_fib_set_fwd_params(struct net_device *dev,
>                                   struct bpf_fib_lookup *params,
>                                   u32 flags, u32 mtu, u32 in_ifindex)
> @@ -6491,7 +6505,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, str=
uct bpf_fib_lookup *params,
>
>         if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>                 return BPF_FIB_LKUP_RET_NO_NEIGH;
> -       memcpy(params->dmac, neigh->ha, ETH_ALEN);
> +       bpf_fib_dmac_snapshot(params->dmac, neigh);
>         memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>
>  set_fwd_params:
> @@ -6644,7 +6658,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, str=
uct bpf_fib_lookup *params,
>         neigh =3D __ipv6_neigh_lookup_noref(dev, dst);
>         if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>                 return BPF_FIB_LKUP_RET_NO_NEIGH;
> -       memcpy(params->dmac, neigh->ha, ETH_ALEN);
> +       bpf_fib_dmac_snapshot(params->dmac, neigh);
>         memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>
>  set_fwd_params:
> --
> 2.43.0
>
>
