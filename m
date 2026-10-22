Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629015;
	b=xLAWnUduyo6tF69VjcMiCbWZ/eLQnOVeMdO8tV7bO0TzkSsY+mQuhf45751hjJHam1vy
	 0L2Pc1TL2BuInRBCaFUz0NV1pLU1qE1d+eLA367QHVybT8OLbyk/EwS1Q/EgnXH35WvtC
	 4zlZw9WPUGVkYMN4c8w2xy+hrsTo3rUF8L9hk6lWkVX2u2qBmJ4m5i3cfE6zgawr37fqq
	 LQKOxNnTwwklCN2+1StnetHQxHIg+qcUfdx2nNfOog6K/Pi/qDrtxA0sn0K7gU5U2YIHU
	 1O0imlpuySHDHLD7LAj5UjPHzGEAigkHKGNf+s56IobfXlHqktwEfx7HWJWsDvj/+Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629015;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3mJzhrpoxuYrCmmHFAca45B8JBZuEIGuuX3tUAue25w=;
	b=AQZc1KyJTHGRJ9NRBHmGlM+M8NDDZjM1nId/0gEk7Y4k7sXX9Kg+j365T6PIYSjPIZ+o
	 bJqlAebmtRpXTxfqdS7Ke/bd0sylfR3i7yPT33SYr+if/ehIsnJi2fLEYo4R9gjWYs89g
	 lfiJUDSViMBVbQqMuFAn4+xuvCRl0k/lEXbQmAFTglDS02KEJxY0ojFhRMl3KOojyhQr6
	 ByFSE4SBQHD3eWbWO+ewfKzxowlKZg1+R+R10jQFEDRcaOEVhz3fKHBdrL8fO2u1NsFJE
	 kEhba0f/GrSkssy1rESLCC5JB4DBybYByJmdYaP226SQPu6mlZ/wOtswtaui6yLnAvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkLWnI79;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7CD606A327;
	Thu, 22 Oct 2026 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkLWnI79
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E8E1F000C1;
	Thu, 22 Oct 2026 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629015;
	bh=3mJzhrpoxuYrCmmHFAca45B8JBZuEIGuuX3tUAue25w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HkLWnI79onTJmrX11iYHjKPBesf/qdh667Qd26q0HmwkwmQ0T+S1WE1MtGO9EEvUC
	 JpKkBLPGiRBghm3U5cy1jJ0UoueVLHDEehor59RQ0wai6LJz7vcWWpiS94ajUkaj2D
	 qB7Ej0f/cI1s1cDxOh6KfQDWeEvSfQyojXEfeXpJM+zlt+NNrx3AMMCqq7cqKwm58r
	 EHx/hi7qV1m5wU/8SD+STMKaGaj3r/Ih5/xaoP7r4ch5bcARY4rPnrmWprjWBaMT3t
	 tlwul6FmRCokTV06wYrHCNOf91JGh5aqVgAwcWLyGOIDcVlZN/sdymvKSCrGjeJY3A
	 9pDel8g7fV6NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F147A380A963;
	Thu, 22 Oct 2026 00:30:14 +0000 (UTC)
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
Subject: Re: [PATCH net] pppoe: delete session hash entries by pointer match
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262901348.1378903.6285875327252867524.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:30:13 +0000
References: <20261020092118.47416-1-qingfang.deng@linux.dev>
In-Reply-To: <20261020092118.47416-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, kees@kernel.org, horms@kernel.org,
 manizada@pm.me, ericwouds@gmail.com, nbd@nbd.name, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 17:21:11 +0800 you wrote:
> pppoe_connect() copies the requested PPPoE address to a socket before
> attempting to insert the socket into the session hash table. If the
> tuple already exists, __set_item() returns -EALREADY, but the copied
> address and ifindex remain set on the failed socket.
> 
> Closing that socket then deletes the existing socket's hash entry
> through pppoe_release(), preventing it from receiving further session
> traffic. An unprivileged process in the same network namespace can
> trigger this through a duplicate connection attempt.
> 
> [...]

Here is the summary with links:
  - [net] pppoe: delete session hash entries by pointer match
    https://git.kernel.org/netdev/net/c/b5b8c81836e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


