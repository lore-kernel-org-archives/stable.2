Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804961;
	b=kgfYOzKuYu4lip6EyeJtEXULW06KLMCefy2+mGIU+9hw95jKCaqoVNJkfGfubMS8rp9Y
	 uD1F5O42IBjIh4tiAozKe5sGY/ShYl4HLAsNUDmN+LIyX9X/33gms/+YAXQMAMk9n81RI
	 Pci86qgm0DKw3yHtjUzdoWs4Ujd3SdROYhb7/mmPvV8UdmzsTsmwlDcb7ePlaukafKvyv
	 amnlaV2TxFZUrp+owLxTEWyxC/kcBMVT4/hkMdiohzq5u4yUHg9Ot0fagYZeDH8A+Km0K
	 X7wwnvKt38sITyMYY5BiRDa513Qp0n5+lzoemLrG4O/PSJ+RrCcnZ4q+MUJ79gQH/Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804961;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PZ9W5jMyXKX3yUIRHeeF4bKkSid+UAfYqLNNsUE71VU=;
	b=EPvnWCOT1Hfd7qSPGHv+x+E3NJDa+qiJn5D1tHCvBiWf37sQk5oYCTfYEVVTjeac67hq
	 bji1s8TaLoye3vdowsnuUZKc40RLqljD/GI3oje83FFdJr+tdnj9T3UZ8H7t1xxctiRhr
	 o0fyZ8fCG3uiN470qhTtwJyabBDMS/B8Q3EpwNWO8v5egQEyUnNp+j91qUVr7h5fXtEoj
	 XQwGg1aXM9lXIjn3HlY4wg26uNqN8IQU0NCQI9oRsb+nC+4/Gbae/9F6DuHhji24aP5L5
	 HY4KKiJlCEIUS70oPy0anHsGut6v14/HF73XjlBYNAnPYEjC9TcacMmyWL2IsB12DVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZJ9Vj+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C3606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZJ9Vj+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB531F0093A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804961;
	bh=PZ9W5jMyXKX3yUIRHeeF4bKkSid+UAfYqLNNsUE71VU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jZJ9Vj+EUsOKcs5AaAMaejgBs1wmEyEZhvVFxEM2EXkz/sOghQPbZX1fgLOpKb+wv
	 cw2W4vj/g2HmZRwZrnoyy/YZmEeJ8pLFNfXJ9763YjnorHl3/smo8LkyoX5gSNvg5p
	 LwmJjNaFHtDUFcus+sw/NWLAazQ0TQUywmfZcJHSUYlrSBtgBDETxjAuZZoc3PbXTG
	 6FnY3d4qbcUjXNRQTRLh+DPWoJcpf4H5Q0FAhxNBsa+3nmJq2O4qrF5a3HmQXcr75l
	 sb4OsmlZeQmrKEhbaiYl1bkg78K2vnXSkLNpVr/PaB7mgxzLSX/ZohBORDEn7XjO2x
	 SU5yUk+vbLEHA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4ad4072943dso235100fac.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:09:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxIf8IegZzl1olznTFosmsrK21ZTX5lAmiAmrlEfo2KcBNDgnx6Lgh1bdXsd8rhKbaBM1DHCKM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IGTZtqXyHMWLNMQpIqH2Isk0RumPxHl2j7S3vkPEYpPFvQNWB
	YQ4tEVSIyl5K67CaIYu2lN3+efaR/WlTFFAUALRcF3umLuYO7NQesCzkKcO1hXDNY59QtPFOjoO
	lk81cdWpHVu0lPhphacSlnelWWTrAQMI=
X-Received: by 2002:a05:6870:c0d0:b0:449:bccf:bb6e with SMTP id
 586e51a60fabf-4a9072eed47mr9411537fac.7.1793804960254; Wed, 04 Nov 2026
 07:09:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103105752.49542-2-edumazet@kernel.org> <179380083642.488856.12336059973220391773@kernel.org>
In-Reply-To: <179380083642.488856.12336059973220391773@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 16:09:08 +0100
X-Gmail-Original-Message-ID: <CAL4WiipYthA7wwfuk4xU0OQaW5No11XXRG5HwFxNeMfMnA8ucQ@mail.gmail.com>
X-Gm-Features: AclHuK98ebxXGkgNQALWUk96fG91psaFgnvdDfUzdKl-qYDRdANoT3i1s2uQNko
Message-ID: <CAL4WiipYthA7wwfuk4xU0OQaW5No11XXRG5HwFxNeMfMnA8ucQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: gro: do not undo remote checksum offload
 on merged packets
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
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] For VXLAN, the new fraglist branch in skb_gro_remcsum_cleanup()
>   (include/net/gro.h) breaks inner checksums when the VXLAN packet is=E2=
=80=A6
>
> --
>
> net: gro: do not undo remote checksum offload on merged packets
>
> This patch changes skb_gro_remcsum_cleanup() so it no longer undoes the
> remote checksum adjustment on packets that GRO merged. Fraglist members
> are the exception: their original inner checksum is restored in the
> headers pulled by skb_gro_receive_list(). The goal is to avoid stray
> writes into payload, or into a freed frag0 page.
>
> > diff --git a/include/net/gro.h b/include/net/gro.h
> > index 2300b6da05b27..13a8ef217a1d7 100644
> > --- a/include/net/gro.h
> > +++ b/include/net/gro.h
> > @@ -354,6 +354,23 @@ static inline void skb_gro_remcsum_cleanup(struct =
sk_buff *skb,
> >       if (!grc->delta)
> >               return;
> >
> > +     if (NAPI_GRO_CB(skb)->same_flow) {
> > +             /* skb_segment_list() keeps the inner headers of fraglist
> > +              * members: restore their checksum. skb_gro_receive_list(=
)
> > +              * pulled these headers, then moved skb->data past them.
> > +              * A valid remote checksum offset points to the inner
> > +              * transport header, which is part of these headers.
> > +              * Headers of other merged skbs are not used anymore.
> > +              */
> > +             if (NAPI_GRO_CB(skb)->is_flist &&
> > +                 grc->offset + sizeof(u16) <=3D skb_gro_offset(skb))
> > +                     remcsum_unadjust((__sum16 *)(skb->data -
> > +                                                  skb_gro_offset(skb) =
+
> > +                                                  grc->offset),
> > +                                      grc->delta);
>
> [Severity: High]
> Restoring the sender's checksum on fraglist members is correct when the
> outer VXLAN packet is forwarded unchanged. Is it also correct when the
> packet is decapsulated locally by VXLAN?
>
> The VXLAN socket accepts fraglist GSO packets:
>
> drivers/net/vxlan/vxlan_core.c:vxlan_create_sock() {
>     ...
>         udp_allow_gso(sock->sk);
>         return sock->sk;
> }
>
> Because of this, udp_unexpected_gso() returns false for the
> UDP_TUNNEL|FRAGLIST|TCPV4 aggregate. udp_queue_rcv_skb() then passes the
> whole aggregate to vxlan_rcv() without segmenting it.
>
> The decap side then adjusts the checksum only once, through a pointer
> into the head skb's linear data:
>
> drivers/net/vxlan/vxlan_core.c:vxlan_remcsum() {
>     ...
>         skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, off=
set,
>                             !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
>     ...
> }
>
> include/linux/skbuff.h:skb_remcsum_process() {
>     ...
>         delta =3D remcsum_adjust(ptr, skb->csum, start, offset);
>     ...
> }
>
> Nothing walks skb_shinfo(skb)->frag_list. So after this patch, each
> fraglist member keeps the restored sender checksum, which is not a valid
> final checksum under RCO.
>
> iptunnel_pull_offloads() removes only the encap GSO bits, which leaves
> SKB_GSO_FRAGLIST|SKB_GSO_TCPV4. Suppose the decapsulated inner packet is
> then bridged or routed out a device without FRAGLIST support. In that
> case skb_segment_list() reuses each member's own inner TCP/UDP header.
> __tcpv4_gso_segment_list_csum() also leaves the checksum alone when the
> addresses and ports match:
>
> net/ipv4/tcp_offload.c:__tcpv4_gso_segment_list_csum() {
>     ...
>         if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
>             iph->daddr =3D=3D iph2->daddr && iph->saddr =3D=3D iph2->sadd=
r)
>                 return segs;
>     ...
> }
>
> Would every segment except the head then leave with an invalid inner L4
> checksum? This path needs:
>
> - a remote sender setting VXLAN_HF_RCO
> - REMCSUM_RX and REMCSUM_NOPARTIAL on the VXLAN device
> - rx-gro-list on the lower device
> - no local socket for the inner flow, so is_flist gets set
>
> Before this patch, with frag0-based drivers, the member's linear header
> kept the adjusted checksum, which is valid for this path. The stray write
> went to the stale frag0 page instead. The commit message does not mention
> the local decap case.
>
> GUE does not seem to be affected. FOU/GUE sockets do not call
> udp_allow_gso(), so the aggregate is segmented before gue_remcsum() runs
> on each segment. The follow-up patch "net: gro: invalidate frag0 after a
> pull" does not change this logic either.
>
> Could fraglist GRO be refused or flushed once a NOPARTIAL remote
> checksum adjustment has been made? Alternatively, could the VXLAN decap
> path adjust the frag_list members too?

Yes, the checksum of fraglist members can not be right both for
forwarded packets and for packets decapsulated locally.

In v4, skb_gro_receive_list() refuses skbs with skb->remcsum_offload
set, so fraglist members never carry an adjusted checksum, and
skb_gro_remcsum_cleanup() simply returns for merged skbs.

pw-bot: cr
