Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FA4772A8;
	Thu, 23 Jul 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820661; cv=none; b=TsVBZgrmN99OT7h6bDdIkQuv+m7qHDTWLyZMz87RVbtQ2kPd06YHn1vSjC/HFCnuvtDbTvgfJlmsFyNoKbJ38saERwdmieetQ+4R0JTQ2is2N85ULNZqG8/vBVsD0U8wUtRwCtlPzYIrfCbo7L69tz1A/LrkIGEq3uiUvCpH+eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820661; c=relaxed/simple;
	bh=sUnAj6t7LeiqMQhwquczG4Uv6BXt+dzJo17pKz2nhxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nH76p8L8WaWJiCKwd64iHs1MI8FsSnp3AqMetstyedoXSx5CvsNRddah6iQKY38eboI/cfanUjFqcB+pfOcl33FZBLqOiF+F6e7j2clf3FK22H6AtPz1AQhEbHvb6VUxoqR8yB6nNJGTpQBtfOGLk/L4V1HHQVY6iM9bYD9ScWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62791F000E9;
	Thu, 23 Jul 2026 15:30:58 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A30392444E;
	Thu, 23 Jul 2026 15:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pcs: xpcs: fix SGMII state reading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482062114.2321119.13883500484545026813.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 15:30:21 +0000
References: <20260717074324.3250043-2-coiaprant@gmail.com>
In-Reply-To: <20260717074324.3250043-2-coiaprant@gmail.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jiawenwu@trustnetic.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jul 2026 15:43:25 +0800 you wrote:
> Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
> added a path in xpcs_get_state_c37_sgmii() that reads speed/duplex from
> BMCR after AN completes. However, BMCR does not reflect the negotiated
> result on the hardware where this has been tested:
> 
> - On RK3568 (MAC side SGMII), BMCR returns a fixed hardware reset value
> - Wangxun engineer Jiawen Wu confirmed that on their side, "BMCR looks
>   like it only wants to be return as 0" [0]
> 
> [...]

Here is the summary with links:
  - [net] net: pcs: xpcs: fix SGMII state reading
    https://git.kernel.org/netdev/net/c/def9a4745e10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


