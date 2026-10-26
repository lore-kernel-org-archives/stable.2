Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793007761;
	b=x1Q4bEFL9EN8nPd5RLfU5DaA5gjFtRGDRTTg3jNPBULctM6I7FmRy9Azt5rlNso0cBJn
	 Ww4uE4LnoHjl6xTu+rngdVwVYGJNWbbSeerPSEP1UVW9QfcxggOFZKt0qLh46NjN+rvg+
	 8s0OMwHlf3mExHWxwnlsgkJubupd5J5uge92jMRJXoo/L8M6pY9n7Y0BeMz8VzD19GUZd
	 TAWWsTaQegdkIhinZoewIf2DhXZkjXU0nkS9LOEB6z6CThTj6Fgsxj08po+D5wVGEesMi
	 EUTSkkLEViZf7FTw9h5lI0Ply40yMlAV+9/r4EHhM5AMC7h8abcq1EGHWk2UAZepp+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1VRakO/y2V/imlB//nrtX81eqpBhTcCSTPsMSK301oM=;
	b=JY504XZXODXKn2KgQbfF95iBs1GY71OnVLG1nr/gtSMa2GRyeiX2lysKLxWav8vwZkCs
	 jll7rx+9IdxZMz5aQEQLOYjd55FjKfnAiOya8sJ5nsKaNZsbtswk/5Q8MRTAU5A1lV5oi
	 /Ht5b6OhsWFj6+D4omkyGIKKNzi4GPn9YG7OlWM8id3nsT5la0gS003zYza5KmxvTh0ew
	 c5XvAstehSHDxb8DQPTlhwstPJk7mGm5Z31Io/4/akNOYr50yt1x7JT82aikGGFTOx+45
	 wsi6OZamZaD2qNx7Eyx9oxweFKoq7mVypZbnysZiHB+xR8lA+osvXngOI1f/cOEfsyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=gar2JInB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C59606A338
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C59606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=gar2JInB
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso894581b3a.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007760; cv=none;
        d=google.com; s=arc-20260327;
        b=ExS64jae4b/eNop4R7lmdvcznoca1zLHrA8Iwky0+PdTNM2K5RwZDagRqj5lHrrM+3
         Al7qdO3hyuojQ9eWBbZDUwe6UmXrbpqlpkgPjE2xzI1GlOVX54WYnIV2zNtqQwDFNrx+
         fH3+fBHz2e8jYu+ENJNw76lh7yd4liNV2/iKOwxPQlamMSVL9ddX/d50bGHXxfqAbsXf
         vBRej0UipHcIFGR6zShgxz4uPyg2GGitw8nYbJZ0blmO5Q7fR3zNc+jX/+wvex7iZN1M
         1Bqt7Z9M5yU1YFfdoAnLaEWm5BdLfTFs9qxFBmfIPj6mldbKifexOlupTgAaTMUB0G4f
         CIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1VRakO/y2V/imlB//nrtX81eqpBhTcCSTPsMSK301oM=;
        fh=KS7bjCfXb59xoAKqBzn+1Vd1/aX5v+IVJpIdzlwrphM=;
        b=ZRiue/GUZTR1OqhWTWEj5qwl/eQ6PpMqvh90FuHpE0LkS7/HeDsGxs9CBL1P4TOXV2
         G0QhN5rZG8HlfeqE0L0CZoAv4M0lIGMIQES7BHaQ4UrAG8mbw9azqW1vjppwExMeIYxp
         g+Ebh6NzQxuUU7m4ebBIOFvaeMjXK1UtXcduBkkOvEgQQM2243liMp0TS/WLwntRmS8l
         dUxITh0SWR4B/PhHKeD0M06a1+/O2+It9MZVhJRg5drgFmVQVzYl7mINRytyP6Ga/U+R
         cYMhjLacvHz3AZbvzS97i5ICHPtn55AVs28uZUHp0bYSSQFUc0YgHPoqx5ri8lJi1WMa
         HJyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793007760; x=1793612560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1VRakO/y2V/imlB//nrtX81eqpBhTcCSTPsMSK301oM=;
        b=gar2JInB+M76BqbODcIOXxlJnq3tSDd19K2qpCcyaviUtM2G5S07P3d52nqVQaf1xG
         pOh0H7fE0/HPV312lVpfF7fAhzhasaRvifGghH9BDzayU1caz1kixISBjjDoxurZu8nc
         39j3MAAK+kmb4M3e5mdaPteD54+iZ3S9yPrXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007760; x=1793612560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1VRakO/y2V/imlB//nrtX81eqpBhTcCSTPsMSK301oM=;
        b=yJKJjIahqcaBcYmfzIayASxywUl7TlsSXXOmF0dm/Ugs9RKf3Zb5g/OMLa8EZkcxif
         P4ptM947NIpaCD5DcWWEJUrLOI0rUVKrMcyE4JWGLRBWSao6P8STlREOXnHFyx9Cq33/
         8ywmoMim3kh6/UaW4lbHAQWZaCjo3T81z7WIYWK/p+Hw5RFAfYCDscZIcxGN+UOtFYDd
         JQ/f9PcienrbTGhiAgsPjlQHXt6WqS/+eqoMidySEu6vwTBpvZgxfmcMXyCsu2vXFK+S
         MF3aDT0u8JeGAJQaZ+aN4hJmw43Rhe8iHelMfuPXy7gy7legvb8WRBeSMPITLakUMly3
         oaOg==
X-Forwarded-Encrypted: i=1; AKwUvBzYUaVOZNZ+42cfN0nqKB2bIm8SOiMCDYvVUwNJCR5hPoZJ8kSe+P1FQZbT5i3SGYcr3/QEJSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKihzKZnoHz1cZwSWlm3R6wwBOyS9oXhBR5jlRPzwD9a3ti/YVH
	z2panoRFMAflaA1B6t2+pXsOyq3MgFIbbTLoaSrvt2vXfIiBbPgs95aVmrhdc6JCLOB+IpFYGos
	5mxp/XhPOeemjDR2JiRk0G1vsCo94xK5Qk9+LR+kU
X-Gm-Gg: AYBFou3i4BoZxr2h3wdlO8z28v1PurtF96PNcLkl/nmWudjyFmyqg1155ApHo3Zpzdd
	76XJZ+3wogIqRHQ1CWDhZKKev5MsgIxgP5Y/Nr1942uFux/aER82T2qqC8trFaDzmjgnvOnSFab
	kJO61vaPhmFtQ8oB8n4EEEApmKfiZCjs74wlBZ6sMQb8B4uxr/14fRL0NVdNmPrZTq65A4IfcEx
	zZLNaTOOqIDCoYt51o0ifdAtnDQ8NwXJp3EzA0SjQ8QSgoSTd37C196z3MzrKIQmisYWjkBZ6XR
	xYRe97M2XJLU3+0YwuhbXYoafUf6JHgpt/H0BicBcBnd/CbL1Md11my/p4RLVpiCN1oYrc36c4Q
	CSh013roGm0cnk+TX+362AA6cQq4sNwUCHhsaSgLmOfiWjOQSmgCKhB6HvIgfAmruk89/NoWNYa
	vetqjwpGQ6tk+kKFE=
X-Received: by 2002:a05:6a00:2448:b0:8a0:7677:c8c9 with SMTP id
 d2e1a72fcca58-8a367a2f8efmr5287454b3a.51.1793007760427; Mon, 26 Oct 2026
 02:42:40 -0700 (PDT)
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
 <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 05:42:29 -0400
X-Gm-Features: AclHuK9Kbj8dxBWyUQ9ZZzVwC1rYp76rQKzNYxfRgPM9tqs42Y9bAdm-hXSXTdw
Message-ID: <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> The issue:
> When the configured inner protocol is ETH_P_TEB, act_mpls POP can leave
> the inner Ethernet header in a page fragment after skb_mpls_pop(), either
> on an L3 device (mac_len =3D=3D 0) or chained after act_vlan POP_ETH.  A
> following eth_type_trans() can then BUG in __skb_pull().
>
> The Fix:
> After the pop, pull the inner Ethernet header into the linear area only
> when p->tcfm_proto is ETH_P_TEB; drop the packet only when that pull
> fails.  Other inner protocols (IP, MPLS, ...) have no inner Ethernet
> header and must not be required to carry one.  The pull is a no-op when
> the header is already linear.
>
> Conditions to recreate the bug:
> - egress tc filter on lo: action vlan pop_eth action mpls pop protocol te=
b
>   (chained), or on an L3 device where mac_len =3D=3D 0.
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-linear
>   eth / mpls / inner-eth frame.
> - The inner header is in page frags; a following eth_type_trans() can BUG
>   in __skb_pull().
>
> Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.=
1782548651.git.bronzed_45_vested@icloud.com/
> Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrG=
KrbB9wZknpqf1-w@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1ddb3bd2ae@=
gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>

For the series

pw-bot: cr

Eric, you are reading this? See the discussion with Willem.

cheers,
jamal


> ---
> v2 -> v3:
>   - drop the pre-pop mac_len gate.  The pull is a no-op when the header
>     is already linear, so the gate only avoided a cheap call (Willem de
>     Bruijn).
>   - restrict the pull to ETH_P_TEB.  act_mpls POP can target IP, MPLS,
>     etc.; those inner protocols have no Ethernet header and must not be
>     required to carry one (Willem de Bruijn).
> ---
>  net/sched/act_mpls.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> index 4ea8b2e08c3a..35a6d27f76a4 100644
> --- a/net/sched/act_mpls.c
> +++ b/net/sched/act_mpls.c
> @@ -79,6 +79,9 @@
>                 if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
>                                  skb->dev && skb->dev->type =3D=3D ARPHRD=
_ETHER))
>                         goto drop;
> +               if (p->tcfm_proto =3D=3D htons(ETH_P_TEB) &&
> +                   !pskb_may_pull(skb, ETH_HLEN))
> +                       goto drop;
>                 break;
>         case TCA_MPLS_ACT_PUSH:
>                 new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_pro=
tocol(skb, true)));
> --
> 2.43.0
