Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446007;
	b=e2RrEfODueod9b76blTL68AfS7hZr+ncFO2aciBs1Mt+l27HXZBFfucrjMFqZ9c020Aw
	 KqJUqlQhviOUsBQySzS87U4VyLoKnWPapkTT7JMjy111GaR6054TXEqnszILIJxyvfsQR
	 ZrjvfmW9vses2Wdpzqhw1w0YR+WhcP+XCZK3aAn9t96V3di1wTA/HoAfpsxzUofahWNzh
	 4vvK7QdK2oMIrhHnC1XKy8tl8SF8QL2fJxJSnikGPAtJOY0vU1Ugq9cXZyTyNwI5BLae8
	 i11FaV2fkXVHc9a9ub0P1yKpF35Zf25i1Bcw5zoQfAs6nNrVicrdWnuKgInza92QBmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=H6E/jkmzLyWVvfOAsLO4im6SCcZEX4bZlh8TxnnXRC4=;
	b=tYV9btcpEmudJSHWxARTUCZbLp5PToiOMXz5xkVkysygBkUzMyzpSzVsgFXVxOtwlaHQ
	 gYWX89dVrgI1WZM8DZtvnhaknTWvY/0nJywoKMEPLRZd9m68eaLdVN451V/vMTHnvAL0t
	 WGdD2B0+mOkt5XCcVFeF1XLL5E6AuKtJJc9ViRXdyqp0C1jJq8Uo9NS+99KpP3Jj/TbY7
	 FWRXwaD4SLP9SWefg875yY+W5G2C68n8+HuMTMoBUyBwj0wfSlRbFD1BznxqTbwZyEvhY
	 ybjI3ZsT4aU3jd3D5kLlmXHayS6adwV3WgHosjLl6x9P9xKlaRl7v66pa98FQreN2DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R60Fl+tY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16F606A32D;
	Mon, 23 Nov 2026 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R60Fl+tY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8445E1F000D0;
	Mon, 23 Nov 2026 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446006;
	bh=H6E/jkmzLyWVvfOAsLO4im6SCcZEX4bZlh8TxnnXRC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R60Fl+tYwITgqYgBPe4X4nnK1kWkFZuB/vkyYtTLO2LhSWW0IcPfYKf+FqL9vTv8B
	 QSK4Ht39YCfTW5e5uXso4Qeyx9gojDxNP1cQhekEmV2AmRvlAK4qCqKOXsaW6+dSAP
	 VDnD0yCFWfOcxwmsa04f/+TPUrEOVLcN8huZUvMaSLSunfs12OWpBVqAqCTyjpF7D/
	 Uako3MFoYx0TfkAWYQZUukw+FRIh5cS8fu6ZN5tVgCfgfkiN8c+Rbz+0OX0rz2IErP
	 Sb52rVDzGRYHHanyhEoLZynEYGUzcLBpdeUWbO2Kd430ENR/+OexAps3JRKe5Kfruu
	 DmcbBye5VXohQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7749C392EDBC;
	Mon, 23 Nov 2026 15:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net] net: release netpoll dev_lock when NETDEV_PRE_UP
 vetoes an open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179544600502.2443681.1409220130904920815.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 15:00:05 +0000
References: <20261118-netpoll-preup-veto-v1-1-7d3fdf101d3a@gmail.com>
In-Reply-To: <20261118-netpoll-preup-veto-v1-1-7d3fdf101d3a@gmail.com>
To: SeungJong Ha <engineer.jjhama@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, nhorman@tuxdriver.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Nov 2026 15:27:44 +0900 you wrote:
> When netpoll is attached to a device, __dev_open() takes
> npinfo->dev_lock through netpoll_poll_disable() before calling the
> NETDEV_PRE_UP notifiers, but returns without releasing it when a
> notifier vetoes the open. The next attempt to open the device then
> sleeps in down() with RTNL held, and every other RTNL user blocks
> behind it.
> 
> [...]

Here is the summary with links:
  - [net] net: release netpoll dev_lock when NETDEV_PRE_UP vetoes an open
    https://git.kernel.org/netdev/net/c/a233b32f1a12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


