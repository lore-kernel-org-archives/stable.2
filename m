Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794970210;
	b=Til3U+erIvKuTwHFFIBuRL1T81nsj9FzfcRQT9EfGaH3xiVo3nQZhNt82m65Nn7K8g6s
	 s52iSo7gPhATbjZqUYMjVqnUNM2748OCP69yMFs/cX4FFxZw+MP199KLAAk871L7SUBf0
	 thWw2P/vcu/vA8nCiK6ecrp0sUquVnbXzmyaOtBe541rMwpkjROcaVl9PQSgfcbdHvBzU
	 r9TUDfX3NzDn9uzGXTYiQnxG9UPeUq86+4sHfOnIpZC2xpzlVLpyC9cMn6IpP0FAGIkje
	 sMZshHURInhauM6774KU0koY4sWsVBJPhfZoFYrvfZ0Ap09kHdQD3t57WFU4hSzb9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794970210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=J4VdQNCux/WRSbi5hDgNlOHQtRMsiZ3AqQN7opFQNIY=;
	b=MLCbvlVftRLbC6PwmQBFXpLg+0Lsc7XDDp/joRaPZg4mJYlyc/VyIOrJfSWwqDNNJKa8
	 XUoY9Eh53re/HaqDurLSYCvq4icR9cEZvX2ht7Pun5imJR+Y7p4fSM0BC9ry3RvoJmIym
	 /Yv65zpNOQhxsrtLwgpHtIXtB0iA7MxMQI1WW+UbTQNfpHWWiIeeuFb4pT65AZ6GCpvsx
	 rJK9zQhCyFze34R45u3BkVATlq121IOWjfr8TlkK/19QSZkv40CT4C4WFMF2wlvMkbJWv
	 dU2K1ftWB8X8WL6S8hg2zb6hMn+lEoKhXNBrAfdviKMOkQ6MvR3JYyXO3r/OdrSbb1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL5Kw4z0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E7606A330;
	Wed, 18 Nov 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL5Kw4z0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0618F1F000CC;
	Wed, 18 Nov 2026 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794970210;
	bh=J4VdQNCux/WRSbi5hDgNlOHQtRMsiZ3AqQN7opFQNIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jL5Kw4z0pYgsWJU+v7yKzrfiRGrJkTPhzpou+zCPBknjSdprlCPlkz4InsuWlQgI5
	 oUhSrbgOkeFmMamv81bnzM4iSUzG5bqvNr9y96q+5+g+O9W6AaAD+PteN24dJcMF/0
	 DynCsT7fE+51ZVZjHWZZqtmMu2LLP8t8b2ofnxG7Q2MzWSE4ZTqvsxXg9mamSkR92h
	 NoefrXKJ5zl0Ph9qFulB9lsYls7dCR3Fn9BOtpI2WxzVKP6yYCfWF3cJmm/XD8peof
	 OXEJCtbUmG9OLPv/iPrchqRKkSbiNEWm/2q731SA5L7tYgtuiC/PpG6fvKfLT50tw7
	 n7agLJWnOhgGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1423392B1FF;
	Wed, 18 Nov 2026 02:50:09 +0000 (UTC)
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
Subject: Re: [PATCH net v2] qca_spi: Avoid unsequenced accesses to jiffies in
 qcaspi_netdev_tx_timeout()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179497020852.1430642.445916911706343587.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 02:50:08 +0000
References: <20261115-qca_spi-wunsequenced-v2-1-8cf32f12d546@kernel.org>
In-Reply-To: <20261115-qca_spi-wunsequenced-v2-1-8cf32f12d546@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: wahrenst@gmx.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Nov 2026 21:45:22 -0700 you wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in
> qcaspi_netdev_tx_timeout(), which can break the build with
> CONFIG_WERROR=y / W=e:
> 
>   drivers/net/ethernet/qualcomm/qca_spi.c:805:16: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>     805 |                     jiffies, jiffies - dev_trans_start(dev));
>         |                     ~~~~~~~  ^
> 
> [...]

Here is the summary with links:
  - [net,v2] qca_spi: Avoid unsequenced accesses to jiffies in qcaspi_netdev_tx_timeout()
    https://git.kernel.org/netdev/net/c/695d0824cb6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


