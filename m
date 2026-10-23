Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792762244;
	b=i16dpBYfAhF3ea3RwJX9dxrFi+9JC9jrW+D7pBoL8DPnwPo6/cTUyeohUhE7KtGzVLOy
	 uSJkyWDqH1Fcw+H2cuU+CamqKLU+UoR/mGj0zcuRg9qQe+RCP8zCDdTERrnpQQMdlITHu
	 230q4kWaEhsH8dt0spuUdJqOyY3s1+tMmcxH2PsDdDatp3VXVCrUj9kFv/SGUG+zvWZsb
	 fDwfR74gTlniy/JfcECQKqUv2Wpx5TLjZDgeDVr6jpBoYfxkzmi36AnwN5VbmVF8zgYP4
	 anX7SELFnfmRRAFbjyP908Vp6fkzYlQ159Ef4KDMST8if3u26O/dpA6VFLKRlBmXBIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EzyUwj4JVUO6rIYPoKDgIaRZk8W7xi8lTeg5fGqGBVQ=;
	b=tX4B7HkKM+mvQQ+Goydj+xsxwNtEWmBqfb30Sg4M3uluQ4QCscQBDCRGO6QlumLYzTuT
	 Ywy8jIjrNJVEN5G8rMPypsWS98D5KRDaQfiIOWBKXR3iLrZGCfWgjroOrGIffe5tI0bsl
	 1y1sU+ACK73Ga7k8jPCO8gmGnsiLj5qsJKPV+G1zzchaOC7GDMJFH1LQ7MEs2aE8yhvJ7
	 jrbIXmtSg7z/uj69IYA+mhiTlrxRlzBQoFjaQkCc4VAP4guFZDvlZ2jfksX2/sBTYAf6n
	 7SNtRFvD8OlmZS1mKdbgZdTNrr2a5bXMaRV3SELBbrh852Bqq+fOzTx/nsTn2IdkGEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="fs6Y/1ZR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130A3606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 130A3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=fs6Y/1ZR
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so332549a12.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792762243; cv=none;
        d=google.com; s=arc-20260327;
        b=PgzuLTSVZ+Z0XPLZ430RIE1PQSOvqhUbUmE34bf6CMQfd6Vh7PAs8Rca10aX8fjcXd
         CJq27UES/bnD2ITZXEvOGbrTormKarzf0+MVvc0PUiG79du2zY9IwJNQVrSHvK2cHk24
         rwxcxoYY6x3lGL02N0iobnW3JHhotIT+/Qf9a3CmLxUFTNM39AxcI9RKJsJZdyCiadt9
         EYtUZIEHPImBIkINRDlaEfE2Er2arF5wusz4vngplnCanq/SKu3EKr5BzlLh+Gcf/DZt
         nJdCJCW+paeeNv/QuQVchPm5UQg1vtlOVejNcaLLe5ypfI2nSK3EYWDIqFuId4gsceOU
         YIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EzyUwj4JVUO6rIYPoKDgIaRZk8W7xi8lTeg5fGqGBVQ=;
        fh=Mx+ROmNp2nO68rWRdHV8nmYY7uK2jfNBHKuZtQ24QC8=;
        b=sF3F4VtBWYWaA+RErBJ9clfebjJ4qg5OQkmluBkbmFkhKHktws1hvrDUIRfoYCopJY
         rL6k3CUJX6R3GlNQdHJOGfbVYgnL2t5R+lyuqugv4fm4n2Fb6CNsIrN2pYFkNKfhCF2j
         HJ9Gj0twRiJcsZO3UCzseJOcXMkHAVdMOmINiD2R/0hmoRILposJvU4PH7xAP4PPXUOz
         JewXkL6EDiLHYGgU4p/C2IXj1+pHsTvuWeiIf1jh+eQG9PcRQwEfIj49r2KUjc4Sxxd3
         PHQP4LxstDgqK+Q6VvRnvhYiiZpqpgRStGRMq1vzdt3w2W51mFf/rl1xDKzRLZ//Zh6Z
         3Vig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792762243; x=1793367043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EzyUwj4JVUO6rIYPoKDgIaRZk8W7xi8lTeg5fGqGBVQ=;
        b=fs6Y/1ZRnc/bW5mPINgu5toojKOWvH2+D0bLnUiuVCaR7JrSN0hq4FJCZqSGq0/mMk
         H+0svpBzSzGnciiCRb8xn+HS3tpNU0eQJZUAqxjqDHor+Z+IupsOv2sqFzPB67N8yFzM
         netOzE5HSuKx4tJni6HSW8RVrumn0ir7oxASo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762243; x=1793367043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EzyUwj4JVUO6rIYPoKDgIaRZk8W7xi8lTeg5fGqGBVQ=;
        b=hhxy2dor4w77FwAI4+cUkx5ADe1jJJu8BA7KnqtJpzkakGtIWE24i5ZFogSwgJ8CLf
         iKlgFcx7MFsHFc3zhKMUevWkTVs7XR4mp4ZUSaTyjtXV0snsjRp00M1WHiRCZpdAz7k5
         R8gVgP5rhxG1s+NTj4Bog0VQE16Tl5JATWn+Nn1ZD0m2DRpMB6s6YANyniLYSeMYupKL
         CFPejtco4pGORRgtzlMYc0gBq0CB+DB5TZkZLCMf0xmhMKH/CXa5+43b2kHYtO/8dZci
         aTwaDRegCcYRFekE/9cfWWvo76Wcjq+S39n91lrsBRJW+9DFm3Pub4dl7sanUZ57CeYv
         WC3Q==
X-Forwarded-Encrypted: i=1; AKwUvBymCCa3NcACmf/IcN7RG4iAklUF+KZaBkUBRGjXKycTKFKSGu1Hl4IWOQc6zGGvOKawty7W2RI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMV4P2P7GKd/qJ7mmo3ussJ5fNGxW93tJtlPChZ94611GyZpEB
	veKF4/oih58Pei2sLgOvFaDVlDIwh3bwpcjkPF/vymrOXc3xSDRf9S0tGfnwkDoXbmLGsacAn+9
	U+bPggsou1zUv7O5CceTbLCoCahRd8W3nKhCowDg1GKMABPGXKok=
X-Gm-Gg: AYBFou0r3egEDhUdg4JtTEABX9C2SkN5XXQEdtqGYnaQDLL8sg9HceK3dntPXeLcTVO
	PHbsD/w7ZrppWzU4nNYjOYoIVxQaaVEW45tGZbdjYvDDJaIG79qjV7fuFdiF0Hnc5R+ig/3Mr/4
	Wukpfs6KTpCBf5jpRPA6lV1Yx2FO5/KYrsFas3KDnOzh4Dww0Y/crD67XgJgWGaG2Xak3PPnwqg
	GX2fhUUwCTCeLcwHyE14yeM5FxhgjQI/kYjYnEZywTJBRslEH2aIXIEh6nNMTdkAu+K1yjDAF+P
	sCV09WOwfSApZ4X5ATL2o7UwH2Y2L8F/FN8glWmtwMx9rP7uevYW26SIVfHDUMwWbhV3HtpXhS2
	qy+207f8cUXcJmW1GoUF6eZlsTWJ2J1/eZ/blqE/8syLLp/qtzwFkZTKcZUH+5tdrpIOQE6aq1p
	vD++24R2mE/wzOCgU=
X-Received: by 2002:a17:90b:5586:b0:3ad:53e2:78c1 with SMTP id
 98e67ed59e1d1-3adce3cabc0mr1925448a91.10.1792762242957; Fri, 23 Oct 2026
 06:30:42 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
 <CAL4Wiiq3h_OoVo9BpBy0pqFe=AeyN25QxsU86h63qEf05uCJRA@mail.gmail.com>
In-Reply-To: <CAL4Wiiq3h_OoVo9BpBy0pqFe=AeyN25QxsU86h63qEf05uCJRA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 09:30:31 -0400
X-Gm-Features: AclHuK-AtjMVPTuxOQIAGGLhH7jsTp8sIy1-bsoXjryMRSrFvhxDPlKmWOEc5gU
Message-ID: <CAM0EoM=T4TNbkj98y=65OZnppkZ=5b7q=Kvk2k7A982pApSZ8g@mail.gmail.com>
Subject: Re: [PATCH net v2 3/6] net/sched: act_mirred: reject redirects
 without a link-layer header
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 9:17=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le ven. 23 oct. 2026 =C3=A0 13:59, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
> >
> > The issue:
> > tcf_mirred_to_dev() may redirect a packet that has no link-layer header=
 to
> > a device that expects one.  TUN builds a valid L3 skb with mac_len =3D=
=3D 0;
> > mirred then pushes zero bytes and the IP header is parsed as Ethernet b=
y
> > eth_type_trans().  The same happens after a VLAN POP_ETH or MPLS POP ch=
ain
> > whose producer did not leave a full inner Ethernet header.
> >
> > The Fix:
> > After the existing push/pull adjustment, when the target expects data a=
t
> > the MAC header, require a link-layer header of at least
> > dev->min_header_len bytes and pull it into the linear area.  Drop the
> > packet otherwise.  This mirrors the check bpf_redirect() already perfor=
ms
> > and keeps the legitimate push_eth-then-mirred case working.
> >
> > Conditions to recreate the bug:
> > - create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
> > - attach egress mirred redirect to an Ethernet device (for example lo);
> > - write a virtio_net_hdr with hdr_len=3D1 and an 8192-byte payload.
> > The unfixed kernel parses the IP header as Ethernet and can BUG in
> > eth_type_trans() via loopback_xmit.
> >
> > Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions"=
)
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/act_mirred.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > index 553342c55cf7..e3e0e4aa70a1 100644
> > --- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -316,6 +316,11 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, =
struct tcf_mirred *m,
> >                 }
> >         }
> >
> > +       if (!expects_nh &&
> > +           (unlikely(skb_network_offset(skb_to_send) < dev->min_header=
_len) ||
> > +            !pskb_may_pull(skb_to_send, dev->min_header_len)))
> > +               goto err_cant_do;
> > +
>
> Oops, sorry this breaks tools/testing/selftests/net/forwarding/tc_mpls_l2=
vpn.sh
>
> My bad, the skb_network_offset() part I suggested in v1 is wrong.
>
> Please remove it:
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index b0390b08600c4a709b18f6d92aebe6629081c735..0bd73c5072a90d3e952d0a724=
461adcf0307592e
> 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -317,8 +317,7 @@ static int tcf_mirred_to_dev(struct sk_buff *skb,
> struct tcf_mirred *m,
>         }
>
>         if (!expects_nh &&
> -           (unlikely(skb_network_offset(skb_to_send) < dev->min_header_l=
en) ||
> -            !pskb_may_pull(skb_to_send, dev->min_header_len)))
> +           !pskb_may_pull(skb_to_send, dev->min_header_len))
>                 goto err_cant_do;
>
>         skb_to_send->skb_iif =3D skb->dev->ifindex;
>
> Keep only the pskb_may_pull() which is enough to prevent
> eth_type_trans() from crashing on a short linear part.
>

Grrr.. Eric, you are not allowed to comment after this.
I should include running those tests going forward when appropriate. I
only test tdc and reproducers.

cheers,
jamal
> Thanks!
