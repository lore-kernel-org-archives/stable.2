Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABA2EA749
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310621; cv=none; b=SGxsxkr/VsfyVzbpCQFVvCOwBmQqHchXodbyceAKv1JUYFfY2tr9RPo89hRqN7X6U/hdVGwb4ZmJI7GnHpOYVX5+IIb/zj0GgDSid0WZQfFEJG1Vzex6BIQbKg4Z1NT3hS52+oUBSwCTso32h8KXTHslXZfoMz1O90N3EcsBQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310621; c=relaxed/simple;
	bh=30DM1dlB4xJ8A7cSQJuq8TjBhktB7+c1xwhudJHedkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3JC/gDK6fW9t5DPYSli5pcHN0aI6QqTlpKhm0Z8FWo5VEza0pMHMJ34P/hWke2dCY/km4msN/EV67C2o00aVAR0kEsOboupF8TkGDFBKH+xVFFcHoo3Lslpc9WFVkhdft8PcZ1qRdLHbtBpXRr/1pjBEG4ykh1ZJ7kPkWL9+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEAtDPo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEAtDPo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6351F008A1
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791310619;
	bh=/qQgWZIWoeeo8NM7QjEOSkMaOjMn+PrW3wol+OaTg6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LEAtDPo+J4Oio9iL14H/E2Y8K1XL8TktF3qfpR4JkQ+leBeydhqHnqBLD0VmS05Cs
	 skzT/bAyvB/LS3AH8BdPVhP8hdm5/dcn79X0r3zNytIisGhQSeURDHGsjpK+tZcH/E
	 eQt0Vx4CT/WqW3eHNaGBU/mS/Q6l+PN1FHZsI8e+y0RZwrbbYDbM1HzRGjRiYETE2o
	 rhyeJuStpPnOHbEg1DDnMl5FYsI/jfusMjJTfG9nhPzftMx8yJt3wDCPHCkLp+DJif
	 fefeFPgroloUdQCTMVgzjcMSwh/WftS0PBYDvoJa1uJ7d2th5AEtM3UuOJ52LcwYlF
	 6XNCF1dDgOURg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b1afdf5196so377595eaf.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 11:16:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwWVZR3pfmNCC2Fv+Uyy5P4xFgSPOp+ilXINpO8ddjrEIcgs5hpiQ6OX507iJ+uTfAT7nkpNaU=@vger.kernel.org
X-Gm-Message-State: AFuF++n1KiJG52Rt8STfJ0CaR8HrAFt8xrMoAX8OTfCExjsTaChy61HS
	8gYqmCpEAAg+TBYV0d6Ek1Vgyyb2E2mpB5k//O1ahoYbFH0b0aZlA79F20QxFtM6UUqA+Fv8HB3
	Do8XYvH1UE8tuxiuI5K/tdxQ3I5hnrB0=
X-Received: by 2002:a4a:e910:0:b0:6b1:5735:b88e with SMTP id
 006d021491bc7-6e551065ac8mr1918247eaf.6.1791310618902; Tue, 06 Oct 2026
 11:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
 <a6193df2-98f3-409f-b73f-5b91835a0107@kernel.org> <CAL4WiirwF6bZwocErCthJ+TUu7wipRfSibRBoKWjjkA2nVSrqQ@mail.gmail.com>
In-Reply-To: <CAL4WiirwF6bZwocErCthJ+TUu7wipRfSibRBoKWjjkA2nVSrqQ@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 6 Oct 2026 20:16:47 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqSmW093PDngLrUNiNA5GVKeM3+tAO7KMDJeyjYZ7GRzg@mail.gmail.com>
X-Gm-Features: AclHuK_npeoQgQiFHlHXF0xFKwh-DYkOGnBzdSKiExLCyu4k-6GIIeNMicuP07w
Message-ID: <CAL4WiiqSmW093PDngLrUNiNA5GVKeM3+tAO7KMDJeyjYZ7GRzg@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, 
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	nic_swsd@realtek.com, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 6 oct. 2026 =C3=A0 19:07, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :
>
> Le mar. 6 oct. 2026 =C3=A0 18:27, Eric Dumazet <edumazet@kernel.org> a =
=C3=A9crit :
> >
> >
> >
> > On 10/6/26 13:45, Jan =C4=8Cerm=C3=A1k wrote:
> > > Hi,
> > >
> > > the Home Assistant OS recently shipped kernel update from 6.18.39 to
> > > 6.18.52 which was followed by a bunch of community reports about fata=
l
> > > network breakages [1] which had one thing in common - r8169 driver an=
d
> > > configured VLANs. This manifested as network stall early in the setup
> > > of the system with dmesg events like this:
> > >
> > >> r8169 0000:03:00.0 enp3s0: NETDEV WATCHDOG: CPU: 7: transmit queue 0=
 timed out 6125 ms
> > >> r8169 0000:03:00.0 enp3s0: rtl_rxtx_empty_cond =3D=3D 0 (loop: 42, d=
elay: 100).
> > >
> > > As there was no change in the r8169 driver itself, I focused on the
> > > vlan subsystem, where AI pointed me shortly to this suspect commit in
> > > the range: 1517d1996b5236fe69eccd9d253f725e06996eb1 ("vlan: fix
> > > skb_under_panic and races when toggling HW VLAN offload"), added in
> > > 6.18.51. I'm not referring to the mainline counterpart below for
> > > regzbot (447cbe95ebb9) as I can't confirm whether it triggers the bug
> > > there as well. FWIW there was another issue [2] with a similar
> > > combination recently in the regressions ML but that one seems
> > > unrelated, as disabling EEE fixed that issue, and it doesn't fix it
> > > here.
> > >
> > > I don't have the hardware myself, I asked for testing with this commi=
t
> > > reverted, which confirmed that this change indeed started to cause
> > > trouble. However, it's obvious that the change itself is not bad, as
> > > it fixes another issue and the regression is scoped to very specific
> > > hardware/setup combo.
> > >
> > > Besides the revert, following workarounds were reported to fix the
> > > issue as well:
> > > - Disabling TX checksum offload with `ethtool.feature-tx off` in
> > > NetworkManager for the connection (HAOS doesn't have ethtool binary,
> > > hence this option instead of direct ethtool command)
> > > - Enabling REORDER_HDR with `ip link set enp1s0.100 type vlan reorder=
_hdr on`
> > >
> > > Clearly, this needs rather esoteric setup to trigger the bug - I gues=
s
> > > most systems set the REORDER_HDR flag by default, however, due to som=
e
> > > legacy in the DBus interface that HAOS stack uses to configure the
> > > network [3], it was disabled. Anyway, I think that disabling it shoul=
d
> > > not lead to driver breakage as we're seeing.
> > >
> > > So far it appears that this only affects RTL8168h/8111h, XID 541 -
> > > there isn't any report of another chip/XID combination yet.
> > > Unfortunately, as I said above, I don't have the hardware available
> > > for testing but I believe I'll find some community members who'll be
> > > willing to test a proposed fix for the issue if needed.
> > >
> > > [1] https://github.com/home-assistant/operating-system/issues/5019
> > > [2] https://lore.kernel.org/regressions/353419280.954808.179029028353=
0@mail.yahoo.com/
> > > [3] https://github.com/home-assistant/supervisor/issues/7248
> > >
> > > #regzbot introduced: 1517d1996b5236fe69eccd9d253f725e06996eb1
> > > #regzbot link: https://github.com/home-assistant/operating-system/iss=
ues/5019
> > >
> > > Cheers,
> > > Jan
> >
> > Ok this NIC can not perform tx csum offloads with vlans.
> >
> > opts[1] only takes TD1_IPv4_CS and TCPHO (Transport Header Offset).
> >
> > There is no IP header offset field in the descriptor. The MAC assumes
> > the IP header starts immediately at byte 14.
> >
> > So we need to change vlan_dev_hard_header() to take into account
> > vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)
> >
> > Can you test the following patch?
> >
> > Thanks!
> >
> > diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> > index
> > cb8f3cdbf1f732c55a8a3d69ab5445988c953205..3a518ff064465e8ab978c66a28bf7=
df579931256
> > 100644
> > --- a/net/8021q/vlan_dev.c
> > +++ b/net/8021q/vlan_dev.c
> > @@ -54,7 +54,9 @@ static int vlan_dev_hard_header(struct sk_buff *skb,
> > struct net_device *dev,
> >          u16 vlan_tci =3D 0;
> >          int rc;
> >
> > -       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR)) {
> > +       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR) &&
> > +           !vlan_hw_offload_capable(READ_ONCE(vlan->real_dev->features=
),
> > +                                    vlan->vlan_proto)) {
> >                  unsigned int hlen =3D READ_ONCE(dev->hard_header_len) =
+
> >                                      READ_ONCE(dev->needed_headroom);
>
> Nope, scratch this. I need to spend more time on a proper fix.

It seems this code is not needed anymore, and was the source of many
bugs anyway.

In modern Linux, core networking already has validate_xmit_vlan() in
net/core/dev.c which handles software fallback tag insertion right before
ndo_start_xmit when the lower device lacks HW VLAN TX offload.

VLAN_FLAG_REORDER_HDR should be an RX option (controlling vlan_untag()).

I am tempted with this (untested) approach

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index cb8f3cdbf1f732c55a8a3d69ab5445988c953205..7c1394ee2a653706c42f1b970e1=
3664583d1cf36
100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -49,47 +49,14 @@ static int vlan_dev_hard_header(struct sk_buff
*skb, struct net_device *dev,
                                unsigned int len)
 {
        struct vlan_dev_priv *vlan =3D vlan_dev_priv(dev);
-       struct vlan_hdr *vhdr;
-       unsigned int vhdrlen =3D 0;
-       u16 vlan_tci =3D 0;
-       int rc;
-
-       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR)) {
-               unsigned int hlen =3D READ_ONCE(dev->hard_header_len) +
-                                   READ_ONCE(dev->needed_headroom);
-
-               if (skb_cow_head(skb, hlen) < 0)
-                       return -ENOMEM;
-               vhdr =3D skb_push(skb, VLAN_HLEN);
-
-               vlan_tci =3D vlan->vlan_id;
-               vlan_tci |=3D vlan_dev_get_egress_qos_mask(dev, skb->priori=
ty);
-               vhdr->h_vlan_TCI =3D htons(vlan_tci);
-
-               /*
-                *  Set the protocol type. For a packet of type ETH_P_802_3=
/2 we
-                *  put the length in here instead.
-                */
-               if (type !=3D ETH_P_802_3 && type !=3D ETH_P_802_2)
-                       vhdr->h_vlan_encapsulated_proto =3D htons(type);
-               else
-                       vhdr->h_vlan_encapsulated_proto =3D htons(len);
-
-               skb->protocol =3D vlan->vlan_proto;
-               type =3D ntohs(vlan->vlan_proto);
-               vhdrlen =3D VLAN_HLEN;
-       }
+       struct net_device *real_dev =3D vlan->real_dev;

        /* Before delegating work to the lower layer, enter our MAC-address=
 */
        if (saddr =3D=3D NULL)
                saddr =3D dev->dev_addr;

        /* Now make the underlying real hard header */
-       dev =3D vlan->real_dev;
-       rc =3D dev_hard_header(skb, dev, type, daddr, saddr, len + vhdrlen)=
;
-       if (rc > 0)
-               rc +=3D vhdrlen;
-       return rc;
+       return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
 }

 static inline netdev_tx_t vlan_netpoll_send_skb(struct vlan_dev_priv
*vlan, struct sk_buff *skb)
@@ -106,8 +73,8 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct
sk_buff *skb,
                                            struct net_device *dev)
 {
        struct vlan_dev_priv *vlan =3D vlan_dev_priv(dev);
-       struct vlan_ethhdr *veth =3D (struct vlan_ethhdr *)(skb->data);
        unsigned int len;
+       u16 vlan_tci;
        int ret;

        /* Handle non-VLAN frames if they are sent to us, for example by DH=
CP.
@@ -115,13 +82,9 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct
sk_buff *skb,
         * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
         * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
         */
-       if (READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR ||
-           veth->h_vlan_proto !=3D vlan->vlan_proto) {
-               u16 vlan_tci;
-               vlan_tci =3D vlan->vlan_id;
-               vlan_tci |=3D vlan_dev_get_egress_qos_mask(dev, skb->priori=
ty);
-               __vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
-       }
+       vlan_tci =3D vlan->vlan_id;
+       vlan_tci |=3D vlan_dev_get_egress_qos_mask(dev, skb->priority);
+       __vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);

        skb->dev =3D vlan->real_dev;
        len =3D skb->len;
