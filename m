Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B035E949
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977142; cv=pass; b=OZJXYK8dF07pgEFXwpLMZieaJtK3tNiZzDUkQ1NiYeCWUzzdvY+4INPYNqEI93WO1NK9p499/slubvzBMV/GWN/jhRjI+uBMGn4YQt8XpXYSzZfJyXelBEn/UyICioxX4CZZBC5sRsNAIWJpkMRfAS68t0b2fQLT5A/9SviVGvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977142; c=relaxed/simple;
	bh=8PXVs/vJwXci6zYoPKQ+hpQ4HKNdygv1qoTYmsjQx5Q=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBeNOV9p1lTKoUP2GnOt8zplwLqGXlfKKY3ZQb8sb0xi26SndRxl28Ha4UBSk1UOFGSX2KCBAY1JYsD3COM5MhT8ITfP+2kzrzvS0Vfds9sX6vx+YYAMBWXhLbCFvh2fR7gP8IkVctncUBmqfFc7eEeMjpbkCDocV8dqujUpiis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=AuwGr0lG; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="AuwGr0lG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc73e322dbso41180285ad.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783977140; cv=none;
        d=google.com; s=arc-20260327;
        b=fqgfOWP6aggmcRi7FGzYBIBghvzOIbeuENworTdx7jJmmcbjlweJ5EHfB0kuONI2Da
         pXVhIDMJnX+TOH+Sp7y6aJfD8nBoQm5QY+qu+NHknIfxYzzqEBWsRrNf/uK5mQDwQAtp
         j1CJeWxOb/4K6Hai7pXrqZYPkECI+JXnEYwSQ+1tqwgM2z2Jn3lqf/7P7lpFl6PrGWSm
         k2LzsSFzBVVyzpehIO7Y1BvLnjsa8otdILSp/w1OQ8WFSrvkL0kP8poxte58gHVypJUJ
         Ziuj2lCxu7WJikHZUVEj5UwDt5yOfLAhlKAZIP+c38wKntDcP5MQxhmy4gR4j+uZ+mNT
         XPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
        fh=r+33VfzZJGOU9oXTkps28VA7XxsEReN6++yhgXh5PJs=;
        b=Q+bYRAYSp74xg9yeHWrwbiApJ+6J66W885JjqSem2Jq8xXCDer0zyF441aohc4tnaR
         BsUs1p7XhMs/mMoRICMbH6SWPp97EiqARMTNKmErUBkfYXd+LFEFNPA5R+BdhN4qZCip
         wFc1ZZ1qh95ku9KK74yf3A7CLvHo808fg0VW5tFcBUFrRbw38oEi0F2v4rfxiguLNiIq
         qlo+IWofUwWnZalX6VQ6FtyfXmYZinA2wRu5YyrwLguJmIL5lHvAN5HLKWER54oR5JXc
         4N6eisngVfnlpMHWYAenbe/71870Z8h4U3T93m/ZILjNy31A2tjIymvwPHg6c3trmYOO
         CwUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783977140; x=1784581940; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
        b=AuwGr0lGDDCHJtNm9lXTNc3DAbpSxBMnkBqNpX4312yBpmq5Q24mtRGrI3uPPLgQH9
         OMYgIz3Sr+2vC20tljuj9F0rhHDa5utb8guwLtVG2CRLfrzdBvrp+asMiPEiUkV9LSyK
         8bWdtWL40Zxx3PxkhwMqJni22W+CchbzzZ/xChuoib8HlT0/mTnORhSmc5LsJObSywMY
         3S2zBTJZO2p1wMesvG561TV0GfZCNj6646x3r8ZDoWwNy9CFa79KPFCRpum6lx5mrsna
         kgv6SdZSPoqoBn/Ht8yNUo212gCUSeK2EslvC9VDcW4UIK9pWR3ij80TRyD+WkkRJUCc
         1PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977140; x=1784581940;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
        b=KB6yjL5EnTslNofah3/rLHcXTBwcQLU5Z5FmzGjyb34gn/9c24iDERmD6+DYsx5Cmx
         O6wWG3bpHxN45u8O9vb+idqViIB5IBc95L8+b3oSliDcpYtDFPmI32+HslDSjzZ6Nz+h
         gfNSDzLNPhM5sK5QDWv67T0MML1I2nyVXPUHxMRy8PZwAqKo2Q1t7FajNkYWdHRHSrHx
         Fja8yJC3vHe6L9Wmhf8zGTbeF8ZkXnZaRjrWCKXF4tKRFZ1IhOLNp5CVb3/AcKqKQ4Lr
         JEP3DrtW4FED+9o55y1C4DW4N3K9FUNTrQK8Wt9DNSc1fbb1VzE75myxsfax52d98LI9
         5BZg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9KK9hRdFGXhAfemuaLBxC6tgTdoMIDvEYNMWMJn3wSbR4uW9VfK9ChnhYB4E7wv9xEcOI5Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyV0AIMXmvD1QSOSEVyyzgiSRTVv9oUjvWQxMIM8y72Fpmv+/u
	rJQW5umVqwEWDJU+N/nQquUW9c6RuDoPPD4SefcUAK8t3PBjjpUtEAAMVMrG02YEPLek7X/NRqg
	iXHJnhtMde7lOhvDkMx8w5lXh86vPPaPQSLZy0k8yzM8=
X-Gm-Gg: AfdE7cnrOzYr/hACydWpeaL5y7f0Pc5zPzw4wSd8ZQ4PIvRzErjCrbs7KAOlkrbp4Ub
	ooeYax4L+qlwy+rRMhzPN86tDjRbA9DSaK7NKBlbP2YmDFYcgzbOvykpX3081Bt0JQMwmeKZkN0
	FJuq0spD3tScEBeGQdEl63dweR0uu3FyQ9c6iWNHU1LJjMOS/lVZdnH16/azPda3JbALKd5QKqm
	2+lgXeOMYHQbV1TmuGenbUNHjB6GfYpNS/Ijxaoamg+48Ptro2LCfjAumjXa2K3C7jAq3UssTq/
	h/+jnNavsDD5S506Bwm1O/iBC4WpcmER8/AmNMLIGIdvZXaDyhbfra06mQ==
X-Received: by 2002:a17:903:2301:b0:2ca:ed41:d331 with SMTP id
 d9443c01a7336-2ce9f27eb79mr100834245ad.45.1783977140474; Mon, 13 Jul 2026
 14:12:20 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jul 2026 16:12:20 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jul 2026 16:12:20 -0500
In-Reply-To: <20260713200417.dghlrj4ca27b6nd4@skbuf>
References: <20260713194010.54642-1-doruk@0sec.ai> <20260713194010.54642-2-doruk@0sec.ai>
 <20260713200417.dghlrj4ca27b6nd4@skbuf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Mon, 13 Jul 2026 16:12:20 -0500
X-Gm-Features: AVVi8Ccf64lA0azySl9H8ulwhmt3h2F_jWjPpkuQXsHGkD6_OCbSPA-I2DgzOTY
Message-ID: <CAPdMp1qf4q42MAaRqqzYnhYyU9KvdryGQR+TWsFNvJ1oCTnPKw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset
 MAC header on transmit
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Woojung Huh <woojung.huh@microchip.com>, Nick Child <nnac123@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Sabrina Dubroca <sd@queasysnail.net>, Arun Ramadoss <arun.ramadoss@microchip.com>, 
	UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

Thanks for the review.

I checked the DSA cases with CONFIG_NET_DSA_LOOP=y. Since dsa_loop
normally uses DSA_TAG_PROTO_NONE, I used a local repro-only override
of dsa_loop_get_protocol() to select the relevant tagger, then sent an
AF_PACKET/SOCK_RAW frame with PACKET_QDISC_BYPASS and
sll_protocol=ETH_P_IP through lan1.

That leaves skb->mac_header unset (65535) on the direct-xmit path.

For tag_ocelot_8021q, the eth_hdr(skb) version reproduces as:

  BUG: KASAN: slab-out-of-bounds in ocelot_xmit()

Switching that site to skb_eth_hdr(skb) makes the same reproducer run clean.

I also checked the LAN937X path the same way by forcing
DSA_TAG_PROTO_LAN937X. The eth_hdr(skb) version reproduces as:

  BUG: KASAN: slab-out-of-bounds in lan937x_xmit()

and the skb_eth_hdr(skb) version runs clean with the same packet sender.

So yes, for these DSA TX paths this is a real bug on the
PACKET_QDISC_BYPASS path, not just a future-proofing cleanup. I have
not yet checked ibmveth with a pseries/ibmveth setup.

For the older DSA commits you listed, I think they should be treated
as stable candidates if they remove eth_hdr()/skb_mac_header() use
from the same TX path. I can go through those individually and send a
follow-up with the exact stable list if that would be useful.

Thanks,
Doruk

On Mon, 13 Jul 2026 23:04:17 +0300, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Jul 13, 2026 at 09:40:08PM +0200, Doruk Tan Ozturk wrote:
> > ocelot_xmit() reads the Ethernet header via eth_hdr(skb) to test the
> > destination address against the link-local range.
> >
> > On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
> > reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
> > resolves to skb->head + (u16)~0 and the read is out of bounds.
> >
> > On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
> > done for the same class by
> > commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
> > and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").
> >
> > Fixes: 43ba33b4f143 ("net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs into BLOCKING ports")
> > Cc: stable@vger.kernel.org
> > Found by 0sec automated security-research tooling (https://0sec.ai).
> > Assisted-by: 0sec:claude-opus-4-8
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > ---
>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>
> I was not aware of the bug introduced by commit d346a3fae3ff ("packet:
> introduce PACKET_QDISC_BYPASS socket option"). Commits
> eabb1494c9f2 ("net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit")
> 499b2491d550 ("net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths")
> f9346f00b5af ("net: dsa: tag_sja1105: don't rely on skb_mac_header() in TX paths")
> 0bcf2e4aca6c ("net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX")
>
> were made assuming that the bug to avoid would be exclusively a future
> one (the revert of commit 6d1ccff62780 ("net: reset mac header in
> dev_start_xmit()")) and thus they were not marked as bug fixes.
>
> Are they true bug fixes, as in "can we reproduce these [using
> CONFIG_NET_DSA_LOOP=y on virtually any network adapter]"? If so, should
> all the commits above also be backported to stable?
