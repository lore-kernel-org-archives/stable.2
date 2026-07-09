Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C558410D1B;
	Thu,  9 Jul 2026 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595431; cv=none; b=Y6cRiI8xJHHFjgj0kkrS+IbWz//fjbMkFdGV0jFxQEoOs7BDep9MSivq6UYCB9hIGvS9Vwk2Z28JoyKLPjr/udAd/fDNFs6jh0mpJGwBteO0rcAHvge7aJ9ZknSeRZws+QiGCE0isoJmdxoK/CbtfN39ozRc/J4itGfTGR4knoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595431; c=relaxed/simple;
	bh=lj5OfcP3DHUXxKqVwSlAI50qcC8NiQQgbuP0Gh4p4tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RvhtwPR6K7tWXzVu0RWrkMHy/Z6uOaVBVBqnlS0voJhemsQol8XGaWtc6GMOp5rql1vhBf/U4uC/jv957yv6qoyjxIALV3lqb2SI3F9tG6lFSD4+meC92XwudND7KB1LvrRHWXB5wfcdJecLOGB1KlKcxydT62ZKaTRWghqIkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTJhozGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTJhozGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B491F000E9;
	Thu,  9 Jul 2026 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783595430;
	bh=a9u5EznytLjmKdbk3xY/dNvQ6SNeDWINs/4QAuUSQGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nTJhozGL/DeGhpa0P10b/BS7rKxzv5nY56IUTsJqT7Q+v0Z4DZmgup0Py8TKTSDxh
	 LMH0VlG2rr5/IwQ4JiTwiIqUAmnGpRcO6bvsAG0BF5kbG7jFalhb/f5gxAo9w4bZF6
	 xM0uH1u8/yuy6UU+AUEr8SEA90/Lc1/LyiX2zVOEJ6uU+myRi2BwugqpHOTwz4vvQs
	 uWHmIEXi6sPzgXeW9pk5SL+SfC5vuDLp88XkOxPYneY3ZsHDLbJm34Dyf8CEYAxL5X
	 Z1hTG3TkRPehmL6vZUi4+v9UFLIRBHfbpv77dt6d5u/R2lcL7WuJ+n3uLiRY+XcLKy
	 cxuU/Bx4G+HHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1A11939EDE30;
	Thu,  9 Jul 2026 11:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macsec: don't read an unset MAC header in
 macsec_encrypt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178359540864.3416587.11485245520244646782.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 11:10:08 +0000
References: <20260703083634.2035145-1-4ncienth@gmail.com>
In-Reply-To: <20260703083634.2035145-1-4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jul 2026 17:36:33 +0900 you wrote:
> macsec_encrypt() reads the Ethernet header via eth_hdr(skb)
> (skb->head + skb->mac_header) to memmove() the 12 source/destination MAC
> bytes forward and make room for the SecTAG.
> 
> On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
> reaches the macsec ndo_start_xmit() with the MAC header unset, so
> eth_hdr(skb) resolves to skb->head + (u16)~0 and the read is out of
> bounds: a 12-byte heap over-read that is also emitted on the wire as the
> frame's outer source/destination MAC. KASAN reports a slab-out-of-bounds
> read in macsec_start_xmit() on 6.0; on current mainline a CONFIG_DEBUG_NET
> build flags it as an unset mac header in skb_mac_header().
> 
> [...]

Here is the summary with links:
  - [net] macsec: don't read an unset MAC header in macsec_encrypt()
    https://git.kernel.org/netdev/net/c/f5089008f90c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


