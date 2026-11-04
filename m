Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804993;
	b=KW5y9Vmf9PcDVa0i6LJvGYbtk8OjiTvnnDj0hFV/J4UTa6h+VTw8OFQtGSeIkdhdR0it
	 bTXW8LqjgF5pVIfy5eNQ9g7CiQpCZV5hml5H1X/zOdyS9Gt1WevUk2Z0Pl0v8FFNPWAwu
	 Ip//l1aRxxFnSKTCDiTJIrvNTVZYXl/JCY04CJpOkVF+01JJsP7Rcue0jProkVaaF6fBM
	 wGAVE0ktqKv4a/oYdtCIeGfgvo0/XYxo7Ox4De9iRVzplZJBUHRX+ZstEmXHNSYxZ9Y6t
	 9D8NmiBYfyWLQ4Zo3FQ7LTKRJ9xZmajUmkr+pXXKTvBLSchYDxI1Rhn4enCcRLDxbmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804993;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cFsxHXe85/v7h5RQTtycXAo9hnX3kcBe7fUXrj2gfx4=;
	b=VI9rGyoKgNyUViSMqrDGTIWpr26eE65hs5uHzP/72GAJC6d3KkqALeyFZoLKJispWdKj
	 D+ZtVTQ6N7AOvwULoYnNPlzp8IOqIU5fqPjHgHYLijNTxRL2+EaRXV3g6QtO/keqxh24r
	 DfoqIyqQayulFSVIi+e0rH72on7GxGQu4CVE/TKo0pRLLNd/X9iVU6r+CnVmx4qZ6UFjv
	 r8DU4NeAlLMnslz51pLTUQIsV3EMuVQ+4+qhnQQO+x8UwNfarn582TWTNxzIinRrphMg/
	 SJnQ6k7TuOtMQ5RuGZIYs/ikbI0SYJyWRjo+Rn1vjBuM2YwrCqVPK3SPmQv13p0Lp0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CT/S8IUC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48091606A32F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT/S8IUC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8301F00A1B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804993;
	bh=cFsxHXe85/v7h5RQTtycXAo9hnX3kcBe7fUXrj2gfx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CT/S8IUCOkBY2NJcAxLyGod9YTW2hzzz+a+XsaeLCkjRMnsTUCq+ZI/0DzM9h7/W0
	 O4vMs+JUc0MdoyNyyoPrIAdaILKuaiImrcuxQigF3MBjJ7se3qAdBLB+PohxzqDIeT
	 wUSZIMkTeWWcqacD7Rq5/2U4cx2UO35IA9a0b9EwnJ5/esR0IiJHrRy/IoxF3Vhaw0
	 eCr/f2uvDN7Kgw/DLkdwDX/OSibWcv9Dp5BZBrKO2+9k+sUVV3S/M9XYCUfRRyg63m
	 MC7S45DZmHgFTJA9JPBiH29470EDaFJ5zkGxwoUt+RtcfcHZEjLGVUcIVnF5rK9ww3
	 sprAL96kEZsOg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-48ed188ee81so495980fac.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:09:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy3L3EW6zT2phq4qQLOC+vxJTaGiGYbykW3E4mM8YWUGo1c83vww6Z0NjYXQclCpdtR2d6bXD8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Xcg+ufW4EHE4dqrn1L2oH8/toCzqOeeSRzffJxXcsBPJLLbl1
	4mAI8zPMFk1temDKKvDvCUx2pKWSccDck/iWNxDmzGdbNzrR4uS0VZgGTESgHUCwPpcqSSRaXBL
	M2RdJw3V0VDWyW0x+F5qgxYcIJW9XrG8=
X-Received: by 2002:a05:6870:f113:b0:491:a2d5:ab31 with SMTP id
 586e51a60fabf-4a90764ca5fmr10771021fac.12.1793804992258; Wed, 04 Nov 2026
 07:09:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103105752.49542-3-edumazet@kernel.org> <179380083773.488856.10057167003627471575@kernel.org>
In-Reply-To: <179380083773.488856.10057167003627471575@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 16:09:40 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqwUhcLVvkcLzDcyUUvEvqffFBWLiwb760iuo+fuJ4vyQ@mail.gmail.com>
X-Gm-Features: AclHuK8skOyT40Y0SuONlcxb2OlQdL3nuEJPupGI6O1KWHIXg1XphjooR5KpWV4
Message-ID: <CAL4WiiqwUhcLVvkcLzDcyUUvEvqffFBWLiwb760iuo+fuJ4vyQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net: gro: invalidate frag0 after a pull
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, willemb@google.com, steffen.klassert@secunet.com, 
	tom@herbertland.com, cenzhang@linux.microsoft.com, 
	AutonomousCodeSecurity@microsoft.com, stable@vger.kernel.org, 
	tsgatesv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 15:00, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch adds a fallback in gro_try_pull_from_frag0()
>   (net/core/gro.c:465): when frag0_len is 0 it calls `pskb_may_pull(skb,=
=E2=80=A6
>
> --
>
> net: gro: invalidate frag0 after a pull
>
> This patch adds skb_gro_frag0_invalidate(), which clears
> NAPI_GRO_CB(skb)->frag0_len. It is called before the pulls in
> skb_gro_header_slow(), skb_gro_receive_list(), udp_gro_receive_segment(),
> esp4_gro_receive() and esp6_gro_receive(). It also changes
> gro_try_pull_from_frag0() so it copies from frag0 only while frag0_len is
> not zero, and falls back to pskb_may_pull() otherwise.
>
> > diff --git a/net/core/gro.c b/net/core/gro.c
> > index 1b033855a20db..49e7f64f27756 100644
> > --- a/net/core/gro.c
> > +++ b/net/core/gro.c
>
> [ ... ]
>
> > @@ -454,8 +455,14 @@ static void gro_try_pull_from_frag0(struct sk_buff=
 *skb)
> >  {
> >       int grow =3D skb_gro_offset(skb) - skb_headlen(skb);
> >
> > -     if (grow > 0)
> > +     if (grow <=3D 0)
> > +             return;
> > +
> > +     /* frag0 can only be used if no pull happened. */
> > +     if (likely(NAPI_GRO_CB(skb)->frag0_len))
> >               gro_pull_from_frag0(skb, grow);
> > +     else
> > +             pskb_may_pull(skb, skb_gro_offset(skb));
> >  }
>
> [Severity: Medium]
>
> Is it safe to ignore the return value of pskb_may_pull() here?
>
> gro_try_pull_from_frag0() still returns void. Before calling it,
> dev_gro_receive() has already incremented gro_list->count (or called
> gro_flush_oldest()). After it returns, the skb is held unconditionally:
>
> net/core/gro.c:dev_gro_receive() {
>     ...
>         if (unlikely(gro_list->count >=3D MAX_GRO_SKBS))
>                 gro_flush_oldest(gro, &gro_list->list);
>         else
>                 gro_list->count++;
>
>         /* Must be called before setting NAPI_GRO_CB(skb)->{age|last} */
>         gro_try_pull_from_frag0(skb);
>         ...
>         list_add(&skb->list, &gro_list->list);
>         ret =3D GRO_HELD;
>     ...
> }
>
> Before this patch, gro_pull_from_frag0() was the only thing done here,
> and it could not fail because frag0_len is bounded by the tailroom.
>
> One way to reach this point with frag0_len =3D=3D 0 is through
> esp4_gro_receive() and esp6_gro_receive(). With this patch they do:
>
>         skb_gro_frag0_invalidate(skb);
>         if (!pskb_pull(skb, offset))
>                 return NULL;
>
> This returns without setting NAPI_GRO_CB(skb)->flush. For an ordinary
> unfragmented IPv4 packet, inet_gro_receive() computes flush as 0, so
> dev_gro_receive() takes the GRO_HELD path.
>
> offset =3D=3D skb_gro_offset(skb), so the retry in gro_try_pull_from_frag=
0()
> is the same pull that just failed.
>
> If the held skb's linear area does not reach skb_gro_offset(), later
> packets in the same bucket would read stale tailroom bytes as headers:
>
> net/ipv4/af_inet.c:inet_gro_receive() {
>     ...
>                 iph2 =3D (struct iphdr *)(p->data + off);
>     ...
> }
>
> The same applies to ipv6_gro_receive(), udp_gro_receive() and the
> tcp_hdr(p)/udp_hdr(p) lookups.
>
> If one of these bogus headers matches and a merge happens,
> inet_gro_complete() writes tot_len and check through skb->data + nhoff.
> Those writes would go into tailroom rather than the real header, and the
> aggregated packet would keep its original single-segment tot_len.
>
> The window looks narrow. The retry can only fail for an skb that entered
> GRO with headlen =3D=3D 0 and frags[0] mapped as frag0, and that skb must
> also be either:
>
>   - cloned, with pskb_expand_head(..., GFP_ATOMIC) failing, or
>   - carrying unreadable frags while frags[0] is a normal page.
>
> No concrete in-tree source of such skbs has been identified, but they
> don't look impossible either.
>
> Could gro_try_pull_from_frag0() return a bool? On failure,
> dev_gro_receive() could undo the count change and take the normal path
> instead of holding the skb.

Yes. In v4, gro_try_pull_from_frag0() returns false if the pull fails.
dev_gro_receive() calls it before changing gro_list->count, and takes
the normal path instead of holding the skb.
