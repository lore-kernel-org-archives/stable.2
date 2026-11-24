Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482007;
	b=C3cfjs29PaAtKbK6CVSqeadrjTVSV/qreUvxHPhtFwoEGl4/d8EV87QO9nWywpN7AiP9
	 l6N1Bg4wEx+oFY9DuHZ6h/gFb6cnRrvqBVJeG2e30PN/CDzN3jwAaZD8B77czyYCjzYkL
	 mwfv1fYlTVFLdI21pc2Fkd7vSfKrx9yM8YnZTQS9EidKld3/xSvZz6HSjGs2C4ToDbqwc
	 gehMegVd/fOjO73pLBCkQY1bKyOm6uQ1bqWsaQG6ZxjxR9SuJye085nD5qkmZWVNeuJp0
	 lBfsTec9YwqQzFjsqc+bzptnKA5Kedm1opATbLbBY/xif/hb2S4BAsrDLKTZDIfWQfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Z6Awb/FZTQ7QqsWLS816v+yxjQCwR8pFOu1dJZlIldc=;
	b=LvelpNnKakDEiDTa1gAjFRkg2P2Tm8MEAhyppPtuBsSF7grb8nFGgW8264atpvKK6Vnk
	 63/pSLZ5Z6ajxAGeOkKAX1MTm+ZDQMkCEz8lEtXPyx/Lu3IC+78udpvAr9KeUJQSdKlgR
	 3qJHyWYNVyhJyDuXqYl8iRfY3uM8L6t/p51ieaNuz4uZeikXalJGP9iH08oZONLs3LzFF
	 1ronsBlhQS0WAG6MzRqMaXPzWfFf++Jy15iKmMJG91X4f7hTSg4d9urICfTiI8TNz9K+g
	 xZEpIVdwMZDMTamW+Rh1xu7I1HPrKuJSvfw9xpu4sZz2Ut7i3MsexLYUzh4JdUxRAdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ov8zGj0p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE665606A322;
	Tue, 24 Nov 2026 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ov8zGj0p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B761F000C0;
	Tue, 24 Nov 2026 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482007;
	bh=Z6Awb/FZTQ7QqsWLS816v+yxjQCwR8pFOu1dJZlIldc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ov8zGj0pryc5LGwIKMgaekUOxaQGMEiUOjAdWWNHzTV581YWkF+v7/CCcA25v/6un
	 HeQ90A45TwqcJgYSr9rFxH0pUmPGfoh+JUB1ngDeZUfb8WhZ0Fo5V0fdlBGsq0jrnf
	 C0pYxaFNV5Y9bJEgpfp4tS752RXuFLPzYyW21/p/Pj7nPs21T1kR8Pz9KX8A4Aw9g5
	 mom8uUZxfdeqGLL55le40rtoPKOnWt9TuWsVqFfhnzIxYensfTKXIwynp+04x+xCl+
	 /tG0G38JoZFkGBrXUKTsRD4YJC68X4cH10NIa39/uw2pB3BRYqzrAwifSN8NAa4C/D
	 GsQQFdBKbxkEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7744C39302C0;
	Tue, 24 Nov 2026 01:00:07 +0000 (UTC)
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
Subject: Re: [PATCH net v6 0/2] vsock/bpf: fix recvmsg deadlock and
 zero-length, OOB, errqueue reads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179548200601.3207943.5212096755627241537.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 01:00:06 +0000
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
To: Jerome Mohm <jrmmhm.kernel@eldare.de>
Cc: sgarzare@redhat.com, bobbyeshleman@meta.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mst@redhat.com, ast@kernel.org, mhal@rbox.co, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Nov 2026 12:59:13 +0100 you wrote:
> On a vsock socket in a sockmap, a blocking recv() deadlocks with the
> virtio delivery worker and stops all vsock rx on that worker, and
> zero-length, MSG_OOB and MSG_ERRQUEUE reads spin with the lock held,
> wait, or consume stream bytes. Both come from the commit that added
> sockmap support. Patch 1 hands those reads to __vsock_recvmsg(), and
> patch 2 releases the lock around the wait and makes the wait loop.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/2] vsock/bpf: fix zero-length, MSG_OOB and MSG_ERRQUEUE reads
    https://git.kernel.org/netdev/net/c/a4b5c8d6de91
  - [net,v6,2/2] vsock/bpf: release sock lock while waiting for data in recvmsg
    https://git.kernel.org/netdev/net/c/cfd56c8720f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


