Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792835685;
	b=vJLWphEgLkFrXzqFI5GavACqNo3q+lmyT2G6q08StOtMggZqR8uI+cy2V2ml38yWLN7M
	 cZpyds9gMWXGSW9ckxWs1UkJYbpEGB5VsIGutsqBqn2X++aEKAdGTwsxhun1EM64oi57Z
	 aiPt/KgB1Df/2jcwqMLkQGqKe0f7m2MqqlgqiwN47QakOkplQvQ5Mh9OkVKUrVvmEu8qT
	 pUXMtHWMidqTptWrU0J8yYDvodQUkpRa0UH22uC3okSy72ZsKTToNjCzgRFQ88lAetY8t
	 SGZhBClDY0/iS9JwBBbK/8AomXF9UWmPjsCM8zkToymFTlaX4YQu3ahTac97Ej7Y/uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792835685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jSHUqM6sVNj4KA+FGbxHG4caWaVLve4l4npIRz/orKk=;
	b=DgCmQjp5j6w62KD5XXkLYSjXT3HwiT8FPxDNQjHocG5X1vK9Pr/+dfc5bblB/jdtxQII
	 ltWkQ6ZxnuUBgweUZ+3acZ7Glk6X5ipw9ZxIilOTYnWP5yH5Uarf37T2O5xI/CL9H6CE5
	 CKgxtxBfDFHmNql7xlC/d8WBI2amLLVNEk10jSaNP4dZWo/c/h2PtIt5MdS9ycOkbM85b
	 22UVmb3PSFgkhUEV+OHjxLiHdIbswnOSzNoJ5KAv0OJdwPE00yomv6yPuK7chSJ+WeALw
	 eZGqzpCvTzqDNzsETz6eYi9p2EjUDU7OpA+c93sT/xTS8UC1rUQiwo1Nn/TrBPgcq9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xYuLJUtj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B041606A31E
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B041606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xYuLJUtj
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so1194639a12.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792835684; cv=none;
        d=google.com; s=arc-20260327;
        b=bbA1fXALxLZTp8Hqwa0kTO31dLoVtAWRbyOFvWD/3+YjtdWj95EnRWNhP0Iuico5wf
         cFui48A7Oy4O5NXbyMEEAuwkw4KKmBa5peyDeIe9d6NP+V+w5j4As6BGV8LjWMdVh3tA
         1mzAMp5dCey4aTdQPP3gWaQrBRQY/Qdl6FOJ3SlYkIxAyv8Mz3od7dcIibF3i3/JdRBI
         S1nVLYttPPdRjL1sU0pfntlnwHRRIbA7Cd29bM/iwEIkOxKVv35J1cunUFFNHvNaErlZ
         vFoRkzFfSotvjnZLmxRrUs8YXm6I4Ek358xhOckHkp+GpxoUd/vXCgPyM2dk7IkI6bys
         LFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jSHUqM6sVNj4KA+FGbxHG4caWaVLve4l4npIRz/orKk=;
        fh=7rX9aX2ysdJ7ftXSGNaGBXXnSwF/YB9V+ZcF20WcfRE=;
        b=KRFlKkZE+mqSBkrZMytxMxIQUcTWIqe9gzwaYSObdIvoX6m4oxI8u2kuAWeBbwvKHB
         A7pXpuwS2RtpjTpgqh3iUyzoHMNFUkjHL3AnVh4Jx84vpr4A4ZG9Ha1Bpu3VpY3etcPU
         hQFdQPQSRWokyNWETYM4Gt3i93aBFq50DKyDOWNwENncb7b7WfydVTwmZr+TtQuqPLo8
         M48NaFdC29unBERumo/cq7QziRcdDWsVLtczvk2tG0kNKhP0OS7NapTPJOT+NA0SQFAZ
         sTDx/UI05dQBN1Kr4TIusyGdUPx76AgGoBwtUFuhg1BnOeeHwmNfM7A3re3Z+p9fYj21
         AlkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792835684; x=1793440484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSHUqM6sVNj4KA+FGbxHG4caWaVLve4l4npIRz/orKk=;
        b=xYuLJUtjK7ChZW8JwqJRH//MAhrs4S+v2TQtv/Lhw8WgAaK7+KSJumkA3m+X5PiId6
         uExYt+M9I+AQu1K306CriByd9pLvjJBxsXxWOpIBkKJkscDxEuWG3jvUZuD4qfMr5qIk
         VoW5emT13A6ywa2xvsda9FgrnmkgBR7lbybCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792835684; x=1793440484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSHUqM6sVNj4KA+FGbxHG4caWaVLve4l4npIRz/orKk=;
        b=JIEGQYveyogTRoC5W+Z50oP/IDwc0ZDRqKvGl7T4+eZH3sSW7bmbDxMXqwogqBtk/2
         UrCJ0vVq5PqUcp75ymupN27JO48ERlih2rWgtSm9xTW6INU5q/e945shthjJLVdSTQnd
         v2cosnIJgKFAuqNgqUSd4ul9uoDJf1/y3P5xNC4P/JK3DXmcXyHMrj6Zto2xDwlq0b5s
         8WW/nIFNqr9ZOrkpFqH0kJ/rJ7MYl04NI3uTP8kn7hwgMwu7bOYlpBfCwgD3YwjY8Snz
         bOf3BscBUCnC2eJPTSvYAmEiyv/o2Nrn3inyd6tzEoXzjf3X28gW67NHZkJW56tS/15q
         Xg3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwpeDx24dz6bwQL/xtdgdXbo2k41XUHc63repAt4YYpMJODhJ0srTiFSgUOukhg8/ts5kmkzt4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKp67NdenV8qfG/GBZaZoWHLDWE+OvMhMHsvFEDo2IAdbpoEZCW
	gZiC5s5nTIl8CHiJbQo3CMfrFs9jUPkW9PJxFBF0u7TnID9GqboQBHQihE85aHhlGnejjAGq3vm
	rJtI7WJ/d0kWkBK+kDF7Ggt7HgI4UJqAhNbrWHlKpkFWhpJvRF9w=
X-Gm-Gg: AYBFou17U03/yveGARJfAodfU9esWubxZN/YbZAeidNjSyb8sk6XdD9KHuWKZJWG0OE
	F7X5GTs9B7AIkdT8aFYrTZOid8KdKl7HgGm3dlCG17u5RLk9Jn72o7f5ERP5UKeFRNlsSHidu5g
	ys0HhJ3NZEpos+izcThLHLGd0+KaxA5C4qEYNYWhlrJbrz3xtgidygtZbvoWcMn2q7bMdeTR553
	bhlG6XAU9A3T++pTgvJ/e1eg5EwDfvkrbMRYcMBnqOkrs7wCLe/s449qPkRpHhi7zm6M8aqIL5/
	oTPn3LxISgTssrzaKrGcJ0NVYB8VC676MX+MxEZ4/k6GfZKbKTjTyHWSo2Rw/wsaszEnEBWScmt
	tYQ7gj/AfAjVcxtrUl28o/DRvOVXAZwhAmil26EIxUl36MYLEnnsdiKsC9GBEls1ouzGenqr4mR
	hzM4CDNmFW8XW8meE=
X-Received: by 2002:a17:90b:57cd:b0:3ab:884b:65a9 with SMTP id
 98e67ed59e1d1-3adeae9c162mr1503965a91.25.1792835683692; Sat, 24 Oct 2026
 02:54:43 -0700 (PDT)
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
In-Reply-To: <CAM0EoMm=t2FMLaGNkC_z_a_D5o4=dwVnHS=Bb23NWdmeJVCVuw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 24 Oct 2026 05:54:32 -0400
X-Gm-Features: AclHuK8x6YsYN68U8TrqczucCZRfN0vZR36J_wmmtKQG0gjq4OLQPKHjLwQKBEk
Message-ID: <CAM0EoM=9GxDCHzpJF_bqcoh+7KZY6E=ZmOiMp7kfVK3bHZDppw@mail.gmail.com>
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

On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jamal Hadi Salim wrote:
> > > > > The issue:
> > > > > act_mpls POP can leave the inner Ethernet header in a page fragme=
nt after
> > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chai=
ned after
> > > > > act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> > > > > __skb_pull().
> > > > >
> > > > > The Fix:
> > > > > After the pop, if the original MAC header is shorter than ETH_HLE=
N, pull
> > > > > the inner Ethernet header into the linear area and drop only when
> > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing =
when the
> > > > > skb was not MPLS, so no separate state is needed.
> > > > >
> > > > > Conditions to recreate the bug:
> > > > > - egress tc filter on lo: action vlan pop_eth action mpls pop
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
> > > > > Cc: stable@vger.kernel.org
> > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > ---
> > > > >  net/sched/act_mpls.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > --- a/net/sched/act_mpls.c
> > > > > +++ b/net/sched/act_mpls.c
> > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_bu=
ff *skb,
> > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > > > >                                skb->dev && skb->dev->type =3D=3D =
ARPHRD_ETHER))
> > > > >                       goto drop;
> > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_H=
LEN))
> > > > > +                     goto drop;
> > > >
> > > > Is this first condition needed?
> > > >
> > >
> > > That was me conjecturing from Eric saying in v1 "...the check can onl=
y
> > > matter when the original MAC header is short.."
> > > Since i have to send a v3 (Thanks Eric;->) I will remove it
> > >
> > > > More importantly, can it hide a bug?
> > > >
> > >
> > > What kind of bug?
> >
> > Two kinds. One, if original mac_len is larger, gets popped and the
> > resultant packet is still too short for ETH_HLEN afterwards.
> >
> > But this can probably not happen, as skb_mpls_pop only pops one MPLS
> > tag.
> >
> > What this patch tries to ensure is that the subsequent Ethernet
> > header is linear.
> >
> > The second potential bug is this assumption that after the MPLS tag
> > lies an Ethernet header. Is that a valid assumption? Or could we drop
> > a valid packet with smaller header.
> >
>
> tbh, I was thinking more about skb frags earlier.
> You are right only ETH_P_TEB promises an inner Ethernet header; for
> other inner protocols the pull is wrong, so I=E2=80=99ll check for
> p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this check in the
> current fix - good you responded before i sent out.
>
> 1/6 (act_vlan POP_ETH) has a similar unconditional
> pskb_may_pull(ETH_HLEN). A brute approach is also to check for TEB:
>
>       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may_pull(skb, E=
TH_HLEN))
>                 goto drop;
>
> Note: skb_eth_pop() only removes the outer ethernet header but does
> not change skb->protocol
>

I am going to send it without this 1/6 change - it just doesn't feel
like good taste. I will add a comment in the changes to say i
considered it but decided not to. I also spent time eyeballing the
code, i dont think there's a potential way to craft a packet that will
hit the perceived issue. In any case the 24 hour embargo lifts in a
few hours so i am not posting yet.

cheers,
jamal

> thoughts?
>
> cheers,
> jamal
>
> > My LLM raised similar points and says it better than I could:
> >
> >   1. Missing protocol check: tcf_mpls_act handles popping MPLS to arbit=
rary inner protocols (ETH_P_IP, ETH_P_IPV6, ETH_P_MPLS_UC, ETH_P_TEB).
> >   Requiring ETH_HLEN (14 bytes) unconditionally when mac_len < ETH_HLEN=
 drops valid non-Ethernet packets shorter than 14 bytes (e.g. popping
> >   an outer label to reveal a 4-byte inner label stack entry on an L3 pa=
th or after pop_eth). Pulling ETH_HLEN only applies when popping to
> >   Ethernet / TEB (p->tcfm_proto =3D=3D htons(ETH_P_TEB)), exactly as do=
ne in patch 5 for Open vSwitch (pop_mpls).
> >   2. Gating on mac_len < ETH_HLEN: mac_len here is the pre-pop outer MA=
C length. pskb_may_pull is already a no-op if the linear buffer is
> >   sufficient; gating on pre-pop mac_len is unnecessary and risks skippi=
ng the pull when mac_len >=3D ETH_HLEN even if the revealed header is in
> >   fragments.
> >   3. Downstream metadata invariant: Popping to ETH_P_TEB exposes an inn=
er Ethernet header at skb->data, but skb_mpls_pop leaves skb->mac_len
> >   at 0 and resets the network header to 0 (skb_network_offset(skb) =3D=
=3D 0). Downstream actions such as act_mirred (with patch 3's
> >   skb_network_offset(skb) < dev->min_header_len check) will treat the p=
acket as headerless and drop it, causing regressions in L2VPN
> >   forwarding (tc_mpls_l2vpn.sh). When popping to TEB, the L2 MAC header=
 boundaries (mac_len and network header offset) need to be properly
> >   established.
> >   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> >   ### Summary of comments:
> >
> >   =E2=80=A2 Patch 2/6: Missing inner protocol check (p->tcfm_proto =3D=
=3D htons(ETH_P_TEB)) before pulling ETH_HLEN; drops non-Ethernet payloads =
< 14
> >   bytes.
> >   =E2=80=A2 Patch 2/6: Unsound pre-pop mac_len < ETH_HLEN gate.
> >   =E2=80=A2 Patch 2/6: Incomplete header bookkeeping (mac_len and netwo=
rk header offset) on TEB pop breaks subsequent redirect actions (act_mirred=
).*
> >
> >
