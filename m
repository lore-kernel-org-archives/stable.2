Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B5334B43F;
	Fri, 18 Sep 2026 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771880; cv=none; b=VD9Y2UA/MJ3LFrqsiCyBpqH84sInhQerqHQVVscdb6b6jrzUQGJ9deaz7bvsUwGqPEmNV5+Qit5k2jbP5Fr1iju5vURlfKZkoocH2jVrhtTJYcjb0TR0L4gvQDPzdsuO56oAPUd3AJm9YtV4OccgSLpeGnXfCHUWwo7dVstoq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771880; c=relaxed/simple;
	bh=CYvxgUfRHtd1RGEfXAVNRd+x/rjaLTfMf3D61vB6lYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N28dsV1QSNAj7X5JZVwNtyV5e5pFp4H0r65tHrjVBbv/ZdQ6jV4pkZGrLamPJune98xWm0clmx288AppfVQr6TKqa0gHn5yJIH+FVdcLhk8JofV0xScUyL/EJ4BCg3xVxIFDP9toMjSU7vsS6dtW2ehWPbaBAHmdLEdcHMXVqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkRPGKA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkRPGKA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB9F1F000FF;
	Fri, 18 Sep 2026 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789771878;
	bh=DvTBMI5YdXqSHeNB5tBT7OLO6g8e1o+wjsXAG11+soI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mkRPGKA78UhIxtvwAY6iTRMYXZukhAahfEhetKYNQZbIT5e+IR+q69RqEZXwW2zcd
	 4xGouS/ljqLJVf6Rb9V3DVeeZwtj6rJxFWxJCLVQ0U637ruoScCaO99/cv8NV/B8wm
	 2vW3qKVriAAdW5PitvCqQYf+3NgWc8Kor9EFandXpf1geG+yCh8f5lKr1eE/sqOd9i
	 53LDhx24EaARGN3ESpO0T0Fm3UpCAbGeKmGrfF/ElQHJ6VwxBikmcci55JwzXyllOh
	 8Qw8oNH4+ic0QjaqKbnVwRY7AxM6jmsQrbfuv/eyXwmPEIGbNHw47bdBa7eT/3sfxD
	 foIV1+tBseZEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19CFE381196A;
	Fri, 18 Sep 2026 22:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: reject invalid and unexpected GRP_ACK_MSG to
 prevent bc_ackers underflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977181170.1178488.789081349546153625.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 22:50:11 +0000
References: <20260913044233.193927-1-edumazet@google.com>
In-Reply-To: <20260913044233.193927-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jamesburton@meta.com,
 stable@vger.kernel.org, security@1seal.org, tung.quang.nguyen@est.tech,
 jmaloy@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 04:42:33 +0000 you wrote:
> Commit 48a5fe38772b ("tipc: fix bc_ackers underflow on duplicate
> GRP_ACK_MSG") rejected duplicate/stale ACKs in tipc_group_proto_rcv()
> by returning early when less_eq(acked, m->bc_acked).
> 
> However, that check remains incomplete in two ways:
> 
> 1. When grp->bc_ackers is zero (e.g. on a quiet group, when replicast
>    ACKs were not requested, or after all expected members have already
>    acknowledged), an unexpected GRP_ACK_MSG with acked > m->bc_acked
>    passes less_eq() and unconditionally decrements grp->bc_ackers.
>    Because bc_ackers is a u16, this wraps to 65535, causing
>    tipc_group_bc_cong() to permanently report congestion and blocking
>    all future group broadcasts on the socket.
> 
> [...]

Here is the summary with links:
  - [net] tipc: reject invalid and unexpected GRP_ACK_MSG to prevent bc_ackers underflow
    https://git.kernel.org/netdev/net/c/99cc2a62e07a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


