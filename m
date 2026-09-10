Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3F377553;
	Thu, 10 Sep 2026 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055468; cv=none; b=uqyptArU83t4AaQATDYAOY4DYJtZbEjQhTwLIoOjeWr+hl6Nihb7hMKveMNCFot5OUr124SWFGwitGAC6hysZeZTSl+SruMXzgDMScGIg5tBK80sFOVF20VAtnqmkYrug2umf8kF/Uxw6dpRV4EqXwBz/IPTknDnI6JKWY8lW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055468; c=relaxed/simple;
	bh=J0BR0XlL21N+EL+dX8Jf9KJSMyypaV6NGLNardccjfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fO94yO8qAPLOaYYthxeisdAE8oWNTaqxI35+1ZxlGA6yIXQrvi8Jp+kIHIDLqSH20ygRqUfaCXGjLyevGc1y17ltdYiay9zlfZjZ3eFesiNI9T4aTvvRYW8EXIDKCD6g6X5Q2uBYIr1eVkWwd1xYNceOExzunoeWpCG+xNP0b2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcV30OMw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcV30OMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E909F1F000FF;
	Thu, 10 Sep 2026 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055467;
	bh=TMzntpbGNDPcqG3F9baUoNtI5d7klICq7Ysy/N21cF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PcV30OMwUebOtl1yxU0mlxbmZZBKX1tT2ij66G4NdMuOm/nEsM7wfcSYGcM5C5kx1
	 oa1Ou9g15HeAMC3PqKqvO+vO37vwn1CiTT5RCytD8qpc5jZmXCNPhj4BIq+JDNNMzr
	 eAqdUx3TEe3qyHNXhwlboW7wS6dRyD3U7pOtRhclqSxS/x34/tkb4oVZjDBNPUoZEN
	 F8ljHrHyz/3PJaFsq1/Ojnkm8IMur9mUvIEStF4tEIlf7s/DD60kuM1M6ZCsCtZ673
	 frJ1WebZy1OOdxHQsYvnrXq5VG4q6/LTOUmKhot1cBF3p54S4AdrsCpBfrHpnZVkef
	 6j6gg8GH5bFHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93908380CFFA;
	Thu, 10 Sep 2026 15:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: macb: initialize PTP state before registering
 clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905540439.1510486.3682579861887737630.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 15:50:04 +0000
References: <20260908103924.607033-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260908103924.607033-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: theo.lebrun@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, conor.dooley@microchip.com, rafalo@cadence.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 jianhao.xu@seu.edu.cn, vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 18:39:24 +0800 you wrote:
> gem_ptp_init() registers the PTP clock before initializing
> bp->tsu_clk_lock and the TSU hardware. Since ptp_clock_register()
> publishes the PTP character device, userspace may invoke PTP callbacks
> before the lock and hardware are ready.
> 
> In addition, gem_ptp_init() is called from both the interface open and
> resume paths. Reinitializing tsu_clk_lock there can reset the lock while
> timestamp processing is using it.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: macb: initialize PTP state before registering clock
    https://git.kernel.org/netdev/net/c/e1406330d70e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


