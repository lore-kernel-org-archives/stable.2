Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE43AD518;
	Thu,  8 Oct 2026 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482413; cv=none; b=ddK8Cx0DUDcyoAkuka9aVl45TfXkXBkJ8YtnF019UIy/f0FXRr5bDIio7YFtQCukqI5RSdtMpJwTKLSU8YafiDaZd9MhufP3G2lN2u/c1pbeVUBixYoBLeSIz2arLZ86hmzSrlbf4JnlP8mfjuEeZxrnByaUCunmzBpSjyIYXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482413; c=relaxed/simple;
	bh=mszzKbfftFTPYWIWOzogC9s+6PaezE7t/0Hv9bG+A1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WzHNcu8huH3KF2Rw4bYYfOE+dX+Vn0q/3vOmz5SmKvfYXeKzt1p1WSYdzEo2cpFSMLqx5HQpgVXbDfKsM+J2HE0JXE0s0diMqeJ80gPCghdqiXKbuz4dUwnj1Xt0KC8tZbF07AAEkS2/zQzu8R1U7ahvJTYRXRprzB79e22bz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxs7GYZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxs7GYZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480361F000FF;
	Thu,  8 Oct 2026 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482412;
	bh=FxsImzC1fNiyTcBHseW/ALc81n5x8S6JkZcq/SrzDUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sxs7GYZDszDqYuD4Tfx0ZZpAM1ZZLNBulUqehn+Jg8IEwggSZyeAbvUq6jC6aV419
	 Q51NlzWMxZE6cwo6uixreWst4L+1b6dciPsWxFlnOC21Xh8YWOxSX+lw9mhaRAzEyf
	 bGyP3OVTs+sWnP2rmBbwLgrLUU+2xobBdz4mUPIkInvV0VxoecFNOtKfkzmtM8kV5s
	 gGz6wcgxjwDX9fH3oWuMWWbQsuXqtkSn8Jxg+ETxGyGbgkCBCJN4PSi+xfLKAt/dHP
	 kFpuFnii4LE6JJXgU29OsmBtoIB09akjogwdVJ4sZFCXAS2+3c0emumnoqvW1STC14
	 aIM4Fi3SFU6Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3AB380CEC8;
	Thu,  8 Oct 2026 18:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: i825xx: Fix dma_alloc_coherent() size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148241076.372666.700478995670344457.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:00:10 +0000
References: <20261006143247.54724-2-fourier.thomas@gmail.com>
In-Reply-To: <20261006143247.54724-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, jeff@garzik.org,
 tsbogend@alpha.franken.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Oct 2026 16:32:40 +0200 you wrote:
> In sni_82596_probe(), the lp->dma buffer is allocated with
> dma_alloc_coherent() and with size sizeof(struct i596_dma), and possibly
> freed in the error path with the same size. However, in
> sni_82596_driver_remove(), the same buffer is freed but with size
> sizeof(struct i596_private). This error may leave the freed buffers
> mapped, leaking a resource and allowing the device to access freed
> memory.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: i825xx: Fix dma_alloc_coherent() size
    https://git.kernel.org/netdev/net-next/c/c16411fff03b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


