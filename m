Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642730594E;
	Thu, 17 Sep 2026 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605071; cv=none; b=mXH83AcscVTY55xmLOrRSrvDqkX5A+uxMm87idKLfPCslKTzUtORsYn8oLW2wK8ImhOy8eSZwNm+s/pfcl0OXSaZBIXGulPu+HSCloMchOJhDVnhmDnBHHvsowfzlkLbO87mUcjV2FHiQv7gmCCWfdPNAyi6gpF5MrwIeZniNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605071; c=relaxed/simple;
	bh=Vca2qZXORiQh2Pnyki0IQ9IRitzRHhv0Wm1TaFbjU9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jyGQxk+O1FK2OdoTFXoZi/qD+Xdr4gR8SrDHs6p7P2uH24qNHB5xbPvmCuaSir0xGxoszSdpki9eXth0EE62ZtngNojs9z4aa+Sk2Uxj7ojgUSP/+8riiRxS4V9Ui5WzYoLP4tmTxPsKPNGJtpIXNLwrozotLV3dPTmPphakB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyWX9tcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyWX9tcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7970F1F000FF;
	Thu, 17 Sep 2026 00:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605070;
	bh=dGYH2qf8bDYuUJMNSIjNMyMbVlWTbB7wZX8aq13Is4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WyWX9tcy4yclbA0s7lVRL0eZbCBsh5QkSt7pGs1RtiQKxAflxEuBXOl6gONo2GjID
	 +TqeJvPpgECWU/jyXWoKiy6jEu3hfOQC5yNjHo8WHuOYhJyRul/45OlMeHQtaSs0Vz
	 eRMQC4CbjUT4Eu4eVecx7OX/A+YsupY1F4vIx6dYd2m9QfWGsA5o3E6YcLMt5enNM1
	 nVYQG+vyhIrNRpwi+2LQRYFU3CrSyrBiWUdiYfNuUf+OWA9f4nr1haW2S3jMFzLFvH
	 xsUZoeunGQDknEqmXMe483fA9ZzLVSdopJAxQmHgUWC1NIAr/FwlF7IGeduubORsSt
	 dPK9STRQsKgfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B0439E9601;
	Thu, 17 Sep 2026 00:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net repost 1/2] net/sched: codel: bound the dropping loop
 per
 dequeue call
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960500439.3351501.17214399774278359470.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:30:04 +0000
References: <QDISC-1L5H.v1.20260912080102@mojatatu.com>
In-Reply-To: <QDISC-1L5H.v1.20260912080102@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, victor@mojatatu.com, johannes@sipsolutions.net,
 linux-wireless@vger.kernel.org, vega@nebusec.ai

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Sep 2026 14:08:30 -0400 you wrote:
> The CoDel control law schedules the next drop one interval/sqrt(count)
> after the previous drop, using the configured interval
> (codel_params.interval). For very small intervals the scheduled step
> rounds down to zero, so the dropping loop in codel_dequeue() never
> advances and drains the entire backlog under the qdisc lock in one
> call - an unprivileged user can trigger a soft lockup this way.
> 
> [...]

Here is the summary with links:
  - [net,repost,1/2] net/sched: codel: bound the dropping loop per dequeue call
    https://git.kernel.org/netdev/net/c/7f4a5ec6258f
  - [net,repost,2/2] selftests/tc-testing: add codel/fq_codel interval boundary cases
    https://git.kernel.org/netdev/net/c/f6fb2ac5e19a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


