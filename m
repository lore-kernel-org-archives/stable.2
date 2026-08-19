Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7F3B14AA
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126855; cv=pass; b=Vk7cMWeX4kMpL9L1CPkdzhxm7cre7xcFKW1S6ye9lffnfy8e3le5GEC5A4nHlQOBpXhL0cIBzr9qmirZAW6jmjO6DJflsyWgm6SdY7sqr9AZmc0EH2AiADZYuPjNDMznosVrt599dfSfRjIBEoix3J5+VRxSNgJcEWbsSwz0GdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126855; c=relaxed/simple;
	bh=baRmk4Qvhw/LzkjrWqAMkrGFR/B0SOBD/+q6h9uTGlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3h3ZubsPm3Dz4hUf309ivCzw7c53uNZftKsYpvXKtMjxDL9PgnrdilvwrlHCdv7hXr3ZpUY5aMzy6ea+G6+9wL2O0Mbzok3SwE0b43mZxpsZ0anA2LFvXgPK/idnS8afcvXapcKK1P30dkHNla03OImC4339fPaHckd4MIa+AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4uUrY9Y; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4uUrY9Y"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2a449c57so4369301cf.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 01:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787126853; cv=none;
        d=google.com; s=arc-20260327;
        b=gZSYdH8FKZAYrAUCMEgFulfG6FRbhAX8HQfMw296bZ0IeFSlAv5ZcZmA3yJW1qZOnB
         dOpzR8doGhHVtWt7kiFBhvjFNjz0Swsj+YbUfDsqchvGAvpdCF7qQVDlyWvHTJTBue9f
         XeBdHR9UhhcIDZdCSyA5M2kVOsH+F+uX4epsO88on539Jil9m+Jwy/+G2z3Tn5C5jpbg
         AA74L2QmLeweTJEZEdp1f0/MLJjoQoaS3esioPHwuppxp8s0L3NoSmR5TJDLuyk5Gd87
         IWLJrsDG8pqLmSIGh08gdVQ2pN4lzjQ4soSL0WEJ7qZEO9QArXOnIGePMNoThaLiapdW
         kRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cBXk6VgXSlRScji19Z2SNW4cHjYOtpgvN2jTyotG9qc=;
        fh=dYToJjCyjTRt9QGk4xzab7kUVyxCDQ0ljpfSRmGzv/A=;
        b=cbcjFmMYkzzxv89VrZXeEhp3fKuz4ajkbLV6Vqzfjo5bY1MY7NT7ucOlVht1lzIuQr
         9Nd1tvwKV9ZVnit66h7OaAvYU0fc0i4BJhyp0hr4qQen9DCINLhnYt1B6pCNjKa4IRU7
         es75ZDjl61Su4Y6ofoWhaRbvmwqOZ0dyooVb0cibkkGxNuoZAwphsXJSLW/zxnkbMCKR
         jUZpkBmRT6L4KJ6Qjsd14gyV3KaJ1LJ64Wi7PtQ+LE4I+8iMil2yLlvaIv7d+WCMEvGH
         Zp3Gap0dOB21hBTKq0FGhb6toX6gIvQE/pYe7QtCQzOMCW+f0mU4Y9SO+mMnUhVlTBQe
         dNpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787126853; x=1787731653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cBXk6VgXSlRScji19Z2SNW4cHjYOtpgvN2jTyotG9qc=;
        b=u4uUrY9YpwJgEpa46t281BmhGNQW3EeIehkaqxLVq9F6v7aF3oZlLTmk/aPgLcg6NU
         9kFn0VAswIONFoy5j+tY3uHQrW+uXiTRuaddDq8A3agHZb83c7Si16D3PTqjlBMucHYI
         6jU0Wwhm071S27AgSLpaAwRlHNfPshiE/PVjOXQf2ECF9eYCGVtbBBcBnfINRWQCziPE
         OklJD8XTdRTI9UOi12wweOiHjr5mG9968RrWV4lgehBt4Y7ccmxxG2NZMCBlRgLGwpdt
         2Ak4aVTDGuqFSpsipQ3LhZC24XA41ACjND/LZJrnI5Vh9hNg5hTjRAUVXKnR4QnzYMg/
         MO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787126853; x=1787731653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBXk6VgXSlRScji19Z2SNW4cHjYOtpgvN2jTyotG9qc=;
        b=l8/oil6H83ti2J+bNqJpiGF2f+84CCTuC0bgCPhgcnphEaoKPdFnt789SVb0/AP8YA
         lg6TJhyM9ayTR0FrXIgZBxg+iLtJAE5gAoldKyPdX1Y+xePSn/+Hq1p05Qn8rLoRzlb/
         JKBFW9PDrHvpHPlt5YyrPHzNrWDgbb9pEqJktqayq9oh8W16oxjKqSs0XeJi3Y1kmkIq
         YeJKQ/wfWVb2J57+xBsdS19mSZhkiE7fTKbBWSCMLHAMyBhBju7pe6qJyQoJqRjBkvj7
         A6kSBH85tQktO74ZEk+Z2XiTrw88JsNs6p4rzyzjZrweKULuWRzad6gwfkkNmSeUGBqO
         7K4g==
X-Forwarded-Encrypted: i=1; AHgh+RrssCrCH/QOSsU3jFG5VCE/3SHJQNpAuL/aJbd+2NnR3j0pr1NdDvy/hPrXc0Gz3wob04qZ/mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAmbULH2UWbcGeNqSiPQWmDTkzrfS5N5vi1BEKGmEQn21sL81
	tUFWb+bsQwf6rcFbOIgzN9tGPb4id/wpqZGDJy9A+HZVK2HmPnX56eRLOtnq3SiCIL+zH4UdhAq
	RxvAGhmhE81NIM3o9hBhLsJEwfQSzCOaGlm+JIhx/
X-Gm-Gg: AR+sD12nZBsVAFy+7t50nQ24UgbbdIWFPs4y3pEbUl0ThnOzhWnBb0NTkP8KEXXk4jp
	euRM3emyHs7S7JoqutaOO2njYeaiysqOPt/PHavycuEwVg5S2vCzz6igCj8IrDKhFQzHnhejH39
	7bFEUrlz0MUdCQeXHh+h3rGMinnevSerdK6W5C9pkA8mBUuw4GuORbOxqjLop2RIdLQzyS3IMUT
	yzjBIdFT2zK9PsEFhY+zBJJRs8SV6TOGtG7zFAzYkj9gUGQ8GVKuH0uMMWz1gtIHzCJGbXv5ZUi
	ttnBY/qG8XubvQ1vwo2AKE9m23Agq/5ZBM2w8zaRPH/dSKRgbRmuawsVz1IqNh7q3YgIo9r7ku2
	ZT5WTidXnsJAMkkP8kgeSYXeL5UEhR+XL8lGpa7v7wcR+60t73c9lbj2504SuA/1DpBeQo6LH4I
	o4hHVVfw2bTygTXWU=
X-Received: by 2002:a05:622a:1788:b0:52d:8743:bc83 with SMTP id
 d75a77b69052e-52dd5cde63bmr25039141cf.34.1787126852435; Wed, 19 Aug 2026
 01:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811085246.2267779-1-edumazet@google.com> <64a0b57c-040c-4703-95eb-886701bdf745@redhat.com>
 <492adef9-936e-490d-ba1e-3d026ff1223a@h-partners.com>
In-Reply-To: <492adef9-936e-490d-ba1e-3d026ff1223a@h-partners.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 10:07:20 +0200
X-Gm-Features: AcwNN1W1ivjjumBg5HEAZjczCn4z84zhMBIZXEHXgS0d1Mn89WnebdnetcR1H2M
Message-ID: <CANn89iLdXQGiLRFTjZOiskWhyKq9nOQJkQ_OuLCHhWw5h8W6kA@mail.gmail.com>
Subject: Re: [PATCH v3 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: xietangxin <xietangxin@h-partners.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 9:49=E2=80=AFAM xietangxin <xietangxin@h-partners.c=
om> wrote:
>
>
>
> On 8/13/2026 4:49 PM, Paolo Abeni wrote:
> > On 8/11/26 10:52 AM, Eric Dumazet wrote:
> >> Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
> >> NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_featu=
res(),
> >> which dynamically changed vlandev->hard_header_len.
> >>
> >> This causes two issues:
> >> 1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_outpu=
t2)
> >>    read dev->hard_header_len without holding RTNL lock. Mutating
> >>    hard_header_len dynamically under RTNL creates a data race where up=
per
> >>    layers reserve insufficient headroom based on a stale hard_header_l=
en,
> >>    resulting in skb_under_panic when vlan_dev_hard_header() is called.
> >> 2. In addition, vlan_transfer_features() updated hard_header_len witho=
ut
> >>    updating header_ops, causing a mismatch between allocated headroom
> >>    and header creation.
> >>
> >> Always setting dev->hard_header_len =3D real_dev->hard_header_len and
> >> dev->needed_headroom =3D real_dev->needed_headroom + VLAN_HLEN uncondi=
tionally
> >> ensures:
> >> - dev->hard_header_len remains 100% static and immutable at real_dev->=
hard_header_len,
> >>   eliminating all dynamic runtime updates and data races on hard_heade=
r_len.
> >> - Upper layers allocating skbs via LL_RESERVED_SPACE() will always res=
erve
> >>   sufficient headroom for software VLAN tag insertion (real_dev->hard_=
header_len +
> >>   real_dev->needed_headroom + VLAN_HLEN).
> >> - vlandev inherits real_dev->needed_tailroom so underlying trailer/pad=
ding/ICV
> >>   requirements are honored.
> >> - AF_PACKET SOCK_RAW network header offsets remain correctly aligned a=
t
> >>   real_dev->hard_header_len.
> >> - vlan_header_ops is used unconditionally.
> >>
> >> Note to stable teams: Make sure to backport these commits:
> >>
> >> e16e960d55a4 ("ipvlan: inherit needed_headroom and needed_tailroom fro=
m phy_dev")
> >> cef51860becd ("macvlan: inherit needed_headroom and needed_tailroom fr=
om lowerdev")
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Reported-by: Tangxin Xie <xietangxin@h-partners.com>
> >> Closes: https://lore.kernel.org/netdev/99d678ae-c7b2-4b44-b534-b832067=
9deb3@h-partners.com/
> >> Cc: <stable@vger.kernel.org> # 3.19: e16e960d55a4: ipvlan: inherit nee=
ded_headroom and needed_tailroom from phy_dev
> >> Cc: <stable@vger.kernel.org> # 3.19: cef51860becd: macvlan: inherit ne=
eded_headroom and needed_tailroom from lowerdev
> >> Cc: <stable@vger.kernel.org> # 3.19
> >> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> ---
> >> v3: propagate needed_tailroom, add stable tags.
> >> v2: https://lore.kernel.org/netdev/20260724035419.1473174-1-edumazet@g=
oogle.com/
> >>
> >>  net/8021q/vlan_dev.c | 39 +++++++--------------------------------
> >>  1 file changed, 7 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> >> index ec2569b3f8dac629027b4344bc89402decf026d1..2859cbac3f266b7c4e3f44=
f41280d33ab69c5270 100644
> >> --- a/net/8021q/vlan_dev.c
> >> +++ b/net/8021q/vlan_dev.c
> >> @@ -502,26 +502,6 @@ static const struct header_ops vlan_header_ops =
=3D {
> >>      .parse_protocol =3D vlan_parse_protocol,
> >>  };
> >>
> >> -static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_=
device *dev,
> >> -                                 unsigned short type,
> >> -                                 const void *daddr, const void *saddr=
,
> >> -                                 unsigned int len)
> >> -{
> >> -    struct vlan_dev_priv *vlan =3D vlan_dev_priv(dev);
> >> -    struct net_device *real_dev =3D vlan->real_dev;
> >> -
> >> -    if (saddr =3D=3D NULL)
> >> -            saddr =3D dev->dev_addr;
> >> -
> >> -    return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
> >> -}
> >> -
> >> -static const struct header_ops vlan_passthru_header_ops =3D {
> >> -    .create  =3D vlan_passthru_hard_header,
> >> -    .parse   =3D eth_header_parse,
> >> -    .parse_protocol =3D vlan_parse_protocol,
> >> -};
> >> -
> >>  static const struct device_type vlan_type =3D {
> >>      .name   =3D "vlan",
> >>  };
> >> @@ -580,14 +560,10 @@ static int vlan_dev_init(struct net_device *dev)
> >>      dev->fcoe_ddp_xid =3D real_dev->fcoe_ddp_xid;
> >>  #endif
> >>
> >> -    dev->needed_headroom =3D real_dev->needed_headroom;
> >> -    if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)=
) {
> >> -            dev->header_ops      =3D &vlan_passthru_header_ops;
> >> -            dev->hard_header_len =3D real_dev->hard_header_len;
> >> -    } else {
> >> -            dev->header_ops      =3D &vlan_header_ops;
> >> -            dev->hard_header_len =3D real_dev->hard_header_len + VLAN=
_HLEN;
> >
> > Sashiko nipa points to a possible functional and performance regression
> > with unusual config (reorder_hdr off):
> >
> > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260811085246.2267=
779-1-edumazet%40google.com
> >
> > Arguably the current behavior is incorrect, but it's also the
> > established one. WDYT?
> >
> > /P
> >
> >
> Hi Eric,
>
> Gently pinging on this thread.
>
> Just wanted to check if you have any thoughts on Paolo's comment
> regarding the potential regression with reorder_hdr=3Doff?
>

I probably missed Paolo answer (too many emails in my inbox).

Regarding the reorder_hdr=3Doff finding from Sashiko:

1. reorder_hdr=3Don is the default for VLAN devices, which continues to use
   __vlan_hwaccel_put_tag() and HW VLAN TX insertion offload as before.

2. For the rare reorder_hdr=3Doff configuration, the intention of the flag
   is specifically to produce inline Ethernet headers, unless I am mistaken=
.

   Previously, whether reorder_hdr=3Doff generated an inline tag or used HW
   offload depended on whether the lower device advertised VLAN offload
   at device creation time.

   Using vlan_header_ops unconditionally makes the behavior consistent acro=
ss
   all lower devices without changing the wire format.

If you prefer, I can send a v4 clarifying this consequence in the commit
description.

I just feel the changelog has become a monster already.
