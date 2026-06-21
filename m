Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22525377541;
	Sun, 21 Jun 2026 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080427; cv=none; b=Jaeg0LPHuAb+ugV/+JIRoR5WBWWKtcpJ2utveDlC7/AaTvW2ZtnAIufDpLOQaOQ9U33xd75NMIjQo+aHU8QDpOYWM4ftMJTsqcwTNwKYvx6LSArwun9dM9hjc05fQYogCwh6DwBA9qyK+EpNx0UP7bIPEcUy7fmMKHR3hp4pGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080427; c=relaxed/simple;
	bh=3dDOp9MZ8r9bN/xL7eWh7CirIggpgGv49X6zKypIoNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZahNhOuaoDi9Gp9oUJEDx0VHT7ILtKZA1l6XJ1rz0hbXgtruBg+opmQZyBsdypqDvPqALmWYrpqkx+mD49dCSsgSZjLUNencAbaY0A1FiK8Ne4Egs9Uf0rW39DkieeeJftG5+ieMk9QwenJcHhXAULPgPzQXaKvNzcJPE9jN+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRkPyYJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRkPyYJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18221F000E9;
	Sun, 21 Jun 2026 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782080425;
	bh=h5u+SbbxToIb+xFR7jv01f/eXTnMKs+MknvmlgN9Noc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TRkPyYJ8NrhthlPxANOzEY7p+wmHGJpWu+8+WKuUWBY43dzUblwf/WsqqC1pgZpJr
	 /G8Vi0D6E1UVzzRvaUqQqlDUAdb2797yYqpRStK5oZ2wyw94p8UMRd9Ie7Bv6z1dYj
	 tPqOnz3b7wX0bLce8LbTej6HPeV0Hmig21oePDqlfiLNByn1zPK8dhUFWSEamiv939
	 N577LIcdfV5wJI3E78CSO8VAHgrlhYZUsxoVO0Cuj4eqj3kGw4C6zSQOB+yDPOOifa
	 IcC9/tTtMFIQQOpXDQAR/uRf3FVWlLWnlbzL100MsVG+fKarKQMCPhrhhHo/dVPYPz
	 lPAle18tqyGQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568593AAA6EA;
	Sun, 21 Jun 2026 22:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] net/sched: dualpi2: fix GSO backlog accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178208041698.521994.2221997843607736583.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:20:16 +0000
References: <20260619151447.223640-1-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-1-b1n@b1n.io>
To: Xingquan Liu <b1n@b1n.io>
Cc: jhs@mojatatu.com, netdev@vger.kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, chia-yu.chang@nokia-bell-labs.com,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 11:13:47 -0400 you wrote:
> When DualPI2 splits a GSO skb into N segments, it propagates N
> additional packets to its parent before returning NET_XMIT_SUCCESS.
> The parent then accounts for the original skb once more, leaving its
> qlen one larger than the number of packets actually queued.
> 
> With QFQ as the parent, after all real packets are dequeued, QFQ still
> has a non-zero qlen while its in-service aggregate has no active
> classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
> the result to qfq_peek_skb(), causing a NULL pointer dereference.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] net/sched: dualpi2: fix GSO backlog accounting
    https://git.kernel.org/netdev/net/c/05ed733b65ab
  - [v3,2/2] selftests/tc-testing: Add DualPI2 GSO backlog accounting test
    https://git.kernel.org/netdev/net/c/54704b32b2ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


