Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703020;
	b=rVxQPQJfIuNrBLHR6F6xseAF3ZoEfFBOLFlae2LZJ5/78TQea3AICLpfIvNhoI9McOds
	 NUC78qhAhfST7RQpSLn7yDoYjIB8vGOzxGPJ9xljvFCQH31Ltcc6Z32ZgOTtHFOjNi7gr
	 nLyKU9FosbQV93z4cJX4vpwftIxDnezZ1VQQBwfEbAgFBX4aZVwiEEaLlenraiuf+qBjZ
	 AOol58TvERY84FLgyHAIJr/N2LdKwgXBvFQNlfD8EK9B3Ep9TKHn4K8IkfqACbLq8/EgS
	 4BIA+OU4rhoqEXwVIK3hFGvwgFNa2Npkv+iUNkdeISUYaCsXL94CXiIgimFDTEIOIrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703020;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vP9cXnhN/CQHkOZZzeFccngbm6E+rmE1zRkFYmLZHQU=;
	b=HV4jRh1inHGCO1pktWkRv4KaClvIlYrUg7UnBycNfMzXK2aKIKas/cOTn6dWr46c5YT8
	 bZ470bVy2RpYbGoN3ypS7+TaXyV4h/R9QRNVZ2G3d5tVSSjeogeskaQ7j+W7I5scaAOss
	 NyhLUfW4pKxkNornvDL9nrYlKxXkyMBgyqgX5tR9JmDmLpQxiyVsakuuLZYoF4etLxHIV
	 rbjmgr9GzoSLnUkRbhl82r8aXFYB+LEczy+stAIyRGg0tkccbnEZnz6/80tshIsyoI7r3
	 LbSTMCEKLr16B1/Edi347u1Qd4vQI03lSA6+rtYMmYGYM3PYd7OqOLzIr/OrWqv6J4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e44FoDIq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A5606C5F5;
	Tue,  3 Nov 2026 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e44FoDIq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5DC1F000C1;
	Tue,  3 Nov 2026 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703019;
	bh=vP9cXnhN/CQHkOZZzeFccngbm6E+rmE1zRkFYmLZHQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e44FoDIqjEN0sw2YQY7FMP9FFKKgbkmy2U1yGu0prTZDqpOh/9iCOD5CYFT8oUaww
	 8R7b/RKW1rZRLh9u0TjAYD1S9t5M6rHqsCHGwah1WwRgnYTTMUPXI3AczeAkJotV5I
	 Ql6O0S4dOZiCUDFBcxGZAdpIYgd2+thxM40cUJEJLORsxOtrgcbEpAC2TX40AjkKAY
	 UxeGnNyWAX8CcnqjVLGqBobb1OB5iZ2eoBTxxcPvMShcylHJmH+xCx/zuDbyin7Gpl
	 iO2yaJvm27vPLsjRRo7Ahz/9U43yoOAplATd57mSK7aZ4LpWKaazbDyz8YeHa0UYpZ
	 U2NiDHuzUrCUg==
Date: Tue, 3 Nov 2026 10:50:15 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v6] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
Message-ID: <20261103105015.GE865646@horms.kernel.org>
References: <QDISC-MD1X.v6.r0.20261029162633-1@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-MD1X.v6.r0.20261029162633-1@mojatatu.com>

Hi Jamal,

I think this one looks good to be merged.

NIPA-Sashiko did of course have something to say [1].
I don't think it should block progress.
But maybe it is follow-up material.

Reviewed-by: Simon Horman <horms@kernel.org>

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v6.r0.20261029162633-1%40mojatatu.com

...
