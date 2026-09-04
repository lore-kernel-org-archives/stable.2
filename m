Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485C29B781;
	Fri,  4 Sep 2026 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487866; cv=none; b=NC3xdhK2unHh1fA4YmIADL8dYcWHgp5hCYZYCR/V9ylMduGUSAYAyiJLBwP08Y7B4YE3mnqRCOL6m9Vf9iX1txLYXt4yLp4sPp+GeS44ofGv2UBXiM3kZSFeSykNUqXjDWsEbKON1xy2tNLT5zoZzmYJumTWg/KvRjinCleSrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487866; c=relaxed/simple;
	bh=13nwkhzY4r3dJ/lRkbg30aQXZ3uF7CNeiVPPC8ox1iE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P695hk8RJTtN/M+NkkcCMh6CKZijGygw8HPWNpKqcLsG45zlO70hzO/1f2TX5DuGFEqJ02DiDVLRYlPEEyUb5v1F/kdsM0EL4y0xxDBLCVRi/nWPUuC5AI2FP/WenbIrBBFeOZ4yID9+/vCF4IDXSxoei5xRtXD2jmDvK0qMFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9woHwBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9woHwBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B09B1F000E9;
	Fri,  4 Sep 2026 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788487865;
	bh=aXIO6ML1i9Mc6rb/GCEq2U1R+PmturfzNZiFQ2D/pDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X9woHwBCNWq7pSPUZ6zuMkLGSW4DUU4h4IYPJCoXXKhqKX0O2F2qBIGbCOGq2DZ5s
	 GKQ90Opg35CWWc9o3pDffQ/f6ZQzQMArsq5IR1Y4n6WyHI7MaktQKKC/+2D346pF3b
	 44KxQmJr5K4GlDRQjdIrPqPAfclUrpKUlNJ6LyWxUSh5mTaxZLPpr2DXHJDYnCtHzK
	 oC5gyv8+GRI2ACiw6dgT0AHA6geUj9SaTAmx/IZt9lUBcgC8ud0WV8sDOKMBslLhYv
	 FK+Fzff/Cx99JtSUBh2o8kkppJdAgvO3JIlyx/z5fiMf6PXWUDMhlnxa3+3IMsFZ7x
	 SGps91CE6n3SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5692138119E3;
	Fri,  4 Sep 2026 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: Prevent queue stop with deferred
 completions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848780589.4119222.12687170569675818749.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 02:10:05 +0000
References: <20260902213956.4160615-1-joe@dama.to>
In-Reply-To: <20260902213956.4160615-1-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 14:39:54 -0700 you wrote:
> When the driver receives a burst of packets, it can mark a BD with the
> NO_CMPL bit to defer completions. The expectation is that the last
> packet in the ring will have this bit unset and the completion generated
> by that packet will cleanup that packet and the ones preceding it. This
> helps to reduce the number of completions fired.
> 
> The suppressed completions are controlled by the driver and the number
> of packets with suppressed completions scales with the size of the ring.
> SW USO packets, on the other hand, have an upper bound on the maximum
> number of BDs which can be consumed which does not scale with the ring
> size.
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: Prevent queue stop with deferred completions
    https://git.kernel.org/netdev/net/c/39b23c1c40e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


