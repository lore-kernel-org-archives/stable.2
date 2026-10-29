Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793318385;
	b=dB9fp2c9b8+Hwcqe0UqR8Mtd8rlRAxU7ArWMoXRHdheyec2ERVXFHbgfUqwbbZDGRb8W
	 S38394T53CNrgba1vEeEcTqCrn4gbXLyIUuE1SmFo5dURVnFxYweozR1FcI4Nw8UwOD1g
	 madQRl6jJL3lROCGmUYKBCsamJfwPwsuYpHcR2vB5ky1+EiKAgH55R4eJA6NIEODLI/cU
	 zYHGAlN/44U3ju0P+bqz1vmOBnOl5161AQpTKUESem137xHpLMInN+mwb+779412vUO78
	 ciuRx60bl1WtT/nlgkKetmEaoAtqTdji8fFY32mATBhT+sjD1jFlSk8b3otH/Tw7noA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318385;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tFic7+OA7yuwo4OpmGmF7T3kX5OjgTEpe3NWwdEUm40=;
	b=u0uBCxZn6wWq8XPaBHm6c+BtMapiEalYHsKXntUmUTj/u5Kphld+OlgBpMLq1c15B76q
	 bURm3NF+hRxGgmHD3UlXWAsF+dit3KF68PT9BnWPepuMuTjCSK+slBYc5cy5mK70gdzvl
	 tqmh+Ez7eG4alBYU15uhsh8hjxON4rz0TtZqptRlSGiPejcChAA6gqFTTeXFF5CpEIEkr
	 O+mtuVSJWMgf3j4/ujNGWN7OqPV2AJA+oIVDctioBEUV04dlKi7QlFRR3eoybx5POYfDk
	 ae5ocpx8oXbTW5LOtmqHNNO+bKbw2i18+CVKJk7s5LGrYwSygRh2VjhFQnpR5pQ2Aig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJzJHzjA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AB0606A31C;
	Thu, 29 Oct 2026 23:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJzJHzjA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A49C1F000C1;
	Thu, 29 Oct 2026 23:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318384;
	bh=tFic7+OA7yuwo4OpmGmF7T3kX5OjgTEpe3NWwdEUm40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nJzJHzjAuk/RG0xk+On6GTS7jqkBbr5JT4t6aHdkKp+iujdCTfutV+/jilz2wwFlS
	 RNzruAggUnJaiG7StNzk1HIDnwRwOWNqgXLcvEpk6poF3yKFyoigvSED2kd7heLAsB
	 4Z1dLgZuCJQK892ubzWHZqdMjB+vZv2Z/hfxaIR/bDu9ZR7uaKauUfFM7zI4RS3pW9
	 a4SD+VIShOjgg3arnWdEETvG1fZJloUEGaqf/MeTHVjdThQNRcvdNN3Ex6ubWG62aY
	 kvt6w0f0FI5T1WP1n3iqlspeNkbaGMfKhfqnDEnNh0cWNu+//293X836C2wlIzvxyk
	 T407X7zoPCpzA==
Date: Thu, 29 Oct 2026 16:59:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shaos <shawnq1@163.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>, Victor Nogueira
 <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>, Vega
 <vega@nebusec.ai>
Subject: Re: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace
 boundaries
Message-ID: <20261029165943.41fc74c0@kernel.org>
In-Reply-To: <SER-NSBD.v1.r0.20261029191634@mojatatu.com>
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 19:27:36 -0400 Jamal Hadi Salim wrote:
> Subject: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace boundaries

Please fix your setup, Jamal, all your recent postings have patches
posted in reply to the previous patch:

Patch 2 is in-reply-to patch 1, patch 3 replying to patch 2.
They should all be in-reply-to the cover letter.
