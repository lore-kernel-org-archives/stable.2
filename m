Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792788556;
	b=GCx58dAzXqh63wNG8p8Pqk/8G0jdawcfcKJKRWMQKpuhqmC6aT31S4A6YgokhqADUgjB
	 fcGxexmxvwYn9fYSUO68FXun1fzbfvHBSIBuEJ3FQVfvw2XU6VfixdkMXa0WrgPPfTJX2
	 faL6+Yu+mefqdbg69IFWeCbfoWzazdTCJiY5aLcsAi2F95/bzmloj6v/Y824D7zrckkiU
	 ms0p/RV5tDGNkIRFZzI5QiRMgoXzPNLRx9iCQuV5YnqgSq8OVeTHrKnajqeisQnz+CsXt
	 q+eFPT8rP7LDAXzXRLXRD6NZ5bjDZGawUlvvEV/gWEI3/1fomHkqYSe/Z5Cjy/vuNMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1e8ZPE4kmMbmXtCl0yrab04f315W635erPEBqteGcDk=;
	b=dnZxb4GDhAhvfALRAanT3vj+h1h33QlqYsZz6Ct3y11P0PnkVEtPLqKc0e8WWRo1ccYV
	 +Frb6VnptmCla3AUj9ryAPsTyT9dhXHJPnHNkTH349FBTZcjyYx2lckDDFFwcOt0c9fm6
	 u0SLvXAbSrtn1wurFGyY6iPcJVHtKQsKS0gdeOTaVZ3plmVwNPh7TXJz1VBD1lu9Idqu4
	 3Gv3PxWh9IvE/R8lAxJYGF1Xm+Aarc3qdIoa89YBMdl5pEwv4IFDpFON9VGHqcUSUIZSw
	 JZQTUPKDy4PPVw8dGM15rPwxVuhyfaHIEvyVU8qcLJwaQ0IT6GVgMLu1Wfr9Ci6dDDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AEOv6u6v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F84606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F84606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AEOv6u6v
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso520934b3a.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792788555; cv=none;
        d=google.com; s=arc-20260327;
        b=f9UsTAuBc7ISVejxkpLD7cLYyVd8mlfw9WVThtKB8iPPZZcT6vhkOfY3IPrOt1SWW6
         x7zhbVNhmwSyjUCZ8avagrVA8UKZZm6qMFl/dA4w7w++3Dvbif0JC5mmO9tJKxl6kS4d
         nVn4sto1N1MmWvuNSb/IuZ3A34FNzk6up7uEVaMXytad9+sk3Tfalw182jOEXCmFf40J
         2JNPaZTbUpFLCXUG3NsXPv2OtylbV6USivuMPn5bJy7Mn5misrxIw3cVOTUR/m5zV5Y3
         4Di8TnXQuaHJJyHv/qgcd431kk9WEmIwyb21Zb4LjgSUQdqk4ZlbpRrHQH0MP/cpjoW+
         DCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1e8ZPE4kmMbmXtCl0yrab04f315W635erPEBqteGcDk=;
        fh=SKVpCMdSN1QLlXLpzUvIOR3gfgPA2G6OZ86PHRzNI7Y=;
        b=pBpD9aLzEF3EEnAILfTDIAH4eT7huOL8Xn2wruvhyxYD0pXvXO0xsBQXlGYDYtULeo
         3b0wjbbDA0i5oYTsbi1Y0TUlp/UCXcRjFBmLNh2rw1smZeS/AWDk+QwtdMDvdxCBbSnJ
         dZkvYQ/Y+Z/nTR2lutuippKMRCCd+T6+OKHSjZJ537jYY6HLqnTM/2GkDK67jpLsvFwH
         DML/U+7ZDlO7UpTYevQuXqdO+XE3kN/6sf8uVOF1vcvzkn+3X9iJIM2AsziRtTP8aR/c
         f66S9KEHtWBMD5Va5U0U9ZAYjPAeskDfr0PGnCLFteIMVWeOgt0D7ji18BkcyhXtF0Yc
         F7uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792788555; x=1793393355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1e8ZPE4kmMbmXtCl0yrab04f315W635erPEBqteGcDk=;
        b=AEOv6u6vIlh8bMLqubdAOCo2ZaWZPNBwX8q7K4RISlY1OQ+6TfhPudRb7ZZc+IEyDI
         Jl2uepJHcQXGgiZ/AEcTgVkS04Z5KXSWGM74zhXnh5lM5SpvjZCAsHZ3wjM8rVT6Nmmm
         OBYpe4OZu+KBfwxchSCixguS+yxodzVQfsm04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788555; x=1793393355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1e8ZPE4kmMbmXtCl0yrab04f315W635erPEBqteGcDk=;
        b=npUi2c1kEPJttlWYHxsesnyqbFqFKLnEJUAZmZPwYtaz7WnTxVzPX1y9BAWUVm9VN1
         5YCjOQoNilQFtsGTpfVCfPYdDwwPnRoeX7wTup09hS26HCuc+z+bxjyyOsf1Ekt2JIMy
         0KYn/ufFGAbc8WloFbyF29FnVfRFumNXM6GjsntwIRB/bYXOftUYgZJOcrM5MIkMAVqS
         x5y+1kzGP9x7NZRJ5iKkjMFOJI6WsB2pdrI46KJK+90sA3mwt4/pgv+nYvbZomdKASLf
         NJUso1Yl8R48cU6dAw7Y+K6W42rTUQNAzqmCObZUclW99sIUAEv6s3guz/oQhvz90rI7
         bkvw==
X-Forwarded-Encrypted: i=1; AKwUvBxYXZ/L95e6MdRgACfUxb6ZUTdvRmbbI5x3wniZkt6PMJhrT123DiEK+B3NqVVCmPPVxEgpctM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgwv7DtjSj1vuf5dxSQFQfQU+HuczuzT3wAad8kbEBbSpwJX9E
	r8FU1mUjupoG4LfLaaz4iX5IyKRQEoLIznrngrTFe0FO5HTdO74FwHrVpUbbhClWE1CnYvPG/qa
	sMDppaqaXrMjLezYn729nOfu+zibGgvV4aCJhmJjr
X-Gm-Gg: AYBFou0JXqQ4WtP5Q+c8gR+U/3MT/1L7gUxnu+6SVxeT6Cx0mdaFdgJHb/On6Zxq2UG
	fM8Fv1ZH0Q5QzCtgutL9caOWccyg6oOVvgADqdGwj5vXTdJ40iNc/y3RtCs1NUxyr1IA6T09cPS
	c5oQChWHqMiuRCPcR+1hcty/7Gh5/QWlOAI9Y4vX/nVNSWAHY8pruLt9ane8XhxC7gLjLTDBY7i
	38uPjxBOuedpsWRD8N9fmYFQp142W9ozYZplELHP+P0UsAE2hTR5KjfB2phY0C9dFOIt7egttR8
	0hCjKF4LgdrjfnuYFGUUlRKICjG8S4aT23mTm1uX/p8KV56ESMlSo/lc2gIyplnCKNm2DGbWt2b
	p7PWtusexUcUf6f1jFxyAW2au9XH7z73TwQAuFwoUxRK8kCUKiaLt9533Bp+YEswzaRaUTTT2L9
	ISVwu9OIQA760eoWJ8TOuYnJ3xuXllFWj/Wx0V
X-Received: by 2002:a05:6a00:f92:b0:899:55e9:880b with SMTP id
 d2e1a72fcca58-8a3661c509fmr328289b3a.14.1792788555119; Fri, 23 Oct 2026
 13:49:15 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <20261023122819.5e48ea9e@kernel.org>
In-Reply-To: <20261023122819.5e48ea9e@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 16:49:04 -0400
X-Gm-Features: AclHuK_KBBLqzVNTj_l61CA0L2zWjhSKF-P73rB5NHPry570bVn5gVtl8tS4o34
Message-ID: <CAM0EoMkaPX_He3yCExA0DG4KuQQd6JLP=6qgsXn0kzry4+P2nA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/6] net: pull short linear Ethernet headers before eth_type_trans()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Guillaume Nault <gnault@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	Ren Wei <n05ec@lzu.edu.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jason Wang <jasowangio@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org, Martin Varghese <martin.varghese@nokia.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Shmulik Ladkani <sladkani@proofpoint.com>, 
	Yotam Gigi <yotam.gi@gmail.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org, 
	Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 23 Oct 2026 07:59:15 -0400 Jamal Hadi Salim wrote:
> > This series fixes a class of producer/consumer bugs in which an outer
> > header is popped and the packet is then handed to a consumer with fewer
> > than ETH_HLEN bytes in the linear area.  eth_type_trans() pulls ETH_HLE=
N
> > from that area and can BUG in __skb_pull() when the inner Ethernet head=
er
> > is not linear.  The affected producers are act_vlan POP_ETH, act_mpls P=
OP,
> > act_ife egress decode, and the Open vSwitch MPLS/TEB and NSH pops.  A
> > consumer-side guard in act_mirred rejects redirecting a headerless pack=
et
> > to a device that expects a link-layer header.
> >
> > Patch 1 makes act_vlan POP_ETH pull the inner Ethernet header after the
> > pop and drop only when the packet is genuinely shorter than ETH_HLEN.
> > Patch 2 does the same for act_mpls, gated on the pre-pop MAC length.
> > Patch 3 adds the act_mirred guard at the redirect boundary.  Patch 4
> > keeps act_ife egress decode from consuming the inner Ethernet header an=
d
> > restores the header metadata.
> >
> > Patches 5 and 6 establish the same linear-header invariant for the OVS
> > MPLS/TEB and NSH pops before restoring MAC_PROTO_ETHERNET.
>
> NIPA CI flagged a regression that appears to be introduced by this patch
> (or one of the closely related act_vlan/act_mirred patches in the same
> series).
>
> The selftest tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh now
> fails reliably (both the "ping" and "ping6" sub-tests, on both the
> regular and debug forwarding test configs, consistently on retry as
> well):
>
>   # TEST: ping    [FAIL]
>   # TEST: ping6   [FAIL]
>
> The test builds an Ethernet-over-MPLS L2VPN using exactly the tc action
> sequence this series touches:
>
>   - ingress: mpls mac_push + vlan push_eth + mirred egress redirect
>   - ingress: vlan pop_eth + mpls pop protocol teb + mirred egress redirec=
t
>
> dmesg on the test run shows mirred failing to redirect the traffic:
>
>   tc mirred to Houston: device veth2 is down
>   tc mirred to Houston: device veth3 is down
>
> This is the same "vlan pop_eth followed by mpls pop" chain described in
> this patch's own commit message as the bug reproduction scenario, so it
> looks like the mac_len/pskb_may_pull bookkeeping added here may not be
> correctly handling the ingress case used by this test, causing otherwise
> valid packets built by this chain to be mishandled and the redirect to
> fail.
>
> Could you take a look at whether the new POP header-pull logic correctly
> handles the "vlan pop_eth -> mpls pop protocol teb -> mirred redirect"
> chain on ingress? It would also be worth double-checking this alongside
> the companion act_vlan POP_ETH and act_mirred link-layer-header patches
> from the same series, since they touch the same pipeline.

Victor monitors NIPA but is currently away for a few days. I will take
a look. Eric pointed out this broke:
tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh
I'm working on updating that and will try to fix this as well..

cheers,
jamal
