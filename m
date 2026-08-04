Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C13EA66;
	Tue,  4 Aug 2026 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882646; cv=none; b=PNV9YKSsta9RUb4fPfE3rbGGlh9KcTOVSjXMwARU4pwDq7ETWDhe3R2uPOVApWZJqNEsNTbbIamc6jtklzKL5LzR+/VobAy4q8knKi/OrSEER981Xhl2QawzF4RpLi6xKgwpO1wi53SiNwdM/mLPrwl/djIfIZAlEhathlH2XrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882646; c=relaxed/simple;
	bh=R4meS5TRxOPrYTgAHKeq7Mr11/rRHStJ1OvMdrYJ9eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vj7AMwQZ4Koy4JNEf3lGwfVYkuO+tOWW1lXhCo6OU2UE4YHoGLfwRGiZRwcJ+SGQB2Tu3p1cf1/9iVPn/vV6/p6a/rzCsJTc4gvtN9b1kVmc6MH6UMsk2w2gzTC4yssBkO/wxogLyE5I53kuf6PxLTnil2kTRyfy/kBCT5rs/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4k6xtpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4k6xtpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274371F000E9;
	Tue,  4 Aug 2026 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785882645;
	bh=qumM/ZUvhwCYG8/BhtTMQCcxLsfhFjHB5gMQ4M558k4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K4k6xtpAmJCBXq/WO7+NJwcEEQVvsGTlGaRZD7oXeH7lDjy7uvABUrYnroTkJOIj6
	 WqyBg+Vxqop6H+c2dRM21muAM0Q/0jpwEsndr3zlgqoTEJDykxAqyd6ODx7stF+r/d
	 oCqFd8a0OXf+U01whnyllLv3pAbtmcOi6Y8q7K5O9urkTRhK/ndqjOPqWydi8WlyNS
	 lGmWJQGIZrb3fQfaGGtfe6HuVS1Zez9yzj0ubkDFngpzdsvlYhxVT4bXTYgNYNwIj8
	 vG6N2PlG8IUw4WWtpVGFw2L66tTQaR+jTIsPotT1T30o7Ud0DkaVjHuOSkfRDTCxxt
	 jLHEj5u42VXJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B8E50392664C;
	Tue,  4 Aug 2026 22:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: prevent in6_dev_get() from resurrecting
 inet6_dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178588260564.3813627.866249845630224776.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 22:30:05 +0000
References: <20260803122758.666112-1-david.lee@trailofbits.com>
In-Reply-To: <20260803122758.666112-1-david.lee@trailofbits.com>
To: David Lee <david.lee@trailofbits.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kylebot@openai.com,
 dominik.czarnota@trailofbits.com, sven@narfation.org, horms@kernel.org,
 yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 12:27:57 +0000 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> in6_dev_get() reads dev->ip6_ptr under RCU and then unconditionally
> increments its refcount. Device teardown can clear the pointer and drop
> the last reference between these operations. The increment then
> resurrects an object whose RCU free has already been queued, so callers
> can use it after it is freed.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: prevent in6_dev_get() from resurrecting inet6_dev
    https://git.kernel.org/netdev/net/c/0e243671bc7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


