Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B494EA366;
	Thu, 27 Aug 2026 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859681; cv=none; b=bjMd9UJK13w/6wmCHHdZhnPgxVFU5uTmSPN+DH9ODLgrlfgldaGHI0yyORlRTYWr5hcSLTjiO1cIYvx7TN8AHtjpwNdSXC/IkjA0FkVBP+l40EisWqB3FQVmoETHJUqHNJ+VltLT4L+ApH+CWGyPHHZFnb6IUDtjLTO9y4/7bE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859681; c=relaxed/simple;
	bh=0P6eMkkRG2b1z1PqpBTFusEK4LUyKsguFzEEnn00V84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HTbzsVP2yPk7PNbSzkFRDPHcFCeSaS8JbRUfblkb8XtwmJF/WEXphzc9Rpfl043SBshTCi1s/ChoeJXR32cjKWwyy8TRD19SspSz0V5A1MevtHbPlTZHMzfQIBboVKIIjHMwlFpNm2T5OcVwo/kFGjsqxI9MfLAIyXOPjIQISMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4rQVz93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4rQVz93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A512C1F000E9;
	Thu, 27 Aug 2026 19:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859679;
	bh=hKmzTWG2QTTLM4z7Fbpyu8BdhihGCi8BMyjswsDYkag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K4rQVz93JFbiwx9l0iuxF9e6oP5YBuDC5Y3UpUSiA/fQxW9Hc2gtqlGGsfIt9R57M
	 1d84bW9RnKd57kaQSN0rCfFMoeyEc6zvZvu9NmbeFDnEYZZV1BVEfpnYMQ0+KW7cae
	 BG2WauRV+wQOTk9y+VoXnYyxeWfFQIUViUherUQXJTQR9El/0qBvwEI3Q4Ew5H9VfL
	 4i62rTt/3qkbMDUrFwMgfdGaj9hC5TM2IE8gq4Y9hkrEXEf2Wg1sdLzl0zDl5HNvlM
	 3iOSA6V0drrvNxXaXvdPAxQxF2hrZBjPlLidT12gMjWaPm6pUYBHmHtupevYc6mD2C
	 FZqN9qLgYo83g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568AB3809A8D;
	Thu, 27 Aug 2026 19:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft
 lockup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178785962489.1816627.15370775137740207387.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 19:40:24 +0000
References: <20260825081403.133992-1-jhs@mojatatu.com>
In-Reply-To: <20260825081403.133992-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, vega@nebusec.ai, victor@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Aug 2026 04:14:03 -0400 you wrote:
> qdisc_get_stab() accepts a user-supplied size table, and
> __qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
> overhead, the size-table data (u16), and size_log (up to
> STAB_SIZE_LOG_MAX). A crafted stab can therefore set qdisc_pkt_len()
> to ~1 GiB for an ordinary skb. Per-flow deficit schedulers such as
> DRR and ETS replenish one quantum per loop iteration; with a tiny
> quantum (1) they spin billions of times under the qdisc lock,
> producing a soft lockup / RCU stall as illustrated by vega@nebusec.ai.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
    https://git.kernel.org/netdev/net/c/8f735d64382d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


