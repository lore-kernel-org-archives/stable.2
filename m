Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539523;
	b=xWm2coBQgRGEasIyery4CmCbsBYiowjbAgofrmneL1AyIY/EJwCiMdujuvtmTgz2qPyx
	 HXW4Qj8HhvPKr8k4Whjqu/xoJyxl6KMj57vhjSQQuXEB5JBNJGH9tdYwNJsnyUh5wPGmB
	 ox8X5qJBmLIFldX86q/c50FrLGGToR3KvqVowfZ2DMDV82nBn6njb7VsZh0Scn3nESzRn
	 h2Ag0W0hWJB5MJ0VOQw0KT/LGaMCFoQK2wWttKcfkGPv5ct5GTY3mlLbjR7rCvTfDm7KX
	 +/BxLVZhACFOqO/IeqTjsfFda1FxxalSiAmVHy0gaiibda7Qfa4OAkE5IJm2djaCksg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539523;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eHsnBaxBmQGoIJUeUlzJuErhbcGl+7GiPF8z+JaeIMA=;
	b=suq8lL/vQEyyRYHdl/lXXwHeZSaMsuu1TgEsaGX5yfCTiJF45SioNcEQXWtRK4SIT3Qn
	 gTSmK1tNrKGYm8eBUssqPxNaPB4kAhv5BUFcnlsZwEuY2n2ZaBAfO5opfg0QodsyRfNwS
	 rNKtl85Cdwlg6nknFqSIdjXpI57MIuMoDxLMDQR8vpPNm29vh+f3TpQfh3n2ssvr3k2zZ
	 5XG2VQ9GdZ/tcrF+wXEHg34VUI4cn3SFFAZYfIAz0towMX1NKcvPRXIj0njiNeXhTdJG7
	 gFev0UOSXyZD5lhBoF8OhBNk/TUFnYpuqIb5rmv85vHhtf+tmPuire1MvTdcKRsCOJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGJ8WllI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06008606A321;
	Tue, 24 Nov 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGJ8WllI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00FE1F000C6;
	Tue, 24 Nov 2026 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539522;
	bh=eHsnBaxBmQGoIJUeUlzJuErhbcGl+7GiPF8z+JaeIMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lGJ8WllI9Qt0HkomMWvWGBn5x1rznruEwe+F4WjZtAa78f6bSfHS91IbwQS1VNlJK
	 CSE18bMi0avham49OZAnsLODB9kxzDyVybNtCU+hCBzqJDdetteBVNxbR8B7hvC5Os
	 f8lqtZdvzTgeKlal+6ek9l+2DEJ8g+VsMiQsJ1TdoMgoSvJzGR82WuVMP83MLLwuNw
	 zNbu2JwdNpzvxpPgfmxKudvSReBFRZpQF60ONlh9wnUoN56CyLjy/voVm16AfYkfq6
	 FX1Jxh6do6bGVvwZFLJc6+ukcNvYT18VuPf0u10uRXPV6HALJ3TsPI5pMUWbrnReke
	 xEvlULGHup+PA==
Message-ID: <f1d92526-8468-4ad4-a9c0-13fc7dc641e0@kernel.org>
Date: Tue, 24 Nov 2026 17:58:33 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 00/10] mptcp: misc fixes for v7.4-rc5
Content-Language: fr
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Christoph Paasch <cpaasch@openai.com>,
 Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
 Davide Caratti <dcaratti@redhat.com>, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Hyunwoo Kim <imv4bel@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>, Martin KaFai Lau <kafai@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 23/11/2026 14:24, Matthieu Baerts (NGI0) wrote:
> Here are some unrelated fixes:
> 
> - Patches 1-2: drain the queues of a TCP or MPTCP socket when listen()
>   fails, not to leak sockets and their netns. Fixes for v4.4 and v5.11.
> 
> - Patch 3: clear inet_opt in the child of an IPv6 listener, to avoid a
>   double free with SELinux and NetLabel. A fix for v5.6.
> 
> - Patch 4: fix UaF in corner cases from delegated actions. A fix for
>   v5.12.
> 
> - Patches 5-6: do not leak an orphan moved to the CLOSE state outside
>   the worker. Fixes for v6.15, and for another fix introduced in v6.6
>   and targeting v5.11.
> 
> - Patches 7-8: do not let PM listeners pin their netns, leaked
>   otherwise. A fix for v5.12.
> 
> - Patch 9: initialize drop_req, not to leak sockets with SO_REUSEPORT
>   migration. A fix for v5.14.
> 
> - Patch 10: do not pass a BPF request sock to an MPTCP listener, to
>   avoid a slab-out-of-bounds write. A fix for v6.9.

TL;DR regarding Clashiko's reviews: no new versions needed I think.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

