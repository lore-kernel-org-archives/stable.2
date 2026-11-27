Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779006;
	b=UErfhLdLvCG3/yMqtcnXK1Rw2/9CiK3CDea5Yt6WK7rpUuVrRlWZNtv13CxGx/9kli3p
	 Zvpn/lp1VPIffYgVCrdmVg8Vh2tuxfLmAVigmDWI8fTSsAdDpT+/kI/+B9KekiuPGv9I0
	 gk8HQExO2CsleprsfS9N6HuULUnY4xuGl6nxPu+aV69TdMbDjaA8lRyBY7DFEzKV2VhrR
	 gGFzPESRwAwfUcNK2fHF2eoDXaWoe5mhj0JM2+PxSUnZXdyqXAYYicBJMX3BgCKd3+pMT
	 9CaijMsUgomx1OVM0PSaj0etkR/PjKBP2GoWdAvkUSHLwI5Ay8HG6DyauHsyuHZWDuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nbgWPHQTVuFS8/6i+ItoRkewUCSl8LV049apExp5FoM=;
	b=suGA8hc5y2+S8281t4vjKeeg9O19NH5p8m55wyxdBIlemyaIfg1rrVpGfID5Z/FdHSbM
	 Cj8hkAhSQziiObIT9FXsfFy/hWBfw6jIIs1VpOogSSw83s0DkPqK77x/jhF7z8ZmnOW62
	 3vjaVPycG+j/9YZ5HtgOgZyA0ydmi8Y7/QyU5ZpoASCipvoTyC73K7qSia4+IxHwmNHOn
	 2bnPRo0ISncwNaoNKlfHpkmC7aqOvZuQWm2cZJoKcmtgrC6yjbb/tbXxQmoxpwEq06Ouv
	 pXzCIDn6QcTE5LZK+YslI1a+7UlTQL5m71Ss2zHXgCg3kQoyOdA9+CBsAts3ZSVL1cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhEQAcgg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AD606A31E;
	Fri, 27 Nov 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhEQAcgg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63771F00897;
	Fri, 27 Nov 2026 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795779005;
	bh=nbgWPHQTVuFS8/6i+ItoRkewUCSl8LV049apExp5FoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HhEQAcgg2Z9lMvcfiIwCn5E4d0wFcKuKXvAnRya1YNtCqYCM5LXSXwwfmqH4FsuDa
	 EIjYNe+6RLsmH1wkg2NYO821fd7KanWku1egVaqvCPxl88sNqcQoRwuapzTsN54wq5
	 ZkPNQTArKcGFn1TnbOy7L9NUqe65lkFtzvksYNIi+H6GKQ2dToGMPDSAfsmqhxZX8e
	 PSvh3IpP/S40XajXRQX9gZ8TI09hK9wdX0BtVWGyMNSBZbHRk9z8cW5BKUqsvsuUnS
	 XFy+YLjnfSuVhbkf/iUVFI/iKtyUQb0R9WxuWDquAVch1/ej3VlFi2CkW0s/t0gxHg
	 ED40RyarXRrLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE91238003E1;
	Fri, 27 Nov 2026 11:30:05 +0000 (UTC)
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
Subject: Re: [PATCH net 1/2] bridge: mcast: Fix source list rollback on
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179577900450.928635.7709962221576961078.git-patchwork-notify@kernel.org>
Date: Fri, 27 Nov 2026 11:30:04 +0000
References: <20261122072504.2623702-1-idosch@nvidia.com>
In-Reply-To: <20261122072504.2623702-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, willemb@google.com, horms@kernel.org,
 razor@blackwall.org, dsahern@kernel.org, shuah@kernel.org,
 bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kyuwoncho18@gmail.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 22 Nov 2026 09:25:03 +0200 you wrote:
> When the bridge fails to add or replace an MDB entry with a source list,
> br_mdb_add_group_srcs() rolls back the operation by looking up and
> deleting the source entries of all the sources that were already
> processed. This is wrong for two reasons.
> 
> First, with NLM_F_REPLACE, a source can appear more than once in the
> source list. Its source entry is deleted when rolling back one
> occurrence and the lookup fails for the other, triggering a
> WARN_ON_ONCE() [1].
> 
> [...]

Here is the summary with links:
  - [net,1/2] bridge: mcast: Fix source list rollback on failure
    https://git.kernel.org/netdev/net/c/da4a53461d46
  - [net,2/2] selftests: bridge_mdb: Test failed source list replace
    https://git.kernel.org/netdev/net/c/28a371228d4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


