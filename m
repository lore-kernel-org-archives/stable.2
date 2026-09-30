Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1D136672;
	Wed, 30 Sep 2026 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731207; cv=none; b=pTVe6RRnIdB9VQ5iLxTuoX13JUq4Stceb/KXTxI3ngk8BUnPVtAYDWrGCGdIddZkb1KeROeoj+tUjswejgTDcGX/hoLYkKIjdsIBAEf8i536xxBj7XUS9akIYqc0/1sPAy8ujBuLWhozwyoU96TQLFD5PhWTAskU+wISwzWVqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731207; c=relaxed/simple;
	bh=9aFDIHxVQGrJaTQn+MDDknVMIusxzxtzpCZhiBXhiyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AIFRRFsKuCgvUxhmcvHnpVcXUxJ6J0rVBrlZFcmQOD0RYCRd4EPGVk2oPvOM5KcguT5KsKMuYqKppKwhGi25pYCwB/Rr3Sdn9qsRxrVGU+8eHz62gJOEq/CXxetVz5jV75H+wIIb7CHfPNa13+b5jWY59U0OARS7VzmrkfYqixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ1TFPn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ1TFPn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817BC1F000FF;
	Wed, 30 Sep 2026 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790731206;
	bh=WG9FFF940uE3B6f8LF0VrFRITAA8wVugqcQ2oADUp0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eQ1TFPn0X+s7ybpeeQBDu8pepKCcdAmCDkcbU6GItV4K0hvVkrFTqvLkMy0+lNm3s
	 1eLQsHgAPh2EQ2TgF1KgLXmmd5AEfu+wtSdJGORDSIC6XOjySEhqunQbY3z3vcOOEh
	 liDL33tQYt6fh7hVgZ5a3z9vkb0RM5Lvw6F6K69wegyw5RQk05tX9f/Ocn7Ct82ufA
	 Bskqgb6Ouh/JHNkWTzegaQPvTORUZ9b4Jqj8X/UNwI66gBnMB3lJmpkftzqyb9Q7/G
	 rFTQvvxNwLfZXwdCKC6P0xJHHoVGhOi4fOQs9ZVFdtzkQ1mQm2tTfFqVoXDKuH3DFo
	 IjLaYgKtGTlzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775353924FEA;
	Wed, 30 Sep 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ethernet: mtk_eth_soc: allocate dummy netdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073120501.1194536.17504645826852585276.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 01:20:05 +0000
References: <patch-e52c13380b0768fec63af04c80e4b487@loljews.com>
In-Reply-To: <patch-e52c13380b0768fec63af04c80e4b487@loljews.com>
To: Sandeep Haemoon <sandeeph@loljews.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 23:51:37 +0300 you wrote:
> The RX rings and the shared NAPI are carried by an internal "dummy" netdev
> (eth->dummy_dev). mtk_probe() creates that dummy device, and adds the
> shared tx/rx NAPI to it, only after the MAC netdevs have been registered.
> That order has been there since the MT7623 support was added and leaves a
> window in which the netdevs are visible to the network core before the
> shared NAPI and the dummy device exist.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ethernet: mtk_eth_soc: allocate dummy netdev
    https://git.kernel.org/netdev/net/c/6f0c2c4f5e71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


