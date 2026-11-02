Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636309;
	b=tveNQ+4pzvRu00LFNwSJ2y9Whx2Orv+iuElBofuooV6z/Dxp4GXGJI1J/TMpZG/AIojF
	 Oq76Af7rIY+zYgnZK2GzPJBnkzT0t4Jqq6EYBVbldAoec+4yx1jnII33m+ZrtLEY2fLQf
	 y1Jkprhphu1kmxYuIruZBqdIz8WOsvdFZnNVO5pZ67eClDB30Os/Hf/D2rLukeJY2yboZ
	 2SlBK73FXrL+Obqw9Pb9OZ9MEa8nt4klXN6Mgp6k7rvmhs3lVEXmY4d96IAEmg8Tc/xiI
	 uxVnmB42rPGhzuAePQqoUFD41kQyJ7uOONhfR9GVY2QYmbCWTJIX6/dsDxyY+Z1m71A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636309;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wxOeynVQGn57hjgx4QIPMlYidyQB2taD5lIeYYJfDTQ=;
	b=L4wYA0R/HJu/Brn57uVQmQ7HRQUGGNF/spyQgEj2wZtxZimZgQUQXX7xdGdwR617AnOO
	 xWVjLCg0mUh0J7rE8UcKYiA+2evuye5uJcSMBfAAguXLnjXaIkhi0/wsCzkkpFSe6Q8nQ
	 5jsjS5h0/TldIJPsF2Jrph2Z3jveYaz5h9tPqo4++hF01SmMFwFnQfNhnvQ1C7Gn46TPJ
	 ufTxO4vwPoHp0aljZFy9zeMmzzhH8B1K4BSRyxfpKdtoehFqLP93Sr6pbvsG8K7z0mgba
	 OXu5njEMVVoaIZ2vw4mhoSm75krptPPqj0ZvtwAvQlb/LW2quKQDIRDeLPexafJDlvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiwSV8pj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C360839A4
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiwSV8pj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBC01F00A1E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793636308;
	bh=wxOeynVQGn57hjgx4QIPMlYidyQB2taD5lIeYYJfDTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aiwSV8pjhOneh7pWpESM/lFliOIOPcx151UCGMgOzMErMnbavonl7IMSgCM2yXhz9
	 aEd3r7y2Bm36cQqGmFjg2N576eNALcMFMOR2W/qDRvODCYd5fB9ioLgHreJ+h7GKTA
	 eViiqXmxFJsNdRQMD8QO25Od+6eflrTPzMkaJJslkCtlt8Lm1EI3dP5hTjNc6C9n80
	 3FZIRYQq+uiYkfwfS3piTI//fIeNHPIm1EL7E+Ti5tnnnECi2warS99oi7zETX4Gg9
	 Qk4FAUhzIGzzya+u6gE9EOwzGlx9Wk77uMjC5Xp3rfdDMvQot2hIgRKFYJH/Vc63m0
	 NKnKr9CBX/SkA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-7143451981fso2309063eaf.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:18:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwB00DpyEMozHxAn2LLHIbSMJe5OxBh4xBT3h2Z8Q5jf1V/CxAa/oglfceKQg3uGiDJ/bqvHFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5aSQLfzriLQREZD8kHM/wQYOXGg3dP4A265Hic7bfct1mKh9b
	ZohPBe3OoXYONNGXDZaGt7KrPnmRQAseH/SAEVh7FuOrl2JgqckIO+gh2jgcI9GEHt6NJ2anFqj
	r6/6AiTot5nv3iz6qo2tmTVSIUY7ur48=
X-Received: by 2002:a05:6820:a501:10b0:6de:1457:fe27 with SMTP id
 006d021491bc7-714f29da022mr3867489eaf.57.1793636307818; Mon, 02 Nov 2026
 08:18:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030125955.3107383-3-edumazet@kernel.org> <179362441613.3131.6007536857643093308@kernel.org>
In-Reply-To: <179362441613.3131.6007536857643093308@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 2 Nov 2026 17:18:07 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiof_AXXF1q8irJVMnqWDcZeZKtghO1V+37=_PX8gGk4_A@mail.gmail.com>
X-Gm-Features: AclHuK-B5hrIDoR7c2h8vnwMbz91vdcjzng1h19upT3oyDEMHA8Uei__0DsgavE
Message-ID: <CAL4Wiiof_AXXF1q8irJVMnqWDcZeZKtghO1V+37=_PX8gGk4_A@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: gro: invalidate frag0 after a pull
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, willemb@google.com, steffen.klassert@secunet.com, 
	tom@herbertland.com, cenzhang@linux.microsoft.com, 
	AutonomousCodeSecurity@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 14:00, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] net: gro: packet corruption in gro_pull_from_frag0() after
>   failed pull
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>   `napi_gro_frags()` (net/core/gro.c:783-794) never checks the result of=
=E2=80=A6
>
> --
>
> net: gro: invalidate frag0 after a pull
>
> This patch adds skb_gro_frag0_invalidate(), which clears
> NAPI_GRO_CB(skb)->frag0_len. It is called before the slow pulls in
> skb_gro_header_slow(), skb_gro_receive_list(), esp4_gro_receive(),
> esp6_gro_receive() and udp_gro_receive_segment(). This keeps later GRO
> header accesses from using a frag0 pointer that the pull may have
> released or reallocated.
>
> > diff --git a/include/net/gro.h b/include/net/gro.h
> > index 00b49b6b9e74f..6f6affc8ab91c 100644
> > --- a/include/net/gro.h
> > +++ b/include/net/gro.h
> > @@ -160,9 +160,19 @@ static inline bool skb_gro_may_pull(const struct s=
k_buff *skb,
> >       return likely(hlen <=3D NAPI_GRO_CB(skb)->frag0_len);
> >  }
> >
> > +/* A pull can release the page fragment frag0 points to, or reallocate
> > + * skb->head, even if it fails. Call this before the pull, to make sur=
e later
> > + * skb_gro_header() and skb_gro_network_header() calls no longer use f=
rag0.
> > + */
> > +static inline void skb_gro_frag0_invalidate(struct sk_buff *skb)
> > +{
> > +     NAPI_GRO_CB(skb)->frag0_len =3D 0;
> > +}
> > +
> >  static inline void *skb_gro_header_slow(struct sk_buff *skb, unsigned =
int hlen,
> >                                       unsigned int offset)
> >  {
> > +     skb_gro_frag0_invalidate(skb);
> >       if (!pskb_may_pull(skb, hlen))
> >               return NULL;
>
> [Severity: High]
> Does clearing frag0_len here, while frag0 itself is left pointing at
> the old location, break gro_pull_from_frag0() when the slow pull in
> skb_gro_header_slow() fails?
>
> Consider an skb that enters GRO with skb_headlen(skb) =3D=3D 0. In that
> case skb_gro_reset_offset() points frag0 at the start of frags[0],
> which is packet offset 0.
>
> Now add remote checksum offload nopartial: vxlan_gro_receive() or
> vxlan_gpe_gro_receive() with VXLAN_F_REMCSUM_NOPARTIAL, or
> gue_gro_receive() with FOU_F_REMCSUM_NOPARTIAL. There,
> skb_gro_remcsum_process() records grc->offset and grc->delta through
> the frag0 fast path. The inner eth_gro_receive() and
> inet_gro_receive()/ipv6_gro_receive() handlers then advance
> skb_gro_offset() through frag0 too, so skb_headlen() is still 0.
>
> Suppose the next inner header does not fit in frag0_len, for instance
> in tcp_gro_pull_header() or udp_gro_udphdr(). skb_gro_header_slow()
> now sets frag0_len to 0 and calls pskb_may_pull(). On a truncated
> packet where hlen > skb->len, this fails without pulling anything.
> That leaves skb_headlen() at 0 and frag0_len at 0.
>
> On the way out, skb_gro_flush_final_remcsum() calls
> skb_gro_remcsum_cleanup(), which does:
>
>         ptr =3D skb_gro_header(skb, plen, grc->offset);
>
> Before this patch that was served from frag0. Now skb_gro_may_pull()
> fails, and pskb_may_pull(skb, plen) really copies plen bytes into the
> linear area. Here plen =3D grc->offset + sizeof(u16), which is below
> skb_gro_offset(skb) once the inner headers were pulled. frags[0] is
> advanced by plen, but NAPI_GRO_CB(skb)->frag0 still points at packet
> offset 0.
>
> Since the skb is flushed, dev_gro_receive() ends up in
> gro_try_pull_from_frag0(). That computes
> grow =3D skb_gro_offset(skb) - skb_headlen(skb) > 0 and calls
> gro_pull_from_frag0():
>
>         memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);

Right, this was added in v2 when moving the invalidation before the
pull. After a failed pull, skb_gro_remcsum_cleanup() can pull fewer
bytes than skb_gro_offset(), while frag0 still points to the start
of the packet.

>
> This copies packet bytes 0..grow to skb->data + plen, then advances
> frags[0] by grow again. The skb handed up the stack as GRO_NORMAL
> has its inner headers overwritten with outer header bytes, and the
> real bytes at plen..skb_gro_offset() are lost. A remote sender can
> trigger this with a short encapsulated packet.
>
> gro_pull_from_frag0() assumes frag0 is the current start of frags[0],
> which only holds while skb_headlen() is 0. Should it copy from
> skb_frag_address(&pinfo->frags[0]) instead? Or should
> skb_gro_remcsum_cleanup() and gro_try_pull_from_frag0() handle a
> partially linearized skb in some other way?
>
> [Severity: High]
> This patch didn't introduce this, but since the failure path of
> skb_gro_header_slow() is being changed here: what happens in
> napi_gro_frags() when this pull fails for the Ethernet header?
>
> In net/core/gro.c, napi_frags_skb() takes the slow path and returns
> NULL when the pull fails:
>
> net/core/gro.c:napi_frags_skb() {
>     ...
>         if (unlikely(!skb_gro_may_pull(skb, hlen))) {
>                 eth =3D skb_gro_header_slow(skb, hlen, 0);
>                 if (unlikely(!eth)) {
>                         net_warn_ratelimited("%s: dropping impossible skb=
 from %s\n",
>                                              __func__, napi->dev->name);
>                         napi_reuse_skb(napi, skb);
>                         return NULL;
>     ...
> }
>
> The caller doesn't check for NULL, though:
>
> net/core/gro.c:napi_gro_frags() {
>         struct sk_buff *skb =3D napi_frags_skb(napi);
>
>         trace_napi_gro_frags_entry(skb);
>
>         ret =3D napi_frags_finish(napi, skb, dev_gro_receive(&napi->gro, =
skb));
>     ...
> }
>
> dev_gro_receive() starts with skb_get_hash_raw(skb) and then reads
> skb->protocol. Can this be a NULL pointer dereference in NAPI softirq
> context? One way to reach it would be skb->len < ETH_HLEN, where
> pskb_may_pull() fails with PKT_TOO_SMALL. Another would be
> __pskb_pull_tail() returning NULL.
>
> napi_gro_frags() used to have an "if (!skb) return GRO_DROP;" check.
> Commit 1d11fa696733 ("net-gro: remove GRO_DROP") removed it on the
> grounds that NULL could only come from a failed napi_get_frags()
> allocation. That reasoning doesn't cover the header pull failure return
> shown above.
>
> The drivers checked so far (tun, r8152, e1000) all enforce a minimum
> frame length before calling napi_gro_frags(). The other callers have
> not been checked.
>
> Should napi_gro_frags() check for a NULL skb again?

I do not think this can happen.

napi_get_frags() allocates the skb with GRO_MAX_HEAD bytes of
tailroom, and these skbs have no frag_list, so __pskb_pull_tail()
can not fail when pulling ETH_HLEN bytes.

pskb_may_pull() can only fail if skb->len < ETH_HLEN, meaning the
driver passed a frame shorter than an Ethernet header, which drivers
must not do. tun, where the length comes from user space, checks it
in tun_get_user().

This is why napi_frags_skb() calls it an "impossible skb". This
could be cleaned up in net-next, but is not a stable fix.

pw-bot: cr
