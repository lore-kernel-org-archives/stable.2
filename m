Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE723394D;
	Wed,  7 Oct 2026 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336007; cv=none; b=uuJ1s8Bd/1t0bxy/3dRGCzexQJlMetRHVkvfHeSejN1q/2PGIxBLvL74yGhwEwA2TxsZyT2pDwrrxUzciQMdviKS8y6/qO8+kKICXVypOVVQUzeVH00FQEe1iTtuwbG+cp7R7UTzV86hr0bYmhKGhXBzB/RaHn6voXlAyofiUUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336007; c=relaxed/simple;
	bh=sPqKzW7EXdrhU2y/nZySIhOtDCR30MECad3/SnoPBdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dSmeszsfd5emaNVAdFoVMQs/Z29wQbCvg6+hco1Mx2lXq2x3uSfSbAdQuhqo5K/w8weHDaODRkIp0qnpHLs4srMrU1w6ONUro+dQyGN9v7qfD3ooAuovTMCYEjhkkM6vGZkaUBUM9rc7nrRLGjqzGzESQ/KX7mgzCJnoVQSf1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeIpuNzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeIpuNzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2511F0089B;
	Wed,  7 Oct 2026 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791336006;
	bh=3prIrymvBNTMW1sX2+jDJgpCgI4QCmk5VEQvUPtMe8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JeIpuNzxFn2VkVZS3R8BEinooonKU5G+DX5LQiFSEaedYYuOhK1ZZtSJPXGO/pUkD
	 th4i1/I8oocyuCo3q33pUlcGDOwC4zZVM5U+725IrrgUxSNxPZcN7hbmw4H0hRpjNa
	 +RZUrgz82KRIFZxaOB0EpjdxQxQaLlkec0WGoHlvggKF5x1IhNVbbkV4auQk1+kRLx
	 6P4g16R83olkklX70bElEA8/Z+Il6ueeyj9fCI8VQm6Tnx7TAqgV/ODI3E4/KEsDfx
	 qjHdtGpa8zeJzPwwMePeItDHhE6HWTC4asGMNjAoDgCt3aNiWQeffTmnIG9v4oxIZD
	 zS26RBhXG/79w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773653806541;
	Wed,  7 Oct 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] can: dev: init_can_skb(): restore skb header
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133600528.2856050.12084143172913855186.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:20:05 +0000
References: <20261001151905.1556270-2-mkl@pengutronix.de>
In-Reply-To: <20261001151905.1556270-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, ndaugoing@gmail.com,
 stable@vger.kernel.org, socketcan@hartkopp.net, quchaosheng000406@163.com,
 shaunakkdatar@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu,  1 Oct 2026 17:14:23 +0200 you wrote:
> From: zjamg <ndaugoing@gmail.com>
> 
> Commit 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
> removed the skb_reset_mac_header()/skb_reset_network_header()/
> skb_reset_transport_header() calls from init_can_skb(). As a result, RX
> skbs from alloc_can_skb() and friends again carry mac_header = 0xFFFF.
> When such an skb reaches packet_rcv_spkt() (SOCK_PACKET), the push length
> calculation overflows and triggers skb_under_panic -> kernel BUG -> full
> machine panic.
> 
> [...]

Here is the summary with links:
  - [net,1/3] can: dev: init_can_skb(): restore skb header initialization
    https://git.kernel.org/netdev/net/c/0a04c0cb8606
  - [net,2/3] can: fix unique skb identifier regression under RPS
    https://git.kernel.org/netdev/net/c/7093c3b8314a
  - [net,3/3] usb: f81604: fix struct f81604_int_data size mismatch
    https://git.kernel.org/netdev/net/c/7f85d1170575

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


