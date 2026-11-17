Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927006;
	b=bh2ErS3YyGAKeyH4OjvzjDAwBZeYVJADWNnDiYb2NaFAxAOoBjCBQQ6+A892OF9hf1MY
	 qa83Lfu25aTRPrSqTldngPLvaBQi9O2y3CUb7HEJPhhR/PS/bc/zKUTylZZeow0v1VHqv
	 ZFZlzuLaZWdTzO1AlQcTHdyvf3Y5qbHyQS8yfTf5R9eujPZ6T35qpAN74KHmujAZaNNB4
	 mlTt+9urcw+dg5jDd1z40DP7SHBO1Z2EGVa7HB2OLrke6/g1JIF422XILCXTP1pcu5mj8
	 zjRA42GfakH428eK0MsXuJeb604mGcqAVbYlumO/fYnXjWxqDXS6pmQ2X8970guQdsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9f/zHcLvxWtQu21XecKTcghtz6+6bj2ttB2w08JqT4I=;
	b=nuH2T/YtDvtOq8sT3ToHJUooJ3ku6aOu3JAjl+ju/YZzJml1QuIW9R6cd1yK0pCKmibw
	 OYS04+wcPqH6dP5d/fU93DDXkaiCiNijyBM3HeVOONMeX5N75zaWQ2hLjDE/3Vdb73ss7
	 mqjIpGMqtpIRIjIoWmr7NsY91u0m17pkIo2O3LhCC+DbXWEGW0yFiFjVs1c+Vb6CwDM1G
	 CPsALdN7pVFDvJBwmJI+jdIXuChB5YO+iqlD8jc+VFLM2RUQL8oBoBZZhJ8HrHxhI3Ibm
	 U/eCcx9yUCEB0xiFucfTQFZGViLvH3S/HkqmNCsiUXhak4ug8Ok+ZdZrkgXfiB2bEYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aigczfsA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F9606A323;
	Tue, 17 Nov 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aigczfsA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C8B1F000C5;
	Tue, 17 Nov 2026 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927006;
	bh=9f/zHcLvxWtQu21XecKTcghtz6+6bj2ttB2w08JqT4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aigczfsALaWDHs09gJhyZVzsB9hidXg5hWYHJu311um3SmJ3/hc21RlfMJav5wK86
	 l8eXI+7oO9+xCRJYjNwFGGIWNTYi8ilyJqFSNWRMwZKPjWhUOfMPhth+mRQxN45Z9y
	 KnmJT6RhPhv4YlEBR5u45lWucwcDhbPt9c9cMtHo73ivEubo5hshVXeafnC0BlqlUE
	 7Ho/7uLNbH8Pc291aZdpO0ROOLhbZOsgjp7Oz8LEcZRxUff6u0MOAIQNtzmADZ46c3
	 TdiPxCvGaPco1jTxeCJaDZuyQhkD3lxMXlWr21R9E3Loy6VU4ArpCeGbH3JSZIBZjO
	 PbjyeP4pZKxtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7761B3927056;
	Tue, 17 Nov 2026 14:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net] net/tls: serialize context removal in
 tls_device_down()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179492700528.635190.1108444356171254276.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 14:50:05 +0000
References: <20261112043209.102404-1-lee@jaeyeong.cc>
In-Reply-To: <20261112043209.102404-1-lee@jaeyeong.cc>
To: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, alice.kernel@fastmail.im,
 tariqt@nvidia.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Nov 2026 04:32:17 +0000 you wrote:
> tls_device_down() moves each context to tls_device_down_list while
> holding tls_device_lock. It then drops its reference and removes the
> context after releasing the lock.
> 
> tls_device_queue_ctx_destruction() removes contexts from the same list
> under tls_device_lock. If it removes an adjacent context while
> tls_device_down() is deleting its node, the two list updates can
> interleave. One update can then target a context freed by the other path,
> causing a use-after-free write.
> 
> [...]

Here is the summary with links:
  - [net] net/tls: serialize context removal in tls_device_down()
    https://git.kernel.org/netdev/net/c/81c8333141b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


