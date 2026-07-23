Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0240374756
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839934; cv=none; b=CblOwWqocsWqI8mkmbSJLVbeVs9NfMYFbjVRa+HC3hOVbhcgG8lXD0EFXSb66lsAIc6ZC2xMn2xQZBQaKvNIpMCV4j03YvSX1wLIPYAvwCuzBQ1lqR+Zezn5Qnr5sLC0681JZd1fcVxJr7JxFiPphAAFElPcYLmF1ZnXkIjiTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839934; c=relaxed/simple;
	bh=8FzMKVurMX96eBmO7rvDjkl8IBJD91E4fy3Zy7Ke1uA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=l1owbAXn4Prk6W2evs1MS3r+ZXZoJzVlQHh3xSDqfXLcaMm6heGvSdujdcTdKANboB+ULkufyi38kKR8z3QMfPHI9wSROAEEcw7UDm/uxlt2quCv2hYH54EKfz/kCllrGA4fsNHgszR/xAYeGOC7EuCs0CLgbqc6kDcJYbaHHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9uYKNyj; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9uYKNyj"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-668005ba03cso964339d50.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784839932; x=1785444732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ITRYudtWCLKdCLtF65U0D/VRCHaXKkiHBj5IzKVLDcE=;
        b=e9uYKNyjTwkRx4UTdwfLnNm/idXh8JRCXdch3ts0bNsZ43u18haSwIUgUW4Py19oI9
         eMeF/l1zIQVe7FRWeeaM8U/pQ+6juxP4PW3PwJSPkbonv5xB42PjgWKOcvTsrVEXKNTk
         TWCU+nalP7B/H2J76E9VYyXLsJFncTthvBtKHZE6jZPyyTLIbdvEHL7oiGS70yAkFdlR
         eE70DJG8c/+oX09uANluI3GelLZcRpO/Z4xwVxvM8vFkV+SS6q4xJ35scNfcJNED2fUF
         3ygJMFXZFXteOg7dKfGhQ9YoqOqqUrSnippdzlA8c5lbRx0IXYquisR2J4xjX2lmrZPQ
         J7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839932; x=1785444732;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITRYudtWCLKdCLtF65U0D/VRCHaXKkiHBj5IzKVLDcE=;
        b=RgObcerI9BDKUXvQBvqtwGI1UpXUMaEX2UAuPLBSpCbIPZ+QiQqL+nHyB8Fv0LDhSj
         c7xkIZZZmKyhSnsybRV3FPp1mBAJEqyQjqjPX0Jr2f6lrAE8t2xRXB9cuOATVcEfvIbu
         Lel7VXNTuprudIEpfVnsUCmpw+qQq1LcaQiHw134hW3W7qTbv0Uq8pZtlrVNxh8SFvN8
         cMKDWx0ME1+aWQNyt2ywuWDvefM2ikQBSvt7JUvqWi/0g5Bir6HI31YNQa49NxybeZNj
         mQkohhyDmvPIqi75k0vz7ScoKOSoY8zGol959cd+b4HGXgrmzXZcbk7h7pHwr6k0W8Hp
         LpjA==
X-Forwarded-Encrypted: i=1; AHgh+RodiVE+J31N4F5J+giHUTe5pmz9/Gj990DnBoD8h+sdlaM/kWsXJyiZNDBjnXQDKRQ+JAYaYVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPYrSwX+iw6GL3Garq+n4jVFRA+0O+qAFFVCWuuXUF++B9jq9
	SyFGjESizKn+NKS80dvuK7+zKJ5S7F0/b9lBh58airqIeyxJkL5eAeyU
X-Gm-Gg: AR+sD11+Iv3rLvkl7hHBSUZ3QCTivStGuGalM9zQu8sm4IdvkE59YygBv2wX2On2kmO
	TJsaWTTFGp5++NiF0Rf+ROGPybWyNVkY8Bau9m8CpmfUVxEwGi9KZ5jEo3AckfOOuUDxP6LBE/y
	x9rJvni+jfFEmCeC1Jnj4ZmvpJ41Zs4AYyRnXRfkZDTzYQrhz2BSJ3A6IX9Fun/41sCXkz3i2j8
	GQyPXL1tVLhxfRTOLuN8rccM0Mt3BAGPUF07zXSZcmuy1FEBM8mMzJhvz1ny9LcpY2Cz+GgzB6S
	9zUrwual7IAoS9K3wzwCM8At3ntOcCvlGmdHujRdek6yiycsTJgu2+FGokK2dVl+PcKm9CNbkh5
	iWVZcdAGyjU7H7GgGHWVJBDCZs/P/4dM+vH+V0/c0D7ix/SGezDiqIXkN8MNjblWXEIFk+nizzE
	Qn71Qd5x4DFNwYYZcgdFvGcW3KJ0pzNACJajpxyMiErTgCgIiPetC5saM=
X-Received: by 2002:a05:690e:b8b:b0:667:b645:530a with SMTP id 956f58d0204a3-668a5001e8dmr1235095d50.83.1784839931719;
        Thu, 23 Jul 2026 13:52:11 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66890523c01sm3800327d50.2.2026.07.23.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:52:10 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:52:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Doruk Tan Ozturk <doruk@0sec.ai>
Message-ID: <willemdebruijn.kernel.4957260f765a@gmail.com>
In-Reply-To: <20260723020337.19040-1-doruk@0sec.ai>
References: <20260723020337.19040-1-doruk@0sec.ai>
Subject: Re: [PATCH net] net/packet: reset the MAC header on the packet-socket
 transmit path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Doruk Tan Ozturk wrote:
> packet_parse_headers() resets the MAC header only for a SOCK_RAW frame
> whose socket did not bind a protocol:
> 
> 	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
> 	    sock->type == SOCK_RAW) {
> 		skb_reset_mac_header(skb);
> 		skb->protocol = dev_parse_header_protocol(skb);
> 	}
> 
> Every other outgoing packet-socket frame therefore reaches
> ndo_start_xmit() with the MAC header unset: a SOCK_RAW socket bound to a

The normal __dev_queue_xmit calls skb_reset_mac_header.

This therefore only applies to the dev_direct_xmit path.

> specific protocol (for example socket(AF_PACKET, SOCK_RAW,
> htons(ETH_P_IP))), any SOCK_DGRAM frame (its header is built by
> dev_hard_header(), which does not set mac_header), and the legacy
> SOCK_PACKET path. A driver that reads eth_hdr(skb) on transmit then
> dereferences skb->head + (u16)~0, an out-of-bounds access about 64 KiB
> past the head.

This is not currently an expected invariant, but I see from a comment
below the --- that this approach is proposed instead of fixing up the
buggy drivers.

> 
> This is the same class fixed for one consumer in commit f5089008f90c
> ("macsec: do not read an unset MAC header in macsec_encrypt()"); other
> TX .xmit paths that read eth_hdr(skb)->h_dest (several DSA taggers,
> ibmveth, sja1105, the atlantic PTP path) have the same problem.
> 
> packet_parse_headers() runs only on the transmit path
> (packet_sendmsg_spkt(), tpacket_fill_skb(), packet_snd()), and there
> skb->data is the start of the L2 header for every packet-socket type.

There are some subtle points with variable length L2 protocols that
need to be reviewed.

> Reset the MAC header unconditionally so it is anchored for all of them,
> fixing the class at the source rather than hardening each consumer.
> 
> The protocol probe is unchanged. A CONFIG_DEBUG_NET build stops warning
> about an unset mac header in skb_mac_header() on these paths, and the
> out-of-bounds eth_hdr() read no longer occurs.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis;
> verified against source and matched to the macsec KASAN report in
> f5089008f90c. Compile-tested.
> 
> Fixes: 75c65772c3d1 ("net/packet: Ask driver for protocol if not provided by user")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> This supersedes the per-consumer series "[PATCH net 0/3] net: dont read
> an unset MAC header on the raw/qdisc-bypass TX path"
> (https://lore.kernel.org/netdev/20260713194010.54642-1-doruk@0sec.ai/),
> per Jakubs suggestion to fix the problem at the source rather than
> hardening each driver.  Vladimir Oltean had reviewed 2/3 of that series;
> this is a different (source) fix, so I have not carried the tags.
>  net/packet/af_packet.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index e75d2932475a..adfb9c19a3ca 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1924,11 +1924,21 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  {
>  	int depth;
>  
> +	/*
> +	 * packet_parse_headers() runs only on the transmit path
> +	 * (packet_sendmsg_spkt(), tpacket_fill_skb(), packet_snd()), where
> +	 * skb->data is the start of the L2 header for every packet-socket
> +	 * type: SOCK_RAW and SOCK_PACKET carry a user-supplied header and
> +	 * SOCK_DGRAM has one built by dev_hard_header(). Anchor the MAC
> +	 * header for all of them so a frame does not reach ndo_start_xmit()
> +	 * with the MAC header unset, where a driver reading eth_hdr(skb) on
> +	 * TX would dereference an out-of-bounds offset (skb->head + (u16)~0).
> +	 */

This is too verbose. Better captured in the commit message.

> +	skb_reset_mac_header(skb);
> +
>  	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
> -	    sock->type == SOCK_RAW) {
> -		skb_reset_mac_header(skb);
> +	    sock->type == SOCK_RAW)
>  		skb->protocol = dev_parse_header_protocol(skb);
> -	}
>  
>  	/* Move network header to the right position for VLAN tagged packets */
>  	if (likely(skb->dev->type == ARPHRD_ETHER) &&
> -- 
> 2.43.0
> 


