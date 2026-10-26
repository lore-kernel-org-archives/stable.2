Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793007681;
	b=lVJYu9V0uPJKYRXlLBUxN6d2pTcI39z+j/FM3NSRGAQ+tGP2h7LbkJjgjqOcz5pB5l7w
	 GtYGiF0eEgITpopTXnpWkyJQW4Q1CU/L2pueVUJcQpE6zP5lVfV3Uq0shbKZzmvbaUFBe
	 gEJ6CVKhsCZaJuyPN+JDf/ecZkwPmN8Y63qVGI6NZuvYxqpRCYhIqz5rZo0eztURIVQtD
	 3zt9mUiVeCtBvAmsy12kSE0cyc6+TTDlKuT2PbEr4aIjEgTv/uH4N/cqC44e6AJZ+a+js
	 Mm+k2g+TKiXxkvTTyplnKYVz7pzu5tV+2129UJTUG+YAQWeGhc4Fl71pE6NkOApdxgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=39E6vW6/aAvA+MOoCKzNKPwKqzjWsVvMXH1IH4y+mQk=;
	b=pHRjVxroFtzbgzhfJQOcdCLOVTDyCtEmI7tTSuFaSjCY966oX1ZPJwShMRKZAhSg3FXx
	 HRkoAGy0f9uvHCj8RYOKo9CER7ryVln6DMHSMAVOol7hre4gSU4xc8iZ27PwVkGlQ4a0h
	 ejA7DIqULu0T4jLqY/FwkiFBC3E5pmvvJdOB7YCK/K95kwN7ueQrwLjvfXdXmEuiNu4gb
	 J6NbEVtrMXUr54QIjmfDtZN7mcZsBnQB1E2XOnELmaNCgxuVEMQoDVltEuVkFX2Ej/cp6
	 xlOUSBInAlKjAB8KuDVVdIPjzz1TwIq+3hjKS1EJnALm0EQ5a0LgofizzEJTRoKXMRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ua891DVI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC860A2626
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52DC860A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ua891DVI
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so817148a12.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007679; cv=none;
        d=google.com; s=arc-20260327;
        b=RgvvYIJ8MZPX3sjToAaIFczmrRViG7ya01hYDyLTDcGUm95ZgElpVWsfTPdQhtv8Xz
         k1JJ3IaHch+JPpgA12TsDKKTUQcMHxWB6edv8WZyRMrWKvnaNuGIBfp/DIV1QobywwcS
         7ox8H0fP7IMhnifkKxTSXWgGQcK2B/JGNjCZnKObjEMEjI3bZLCl1aQ0iP5JKR5GVVWP
         PN6HV13dYW+2RQ0SlQPPfY3Ntzm4I7EkdsraVk6fsattqaAXgeRJPklCsAGxLegYIV9W
         MwLMQONOlper+ZBWOjp4PAJnmYfUjvkcxZ6FWfFC+YbaU87LWCd4VDqqxRFcrev0EJoo
         YZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=39E6vW6/aAvA+MOoCKzNKPwKqzjWsVvMXH1IH4y+mQk=;
        fh=leQmvePp3P1DLHQGOKZd5AysStXIsPxKPOff4C4HowM=;
        b=XEX0myNfQ835YzdILk4DKPZNb9iL0Nkpt5dOWJwAOnrlY1/Z5dSpxNN8Jt16b+DqmE
         2HaoScYVwKUMjYVLBcrS4omMRB1UnHuGT6pzhOGANMWnSNOAM45AojlTZqv4O3W2Ibd7
         1v6O6AbolQywAp3yFU5gkf2vxoFOQPYb7XlaE0mybe72hpiuIxuMpvgmzekt0zn70RXl
         olTvuMV+/e6QBkeXgbyWuOHVkIPrbBsrjUH73vhVtRCiaX6Cw40H/StESLkwCF8rgUGF
         XmA0tUkAj1YFn2kgL2cpDxSLv/8hsalnFCvoc1WsM8VZzHKOaXrrYTlGQugTizaCIEWj
         G9EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793007679; x=1793612479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=39E6vW6/aAvA+MOoCKzNKPwKqzjWsVvMXH1IH4y+mQk=;
        b=ua891DVI/vtebzFUMuYOmcWft3UELTZZSw3AaMRCcrLZznkX8LdQoBSfiOfHcwf3RB
         5x5HkF4Wqplv4R+QezQHIdzf9xHekp+YHj1p8PhHjw7cjK3Bpt6nPAuHNH6/GQPVuXcE
         9NNIsF9pnRwYw06uFCLr1YqezvT3/FR1FxtZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007679; x=1793612479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39E6vW6/aAvA+MOoCKzNKPwKqzjWsVvMXH1IH4y+mQk=;
        b=rbskQqqSjv5g/H6IRjJud53tbcL8FPGuyujOVr0O7nJWE6YnsBUD9gRoYLK8fosVLB
         AcGQo5aT6R9VvpzxAq5Yuw1NP5tiTMgXDpVZHuhVx68BWgJcgSIycXY8yzxORo8CtDzH
         qz9jUl1WJYb8GYn1qloymMv3WLuFoo12qxvl4S8vnwpbiVQSE6cw48BpKGDum7boaP2v
         O4fosefa4gX8+TLG7xKWwBsOqcQFn1iIbmLzFWjqRP/EC7XTS/UF2zxAtM92mVoFeSIs
         eDo3q6pKitPg1ken9RB48Mr+RCpOkwK0cM42iBRdOhIyXnqXNnP9GwfkJK1livDQ1QDK
         1QHg==
X-Forwarded-Encrypted: i=1; AKwUvBxNROC4jeH0oDwSzssNlW0QQ/VE1L1JRPJVnPDqRgn4SYFQ6Ks1pAZIn7SD+Bd9pCF0gteq2uM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjtQC1uPhoN1GjP90N/gwvOcqwEQ3rvqrn6q4w2f053N4oIyE4
	yumRaRIRx3SKrSApOrO98UoRNWrUox8ysQlz30cqrvpmNTt7VohkffS9XbRmkboYLZANv5Hm1KE
	RI+Bj/zuYiRBHiXXvnlENBz0bhrj7C6VmtUEZZIMWIclgz+YNucx5Ug==
X-Gm-Gg: AYBFou0Zj9fWSUOxeeZVuY2SV+5aUBwIJx4+F9o2SUwI+UKTDnZJcydy6b8kbE47wLR
	KyYFh0iGz1rvBzaZGhkf9MXtS5lPnkY2CyOqhTsLVVtVukgqeJsT9gpuSYGvME73GQzZ9hCJpci
	MnZe5P0as4fg9VcrnaYu67e4Kb3uOwLGeTMN+wCDH4N2AfVrClHcmxLxGmNI6ylzLzGTFUTXZLV
	1kxaTMq43HenI8zyH1szEvof2RnXBi27cj8meR7KuXhEjjHovog99yWtRf0n2xB6xuk5qKWDwbT
	TINOv80HXo95rRRwg6wsxzFIB4qQcRZhwEdZRDW1nrRQOkIy8ewtCkIkRno443HEeIKFWUeL1xS
	qjEB5tJZoxp2QxiHWrhuStT+fjPQFZAAKFOPTefKXNktYaBQou22S63NC+J0rrUUKMb/DP9GmkA
	+SMBrFS27B552dLo8=
X-Received: by 2002:a05:6a21:880d:b0:3e2:8c23:5d35 with SMTP id
 adf61e73a8af0-3e7a1b8a544mr3717353637.0.1793007679641; Mon, 26 Oct 2026
 02:41:19 -0700 (PDT)
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
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
 <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
 <willemdebruijn.kernel.30ca6285209f7@gmail.com> <CAM0EoMm=t2FMLaGNkC_z_a_D5o4=dwVnHS=Bb23NWdmeJVCVuw@mail.gmail.com>
 <CAM0EoM=9GxDCHzpJF_bqcoh+7KZY6E=ZmOiMp7kfVK3bHZDppw@mail.gmail.com>
 <willemdebruijn.kernel.eb29d53899f1@gmail.com> <CAM0EoMnQWjN24gBye1kZdcJUJgXDPDy-=dM+NQ6dqCny7O851g@mail.gmail.com>
 <CAM0EoMnj7pkfGUg=VFjpbU7AGw7ysD_tQOeuUu==YEc9rfQJ0w@mail.gmail.com>
 <CAM0EoMmEuj+k4HXOD08rdtS8+aD-8oTWFedED2kt5XfBR8=V3Q@mail.gmail.com> <CAM0EoMkvAgc6+HNsTUrYZ1RHqRrr5Z2vzJkWsz03jMt6NVcEpQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkvAgc6+HNsTUrYZ1RHqRrr5Z2vzJkWsz03jMt6NVcEpQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 05:41:08 -0400
X-Gm-Features: AclHuK-S6M5HVrCrcktozs8lmc6x1ni0POvowYyPX-T1Tv2bgs8iy1Y_kr9wG_c
Message-ID: <CAM0EoM=t0zL+QDKaEJRhzK38XdpwkimsYgoc8p4SF7dFo3fOjg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Martin Varghese <martin.varghese@nokia.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	John Hurley <john.hurley@netronome.com>, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 4:50=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Oct 25, 2026 at 3:39=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Sun, Oct 25, 2026 at 3:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Sun, Oct 25, 2026 at 4:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Sat, Oct 24, 2026 at 12:14=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jamal Hadi Salim wrote:
> > > > > > On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@m=
ojatatu.com> wrote:
> > > > > > >
> > > > > > > . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Jamal Hadi Salim wrote:
> > > > > > > > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Jamal Hadi Salim wrote:
> > > > > > > > > > > The issue:
> > > > > > > > > > > act_mpls POP can leave the inner Ethernet header in a=
 page fragment after
> > > > > > > > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=
=3D 0) or chained after
> > > > > > > > > > > act_vlan POP_ETH.  A following eth_type_trans() can t=
hen BUG in
> > > > > > > > > > > __skb_pull().
> > > > > > > > > > >
> > > > > > > > > > > The Fix:
> > > > > > > > > > > After the pop, if the original MAC header is shorter =
than ETH_HLEN, pull
> > > > > > > > > > > the inner Ethernet header into the linear area and dr=
op only when
> > > > > > > > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() d=
oes nothing when the
> > > > > > > > > > > skb was not MPLS, so no separate state is needed.
> > > > > > > > > > >
> > > > > > > > > > > Conditions to recreate the bug:
> > > > > > > > > > > - egress tc filter on lo: action vlan pop_eth action =
mpls pop
> > > > > > > > > > >   (chained), or on an L3 device where mac_len =3D=3D =
0.
> > > > > > > > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D=
28, and a non-linear
> > > > > > > > > > >   eth / mpls / inner-eth frame.
> > > > > > > > > > > - The inner header is in page frags; a following eth_=
type_trans() can BUG
> > > > > > > > > > >   in __skb_pull().
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulati=
on actions to TC")
> > > > > > > > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > > > > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9=
271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > > > > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYee=
W0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > > > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel=
@gmail.com>
> > > > > > > > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > > > > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  net/sched/act_mpls.c | 2 ++
> > > > > > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpl=
s.c
> > > > > > > > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > > > > > > > --- a/net/sched/act_mpls.c
> > > > > > > > > > > +++ b/net/sched/act_mpls.c
> > > > > > > > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(=
struct sk_buff *skb,
> > > > > > > > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, ma=
c_len,
> > > > > > > > > > >                                skb->dev && skb->dev->=
type =3D=3D ARPHRD_ETHER))
> > > > > > > > > > >                       goto drop;
> > > > > > > > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pul=
l(skb, ETH_HLEN))
> > > > > > > > > > > +                     goto drop;
> > > > > > > > > >
> > > > > > > > > > Is this first condition needed?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > That was me conjecturing from Eric saying in v1 "...the c=
heck can only
> > > > > > > > > matter when the original MAC header is short.."
> > > > > > > > > Since i have to send a v3 (Thanks Eric;->) I will remove =
it
> > > > > > > > >
> > > > > > > > > > More importantly, can it hide a bug?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > What kind of bug?
> > > > > > > >
> > > > > > > > Two kinds. One, if original mac_len is larger, gets popped =
and the
> > > > > > > > resultant packet is still too short for ETH_HLEN afterwards=
.
> > > > > > > >
> > > > > > > > But this can probably not happen, as skb_mpls_pop only pops=
 one MPLS
> > > > > > > > tag.
> > > > > > > >
> > > > > > > > What this patch tries to ensure is that the subsequent Ethe=
rnet
> > > > > > > > header is linear.
> > > > > > > >
> > > > > > > > The second potential bug is this assumption that after the =
MPLS tag
> > > > > > > > lies an Ethernet header. Is that a valid assumption? Or cou=
ld we drop
> > > > > > > > a valid packet with smaller header.
> > > > > > > >
> > > > > > >
> > > > > > > tbh, I was thinking more about skb frags earlier.
> > > > > > > You are right only ETH_P_TEB promises an inner Ethernet heade=
r; for
> > > > > > > other inner protocols the pull is wrong, so I=E2=80=99ll chec=
k for
> > > > > > > p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this chec=
k in the
> > > > > > > current fix - good you responded before i sent out.
> > > > > > >
> > > > > > > 1/6 (act_vlan POP_ETH) has a similar unconditional
> > > > > > > pskb_may_pull(ETH_HLEN). A brute approach is also to check fo=
r TEB:
> > > > > > >
> > > > > > >       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may=
_pull(skb, ETH_HLEN))
> > > > > > >                 goto drop;
> > > > > > >
> > > > > > > Note: skb_eth_pop() only removes the outer ethernet header bu=
t does
> > > > > > > not change skb->protocol
> > > > > > >
> > > > > >
> > > > > > I am going to send it without this 1/6 change - it just doesn't=
 feel
> > > > > > like good taste. I will add a comment in the changes to say i
> > > > > > considered it but decided not to. I also spent time eyeballing =
the
> > > > > > code, i dont think there's a potential way to craft a packet th=
at will
> > > > > > hit the perceived issue. In any case the 24 hour embargo lifts =
in a
> > > > > > few hours so i am not posting yet.
> > > > > >
> > > > > > cheers,
> > > > > > jamal
> > > > > >
> > > > > > > thoughts?
> > > > >
> > > > > I'm actually a little confused why the tc layer has to anticipate=
 the
> > > > > needs of downstream code and pull headers here.
> > > > >
> > > > > That directly lead to this guessing of what may be the next heade=
r,
> > > > > such as Ethernet. Which may often be correct, but not always.
> > > > >
> > > > > All protocol parsing code itself should already be robust and cal=
l
> > > > > pskb_may_pull where it is needed. Sounds like there are some targ=
ets
> > > > > post TC where that is not true *and* we think there are too many =
to
> > > > > update those targets directly, rather than this transformation lo=
gic
> > > > > that exposes them to unpulled packets?
> > > >
> > > > Not "too many updates" rather the main motivation here (which i kin=
da
> > > > empathize with) is pushback from Eric that you have to "fix at the
> > > > producer" to avoid performance degradation at the "consumer". i.e
> > > > rather fix the vlan action than have loopback vet as in the origina=
l
> > > > patch  (and you just witnessed him stand up and push back on tun fo=
r
> > > > that same reason ;->).
> > > > IOW, we are anticipating so that eth type transfer doesnt bug out
> > > > (_for ethernet headers_) when invoked at the downstream consumer
> > > > (loopback etc). Essentially it is a game of whack-a-mole until the
> > > > next bug or malicious use shows up.
> > > > Generally, policing intoxicated drivers from getting on the autobah=
n
> > > > isn't the best philosophy; it's better to complement that with a
> > > > "driver beware, you may encounter drunks" warning but that would sl=
ow
> > > > down the fast car on the autobahn ;->
> > >
> > > Actually the more i think about this the more i am concluding just
> > > fixing the producers wont be sufficient (Eric!).
> > > If i have an incompetent or malicious ebpf program it could do
> > > whatever it wants.. I am going to try something with ebpf.
> >
> > And the reason i am bringing up ebpf is because i noticed sashikos
> > after like several iterations of a patch find a way to sneak in some
> > ebpf corner case. So i am sure that is coming (if indeed an issue can
> > be reproduced)
>
> confirmed.
>
>     #include <linux/bpf.h>
>     #include <linux/pkt_cls.h>
>     #define SEC(NAME) __attribute__((section(NAME), used))
>     static long (*bpf_skb_adjust_room)(void *skb, __s32 len_diff,
>                                        __u32 mode, __u64 flags) =3D
>             (void *)BPF_FUNC_skb_adjust_room;
>     SEC("action")
>     int shrink(struct __sk_buff *skb)
>     {
>             bpf_skb_adjust_room(skb, -1, BPF_ADJ_ROOM_MAC, 0);
>             return TC_ACT_OK;
>     }
>     char _license[] SEC("license") =3D "GPL";
>
>
>  ip link set lo up
>     tc qdisc add dev lo clsact
>     tc filter add dev lo egress matchall \
>         action vlan pop_eth pipe \
>         action bpf object-file /mnt/shrink.o section action
>
> tc filter show
>
>     action order 1: vlan  pop_eth pipe
>     action order 2: bpf shrink.o:[action] ... jited default-action pipe
>
> And boom:
>     [    6.748140] kernel BUG at ./include/linux/skbuff.h:2830!
>     [    6.748154] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>     [    6.749434] CPU: 1 UID: 0 PID: 301 Comm: mini_poc Not tainted
> 7.3.0-rc7+ #271 PREEMPT(full)
>     [    6.750115] RIP: 0010:eth_type_trans+0x335/0x500
>     ...
>     [    6.757723]  loopback_xmit+0x1c1/0x580
>     ...
>     [    6.778076] Kernel panic - not syncing: Fatal exception in interru=
pt
>
> Eric, any ideas?
>

And worse, i just tested a non ethernet next header for mpls (the TEB
check is a bad idea) and it killed the kernel as well:

tc filter add dev lo egress protocol all flower action vlan pop_eth
pipe action mpls pop protocol ip pipe action  gact pass
BUG at include/linux/skbuff.h:2830 in eth_type_trans  via loopback_xmit

I am going to withdraw this series - lets reach some consensus first.

cheers,
jamal
> cheers,
> jamal
