Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007B2C1586;
	Sat, 22 Aug 2026 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430674; cv=none; b=rVPDc/uNR1J0lVIPm+lSTzPSiyVcA2fzXltqJ3MpujMbxYx/VHEIPHLd2t7TjtOTbSbYQRwYcBqDZ5KbR9Zb2BilTLDmFvQyQ18nrJGVivY97vJ52BbUdeKCaBiqlZms12KlXauLnm36zC9Xb1xjR5Jn9uxhyn2RhiP8yqqY/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430674; c=relaxed/simple;
	bh=yDzH8iljCPcuvzB0eUMSZKaMgoKwXLvINxwMKKOxwV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nG20JmEkSrndVt18QB3cVz+gcKZy1QqBSGA/ARX0hqV9CGgzYz8AVg9VZIQW1eAuwTGqdP0mtg6Jcbl3pd4NX8pQsd3tT5DR90fjHxfgrjSOQxGimwPXrzEHGEVTgOUOSN8vL43o+okXJ08eSPNnuDZEvLLDBiDgX178nCyB1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj2gwk8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj2gwk8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AF71F000E9;
	Sat, 22 Aug 2026 20:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430673;
	bh=v7vpcojRv1+YHhH/nJQaLge8CmSjruhW4FLUNpf81as=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pj2gwk8cXC4y390aDUciYkjT4AlGXPMXYXa64bhX5xpegDJJ62NwBclrLsOGYyD1J
	 8VGbEFvAAiZQ/2nto7p885KD4wPB5Um0Fbas1D4HDAFuYh72vPIc4E/oi+Qm0ooHRK
	 125m6Lsob3XztuNCMpU3q0knDdL+UzFusyKL/FeifJteDdtbB+nGvYfV18HKyLrE/Y
	 Guhtrcfq4JhFyVPDtiaUYnLGCObfBqjaRjkzQdsRin8AJ3B6qVbOnBxxQVBGKQAjoz
	 FwSdA+Ws5Y2dprl8qw8tP/smNn5jyZLArM9E0s/G+d+ZrWFgcpIos/e0JDsl9Bnnuy
	 LlHVUOtlMt/+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56903380CEF9;
	Sat, 22 Aug 2026 20:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] qede: Fix NULL pointer dereference in TPA fragment
 processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743062214.1819488.4090246622562487688.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:30:22 +0000
References: <20260818073309.2266072-1-vnagare@redhat.com>
In-Reply-To: <20260818073309.2266072-1-vnagare@redhat.com>
To: Vaibhav Nagare <nagarevaibhav@gmail.com>
Cc: horms@kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, matvey.kovalev@ispras.ru,
 Pavel.Zhigulin@kaspersky.com, aelior@marvell.com, manishc@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 vnagare@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 13:03:09 +0530 you wrote:
> Under memory pressure, the qede driver encounters NULL pointer
> dereferences when processing TPA continuation fragments.
> 
> Commit 8a8633978b84 ("qede: Add build_skb() support.") accidentally
> dropped the assignment of tpa_info->buffer.data in qede_tpa_start().
> 
> When memory pressure causes an SKB allocation failure in qede_tpa_start(),
> the driver sets tpa_start_fail = true and attempts to recycle the physical
> page later in qede_tpa_end() via qede_reuse_page(). However, because
> buffer.data was left uninitialized (NULL), qede_reuse_page() pushes a
> "ghost" BD (valid DMA mapping but NULL data pointer) back into the
> active Rx ring.
> 
> [...]

Here is the summary with links:
  - [net,v5] qede: Fix NULL pointer dereference in TPA fragment processing
    https://git.kernel.org/netdev/net/c/06aa3d26327f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


