Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4803B71AE;
	Thu, 20 Aug 2026 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254282; cv=none; b=XSr9VETO/GFuPmWLPMrwuBku3ig0jdDxRgPQtIxrsekalU0LfDBqCE9eeT6NCaN53EJdI8civSaPB9QQ/BW9AtG0YZ7zHZoaWT2yrLLHWu3OFiIFd5rJeHmhY6almqUx3QBRtipYbsJsMmHNitDMU3ZHR4mJj+BTwX4p985ZT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254282; c=relaxed/simple;
	bh=YUGvMc7pkO/vfaAGafTbVxhlBCl+vepfR5sq9vuqHpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=suzKBcrgBSlmmRaxUluEWp3FQavFXV01Pdecbx0OJTnBPIt7fDeLliHtlY0Dsa9MmIHqEee97yMJWBjHZ3RzahfUp8UfDMvEoqCcwrsltG/BzuT2XwFnyh/wjhd/F3iNANWP3zN2Hb0T4axJ6JB0z0fAbuYRbw+F9P6aFETPrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYS70/QY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYS70/QY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25D51F000E9;
	Thu, 20 Aug 2026 19:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254277;
	bh=G6hLzW/9WAL4cyybj1izKGx83+JCfFNjZLkKs8bw/5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XYS70/QYkuhR+j4dwq1ah6p2h0aBr9pAwbFmI/pg0VOheNa+ylRKpMIVc8Qgd0jHo
	 7WxcXkCbh21U/oyZYykcS7YkYVXe653IaHtvuOI9mWnxaFuPs9OYHP49Xb6aQo4Inl
	 HmXwIMzpnfGp6bPTD2Ph59hoRbdhuzXYdFLpTfBmK9N90HcgBEmcQzj9huZr3T+iQ+
	 kuq/OQv1829qZiHprK3AtZ/f/kCtKZB3R7cDIFyOGi+e567itjuvvIBf/dhOI7KgpM
	 RS2UWdqU14Cxk9hvbyR5U7e2GxRws0+lhXJ592O4Wx37JiJ9Y7hMHiKP7LTywNq7fp
	 cxHvQbdya89Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D83924459;
	Thu, 20 Aug 2026 19:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net: advertise TCP MSS from the configured
 MTU,
 not the learned PMTU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725422789.446762.4527576854549285289.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:30:27 +0000
References: <20260815070413.294559-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260815070413.294559-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 15:03:36 +0800 you wrote:
> The MSS a host puts in its SYN tells the peer how big a segment it may
> send us. Right now we can shrink it with a PMTU we learned on our own
> send path, which is the wrong direction entirely.
> 
> On asymmetric paths this bites - think DSR load balancers, where the
> request side goes through a smaller-MTU overlay. We learn a small PMTU
> going out, then advertise a small MSS, and the peer stays capped for the
> whole connection even though its path back to us is wide. MSS only shows
> up in the SYN and never grows back.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: advertise TCP MSS from the configured MTU, not the learned PMTU
    https://git.kernel.org/netdev/net/c/2640e6419594
  - [net,v2,2/2] selftests: net: packetdrill: add tests for advertised MSS with PMTU exceptions
    https://git.kernel.org/netdev/net/c/e5c8e301b497

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


