Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6338F930;
	Fri, 28 Aug 2026 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953266; cv=none; b=a/ZrnYUCMbDtuB35sx6iVFGGw7M9JBB9gkkYofx33pZXyOEuf+DvPjVxjFRNjTExHvJEQYs02NafXJ5XSK+1eByA7XN+f/qTKxDHtE016qIXMTQ9k0VLl4oTQKY/ojBK3YI7OCIXc9DTdVQKP/dB1sxSFmSIDxkx8CbAy80VdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953266; c=relaxed/simple;
	bh=1nVbRLlnc5pp1GGpqSgriShJO64Z+HUZmV5hOfrZ114=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oeu6eosCXDeEdeCYG83IK+XlPCmYaxDQRB5Bd+1Cj4IbKT0jSV1HB8DJjrUwqXnkZEdadwX/ajU2REYAHrPkyhJjj1emAceqq66yFp5cORgOLczvQcX69InQpkz4xjghLXhrfGMFvPGNUsWpLKe4D1gOCZLc7Akb/paEz5yUAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tiz+Jez9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tiz+Jez9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9A21F000E9;
	Fri, 28 Aug 2026 21:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787953265;
	bh=KrvkO2ccwy+eQ4k/uKQTv0w8AiMY4F4re4l5qc+6P9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Tiz+Jez9d/Mhnm15WhTUF1vH3/7WoB7rqwO097oODQPyxrXi76tvFbQfWck6lh/g4
	 Oeq/2sulqW6lqP6vvzL00W9K4MobYtDU48fY4Prm7yABegChWOAHquDjoy+Ruv5seo
	 DBXbNMnCKAIXCL+pNC1jVgocM+TycSlvFGudG6YUBWpMEzlZGDXJ2Mf1/63DdHcdCq
	 Laxfv0rrqukSsvzAt75B+BNZzpYtLMUFpdmtfsAGfPXaKLlAcMgH2dSYFWDRtXP/SX
	 2YXBkbYaHv0C9J3UBZtRBRrlxPgw1FRtvEf9LjCXVDznucmMd4/TSQge9BDQrUY1iF
	 zIR2d1MZMNomw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C0380AA69;
	Fri, 28 Aug 2026 21:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] ipv4: avoid divide by zero in fib_rebalance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178795321005.2809934.10801359002535054406.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 21:40:10 +0000
References: <20260827182514.4667-1-zihanx@nebusec.ai>
In-Reply-To: <20260827182514.4667-1-zihanx@nebusec.ai>
To: zihan xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, pch@ordbogen.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Aug 2026 18:25:13 +0000 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv4/fib_semantics.c. The bug is
> reachable by a non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] ipv4: avoid divide by zero in fib_rebalance
    https://git.kernel.org/netdev/net/c/5046d2880fec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


