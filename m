Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340208;
	b=LncU2W3FKEgVqFkULd7pbVT3lwdnLI9ZI2sn//HY2hgRrND9CcOs/wN2mrM9cpAAkSox
	 aTGjNCLKx+t6DyaPex8yXVJDLlYz0LOtIVhLM7dp7uIb/tTMmDU6fbOjJOIAThYSXkT/o
	 n8IDHL5evc2C6tLijoWih7Z3wZrWgjm+e+BDwtW18ZBvuywTlVGydPNEKpz1359urbqqf
	 sTpjT9lUJphG1+vNtTmqPZURjAq2Z4/5WrEh8i5S5wG36BcaPQfz1ia+bvst7wpNpANe8
	 WwSoFApwthGMSVMtztJj2A5L38XKdbC1jwPdBjuxl06UmagunknjDIpbFPBR4bR4XNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=7Cjs6guS+OJwVbNRjRbNDwNc27/j3K8NqqNX59/1b0o=;
	b=w8YNbTcoW+ZGWCVBmWVijtiaSb4czFlJPHyyXLsFZDaLQ5zUU+xucrRz7bCtefx5omTD
	 y0IwNWy70SQ4Nl8XSMhUSHcTJHprvs1o4odzz+2uucQjBgIUvCwlEOC+xjfqEGi0R4aKa
	 cetdpqQPNpstvoBBiO8qphHqWODrhnk1hlBad+3TV1Rb6Txc61Wyx1L9qQX7qOg63UMQQ
	 1AAqiEVZE0Kh8Zuoxbgg5vFnMgNhsiLie7WsGRNaQYuxkfaCVHZoJh6pZB9q8+EWG1hr9
	 /qkYcUFgU5wU1KIwkQ3vzIVeXRb2yyF8be6s96vGPsLXHTUYU1Sjwm1n1ScDXq5NLZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4Rbu8PK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35753606A32E;
	Tue, 10 Nov 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4Rbu8PK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB201F0089F;
	Tue, 10 Nov 2026 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340207;
	bh=7Cjs6guS+OJwVbNRjRbNDwNc27/j3K8NqqNX59/1b0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S4Rbu8PKSftA6ACv7s5cNBpib+1wduJfW3hljsjGJfG2uRdstjZOudN/GnDLhHvFx
	 MZ/b4gevYcyDjvVQx8l+7kVID79359O5LCLmB1HWI3fLxZts9Pv+E4cjplbfa8g7Q4
	 RLmT1yh0Cnw12j+l8egshKVPIuQ//LAHeUVqblmdT/YrsmQagxWBkdomnwUSB7fAm6
	 wZHW9hn1dpco2SJNzN5h6xfgyNwO2XYDrWu39pNCf1oO8U63RGuZ6wzN82sPBVAGWR
	 CVxCIyhhLp7yq6X47RuPBGs6s4pN12LQOioJjcpaz2k0ILH0mn8Ij6JROGlGbv6ZUo
	 Pv69q7PXDftpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B16439D60B0;
	Tue, 10 Nov 2026 19:50:07 +0000 (UTC)
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
Subject: Re: [PATCH net v5 1/2] tls: only install push_pending_record for a TX
 context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434020617.26472.10011762273074011911.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 19:50:06 +0000
References: <20261102213011.4191020-1-rjethwani@purestorage.com>
In-Reply-To: <20261102213011.4191020-1-rjethwani@purestorage.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aviadye@mellanox.com, borisp@mellanox.com, ilyal@mellanox.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 14:30:06 -0700 you wrote:
> tls_set_sw_offload() assigns ctx->push_pending_record for both
> directions, but the hook is a TX-side dispatcher. On a socket whose TX
> side is HW offloaded, tls_set_device_offload() installs
> tls_device_push_pending_record(); any later TLS_RX setsockopt
> overwrites it with tls_sw_push_pending_record(), because
> tls_set_device_offload_rx() itself calls tls_set_sw_offload(sk, 0, NULL)
> for the software half of a successful HW RX offload, and so does the
> fallback when the RX offload is declined (NIC with TX-only offload,
> tls_dev_add() failure).
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] tls: only install push_pending_record for a TX context
    https://git.kernel.org/netdev/net/c/c47e766c5307
  - [net,v5,2/2] selftests: net: add TLS 1.2 hardware offload tests
    https://git.kernel.org/netdev/net/c/ec7b283e11e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


