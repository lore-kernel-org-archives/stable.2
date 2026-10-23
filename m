Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760493;
	b=crKML4vSYWb7hapCv8oYLFW4ySY13+BUVFtjLC8ZCm1jhBWYqQRytOLBia7iY9v9WT2S
	 6h8knHmheX25MnpiRumK1hshyBNjrWY+7AKrj2anBvDEYs1T59fLRS+ljSTUwvEW2L0fS
	 ZhV3Jwa22JeiO1bGv0EkMjfCnV5wLyhgScX1l7HctX72r36PhN/lwKHnQw+WPXu/jhfDP
	 2kaMpftGsl706r/YxVh1WMJIwqSLkRlAFgfFcLcOkkDu2J/dbhlFC3eZhCRMU6EgXv7vY
	 M4VpgpHcbFEzockqBVaDs9D32rw9ytb4CTPQX2F/x1O4p/RoArnnb4kL57I0/rUrNog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760493;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zW/Tu6G2P143M5yOiwqhQlrPzgSe2ppBT7C/fkz52fE=;
	b=fbV5D6l0ed40XDyE6HP940TOmT4VJdqA3H5PmNfCpoRT/Ha8XtEGK4WU0lqUqI13M8r8
	 3fHsY0JId0X51DRu2HTkk8Qfam2Imy6E+PDeoa2JZXY4U7cUDjwIKuXEcxtt2Wy8DHSMq
	 yeNw6oTeDIgEkzzlTQny4CVZSx373819Liyex2e4s4E0nxiE4poAiyUfRcecvqVqvRFEH
	 +nUASOmm6CZ+zyeEXMbcSvd/1RAJyHvwFlcWjSmVmOw7ETygJe3aUbPdfzOhjJsNS5otY
	 a5Yl/RqRzYkA4vb33P1oVNjX0qGIq3mhnwIHEygIwO7WC4iZfG8DQWqKw3u/VD+XoSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgpaWphN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7561606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgpaWphN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56291F031EA
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760492;
	bh=zW/Tu6G2P143M5yOiwqhQlrPzgSe2ppBT7C/fkz52fE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mgpaWphN+KbA2Dbt2SqY6GT75J1EmnwjkTpCzBcp7sEwG0NWjKfvD1pyIbZU1WQ9M
	 bZDHG0Xq60r0XGrJpxxiGPi//3E+EZgB1xyxiaplLOsi0SOmCDixAd7I+zP8NG4e2C
	 ABKG7j6Ld3yqJ9/R2lEa8FsWGEz+Q3PTCSQgb2b2cXFpLzDpxkhTV7oeRGVTqYE62Q
	 ndx21hmdIuyzr4xrp+SvEnIU/dW41cybPbvCy0WFrcvXU2CzRoIzBUpojD36mHWgSQ
	 JwFzVcqwr8KJ4RaKxPTZiurXt5cqybWj7B2cdRDmXZE8W6VCeJsjtYz+M1qYmAa86p
	 yFI8N6posa1TQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f432ac553fso790485a34.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:01:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwVb4mJnuXIjrEX4wWryBRoiz/pPkGrqged6jqX4izF1daVq08qfHTBmf/kk2HB7dltu71iM4c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrM9qxX1xj7LcYQnLYA6N2OioGBl97cFFQnsetlRisUG1UX4qK
	PhEa9jCFLwqM0OpzxoG8WlcHUQHZfr9M2f6FloSixAxsEO7KOmR+JS2HRmyPuq+OJUUkOuCkyf5
	xAPKwr+yXCcxhsmrK9ND+rTbQMiBuJUc=
X-Received: by 2002:a05:6808:c3f3:b0:503:8f9d:f11a with SMTP id
 5614622812f47-55be83732famr1312266b6e.29.1792760492126; Fri, 23 Oct 2026
 06:01:32 -0700 (PDT)
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
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 15:01:19 +0200
X-Gmail-Original-Message-ID: <CAL4WiipmpDUeT3au2yPQFi=is1tiMZRTd8SuD+14n_09gFfGEQ@mail.gmail.com>
X-Gm-Features: AclHuK_emv7YwmEpyMuOD169Cb1tzAQTRU7DNCg5vkj8MB2QytjcxoGYSV4Q--U
Message-ID: <CAL4WiipmpDUeT3au2yPQFi=is1tiMZRTd8SuD+14n_09gFfGEQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	John Hurley <john.hurley@netronome.com>, Willem de Bruijn <willemb@google.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 23 oct. 2026 =C3=A0 13:59, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> The issue:
> act_mpls POP can leave the inner Ethernet header in a page fragment after
> skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chained afte=
r
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
>   (chained), or on an L3 device where mac_len =3D=3D 0.
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-linear
>   eth / mpls / inner-eth frame.
> - The inner header is in page frags; a following eth_type_trans() can BUG
>   in __skb_pull().
>

Reviewed-by: Eric Dumazet<edumazet@kernel.org>
