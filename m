Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653818;
	b=ZcrIkA5x/JSXhC0IPl7Z4TTlUEuFqhZlCQeszz9VKW12DzoO/VThUwUJJwy0lyAxRiDM
	 S7GMatLFa2lluaQxkMKApqi8z+lFlUipmDITSaq08xLvLMnVJYZe8qubTOQhxoImYy1ox
	 bPcINA2vxJoRRt36PXb54/cFQTrKdRsryOGxwk0VUdXC2EhUoSIoKHuKMueLwmzBbi5IO
	 fiZKJ6UVw+0Cr93C3HK7FafKoHg3Pedtl5v++uVNzGP0NA7oh38QUduYlKByozGkBj2HO
	 Zo2UMIlP/je2Hq/RwEenQSJbbv04IOJ8S4EcLQ8blk6DPgurFs6scWkjSPfSXLAkqAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653818;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YoD2nxL6T5DqfJJE0YMVYxFb5TKJdSpwilsqIJT9cY4=;
	b=to1zf6hbIeFOfVdtyqm41WiPUbN0hWYGMbvtPzku0O68fQsYZQp31/rslvvF56RqyDLp
	 qwEzLsHB0aFkbHtQrPgF+34gxqFoNksSNdllgq33mys38XGQfLQp37kfAHeP8lCGn3axq
	 5yj8iM6Vp9R4yIaaEZCDfuZFOOGFh49ACR7He3KjAGqGbRvlqrKJjwMJHf4cSzN6sOgM8
	 gKXQmgDl8O9TC16IAn6XZw+VAgd4IgYF2dWe62s7f1842JjNMR1diw/3bCqiFSRPegAuB
	 55Qqr7myS86FdePesvpbZ2IKbtfVdptz+dyDbwSvME4an1qBeXUv++EFtOYD+7jQhCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnlpjEz7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F9606A326;
	Mon,  2 Nov 2026 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnlpjEz7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0CD1F00A1D;
	Mon,  2 Nov 2026 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793653817;
	bh=YoD2nxL6T5DqfJJE0YMVYxFb5TKJdSpwilsqIJT9cY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XnlpjEz76PxkfqkqfxB7OxeBoqzPZENY4gd93L/4o+XOlmHpDmw7dRTGbbfgEm8tO
	 u9oRLNSX9zX9j2svdMJDHHDIjSEJsP6hrw6uCIRPVw7KbbEUWaFMI0lcFjCPrXX9mc
	 RTcoA1KK6It74E0s8Sjg2Ct6xj4dIz5EXJuYEq6ArKMpSd5YgZJJbHxDb30n3O4+P1
	 DO6FqCpvGRCvrP6Zt4TKFW6/L4AmxFGgQpdB+BCa5I/ekbRkDsnVDmtu+Te/9QOCrl
	 wD7UKcQ5hC2wpoknxaUccHqzVVp31o+rw/RCt6wEVmUVUwc1wcH//jPbY/LHQ44bLx
	 icEISaDkJ1XLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 402F2380821F;
	Mon,  2 Nov 2026 21:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] inet: frags: limit the truesize of a reassembly
 queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179365381605.657459.4602528540338135387.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 21:10:16 +0000
References: <20261030081225.2575462-1-edumazet@kernel.org>
In-Reply-To: <20261030081225.2575462-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 stable@vger.kernel.org, kylebot@openai.com, fw@strlen.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 09:12:25 +0100 you wrote:
> The truesize of fragments in a reassembly queue is only bounded by
> the per netns ipfrag_high_thresh sysctl, which has no upper limit.
> 
> inet_frag_reasm_finish() sums the truesize of all fragments in an int.
> If this sum reaches 2^32, it wraps, and the final sk_wmem_alloc
> adjustment of the socket owning the reassembled skb can cancel its own
> reference, leading to a use-after-free of this socket.
> 
> [...]

Here is the summary with links:
  - [v2,net] inet: frags: limit the truesize of a reassembly queue
    https://git.kernel.org/netdev/net/c/3ae20e4697eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


