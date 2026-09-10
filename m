Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6873DCDAC;
	Thu, 10 Sep 2026 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032068; cv=none; b=CLrNmN6xijp6kaNVbHQUylMqpRCRK5u5q/gjIEo9GBvtlBcpQG0XMWrQIyiUqHrtZYEVqMTgf1lEbUB5fwm2CpxuupqCmQoEu2knSy2AeoXbtWTCM+MKaXNdhDsf+f7cjxd4LusHJosflgU07Bx3PRTSqIfLHm/uxFe3XHdDDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032068; c=relaxed/simple;
	bh=MgIXUlh6J+HX60OwQMh9WWMGKG1u01IwmlPUBS0zqgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NtlN8qa+4NUv8MYY+W7Pu6NAmjHwvNtndnvB09QYDsGUn/MHd+TNPZoKSG2Pa+IQRpaFrVs0FLrt9KLN72t3+VMSr8uuTSrQti9vdXUwckXlAjZr6OTqrO7eRDKB+TqVdDkzpTnskOROn0WpL5mTCDIgSEpjqf/XoA/64uFyp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDMhDIpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDMhDIpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4191B1F008A0;
	Thu, 10 Sep 2026 09:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789032067;
	bh=DhzjVhw1bgk0+xVzEvByhtJ/L0m+GT7klyyGOOlGhp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PDMhDIpFPDx/DMkIX5z3tp/qVe7yO2LHUd2/H9RGYkuufVS3MnQoFiQsaMYGQ+hne
	 Ruz6jMepv8AglviZLmjtPFmnh11cTD+Is2H2/objeXbM9tTj3deJE8CfOfCvlsqbpW
	 0Bt7dse3QybLLp6WVfdJZ9EvE9uXTpTKUGsDyBXbPLzpQIBC7haSSyEddV5d9//FGf
	 4ag1ZiJ1Af4m89e+Fdtzxa3wh3CayNQ9NaK9rEwqnORxJ1NwooraQ2dRmry5VjWgUz
	 L96iDQzn3cBEIB5v1AbmDjz5zSC8mTifagsDV2zOylVyRH5aouEgo01aEBRF4iZuLX
	 BYfxk8v7qXKDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198CD380CEE4;
	Thu, 10 Sep 2026 09:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hso: fix TIOCMIWAIT race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178903200489.1307068.14362741473864452441.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 09:20:04 +0000
References: <20260907065235.100848-1-johan@kernel.org>
In-Reply-To: <20260907065235.100848-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Sep 2026 08:52:35 +0200 you wrote:
> The task state must be updated before checking the wakeup condition to
> avoid missing a racing modem status update.
> 
> Fixes: 542f54823614 ("tty: Modem functions for the HSO driver")
> Cc: stable@vger.kernel.org	# 2.6.29
> Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: hso: fix TIOCMIWAIT race
    https://git.kernel.org/netdev/net/c/00f9fbc12320

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


