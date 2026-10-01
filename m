Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F854FD292;
	Thu,  1 Oct 2026 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812814; cv=none; b=p6tl7V881cfw2EtSJ8QlJ+jPrhqqjfMc9yypFNXXshuuTVWQnZ10+X4O/fNS/WWHWmlCymhnJLE9VXnnWzU0SX+RvrAIACFA16eK5NmrpYk08AjE6WYk7no6+lLaJlgaN4kVOwP1QtcSaqWZTomMwjpMA4ps4pCWj/3JdXVA25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812814; c=relaxed/simple;
	bh=vMLXNZBW6nTdbZEXwzrav/arTlUDVQZVDGZvwT/hj+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uTMgHFvxv/GbYb3Rv5nFjJcfATsVdPtJF2kTh/ZkGuExQMJ9QRK/FcWafl69lubScAhwk8PIbAXdJKMiiuHjwnXe6Xm0VoMvyZ8BPhIrrwDxkos5tyJ1kGyTUfod0wCg4RblkN8u8YrcBitn7+NTaQ6Vo6HaYcz2ox6Gv+f5774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyV5aOto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyV5aOto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF881F00899;
	Thu,  1 Oct 2026 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812811;
	bh=cgp4s+cXj4zAn91cYbbDDtwTCvHsmGb6CLljxkm15wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DyV5aOtoPVCRrAm0a8pPS4sSzS1VlWjp5MXhwVqAFTOKqbOZkDG9cQXsngt2I8b0y
	 HDRSRqbyNRa8Tuf8Ox7nM6JCOg3LTFACnwBKAD6bFF64HeigzMQoV3lGZpvUgmslRm
	 a+7sIbFEweNsuNt36OCUknHsgkLv0DTTwgnQxDyrUZ6xJPgIxZ3qO5PFDOeq6KxKbN
	 4bQsRXsgjWTD6U9UXS6nMDIKkiszYdC41QAsqN+44TXbGYbnOekoxsMx42KrZT6FrG
	 YfkXNh3JThkEiQ/6T0XVOR2BQuafo7L+gkC1ZAxtpRK/LQkksrAB5gubIUdJn+9Jx7
	 WQgEYiAoTFpPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44A03AA6A61;
	Thu,  1 Oct 2026 00:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: init workqueues before register_netdev()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081281028.2182141.10765407391197004447.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 00:00:10 +0000
References: <20260925-macb-netdev-register-race-v1-1-752f90ce1c39@bootlin.com>
In-Reply-To: 
 <20260925-macb-netdev-register-race-v1-1-752f90ce1c39@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, stable@vger.kernel.org, sashiko@sashiko.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 15:15:08 +0200 you wrote:
> register_netdev() exposes the interface to userspace which might trigger
> operations like close on it. Those access the HRESP/LPI tasks and
> might therefore use them uninitialised.
> 
> Fix this race by initialising both `struct work_struct` before
> register_netdev().
> 
> [...]

Here is the summary with links:
  - [net] net: macb: init workqueues before register_netdev()
    https://git.kernel.org/netdev/net-next/c/0ac396fbc25c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


