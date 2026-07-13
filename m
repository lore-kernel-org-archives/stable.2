Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B42BE02C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973064; cv=none; b=byTgpvlnjkR4iXy1FnlicD+IfHtEL+yCIEdkAhAsrC5MZk5sNG4T+1NYY2K8gbhkXdH3ona+oKF116gLUxXZsvDWYyHYjwQdL0j7Sovu2qTsj5SyrSpf0p7jnyzZQqQKv5yMNBKytb2Z9paPhAW7QnChfu2Y7FFICDbHX5B0DvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973064; c=relaxed/simple;
	bh=YF+KOotGzZmW5OzmRDV//DtHveaZ5nJeRsKupPRkt7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=six++qbpMpgOUrionsw+QghAlKSoSx/fhxpSxjAbvI0O0RBWzPBicsPHALnmEV5Ew8vC5ySFPRnGVkmArkU0+g2mLN3fB4Xs/tsRuZA+/Mks1tNm4dE0KCj6DfGbOmOPjxo7BhFbW+0N+lvLVKKO8obIA9ny9A9vkwXv0qnf54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgkFk3n1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgkFk3n1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-494049206c6so606135e9.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783973061; x=1784577861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JTj575AcHAom2fz7OwDDRttEo4AE92OOBeJUOqyrws8=;
        b=HgkFk3n111Uu2CWlsOwuDk71tx53WKuPJM4XSbnq8Ii8Al8FgRS7/TN9Ooc0SzS8Ih
         0z/155WlWBOAq8NfjKLt3MkWhLffWp4QKiOrJ1R+AWFtFmg6CofXbl8wSUQeCCfu7Bao
         rWKrDmeloj9iIvvyP4b5W1CuS+URN+R5CwHxvAuTgAygpTLENCSBV52PH7hi9PZ9H3Ac
         JG2QsBOeFw+RtnTSsWOselL9mWGqKryCSshJEjD38J0WcGBHAtSaFFpfgWceDYroEJWN
         I8OiG7NNZA6OsENsVIQ4PWzKDF1zXnjayvMoIVtbZv6QiyCcb67sCUbP5bkbMNXs6UcP
         Z7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783973061; x=1784577861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTj575AcHAom2fz7OwDDRttEo4AE92OOBeJUOqyrws8=;
        b=j4C4K95IYcofZxdOtobyk2RmNXa1KCTWbSmQPMtd4BGPIx+CJC1R3wkRNRKId8o4Qu
         ggTO1ywigYXpT7HOGPJ3jmQNpblPs0DLgR3lF2qwTtPuJukXcWh6CxY79yP0u832YqUe
         6N0qClyYcGqnRrNxTDPUHBhAcLyqq2yrbYOE5HBCrUvpCxx/fV6l9LD1gU6m5ZMiVaOh
         nhM0RY4mbwPIxovvzxDOezQF8OQSi/mpUEb8ujPC3Bai9WR7hcf1t/9GD0HGJ39lilLA
         uk7u9Pq22LcZTRwneu5FyXkd7+kbXD0xIZATsigx+Hv395i5R5RgUEukSU0Va5wD8OjG
         nGjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpe60vnzl3Ay3+NILdJusoQKZgl5NJOD+if0jxsGMkJO8yG7IdEcfNHA10J1pShpENvehqtwTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdckrS7dzsp7NA01egbioKqoTQ2H4fvWpbYda0i7V3tnqMG+xn
	CiK6buGSZH0vfIFVN4h420xoA2yfuWCHZZOeJsC0PDQKQMhaDwNqBNfG
X-Gm-Gg: AfdE7cndOe69fv4K6gedBG5sKnQokqqhFs5iGtE7iT/vZzLpr8J68G+fcgAVOGNy2Wf
	dqtoL4x1KwJdlasGVQDi/z0LWlc9+ibBMTGrsd6iqdfjAVRCcXPOqNYkz92MlK2D/7vGinxXNjW
	aXeBc8pA4+TC6JTG1fFmyfgL1uU72N8fctACK6PVfGf3QzXXciN6ZrwoIDVXcFqRMKSAhpQdc+c
	ybcQW1WiceSzHcL28w9w4IG1QftALnIon6we5SGLHRJW33nQ7xeps1OPKYBfZegexqJK+UyxN15
	2ObA9XLRQBaO5GDEDT1YLfb/TxKCY2gbIpFCe0SwLV7mH+vqC7Xu0tXQ5cBdtXA/YlJQrbcelLA
	Q0ML+5NXWIES7jinasxub7CiDTy7gWpGw/v6IhQdeXOqo4RX+K//0aYBODiBf0LGnL/iTL/20HS
	XgDWLy
X-Received: by 2002:a05:600c:4f94:b0:492:1e4d:d44b with SMTP id 5b1f17b1804b1-493f8835228mr59867925e9.8.1783973061275;
        Mon, 13 Jul 2026 13:04:21 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:d8f0:7a38:1703:914b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a322c86sm17366115e9.11.2026.07.13.13.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:04:20 -0700 (PDT)
Date: Mon, 13 Jul 2026 23:04:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset
 MAC header on transmit
Message-ID: <20260713200417.dghlrj4ca27b6nd4@skbuf>
References: <20260713194010.54642-1-doruk@0sec.ai>
 <20260713194010.54642-2-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713194010.54642-2-doruk@0sec.ai>

On Mon, Jul 13, 2026 at 09:40:08PM +0200, Doruk Tan Ozturk wrote:
> ocelot_xmit() reads the Ethernet header via eth_hdr(skb) to test the
> destination address against the link-local range.
> 
> On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
> reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
> resolves to skb->head + (u16)~0 and the read is out of bounds.
> 
> On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
> done for the same class by
> commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
> and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").
> 
> Fixes: 43ba33b4f143 ("net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs into BLOCKING ports")
> Cc: stable@vger.kernel.org
> Found by 0sec automated security-research tooling (https://0sec.ai).
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I was not aware of the bug introduced by commit d346a3fae3ff ("packet:
introduce PACKET_QDISC_BYPASS socket option"). Commits
eabb1494c9f2 ("net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit")
499b2491d550 ("net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths")
f9346f00b5af ("net: dsa: tag_sja1105: don't rely on skb_mac_header() in TX paths")
0bcf2e4aca6c ("net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX")

were made assuming that the bug to avoid would be exclusively a future
one (the revert of commit 6d1ccff62780 ("net: reset mac header in
dev_start_xmit()")) and thus they were not marked as bug fixes.

Are they true bug fixes, as in "can we reproduce these [using
CONFIG_NET_DSA_LOOP=y on virtually any network adapter]"? If so, should
all the commits above also be backported to stable?
