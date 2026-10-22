Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692049;
	b=uKBCPeVMQ38VbX5g94PQ5mfPBtkf/PLASbYZHjGDUsbRlqTPBGx3KyLiYSaqSP3Tmf2q
	 pwME8OvZvHcImlvTN8qj0aU1rHWjfAk1mv0mHcurbptf/QzF9a8A8FFA2kV44MsOJ3YCJ
	 cy7Pw7067r24MJ5XADpX1ImQjSaODDqjAgbcE2QnMFg2gcJkBnRXD/FVUwGQnPVYRe88x
	 27h0hJP/ifKQ8lKYRH6cYXpo8tMlF4eeU0YqgDEF8pX+ZzZd7gm0jL87LSRcH4vZGLe+I
	 OQdLe5EhyGaYyoTMaT3P7FNIaye/LBA3YI9zmAgRbbCMngdLs7EbFn+Hyj4bRpidzTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692049;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OezdbdKysFqgjMHGtNKMfceio5G1Rt0ImqaD/QPQ7L4=;
	b=od7tf5md88sOzl4Zl60FJYFUGE7+nE3PZcCADQodoBPk3Hnb14VlJ4qJEzfYhQxFRuum
	 0rc7LiDEMoS2gh2IHJZQrMx346F/mPHRuQ1su3tnQw0iXwc/9d/1is7syXTTo7b9UARtj
	 VHUrtUd2ELcLy9NOD8St+TsR8+3BBDd0k7weJEiMJzB5ZCQxx5Lrrx4p4at31g4xv+JsM
	 IojOmOMHv/wGYGPcOyL5+j7R6JOs+U/VVHeRWyZiKNqmMzd+Fi/celaESh85+Vc2rRZRm
	 Miq2VlY/HVT9/sXQz1/ufEXIC1njI5/8jP/KckTWtSYKV7S1jtGY4xmEViYHozqDeGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtxZxABz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2481606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtxZxABz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE561F01829
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792692048;
	bh=OezdbdKysFqgjMHGtNKMfceio5G1Rt0ImqaD/QPQ7L4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GtxZxABzY7Qio4KKG3pdTrfVAn45+YIVlwOPYi4E5Z0jtJ6WNw4pLoPa8T8P/1GHB
	 j14RVnJQTZlzdzZXyVEjN/RBzuK15pX2rGJOv+5/0HnMgcOBcWSgFYrMYFBYmfFhNv
	 24L9dKXClr+Oh7FNtYRSD/4xnjsFUAW62GwBTO6gP7eft25Mq0jOcKasOpXcEtvdF3
	 kHOGxUDJL2sveO1xcU1zwzyxsOaYR7mN25mzpv7PCspgacEU2Ei6Oba6QhaZ12+eSz
	 Bn9m2Yn9sKRD/ehrnvobUPdtioHdDUNtuhZWdSnGFJ5f3m9a1z8NcmhPdgtu0SObtN
	 6VCDrnkYNwXvg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a9787a156eso23504561fa.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:00:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxIQG8ZA6qvDEtReLYxxeN7uk5jROfmqQvKe1Rep7THMXZHz/hGiG0DoJUixhaIMcDvfC1PreY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9Xyst36/JaTrGF2WLpGZRiiLsivlAHhQaHC+iNSI6t7FYb3Aj
	VulGRHKTomiGnr4y3QKWhmwMc1svUzyAe393NMuZGTXjyBo84X5wSDgF+oxLSC0Vv4lzCuthh9n
	x/5XQ+IlJEnb8u/xwaBKrZhmRp8/80lE=
X-Received: by 2002:a2e:a7ca:0:b0:3a9:9c1f:1b9e with SMTP id
 38308e7fff4ca-3ac4413d5eamr17333041fa.4.1792692047249; Thu, 22 Oct 2026
 11:00:47 -0700 (PDT)
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
 <willemdebruijn.kernel.1c05560ef167@gmail.com> <CAM0EoMmeOCQT8dRYKvfYa0EUtEsLM6EZcNCsQZSF+HfoK61Y2w@mail.gmail.com>
In-Reply-To: <CAM0EoMmeOCQT8dRYKvfYa0EUtEsLM6EZcNCsQZSF+HfoK61Y2w@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 20:00:33 +0200
X-Gmail-Original-Message-ID: <CAL4Wiir8Y03fhsevoqjvO8bH9PyGL0TWy312KOjip0SngPmVfg@mail.gmail.com>
X-Gm-Features: AclHuK9tGCezuKXL3ZQaoeKiwEcpj7XQlNue34RgbxGGna_VvvqlguiKkWN0igM
Message-ID: <CAL4Wiir8Y03fhsevoqjvO8bH9PyGL0TWy312KOjip0SngPmVfg@mail.gmail.com>
Subject: Re: [PATCH net 3/5] net: tun: keep TUN short linear copy hints safe
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rusty Russell <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 18:17, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> On Thu, Oct 22, 2026 at 11:22=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > The issue:
> > > A TUN skb can be redirected by tc mirred to an Ethernet xmit path, wh=
ich
> > > calls eth_type_trans() and needs a full Ethernet header in the linear
> > > area.  tun_get_user() currently validates len and the GSO header leng=
th
> > > only for IFF_TAP, so an IFF_TUN | IFF_VNET_HDR packet can set hdr_len=
 to
> > > 1..13 and leave fewer than ETH_HLEN linear bytes.  The redirected pac=
ket
> > > then BUGs in eth_type_trans().
> >
> > TUN mode does not imply Ethernet. Indeed, TUN implies an L3 packet?
>
> I have a feeling i am missing something: True, TUN is L3  but we are
> not adding or parsing eth headers to TUN.
>
> The patch only bounds the linear copy hint and receive headroom so a
> TUN skb redirected by tc to an some ethernet xmit path satisfies
> eth_type_trans()'s precondition in the patchset. IOW, with current
> code does it matter if TUN is l3? The other side will assume the
> payload to be ethernet..

I agree with Willem: TUN is not the producer here, mirred is.

TUN builds a valid L3 skb (mac_len =3D=3D 0). mirred then sends it to a
device expecting a link layer header, and the IP header is parsed
as an Ethernet one. With this patch we no longer crash, but we still
transmit garbage.

Also, rejecting len < ETH_HLEN in IFF_TUN mode changes the uAPI for
a constraint that has nothing to do with TUN itself.

> If the redirect itself should be rejected for TUN, that is a different
> fix; earlier ask from Eric is to fix the producer not for example the
> driver (like loopback).
> The "reject redirect from TUN" could probably be done but i dont see a
> cheap way of doing it.

It does not need to be TUN specific, and bpf_redirect() already does it.
__bpf_redirect_common() refuses to send a packet without a link layer
header to a device expecting one, since 3a0af8fd61f9 ("bpf: BPF for
lightweight tunnel infrastructure"):

        /* Verify that a link layer header is carried */
        if (unlikely(skb->mac_header >=3D skb->network_header || skb->len =
=3D=3D 0)) {
                kfree_skb(skb);
                return -ERANGE;
        }

mirred could do the same in tcf_mirred_to_dev(), after the
push/pull adjustment. Something like (untested):

        if (!expects_nh &&
            (unlikely(skb_network_offset(skb_to_send) < dev->min_header_len=
) ||
             !pskb_may_pull(skb_to_send, dev->min_header_len)))
                /* drop, freeing skb_to_send if it was cloned */

This is one compare in the fast path, covers TUN and any other L3
source (including a vlan pop_eth / mpls pop chain followed by mirred),
and keeps the legit case working (vlan push_eth, then mirred to an
Ethernet device).

Then this tun patch is not needed, unless there is another path
from an IFF_TUN device to eth_type_trans() that I missed.

Thanks.

>
> Thoughts?
>



> cheers,
> jamal
> > >
> > > The Fix:
> > > Reject packets shorter than ETH_HLEN in both modes.  For IFF_TUN, whe=
re
> > > hdr_len is only an allocation/copy hint when GSO and checksum offload=
 are
> > > off, raise a short nonzero hdr_len to ETH_HLEN instead of rejecting t=
he
> > > write.  Keep the TAP rejection and its NET_IP_ALIGN adjustment unchan=
ged.
> > > This preserves valid no-offload TUN writes with hints below ETH_HLEN =
while
> > > guaranteeing at least ETH_HLEN linear bytes for the redirected consum=
er.
> > >
> > > The maximum receive headroom advertised through tun_set_headroom() mu=
st
> > > reserve the same linear minimum.  A large upper-device needed_headroo=
m
> > > (for example an L2 netkit port behind a VLAN in an OVS datapath) othe=
rwise
> > > caps good_linear below ETH_HLEN and defeats the clamp.  Reserve ETH_H=
LEN
> > > for TUN; the TAP branch already reserves ETH_HLEN + NET_IP_ALIGN.
> > >
> > > Conditions to recreate the bug (repro available):
> > > - create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
> > > - attach ingress mirred egress redirect dev lo;
> > > - write a virtio_net_hdr with hdr_len=3D1 and an 8192-byte payload.
> > > Unfixed kernel will panic in eth_type_trans via loopback_xmit.
> > > In a fixed kernel the write is accepted with hdr_len clamped to ETH_H=
LEN and the
> > > packet is forwarded without a BUG.
> > > - no-offload acceptance: a separate check writes a 28-byte IPv4/UDP-s=
haped
> > >   packet with hdr_len 0, 1, 13, 14 and 20; all writes are accepted.
> > > - high headroom: create an L2 netkit pair with headroom 4096, put a V=
LAN
> > >   over it, and add both the VLAN and the TUN to one OVS datapath so t=
he
> > >   TUN receive headroom is raised to 4100.  The same hdr_len=3D1 jumbo=
 must
> > >   keep at least ETH_HLEN linear bytes; without the setter reservation=
 it
> > >   still BUGs.
> > >
> > > Fixes: f42157cb568c ("tun: fallback if skb_alloc() fails on big packe=
ts")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  drivers/net/tun.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > index 242899f7fd07..1e235c2f0aee 100644
> > > --- a/drivers/net/tun.c
> > > +++ b/drivers/net/tun.c
> > > @@ -1193,7 +1193,7 @@ static void tun_set_headroom(struct net_device =
*dev, int new_hr)
> > >       if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
> > >               max_headroom -=3D ETH_HLEN + NET_IP_ALIGN;
> > >       else
> > > -             max_headroom -=3D 1;
> > > +             max_headroom -=3D ETH_HLEN;
> > >
> > >       tun->align =3D clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
> > >  }
> > > @@ -1830,6 +1830,11 @@ static ssize_t tun_get_user(struct tun_struct =
*tun, struct tun_file *tfile,
> > >               align +=3D NET_IP_ALIGN;
> > >               if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ET=
H_HLEN)))
> > >                       return -EINVAL;
> > > +     } else {
> > > +             if (unlikely(len < ETH_HLEN))
> > > +                     return -EINVAL;
> > > +             if (hdr_len)
> > > +                     hdr_len =3D max_t(int, hdr_len, ETH_HLEN);
> > >       }
> > >
> > >       good_linear =3D SKB_MAX_HEAD(align);
> > > --
> > > 2.43.0
> > >
> >
> >
