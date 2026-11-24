Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486807;
	b=POwRoPg+GB3RBP9SiMMDF7OEV2gAkJkwERY1Qvhr00cQPiA3k1Xw+d+MuuthyDaKLp9A
	 RDlo0hH+bfq5Oc54Oh1l2a/umul8HhlDzsjXWsf357bhsS3czwT3XNRQbBjuquNNM1oSz
	 MhiwmUOs7mHPMH+Yk/BEM4bocBxXtD+DJfavj698B5acFdaOtt8hk0VgS/HcMv+Y6s4mQ
	 8TeYevPM4VjYUNHgPfQLsa1eLIqjuffbFHNxq3ElmQdz5qVSj3Y8weiVw64M+ypcov1En
	 zheqY8yXSY0OndM1963QQ6qJrVqfF6zE9cTia+zXW5k5oDdqEIyOpZDH77/nT9d2lcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=T1SC0J9AwjdFx9BDrE+/CgVPZT1ktRGkX+KqeNbuZak=;
	b=K3DwHtP2T7Is/QKNnTUt0nLDdPG08iiDK6b66CUIMIcyOT0wacAu9cZPfBgCDqnTDn9/
	 vL/mX1lftwiKbqyUDFHiNJtcPowwqveAlVeALwvOJ+9B5qYPqYzY9VPHnLzfFIyEfB7iL
	 /LOwJcS4ZJThcwZ8KFLgLT1vI+SMLidevdvVgrZ6z0dkEx0VWeTQW+IFkWMNE/olKMx73
	 7x9peXfSsvxhyIhbC0EZeQDA1Cs1MiibM8LSOklGDmzvxi15OEuHfpOzHBlutERvf0OyD
	 xM3WiwSVuUNb7djEUhC6tt10Q/5wvxFavl3vFL0Jo4j7V7JrFr+7Kz3SVTLdRmW2Z7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDoiXZhu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FF606A31E;
	Tue, 24 Nov 2026 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDoiXZhu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E111F000C4;
	Tue, 24 Nov 2026 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795486806;
	bh=T1SC0J9AwjdFx9BDrE+/CgVPZT1ktRGkX+KqeNbuZak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GDoiXZhu3GdNMwC7ZTUt7GNBxV0+z+uN+9EK+K8tqMq7myyBsrArOQ2fd2PDcwGfw
	 iJ/z4HXkyHvEhnQ6dsNudbUrXnQf7fjqO9mvj714hl+ByK9D+euncH4qiCuuo7BvVH
	 rjSsVsFa7l+2Up3LS1yu1mSCLJ2hwh/lKi1ObGBbXjWw8AK960YWS4otLhgGSQrEpE
	 OMfafYPd6r1xa+0lCH6mK+s1wW8+wMUMBhBcQteS9iEpA5zL8qz91Q3EMLnL+c2anG
	 8/qXzg6ZHCaJHUS31sGU6I1pHH7ab6i/ANMH2Gdml5jTZFtTTCnXSPyZE+6tklqL95
	 NJFRxA06gGQPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A34439302C9;
	Tue, 24 Nov 2026 02:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/2] ionic: fix Tx stalls on TSO skbs larger than
 the Tx ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179548680503.3235934.7161170988838915677.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 02:20:05 +0000
References: <20261117-b4-ionic-tso-max-segs-v2-0-f9792566c5d5@amd.com>
In-Reply-To: <20261117-b4-ionic-tso-max-segs-v2-0-f9792566c5d5@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 eric.joyner@amd.com, abhijit.gangurde@amd.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Nov 2026 19:18:53 +0000 you wrote:
> ionic uses one Tx descriptor per TSO segment but never sets
> tso_max_segs, so the stack can build TSO skbs with more segments than
> the Tx ring holds. Such an skb can never be posted: the queue stops,
> nothing wakes it, and the netdev watchdog fires. Guest TCP traffic with
> an MSS below 64 hit this on the default 1024-entry ring.
> 
> Patch 1 rejects Tx ring sizes below 64. The completion path wakes a
> stopped Tx queue only once 44 descriptors are free, so a smaller ring
> never wakes once stopped.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] ionic: reject Tx ring sizes below the minimum
    https://git.kernel.org/netdev/net/c/c5aabb4fcbec
  - [net,v2,2/2] ionic: limit TSO segments to the minimum Tx ring size
    https://git.kernel.org/netdev/net/c/0778833b9602

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


