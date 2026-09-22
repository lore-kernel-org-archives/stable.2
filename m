Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3B53A3AE;
	Tue, 22 Sep 2026 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076082; cv=none; b=ss0NbtvJ9Gop+eFi+C+IEh/M/yl06ik80R6M/KCuQfBlo9aw/+240qH/akr9TLW3rnRqsFnNCpYh29NwBrfFC0ZoX5CHJxR7k5Dku3jtvR8Nt3wGcUrr81cGPDShg0MtNKRnzQtWz7dgsQuDhwlGXWMY1RU9xEYdqWGfrcmE9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076082; c=relaxed/simple;
	bh=YUWmM+DsV4ob+2InduncGBBmKEKv1bt9leCPNLWW1Lc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NxfpIvyUZtB92kySnv9h06DLr1/JZC3RRx2efTjSlhJmBoyFp2p81Cd8ibUDtBrGOATX6Z//9AM8KN1kLpZAIJ4+Cw4Muq94Q13u+JzNQ8Ttd9JYVtlYrqTpLZW4YMWmXbtS9yuosyCDEf3znsZ8gS0LGXxOPRVoSF6/Dyg8BwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h91nEVLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h91nEVLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787851F0089A;
	Tue, 22 Sep 2026 11:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790076075;
	bh=sjls2aJMFPzTgcnwmLIQcOJ6oSmVUO+bio+1mfCNZZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h91nEVLX1vj8UP0PI3ZdSeyn3kbjO4EzB+epLFhwnbiMu7MYjWKvuwxm8Cen3ToWV
	 zQ6iCyS+WEPjjOzA+qgGQ+6INRbFWiUin5iBkYAt2CRtsBSpCRG3kfpZDGylyZaxgQ
	 kXLIuKnuxsnll5pbCjWcQNpcGLE71Z52cF/BPzlMaResnUvGWo6iODJmaL2h91tZTx
	 sJOJMpXMB/li8S8Zv8S+J3i5k1+03apm6DJ+va5crBiE59nzcIQXcq7OK7EopgkmNF
	 7psnwJJCq6nM53nRwfGgDt0EMcG+kUhfyOMOFbP8ct4hKg0SVrTxwbNIQj6keGEZ2o
	 dLGXvMsHhqXlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D094E38119DF;
	Tue, 22 Sep 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: hisilicon: hns_dsaf_mac: fix mdio device leak in
 hns_mac_register_phy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179007600639.3566792.13838723236153887159.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 11:20:06 +0000
References: <20260917110828.2148390-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917110828.2148390-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Yisen.Zhuang@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shenjian15@huawei.com,
 yankejian@huawei.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Sep 2026 11:08:28 +0000 you wrote:
> hns_dsaf_find_platform_device() returns the mdio platform device with its
> reference count incremented. hns_mac_register_phy() never drops that
> reference, so the mdio device can not be released.
> 
> Release the reference on both the deferred probe and the normal path.
> 
> Fixes: 1d1afa2ebf82 ("net: hns: register phy device in each mac initial sequence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - net: hisilicon: hns_dsaf_mac: fix mdio device leak in hns_mac_register_phy()
    https://git.kernel.org/netdev/net/c/999e8295bc41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


