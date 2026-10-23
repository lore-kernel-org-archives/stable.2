Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760741;
	b=DosHP/K9fMJl6LGXQEYCYEOHf6oGFj7UYYTRWrdJVhUAoZkLt9FJhM+5STysAn3nNil0
	 3HM9nfjDWkni4Am66Iy7DvJwFhO3E53KxuPPW7peSHQfO3KXLlUYkjLT5POw33AT+dcdm
	 uI0FhtQlUHu6KnhGKVUfHKb18ofxNqGWJzuT6fwexfLKpyTJONH4yPtYFGYJelCH/Ur+A
	 dwX0/cfGghBCKGaDLk7Mgu1LjWrXAZV3wZMxQqE5ue8i99U29tB3ugwOFkMaCjSi/gawP
	 cc8r+4UOlJ36xjHuOFeKw9GF/M4Qb9aVvtUeCC67iA04HuvB00T9Fx8XJvHd9tDmkIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760741;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nxrlDr5Pv1kPW7dd5eO3qfJ6XICV5uYprA+uta9M6UQ=;
	b=tiytjxnJUBMF/ff9NCtGRasyTlsFLE0zIxSPo25/JXJXXyYick986JHPfq0fwbNMyGqD
	 Rz21mCyLsLseqTSW9VvnpGYG+d2n3gqSVMKWifc3G8rhUzMXSiYf+9M9JNqFSTr2xDK0C
	 ci6eYaPgvSQp/UsZiYOytFM2IeUXMiBTdtfLzWBIY04+0OKH5pSxQNMmxHLDxTGCmEOwh
	 qeNAhgCm51AoPs5/BEABN/MtC5ClLfMbQBn/NJCWNlv2oK0zbbPwHY8xLWkd/YrSbom6A
	 Pekr2ih1mBJPaK6wnm+6ms2NJwXlDqDsqEGUEgdohCnEWOAaoApfnoryZRZHa/4amNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mioTpND/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D32606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mioTpND/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B201F031E7
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760741;
	bh=nxrlDr5Pv1kPW7dd5eO3qfJ6XICV5uYprA+uta9M6UQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mioTpND//qWuVuc3ljq4iPyNLlJKcEF6BwqcTdsM3eLtWtwrXxMQIJO/sx2FS920+
	 OqHnBTFCFl4WSBEn+TiyiOKjaqUatBBwmUgw0Z4P8ojhUU9v5w84rMkzDZGqCGU7Qo
	 BqpRzt36i+az+d0FO8PwJ75O8U23jIu5l/27auuiX50iHFvM3G4dFTFqstGz1TDnCd
	 ya/r+etVeHYBX+F762XSA/1BdF4SHF61KisAt52cABXX7xWAhUzJb+egQXTizFJE0i
	 rX1ISsCNP32oAhG/kpIOSaWjqisDrx+RKKPKr1Al1D4gRhrD+Z1sT+J8c3R9VcvUTu
	 QLQcnTgX/w2eA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6f8a519e215so618546eaf.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:05:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxun/L5U9y8h4WBcIWDpdU/kdb4zSBrKfoZ/37iotOuGpHCI7NaQfAcwA1Etlv3Ldndt1wNVls=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9/58ndWeV81mFcE7RUuRo2PDs97WyHURzdvRR6m9ekzFCGCeA
	NZDOiwpjeyJiDic+xhquNwZ2Pcs/mk259Cg84Eqk6K+Co1YdnkRfnsn4Pd3Q7Zix6JEn9PYpRQW
	jvfUAaLqDN0VhpXz8PEwFz+LIqogum30=
X-Received: by 2002:a05:6820:1a09:b0:6f7:384:a094 with SMTP id
 006d021491bc7-70a8040d285mr2645443eaf.26.1792760740508; Fri, 23 Oct 2026
 06:05:40 -0700 (PDT)
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
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 15:05:29 +0200
X-Gmail-Original-Message-ID: <CAL4WiirQwq=MyAn-D4voz+cctj7sj5pbpz4f1K12yhRjp-_qew@mail.gmail.com>
X-Gm-Features: AclHuK9dKwFPAUosG0D9nbQQXD1VWaoosAHEMdMOIldlGKdqHWO2J3RhpAy5O6E
Message-ID: <CAL4WiirQwq=MyAn-D4voz+cctj7sj5pbpz4f1K12yhRjp-_qew@mail.gmail.com>
Subject: Re: [PATCH net v2 4/6] net/sched: act_ife: do not consume the inner
 header on egress
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Yotam Gigi <yotam.gi@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 23 oct. 2026 =C3=A0 13:59, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> The issue:
> tcf_ife_decode() unconditionally calls eth_type_trans(), which pulls
> ETH_HLEN.  On egress this consumes the inner Ethernet header; a following
> eth_type_trans() from loopback_xmit() then parses L3 data as Ethernet and
> can BUG in __skb_pull() when the remaining linear area is short.
>
> The Fix:
> Parse the inner Ethernet header with eth_type_trans() in both directions,
> then restore the egress data position and MAC length.  On ingress the
> existing behavior is unchanged.  On egress, push the inner Ethernet heade=
r
> back after parsing so the xmit path sees the original frame and later
> actions see a consistent network header.
>
> Decode is a receive-side operation; the egress branch keeps the frame
> intact for transmit paths such as loopback.  tcf_ife_is_eth_skb() accepts
> Ethernet and loopback devices generally.
>
> Conditions to recreate the bug:
> - egress tc filter on lo: action ife decode pipe;
> - AF_PACKET SOCK_RAW frame: outer Ethernet with ETH_P_IFE, IFE metadata,
>   inner Ethernet and an 8192-byte payload;
> - the egress pipe re-enters eth_type_trans() via loopback_xmit() after th=
e
>   action consumed the inner header.
>
> Fixes: ef6980b6becb ("introduce IFE action")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
