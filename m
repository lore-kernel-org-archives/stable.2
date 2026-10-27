Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142011;
	b=EU/uQJ7fbX7iUEOdTLbflhpNp4zDCyIdDhbaLe2ZVVKL5P+fSGIqa/3Z4RdRwEbdsJGF
	 PVGKAeOuhB4gPEaUwKa6LZTTpQacvstzHVBsRZrUIW2fyywpaEB3zjwne5MFyDXM6LJkq
	 hNMFRBe31sXTyYMlL10aS75mgV9wnlkvGXx6ZaL/PaR1xOhyLx2FAjkZls3n51ckyF5Qg
	 6oVv1N5n4cvi1V+E8476D6prt8tYAXg3eew4dHJT7VDfjl+b9U0aT8XazuLiei8URD4QW
	 AdHeYZfl5ykhVfljwnJtI33ZksnLpWR5PJqpVkKEunsZ6/KozdjuYqS5V0z2Glor2gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=UfWvtemhdP4zJ7uBSCJzg+Qoh/1DBpgY2rm04yLvulg=;
	b=yb7+fk4KT13Le01FOQmK8KRlVPOyymUEfj9+Lg7gPZJDNBxYGYXeXaHRBgpPrGYSxeYV
	 OpnkdoIjnxFS7B3Foxtbn1rL/d+GG0w2NWEm5b1tXDbCwXIP0audJcp0W3AR6Rl+ylWVD
	 IW7tyzVLpSdZhrYSoxXLfzOhz3yjP/m7rDPVfz7I1NjNOoCc70mo4YPFK3yasuKXSilOD
	 7pSv+TDiY5xRxHAnNrg/Bo/+ivZIBrFugDRo+14bYXSpK+8wCxvIIsoSQ8G62coXEsy17
	 HWmVyQnCaXzFxHUF11vJJSuzRSpMJ0+0eJOvj6NjKDtc7gQOXnJqtOn5uc1IryrIOLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IB0vDJAU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26514606A31D;
	Tue, 27 Oct 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IB0vDJAU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C780A1F01825;
	Tue, 27 Oct 2026 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142010;
	bh=UfWvtemhdP4zJ7uBSCJzg+Qoh/1DBpgY2rm04yLvulg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IB0vDJAUHAIAwbiAIj11wTgxSxuUc0A55SisR7A9yRW4HBDLddSZ6vOLlEdhpUT2w
	 I8sR6G+Of3d0PDuerBmlR8mGhqF/fp8vt1BnoNeGrE80JzFqNnDgDfKFCSwxZD22Jj
	 BM3Ul/I9Sv5L9ixqhdQ/n3DJLmqmBIsWilBZqa44aUJoMcnCWJ+omobMTG8hBx7C0u
	 djKZUdunORNhM5QuQx212tFNzycITy2qxsXy3Vd71U+yX2YEQHIvIvzlOTgwoGBzDa
	 HB6lcgvvTP3uNLkNM+qj5Bai+SBFvshbWOesIzcH7kJM2Gsy6n52YxJZFSfhuREOw9
	 PMn6mQ1nVkMIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5B33AA940D;
	Tue, 27 Oct 2026 23:00:10 +0000 (UTC)
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
Subject: Re: [PATCH net] macvlan: fix passthru promiscuity accounting while
 down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314200928.379196.7973940130661793334.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 23:00:09 +0000
References: <20261022090809.12019-1-yanxia@cmss.chinamobile.com>
In-Reply-To: <20261022090809.12019-1-yanxia@cmss.chinamobile.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Oct 2026 17:08:09 +0800 you wrote:
> macvlan_changelink() adjusts the lower device's promiscuity count when
> NOPROMISC changes, even if the passthru macvlan is down. The reference
> is acquired in macvlan_open() and released in macvlan_stop(), so a down
> interface has no reference to change.
> 
> Clearing NOPROMISC while down leaves an extra reference after the next
> open/stop cycle. Setting it while down can remove a reference held by
> another user of the lower device.
> 
> [...]

Here is the summary with links:
  - [net] macvlan: fix passthru promiscuity accounting while down
    https://git.kernel.org/netdev/net/c/b6743653d134

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


