Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771792;
	b=a5CEfn+RYhfHyPWh6MH9BMC/mK58I6xFAAAqjfVQtSoufE6ib66DIDyjlS2KjMpIR9/G
	 UyHhOkab99lZ92xPDt1xmt4PVS3gvd1KE3Y4lfZkQzm5WxplcHCkPLZh64k3iQMEYfM2V
	 4AraVDyXAnrZgrIscK5DGDiY7fhoNNmGeKlDvKEp8RE0my8Em04DKV8AkB1NYx0frNKFO
	 p25RCOmhjQNSBH3jOwlQynjw7ddF0141X7m8tnAybwoAT4Lqw3BjBEeexB6KoybbejQlM
	 3/ZuimgySnILe0tNKpyoNBa4WL1d6yFeeluDBdzO1oc5H6QpxgSR+PmYbMv5KrlPhRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CmfPnWP5B6RgKJCu/MFJ8MblMva2bc9HFmeEh//UCZk=;
	b=BNIIHfjk9djV6jtUhMs5nFcBEo1yATwDClBajc8DHZsl2Zevea68iiAjTAXqDBXMFPuQ
	 w5Lswo910ODkBZ1z3ggoZGJ2Ek7/XckC7YUOWz4iRBUk8wfzZyzMFHBsS/JsNylXWXJ07
	 5GPAXee9axEyMkfCq4lFqhc7PqLpt5c2On92ib0DXidSdY3kL+26qqcviuf5Bf+TDa1Li
	 dwPVBD5Szp+1/yBcEizZe5bmGT/zmWEi8Ga+lolG5tzV6quMyPZ7hZU7YBFumB2LIH61G
	 aOjlBh+tbpu2UIR+IlhZ8pFNlP5tvE4QcziBBKtIAlurssmRr4CNFZXnteXGBqPYYsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTZWksC+;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A2606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 266A2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTZWksC+
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eadef147ffso924823e0c.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771791; x=1793376591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CmfPnWP5B6RgKJCu/MFJ8MblMva2bc9HFmeEh//UCZk=;
        b=FTZWksC+iYfKyk8B+byZ+4M/snU7whcjv0+k7YaPonWXnGtvz0xhEqd67KSKxZQH2X
         WjYUtM0q9qXXRJOMEXJUvsJsIadlcZOhS9/0SVfBTwvXV1VSCZsUsltAm5fpEh7cvXVd
         AsZHm400dzeSglc7YLHMCHlfi/fWHfr9eP7JLdvzftlPCTkUo3QD/oZ6ih37v61qj2cC
         3oQCC3VxgbZ00ZIjGW2IQnUhPlv19uGoDMUihOlx/oZX1/yKSMwrFSCBUceksJgVQesV
         OiPXPiAqOFBkAX832we8w4zjJik6UvpFEsox79gLY1UHcVrVqr6kSnQl7n/wLqxeEH9s
         T9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771791; x=1793376591;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmfPnWP5B6RgKJCu/MFJ8MblMva2bc9HFmeEh//UCZk=;
        b=u4JWzyTHdaQOB5oEHclCB5GA6okTwVJ18NVgm2FXJOOMBJOz6Aa8YU01VNT3I2CVTv
         NsgfQouG2sA6Q29RDBQRGix8/FycQGW4Otl2pXpYL+DJAAtLs7MbVvb6NDDkW2qtU9bs
         BRzfgJiKOVpEQ6Vl1RicdN7wB8hlSg1WM+jbZKNkmK9PdyToFwnQp9SjbJg/0AY1NDJA
         lTPkEmd3RLXac7s7hn1Vt0Wj98sFgqoRnBhp0UC85w3TtbFKZPe9Tcjwr+nSXnyenKP7
         Kbj+ERGnW9GmkztycMTBabQ+BsV3GE7gKWiLCsWTmPuLqe9qTSl4c0SGU7hIN/l2sw3S
         KDyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkhbClxkdtHWnsyUxVQA580zeFbv4m0SjYm5sjtuSEXzPJG1VK16V23zOBobMgRgRLJp9tyLI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlfo8fMHGV6HGSlCiYcZbYyagX9fEQ1YPark5T9P2Vw5mRk2gc
	R4lCWySsjKWeSTQUlEGNSUPI0Ds1FcNh8SG6kBymXDJ/xg+/EujTTnbX
X-Gm-Gg: AYBFou1Edmtwe2/1zFm1sg6MLzjRgJ7xQkXliqgYWlg1TDpx3kCNE2DZQB4B3B4QEi4
	YvUL4BGISKq638+RmaE6km2UOZ4mFzCpbP30/BUmmLzv6MyICO2H5ntM22Mom7KF/ClxZ+/WV/J
	6Z+oUOnb+O24h1KZP5c/VoFNpQFH+QtepF4JYz38odBVd7FrhsqiIIlxPTAyGUQXUprnlndPtfr
	u+bEibxsRTCRFwhdBA1RsOZnLHOlKo+3mCxiQN/s4aEF4Che19HEzB6xeSzcd96GELhK6jpgnya
	vr8TvgWXYyk2clQaIco3RQFlrmKiF2NbBJaSdzSPgqydO6/niarib7omPJ1p1+Ne5QYW7rewlha
	U2DWlDh2XTTPxfQd8fEdiGMjEZgkWY0zYn6onQGPXBg50ue6BOF1SHv0LQQUjVkStjGuZQXMYql
	lDnDuI0+DPa9A834BHNERpHQWG8dDASb/+I3MJOGP9T8BzUXrPmPAY62TIJc+/yhoZMwVqWusqh
	H1/5+42/vbVUvrkRQGoLLjWJ8CiinOP2fQvZZ5+FiEpr3YlvnCdWuVTM1/6Paut7cyG86mrcMYd
	EUn3R3OcLzVmccDsaGASb5afkbryiYdivV7KKwm5ogPIutw0q53cRBiTafJYgU52axcJ0Ot/kLN
	+ckY5KeYoVOLaOGbNrhM=
X-Received: by 2002:a05:6122:4909:b0:5ea:cd69:7cda with SMTP id 71dfb90a1353d-5ec14a6ff12mr1128537e0c.7.1792771791099;
        Fri, 23 Oct 2026 09:09:51 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec1ff28c92sm592483e0c.11.2026.10.23.09.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:09:48 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:09:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Victor Nogueira <victor@mojatatu.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Martin Varghese <martin.varghese@nokia.com>, 
 Pravin B Shelar <pshelar@ovn.org>, 
 Vega <vega@nebusec.ai>, 
 John Hurley <john.hurley@netronome.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jamal Hadi Salim wrote:
> The issue:
> act_mpls POP can leave the inner Ethernet header in a page fragment after
> skb_mpls_pop(), either on an L3 device (mac_len == 0) or chained after
> act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> __skb_pull().
> 
> The Fix:
> After the pop, if the original MAC header is shorter than ETH_HLEN, pull
> the inner Ethernet header into the linear area and drop only when
> pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing when the
> skb was not MPLS, so no separate state is needed.
> 
> Conditions to recreate the bug:
> - egress tc filter on lo: action vlan pop_eth action mpls pop
>   (chained), or on an L3 device where mac_len == 0.
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
>   eth / mpls / inner-eth frame.
> - The inner header is in page frags; a following eth_type_trans() can BUG
>   in __skb_pull().
> 
> Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/act_mpls.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> index 4ea8b2e08c3a..5363bca892fb 100644
> --- a/net/sched/act_mpls.c
> +++ b/net/sched/act_mpls.c
> @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
>  		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
>  				 skb->dev && skb->dev->type == ARPHRD_ETHER))
>  			goto drop;
> +		if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLEN))
> +			goto drop;

Is this first condition needed?

More importantly, can it hide a bug?

Simply running pskb_may_pull is cheap if no pull is needed.

>  		break;
>  	case TCA_MPLS_ACT_PUSH:
>  		new_lse = tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_protocol(skb, true)));
> -- 
> 2.43.0
> 
> 


