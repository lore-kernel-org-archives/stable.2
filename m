Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAC7390CA6;
	Thu,  6 Aug 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029651; cv=none; b=X9N78wV7gK4nHkEeE2Al25lWOFJsPv3tQWUVZf/k9uCbIHJ90CJqoEKNxYmsBnvkVY5bCxoalWnjR1z/EXVOl2AY/OtiCWZ+iRbMSA2NgCUtOQZe1eixMHpWC5jQJSDPzkenyb/ng0IueP/NaqUptkYKWd/XUmAEqrDTmcUBLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029651; c=relaxed/simple;
	bh=1lVLDNftL+PCshr/bKIyiUq9UjY2dnZNkhFEmDSSruY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kgc7+UE8nF0IsftbbIin4HRCRIO3WruVqr3Jp4DOrVbUotfVLUuQAE7zdnvn50IeSTqnGFSHNh/evzpgv/UHDv5qlnLyrlM+i63EUbM6k+4kZGTOag+SjDNPnJuD6M9DOD2HlZt9RvJoXhHa7vG3dUUt0AqOd+kzZI59r2t3/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLANLCd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLANLCd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493D61F000E9;
	Thu,  6 Aug 2026 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786029650;
	bh=dugqSMkZOoszMrAgVZwnKFek9N80adddweUaTY/KKJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fLANLCd71KXRS2qi6Z+uFPdGcjl3gtsIJnG+lrv1vffQSir8Q18me1UxpeF53MVyg
	 klZebbicRsVgRmzih0uLHj2sKK5img56pSEZNGPEHZ41cDwfMZWNdhPibBioAAv4TA
	 WTwWtj9nk74zyjVwVXgj3h7IwX++RJK+RGr5+YEixS2YoA9CSt9jgrA7TsP63dNqci
	 GccMbAdG2aKuRlHiEep/sMd2hT+goRL4Y8QMBVAtYc7y4GoYPjjloxdFPj7KJvtj3W
	 6s/hyuuvaAz5O4i1i+GQL/eMnPkyGEpT48PxRunSpHgICFWkloY+mAvxw1Xpghlspb
	 Gg1FbgXiOmvJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A15380820D;
	Thu,  6 Aug 2026 15:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ptp: fc3: register PTP clock after initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178602960938.1333975.3024284810821390320.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 15:20:09 +0000
References: <20260803135942.48383-1-mhun512@gmail.com>
In-Reply-To: <20260803135942.48383-1-mhun512@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 ae878000@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 22:59:42 +0900 you wrote:
> ptp_clock_register() exposes the clock to userspace. If either following
> initialization operation fails, probe returns and devres frees idtfc3 while
> the registered clock still refers to the clock information embedded in it.
> 
> Complete the fallible initialization before registering the clock. Schedule
> the worker after registration because it requires the registered clock.
> This removes post-registration failures and avoids exposing a partially
> initialized clock.
> 
> [...]

Here is the summary with links:
  - [net,v2] ptp: fc3: register PTP clock after initialization
    https://git.kernel.org/netdev/net-next/c/762137ff748f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


