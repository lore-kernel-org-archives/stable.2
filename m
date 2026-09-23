Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AE3321C2;
	Wed, 23 Sep 2026 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126491; cv=none; b=lUCSS2lyFQEUjpUSFBWfdk4r3DVmDgx2yqY7HGOo6HoHHRWNbVEKNM+nUwTEcXN8NvTHRIkNWREj7R0CYdemUD414AfwAD13uMRblg826JIuQEItz+dF2+yZeXW0UMkVayLWtpf0m9Fnx87cl0FA9TeSsK3+AYm5zosGVSD3Xxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126491; c=relaxed/simple;
	bh=ZBbowwj9g4LiCppnvLOwcyj9BEF/cyQCdfeHzHQMhjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nDW9uvCByj8BeMrNq+JMXtN4L5t2+QS6I/3u94nc0SvnrbmjR3HyLHY+3Z8ieLUc88QSH41hjxnSibZLivONlXUwFLOM+xqnhjy1wbtYREgJYDp0HU3Ku4gMOOz4yck0kj3oBHCPJZk19t3Hbkwjur3f/vbv85cRJcJEtEw0KxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5mLL55H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5mLL55H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E50F1F000FF;
	Wed, 23 Sep 2026 01:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126490;
	bh=hvLyBIZlI4M3HZZ+3BYKdeiiZqGAKGp8Army6XuZzek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W5mLL55HqMCrTCHIpEiCkhYCq+pc2qDxZgkmMraGm1rlu2JN5zMdk3ZdVbM9acUis
	 guRN8a/qFL70GVWyGX1Z2hRTvkoMa7CsvqkBNBHIWedU53zeSVgqUqgQoOxjrQ2kbh
	 /oULwbr3WJcxBcdNthKPRBrdhYzAMI/DYsyFAm1DWaaAzeFGpeXKHo1qbA3mPDcT5Q
	 zXCqvkVyWXdsA7l29nfkv8J/hmfToD39g24ljBLPi/jEazTvRpd7G5JIWtWpFKM9WH
	 r8lpfDweAtRonw03bXWvGu/rjVyYyHwvitwCJM6O1wPSNhf9nBj1YbaalOwcTgCtoG
	 +yh9+3CA4Gd1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A8B3924463;
	Wed, 23 Sep 2026 01:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: dwmac-sun8i: Fix EPHY clock leak in
 get_ephy_nodes()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012642070.161587.7205232345665822833.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 01:20:20 +0000
References: <20260917113654.2149268-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917113654.2149268-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 clabbe.montjoie@gmail.com, davem@davemloft.net, edumazet@google.com,
 jernej.skrabec@gmail.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 samuel@sholland.org, wens@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 11:36:54 +0000 you wrote:
> get_ephy_nodes() stores the clock returned by of_clk_get() directly in
> gmac->ephy_clk before the reset control is obtained. When the reset
> lookup fails, the loop continues or returns without releasing that
> clock, and sun8i_dwmac_probe() then jumps to dwmac_remove, which does
> not call clk_put(). Keep the clock in a local variable and release it
> on the error paths.
> 
> [...]

Here is the summary with links:
  - net: stmmac: dwmac-sun8i: Fix EPHY clock leak in get_ephy_nodes()
    https://git.kernel.org/netdev/net-next/c/d9750b3c4c27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


