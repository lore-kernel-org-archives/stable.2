Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447017;
	b=XWQUwiIGhwD8IJ6J65Nbf0rO3tqwwoT6c+IUdjcvNTsEi7q9lPl2Ut7vP+kNWDPjIv89
	 9nKckwRnS0GocesnyLzwcvZ4MydWUa1/spcs682c5hHoWs5hPQmR6ysH8FBthpYt34vIv
	 Ftbx5QqR1bARcrKlpLlyJfnYBA4V/xhd94NSELQZ6XB7OAxTIxAqHEaV8gi6IgrDZIhni
	 j4ItqV/wwuzxK2fLLfXXIyquVAcTTQ98gr78Y9cpzfE/t5r+XmV6MlkYzdaP3B8YgTfkR
	 w/MDo9MfR/uuV97MC1Q4jmIaJf1X5grJRdpdRCz9sM2dXVq1Ptcgcgpza5qjf1YG4Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447017;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=d1ryBN7m25xIxhEAVtHnwEmc3pQTp6vGAygh4SVWUJw=;
	b=o/Uq7sHQkIDYziBYhXsdR0+pD9qypHGc2dbt2X4VIxW6CAeaQc5aPry4CS2XutmsoSEc
	 b29qQPFlfr6/xIxEMCXxumWXamX8OL6cVedCcDXytENFGpV6RSHZE0ENE54AIJaYKuigW
	 Co+EoAeRE7lLIFR/al8PGD63Ib6hDe5ZvU7aen+6lrXMx3+FPSbKPQBwLMC9e/VYCS3mi
	 h4KzuyERdP4mTowzfMrgzWy9RrxzRHhj1v01hdw1wQVg6HoFDVSB3C9s8Kt4uc1VESaNS
	 9erxbGsogfL7VmGuyIPBuXS12Ahh9KPPqsDCBsgiTMjU0YMShPycARM2kp7n4NbcS9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apfpXwSd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9D6074E66;
	Thu, 12 Nov 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apfpXwSd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B821F00A05;
	Thu, 12 Nov 2026 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447016;
	bh=d1ryBN7m25xIxhEAVtHnwEmc3pQTp6vGAygh4SVWUJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=apfpXwSd23atWyrd8dINN+fwFwGUn6W8zDWDPVL/N0b95KjH2YslQv7Wo+e6HGPYn
	 KItlcCGzuW/qf0TikuPdhNWaEHr0tgF22JczmP+eMwdpc8ut9HX9WdE4e8PAH2MTU3
	 5J3k2/SNka8hLhaE/IfBeiy6Pw5XkCN1x6dilMfyo9pdYE/jh1tXsuGyb6HsLCl4Yp
	 19tvFKC2XL/w1dudeoyaWfRIrCisapV8Gcq69pq3xw707Zxl+SBuHr37ymfZFaes7Y
	 mIQdM1dg4DLdPEj9hz23F/Y6IqvMrlurIUFlzMHA90aYFlX4Mfpo9QgGzsIxS0VVZt
	 sxm9bov/P0TfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B26B391AFCF;
	Thu, 12 Nov 2026 01:30:16 +0000 (UTC)
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
Subject: Re: [PATCH net] net: enc28j60: cancel deferred works on remove to
 avoid
 use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444701517.1753823.12338640917223292373.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:30:15 +0000
References: <20261107140649.3702472-1-hj351016@gmail.com>
In-Reply-To: <20261107140649.3702472-1-hj351016@gmail.com>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Nov 2026 23:06:49 +0900 you wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> enc28j60 defers work to three work_structs that dereference the driver
> private data via container_of(): tx_work (queued from ndo_start_xmit),
> setrx_work (from ndo_set_rx_mode) and restart_work (from ndo_tx_timeout).
> They run on the system workqueue and are never cancelled.
> 
> [...]

Here is the summary with links:
  - [net] net: enc28j60: cancel deferred works on remove to avoid use-after-free
    https://git.kernel.org/netdev/net-next/c/bafe532bae92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


