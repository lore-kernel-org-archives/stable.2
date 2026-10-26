Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793030494;
	b=MYl9zkDK/NY5/mE6tBvfdvxjNsGODt6YcOuYUs704mwguPxQdVzPWlXOB3PavUx2ll9Y
	 5JegVZEBQtgicDEmFyvuLeWwCpm+1ZDd/5KpSQJO1nr3Xc5B8D1ew2inIfgWYZnwclSQj
	 0J/grA+EtgP3XhBa1wg6/VH5IFiU8yNFKej6u3/0rr2gpmRQ9RW3duHoov29glzHq1ZDn
	 vlVbUdbKGrzuoC+YCaDuHjflSV3Kt/D316W5LhJSiA8AkSRTu20m4lstMvWSqgojrpoiV
	 rbArxSwGTER/bWDCT4VB8eemUzOSeQNj/AEbeK39IJOJ9HbECrPYd0XdiNcBP4M9cxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GjQ4hqefIfaios73k34S/01Xsy10UeoBHYey2Jhugqk=;
	b=5IRFoWMkFU/W1BpDa63lvWkQOqXTgBy2tS77V3w7slY/Ry07fYK8Fh8GzfuRPCrsftr+
	 lcmVg8UncI6hvTHkBJ2n/y/C3GNqGMMPKSZT6DwBAuTaQxWU+fuxv/aEbbrNIutbq6mpD
	 A2sKhYwgB4GuV4gKljm+ZIKJgrQAEyGdllSTjVdgclT6c2H7xQgBVDwfENVPazi/atZI1
	 Zfp/S30x/TBbQ51vwcjZ/J1AHlaPwJUBp9NVofF6sybJu4MBB7cXN0cwi6TNwdXmd1/ad
	 9BF7ET4ZRKoV6P/zGZuovQ4pfSDmQF+9BRVYaFEkJQGpc2dsWh56Lj8vrUX/jzyvSIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=s++gc8ny;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33360A261A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C33360A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=s++gc8ny
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070781f63so1187335b3a.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030492; cv=none;
        d=google.com; s=arc-20260327;
        b=L1ftxpoEEgrIMVdgm3XYGYa1gwA99v5TXQE9H82ai+9kCcwpls0me4zMDVDRFd6Q2J
         Cxo/7pxseH4N3g3Qeu9wcsY1CXv/OxA8Y54/h8/nw4ya/f9xuvGK7LYExBN5Lj8QJfcq
         zrixKp9HVRTdFisoqstSCvW8y+ctOVmjAczCP5fw2RnWr+r/gEfhevoT6cIfu75PG5vq
         rUTwnke9K3SaDrV4E+3QMQj3MjXw3SdYspBMVzFSwA+UE46q9nWXvsJ3vAYndM7esKID
         rs10jQZ9mSZQAwnU4QcVs4mpIb8uUCTzhup3/pDoTym1htGFV4N8U2KYTbiVhAzhj0rh
         9TdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GjQ4hqefIfaios73k34S/01Xsy10UeoBHYey2Jhugqk=;
        fh=uHxZKP9kG/tu1s1SOJuItC+aS+ZXnoUNox20mXKB6yM=;
        b=itd62w4hY55+7brOzh9MSSHal2A9RL4Ta5NPiR//qvPT57FqBa3PrdO4wf4VrO+pEb
         zKCq6dA2GakoW78UvN1JHJ1Gr4yQAll9YOQ9j9T8+li4xQae9H8N53EOkCrYnYv1RPJy
         fQdBNiskRHfB31Xu9EezOujNDAugjk8ZXLvVVNYIV2Ysq2pKXbwR47SBCKnrZD1BO5Ul
         vJVAoAwhdW2acQtlec4OAp39+VXhG339nQvV5Du4qxdYa6MOU5yyLJUP82860RQZaXRT
         p3736yXOlTQzog9bUo7JkIPKpHQ3MBUpNfPkTBKhMaZRKEqy+tQ2ii5HS8LBw3plF6Nu
         kmbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793030492; x=1793635292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GjQ4hqefIfaios73k34S/01Xsy10UeoBHYey2Jhugqk=;
        b=s++gc8nyrrHh6C2IbJ93wZXYJD5XPOFnCXIMXT5VHQ2uPzM/gWtLvKnN6L8lb1Q4V9
         5lQVCKaQV9sunw9smCK8XCfqQr2vNehAVxEP+zK7D+k98JympliZ2Ut9SsUd3Qctc93h
         AVROzrIFd+DfIHKH5OiTF2X0bCjChJNK51Ev0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030492; x=1793635292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjQ4hqefIfaios73k34S/01Xsy10UeoBHYey2Jhugqk=;
        b=xNGhfZWtywY8venuS4cF5JRvehlELJeU6LWnsHww7pMQVrQEWxQuiLMPp5AjKG1kPy
         1aGOxAtkrZWaEJ1ZpMi6EBNPOq+DRs1/xRlbIgvjRHMMslJXrbe1nYtMD85RXZ0RPIeB
         f/UO2SM8EQG819CyrueMTWu0Pxvv3thqeSv/XwuYlm6djmZRZKC3K4sGAi1iYYQ/GVzS
         9n+YcjITrjnOjWOYFF6DbiDf0bGjH1yx3oG/kKs+p8lMObRkDGQ97pJUVd1CTC/s5YkE
         PPCf8FRzy+Ge6+muCXfYKm31VaOVl4W617FVYrhg/rnCU08OIiMCk/3+fvGHtKJZflEf
         ka1Q==
X-Forwarded-Encrypted: i=1; AKwUvByd8lSR/b0zNZpHIaEKTz5WQeaNKBfyIWqOGntXtKEBvXlCLnT2ktlIvN+Oe9cOwwotiCeSQiE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmrlQxgJTt6bVe6K4JE5pvJC2MWnJH0yR1fcJHcI4TT/6JE4Os
	YRMNvJiM4mnuCUX054kg2haL8bnMoq2pkJHypRUA+6asEPkEEMem0ts3t0c83Ol6HRSKc/XSM4A
	Sse6ZkELs1GeERvllLEuZTP95as0fVFGgAyDe4wKe
X-Gm-Gg: AYBFou1UoWvjindd3Om7wv9e9B+eG45MFO84UMmAyOq704RwGmpTKLY1fgzB1BkXYWk
	FmgC/uaXMBGxI31dg6YToMPMoXDa6+7+yPKH1tlC5CZbBUeJgNs57SDSptS01WKOOBoNZaiNXBq
	krNdADmV0VykJOOFu+JOnjIbO3pHeZNrNOZuD9LGvMI0lu77l9bk7rZbQMdKrAXEAZ+vEkcIofR
	DEeU6M7Xm2bZ8tJWGBc3azNATJr6XLWAqw0eJ2TBAwnE4nNUPg0LyKzQMNPLFPLAo3hIpCcwx2k
	G9EiPFxwR6Cq87KMZctzRiAFnGc3z15UecUvdlsGnruV/gcPAnI7C786Vu7YY/Q7yueWR3gb4PT
	6sK0m27TSVPiHKPK7Pxc6KiD65HEb2y/PfInxUVLsTt/cC3j5/EfVA8dllpoaUCf2dX/uaO3tT+
	FGrY9u17BWR78CdTo=
X-Received: by 2002:a05:6a20:969b:b0:3e2:86b6:9be5 with SMTP id
 adf61e73a8af0-3e8e8126de8mr267635637.71.1793030492149; Mon, 26 Oct 2026
 09:01:32 -0700 (PDT)
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
 <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com>
 <CAM0EoMmGnxd6s+e_VN734KbbYK5UVZH6yzeU55En2-VqyGkSrw@mail.gmail.com> <CAL4WiiovvM9OTbMdN3+-74gSV520ihh1yqevH2T+OoWNiL2k4Q@mail.gmail.com>
In-Reply-To: <CAL4WiiovvM9OTbMdN3+-74gSV520ihh1yqevH2T+OoWNiL2k4Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 12:01:20 -0400
X-Gm-Features: AclHuK9xjAYezxPVVqGOeKURrXUSWSjtbzfR-dDudaMkK6A9to6WgelL6pvpAPc
Message-ID: <CAM0EoM=-JsC1YhodxNUqv95zZST=phXFupg+Z-TSP+UWWeOYxg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:16=E2=80=AFAM Eric Dumazet <edumazet@kernel.org>=
 wrote:
>
> Le lun. 26 oct. 2026 =C3=A0 14:52, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
> >
> > On Mon, Oct 26, 2026 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@kernel.o=
rg> wrote:
> > >
> > > Le lun. 26 oct. 2026 =C3=A0 11:32, Jamal Hadi Salim <jhs@mojatatu.com=
> a =C3=A9crit :
> > > >
> > > > On Mon, Oct 26, 2026 at 5:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > On Sat, Oct 24, 2026 at 10:28=E2=80=AFAM Jamal Hadi Salim <jhs@mo=
jatatu.com> wrote:
> > > > > >
> > > > > > The issue:
> > > > > > When the configured inner protocol is ETH_P_TEB, act_mpls POP c=
an leave
> > > > > > the inner Ethernet header in a page fragment after skb_mpls_pop=
(), either
> > > > > > on an L3 device (mac_len =3D=3D 0) or chained after act_vlan PO=
P_ETH.  A
> > > > > > following eth_type_trans() can then BUG in __skb_pull().
> > > > > >
> > > > > > The Fix:
> > > > > > After the pop, pull the inner Ethernet header into the linear a=
rea only
> > > > > > when p->tcfm_proto is ETH_P_TEB; drop the packet only when that=
 pull
> > > > > > fails.  Other inner protocols (IP, MPLS, ...) have no inner Eth=
ernet
> > > > > > header and must not be required to carry one.  The pull is a no=
-op when
> > > > > > the header is already linear.
> > > > > >
> > > > > > Conditions to recreate the bug:
> > > > > > - egress tc filter on lo: action vlan pop_eth action mpls pop p=
rotocol teb
> > > > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a =
non-linear
> > > > > >   eth / mpls / inner-eth frame.
> > > > > > - The inner header is in page frags; a following eth_type_trans=
() can BUG
> > > > > >   in __skb_pull().
> > > > > >
> > > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions=
 to TC")
> > > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54=
fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ek=
R4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > > Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1=
ddb3bd2ae@gmail.com/
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com=
>
> > > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > >
> > > > >
> > > > > For the series
> > > > >
> > > > > pw-bot: cr
> > > > >
> > > > > Eric, you are reading this? See the discussion with Willem.
> > > > >
> > > >
> > > > And to be clear, I am suggesting we fix both the producers and cons=
umers.
> > >
> > > I don't think we need to touch loopback / eth_type_trans() directly
> > > (that's the per-driver cost I pushed back on for tun). There is a sin=
gle
> > > natural choke point: the egress fall-through in sch_handle_egress(),
> > > right before the skb goes back to the driver's ndo_start_xmit(). A
> > > device advertises how much link-layer header it needs via
> > > dev->min_header_len, and that is exactly the amount eth_type_trans()
> > > will pull. One check there covers act_vlan, act_mpls with any inner
> > > protocol, act_ife, pedit, and BPF, now and in the future:
> > >
> >
> > You are resolving part of it with this choke point but: the primary
> > concern is that ebpf can make changes that will still cause crashes at
> > the consumer.
> > Point is not whether you guard against bpf_skb_adjust_room() but more
> > the boundary coverage i.e not correctness of the check. You are
> > suggesting to (iiuc) to fix the other stuff inside ebpf? Here are some
> > sample holes (there are probably others):
> >
> > 1) bpf_skb_adjust_room() then bpf_redirect() - note: bpf_redirect()
> > returns TC_ACT_REDIRECT; sch_handle_egress() returns at the redirect
> > case before the check
> > 2) bpf_skb_adjust_room() then bpf_clone_redirect(); The clone is sent
> > immediately inside the helper and escapes; the original skb may then
> > return TC_ACT_OK and be checked
> > 3) you are handlin egress only - ingress still vulnerable
> >
> > and xdp totally bypasses sch_handle_egress() [think
> > bpf_xdp_adjust_head() then XDP_PASS or XDP redirect to veth
> >
> > I havent looked closely at the OVS ones you said to drop but hand wave
> > review seems they can be bypassed (likely i am missing something), so
> > we cant drop those.
> >
> > summary?
> > The concern =E2=80=9Cproducers alone cannot protect=E2=80=9D remains va=
lid unless you
> > convince other wise ;-> Your turn...
>

> We agree on the premise: producers alone cannot protect. Your bpf
> skb_adjust_room case is the proof - no act_vlan/act_mpls change stops a
> later program from shrinking mac. That is exactly why I went to a
> boundary rather than to the producers. So the question is only whether
> the egress fall-through is the *complete* boundary, and you are right to
> push on that. I went and tested your holes instead of hand-waving.
>
> Setup: inject a non-linear frame on lo via AF_PACKET+PACKET_VNET_HDR
> with hdr_len=3DETH_HLEN, so the linear area holds only the outer Ethernet
> header and the inner one sits in frags (this geometry is what actually
> BUGs; hdr_len=3D28 keeps the inner header linear and nothing crashes).
> Each case in its own netns, PANIC_ON_OOPS=3Dy:
>
>   A  vlan pop_eth                                  (TC_ACT_OK)
>   B  vlan pop_eth + mpls pop protocol ip           (TC_ACT_OK)
>   C  vlan pop_eth + bpf skb_adjust_room(-1, MAC)   (TC_ACT_OK)
>   D  vlan pop_eth + bpf_redirect(veth, 0)          (TC_ACT_REDIRECT)
>   E  vlan pop_eth + bpf_redirect(lo, 0)            (TC_ACT_REDIRECT)
>
>                           net          net + egress guard
>   A  pop_eth              BUG          dropped, no BUG
>   B  + mpls pop ip        BUG          dropped, no BUG
>   C  + bpf shrink         BUG          dropped, no BUG
>   D  + bpf_redirect veth  no BUG       no BUG
>   E  + bpf_redirect lo    no BUG       no BUG
>
> So the egress fall-through guard covers A/B/C, i.e. everything that
> leaves tc on the TX path, for any inner protocol and including the BPF
> shrink - no ETH_P_TEB guessing.
>
> On your holes 1 and 2 (bpf_redirect / bpf_clone_redirect): I could not
> make them BUG, on net or with the guard. The reason is that these go
> through __bpf_redirect_common(), and after a pop_eth the mac header sits
> exactly at the network header, so the existing
>

I may have miscommunicated or misunderstanding you now but whay you
are describing is not the claim I was making for holes 1 and 2. The
test should be:
     action: vlan pop_eth
     action ebpf which does:
       {bpf_skb_adjust_room(skb, -1, BPF_ADJ_ROOM_MAC, 0);
        bpf_redirect(lo/veth, 0)        /* or bpf_clone_redirect() */}

From what you are describing above you did not test this sample

>     if (skb->mac_header >=3D skb->network_header || skb->len =3D=3D 0)
>             kfree_skb(skb);
>
> already drops the frame before it can reach eth_type_trans() (confirmed:
> the skb never lands on the peer, rx_bytes does not move). clone_redirect
> takes the same __bpf_redirect() path, so same outcome. In other words
> that boundary is already guarded for this producer - just by a different
> test than min_header_len.
>
> The residual there is the case I flagged in my previous mail: a producer
> that leaves mac_header strictly below network_header (so the check above
> passes) yet with fewer than dev->min_header_len bytes linear. I could
> not build one out of pop_eth / mpls pop (both leave mac =3D=3D nh). If yo=
u
> can craft that, that is the one I want to see - and the fix is the same
> dev->min_header_len test added to __bpf_redirect_common(), not a
> per-producer change.
>
> Hole 3 (ingress): the plain RX path does not call eth_type_trans() a
> second time - the mac header was already pulled by the real driver. The
> only way an ingress action reaches eth_type_trans() again is by
> redirecting to a device's TX/forward, and that goes through the same two
> boundaries: __bpf_redirect_common() for bpf, and your act_mirred patch
> (patch 3) for mirred. So ingress is covered by the same choke points,
> not by the producers.
>

There are other ways ingress action reaches eth_type_trans(); probably
a good description for this is =E2=80=9Cpop_eth + normal ingress is safe=E2=
=80=9D and
not =E2=80=9Cingress cannot reach eth_type_trans() except through redirect.=
=E2=80=9D
ife action,  __dev_forward_skb2() , ovs internal_dev_recv() call it
directly (Although i admit i dont have reproducers yet for these)
IOW, plugging redirect doesnt cover all (and who knows what other
codepaths could get through in the future).

> Hole 4 (XDP): agreed, and this one is genuinely separate. XDP mangles
> the xdp_buff before an skb exists and bypasses sch_handle_egress()
> entirely; bpf_xdp_adjust_head() + XDP_PASS/redirect is an XDP-core
> question, not something an skb-level tc series can or should address. If
> the build-skb path can hand eth_type_trans() a short head there, that is
> its own fix. I will look, separately.
>

I dont see it as a separate fix tbh - it is part of the same
cause/effec bugs - i.e the same __skb_pull() BUG occurs

My position still hasnt changed at this point - and going even a bit
further: fix the consumers in "net" and this whole patch series goes
as net-next "strengthening" patch set independently. If you fix the
consumers the bug cant happen. I understand your position on
performance degradation and i empathize with it.... i am curious to
see what clever thing you come up with (you always do ;->).

cheers,
jamal


>   { sch_handle_egress() fall-through, __bpf_redirect_common(),
>     act_mirred } - a handful of boundaries, each a cheap
>   dev->min_header_len test, not every producer and not eth_type_trans()
>   itself (I still don't want a pull on the RX hot path).
>
> Which maps to the series as:
>   - drop patches 1 and 2 (the egress guard subsumes them; ETH_P_TEB
>     question gone);
>   - keep patch 3 (act_mirred) - redirect boundary;
>   - keep patch 4 (act_ife) - fixes the egress frame, not just the crash;
>   - keep patches 5 and 6 (OVS) as-is - different datapath, no arbitrary
>     BPF, already reviewed.
>
> If you still think 1 and 2 earn their place, the concrete thing that
> would settle it is a redirect repro that BUGs with mac < nh - I will
> happily eat my words. I can share the reproducers above if useful.
>
> Thanks,
