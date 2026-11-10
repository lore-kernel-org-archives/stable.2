Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334992;
	b=k2IyENKF7fc8OaOO2MMHOff8hZDLmLjvu1FengKtsREOXfmQAFLffKvVJ6KBCStncvN3
	 nsbPnA4cgd0KyF4tf+bLIrmkG+pSX1oL3MCYsVOLWqmWiP0ZymLFF89qO8QCd9UJd1Yxc
	 sHO4oONMf8tKT0sFIdwwBrbtjaUbHki/dkRmN+n16MQhQezVwZCuGdE5PfHMvEFHBkx2G
	 sWdK2U9dTot8w+b+VBD94I6YHeSsinDx3JbMVh/rXAwS3QNN9F79lAyTNiDQjOo9IQ0DU
	 nLAHCVslU9HLZ5Sz0kpB/T0e92OxaBqy+mIhhX9uKnAmb9sEpF7KaBAxgMVAQQFPGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334992;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=eadta1nFjsoRbuz1U6jLN8xSeOneDP8tDN/7+E0RQVM=;
	b=SPq3NhBEsKQCfUax9mGk8p2WZp3VQahW2GFqxzkE1ObY4FPQJw/FCY/L30SBTPJATFCM
	 nJag81MDzGLeTm2fOXHOF0V5mZq3IRv58tuWgpV7j8ZM8GyFwwShG4MuvVeC3YvecCtDX
	 dZ5vHJtzE4fEnJuUYHLMsU1VEF5rbHePbNRDX2CP+uzIshibWPQpR46fOnCFWZ/BE++Rz
	 4cel0NBxO/NrMgMCYI1v5lUjNH/vXesdbnDqRC4xD++2mJN2fxHFYWeTYYT3TMUkdv6S4
	 uIxp2XSe606nP34m4h26JK6LjIsGz8md0h7YfVo/BmBwaONO2IZoN7SvCMIA9Klh4yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBcrJWZ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C889606A336;
	Tue, 10 Nov 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBcrJWZ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57171F008A2;
	Tue, 10 Nov 2026 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334991;
	bh=eadta1nFjsoRbuz1U6jLN8xSeOneDP8tDN/7+E0RQVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZBcrJWZ6nnmuOKxU9Fuq848yjYrLsp9HdcARKvfSexUug0ezZG5DCqksGZycWADyT
	 rD+nJpXRGi5TZo0NRld7lPac0JqGtunmQB75MqZ82DO6CSp1ERfNg2taBNlVgu0ObF
	 faGD6s3ZUoin2yKknmTkuyMw9cNoASrCpOwtk/8zY/aMM2QC22seLXsK377ZKz8zNd
	 CZysS4g8+pIHyRtciGV180TsdtNg7sHuVil4O0YOStbzfFqc8/qcq2hXD5DqOMbVZG
	 VttAGxiIGowIFqvK2ffb7gB/w/DaOGogTqwHDn4Tou68NSCRKu7yy4qKAACMs1q7oq
	 coRBxrzJqUAuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B1CC39D608B;
	Tue, 10 Nov 2026 18:23:11 +0000 (UTC)
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
Subject: Re: [PATCH] net: mvpp2: free pending TX timestamp skbs when the port
 is
 stopped
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433499017.4118637.2163160814917969670.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:23:10 +0000
References: <20261103100535.1310088-1-vulab@iscas.ac.cn>
In-Reply-To: <20261103100535.1310088-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 10:05:35 +0000 you wrote:
> mvpp2_tx_hw_tstamp() takes an extra reference on skbs that need a TX
> timestamp and stores them in port->tx_hwtstamp_queue[]. The reference is
> dropped by mvpp2_isr_handle_ptp_queue() when the hardware reports the
> timestamp. Nothing drains the queues when the port is stopped, so skbs
> still waiting for a timestamp keep their reference until their queue
> slot is reused, and are leaked for good when the port is removed.
> 
> [...]

Here is the summary with links:
  - net: mvpp2: free pending TX timestamp skbs when the port is stopped
    https://git.kernel.org/netdev/net-next/c/6c4f0baee69e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


