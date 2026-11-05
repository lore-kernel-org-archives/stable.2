Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887814;
	b=mW7Yg0DveTCNzdt+hlfyjK8xrSEuS1bJy0YsDuXSa1HyuoFf6LYXYx4tY3k/RffFYvbJ
	 h5BzR0KNyQam7bvUd1aBvu0Cta/J4EvpgZGVN5cNL8Z/Zf2r61uFR5Jhw4VnLuWtudhxi
	 JDzvLd9hzsaP3wFgHLSknIqj8MJsmCkqDkYhv45aK4KDDloRYeWMfP4fbbXX5u97stpF3
	 +WL8zcZ/eURXYQNoyzJc0pFF8SF1ZGSgw/uqe03IDuQ4US4uSSOz6UUJsfvYyHLLHFM5w
	 NJBZ6VJGZMYDfkajHfvGrsSJCEgz8QyiTCtfuZwjp3AyaaJs2AVh41sI0z/fUMSSl5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887814;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QimVwv0cZRzNP0rWP38GJwNq4IJRHfDBqqjVo+ay0uI=;
	b=ZPyFJ413QvtnD75FMUXQx9K+jeQh0TMdKtL8TxAr0w8LiV483aTErwPN1mLYlKSwOHUJ
	 Hb8bb+zfehcoPuSztwvCA7siUU1VpCzV/ZDwRkZhQiWTIwNFrTCYxT0dEGwq6gUjnbAML
	 PsERbDlZgWSUJbPur4laDpzz0OE7l7jTAvjdYDIdqJhOBJ6PKR9ZMni6nYa0EUZxXSA7f
	 CVj21vNw3MbtNyOjz69RyvT6rNLpAJrJv0owvYYyPQMoy0dH/l7cTcIzk2OMPaW8oA95y
	 UMSob6MvSivDawC6K3dwlegUw240JuFAl08E00WJDmkPltifPRB/fXsOSY15OE5oOPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T09ksnn0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA2606A335;
	Thu,  5 Nov 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T09ksnn0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53B81F000C1;
	Thu,  5 Nov 2026 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887813;
	bh=QimVwv0cZRzNP0rWP38GJwNq4IJRHfDBqqjVo+ay0uI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T09ksnn0eTMR47JKPUMxF7caYMwBTlbHrza/PmxlFtHvSssRlUJHQkwdpbU2Hgrs5
	 qMRsdIjBmTGmpLILPDP4PAQsQju/317vpLB+UMlSUb/a/03VOuMVwS6+2d7o4Gr0h3
	 4gESMjUuVwP5ruaU4eSHVk7Yxk9HyJe9sH5Cv7VXJJK4dQ9OiOOp6IRZenAfWHfMZH
	 mPkKUZsDkQQgBky9dAUZh4dxjeLKOHYHrBLVBvFIenag/SBXTmcTJCNcQLlgB1MDF8
	 4RoLLT1ayKC9/CS7+aSlUbxj3RW0Toj2ltva6enbYe2gkThUzagnDovNEBRTnjST4r
	 rrtb2ZWCPTRtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2CF391AF93;
	Thu,  5 Nov 2026 14:10:13 +0000 (UTC)
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
Subject: Re: [PATCH net] dpaa2-switch: fix port cleanup on probe errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179388781230.3729553.1879674785281037488.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 14:10:12 +0000
References: <20261102071310.3004332-1-lee@jaeyeong.cc>
In-Reply-To: <20261102071310.3004332-1-lee@jaeyeong.cc>
To: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: netdev@vger.kernel.org, ioana.ciornei@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 02 Nov 2026 07:13:18 +0000 you wrote:
> dpaa2_switch_probe() reuses i while probing ports, adding NAPI
> instances, registering netdevs, and unwinding failures. Consequently,
> the value reaching the port removal loop does not always represent the
> number of successfully probed ports.
> 
> If IRQ setup fails, i is left equal to DPAA2_SWITCH_RX_NUM_FQS. A
> switch with one interface then causes the unwind path to access
> ports[1] out of bounds, while a switch with more than two interfaces
> leaks all ports after ports[1].
> 
> [...]

Here is the summary with links:
  - [net] dpaa2-switch: fix port cleanup on probe errors
    https://git.kernel.org/netdev/net-next/c/0822d2fe3826

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


