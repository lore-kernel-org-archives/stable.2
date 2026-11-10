Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334986;
	b=kkzg7vpUTq/MFCIClzPtO7VYKTnkWVMoU5t9LRnrNNWYbnqAdHKvxUZbYbl5Y9zgyVda
	 qbtgFYiNnsj7LtFtKhmdARvO+oVrhVU8v6f22nwgN4w1rAng4Lcyq1J646vDjVXR4rYjq
	 lm/HOx5NHDlv18Zq/iBK9W53h+LrLeJfPPw/JHnoCxnmzU5it8VAJK+26Z/zeSyeUsOA7
	 SZheSME302+DTZomJnF37XXC7tqqDW2pN50+L+i10Z7fcijS7AbSD5nJzvcpDgZCp5mdu
	 tIngeq9crqKiz31UhLIa09wGqGQ/qPTSuePy77m184ZoBUHFhiIzr1m8qmkAp09UPPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334986;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9sE8gzaydrNHDIN+s0tYeRlNamt0qF0RhgBxRYsfIv0=;
	b=ZcN7NZCrbmoETq80k2Gl2LRPYfLDUckwCkkyKSM3XfG9kfr1sFjRol7NdVmo6LXrbmnl
	 5ND0QsIa8O9zdrNTP4UizvVB69krahH+iJbl4YfKrrF0k/X66ZM3oPZCANdNPRNHwfJSK
	 jGL1qHIC1jk2Dw6APYBTqnS+ihM5eeApOV0zdk/VIsPMPbfrHdqvFMw+rspR8gFQKw8Tl
	 8kkJ0YKVwvbkcKHvJd2+0TTqiIZOccU9HmWdCgf0WiH+0MYpUnvJw+AzvzgXhMXAJjNwi
	 3JStBL9VKjYCzt0UrmWETRpeDabH0nPiOSJnmXO0jMFuuCTQri2cGqxpWoW6rlkyyrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIfL55HO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280060A2607;
	Tue, 10 Nov 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIfL55HO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0EA1F008A1;
	Tue, 10 Nov 2026 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334986;
	bh=9sE8gzaydrNHDIN+s0tYeRlNamt0qF0RhgBxRYsfIv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dIfL55HOXbwYPWyq6dX5QadDojD9GRw/005QwnPDkenjdFn4T84RpwI3O3tJn3pS8
	 Df7unLDv/XnCWoSfAMNGidQLjlVLuWuNdoN1Nj+U2UFUKY/c8Gn2yReOxqqFCFey9Z
	 o8dz8ghEZJl87qkwMSX7SXDtmkvnf9wES3Iu/z4GXS/MmHEgx1XSLqEl/O4t1z1rTT
	 3FOaKGDdEwTOYNpyuV7WjDyY1d15V9qwCFbW7SL8e6d6qwmyssKMW8sPehJsZhT0ZL
	 CO00WsxQbD4N5balZWdF8SACptEKMK6d3+5ijpA8Xmw7Bfw8yCmFhZ26BR8GlAF9+Y
	 lW+ZLn2QvrLlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210B939D608B;
	Tue, 10 Nov 2026 18:23:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: usb: lan78xx: let unregister_netdev() stop
 phylink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433498467.4118637.205536379890905372.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:23:04 +0000
References: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
In-Reply-To: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 o.rempel@pengutronix.de, stable@vger.kernel.org, byu@xidian.edu.cn,
 wencheng@xidian.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Nov 2026 00:52:13 +0800 you wrote:
> lan78xx_disconnect() stops phylink before unregistering the net device.
> phylink_start() is only called from lan78xx_open(), so when the device is
> unplugged before the interface has been brought up, the attached PHY is
> still in PHY_READY and phy_stop() reports:
> 
>   called from state READY
>   WARNING: drivers/net/phy/phy.c:1670 at phy_stop+0xad/0x380
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: lan78xx: let unregister_netdev() stop phylink
    https://git.kernel.org/netdev/net/c/928012824561

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


