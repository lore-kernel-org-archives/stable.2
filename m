Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792700297;
	b=RMej6iu+zBNrPKQyv7tiMJRtw70SgpxzOtc/4hf3feNgz6jtQTE24r7mA+9qkP+9WQVV
	 bvs0DOXIMiDLkJCsDyeoN7KAUESaYmCjkPcUJFQ2M/28f30v3j4jTaxbkC9oUhPBiMyL/
	 3tEIC/fwU/w6BxU5ISYiJpwls++nWn8dxyfGmohubkoup4PCDu2tX6ZePVjTYJCfA2jma
	 jx20zJl69V9EXXmWtLRRjgtIEX/nEXaxG9ANAjiAc/wV0wZ5uPrMHvKGSUkY5JMHBNzD5
	 CFbCXkwSl1RYAYdgXSCA514Q7N/oj9ttM7Vs4VnA1aBZyxJ+gYhzRT7LLQzPUAVEYxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=moNSTojx0dXTPiE1dpjsERmt8FpWrrd0KC9O4iA7TPU=;
	b=g9uKzIwZ3PnwFHiCE3BUyira8/0jCcqgUcucFQ4pGsEszdTW/Bk3jwSTeRkmxJlhviaZ
	 HXiW+8/3JVcjajiAHCB02DVfi74aFX7KYf7SAgVpnxmHUYVD49jZqimDCllsp67CStd0I
	 HSKt2/dr7GZfCxQahb/rxCi0ukyVr1p+BdnR0BRxknV//CEr+ozsSvJqaM7Q5BhxFeELT
	 yQDjlSvFoox6Oc0+1k6QrkKxVZ/jBO1HSkpA1jMtn7W5YkClYc49ccZTCU3s5J6bAQ4l1
	 mb8UFo6mX2LOqrCrU41v/jQEfH4jiFpy1ZnLiFR6FgKK7K91Rvj2FijiDOm2NYm9dcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DFN8QjBG;
	arc=fail smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC0606A32E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 20:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFBC0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DFN8QjBG
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so150060b3a.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792700295; cv=none;
        d=google.com; s=arc-20260327;
        b=XbXxiZW2tNmSKVJc6o1HAl0w2zusv5705kvTAjTi2x0pIsAfzDxKSyxIDxBGZu6G9t
         ArjreCaZekKft1kB6gRMF70yDkdmfeC43C8Af4m4+mlZqYmsvW1orGtpBx4m1hqg75uW
         5xhLFkTw//a3IrKqqtTOcnLU9BTyCWLL2ga4FuzbYd8ZxCkjSI3buvpCLi23P9CKAVkL
         pY25RgIXRWamwYBXzXvxrTGgVcbZ9XmQOsMeCbxgEenaj8CysrM46xANN/U1V4+bZknp
         E/pCAnK2oXjxC574PcVLr+pkMJcONqamSTefqIXDCKHUIVZ3Jj3Grb1xdduZfyQtT/3u
         x1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=moNSTojx0dXTPiE1dpjsERmt8FpWrrd0KC9O4iA7TPU=;
        fh=97DN5qdEl+FcZ2JNuoru0QovN4t3LYlsKs6TaZ1C60E=;
        b=S/FUZFHCzlpD9iA5zWlSCh4rO5MRISJuHuMWwpUSWPg4K0S/1WbgmHQRkHsIf4qci7
         WdUq4hu3SALoSLTQD0MaCJSIcVOZeg5p1zmbYPw/1SF2Uz20WbXaKtx06NX1JKqemaju
         SiBAd9jDZDigHm1qZT4T85EXd3VsogiEv5Zk05wa4azmUVe62FWlXiYVoLe6VuznDqDi
         4uhFY6azYf3PonommWZJNKSV3th7IVT4SXt9Yik9BRr3H5FiN+kADI5UTvjZr5+Soz0S
         c/ZAH+TvJPk+JhJkrQSvtC+Sg+j4MZJAh75xz/0B+CR3Y35JeuH2Ya7rvTo7xM/MA9Gg
         Y6tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792700295; x=1793305095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=moNSTojx0dXTPiE1dpjsERmt8FpWrrd0KC9O4iA7TPU=;
        b=DFN8QjBGMkL8fyQHgyaJLwRckP18cIaxLw/zw58d/m4tx25LYPLc4EgUaQXwiJiC5R
         ti3cobbdflJQ+sRVB5Z3UkSXZRx7gtickqyfQ8kSL5uoeOHWzsQcTRNrGX+n0feOSjD5
         W3t6KJ7EO3ula8IYM+qi6wAgukI9AgmLshy7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700295; x=1793305095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=moNSTojx0dXTPiE1dpjsERmt8FpWrrd0KC9O4iA7TPU=;
        b=pXCcQTdj8VhuUif3ba46wY017Y3Qj9pvjYEDgfsk18pnoH8W9MlfdH90g+uI/e6wyz
         /TWyUdQj+zR4wF2XLyACN3lMl5zf9jCKfiR2QdVepOCnrNm/1ZtkGILPjM3LUAbJEXfl
         iZO4bVZHqMycoITFnY48Rhf7E+FXSUbVnqFX0rokUr5fxQQfnqGY/wDHlu6P+7+NzOLS
         pq758AHJmMYWoqlrneO7WPs96Nq7k+L2qiyUXNTCVf39aXbi8iWcQkMOOsMYdmzRC0yt
         EJ/F0P/m2X5u3LxZwPSTTocq9XUHTiQ/x3Fwtc5auYoJuElnjmZEXf5ZSQ9GVemAiPrw
         X0zg==
X-Forwarded-Encrypted: i=1; AKwUvByM8Ip0M604xOtKuEMtSuqkeNSjtaPthX6IHBHPMIA/piyzIDx8rCk7U7xDELEMEqfD1TsrLPc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMrFz3BBrbWnjkeq/90IjnWSKYgU9Klz8w7ATAdjHuFAjuj18t
	GMhkGCRCZ2hfCmyTmzWyeBJYXe0WsrrmxcplH4PpB3TSkWf8s+CJ6c945kM98h8EXoserGVGUNO
	Nacsz5hIWsyvNqUn+s584RKtnEXbSpLkeeE0I9n8V
X-Gm-Gg: AYBFou2LiPgCVxBtVyNI+kwGM2wAwCp6qSbrHbsC/oA2n1kOZIwI9hHuSuPCHS3L9og
	l/tfxZaHBdXi8eyao+0tObqLMFon+GHaVSDMKQCyWTDxGYTgu6Jxaxsnn/qwbIF4rw2RXhTnQT+
	0m+sTjymYQ3C8r4TsNbKL1fmS++E7yCOzN1MMDBhfwtAYNVcHUaAIn2y2O4d++YhntUsuZPCxxo
	1WKofzymZp3mSJRbN20OqZ1CiHVXQIs7WAGfu8RxFEuAxaq6JXQmyRnXupPxv8kLu+FfH27yFqg
	DVcS/IX993lnxe+mqNohjv1DolAuOirRVKbc1b+M08uA+BaTxQrPnlFfW02dHZdtEJyKRoB/0ZA
	6n8+6Uatle5ieAZySAiPJFGEBvx3YU2iuR1PYAxGIJtP8oaooekWbqZMA+vAbrLerFv/bPsHO/A
	xqXFL807o0/Z7NBRA=
X-Received: by 2002:a05:6a00:3d53:b0:886:9187:1a00 with SMTP id
 d2e1a72fcca58-8a2c6c9a851mr202915b3a.59.1792700295238; Thu, 22 Oct 2026
 13:18:15 -0700 (PDT)
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
 <CAL4Wiir8Y03fhsevoqjvO8bH9PyGL0TWy312KOjip0SngPmVfg@mail.gmail.com>
In-Reply-To: <CAL4Wiir8Y03fhsevoqjvO8bH9PyGL0TWy312KOjip0SngPmVfg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 Oct 2026 16:18:04 -0400
X-Gm-Features: AclHuK_-5NUgjQpH7g9e6wEaUSHlW8S74djMDTg7OfaA5bfXJ2krL517q9k5L7k
Message-ID: <CAM0EoM=yw01ZYg-eu6fX=v=guH1-rS=dU2zpNoq_nEy=WmWTRQ@mail.gmail.com>
Subject: Re: [PATCH net 3/5] net: tun: keep TUN short linear copy hints safe
To: Eric Dumazet <edumazet@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rusty Russell <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 2:00=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le jeu. 22 oct. 2026 =C3=A0 18:17, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
> >
> > On Thu, Oct 22, 2026 at 11:22=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jamal Hadi Salim wrote:
> > > > The issue:
> > > > A TUN skb can be redirected by tc mirred to an Ethernet xmit path, =
which
> > > > calls eth_type_trans() and needs a full Ethernet header in the line=
ar
> > > > area.  tun_get_user() currently validates len and the GSO header le=
ngth
> > > > only for IFF_TAP, so an IFF_TUN | IFF_VNET_HDR packet can set hdr_l=
en to
> > > > 1..13 and leave fewer than ETH_HLEN linear bytes.  The redirected p=
acket
> > > > then BUGs in eth_type_trans().
> > >
> > > TUN mode does not imply Ethernet. Indeed, TUN implies an L3 packet?
> >
> > I have a feeling i am missing something: True, TUN is L3  but we are
> > not adding or parsing eth headers to TUN.
> >
> > The patch only bounds the linear copy hint and receive headroom so a
> > TUN skb redirected by tc to an some ethernet xmit path satisfies
> > eth_type_trans()'s precondition in the patchset. IOW, with current
> > code does it matter if TUN is l3? The other side will assume the
> > payload to be ethernet..
>
> I agree with Willem: TUN is not the producer here, mirred is.
>
> TUN builds a valid L3 skb (mac_len =3D=3D 0). mirred then sends it to a
> device expecting a link layer header, and the IP header is parsed
> as an Ethernet one. With this patch we no longer crash, but we still
> transmit garbage.
>
> Also, rejecting len < ETH_HLEN in IFF_TUN mode changes the uAPI for
> a constraint that has nothing to do with TUN itself.
>
> > If the redirect itself should be rejected for TUN, that is a different
> > fix; earlier ask from Eric is to fix the producer not for example the
> > driver (like loopback).
> > The "reject redirect from TUN" could probably be done but i dont see a
> > cheap way of doing it.
>
> It does not need to be TUN specific, and bpf_redirect() already does it.
> __bpf_redirect_common() refuses to send a packet without a link layer
> header to a device expecting one, since 3a0af8fd61f9 ("bpf: BPF for
> lightweight tunnel infrastructure"):
>
>         /* Verify that a link layer header is carried */
>         if (unlikely(skb->mac_header >=3D skb->network_header || skb->len=
 =3D=3D 0)) {
>                 kfree_skb(skb);
>                 return -ERANGE;
>         }
>
> mirred could do the same in tcf_mirred_to_dev(), after the
> push/pull adjustment. Something like (untested):
>
>         if (!expects_nh &&
>             (unlikely(skb_network_offset(skb_to_send) < dev->min_header_l=
en) ||
>              !pskb_may_pull(skb_to_send, dev->min_header_len)))
>                 /* drop, freeing skb_to_send if it was cloned */
>
> This is one compare in the fast path, covers TUN and any other L3
> source (including a vlan pop_eth / mpls pop chain followed by mirred),
> and keeps the legit case working (vlan push_eth, then mirred to an
> Ethernet device).
>
> Then this tun patch is not needed, unless there is another path
> from an IFF_TUN device to eth_type_trans() that I missed.
>

Ok, i will look at this with the same reproducer script.
Also good answer on the skb pull.

Overall i wll resend this series with a new update, substituting this
with a mirred patch. I also have since found IFE old report from
sashiko fits as an additional patch.

pw-bot: cr

cheers,
jamal
> Thanks.
>
> >
> > Thoughts?
> >
>
>
>
> > cheers,
> > jamal
> > > >
> > > > The Fix:
> > > > Reject packets shorter than ETH_HLEN in both modes.  For IFF_TUN, w=
here
> > > > hdr_len is only an allocation/copy hint when GSO and checksum offlo=
ad are
> > > > off, raise a short nonzero hdr_len to ETH_HLEN instead of rejecting=
 the
> > > > write.  Keep the TAP rejection and its NET_IP_ALIGN adjustment unch=
anged.
> > > > This preserves valid no-offload TUN writes with hints below ETH_HLE=
N while
> > > > guaranteeing at least ETH_HLEN linear bytes for the redirected cons=
umer.
> > > >
> > > > The maximum receive headroom advertised through tun_set_headroom() =
must
> > > > reserve the same linear minimum.  A large upper-device needed_headr=
oom
> > > > (for example an L2 netkit port behind a VLAN in an OVS datapath) ot=
herwise
> > > > caps good_linear below ETH_HLEN and defeats the clamp.  Reserve ETH=
_HLEN
> > > > for TUN; the TAP branch already reserves ETH_HLEN + NET_IP_ALIGN.
> > > >
> > > > Conditions to recreate the bug (repro available):
> > > > - create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
> > > > - attach ingress mirred egress redirect dev lo;
> > > > - write a virtio_net_hdr with hdr_len=3D1 and an 8192-byte payload.
> > > > Unfixed kernel will panic in eth_type_trans via loopback_xmit.
> > > > In a fixed kernel the write is accepted with hdr_len clamped to ETH=
_HLEN and the
> > > > packet is forwarded without a BUG.
> > > > - no-offload acceptance: a separate check writes a 28-byte IPv4/UDP=
-shaped
> > > >   packet with hdr_len 0, 1, 13, 14 and 20; all writes are accepted.
> > > > - high headroom: create an L2 netkit pair with headroom 4096, put a=
 VLAN
> > > >   over it, and add both the VLAN and the TUN to one OVS datapath so=
 the
> > > >   TUN receive headroom is raised to 4100.  The same hdr_len=3D1 jum=
bo must
> > > >   keep at least ETH_HLEN linear bytes; without the setter reservati=
on it
> > > >   still BUGs.
> > > >
> > > > Fixes: f42157cb568c ("tun: fallback if skb_alloc() fails on big pac=
kets")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > ---
> > > >  drivers/net/tun.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > index 242899f7fd07..1e235c2f0aee 100644
> > > > --- a/drivers/net/tun.c
> > > > +++ b/drivers/net/tun.c
> > > > @@ -1193,7 +1193,7 @@ static void tun_set_headroom(struct net_devic=
e *dev, int new_hr)
> > > >       if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
> > > >               max_headroom -=3D ETH_HLEN + NET_IP_ALIGN;
> > > >       else
> > > > -             max_headroom -=3D 1;
> > > > +             max_headroom -=3D ETH_HLEN;
> > > >
> > > >       tun->align =3D clamp_t(int, new_hr, NET_SKB_PAD, max_headroom=
);
> > > >  }
> > > > @@ -1830,6 +1830,11 @@ static ssize_t tun_get_user(struct tun_struc=
t *tun, struct tun_file *tfile,
> > > >               align +=3D NET_IP_ALIGN;
> > > >               if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < =
ETH_HLEN)))
> > > >                       return -EINVAL;
> > > > +     } else {
> > > > +             if (unlikely(len < ETH_HLEN))
> > > > +                     return -EINVAL;
> > > > +             if (hdr_len)
> > > > +                     hdr_len =3D max_t(int, hdr_len, ETH_HLEN);
> > > >       }
> > > >
> > > >       good_linear =3D SKB_MAX_HEAD(align);
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >
