Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141806;
	b=P5MH72ZWe/cT6B+cxaETlr/q/auOsbdSQTPJS+PxhjITYLjwf9ZtRyahB/5imu2l2UoH
	 hcGBeC25PPf7IuYARpY92LyczLKQgl+aAJTvXQf4w3mY9j4vGE3M6Ihpk/RH1ff953t+n
	 lEOyGuIT3yseYO5orDaE2lfvY5DpBe3UvQ9GvHfB86Utt/xNCPjnpTo87ca+gEbvM709v
	 FbS7bpm0eEKVCMatAs4Y6BkWJ2LyaDMCWrkgE5lJXS7khqckzzdOc0k5YYW5NevkNbufn
	 AJo/ey2iNAnxruQofSIIUr+X9F8jjWa4o4W2o3yPsWEbeIqSWIIzf3r1ya9XMQxCDHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9qUIPmIYPuUTwrmfhDJvI04x06r49CpjuUWZ05eJ8FQ=;
	b=a1S00IOGEjzpERfETf/qBpGHIlGJFEfSbMOmWBcTxI1WbJl6SHeH3wdFqCIEX9p93t/i
	 W9X0DIF5WzqPRWUfjSgYC5oCP7+zefl+JlOWR1GZfg1xnv8x+Ke240AfRBASQSUenvDSR
	 N/UmrL+yHkZUpl7Sv27mlD+1q+JZAOleb/NnddC6JcutyK50OkPaB6XQsXfzyULS4FkD7
	 Mn4PNSCj9ILGt8quhG7hAZRG27KVoWKDRNdUIuMjKmt+5JtyMymexBUHqZbO4B6SrqXEL
	 Hm0wyoJLcZCalrZydumOAyKSxg9hk3pMP5qEe+zusJh6L0Rjb/OVMxK3YiGsRIH+J7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfN3iCcq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1403606A326;
	Fri, 20 Nov 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfN3iCcq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0602B1F000C4;
	Fri, 20 Nov 2026 02:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795141806;
	bh=9qUIPmIYPuUTwrmfhDJvI04x06r49CpjuUWZ05eJ8FQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YfN3iCcqTm67hg4w/R2O7jdCBWY4Wuylhaw/PjnRiT7VQdB8His/XoEo+xEHXfxh+
	 LH9NJTixNjHGGYzJmHuRpEudl/D8okWWoA3gorE08iQAiLy3M79guRRa1phXNN6vdy
	 yse7qxaevsM5vTcsEw+kCf7ZmbYyf3RFu+HIKu4jY/rWp3OF//0CeNMFj5vF1ovwT3
	 rgwevLWZzfdfhI2GVOgrl9kVLjSqRxcP5WcVbwE0rC4pmPRXnzfdPS+VCeqv5ks9Wz
	 3+EgXMGKQo4bAuiVk8PbIwd/tASyp/UEUrLj3Y/iGnzCmwKkac/oZR0gOR5NZATzhZ
	 7AD+UEz7//k1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14503808209;
	Fri, 20 Nov 2026 02:30:05 +0000 (UTC)
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
Subject: Re: [PATCH net] l2tp: reject short IPv6 address attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179514180478.3985754.2418266134106801172.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 02:30:04 +0000
References: <20261117092157.85513-1-hj351016@gmail.com>
In-Reply-To: <20261117092157.85513-1-hj351016@gmail.com>
To: khj <hj351016@gmail.com>
Cc: jchapman@katalix.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 celston@katalix.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Nov 2026 18:21:57 +0900 you wrote:
> L2TP_ATTR_IP6_SADDR and L2TP_ATTR_IP6_DADDR are NLA_BINARY with .len set
> to sizeof(struct in6_addr), which only bounds the attribute from above.
> l2tp_tunnel_sock_create() then copies a full in6_addr out of each one,
> so a shorter attribute makes it read past the payload. If the attribute
> is the last one in the message this picks up whatever lies behind the
> skb tail (stale heap data unless init_on_alloc is set), which ends up
> in the socket address and can be read back with L2TP_CMD_TUNNEL_GET.
> 
> [...]

Here is the summary with links:
  - [net] l2tp: reject short IPv6 address attributes
    https://git.kernel.org/netdev/net/c/3bf0ed569563

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


