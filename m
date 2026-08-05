Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7030C630;
	Wed,  5 Aug 2026 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892855; cv=none; b=P8OiawMuwilwdMQlc0c15XwGLqF+vKRyYjKtDldF482Wd5OhEzkbF/Gxerawf37Oaj/IYgxy3p2fqLCxl5RH22V0QRZU0Y5dvq1fpPtn40Mfbgj4l3TWrYZCF3IcGnAcGVbOsZFd+8zxQnLji6JpdVSzP1tcBqM1DZqnGkX1yWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892855; c=relaxed/simple;
	bh=YIpMCKd0QTvF/xFdG9OQ85qOLrkXPC/EIrN+d2yy0jQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E5sTGLiEFePtOP7Ziw3JGgBzWkcMzaV1jpS9rKGinr83jD+Oqdy6FIcFfCY7FUBr9BU6unsG7uabHI6yclMTMpYOLCkgFI7wdNV0PvH2ufyBXY0RTI6xH4X1XP1YByyKrnG5t087oSn1PfHSDFd25Vzbmu1DDrPAYw0kocNjnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giLDqnsk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giLDqnsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C501F000E9;
	Wed,  5 Aug 2026 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892854;
	bh=uuhMVFIUH0GFr8lEZjjoZkS1y8qznpSN0ez9bBjiM9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=giLDqnskBnDw3fGI1DU5i3n6NNujaPq4i+qjr/zkRRHTHpfHND1DCwK5Rscw8+J79
	 gQt/Ey99PTOFWhsoJbTEWu7DFB9WiH8DHbdkf5N35AAhgDL2t836hVeWHcjNjLdvTL
	 lvyW6p5oFHzoiQnG9TttYZGFL80bVrFmH5Isvy3qRnSYy1mUvsrbZOf3NdpVWvP6Y7
	 tV9y8X8kt1B8+mBqd3k2AzO1dfprL8u3Ew8uQdnYrfi+ddypRqIF3AgM3HI/yndd10
	 6zSJ5J3dMp2k3XJGT+HiciOqflDfT5me4o48PC/tOjt5mjsg2stncDDsaURrcXxG0s
	 ZMLN6V+2O3cLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A773926666;
	Wed,  5 Aug 2026 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: atlantic: fix two ring teardown leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589281439.3863162.3432302157520903640.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:20:14 +0000
References: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com>
In-Reply-To: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: sukhdeeps@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 almasrymina@google.com, hawk@kernel.org, richardcochran@gmail.com,
 LinoSanfilippo@gmx.de, irusskikh@marvell.com, horms@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  2 Aug 2026 23:44:53 +0800 you wrote:
> These are the two fixes from the page_pool conversion series [1],
> resent against net as requested in the review of that series. The
> page_pool conversion itself stays in net-next and is not part of this
> posting; it depends on these fixes, but they stand on their own.
> 
> Both patches are unchanged from [1] apart from the collected
> Reviewed-by tags, and each carries a Fixes tag and a Cc: stable with
> the affected range (patch 1: v4.11+, patch 2: v5.2+). They apply and
> were build- and runtime-tested independently of each other and of the
> conversion.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: atlantic: free stranded TX buffers on ring deinit
    https://git.kernel.org/netdev/net/c/452636ea5410
  - [net,2/2] net: atlantic: free RX pages of consumed but not refilled buffers
    https://git.kernel.org/netdev/net/c/e8e7471ef686

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


