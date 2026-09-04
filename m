Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF73BCD0A;
	Fri,  4 Sep 2026 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563478; cv=none; b=bbxUwKdE4CI8SG08xoCxz2yZMJAjENYJd1/Q4AZADwIN1C8jdnj1g5L31Bqp8tmFuVap1p9rTkeUMoORT4rfqjt2CFpcCXOEg1P6WFADNkpYZV7LoadA3WfVS7MkHda3Cj86ORPhtEB6RTSL5AWCF3dULXWuZ/PfqXqju0l3T7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563478; c=relaxed/simple;
	bh=X/zcEbPOXykzO+lKlT/G+vviQfkHnu5WvlZ44E73shE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qmodVw80RX3C7y0qbnrW6Ky4YEHLAJTsqEaBOERgf1Vddt4/VMMz84WFtVSmfxbFYoAgBVg/BJkT7ypUAyWNR/t+BW9YL4HZC6vyZ5d0jTVj0RSMcUF2I4Iazv7mgXOHWW8tZy9UsqGcUYZiM/JQQWt+kff9dVjI+wQg4pEcQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOSJGzmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOSJGzmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91321F00A3D;
	Fri,  4 Sep 2026 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788563476;
	bh=KqK9XrYhp0zWmWnJFK1MkgsU1lZMkDtpzKm5JwFYO2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XOSJGzmkgEidCn5PBomHjoFQfKG9igvwgUuTr2+UeKuqyYmTju/0gmfmFmcFBBPdE
	 sbs5iYZV0WELEUMlnFv1J87LcD9F9T+G+qmW7vhm8jm0cw6Q/pbtGMYyyzpdVU8c+N
	 YQ0/x4knSfJhtEnTiW6wrWG64kImdqrmbIOk5rzhmbQT9bvbqON+gVOeJhy3luWUiZ
	 FkOuVlKOK2Yz2wb/XF8EZIZZFEiV7eKeCx9UchO2DDTNmcV+mzZr/76EQwGj57OEY9
	 d8wh4CLfs9cOOSpsU/PmSc/ByGVSqWtOaFXzfMoaHPO26cQB7QABhuFn9XHpf5FBel
	 EOxgP7LoN9oBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9395E3924A7F;
	Fri,  4 Sep 2026 23:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: reduce XMIT_RECURSION_LIMIT under KASAN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856341714.1009860.16795255539581873651.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:10:17 +0000
References: <20260902123040.2172805-1-tristmd@gmail.com>
In-Reply-To: <20260902123040.2172805-1-tristmd@gmail.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, maheshb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 12:30:40 +0000 you wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> Virtual network devices (ipvlan, macvlan, bonding) can enter legitimate
> transmit recursion when combined with packet forwarding configurations
> such as IPVS NAT.  The existing XMIT_RECURSION_LIMIT (8) in
> __dev_queue_xmit() detects and breaks these loops, but the allowed
> depth is too high for KASAN-instrumented kernels: each recursion level
> consumes significantly more stack due to KASAN inline instrumentation,
> and the cumulative usage overflows the kernel stack before the limit
> fires.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: reduce XMIT_RECURSION_LIMIT under KASAN
    https://git.kernel.org/netdev/net-next/c/7f1de03e3103

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


