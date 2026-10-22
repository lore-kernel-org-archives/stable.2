Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691288;
	b=DgT9cKb7HUErSaQ6ktpf7waYnJoDDdOyA6f5LqHS5OdmQIzDAPwWAluteTd9R2QpCUoB
	 jM5K4jWBh6ic8Qf/Fy+JW3oWdhVKpDNcFMchY7UsClijk1Y0WvopIrbfW3miEMshrb4if
	 bR+auKjj999FVlZc5wYes7BN6TSt2n+FdW0l4rr8y7nu7kVvfB3AlPfjkzvrk+3s/1IFe
	 xJNLExOrgVRcUS30CPKavHy4zen9xyhIm3SBMbGcWHNz/9iRDNbPrcSFXg+aNYotjVPYA
	 g5wK2Saa0yfN2pVETQkO1TgZqAnjN5Hkga4ctWPXYNhiptgSMLFObUqGhF8r9NVa5Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691288;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MGotvCzhWr/lonfJnRU59oPcrOTBROzb2+c6xsa3Gm8=;
	b=q75VBcH1i8jd8E1eagHDpshHWcNSC3CqHv7qmpcVmSoEjxtnHBW8rSadI4VxjvRcYVvf
	 CVdIOgvJf6v2am6ij0/w7QnoEHAzHQDffEDdz0152XjP6GOtvoM+iNN3zABNbgKIDOTs+
	 a3nGlaINbnyz2Wu6Nrwq1BgszZ+0Wqdl9NtMkqQPHr4RXy7XgmyaKpjFRAyK6qoYgMXbU
	 rvxi0Af1ViYwIfjyDr45+u/VOZ5nAFq5+W4AWliTsVOrU/vG0NGefnof1+CMUxjALk+AK
	 Kh3uTFFt8tDojMDkHhDduzFWN2K1K6YBCP4G4yUVrd+3Z53DiJd7E00iULxKxXE7nvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2ZmsuqW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD926606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2ZmsuqW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACF51F031EB
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691287;
	bh=MGotvCzhWr/lonfJnRU59oPcrOTBROzb2+c6xsa3Gm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G2ZmsuqWEkBNHwHLkDIFwTgdwWMAd3VNDMwaCMWpekNralQaK67EgcCV65cGgVuvE
	 Z1t4l+1ZaspZDFN+aExiW1/gzzI8+zKtPOP6pqWyU5MA/tUfYkLXCYYJmBVhVtLw7F
	 wkYsKr/O0pFcd6I1qGPFnd2xcbVJ3SzKFDsMKzE4oSLjm1jMKrdQ3BsGddjo+7vWbt
	 4csvW/KjdE1ca6xD1BLQ1AYh62VR3KYJC29nAqEpcYS9NA3vjLZv6BhuC6p1UCrweR
	 VI96xsUqb8q+e06o9xbKIUxqB0WWBg2ALwreAZu2V/QOMgHqiUCp56/5wkv7KEDc7l
	 cvBD8yWEqNB5g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be4d648aacso1749440e87.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 10:48:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBydODwTgijbMA9/SlfDiWKRq4918xL3eaC0jzDOvlky2iAKpMoambtr/q6ui6GHueLX0w98A7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqJLZ2jksOSiC4aowPUsELSLNiXV+MF/I6Mowg8S2ldYn/L6/C
	ULu5mSdS1Ns7XRRSpDxYDrf9WoGELbn76XKzcJzudn5Yxp5k0ixNz30tqOM95+jDjDjNCX8232W
	8xzexqI9TZ0CR4JWgsqA9P1b8tGsQVFg=
X-Received: by 2002:a2e:b88b:0:b0:3ac:4ce6:8b73 with SMTP id
 38308e7fff4ca-3ac4ce68e14mr12334331fa.22.1792691286350; Thu, 22 Oct 2026
 10:48:06 -0700 (PDT)
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
 <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-5@mojatatu.com>
 <0225eac7-1432-4d46-8649-2ad864aa26d4@ovn.org>
In-Reply-To: <0225eac7-1432-4d46-8649-2ad864aa26d4@ovn.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 19:47:50 +0200
X-Gmail-Original-Message-ID: <CAL4Wiipm9x5LekCb2WTo1CfqihwRY1=rV0W+KdS-FVA_pRCj3A@mail.gmail.com>
X-Gm-Features: AclHuK-omgKLVDEOSqFcU4jhRjUPSbk60eGlMwcbvEyU8LVQvfW9BHbpDh38hkk
Message-ID: <CAL4Wiipm9x5LekCb2WTo1CfqihwRY1=rV0W+KdS-FVA_pRCj3A@mail.gmail.com>
Subject: Re: [PATCH net 5/5] net: openvswitch: ensure a linear inner Ethernet
 header on NSH pop
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Eric Garver <e@erig.me>, Yi Yang <yi.y.yang@intel.com>, 
	Jiri Benc <jbenc@redhat.com>, Pravin Shelar <pshelar@ovn.org>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, dev@openvswitch.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 14:43, Ilya Maximets <i.maximets@ovn.org> a =C3=
=A9crit :
>
> On 10/22/26 11:22 AM, Jamal Hadi Salim wrote:
> > The issue:
> > pop_nsh() restores MAC_PROTO_ETHERNET when the popped NSH next-protocol
> > is TUN_P_ETHERNET, but nsh_pop() only guarantees that the NSH header is
> > in the linear area.  When the inner Ethernet header sits in a page
> > fragment, the datapath then claims an Ethernet header it cannot access
> > linearly.
> >
> > Output to an OVS internal vport then calls eth_type_trans(), which
> > pulls ETH_HLEN from an empty linear area and triggers the BUG in
> > __skb_pull():
> >
> >   kernel BUG at ./include/linux/skbuff.h:2830!
> >   RIP: 0010:eth_type_trans+0x335/0x500
> >   internal_dev_recv
> >   ovs_vport_send
> >   do_output
> >   do_execute_actions
> >   ovs_execute_actions
> >   ovs_dp_process_packet
> >   ovs_vport_receive
> >   internal_dev_xmit
> >
> > Conditions to recreate the bug:
> > On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
> > enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its loca=
l
> > internal port up with MTU 9000.  Install a flow matching an Ethernet/NS=
H
> > packet with a 24-byte MD1 header whose next-protocol is TUN_P_ETHERNET,
> > and actions pop_eth, pop_nsh, output to the local port.  With
> > CAP_NET_RAW, send a 4148-byte AF_PACKET/SOCK_RAW frame containing outer
> > Ethernet, the NSH header, inner Ethernet and 4096 payload bytes.  The
> > two pops consume the linear headers and expose the inner Ethernet heade=
r
> > in page fragments.
> >
> > The fix:
> > Pull the inner Ethernet header into the linear area before restoring
> > MAC_PROTO_ETHERNET.  This is the NSH counterpart of the MPLS/TEB
> > producer fix in the previous patch.
> >
> > Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> > Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200=
ea@kernel.org/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/openvswitch/actions.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > index 03b31e33e880..cb7e16c6a8ef 100644
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -314,10 +314,13 @@ static int pop_nsh(struct sk_buff *skb, struct sw=
_flow_key *key)
> >               return err;
> >
> >       /* safe right before invalidate_flow_key */
> > -     if (skb->protocol =3D=3D htons(ETH_P_TEB))
> > +     if (skb->protocol =3D=3D htons(ETH_P_TEB)) {
> > +             if (!pskb_may_pull(skb, ETH_HLEN))
> > +                     return -ENOMEM;
> >               key->mac_proto =3D MAC_PROTO_ETHERNET;
> > -     else
> > +     } else {
> >               key->mac_proto =3D MAC_PROTO_NONE;
> > +     }
> >       invalidate_flow_key(key);
> >       return 0;
> >  }
>
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
