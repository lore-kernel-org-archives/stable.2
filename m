Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029989;
	b=cx4wAevbOa37+WhgVZzGJYsFSbZOFkTQE+PeMiXXVyMpbnNhSUOM65GbOG0judn9uoUJ
	 TU+ed7Sl3GFxsIYdvbstgbc5oCQUpfEn1h7VThnd6L2x6ByqrKH5LPhBUfP6TDZGxZHub
	 ZRoWCNjn8f4kIPElJv27j/u1TeUiBMpktWh+jEYftwLehiKBXrqHYr+8GBXu4FQfWFfCH
	 58USJ9XyAu+UzY1etC6d0J9opC2vtpZnrUQI7SzwSjbVw+ifEkDY4H3lCxQFoVvjK7NUU
	 8aiqo4yAKs8oRZ0z10yrcTisPt+pwVex3WEqiDaNm9gisMIyf0EbMJzrFaiugzRXq9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029989;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bBoElw9ysLsJQUI5C4w63KN4DXiE3vbiLtAf+efL9h4=;
	b=Xm1iCRnf7dUhCgOe8L2TET3Je+oBW1r/proUatk5EmYW6C3b70/BMWsrKiAeaBoed/Gw
	 q6ye8pCrH7e9Wh5+EZBykXuU9m162oZdOwttxTwQS57o7Ok/+NmniADnEQvW8V4zLP5EC
	 BmS0TtxA4BfX9Dak3d6KBoaR+bPTA2IMW76OraJw1FWzp5GMzsptrmQrr9M+eDzoc+YB6
	 u2Bxxm45DwjPasb0INzbrUiP2vFqFi7LzUG+5940INFNIxB54UZwnkCbRhrRb+4yAHz/W
	 6eWiaSRVAIgwTC+PKhv8Axi23hm/wFeJ2JTw9itKhrmQGNV0JPx53EWPxwEX1EU63Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTdinQVJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075D606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTdinQVJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3861F031E1
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029988;
	bh=bBoElw9ysLsJQUI5C4w63KN4DXiE3vbiLtAf+efL9h4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jTdinQVJ6Y/zy7EOvUPX92o7sAFic0UzNWh5zy2glqPkYzkVh3Mc/rzKkgivWTJgz
	 n2kioSaFNnRWT1912/50vIAmCwUtoQlQf8ZW7nnaWs3b1BnV4S+at/FQaGbnRKR3Tg
	 0I97p72cKWGIgupJzxJzrcrvzYzdxTa8SplXNF+jQR8Ca4SOiElW3Dew83xM0EnGwJ
	 4sRUwGEORnH0t84ne6SnJ/cMuPa8PcWRXY3L0Gvg0muwGaiPwCv/hlMKghav9l2vM3
	 72rkolUxi97UkeuZ0krOpd7fVW6HsRv93YPqfpEVWvvCmZgskCfCW/x0r2288lTpbp
	 i+J05wTD6AoaA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-53a448f86e0so1491424b6e.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:53:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBym3iyPXv/bVrig7/9iu4FEbdN+bjp27N+hBEFDJTLqpgLgSIHIGR/JvRgEWMUAYRuXKlpEgmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoLJm/W7Oio0iC3ycgyK+RKyHlmS0hstD36sOtRmwqBF7y/8a5
	Q11s6fbDCngY+Pmy+2katD/dVNOjue78tHJbwCRe9zRX7eY2evqdKNWDfXE1l2g21NnQErDqAEp
	fv4e6T26VWeut/n8aupiARXmV3o4NTC0=
X-Received: by 2002:a05:6808:6f97:b0:53c:af69:84dd with SMTP id
 5614622812f47-55c0023cd9bmr4694423b6e.12.1793029987656; Mon, 26 Oct 2026
 08:53:07 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026153113.3275494-1-antonio@mandelbit.com>
In-Reply-To: <20261026153113.3275494-1-antonio@mandelbit.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 16:52:56 +0100
X-Gmail-Original-Message-ID: <CAL4WiioW-1AcvoL6OxOJK3RiKCUumhprte=hBeLRT6gY4QhENQ@mail.gmail.com>
X-Gm-Features: AclHuK-WozjKfrhLn3dLLvjqv4oI1SvuaLyn7JbhC-t-dDZ906WiZQoSv-YDBKA
Message-ID: <CAL4WiioW-1AcvoL6OxOJK3RiKCUumhprte=hBeLRT6gY4QhENQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix packet reordering on requeue
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 16:31, Antonio Quartulli
<antonio@mandelbit.com> a =C3=A9crit :
>
> dev_requeue_skb() appends requeued skbs to the tail of q->gso_skb, while
> dequeue_skb() takes them back one at a time from the head. If the driver
> returns NETDEV_TX_BUSY again for the first of them, it moves behind the
> skbs still parked there and is sent after them.
>
> This showed up as heavy TCP reordering while benchmarking over veth,
> which returns NETDEV_TX_BUSY whenever its ring is full since
> commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to =
reduce TX drops").
>
> Requeue the skbs at the head of gso_skb, keeping their order. With 4 TCP
> streams over a veth pair with a pfifo qdisc, this removes about 1.3M
> out-of-order segments and 15-37k retransmits per 15 seconds, and raises
> throughput from about 40 to 76 Gbit/s.
>
> Fixes: a53851e2c321 ("net: sched: explicit locking in gso_cpu fallback")
> Fixes: 9540d977618c ("net: sched: fix skb leak in dev_requeue_skb()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
> Notes:
>
> - Setup: 8-vCPU VM, veth pair; sender with a pfifo qdisc and TSO off,
>   receiver with GRO and threaded NAPI; iperf3, 15 s runs.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
