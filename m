Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99842352017;
	Wed, 23 Sep 2026 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126482; cv=none; b=j+YGfs9TlgQEJhIgyu3mGkEpjd2BdwqBCh65Mz6Xyf3dbPpDZO0vH13/DrDGGomNQ1lNAAjooPwbP+afWZqb/P1MjzHh1n3VH6TCoR2aWzXQmTj8/cUPXYWMTiZrVVutgCf1Jgz3aXMS09KJC3H9+MaJHrqYa8oczxsvK/tmmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126482; c=relaxed/simple;
	bh=AN4N9EkUF7L/m6m3ocLL+1vwSg0sKXvQ0vCXXhMKEGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RyM9mYvsWaOjvfDUm72ojNKFKhieYwWT0o8iZVQ50t+Su5RwxSYA7SOaScY7zFSYUUJRooX3X6xqmzZ8dRGNx/Sb1z1uU+JxoDPa4rL39fawemRT5sQfQwvJjuFrc23bXmYvx5+/xF8ObG6/WFEA7Vz9kzGOQq2peS0lDXFXrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS5sU//M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS5sU//M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD681F000FF;
	Wed, 23 Sep 2026 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126481;
	bh=9eEOh9OQcVB281ZaZa+Ae1kSGMocDKM4S9wYDuFBcPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LS5sU//MvBzZnBOHJuGfRVn9EcPwh4cIZ1eNa/k7MZWlXB5hnd3JAroJnZ5wJJrBw
	 i5TPcMe6Eibhko3w+cIPxCa7IEJMSc9iHbKo7zXdIliVGqlFd6fB8fyEDA2gjY6m3W
	 45Hnkay9jlQql4AJieaFGmFVO6jsA49ypf4HPt1NHMHg/4TCWIKrdmgGtLK89IxeHj
	 3wFnlEXRQoLpocpIEe4eMrrnqmMN5ynpq/OoYqUARN8yjssxtZu8XbflwxBXOXitvs
	 IU74+oEuIIjkIdKQHeOzJ+xbqaxKvRilOQLw+Mmn8Xp2/vFDGmZGs6a7CFwrsS03Ep
	 2bI3E+qXtXhrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197D23924463;
	Wed, 23 Sep 2026 01:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: vitesse-vsc73xx: Fix SPI device reference leak
 in
 vsc73xx_spi_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012641164.161587.2169545337550051566.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 01:20:11 +0000
References: <20260917104920.2147568-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917104920.2147568-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, olteanv@gmail.com,
 pabeni@redhat.com, paweldembicki@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 10:49:20 +0000 you wrote:
> spi_dev_get() takes a reference on the SPI device, but neither the
> probe error paths nor vsc73xx_spi_remove() ever release it, so the
> spi_device can never be freed after the driver has been unbound.
> 
> Release the reference on both probe error paths and in remove().
> 
> Fixes: 95711cd5f0b4 ("net: dsa: vsc73xx: Split vsc73xx driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - net: dsa: vitesse-vsc73xx: Fix SPI device reference leak in vsc73xx_spi_probe()
    https://git.kernel.org/netdev/net-next/c/08dfb3106c0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


