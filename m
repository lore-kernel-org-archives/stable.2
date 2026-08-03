Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDE3C1F
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720791; cv=pass; b=Trvsay2L51U0T9M2MR+Ek8fr+/BUT+IQWv45akHPi9pSy0xnhv3FA5RFZNqOie8gSWbi4RRVHLH/sPUeCqyeBcb0wIuLq6aXg3fxla+J+uJQXaxjarRMYNf3cF78mdx3bspGsReQHag3TXyxRULLtbn8Ml75UVZQDspxy46NuQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720791; c=relaxed/simple;
	bh=hdzmpEyx7wmQQes5tKR6PInw0TXRMu3tnEXMX3bv/zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TielkRXBopgck83cdVO6tcmriYLOa96vyGj5p8lwvdGqSR2TsV+bbIMfsXWPjWu3RPFRMUKNvmyoHDellay2/DZJ2IEnNV824gl4ZnW8SebW4j5i0x98phQgmlv5yqPs+AVJEO5Eusgn9xkB0YrEMWVt1Kc0W7tsN1t8MbGpZrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxff5bxN; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxff5bxN"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6626b5ace23so5970250d50.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 18:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785720788; cv=none;
        d=google.com; s=arc-20260327;
        b=JHMEWYQN45z+0ufsHkJhNbCo4s6xgnWMPUOkonu85zSdEnmAptM/4gnh+JkIlhIXqD
         likjpPdac+SwzBTJGbLOjMKoC9u1lytQusaLPvc59wQ64alWPwuFkPTkhaFpDqXh8Rjn
         tBG70sFED0EQOxKOgzRPYNxKKbc0xFQkNN+enycMx8//ZovBZo6h4wnlHaqUXaED+ZyH
         jst9IFujFL9gSbGdoZkYhGtutmbtyY7j5rvbKO7HJ2qRWKtwSYMUlZfVkvojxfE6fwMU
         SDiRfsVGdyf4V7AqFh6aWX+cuX6ZTtSEe6N1zyeu/+UrkAVjNAR8QN7E2QKLf3gqrVWc
         QBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MtK1QoBX9EhvBSeTPFcat/a++KIi/D9hUCf5F/tRn3Q=;
        fh=Oz1P+lemdjSC1Dfmw6Z09vCgKG13Zmr35cxZr353pns=;
        b=hOncjmJU1HP7KGm/c3vHb9SO7zi4oQ8HQdCfANaLEJhq7iZHv9c70cDnN5K+mwq8D1
         kFMz1GZZU4tOOOK3gphaDm3juzf4UryISLev5Q+dfwQwjeE7upfvzV2yREmLV12Tlnga
         eBnZfJPAwmb4/0gbLeRwBv+lwapyying/fuo5SV7XzzKeyAuFZVlH5Bd/p86q+AsW6p7
         8/foluUxE6NkCdb9+0juFiUg72WxAycvDoWp1o+rYVLiiQT+nlKrDJ3N2cNetvJGixFH
         MF9LeZu7EaI41Br7aRlnhaPehXqY8ves8Yfa848seDlxqLE3ScEWGKXeNjHaByaQEBG1
         b0cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785720788; x=1786325588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MtK1QoBX9EhvBSeTPFcat/a++KIi/D9hUCf5F/tRn3Q=;
        b=cxff5bxN1mY09Ynidyu/GMTgRqPWYllE/6HBQFWqHZcbPtqslT5JTtOBdmC9TBuZOf
         1bBgNZL8QMdvjEK/ElzPsc4OKbrdzEFp51sDg2rONC/2owAbQezeCmizO0SAAyTf0DqV
         M/9SeWk2k2+8x7E0bml1Nv6c4g7VYcisoML9qADMIz92rSaODAuwE4STfQz5MpZYBGTo
         NIh5yFzEpOWEh7007NfpNxZ6bD9ifWSOw4iyqR1OyMfXnNku/WBgWgsyhlgMJZUvp6cS
         whaG8TLhzQR1+w8HdXXwThdc/OqrtgXUXkXv2VDutoG+tcVznTkYcgda/Dl4ei+lngSq
         lEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785720788; x=1786325588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MtK1QoBX9EhvBSeTPFcat/a++KIi/D9hUCf5F/tRn3Q=;
        b=dwWIBprwL2JfNjKExSKwDlbH/gPgjld5VC7u+f7/JYOe+jeFJn6FSUq3OF8EmrhuNl
         qtloMek0BVpS8wYTOBiGjNAtBOG8LdzXQEdUKExYo88jT6IzoxtLJ5jJq9hFCiuxHxHP
         3Aet4O0fuz9kT1DY1Nw6G6Xx0qM7JTedAz5JZHyTUF8metp4EqmFewq+tR6rIlARQiQE
         TfhkxlSHuhVL/+MORN6ZbNCPX4GGp6kTCtj8hz6cf5r5Ewa8jKUfzPmLcOPPYvip8BFK
         6criTIN0/4MvLteLB288+/2oITJ8mR3lB646AoYXAbNm0bhtqomSv9sSFvmree/hWUdR
         3iPw==
X-Forwarded-Encrypted: i=1; AHgh+RqA2K90UuYq87LoxNh1ZEnhBrqoI6JAr7iE+1xeTY/Zd//cwt2UOygAltZ+zqioC2nItYnQd9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJWAWY3Y2tk7aKIvH1Vpp8Z1wfuHWyzlBXQNvj31OGdzmPw2O
	cVTFKUZebl4/JfiIshteaADeEHaKodDlOY6RZu5rQZkULgHqe+gYPtdq8Ey/eqy6zh1fyIlmjYf
	rK/Z57KgohCq8ws2kO5LqL012Ke4UaWY=
X-Gm-Gg: AR+sD13skl9rJ31Vj7yDXd3QctkE3clHpPu7kV+1TmfVj0iVwqVHb0C7b5UocoXOQ6Q
	PSHhtJTJJU8yw+kIREYz0wl/FAcEc8l1TlKZUZV1q2zAp19WWWGU6BqLRRs10E0fT6sbRkVsRoA
	RB0EhpnBzlsTFx3tQBn3fuJO1FWOR+mZLEr+OXyDnNnWqA5JpH95sNoUrGAB9wW6acYqsPQqsxv
	YASZj17pcEaewMEGtg08EWSmRoosf+JMpsT3KDVgNjlCIW7iE9m8Tf0+wMKJpt1UC8dEXlgD8P1
	QxDm7xoKYk48irDY+w43C+Q1zkQ8t0jGx5KZOdlf/2rBvAg0cFJpmIHhuDAFOQ8/srrS0SeGCk5
	hgNr4zu+W0I9ozD7+bj7/WLNl
X-Received: by 2002:a53:e031:0:b0:667:8471:41a2 with SMTP id
 956f58d0204a3-6694f9ec735mr7732211d50.25.1785720786742; Sun, 02 Aug 2026
 18:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-3-sun.jian.kdev@gmail.com> <80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com>
In-Reply-To: <80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 3 Aug 2026 09:32:56 +0800
X-Gm-Features: AUfX_my1NUSs3oqdmWxM7iAAroMNTq7trteihXH_7Nm5heweklKCXTUafeNBAzw
Message-ID: <CABFUUZGTJptpOKKAeU3ThibmPpXize4Eud2=EBX-vqaX3YH4pg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] veth: fix skb length accounting after XDP frag adjustment
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Krishna Kumar <krikku@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	maciej.fijalkowski@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 12:14=E2=80=AFAM Mohsin Bashir <mohsin.bashr@gmail.c=
om> wrote:
>
>
>
> On 7/30/26 8:23 PM, Sun Jian wrote:
> > veth exposes non-linear skb fragments through an xdp_buff. If an XDP
> > program adjusts the fragment area, veth_xdp_rcv_skb() copies
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
> > The fragment accounting must run before the linear tail adjustment:
> > when bpf_xdp_adjust_tail() shrinks the packet into the linear area it
> > releases all fragments, and __skb_put() requires skb->data_len =3D=3D 0
> > by that point.
> >
> > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened b=
y
> > 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> > corrupted payloads. After the fix, all 10 runs matched the expected
> > payload exactly.
> >
> > Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept =
non-linear skb")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >   drivers/net/veth.c | 23 +++++++++++++++--------
> >   1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 00e34afd858e..348391e87e14 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -865,18 +865,25 @@ static struct sk_buff *veth_xdp_rcv_skb(struct ve=
th_rq *rq,
> >
> >       skb_reset_mac_header(skb);
> >
> > -     /* check if bpf_xdp_adjust_tail was used */
> > -     off =3D xdp->data_end - orig_data_end;
> > -     if (off !=3D 0)
> > -             __skb_put(skb, off); /* positive on grow, negative on shr=
ink */
> > -
> >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +      * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contributi=
on
> > +      * from skb->len before updating data_len, then add the new one b=
ack.
> > +      * This must precede the linear tail adjustment below: a changed
> > +      * data_end implies that no fragments remain, and __skb_put() req=
uires
> > +      * a linear skb.
> >        */
> > -     if (xdp_buff_has_frags(xdp))
> > +     skb->len -=3D skb->data_len;
> > +     if (xdp_buff_has_frags(xdp)) {
> >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > -     else
> > +             skb->len +=3D skb->data_len;
> > +     } else {
> >               skb->data_len =3D 0;
> > +     }
> > +
> > +     /* check if bpf_xdp_adjust_tail was used */
> > +     off =3D xdp->data_end - orig_data_end;
> > +     if (off !=3D 0)
> > +             __skb_put(skb, off); /* positive on grow, negative on shr=
ink */
> >
> >       skb->protocol =3D eth_type_trans(skb, rq->dev);
> >
>
> I am most likely missing something here but what happens if we have
> frags and we attempt to advance data_end while leaving some frags
> present (e.g., bpf_xdp_pull_data())? Looks like, in that case we would
> issue __skb_put(skb, off) with off > 0 and we would hit
> SKB_LINEAR_ASSERT() because skb is still non-linear?

Hi Mohsin,

Thanks for catching this. You're right that bpf_xdp_pull_data() can advance
data_end while leaving frags present. I'll investigate this path and follow=
 up.

Thanks,
Sun Jian
