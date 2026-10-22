Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792685869;
	b=gqRVTQZRtZ62XkyfixwidiTERfC24fYDm/Qs/WmLegOXmHgBPhwomFLA6aAuKdV2/L3I
	 TxFpijbFHTskQDecHpa/X0FylGb1VjD34ahYgquIam2+JtBdkpTVEPKOR3K2zQp5Uo6lQ
	 OATbIvL8zGk3ZHLbcZUvh1rWxpidB+OF8AA5JEx8Im8O7uGw9Izra3g5QqPTJsVBR9qWp
	 A0hQp9LgRA96jmQpq0JjERuwTdL8wWiAKfS/jEWUv2WgyvDc63rIzTw1lJhRXBHYTyq8n
	 7+F9g/ArmqoE1k0sn1tBUKYAbriflNxJxfX80QnKy5HHmwQoRrzZO7UxN6d8X495PSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ms9np8acRDIjcChjTD82wOHEoaKI9XRh/myC0U9P134=;
	b=xzbcm08jkuHjQmHWS9yfU+7bXAm4oIWkx6o0FQh/jBbBzuhaqAk6N4YUXeD7sTh14gzj
	 8Hiimr5XqXA6K6BcMBO+8MeMJ0AVUO0UGXD+Hq+8Gqyfx/9aypdFOxYsQTtVoLwxpSRLx
	 tC05qIe8ujpzcjitwXvEkbY0cg5r6zo2L4inZ4iz641gE0Q2yMwVn0wK4u86dpIWVJ1OL
	 QUhc9DLOXtN9f+viLwaWayhEuPavDIw6dXT0qJMhmmY1CRjfpkQ48xjFayb7mkT8RoG2W
	 JhAxDpkdnryyp6NHH39MgzqhOVbNLDVi2Ke3VB6Far5eZdneoozinUM9Qo7PRl+uzMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=X5JSXNOE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A6606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A0A6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=X5JSXNOE
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a264b6a06bso15281b3a.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792685868; cv=none;
        d=google.com; s=arc-20260327;
        b=qhayg7l7RgTcy+C08jL8v0iIyIDzie6ePZqR3sErKgsHfCp96m+OoNaenqRsPs3rB5
         nqelZYI1CsAJvL6mMy4ukoqKyXey+lyLcLIn48KnIfgvril9WDFQqtlPrU5x3azVd+io
         8A+KkiMgTvx9KsLEIB5OruTnhyWXjxXodsy6tiFWFS3X3RPIIeRkcPDILuUt3aSKw0az
         M8kdnPI1kdIX2G5Ck696eHGYotH820WFuTC6FFLEMk9QXawhU8/aFm1G1QqvWfwTlRLR
         nw7ESZHHROpuRgZGD3izYp6Qdpe7kkYxg5thr4z/50D/Ulb/ZyRvs2GllbXVeUYFdfV1
         +oLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ms9np8acRDIjcChjTD82wOHEoaKI9XRh/myC0U9P134=;
        fh=AQYJ8nNCv0WmzlGDRAYxI6VpAKTxqAYGOFkewrtLHfY=;
        b=Z1nLvjaW6iXwRXZNR1ZynHPH0vCQiEJs7B8EqSzodoDrKXVN/G72Rp5x9DNMYEF7Vr
         r4tfKbut3T7U4LBU7SF4GF1RZOxD3mm8YXqbdNBpSVJ8kJ8kUC2vjcEFgRabltboxYHA
         JcIstW+NeLU4ULEfoCHShu24AUlR2t2QuLkqbS//tfNDY+bXAPiCJ0SwnpNclAQxIQPO
         dIA4QWU/FyJ0d6fxIGynPi4ZzbyR0vCLuyP7ZvnQDlCKsxElBALccEYVN0qFdXfOtM3h
         ZJ2xuhwtJgooo/elAsnvcQMPV4I1v0qdyTKv+b/CIAB1nVhoViDRatanq0CQUiR/Zq8W
         hZxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792685868; x=1793290668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ms9np8acRDIjcChjTD82wOHEoaKI9XRh/myC0U9P134=;
        b=X5JSXNOEc5Vv420YTpmU527PofhO2y8Pp4UOv2V4oENqDjwEhM+iuXwNSe4YPkRsSs
         PxEryo0QZEIXwpJmKBbMEztwjC6FfWGVfessSwPTIywro4GVq5LyIEUgLS3+suNxlWCN
         KT01o71elxhI7F6Ybf18iz96qELABTOErlopU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685868; x=1793290668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ms9np8acRDIjcChjTD82wOHEoaKI9XRh/myC0U9P134=;
        b=glk/coW5GwIhHtgy9qFHZODpiTPbKfof7rG5dPjafZiqedNeecRJbXx7nVy4zklDH3
         z2LgSHyc2oMVa/w0Sw8SsosW6HaiXqGLvYciJPfdz+bP3ceOzwA0VJ+6lkN3yTEkQ/Be
         xZdZNpUlCWVrpZugrEzg56qQMTNTYLdJWYCMy2ectal9i7CnegKoM6Vq52hTuUkJPZKi
         kTebCqjvHQGcTQfVElD9yvZ6Ohdwsquf6Xw8s5o+v84WDy+qqjc9p/4o2sModN2s1+qp
         c+cROXKRpX0vwRtT9nxlWOjG+tpNvS8QFvkqH1qBSfYmV7WXHPc8+BbGK9NxIiU9bDCb
         RY/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzKfVII61y1lVqBLqLnZ2gooAlYqKm5c+VuSvy+p03LqY9QaAXKSqEmC4nsDscdT9jbYrCGTKA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBSV5uKsZtrV7HQaJoZupWtU44uchorE/2/fjG9lT4YxJuSAEN
	m+OPz0ZCZIh0i43A7GR3aarK8ctKrBxVFRYJKLRWL3P3QexiVglUi4OGic2Ivtx+ZZVmfnXpGjj
	ldDLcyi4WmMVw5G2o7SDhrBHE51vrXVtX2PHIryPP
X-Gm-Gg: AYBFou33MJZ83cvwpZvLRzyCRpM+nxQhj1ONjFZpEzhwDBY/+e3sDWBQAtTASLkn4g/
	QFXgukOkZnmsAuWCFFGCbJR/eB+U6ct+fcYme6FP5KlCjWy9AuNVExJiL8ga1qtokEJyE3tV3ey
	aV7reE/+Fq9Fea/1m0s/M7AygadELbpllf274+8VVnT+hQmUGOJeoXqGXpu52kVpjce3YfRJNy6
	sWr24n43+XIeWwwWs1vhbF+jJPDNgkNefOQHzP6HjdYX/YrmdIZGoBsXCs7eiwWkdGEQGnx1VaT
	q7MLh9y8YQYvUL0w0IF3HOlWlBu/D9irZwY0PeqZlo8EXWvLyWOxlVTav5n21TxRhXjf6nCIUYd
	2BSspbHlCrujce5UakDJ5OuhABYuuf1mVTRULKBm3pCj72DluylKiuL7DCWB1PNaLvCTDCQGRdJ
	rc4LJvAPnj3WhfcGw=
X-Received: by 2002:a05:6a00:a24e:b0:886:84c7:72b3 with SMTP id
 d2e1a72fcca58-8a089d340famr4954139b3a.26.1792685868305; Thu, 22 Oct 2026
 09:17:48 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
 <willemdebruijn.kernel.1c05560ef167@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1c05560ef167@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 Oct 2026 12:17:36 -0400
X-Gm-Features: AclHuK90a_fLh211CG2JNlvlKpUC5VtT1JKVs_mlSRyBwFYzOdwvch_anYMODbQ
Message-ID: <CAM0EoMmeOCQT8dRYKvfYa0EUtEsLM6EZcNCsQZSF+HfoK61Y2w@mail.gmail.com>
Subject: Re: [PATCH net 3/5] net: tun: keep TUN short linear copy hints safe
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rusty Russell <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 11:22=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > The issue:
> > A TUN skb can be redirected by tc mirred to an Ethernet xmit path, whic=
h
> > calls eth_type_trans() and needs a full Ethernet header in the linear
> > area.  tun_get_user() currently validates len and the GSO header length
> > only for IFF_TAP, so an IFF_TUN | IFF_VNET_HDR packet can set hdr_len t=
o
> > 1..13 and leave fewer than ETH_HLEN linear bytes.  The redirected packe=
t
> > then BUGs in eth_type_trans().
>
> TUN mode does not imply Ethernet. Indeed, TUN implies an L3 packet?

I have a feeling i am missing something: True, TUN is L3  but we are
not adding or parsing eth headers to TUN.

The patch only bounds the linear copy hint and receive headroom so a
TUN skb redirected by tc to an some ethernet xmit path satisfies
eth_type_trans()'s precondition in the patchset. IOW, with current
code does it matter if TUN is l3? The other side will assume the
payload to be ethernet..
If the redirect itself should be rejected for TUN, that is a different
fix; earlier ask from Eric is to fix the producer not for example the
driver (like loopback).
The "reject redirect from TUN" could probably be done but i dont see a
cheap way of doing it.

Thoughts?

cheers,
jamal
> >
> > The Fix:
> > Reject packets shorter than ETH_HLEN in both modes.  For IFF_TUN, where
> > hdr_len is only an allocation/copy hint when GSO and checksum offload a=
re
> > off, raise a short nonzero hdr_len to ETH_HLEN instead of rejecting the
> > write.  Keep the TAP rejection and its NET_IP_ALIGN adjustment unchange=
d.
> > This preserves valid no-offload TUN writes with hints below ETH_HLEN wh=
ile
> > guaranteeing at least ETH_HLEN linear bytes for the redirected consumer=
.
> >
> > The maximum receive headroom advertised through tun_set_headroom() must
> > reserve the same linear minimum.  A large upper-device needed_headroom
> > (for example an L2 netkit port behind a VLAN in an OVS datapath) otherw=
ise
> > caps good_linear below ETH_HLEN and defeats the clamp.  Reserve ETH_HLE=
N
> > for TUN; the TAP branch already reserves ETH_HLEN + NET_IP_ALIGN.
> >
> > Conditions to recreate the bug (repro available):
> > - create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
> > - attach ingress mirred egress redirect dev lo;
> > - write a virtio_net_hdr with hdr_len=3D1 and an 8192-byte payload.
> > Unfixed kernel will panic in eth_type_trans via loopback_xmit.
> > In a fixed kernel the write is accepted with hdr_len clamped to ETH_HLE=
N and the
> > packet is forwarded without a BUG.
> > - no-offload acceptance: a separate check writes a 28-byte IPv4/UDP-sha=
ped
> >   packet with hdr_len 0, 1, 13, 14 and 20; all writes are accepted.
> > - high headroom: create an L2 netkit pair with headroom 4096, put a VLA=
N
> >   over it, and add both the VLAN and the TUN to one OVS datapath so the
> >   TUN receive headroom is raised to 4100.  The same hdr_len=3D1 jumbo m=
ust
> >   keep at least ETH_HLEN linear bytes; without the setter reservation i=
t
> >   still BUGs.
> >
> > Fixes: f42157cb568c ("tun: fallback if skb_alloc() fails on big packets=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  drivers/net/tun.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 242899f7fd07..1e235c2f0aee 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1193,7 +1193,7 @@ static void tun_set_headroom(struct net_device *d=
ev, int new_hr)
> >       if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
> >               max_headroom -=3D ETH_HLEN + NET_IP_ALIGN;
> >       else
> > -             max_headroom -=3D 1;
> > +             max_headroom -=3D ETH_HLEN;
> >
> >       tun->align =3D clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
> >  }
> > @@ -1830,6 +1830,11 @@ static ssize_t tun_get_user(struct tun_struct *t=
un, struct tun_file *tfile,
> >               align +=3D NET_IP_ALIGN;
> >               if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_=
HLEN)))
> >                       return -EINVAL;
> > +     } else {
> > +             if (unlikely(len < ETH_HLEN))
> > +                     return -EINVAL;
> > +             if (hdr_len)
> > +                     hdr_len =3D max_t(int, hdr_len, ETH_HLEN);
> >       }
> >
> >       good_linear =3D SKB_MAX_HEAD(align);
> > --
> > 2.43.0
> >
>
>
