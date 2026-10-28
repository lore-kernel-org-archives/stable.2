Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793229007;
	b=gzZ62O+JaZ5MfTR/XL7gFNUUUOnr2z1vcP8oCthFr0MW71GGVbaGJ7rbeX8Nz3R1ImsJ
	 HIcJnpFpoB+au77igOnK11Tt25UyViDJ5BFUKfKaYGisbzXbQT054fCwQVXCG7SobNhI6
	 0/2/8VImR107QMsd8L7y3he3I1wbE82QEgS9N2PZyXKXq/EBhfSc1ejcWglp33fti+NUl
	 SUn2vxgz2I6ykjZ2z9yKj5hXMGuKWUiMlRqlSscQiFbeRRLF6Y9dVW19X0MTHjz1yJPN0
	 YQjwwABT1pQzu4RfPsv2rMy/GpeNrGWcC7nSe/bgjufH8hwu0vtkPUoPzEstXU3fn2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793229007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ZOxopfCgic5R7Aeo/hqd3+pQx4C+2s3b4c+s8g5N62E=;
	b=J44XrhlgQWb0ID5fgXRXx91rv28Lbod5hZXlEDVQKsGNYZp31W25IGC6GwrWwhiTvVzp
	 UEiuJHqrrc55zmb+JDQuJiSvYMszSrrOM8yCFBTOnllZ9uiQIY9cRKFfphnIYijeVRYja
	 daDVPeW7hBQx2IRF5GNNERm2SaSPgmFfh78EM0+S7QuCln5A6aKUh5KSnIqOp5ugNns+a
	 Ks35dymvUnyeHWHl+n6xSSFCCP6+GOZ58y6RcQP5WWsl15Ne8ouInlTkgCskGsr14/TBZ
	 34AzPUjMzXUzxz1bPr81PjK+GaMfBl0D/v2PNDLUTgHvYFf2a9UasAveRVYfxTgdIjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMWmqGSW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBEA606A327;
	Wed, 28 Oct 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMWmqGSW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A601F01829;
	Wed, 28 Oct 2026 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793229007;
	bh=ZOxopfCgic5R7Aeo/hqd3+pQx4C+2s3b4c+s8g5N62E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cMWmqGSWRNceRIBKm9sypqCBQCCTstQ+sWjOo9F5Qnb8akIOkcIwqDKxQCoJeEQBb
	 8fMYBsSu38Eh6+qVIaSftHmrUisBvPE8ibS0/xZUUEoqfwaMVX7aLbm3QK87iKZzlJ
	 qgxg4Wb3YdOWFC9kln+YseUAaBJT1y2hiakvpvJre5L9kgNTK8i35LYZfbv3PbSYXE
	 u47i4nARHOn0hLgHf/NKolucdY26ECrBoUplVnwwA3m8R0cdDnL8joRrRTau7HZOM+
	 9eYyB7qKInW+0WSma8FtWPfgWk1jA3jv2uqYRPlCSW7O/fRdtIcgJsz9WTZOFDSpm9
	 1ETGv94QZr7ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 074D23AAFC4A;
	Wed, 28 Oct 2026 23:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] Revert advertising the TCP MSS from the
 configured
 MTU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179322900582.1471258.8439548147927472759.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 23:10:05 +0000
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
In-Reply-To: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
To: Esko Mobius <echoowall@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 jiayuan.chen@linux.dev, shuah@kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, edumazet@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 15:23:07 +0800 you wrote:
> Commit 2640e6419594 ("net: advertise TCP MSS from the configured MTU,
> not the learned PMTU") breaks TCP for clients behind networks that
> filter inbound ICMP, when the server reaches them through a hop with a
> smaller MTU: the handshake completes, then the connection stalls as
> soon as the client sends full-size segments. This was reported in [1]
> and confirmed on 7.3-rc7; reverting the commit on top of 7.3-rc7 fixes
> it. Details and numbers are in patch 2.
> 
> [...]

Here is the summary with links:
  - [net,1/2] Revert "selftests: net: packetdrill: add tests for advertised MSS with PMTU exceptions"
    https://git.kernel.org/netdev/net/c/b4aac29a21d9
  - [net,2/2] Revert "net: advertise TCP MSS from the configured MTU, not the learned PMTU"
    https://git.kernel.org/netdev/net/c/564313447e54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


