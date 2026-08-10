Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2D43BDC0;
	Mon, 10 Aug 2026 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403461; cv=none; b=b/c1v0UGjNguzQahafNVVYmY1YvX8Mk03BVRs89Id13x+HN/5D4yrwrW9cWyweqApENcA4A1HMDs4yKLCRuGcOE/Ftm6i9TkGJYKhM8FFF+JaxFAq0/jZma386hMeAmiOExRSSK5PV42gifFnPWwjDDit8B1WhYd9LPksNV4nt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403461; c=relaxed/simple;
	bh=piR9f5v6xMuDCD2PiCHy96p6T2vb7JtkIpDU+I4rnBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y0kivUHOwQHHySPu0X5uLrJVv5pUW92uq76UDoRcb9oQ7fC5+wx/vugIUTj4fgoU3/dQfRBUDcsSpQDzNhJBTMM1SiB83MdPVF1vU1kzZEragJHEYYDbUuw2FM4581PIvReZNvtaOIE4FyT+TeYyKLAJ58QzfYHve+cW8Lps2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVc4Jrz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVc4Jrz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8181F000E9;
	Mon, 10 Aug 2026 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786403459;
	bh=8ULtlrwCPA8tyYSyXD+ONP5sy2lIHW2DHKca5cX+NOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LVc4Jrz1n3YqLvLEUXzneHme1Jy/1ggZWBhb2XEVbVnjKC/AxxgYRScEMoONMxAr7
	 pQzHv5F0g3yaV3Y7FuRRVqx6D1FtBxHnY0+GkV6sfGlye5slAHhI74zH2cHHrLMyQp
	 wYePZlCVdKz5v7IJeBusM4uOmKH5SYydwDfhOjKV45q1AQQP/cTAv9/QET8rOQmd2O
	 cTivYhJq4dV3Pn7uVSrY6Q8NLH75nGY3ji2JEomxLVmvRpVDXUiAJkQvvAh+YFohdj
	 TVemr//N/UTfrpvdA9G4q5rs6sXt9jTb0YA2KXVKP27PPHZUiJLz2TOZnGH+rkEF/x
	 hWavds9FwJWDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568AC3926265;
	Mon, 10 Aug 2026 23:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] selftests/net: fin_ack_lat: fix latency threshold
 typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640341588.247552.5360700378574412484.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:10:15 +0000
References: <20260806151645.4172900-1-bgrech@redhat.com>
In-Reply-To: <20260806151645.4172900-1-bgrech@redhat.com>
To: Brian Grech <bgrech@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, sjpark@amazon.de,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 10:16:45 -0500 you wrote:
> The commit message for af8c8a450bf4 ("selftests: net: Add FIN_ACK
> processing order related latency spike test") states: "if the latency
> is larger than 1 second (spike), print a message". However the code
> uses a threshold of 100000 us (100 ms), not 1000000 us (1 s).
> 
> The lower threshold causes false positives on slower hardware where
> normal connection latency occasionally exceeds 100 ms but never
> approaches the 1 s spike that indicates the actual FIN/ACK race bug.
> 
> [...]

Here is the summary with links:
  - [net,v3] selftests/net: fin_ack_lat: fix latency threshold typo
    https://git.kernel.org/netdev/net-next/c/2373107782a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


