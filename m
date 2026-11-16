Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872408;
	b=mD2ivrQ5zg9R+Nnhp8fkdPiZnvvTrv1NF0LAi/4QAsBPGAF62qH4cPfehb96IJpiXYem
	 VeGpJrq8Fu3x1NwZuPCGX/GqR8ler05innfXxkIiL1eFmDdfK9yAmEFQYCLLTIxccW0m1
	 OCHqO4uOXnZUCOJOGTeqxiohKDgLd6KotpcIjISc0jotCHxujyAKi9dXt8eNg9VLM7LCg
	 6RC2MULc4DAfIkCO7SLk3KlVv50PEZ1XSRiewBpGY+5QtnM20ht9EoDetT2G9DYh8ZubY
	 q9tHbdM26UWrAn1nEgp6UOGmGI1+fZ3PVOkiWrML2QRjiHhvmysr1lMhhDuSfRCUcKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=o6DtZ4QfLqxd8P7gv4EDdAGSJ0MyhP4XAhBB0Bn7C10=;
	b=VI534x1wUieAthb1Bf2i0OqngHYvn9VfYxKssoU3a5xYmStonH1clBYrUlfCpsMlB3Hi
	 He1PfaGJK2maj0pOe3M9mOlVEl5NM3hNaPLfTCf1UMRX/o1/29ENhqsJPvJAgzDGgpRts
	 sOxLPz0FL1qd3VbOC5yYUrE4iop9TrY54sxStKIumNYkWHs9+owPvcQrrK587Vu3vnJLd
	 iq0US8tcODqnDtwDL1F4JEJ5MVluXfWfv8bqunmLXRNewMZS/PAkHmQxHBxPHsNpZiPPT
	 8zTZ4fI3ctUlK+vuS9UltwG2/Bcsfr2dCx7C2wk6wubIwyyYru8nl5KvT+wZ5z4ni1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMn2r7El;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6554D606A31C;
	Mon, 16 Nov 2026 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMn2r7El
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0542E1F000C4;
	Mon, 16 Nov 2026 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872408;
	bh=o6DtZ4QfLqxd8P7gv4EDdAGSJ0MyhP4XAhBB0Bn7C10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hMn2r7ElX2F4bb6Auv3+NkvkHnsEkeYOaWKf28eVtGHd09D220QGl2lyvDTWluI8c
	 a1H1Ct/NWWcoap6W0aU3MOmeGtrRRlzACR0MDhRoiYmpAG+kTsdZZs8NEEcHcWIfjH
	 vpi747AHkYPKWvnpowhJc5hbcZBcxNEVPKQCxdpXNMe+qVDg+Wy0ntk2VJZaN+o3vZ
	 aDdIY0diwviF0vUrfoR/orAx6K+pcEH49QDS2TM5/3H9Doc1A1zx/IloXHCCzT0Vxz
	 s8mp4kI9vtJaFpI/bGRF1VD9/r4bahfd/mRAXJC1LtwvfxpfwvlzFF+fpr+gi0MhfT
	 Uat8+UasY6f2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F150F391B059;
	Mon, 16 Nov 2026 23:40:07 +0000 (UTC)
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
Subject: Re: [PATCH net v3] net: usb: smsc75xx: reject frames without a full
 header and FCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179487240653.241382.6072784955848476091.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 23:40:06 +0000
References: <20261112-smsc75xx-rx-fcs-v3-1-6ad0378d0384@gmail.com>
In-Reply-To: <20261112-smsc75xx-rx-fcs-v3-1-6ad0378d0384@gmail.com>
To: Joas Antonio <joasantonio108@gmail.com>
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mim@microchip.com, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Nov 2026 16:23:27 +0000 you wrote:
> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> 
> smsc75xx_rx_fixup() takes the frame length from the RX command word
> supplied by the device and strips the FCS by using "size - 4" for the
> allocation, skb_put() and memcpy() of each frame that is not the last
> one in the URB.  The length is only checked against an upper bound and
> against skb->len, so a device can report a length field of 2..5, which
> gives a size of 0..3 after RXW_PADDING is subtracted.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: usb: smsc75xx: reject frames without a full header and FCS
    https://git.kernel.org/netdev/net/c/1b02f90976d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


