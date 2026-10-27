Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093490;
	b=pvuOUmX4eYb8nxZ36OYdMa4XC/UhOA9lvKQyYJ/TpC5L8PWxwPvQFHZc2a66njgmXLD2
	 izqZcZfht9zhwKplxuV9/FCJUGw5/FPvFyGzfx6eJoD1lvjRGxwUQ8ovHBkDEVkI1ihA7
	 OfnTtX7GwEW7+9sEcCo452m3/h3VGpmjmEoub8lH/DNtk8GzzO4ii9GZxuXSIr8+st8Xj
	 9t3ZS/ix0ApGW0F34+souk7rHA9eqG8TlQmY3TjKp2DjvdZ9Ju3z+J70hVzqrGGvALqkl
	 1+GBdhM51gdGp/v/Q9uTqkZebDtIf9MF7wRsJKu4ILh+Gt0c7v+YE9rPzBovmZuf5SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093490;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kvtdwU0KO2BtXBt6y/IVBzHQ0xmBFBGF6XhQxh8VEFk=;
	b=dUDz+0rcqyKIi3eAM9bjp01WfUEyNH2wE2xdoxnC1IHs6qXw6l3JKPB1t1MP6l/IvTw2
	 IopeOckF39T177sEX2xeoAvUrUfHAUNr9V98OUqEGI5Q14gDaaenYcAoz7nx5auhvig9K
	 EhCHnzV5gDIDatcirnQi1K4wqkJOFIjR33qasJSVhrz/kAv/yIfKnnxsB+FtsYQ5FGTv+
	 SZ7VvdRGfztxxr7ynH+euvsMQiQqloO4WCyhc8Y+GHFxGmCZDL4aPr3WMxX8vXVWzJ04/
	 oef8jsXkPqIBW6Z7I0NPOMRWGIUXeWrEAHWoShexA8ohECvgDHWMXcMui+iH29aJfKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTuFsuZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E24606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTuFsuZl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097851F031E7
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093489;
	bh=kvtdwU0KO2BtXBt6y/IVBzHQ0xmBFBGF6XhQxh8VEFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VTuFsuZlVlYXSXEfBa06AjAr4dvqbmTCvoiiH7lZI1NKPWXSSahEY/KcRNGOOED6U
	 WbKHmI20D8IpJz+Xg3J+lJy9KUEV6p/hA/YW8h2nN1Em9a2R860IjhQcmpuEh8Hfqw
	 q0sp6MzIVN+9cA6od3AofVS64c2uBl1HMhY1VzV6VESYBhVKsE5QnZdPCjlxaJGVZ2
	 eJ7sHAiVBtQk1XqyQJ5c0Hpoqrlynsa37MNYiD6hfUzGALjNkhiGbxmWX+2Yy4X++w
	 z3mcvYx9Fay6HAhzzgflObM0jAOqBSe2W2/78twpBdpKk7oahxj55TwNHqG29RX0cH
	 ZDmD5snh9yzug==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3aae7df0971so26910041fa.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:31:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwtCrIDkx5nwDb1EZobVTnbT1/UtNpWttxTIbkl4F7nAy9p2VWILeZ8LdOh4zraPdCVFEc27sc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLExYRvGPYGSJz/1RQhJpRRikppjqVO+Ya/119j6nw29GRi8vvG
	flHxqf9RTsLl3sHeDfbIoNOa0ZdmdlgGuMTs9luJwCocm5QkdLFEqaIUwFQN9X4lvNTvHZGtcb+
	qa4bpqPsutrwxTY7sSkYJZMX8pgW3N7g=
X-Received: by 2002:a05:651c:1612:b0:3a9:9b74:1ba1 with SMTP id
 38308e7fff4ca-3ac6fd15170mr24859951fa.8.1793093487766; Tue, 27 Oct 2026
 02:31:27 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026153113.3275494-1-antonio@mandelbit.com> <2812b71c-cd0c-4d87-a57c-427ef40d078b@kernel.org>
In-Reply-To: <2812b71c-cd0c-4d87-a57c-427ef40d078b@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 10:31:12 +0100
X-Gmail-Original-Message-ID: <CAL4Wiipicgwk47pDVtxcuRY=QRWM4tbpf9jsBJ3YPhOo-emhXg@mail.gmail.com>
X-Gm-Features: AclHuK-I6ImiJ1FO1cFDbA969CprrieCj22Ga3zWI-G3lytVH7H4AAoLQ4_fFPM
Message-ID: <CAL4Wiipicgwk47pDVtxcuRY=QRWM4tbpf9jsBJ3YPhOo-emhXg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix packet reordering on requeue
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Antonio Quartulli <antonio@mandelbit.com>, netdev@vger.kernel.org, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>, Chris Arges <carges@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 10:28, Jesper Dangaard Brouer <hawk@kernel.org>=
 a =C3=A9crit :
>
>
>
> On 10/26/26 16:31, Antonio Quartulli wrote:
> > dev_requeue_skb() appends requeued skbs to the tail of q->gso_skb, whil=
e
> > dequeue_skb() takes them back one at a time from the head. If the drive=
r
> > returns NETDEV_TX_BUSY again for the first of them, it moves behind the
> > skbs still parked there and is sent after them.
> >
> > This showed up as heavy TCP reordering while benchmarking over veth,
> > which returns NETDEV_TX_BUSY whenever its ring is full since
> > commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring t=
o reduce TX drops").
> >
> > Requeue the skbs at the head of gso_skb, keeping their order. With 4 TC=
P
> > streams over a veth pair with a pfifo qdisc, this removes about 1.3M
> > out-of-order segments and 15-37k retransmits per 15 seconds, and raises
> > throughput from about 40 to 76 Gbit/s.
> >
> > Fixes: a53851e2c321 ("net: sched: explicit locking in gso_cpu fallback"=
)
> > Fixes: 9540d977618c ("net: sched: fix skb leak in dev_requeue_skb()")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> > ---
>
> Thanks for finding and fixing this!
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>
> > Notes:
> >
> > - Setup: 8-vCPU VM, veth pair; sender with a pfifo qdisc and TSO off,
> >    receiver with GRO and threaded NAPI; iperf3, 15 s runs.
> >
>
> For others, notice threaded NAPI an important setup parameter here.
> This makes it more likely and reliable for ptr_ring producer and
> consumer to run on different CPUs.  This situation can still occur
> without threaded NAPI, when multiple localhost userspace applications
> run producing packets into veth, as they will likely get be schedules on
> different CPUs.
>
> FYI, we also run veth with threaded NAPI in production, but used in a
> routing setup (no "localhost" apps).  We have configured veth to have
> many queues (64), and we use qdisc MQ on top to avoid serialization on
> the qdisc root-lock.  Thus, we should be less affected, as we spread
> flows more across qdisc.

And presumably you use TSO.

With TSO, chances of hitting the bug is probably quite small.
