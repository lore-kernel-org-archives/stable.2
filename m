Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682469;
	b=spRud3vTFaulT6gHwKUUCV3oXsmrGJY/+ylaGOjlhbhj6lBxmEWkGG9U05+xV4yjZX68
	 lRca31GS4T73l527nPGUB/WekN+OwzPp6M6AVN7LQj1fFtCCnSSM+T+dIYgNQcFl54bi0
	 mcJgK4xpSPlaFZaKxiOQjOTnzSbQPKjpsxdPciQv1t38lxtNuXBpRafLkcOrl7i0axY9o
	 tRGdStjMHF9Y+UDoQjrhQ046UHzdHq6l62ZMQFebTm5GyoY42NrkiyeijhimA12w/Ah//
	 IFD1NSAta14tONRXxc07jpiarJYHEMMLVe/UOluxvMO5lCHgCNq2jMgVpjwfsdWjWxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ut1MbZFisvfUQUtEfL6SNU0FdsUnm/HnnqHBMvtQOC4=;
	b=LF6C6V9hW3jTonpu1/pOVtm1q2xdIziYXgOCDcf0JaO/bOGZSs+ghnSslv7fhD4i/FlP
	 dAF5aB0WQOMG2XVm0IvJRCaEZRZuwmeLpinQWLjc9B6M57D7DwxX9M4TPf7e9fljLc3d0
	 YJYLbcN43R+CGVwhs3s9J6/8wU6o+0u2nXVrnnvXMvMFIQ8bmmXF+9t2Rwwc+okXrxVyb
	 9TOzmVmcU15DcfB1MhP++2gnb0buB2NxxIprXtVxcQaV6S2IaKP1XrOfd3NEj6/oKZ2Iq
	 vs1ifzzr+T9y1hrV5+12zGZawYfrPLb3q6kC6RBF1XbzkKMNKV5EyuFlk2kdBsMgGPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipQMKzYb;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B850606A33E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B850606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipQMKzYb
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eab93a9862so578191e0c.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682468; x=1793287268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ut1MbZFisvfUQUtEfL6SNU0FdsUnm/HnnqHBMvtQOC4=;
        b=ipQMKzYbHgjHM/EwCO58dSFAnNpq1+KU7vhUwsLIJlpYtpCPo1xOBHe9msP1BIGMI9
         Ha4kYX2m6/onHNR9ui5yDM2wtW0Oci0uZ1QD26oVaPKKuhJQ4iCHw7smcz4oR66iMLA8
         TGM1nTjx8obQhsiY1ytvupAHCUe+UFpDGtohgnAqQmAduzceFGTQvZnjX1TaMzYrmros
         MbtjQwlkzk3js33URLlp66roXPSaIwP5upIVOcawIt2olSgIn9lEa9Tla+oDs8NL99VG
         ChwZ4iDaaW8gT/fUMkxu+tCSsgLKsn+dhFPvnPRXJuqlQGizGYgtlUk1rzOP5DUDbzn+
         MAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682468; x=1793287268;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ut1MbZFisvfUQUtEfL6SNU0FdsUnm/HnnqHBMvtQOC4=;
        b=Nk5VGA6RxGIsmz396Cx5pwkmG4qi5906gLyUn4wKQfWsRPTkAmQC3XgSLkfdOoBSW2
         ND4HNHbLpZ0/B1JYbIY5OP7iGQ6tmHg+UBQMdWBeu8VAJfh1PgWkT6RAoNpfmQ5aCN0p
         /eiI7CGucWHHSoRUuEMnMNsQyR0VeiRM5p2zYfkk36uKg6B+pGB0bH/3DVBvz9qUk83s
         rMIMgX2qCmrK3O+Q3TyiG2ROJ8QFaMmIwHih3wOWIUM04kqXoDTPXR1jr/1BTvaj7zjO
         J72rBWUndmBNaNd7Thr4POEfhJPYwZt0RL/3Jw8CxamvygMJ8a08ds5/7BLwNmdUmNZ4
         CpLQ==
X-Forwarded-Encrypted: i=1; AKwUvByEJm71/NJ5rOufHjyst4Jm0//L0vUgu40zMeW4fzmYg0m2xMqWvBaexcSSUvnfu7lj3iY9Og4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjf9NTrSeuoqtG8hnLbIzK4XmIdWT/yygFE9T4QzQ12CLOONpn
	jboYfLvtGNuue9Aw19zEe8lqeJb9wIzg5U61WbXvdxTJSYO3h/Itwe9t
X-Gm-Gg: AYBFou2y3JgvUQepZp4I7Zg4AhtF2mV60qkBPQ9YI95y1usHY4irPzpPz68C4TVtSG5
	9q5DD2afNhKge1FU6vPe1k/1Z//FD7mt67SHQxIXpKFO6/97VUm65p3H6WzKpl9t3N6Zo0YJwz4
	O/WNHKm+HsI2TUBQBkn7/RVn5M3URw9U/bmWGHLzJb5pAyUBC2drQI2qp14JXofb2CI4v7fHL0P
	xz0ffzgAqcY9onCUeKLfAEpApnXz2E4wnF0KawpDYIY9KogTOxh8bzdC7EzqwNELi9sFxIlRf1t
	VtQN7z523YvkHaPZ3ZZfqQu4BByHhm8sYUfgkPdHEWL3Wnm+N7vZVKjTHP2bpRGEkLS/EQ6HRQ4
	MKP0a38Fa/gZ9Ct+cVr0q57nCWEvKFl931BcPjFdAeN3Mn/YXgW/YD9iP6qjRWLDeIW53dxFf/p
	Wn2C/rNDoAXA/u6EcA8RuZ/OgSB6u76zAHQhX8vWpAy6MWnN71vKnz90+DcpBhjC6LgVXPmRRAE
	5ESDP0Qxu9UfdkULcfU1e3cdkg3beH4UREsAYn9k8vPy54GZmT+gk/1U+K079AWVbyd8t4/cx3V
	QjG9X3gvDMRIWMjJkfCgBW4+t5/l6il+VFZ4pjyhjTJew1yqaDr/rtUzrkOMflgq/RorJBKawRA
	QAv+JdS3mj2oDJTjgm84=
X-Received: by 2002:a05:6122:d0a:b0:5ea:a0d9:e5d6 with SMTP id 71dfb90a1353d-5eaebea1ffamr2067386e0c.17.1792682467917;
        Thu, 22 Oct 2026 08:21:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae9788c68sm7312496e0c.5.2026.10.22.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:21:06 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:21:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Guillaume Nault <gnault@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Victor Nogueira <victor@mojatatu.com>, 
 Vega <vega@nebusec.ai>, 
 Ren Wei <n05ec@lzu.edu.cn>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Jason Wang <jasowangio@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.38722ee638a21@gmail.com>
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
Subject: Re: [PATCH net 1/5] net/sched: act_vlan: reject short linear Ethernet
 headers after POP_ETH
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
> act_vlan POP_ETH can leave a linear area shorter than ETH_HLEN; a
> subsequent eth_type_trans() may then BUG in __skb_pull() when the frame
> is redirected to an Ethernet device.
> 
> The Fix:
> Drop the packet at the producer boundary when skb_headlen() is shorter
> than ETH_HLEN after skb_eth_pop().
> 
> Conditions to recreate the bug:
> - egress tc filter on lo: action vlan pop_eth.
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
>   eth / inner-eth frame.
> - The pop leaves skb_headlen(skb) < ETH_HLEN; a following
>   eth_type_trans() can BUG in __skb_pull().
> 
> Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/act_vlan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> index 6a375fdc63dd..ddf03b08bfe8 100644
> --- a/net/sched/act_vlan.c
> +++ b/net/sched/act_vlan.c
> @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
>  		err = skb_eth_pop(skb);
>  		if (err)
>  			goto drop;
> +		if (unlikely(skb_headlen(skb) < ETH_HLEN))
> +			goto drop;

Could it try to pull the header and only drop if the packet is too short?

>  		break;
>  	case TCA_VLAN_ACT_PUSH_ETH:
>  		err = skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_push_src);
> -- 
> 2.43.0
> 


