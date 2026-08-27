Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985143F4CD;
	Thu, 27 Aug 2026 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826077; cv=none; b=cRPGOBFb5x3xHpQRI8LhcJN9+bxM6vwUO3BZoG0ZY7CBW//8Br0beZEbS1+j5vH0gIcRlFvQDF/udY4Q5WLN1ZjE2msBPkVWu52/g9ssfbm+f3jc5hp5wc5KfARI96yG8OMfbwiOHGbGd+Gvm9dP4dQGMG00lInt6wtp+ngqr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826077; c=relaxed/simple;
	bh=kvaXaBPufC2M3Y5zScKMAffR58jxDKGRLR7yYkWWMFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bkjHIPrvAx4N672gShZ5ayYLVxoysEXGpfIRQ2il/nWevPSMImTxeFszb59rWrzWmEyVLhO5itcIoJ29d2XLbn7s/ynRpireTUO7QORl9fsbozeDCmcbpmM8RBlCGTkJ9Sl7eUI71aqWGssCuiku/eZO5zSXD5ABUhS0iZxLFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgqh5CBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgqh5CBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B01F00A3A;
	Thu, 27 Aug 2026 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787826063;
	bh=sL0WV2olcxl3B+LDat1kzlei652RQMu3rzjmysxkP/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Jgqh5CBmiw60G8haLaO/iEJCsfqXOq4RMurEWHzuapgoImG9GzAho21Ge6x5S9otU
	 QpfY+u9cY3z2YYa66EPlxOATtviDmAL0t4642yRmeeSrfVzJpyCwG+lb9+WrCErG0Y
	 nxKXZo7qTd0LjAZEBZljjwiHIdKQPLGsO/5PaHVzjErDXN3ea2QkbpW90iGEabeV6/
	 8Wr/r+guH0IQ4v3Uzr0kBYLPaWU5yJHs6nrCaSLN/AkfSkBaIcy4ey4uN56utolge3
	 Ut5AXjQUmkmy8HqXqB0dBujkFXFeWfo8pqPowdSGIw5qFozMqnYWYDUNpJUCuaS73O
	 FKi96nesgOWfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568CC3809A18;
	Thu, 27 Aug 2026 10:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tcp: fix AO info use-after-free in
 tcp_ao_connect_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178782600890.1149245.8761678837967015853.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 10:20:08 +0000
References: <20260825072033.6921-1-a0yami@mailbox.org>
In-Reply-To: <20260825072033.6921-1-a0yami@mailbox.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, 0x7f454c46@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Aug 2026 15:20:33 +0800 you wrote:
> tcp_v4_connect() adds a SYN-SENT socket to the ehash before calling
> tcp_connect().  If TCP-AO is configured, tcp_connect() first verifies that
> a key matches the peer and the bound device's current L3 master.
> tcp_ao_connect_init() later resolves the L3 master again and removes keys
> which do not match it.
> 
> The socket lock does not stabilize the bound device's VRF membership.
> Detaching the device from its VRF between the initial validation and the
> L3-master calculation in tcp_ao_connect_init() can therefore make the
> validation succeed while initialization observes the default L3 domain and
> removes the only key.  The subsequent AO lookup then fails, so the no-key
> path clears tp->ao_info and frees it directly.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: fix AO info use-after-free in tcp_ao_connect_init()
    https://git.kernel.org/netdev/net/c/ea30dc5267e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


