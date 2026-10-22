Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627807;
	b=rHaVsYEIkvBGeo13X7EBbznJnN1cfOqQZ3wopTZ+X8Rce9V2zB+njMCklqxlein8yiD+
	 tGYy665X0zubbQ0SNVyVLsThJgTKR2gXAJ3Ly1TOvFSJCi2Nnd7m7gVvTWRO8HjEbcerQ
	 bSCMqad/wYbP9/RpocgMpCWtC9sSGUxIWUHUWBOIkfRvxNSmqECGIsgukbVKdERGplabY
	 p5hm9p1Dc71nHuIHWG9j+xpsJKY0Ays42TLSNdY7dO2+qI01BAHzql5NC4L+LV9ATcEt5
	 0rg4l38nl7g1tZ+oxHNupQ89whN+DUdCjam8jvj6PW2T/pFKpz0V1kyfiXe5Ob7mcoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=HHAl1d6Kd+fQ0UdZyUkMWIDkcLOhCJfCqkZkHQ8ES7E=;
	b=OJQqrjRqoyd6gXPx0v4K92cfgx34rUDFbdSBpNvUZg+BDhgHXag9P999Gxrug7U3Y+xn
	 s3T4BDQN9rq3pS7TpSU6LgkgYPE2/5INIiezBO/NGMxagfbOmv1oRLvkjt3+ZLhhkBM8C
	 eXN0r9weuRq2JkGDH5U0HKWiHgHh5mFW0/wIUUQW6Kzbt0Gw/XoXEHs8FPOP0s7F/1sDD
	 r99pIh7bcmVdvzc3sy8zK6elqP3Je6bHytFvsPw2kJWkeeOSCx8Am79OBmaAJ9XI/Z8BH
	 cHms7g0HibGDh4G2NoyAqOc4MWFd2vFtB35pds8yQpXbJ9LTFG4nmoEvY9GRFZrgxXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bksz2Na3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D61606A31B;
	Thu, 22 Oct 2026 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bksz2Na3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082A31F000C1;
	Thu, 22 Oct 2026 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792627807;
	bh=HHAl1d6Kd+fQ0UdZyUkMWIDkcLOhCJfCqkZkHQ8ES7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bksz2Na3KHmMvUfrZxEXMzPCxDEEPdL95+hlZfS6D0Rnori8Eaqr9yurVTD+B8Zg9
	 U/iMdsRUAJlgU6GgHEWnkte69uDttJCTmyb/rXOdnXySOz+wf2bPgsN66CmdMvFT4P
	 6ooYU7oGMYhOPSy5YuSZXO1gAdTaiC46rw3vtPFm9vMgi2DWjvFodPTtYPkWO0aRkF
	 Yl0euvS5mCKo1omWM4Y5Yn9YZ6Pe9W1TGh3MfVepHYHo8Qoh4aUAkpq3Q2ENrexmk2
	 JKueCvM/4CWkaoyGjz3vvdLEHAMeZVovNmYJeZPOZEspZBBoSdLPH6C7adfTtBgWB2
	 pJLp4hQCJbMPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1477380A963;
	Thu, 22 Oct 2026 00:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262780578.1374404.12449019792107487021.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:10:05 +0000
References: <20261019060430.33254-1-kmehltretter@gmail.com>
In-Reply-To: <20261019060430.33254-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: netdev@vger.kernel.org, s-vadapalli@ti.com, rogerq@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, j-keerthy@ti.com, haokexin@gmail.com,
 alex@sverdlin.org, arnd@arndb.de, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 08:04:30 +0200 you wrote:
> The legacy CPSW driver registers its netdevs before requesting IRQs. If
> a later IRQ request fails in dual-EMAC mode, the probe error path
> unregisters only the primary netdev. Devres then calls free_netdev() on
> the still-registered secondary netdev, triggering the reg_state BUG_ON.
> 
> Once registered, either interface can queue rx_mode_work through
> dev_set_rx_mode(). The error path does not drain the work before devres
> releases the netdev and its private data, allowing the worker to access
> freed memory.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: cpsw: fix netdev cleanup on probe failure
    https://git.kernel.org/netdev/net-next/c/6acb220312d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


