Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C1382373;
	Thu,  6 Aug 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035085; cv=none; b=idAfL2Oap6CczfMAqTTVd07HcdiVBFEtNeXdcH36TQDybG8okuBigwQrvfZIlFZEAH1Tw3mWHxE3EYoBNjdR7Zh2gSMOo7Vj6uMT5qCsxTj6QrlY7LVPf9C3FeAfHMm54rbMC8Lga4Fp5BaQi/nO54i08BzbLHyd6sJcBBWTc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035085; c=relaxed/simple;
	bh=X+NP6XH/WHMjJl1Vw83zFSPKe5U0fCG0e0j3F4pBMl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sM+jtXTfT0CJR9vad9Sr2lixy6eMUj5JUInilw7jQd2BDOZoelTRdbgDAAM4AKhAIsuyQ8DYeERK8tWo8aCRpuDVorQSX+bI4pOmaVjuPC4vxOTiw4RmIHTf4TjIyOZefUqB6FQKzyqMRU8bnX1FurlOeSPsSTLgP5bUglgKCnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbjmk6fO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbjmk6fO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141211F000E9;
	Thu,  6 Aug 2026 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035063;
	bh=pSFVI4nEQI4pmMpifR/iQZafl+JEc6XAcH5XUNZIEZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hbjmk6fOuFAM4SDLly0QwZpufCSbYgEZLBLyPYWLTn55nw5pEo+7Y41V24I51sTBa
	 SlDzMNlIxz7mTitvkwy/6it0o7tYpx9OflLFEppIKoDx1zvGMXaXlLwRXNUHT8EsA9
	 TgBAVcSHw0Wowph7op579VEonw4dBTyrUrLeElViMPlpQ6SXelgtC4QeLho+h1mf+L
	 8LsDuWn5VyldfzjS2HPc8OFsNRPLeH80sKZeDQsiRYeY/CZbc3ibSnT2TVEPlp1XO8
	 XgmJQupDp+Kb6ppb54blNfGko+e7h4vA5AP3UZOqM1/1YGAtUtUdD42JEMqV06PKqq
	 Isd86sT8u3dHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939CA380820D;
	Thu,  6 Aug 2026 16:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/3] net: fix hard_header_len races in packet send
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603502213.1375455.2088843819224139687.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:50:22 +0000
References: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, daniel.zahka@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 20:57:26 +0800 you wrote:
> From: Qihang Tang <q.h.hack.winter@gmail.com>
> 
> The packet socket TX paths read dev->hard_header_len independently for
> skb allocation and header construction. Concurrent netdevice
> reconfiguration (e.g. bonding device type changes) can change this value
> in between, leading to mismatched headroom and copy length, and in the
> SOCK_RAW case to out-of-bounds writes.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/3] net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
    https://git.kernel.org/netdev/net/c/3b9a324e646d
  - [net,v6,2/3] packet: use consistent hard_header_len in non-ring send paths
    https://git.kernel.org/netdev/net/c/03390aa32e66
  - [net,v6,3/3] packet: use consistent hard_header_len in TX_RING send path
    https://git.kernel.org/netdev/net/c/21b5953e7494

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


