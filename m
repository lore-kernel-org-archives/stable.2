Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2B32B135;
	Fri, 16 Oct 2026 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113013; cv=none; b=Iufeb42GQqQZZEttbXK4pH6hYGKwUJVJx+BTAg1YyqI+Z/r9NkMuBAGtq3OtXt+lUjQFRv5SLWNA91AKZbxDfALk6GNH49N8Q4lJvcdnjgqNsdbgg0FtpSU93F2kndSr5PD1EPkEXg35doSdtt7g50lUrQE+ZTuPxg7+BlZsV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113013; c=relaxed/simple;
	bh=b5028DQrQKW6ZF+VhPTKQY0eEDmIRlSwjq0y9yyp+qQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c7wq2WsLWo8TFfDTt8xYksImYqNCG2amlBk49+V1UHFwR0clDt7gyDBEzKIitiEZb6LO3YRbn5WB+JR9PJ9gANEKbCQ5qbGKgoqd/Q3fYbDYZtX2pPymKuV7BrbpfVaQB1jJdfQ7Qswt6zs0G7Ai2H4lV5X8PPR2dbvoUHusCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUiXHPEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUiXHPEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB931F000C4;
	Fri, 16 Oct 2026 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792113012;
	bh=ymNhEkjimRGeSuYmrBqIBrAIzE//R8j4khgVGTq7IF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DUiXHPELW7LD5aVh5zyrpeo+ElpXD2Gz2NuKdck07UbrtQBZwvIR1pMToE3xUJFO3
	 pvk0N0+Xm+oro6MH/+H4KtKbtaDne00Asnr0l+rBWAefozaQqmWouL03aZK3LDhtEj
	 wvZunW2fgzdW2mnbkXlvMfd2z9D6HpxdWx4U49eFS/1gGa/DWIX+BWQqjNA++yWdzJ
	 PACCxEg7sbAPfXEBSlvt+IZqTeTtB3cptT/YcRcUv5WBbSy8hmuVs/I/g8SDhYT7/7
	 KDscpQCBMfrdz9/+UqtcbhyTCcxzltHadJHiB6FRM8TvXsXr0r2gmc3qOWNMmRQo+9
	 JpkbJkBQpSVXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774413808209;
	Fri, 16 Oct 2026 01:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mpls: unregister sysctls before network device teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211301102.4187796.14903692896368030856.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:10:11 +0000
References: <20261007201237.171863-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261007201237.171863-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Oct 2026 20:12:37 +0000 you wrote:
> On network namespace exit, loopback is freed before MPLS unregisters its
> sysctls. A task can keep platform_labels open and write to it during exit.
> The handler can then use the freed loopback device.
> 
> Unregister the sysctls in pre_exit.
> 
> Fixes: 7720c01f3f59 ("mpls: Add a sysctl to control the size of the mpls label table")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> 
> [...]

Here is the summary with links:
  - mpls: unregister sysctls before network device teardown
    https://git.kernel.org/netdev/net-next/c/c71d33e31b0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


