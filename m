Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792684904;
	b=kTyDPkfjSEi++6kv89Oa8EYtTxZtqARj3eb6K4Xjz+7pk1PNxo5AzcbRSlApThvVQ5LK
	 uyjDnfNKo4/WZ4fHTgdKmxDW1/3iuvgShnEYF0TcFHEyWW0/wXT7o6x9lRUEZA8E7fmP/
	 2q6SsKaXL1409VKBjGlfTPmNGyYvPB67AG2COMgisHjqmY1PmInQi8gE/tkb+BHqGwH5v
	 faNkALMf3aXcVl3FydIJtyk2f9X9u6qbWdszUmnAQV9TT0iYrshIEBcVikc+yOp+WPU3m
	 PfwHGLGJgI3K9vfhDcBfdC7aXTJNUySACgCp0+TLbv/Xcn9F+kFELURbmw4pLm9pdJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S6BzR53XkcYWnJTROJDWWc96U2wGkZB/h4YFyc/vD1Y=;
	b=mZtWFWVCA3wYsah5oWkGLq4FAWCidWDOazGHgN4XGF2K2fOBS+BY17a/SdTmIQZGyOo4
	 VYAtrTM8mbGrIA2+GiaRJN5I17JpVMI9h4d4Ur5zdjE/YEreiq9xzR0oIRMXxfwg6MclQ
	 epX2FlcKm0dzCiZSbkXpzjOlQuR8ta3XBJ86tZTzOhA2b1uCH5KNwnWf8eX45c0iIHq/Z
	 efUzGXi1RSoBH58WEdTEyh4uyh5OlX9BeH+B0xex/Q8DiH/hCVvDp3n8alhTaVkTo3+BZ
	 kiNWDFk4iBMMXYs9hBdmih/9SiIukDm3PX7k0SxKQcnXqaXvFoJgWE92A3/u2PqMN5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=m+f5lWNJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE69606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE69606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=m+f5lWNJ
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so22847b3a.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792684903; cv=none;
        d=google.com; s=arc-20260327;
        b=ePYLnnNLfNuNWhBA/O3gmVCWVNKHBNYXBMX9fbMPTwz1QPvZyJ668UahkFvbgjWLR+
         yLQpWPaWAQvh1ELrB4q8OryqKcp1IhjwF5etbZM8Lj3fE5SSmwATrVneYLP5qoJLcAzq
         L2EBKhGCSxb2Zc/+OW30zarCf30cxCE2kjsyK2vQDItUYHcwCmCJFmvG1oMZLS16yFM+
         ChA0V5bC10rkaN1HbXn5HcWIFmN8m1FyxHv4toc+zmRrD0ypx8cP10xiCSYo0e0hofvx
         HMPRS5ng/5elyTCsuKWX7F1OF8Tm3oc7yHKW4iUcKtjDPtqLxIvIYfq5uitrRccrqM9L
         YJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6BzR53XkcYWnJTROJDWWc96U2wGkZB/h4YFyc/vD1Y=;
        fh=RJjRotZgG8q63DEveLo7NG+BoZzxcek5NmgqkXbZ+lQ=;
        b=Eb7aKWgmglote4CGTW870hQLB2HwBuA0nmTWA2MUeFg4ptrlI69VdPEljKdNBEymQJ
         05j811shnkYvh/sb9zMeBfG1u6i7PfOOvXTxpxNhVn6WJmb8bZBEEuiJ1OwZab3rq+SU
         StczvNDAgQphtpAbolAUkPjAHTEa37lnf4UqL5poUdE2r/rFnDJErsWGXJJkv8vALniH
         /iuuRKSHZwhn7naoG1evy9jrIR9Nr54pZxYyNPrYAOJwp6eq45s4BAhj+hAGSLbfLzXj
         /1BuROHY1tpZxD/7+3f6Zrz9BVHGQ+R6z1jIW5YHmpKSXmoZZq0kv574yrghBRg+S116
         /ULQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792684903; x=1793289703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6BzR53XkcYWnJTROJDWWc96U2wGkZB/h4YFyc/vD1Y=;
        b=m+f5lWNJhnrnTVhzqermTyNGDuwZEXtHxT8p9i91KKg5Rufk4Rp8jE6prA1pkVWRY1
         NBZU2CvMI/pTtWypFk9W3AaAUnmI8m/m4aPg7xTGF0W8eI92FoAnZiCqqV2ZRaFQ8AXf
         gGsNJZAnWjV72cTsGrSG6yKBtX95pM2MHqRMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684903; x=1793289703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6BzR53XkcYWnJTROJDWWc96U2wGkZB/h4YFyc/vD1Y=;
        b=ZJIX91BNVgAUgt8MH3F02Tnc9GUMWhW9q2ztJ7z0ItGy6uf6NMSpD+BtRVwed/ujax
         etdrAxLtV1AHl1QbuaSKMTYMSEdH25ujJuvZPPIgwbnmjkO4L5TV+pe3OYh+mezQB/Hu
         07ChUD1DKRSp9Dh8idkgrUF5SF/tLmyswDlTe7uwWiUAzzAf17bkrH3KOafYZ50sYEQ7
         SK3vmfZjrtufA2m0+rVT/sZZBZzvv9gd4yyeeaTrSL33y17MV+iEKkY5yL2VRseqw1ID
         VGhiB315KoEbwxPvPHHzl54ZeG9sq/nq+KvVDtne/Fne2pkY53dZKan84pjHFgjKQNOs
         cZQw==
X-Forwarded-Encrypted: i=1; AKwUvBwH34dQDk88DFl0Qde5ZLIep1GuA5aTIA++S0+yKMzeXw7Tyn0LcIwT97jwf4bhThhGXVw7UFw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgnHqTGagNqh/7MHgwLWXGUx+j7xGGvo4fcAX5BJ9BGPUI80/s
	fT5uZehCD8F+74mVhBGfw8wZ3Tfs86d8atT70XqPQ6rf+faOWFsyxqS51oZZOjS4mZCImYA4d86
	xXnLo1VlEC0QWICsVBV9mPxiBrs5RaI2BwFsE7nx9
X-Gm-Gg: AYBFou2cgj8PTTT9/l5XtpGAjidG7E2OE+XWtWXy7IfmBiLR8NZ8GiZtXIIj+7miAVZ
	mYkV3SP1MdixLBz4vDXxKirwutnYE4KKGpplWACf1iaJjyrB6OQ9hY/Ll66Xse6qYyvPYVHZoJa
	30tAtzaQi0OpaTVYFvgsDvS1zqqmoeSi3pWA2RjQgwx/+nyzrTaOcP0Y5cBot3OrQXqwCoLmdyV
	GRDAMA/v/wiDuKWTNUisHQrxRIi/z9EQKQP05OwcSmnU2TqQOXtdgTLgeyZYeV+rweREN6sB6zH
	Zfqc62RWfTzSC/OaOnX+q9gJOdSnxIL2T0spOUj683NyacgJa9NuVDlnUGjbZE2iQTvHvFu3pln
	bHs1aKXXcaQWcJKrshfcltwEW80GlLZ8Uhx7tLUyHNIZjas2kp+eUIsP0Ic8o4NeGWk0Mbxy43B
	V4VMBCL3IHfX5FVdQ=
X-Received: by 2002:a05:6a00:94f2:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-8a089d4b9demr4627712b3a.52.1792684903101; Thu, 22 Oct 2026
 09:01:43 -0700 (PDT)
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
 <willemdebruijn.kernel.38722ee638a21@gmail.com>
In-Reply-To: <willemdebruijn.kernel.38722ee638a21@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 Oct 2026 12:01:30 -0400
X-Gm-Features: AclHuK-5CkW0mOltEfM9Zb_u_0BHBPvpxVVM8r2c2XDj_cPKyz7BcCck9T_aWJE
Message-ID: <CAM0EoMnJhXQPxfU65oLYvpc-a6MhZSKi-D664fTMLah_6p7G2Q@mail.gmail.com>
Subject: Re: [PATCH net 1/5] net/sched: act_vlan: reject short linear Ethernet
 headers after POP_ETH
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Guillaume Nault <gnault@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, Ren Wei <n05ec@lzu.edu.cn>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowangio@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 11:21=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > The issue:
> > act_vlan POP_ETH can leave a linear area shorter than ETH_HLEN; a
> > subsequent eth_type_trans() may then BUG in __skb_pull() when the frame
> > is redirected to an Ethernet device.
> >
> > The Fix:
> > Drop the packet at the producer boundary when skb_headlen() is shorter
> > than ETH_HLEN after skb_eth_pop().
> >
> > Conditions to recreate the bug:
> > - egress tc filter on lo: action vlan pop_eth.
> > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-line=
ar
> >   eth / inner-eth frame.
> > - The pop leaves skb_headlen(skb) < ETH_HLEN; a following
> >   eth_type_trans() can BUG in __skb_pull().
> >
> > Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
> > Reported-by: Vega <vega@nebusec.ai>
> > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3=
b.1782548651.git.bronzed_45_vested@icloud.com/
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/act_vlan.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> > index 6a375fdc63dd..ddf03b08bfe8 100644
> > --- a/net/sched/act_vlan.c
> > +++ b/net/sched/act_vlan.c
> > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *sk=
b,
> >               err =3D skb_eth_pop(skb);
> >               if (err)
> >                       goto drop;
> > +             if (unlikely(skb_headlen(skb) < ETH_HLEN))
> > +                     goto drop;
>
> Could it try to pull the header and only drop if the packet is too short?
>

What would be the benefit?
Note: the OVS patches pull because they must restore
MAC_PROTO_ETHERNET and already return an action error, i see a good
reason there.

cheers,
jamal

> >               break;
> >       case TCA_VLAN_ACT_PUSH_ETH:
> >               err =3D skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_push_=
src);
> > --
> > 2.43.0
> >
>
>
