Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3453C3F45
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791348784; cv=none; b=ff8tJnzfkcb5884vaVcTEbXJD3YHg7vsAYPizwafOAOn6irpgt+PKnexCYMqDn10lOh9AMvaQvapS9HgdN3qkN/gI1v9PrWv7fDRL7TqdFHRQOqHnJzFHIokSxcT3z8PB0SPRA6nVRfjA2OvyE6xT7fyjn84Z8A20kHxYuizDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791348784; c=relaxed/simple;
	bh=crUw4FZcmyDM6WQW1xXi18AAldcRLt3eFNCFN/oF5Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lggyC9Hat38DYuz6CTJgBQM73mfjidzmH486A8zCG8qoiRfEYsMLFux4J45kV5NtF1yJz8fIFHKrrZZiWAvimzjZuchbCJiUVeWyv570znVvFynQLcQzEsgLvV1TypTIQ1WGjwFgKwbBYGPXT/dP5FzJ7UkFqkFRi+2dyEweLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAYNCpgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAYNCpgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B6B1F0089E
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 04:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791348783;
	bh=4XL1u9c2TANbieKXIBxIWnTPffWE6ngH5dVK2wPVARQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XAYNCpgv2cqthkyDiMfXSFAftuTXye9OhtMefcqQwnTVcg14XNKpyWFTzsi5VFP5Z
	 TDkghFNOYmBAgIfyN+/WO4/TReto9icR9ljrcrTpRgaP5bLyXzM2pw4SkqAziDlj6C
	 DRbvblptZsHVeR3vpihRnRASOsfFqHs2ezXxiBLI7nND9CgOM/43jt+BsBPBN4EtiZ
	 m9sEcXYujKZDG+uHHbPA+hHBJJTNLNhNX2j10LIQ/Yx903nCoHT2zPoXavro3Hn/lZ
	 PrI7QQy1njsRiZbuESqF06zxs7HrYc88qYUYEbCe8FdtntInXqKL0ASZSf+ASkTali
	 5X/gZuPYSAU7A==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49dfaa16190so1074482fac.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 21:53:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx3lJTy/1muiTZSs3u/I2Jnpkul+ds4ISC8BahwLhYU/ffhYvIjyZPjfhMdVfOR/ODJWLmoE38=@vger.kernel.org
X-Gm-Message-State: AFuF++m1IOaPdUvdYlVORxP+SzSYq6r2FyZD9YxPv3eMR1v/EiG4us47
	BR6XRIYi3x0HvbNQaLcrMcygjKRybgZIBMgtfkAbf5GSdqWdkOASPbopkASOISVAnR7S7xz/ed5
	fk94ZF7g+ZWimqcJ8DNrdLzO+3Wq5n2Y=
X-Received: by 2002:a05:6870:1491:b0:49e:241:600e with SMTP id
 586e51a60fabf-49f4f0b9f1dmr4328195fac.36.1791348782689; Tue, 06 Oct 2026
 21:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006042153.199444-1-edumazet@kernel.org> <179134695789.434549.53526916334276884@kernel.org>
In-Reply-To: <179134695789.434549.53526916334276884@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 7 Oct 2026 06:52:51 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiqp2qmAbgu8Etb+ptoPiEoW1Q0iTCK5ZgWbQ36o=-8=ow@mail.gmail.com>
X-Gm-Features: AclHuK_pbisgIDYA0RvghCwtOjDIXsoHeC-nG8BPEIdo-7jH51YS4sZIGBQ2hWo
Message-ID: <CAL4Wiiqp2qmAbgu8Etb+ptoPiEoW1Q0iTCK5ZgWbQ36o=-8=ow@mail.gmail.com>
Subject: Re: [PATCH v2 net] bnxt_en: fix DMA mapping length for padded small packets
To: netdev-bot+sashiko@kernel.org, Joe Damato <joe@dama.to>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, sfle@kth.se, 
	edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch, berni@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 7 oct. 2026 =C3=A0 06:22, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] Regression in the software UDP GSO path.

Ack, I CC Joe, because UDP GSO is not padding yet short UDP packets
(eg IPv4 and gso_size =3D=3D 1)

I will send a V3, hopefully this will be the final one.

pw-bot: cr

>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the sister
>   bnge driver has the same stale-fragment ordering bug that the bnxt v2=
=E2=80=A6

bnge driver will be fixed separately, once bnxt has shown the way.

>
> --
>
> bnxt_en: fix DMA mapping length for padded small packets
>
> This patch moves short-frame padding in bnxt_start_xmit() to the top of
> the function and uses skb_put_padto(). As a result, skb_headlen() now
> includes the pad when the linear head is DMA-mapped. This fixes the IOMMU
> read faults that happened when the TX BD length was larger than the
> mapped length.
>
> Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothron=
d/
>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index d7728d0c5b6e6..7f379f21fe465 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>
> [ ... ]
>
> > @@ -507,6 +507,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff =
*skb, struct net_device *dev)
> >       txr =3D &bp->tx_ring[bp->tx_ring_map[i]];
> >       prod =3D txr->tx_prod;
> >
> > +     if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
> > +             /* SKB already freed. */
> > +             goto tx_kick_pending;
> > +     }
> > +
>
> [Severity: Medium]
> Does moving the pad ahead of the SW USO branch change what
> bnxt_sw_udp_gso_xmit() puts on the wire?
>
> Before this patch, padding only ran at normal_tx:, after the SW USO branc=
h
> had already returned. So bnxt_sw_udp_gso_xmit() always got the unpadded
> skb.
>
> Now a UDP GSO skb shorter than 52 bytes is padded first. On devices
> without BNXT_FLAG_UDP_GSO_CAP it then goes here:
>
>         if (skb_is_gso(skb) &&
>             (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
>             !(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
>                 int rc =3D bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
>
> bnxt_sw_udp_gso_xmit() in bnxt_gso.c then computes:
>
>         total_payload =3D skb->len - hdr_len;
>         num_segs =3D DIV_ROUND_UP(total_payload, mss);
>
> This counts the zero pad as UDP payload. tso_build_hdr() builds
> iph->tot_len and the UDP length from the segment payload, and the NIC
> fills in valid checksums. Would the receiver then accept the pad bytes as
> real UDP data?
>
> For example, Ethernet 14 + IPv4 20 + UDP 8 + 2 bytes of data is 44 bytes.
> With gso_size=3D1 that is padded to 52. total_payload goes from 2 to 10, =
so
> 10 datagrams are sent instead of 2, and eight of them carry only zeros.
>
> An unprivileged UDP socket can trigger this by setting UDP_SEGMENT to a
> small gso_size and sending a few bytes over IPv4.
>
> Also, BNXT_MIN_PKT_SIZE is a per-frame minimum. Padding the super-packet
> still leaves the individual SW USO segments (for example 43 bytes)
> shorter than that.
>
> Should the pad be skipped for skb_is_gso() skbs, or applied after the SW
> USO branch?
>
> [Severity: High]
> This isn't a bug introduced by this patch, but the sister bnge driver
> seems to have the ordering problem that this v2 placement avoids for
> bnxt. In bnge_start_xmit() in drivers/net/ethernet/broadcom/bnge/bnge_txr=
x.c,
> the frag count is read before padding:
>
>         last_frag =3D skb_shinfo(skb)->nr_frags;
>         ...
>         tx_buf->nr_frags =3D last_frag;
>         ...
>         if (eth_skb_pad(skb))
>                 goto tx_kick_pending;
>
> A nonlinear skb shorter than ETH_ZLEN has skb_tailroom() of 0. In that
> case __skb_pad() goes through pskb_expand_head() and skb_linearize().
> That pulls the frag data into the head, drops the frag page references
> and sets nr_frags to 0.
>
> bnge_start_xmit() then keeps using the stale last_frag:
>
>         flags =3D (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
>                 TX_BD_CNT(last_frag + 2);
>         ...
>         for (i =3D 0; i < last_frag; i++) {
>                 frag =3D &skb_shinfo(skb)->frags[i];
>                 ...
>                 mapping =3D skb_frag_dma_map(bd->dev, frag, 0, len,
>                                            DMA_TO_DEVICE);
>
> Can this DMA-map frag pages that the skb no longer holds a reference to?
> If so, the NIC would send the frag data twice and read pages that may
> already be freed or recycled, such as page_pool pages.
>
> Two ways to get such skbs are AF_PACKET TX_RING SOCK_RAW frames and
> forwarded small packets whose payload stayed in a frag after
> pskb_trim_rcsum().
>
> As a separate fix, would it make sense to call eth_skb_pad() before
> nr_frags is read in bnge_start_xmit(), the same way this patch does for
> bnxt?
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261006042153.199444-1-edumazet%40kernel.org
