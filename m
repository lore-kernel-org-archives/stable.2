Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F327A907
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 04:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299759; cv=pass; b=ufzeuvTvcLEKZ7lBoM+SIj00FaS4w4Tn/kJq+l+70LenaTfMidUG1UAD2jfe+3UmRTNfvMW/JHNiTwROk8CvgdKOmEVKysq4KiPHx+LsYzutcbVRjVM61HreLZOtIAOq/Zki+FQ8eCZkOdxttiGCSXWb5pZjKXvTcXszhcZUdIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299759; c=relaxed/simple;
	bh=eXxuZZCRR4m1SNx9TqLOQOAWhfwaZChlZDGtoBJUfDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMW7gXCHacpnTxII3fJ4/QxkfhaV5rIiMoH+DH0iiMBP7EfS1Qwsz6Y8BYMsinyhVO46EvhUWYMhx+/5O1uTm3smK82X+hhjbLq24INPZWy1W7HgxAUVRVrJKIGMLaaFNsXf9bJus1nmwxORpw54Y2WTDtJ+z8UdawCqON94zlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6A+vyeC; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6A+vyeC"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81f36179d72so8786187b3.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 21:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785299757; cv=none;
        d=google.com; s=arc-20260327;
        b=pl7uEzVfH9+W18vwvxpeXDX1GsFyuFLC/CClxMGl6/KoE3My9AwJxB1CgE4l4HqmXW
         flcMJupjo/uCCUS9PFTmm439ERRvj8AKTK9CFWbJ+HJzW1DsBtxE4etoWu5ctGJmbEaK
         8zHp/uA2MziFWw1ZN97ThKfBhcfZRfgus+I5fkFoJrTjOzodgeHJx2eG4HtJ4BWImBbq
         tOr8eqK0oe3JU27bf4gqR2t2v+9qdFTaX2a3+ToKX7fh/ZpXA1M/lQK6OFCsNZ/7jKSi
         CBlxrm1Xp+8PQ0ibVcDPlGPxlr5qOz3vXwc7p+bJ12SnxW2Tl8U9pF6YPERYp6Rjz8Wa
         d40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJnft9PmfWlLs1b4MKRuyLFvy1g2soCrYIGgLbTdANE=;
        fh=SdUR5dSSLLA48hsSIbhareXVOZrEJ3j40fGfjuElSM0=;
        b=KQyLtor7CaecxT2gP/PNdh0pCbu7so+cRGMkyfYCPQKxCJhJv4CWTlFRKmAXCLHDQm
         HHQK07ULQRZCOERfJ9qCnER+SF59ySO6My51R58emGyRoIuTY4APeccrak8omoRNVcga
         Dhfmd4rLvc5KsknFESpBEJuB9y6LmKKgX6j2ElQbNrG71bGsfBEw+UpSon0uAbeC/P8m
         eBeInOGLhEpIEkQ3rsKXWGKMveHmJp/90WdTzmLJ5PX4c4mf78sywdC3iTzRB/B7SaqE
         b8lvjZ62e2scB2PnX65caaI0z9noCe20tnCIwXqVnwLwn43CMXVtEHnNGarSWB66ibKz
         Ugag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785299757; x=1785904557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJnft9PmfWlLs1b4MKRuyLFvy1g2soCrYIGgLbTdANE=;
        b=l6A+vyeCtZ5Vc77/EbmgNFgvlPrXl5+NoSac+IUW7nQV32Mrwgz0JzrO4BkFOQXYck
         EWHTwv76SqUcwVa3wgBQgFakN7DsD6l7pKqL3Yd/j2usjmHAKrPR7FGmrllYMd5dGi8a
         OyjSjAtKdwhHjQwiNVx56na6BJ5VlivPjvguFQSvcYQAVjNkmjBtO57kg/tXNrlb05PO
         GxDuINWPFEzyeniiv3Vsn/voZNYYgBKhWAKmQ+AolOYyGIlCaIR0ufxvIY2JRl2An6l9
         a14D6DXl6RZwtjkTdsJ/0Knpc8rQ0NFhRQ2Cjg6qPTyZyi9/wAejWC8FEnx87yPSro7+
         QQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785299757; x=1785904557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJnft9PmfWlLs1b4MKRuyLFvy1g2soCrYIGgLbTdANE=;
        b=FSvtH+NXBsH5p8C8Cs6PaZhZ92PhbD/wpHTo6shmXVgGjQN+Ef1G2yWiiVDfDf5nMY
         iC7xyo5OhdHU56dgMVG597Jc8gS7qgnfeEDki9r40wlcEbb4IRgJ2kmQc7PPsW+vG6r/
         LQ4wZhtROvvPvnuqeifdl/WlskJsDZ28CQHdW2YSeNZ21/25lIFz2dcJKjdmVSbVUcFK
         /zDAGXLPIipR1c4r2hd6P03euwpc/1nN9iLuAFPt/LrwuUl+AQOBDkccua8qI7ix9hya
         0srvYrKkPrtFLJ+AakOvcBv7QiKxNia5C4GXPf9FUcilgErct4BpZ8XQRyI1LuTqHVKC
         rqsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMQTSs7O9ZM4gUISD9FGPryyoxSsDJa870XOrqO8JHRdwa/nBeUhKF06HG3uY8YzL9LcFt/qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZE7s3ZpYw5W61cv3mqnfwNJAErKHfNvHgne+1b0j+jmKvnc2J
	T5RO+q3VTg46iUKTeBGqP5Ou6PfDe7KT/lxMR8KfuDcUvUyWkvm7mjAxbDdh6jGHH4W/UqSjo0T
	N1rlrg4NXO0Symbp1t4OhYomJG/gBSEg=
X-Gm-Gg: AR+sD12oR4KHGNaFoIuz+14ymNQ5GkoQWqWAVNUQnoY+ux5U+IfzoYW9rdSbp7kFw42
	OOAjlZtyF60NlAL71FLloJTyk1BdKNI8jseZC2DVrTpg6hviRhKyzKyi+YAiuHyWB7GspgSSOwN
	PA831x7VphbUWLScnJoc7r3RoRs5qoqMqmLhqeXg9+T+bLgZWlbDcTNDSjmJxYZscwndGRQa2CJ
	8D1ApOt5S57wc8qHQf6q0FCniAFsObbKEW/pMi2P/BS6xtP5+aZwof+j8GZ4OHM9wXqvC6jtMiF
	EQ5qLj4JmdupQeQZ+wTzfDl70wLA1Okid2BEObKd4o4PVA3nxcC5iiSlAG4J/eWeDsn4YKqragv
	s5P7U97P5jRAmbjt9RwE=
X-Received: by 2002:a05:690c:4d41:b0:81d:5155:213b with SMTP id
 00721157ae682-81f990adcdbmr25491617b3.14.1785299757024; Tue, 28 Jul 2026
 21:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-2-sun.jian.kdev@gmail.com> <amesUgTjM+4WvTkJ@boxer>
In-Reply-To: <amesUgTjM+4WvTkJ@boxer>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 29 Jul 2026 12:35:46 +0800
X-Gm-Features: AUfX_myQ6iay0D6KuhMY71cOqlREpxPTZjbUcUBLGVWUwA3h0jnwU10zyOyJWrY
Message-ID: <CABFUUZFfE86j8QVZoR6HSs1PsgLjxOB0=_hqBRwBaFbXKJKxXg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: fix skb length accounting after generic XDP
 frag adjustment
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	lorenzo@kernel.org, toke@redhat.com, matt@readmodwrite.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:07=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jul 26, 2026 at 08:25:34PM -0700, Sun Jian wrote:
> > Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
> > XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copie=
s
> > xdp_frags_size back to skb->data_len but leaves skb->len containing the
> > old fragment contribution.
> >
> > After a fragment shrink, this makes skb_headlen() larger than the actua=
l
> > linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> > copied 1024 bytes past the actual linear tail to userspace, starting at
> > struct skb_shared_info. The copied bytes included the affected skb's
> > nr_frags, xdp_frags_size and a kernel pointer from
> > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> > amount and truncated at the end.
> >
> > Subtract the old data_len before replacing it and add the new data_len
> > afterwards, keeping skb->len and skb->data_len synchronized.
> >
> > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened b=
y
> > 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> > corrupted payloads. After the fix, all 10 runs matched the expected
> > payload exactly.
> >
> > Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in ge=
neric mode")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel=
.org
> > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  net/core/dev.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 5933c5dab09e..94204702cb02 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5517,12 +5517,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *sk=
b, struct xdp_buff *xdp,
> >       }
> >
> >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +      * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
> >        */
> > +     skb->len -=3D skb->data_len;
> >       if (xdp_buff_has_frags(xdp))
> >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> >       else
> >               skb->data_len =3D 0;
> > +     skb->len +=3D skb->data_len;
>
> hm that reads a bit weird to me. maybe we could follow the existing
> semantics and reuse @off ? that would be a nicer way to update ::len only
> by a delta.
>
> if we would stick with existing approach i would appreciate comment being
> more elaborative, where we could explain that it is simpler to wipe out
> data_len altogether from len and then just add it back.
>
> >
> >       /* check if XDP changed eth hdr such SKB needs update */
> >       eth =3D (struct ethhdr *)xdp->data;
> > --
> > 2.43.0
> >

Hi Maciej,

Thanks. I am reworking the length update around the delta and checking
whether the existing off can be reused. I am also validating the ordering
against the head/frag adjustment paths before sending v2.

Thanks,
Sun Jian
