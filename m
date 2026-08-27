Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2558287E;
	Thu, 27 Aug 2026 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819461; cv=none; b=LwoaKQZQ9LYJ791kPoh/6cqDgRGTO4Wa6Zop5F1NFsXDOJmlxKqSxCO9vN1b4gX7Xsvh290AWEJ21FNZT89gunP9FlnViPPC0fJlFJ4xGca7vxupawW6WnS65ov96XDlOFEqoyoNs5ti3FT2DE66cc6B6J+X7ZBSkgIIwkp2A6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819461; c=relaxed/simple;
	bh=PFKuncMNnfQaBfUKEBl601Fccjvae1YIQuJYQZRS9sY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IcNCcd7H0TJ4VG/j1up+E2ZIqr05x6aer5YhdGFgmLI3See0UdBvxekxf7TTBwAPkJVc0kHH0Xsd3YxYd6puGXAe+pCHq8bnHrrfSIDtZHqgt+j4Z+pjbAdyy0yYykejaRZjoQ2L/+AAbd2U1oW4Rlos5eAoBwMo8raPmtmbPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVh8lbMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVh8lbMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2441F000E9;
	Thu, 27 Aug 2026 08:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787819460;
	bh=hGBDlZHSEvqF7WW+5Upib7S2O0nUIwQZJ+S8JO8iHLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SVh8lbMVB5WQ2tJQFwZRSqVbVJAM5f/9uiok6IhY2J+rK/drQ2iz7suvUGfFggH/U
	 MfNxeg6IZyvcETIhKb7kgRjFRfjtbw2Ir61OnzLKsMNTly1NAJKN2/wBgCKubL4c0k
	 aVWw3I28Vo7Xj7HjuKTJFMO7gTDKaJoUH51c8AGgMkzLQWwD4SAFJzjpsbE8nAw7u8
	 dIP49nzCY96fv7D7s5tEjB/za6dtU9woBqV6yeu5wrCWcelsZhbfViJq/3BeckKGmn
	 oS2BdfrgTvHNYgX3CV48EuP8gDo9N8yHrDrCDVJdU4dOc7eZXyAsCrFluSI14mI+SD
	 u2OaBKS+ZQzaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983C3809A12;
	Thu, 27 Aug 2026 08:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: fix spurious TX timeout after dev_activate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178781940590.1103151.2789234266470472117.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 08:30:05 +0000
References: <20260825-trans_start-v2-1-286b4d6d70cb@debian.org>
In-Reply-To: <20260825-trans_start-v2-1-286b4d6d70cb@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org, nb@tipi-net.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Aug 2026 03:50:10 -0700 you wrote:
> While debugging another issue today, I found out that my TX queue is
> reported as stopped for 4294907392 ms (49.7 days), on a machine that
> had been up for four minutes.
> 
>     bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 28: transmit queue 23 timed out 4294907392 ms
> 
> 4294907392 is not an elapsed time. It is the value of jiffies at that
> moment: INITIAL_JIFFIES is 4294667296, which leaves jiffies 59 seconds
> short of wrapping.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: fix spurious TX timeout after dev_activate()
    https://git.kernel.org/netdev/net/c/82aeed240078

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


