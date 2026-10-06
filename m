Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73602347BD4
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259025; cv=none; b=Dy6ODqL0rE8QWm30gh6s/by7IqRlktQtyEFzMKNQzXj1M52iwAmDxaKzTZCKvCVQzoME6jF1rK7C1rRjlVYia+4gFGLc8FVvrWqUneRPO4GtFE5eTY6aEO+XOceAgU0AxxuC/9zOVtXKiJ0e4EgIX9r0UZp+XLf8ERG/UhFsaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259025; c=relaxed/simple;
	bh=SgUAhzu7Itx6WZw68Z1rbdS8ZGs4SpersdAcLF4qBSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5KwNff/mbPIpD9TG/M42+WjbIXgzHymH1U495xQkXIHnZn9MohRG0IrotbA9Zpap8vlE4AlR0Qt6OiBt3h9kJKVlVPZENzEX+EYTxMi8KVLmxVzFbz2D/6GI1QU6E2hjxvPHK2BNv0ShtBxES6PlDcCAcPAZ5KC0UfMzuSIAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyDCUUW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyDCUUW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8A11F0089C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 03:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791259024;
	bh=nylbsV/BGOOjUon/OhSun9x/7q39ACZXXGxsuDGpM5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KyDCUUW1tRFxQ0g0tP2U2BpmHNZ5u21AEem/jiMNEx30JY65mlm3LcY8peWy/vG72
	 006FoYm5Fnb1BVnAZJSDjJIG9XwP+vkUzYY2Z9nmCOPJf9uCySxJkx6JRgL0wbuj9y
	 bqGFvJOiJEItEysIJ3/emptHaU8oUkb0odhNxQ7nDXVwdT3I4G6RsL/twNzZ/gEiID
	 yEPUDrjHp1xXqLJ4WhJx0l2f47vZfSZNHUPeVIerDqkziIN5zYdhwVqib/2BmMf7Tq
	 m4G3MfRi5m+KA49J9O/EI7Jc04Dnhk65586LDFIguG6Tbtu8pUm51lgt2QChYdBAQ6
	 G2/1kmRNv4jRw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6cfed5dd071so90005eaf.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 20:57:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxJMPItbLt4gMG4k03zmYhb/APIjkJL43scvLSMqquP0v/mqxgFr0weYmw4N3PpWh9DytmhpjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nlthvZgjjWiHfcT0T1fPMu1A+5gKUzriM+qhOo4czgyy0JYOnc
	mRSfFIsoZ1ntA40nGI1WGJrCGeFlxD0i45VVz2amvCJIaXOnd/2/wf3bs0hxq1lsrk0bqAKNO16
	mn1gNim9G/y9tQHQL7Sj/YpUcUuud2mc=
X-Received: by 2002:a05:6820:8184:b0:6e2:3d8b:a01c with SMTP id
 006d021491bc7-6e554301635mr27703eaf.19.1791259023447; Mon, 05 Oct 2026
 20:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005023812.130639-1-edumazet@kernel.org> <179123498942.434549.13440734253618262332@kernel.org>
In-Reply-To: <179123498942.434549.13440734253618262332@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 6 Oct 2026 05:56:51 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqwLH51iXsqmuUKTeP4Mo5Tv-qZ_D_MzaGK6C81nxQ6SA@mail.gmail.com>
X-Gm-Features: AclHuK8X7N50oa_vNPjBaL2CiYSW9zS2hkkKF2T2tKJn8ehllNz5e-34bB0K3IQ
Message-ID: <CAL4WiiqwLH51iXsqmuUKTeP4Mo5Tv-qZ_D_MzaGK6C81nxQ6SA@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: fix DMA mapping length for padded small packets
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, sfle@kth.se, 
	edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 5 oct. 2026 =C3=A0 23:16, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
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
> - [High] The fix is incomplete for short non-linear skbs, and for them it
>   changes the wire frame for the worse.
>
> --
>
> bnxt_en: fix DMA mapping length for padded small packets
>
> This patch replaces skb_pad() with skb_put_padto() in the normal_tx path
> of bnxt_start_xmit(). After the change, skb->len and skb_headlen() includ=
e
> the padding, so dma_map_single() maps the whole padded buffer. The pad
> variable and the rewrite of the last BD length are removed.
>
> Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothron=
d/
>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index d7728d0c5b6e6..7ea27e81e88c5 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>
> [ ... ]
>
> > @@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff=
 *skb, struct net_device *dev)
> >       }
> >
> >  normal_tx:
> > -     if (length < BNXT_MIN_PKT_SIZE) {
> > -             pad =3D BNXT_MIN_PKT_SIZE - length;
> > -             if (skb_pad(skb, pad))
> > -                     /* SKB already freed. */
> > -                     goto tx_kick_pending;
> > -             length =3D BNXT_MIN_PKT_SIZE;
> > +     if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
> > +             /* SKB already freed. */
> > +             goto tx_kick_pending;
> >       }
> > -
> > +     length =3D skb->len;
> > +     len =3D skb_headlen(skb);
>
> [Severity: High]
> What happens here when the skb is non-linear and shorter than
> BNXT_MIN_PKT_SIZE?
>
> bnxt_start_xmit() reads last_frag and tx_buf->nr_frags earlier, before
> any padding:
>
>         last_frag =3D skb_shinfo(skb)->nr_frags;
>         ...
>         tx_buf->nr_frags =3D last_frag;
>
> For a non-linear skb, skb_put_padto()->__skb_pad() skips the tailroom
> fast path and calls skb_linearize(). __pskb_pull_tail() then:
>
>   - copies the frags into the head
>   - calls skb_frag_unref() on each one
>   - sets nr_frags to 0
>
> The frags[] slots themselves are not cleared.
>
> After that, len =3D skb_headlen(skb) covers all 52 padded bytes, but
> last_frag still holds the old count. TX_BD_CNT(last_frag + 2) and
> SET_TX_OPAQUE(bp, txr, prod, 2 + last_frag) still count the old
> fragments. The frag loop also still runs over them:
>
>         for (i =3D 0; i < last_frag; i++) {
>                 frag =3D &skb_shinfo(skb)->frags[i];
>                 ...
>                 mapping =3D skb_frag_dma_map(&pdev->dev, frag, 0, len,
>                                            DMA_TO_DEVICE);
>
> This emits a BD for each stale frag, and TX_BD_FLAGS_PACKET_END is set on
> the last stale BD:
>
>         txbd->tx_bd_len_flags_type |=3D cpu_to_le32(TX_BD_FLAGS_PACKET_EN=
D);
>
> As an example, take a 42-byte frame with a 14-byte linear head and one
> 28-byte frag. AF_PACKET PACKET_TX_RING can build one through
> tpacket_fill_skb(). The head BD would describe 52 bytes and the stale fra=
g
> BD another 28. Wouldn't that put an 80-byte frame on the wire, with the
> payload duplicated?
>
> The NIC would also DMA-read pages that the skb no longer holds a
> reference on. If this skb held the last reference, those pages could
> already be freed or recycled.
>
> The completion path in __bnxt_tx_int() (last =3D tx_buf->nr_frags) and th=
e
> tx_dma_error unwind path also trust the stale count.
>
> bnxt sets NETIF_F_SG, so the core does not linearize these skbs first.
> They reach normal_tx whenever the push path is skipped, for example when
> tx_push_thresh is 0, the ring is not empty, or lflags is set.
>
> The old code mapped the same stale frags, so that part is not new. Its
> total descriptor length still came to 52, though, because the pad was
> added to the last BD. The oversized frame with duplicated data seems to
> come from this change. It also doesn't match this part of the commit
> message:
>
>   so that dma_map_single() maps the full buffer and the descriptor
>   length is consistent.
>
> Could the padding be done before length, len, last_frag and
> tx_buf->nr_frags are read, and before the free_size check? Or could
> last_frag and tx_buf->nr_frags be read again after skb_put_padto()
> succeeds?

Looks legit, I am cooking a V2, thanks.
