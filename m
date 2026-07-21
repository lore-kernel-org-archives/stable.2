Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D2846DFEE;
	Tue, 21 Jul 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650843; cv=none; b=j+oAVPBkrtVBt860IjGIoWxRfJAQIzBxq9/fl7znhFeZA+3M+yL+Z//EPJwVdFXyHbOoYZrO2/WjDdaQiBn203Onwd1MWxML26WVsnnXJSSSVCMZMvo/QhG8Rv14v5pEpGo+z8It1VMnkJfKtiPS5WKTws3CJDTulxQS+zBumPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650843; c=relaxed/simple;
	bh=eXpHhurv7kzyzJr5wyPXbHAGAPEL+72AdrbdqQp1dt8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MTi9WsRx/RyuYJpjyjf8QJo2Q8pHDHbBIbH3RZZiFwSXW0RrSPe+5MYplBCYnmhW8wC9oId/hKEcGjgTnZuBbjDJk71sHFo0ur3rvbk0BPAiemjTaGSBFL/qOdRLW4No1bMwPCocEko0HNLNuMtoBxek9QleRPGYnes5jN/FfGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3jEMJYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3jEMJYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831111F000E9;
	Tue, 21 Jul 2026 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784650842;
	bh=vOXJqZBq7kJKKJZif/QJuoo19qQj/Am4g5tOlmsEm8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y3jEMJYPXK7L7g5mjUyckvhclxoLNo8rYwIzM/0tiAuVH8Owbw32EnIwrGLRATpc1
	 t0yi7m8cp2Y2s/82+SAR1aN8xdckq0ShxaJbQ42NZR1YH1+vMBTdZKahDVC2FgPziQ
	 qNVKbY3R/Ss/EwNXJ549nN/PAA0l3Z4Z3SKu/q2abSz7sPOC9lHYuTzjm78vvGJkqN
	 aI5k9KG60ZhuP+6CXnVtTcxfZfcnp7VMixAvCpG434qnsE3jrtxSpG1GWzHqMhbE4S
	 fRJWRZT6uEzA16cIuYtiEfO4rUSo/62BUORKBayGuqMEbPyCPoXDVV1QYLIYGaVlfz
	 FPGq14Ggl/JgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C803924FFE;
	Tue, 21 Jul 2026 16:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465081196.386198.12551993871523492296.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 16:20:11 +0000
References: <20260709095006.3683940-1-prashanthkumar.k.r@amd.com>
In-Reply-To: <20260709095006.3683940-1-prashanthkumar.k.r@amd.com>
To: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Shyam-sundar.S-k@amd.com, patrick.oppenlander@gmail.com,
 regressions@leemhuis.info

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Jul 2026 15:20:06 +0530 you wrote:
> From: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
> 
> MAC_AUTO_SW (VR_MII_DIG_CTRL1 bit 9) enables automatic XPCS speed
> mode switching after CL37 auto-negotiation and is only meaningful in
> SGMII MAC mode. The original code unconditionally set this bit on
> every call to xgbe_an37_set(), including when called from
> xgbe_an37_disable() with enable=false. This left MAC_AUTO_SW=1 after
> AN was disabled, causing the XPCS to autonomously switch speed from
> stale AN state during subsequent mode changes, breaking SGMII speed
> negotiation on 1G copper SFP modules.
> 
> [...]

Here is the summary with links:
  - [net] amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN
    https://git.kernel.org/netdev/net/c/4bf22afe53a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


