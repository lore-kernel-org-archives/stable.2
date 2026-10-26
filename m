Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024172;
	b=0g5izXxRXxSD+VK+bppH3N1BFLBHtvqU4ZmxMVaOSyl8DEKRTDizr/0vhkfdudRg0oOE
	 ImGzUDoB4A9lxe8UcNPxxo6IETCjs2HcTaww8mSouTfKReNfV24C8FJsgwcVraTKb1LRE
	 YgfPgk6E1uElXY33M4qWKS17k9UxCTC4zLM6gRQDehKo44lU5wy56U53g57dGXWpJlti/
	 HHrp1VAA1ruBMixPfeWQJsgdipJV4Y/dTOZbwRDiAlYN4p+8fMhEMV7jeDNMq6jRKYnSq
	 mgllYcHFf9NMp4RkegQlT8v2L7tmukIxw6Cb+tr+T6NNGGRtth0/PJyt/wfQAXbdt0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024172;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+cY3MnydBaxpTejs+U772a+2Cy8wWYNpsnXZyyAN6zs=;
	b=KjCKxdpFKpnR6tpGWX3QqYKqcSCyNMhN8P9k4M3QgB7Ys0rYEBEWppAUZ1jD4H+ZuOVA
	 3xDrMsF+E//micaal/5QoJQY/TvwdcJ1AgEHkl9dmNhDZ/dAxgiTQpsdO8haqGpCLgLpq
	 Kq+2F3RCuUztUNeOJUYWtR3KsEu6TQOpw2GPeO7m7ro3QYFdhGqiOdHheAGYF4gZeAT2z
	 ogwgZu1q0jMZJ2UcVKUdqUocqw+dgr1KPxqaH4a7kqWTZ+BGzEQ3lE4tRpR0oHS8duNSk
	 XX0eYdPbEANDeQrjIEuFrpSJ2e+6cq0a34ol3eYdcN2pfwX9xn/IlhXC+pEA8BvFzig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nqNa1/Dy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439F606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqNa1/Dy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FED1F031E0
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793024172;
	bh=+cY3MnydBaxpTejs+U772a+2Cy8wWYNpsnXZyyAN6zs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nqNa1/Dy/3OuGHMDuHCxnDA69VqYaxF8iPNvDPaxcQSNUT83yoVdg/v8pp6IySMLR
	 0lvCuURfNH58fdR2qbgZZLTWBq5A83x68WlcSlxLjB1o5eqlhfr/rPmd3OAwdroxBF
	 2K8ZlLiFKwdf+yo0nz109mAjMypebWcGiniID4IaVbP5M3RO7bWLTl8SalXu0KYVe/
	 oSiA69ikaaqm7OCIkrPSpEXmKxm5lq7l1Sm40hyiyuxRka/S5tZDnkc6NaxMFGVoqf
	 /MWU8NQapaakuG4TajgTnlqlg/b0++c1jC2FNP+JLEAVc7fJuWvmePKWZMual9vWfZ
	 PNUW8n1NQHsZg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-48ed0b68895so1594420fac.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:16:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzkgkry3II74L8Rq4bE9tIwidizeJOJtAlM5ubhk7C3j489simVsSQL64Dt5cY8MIG6CjqeV1M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVsXzsv5nQ4JP3jn0IpWUBAqrQ2NZo4hRCrrSah3WLo+qIoTFX
	cUznB0lW6+QHRH2nr7g2TgljsbWbT/DRpnzBNuNEIGQQbo+2s3fP1uiOuQxs3mVKUd+4sFEukqi
	e4M0wLkDQmMtstt0bzfyJNUSvenIkjNQ=
X-Received: by 2002:a05:6871:690e:b0:48f:e22e:7f8d with SMTP id
 586e51a60fabf-4a83f6309demr3886521fac.46.1793024171246; Mon, 26 Oct 2026
 07:16:11 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
 <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
 <CAM0EoMkct9bMMZHPRKh3xZ-L5GTX0SeLdnp_NQd+C_QWspHW8w@mail.gmail.com>
 <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com> <CAM0EoMmGnxd6s+e_VN734KbbYK5UVZH6yzeU55En2-VqyGkSrw@mail.gmail.com>
In-Reply-To: <CAM0EoMmGnxd6s+e_VN734KbbYK5UVZH6yzeU55En2-VqyGkSrw@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 15:16:00 +0100
X-Gmail-Original-Message-ID: <CAL4WiiovvM9OTbMdN3+-74gSV520ihh1yqevH2T+OoWNiL2k4Q@mail.gmail.com>
X-Gm-Features: AclHuK8sa-GSJA3YvJjIOMkEBqSSsZbALKWquXdky5Cq4xCTPHK6cecO9xXd7fw
Message-ID: <CAL4WiiovvM9OTbMdN3+-74gSV520ihh1yqevH2T+OoWNiL2k4Q@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 14:52, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> On Mon, Oct 26, 2026 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@kernel.org=
> wrote:
> >
> > Le lun. 26 oct. 2026 =C3=A0 11:32, Jamal Hadi Salim <jhs@mojatatu.com> =
a =C3=A9crit :
> > >
> > > On Mon, Oct 26, 2026 at 5:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Sat, Oct 24, 2026 at 10:28=E2=80=AFAM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > >
> > > > > The issue:
> > > > > When the configured inner protocol is ETH_P_TEB, act_mpls POP can=
 leave
> > > > > the inner Ethernet header in a page fragment after skb_mpls_pop()=
, either
> > > > > on an L3 device (mac_len =3D=3D 0) or chained after act_vlan POP_=
ETH.  A
> > > > > following eth_type_trans() can then BUG in __skb_pull().
> > > > >
> > > > > The Fix:
> > > > > After the pop, pull the inner Ethernet header into the linear are=
a only
> > > > > when p->tcfm_proto is ETH_P_TEB; drop the packet only when that p=
ull
> > > > > fails.  Other inner protocols (IP, MPLS, ...) have no inner Ether=
net
> > > > > header and must not be required to carry one.  The pull is a no-o=
p when
> > > > > the header is already linear.
> > > > >
> > > > > Conditions to recreate the bug:
> > > > > - egress tc filter on lo: action vlan pop_eth action mpls pop pro=
tocol teb
> > > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a no=
n-linear
> > > > >   eth / mpls / inner-eth frame.
> > > > > - The inner header is in page frags; a following eth_type_trans()=
 can BUG
> > > > >   in __skb_pull().
> > > > >
> > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions t=
o TC")
> > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb=
7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4=
xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1dd=
b3bd2ae@gmail.com/
> > > > > Cc: stable@vger.kernel.org
> > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > >
> > > >
> > > > For the series
> > > >
> > > > pw-bot: cr
> > > >
> > > > Eric, you are reading this? See the discussion with Willem.
> > > >
> > >
> > > And to be clear, I am suggesting we fix both the producers and consum=
ers.
> >
> > I don't think we need to touch loopback / eth_type_trans() directly
> > (that's the per-driver cost I pushed back on for tun). There is a singl=
e
> > natural choke point: the egress fall-through in sch_handle_egress(),
> > right before the skb goes back to the driver's ndo_start_xmit(). A
> > device advertises how much link-layer header it needs via
> > dev->min_header_len, and that is exactly the amount eth_type_trans()
> > will pull. One check there covers act_vlan, act_mpls with any inner
> > protocol, act_ife, pedit, and BPF, now and in the future:
> >
>
> You are resolving part of it with this choke point but: the primary
> concern is that ebpf can make changes that will still cause crashes at
> the consumer.
> Point is not whether you guard against bpf_skb_adjust_room() but more
> the boundary coverage i.e not correctness of the check. You are
> suggesting to (iiuc) to fix the other stuff inside ebpf? Here are some
> sample holes (there are probably others):
>
> 1) bpf_skb_adjust_room() then bpf_redirect() - note: bpf_redirect()
> returns TC_ACT_REDIRECT; sch_handle_egress() returns at the redirect
> case before the check
> 2) bpf_skb_adjust_room() then bpf_clone_redirect(); The clone is sent
> immediately inside the helper and escapes; the original skb may then
> return TC_ACT_OK and be checked
> 3) you are handlin egress only - ingress still vulnerable
>
> and xdp totally bypasses sch_handle_egress() [think
> bpf_xdp_adjust_head() then XDP_PASS or XDP redirect to veth
>
> I havent looked closely at the OVS ones you said to drop but hand wave
> review seems they can be bypassed (likely i am missing something), so
> we cant drop those.
>
> summary?
> The concern =E2=80=9Cproducers alone cannot protect=E2=80=9D remains vali=
d unless you
> convince other wise ;-> Your turn...

We agree on the premise: producers alone cannot protect. Your bpf
skb_adjust_room case is the proof - no act_vlan/act_mpls change stops a
later program from shrinking mac. That is exactly why I went to a
boundary rather than to the producers. So the question is only whether
the egress fall-through is the *complete* boundary, and you are right to
push on that. I went and tested your holes instead of hand-waving.

Setup: inject a non-linear frame on lo via AF_PACKET+PACKET_VNET_HDR
with hdr_len=3DETH_HLEN, so the linear area holds only the outer Ethernet
header and the inner one sits in frags (this geometry is what actually
BUGs; hdr_len=3D28 keeps the inner header linear and nothing crashes).
Each case in its own netns, PANIC_ON_OOPS=3Dy:

  A  vlan pop_eth                                  (TC_ACT_OK)
  B  vlan pop_eth + mpls pop protocol ip           (TC_ACT_OK)
  C  vlan pop_eth + bpf skb_adjust_room(-1, MAC)   (TC_ACT_OK)
  D  vlan pop_eth + bpf_redirect(veth, 0)          (TC_ACT_REDIRECT)
  E  vlan pop_eth + bpf_redirect(lo, 0)            (TC_ACT_REDIRECT)

                          net          net + egress guard
  A  pop_eth              BUG          dropped, no BUG
  B  + mpls pop ip        BUG          dropped, no BUG
  C  + bpf shrink         BUG          dropped, no BUG
  D  + bpf_redirect veth  no BUG       no BUG
  E  + bpf_redirect lo    no BUG       no BUG

So the egress fall-through guard covers A/B/C, i.e. everything that
leaves tc on the TX path, for any inner protocol and including the BPF
shrink - no ETH_P_TEB guessing.

On your holes 1 and 2 (bpf_redirect / bpf_clone_redirect): I could not
make them BUG, on net or with the guard. The reason is that these go
through __bpf_redirect_common(), and after a pop_eth the mac header sits
exactly at the network header, so the existing

    if (skb->mac_header >=3D skb->network_header || skb->len =3D=3D 0)
            kfree_skb(skb);

already drops the frame before it can reach eth_type_trans() (confirmed:
the skb never lands on the peer, rx_bytes does not move). clone_redirect
takes the same __bpf_redirect() path, so same outcome. In other words
that boundary is already guarded for this producer - just by a different
test than min_header_len.

The residual there is the case I flagged in my previous mail: a producer
that leaves mac_header strictly below network_header (so the check above
passes) yet with fewer than dev->min_header_len bytes linear. I could
not build one out of pop_eth / mpls pop (both leave mac =3D=3D nh). If you
can craft that, that is the one I want to see - and the fix is the same
dev->min_header_len test added to __bpf_redirect_common(), not a
per-producer change.

Hole 3 (ingress): the plain RX path does not call eth_type_trans() a
second time - the mac header was already pulled by the real driver. The
only way an ingress action reaches eth_type_trans() again is by
redirecting to a device's TX/forward, and that goes through the same two
boundaries: __bpf_redirect_common() for bpf, and your act_mirred patch
(patch 3) for mirred. So ingress is covered by the same choke points,
not by the producers.

Hole 4 (XDP): agreed, and this one is genuinely separate. XDP mangles
the xdp_buff before an skb exists and bypasses sch_handle_egress()
entirely; bpf_xdp_adjust_head() + XDP_PASS/redirect is an XDP-core
question, not something an skb-level tc series can or should address. If
the build-skb path can hand eth_type_trans() a short head there, that is
its own fix. I will look, separately.

So my reading of the bounded set, for skb, is:
  { sch_handle_egress() fall-through, __bpf_redirect_common(),
    act_mirred } - a handful of boundaries, each a cheap
  dev->min_header_len test, not every producer and not eth_type_trans()
  itself (I still don't want a pull on the RX hot path).

Which maps to the series as:
  - drop patches 1 and 2 (the egress guard subsumes them; ETH_P_TEB
    question gone);
  - keep patch 3 (act_mirred) - redirect boundary;
  - keep patch 4 (act_ife) - fixes the egress frame, not just the crash;
  - keep patches 5 and 6 (OVS) as-is - different datapath, no arbitrary
    BPF, already reviewed.

If you still think 1 and 2 earn their place, the concrete thing that
would settle it is a redirect repro that BUGs with mac < nh - I will
happily eat my words. I can share the reproducers above if useful.

Thanks,
