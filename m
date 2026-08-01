Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35E356777;
	Sat,  1 Aug 2026 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785544244; cv=none; b=lB1lRWdXA6MpxJO+vbNZMa/fYgMVW71rB1DTN3xibjHcwiCNWJWK3UAV9RFpjoModpNY4yyJajUKb9Ap8ircWpkJaDn13ACI46WsaHa3tmUKhDbjy6ERtJp8GHrHgWZGV2wNOPq4RE4yJkNGQcldJUioxYb0DUQeh5wEZ4pr1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785544244; c=relaxed/simple;
	bh=fCGi0GRhF+7mCtLhidRy9ZUHhqBdOeBC0l2DAz+9Ohg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E+BueamGeuGO85+X1CGuG3fgE3fjazKKPMvMDxDAO7En7wTfG3ANU889vkykpuMmbHsPjGY4OudB6lXv0HsqT0xohOc37Lp6rnKXsb/gwFLvwL6/1uh6O56aY24P26sCQPX/EuZfn0Ctx9c0h1wWPlAjwUyBCQId1RUusq3BPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cH0HfU/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cH0HfU/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE781F00AC4;
	Sat,  1 Aug 2026 00:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785544243;
	bh=HOc8wkH4KWlK6hAfNL1YUhl+QnqMwHZ55C5ARdDssHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cH0HfU/yJfu1HaBmSv/wQwVSzwZBjo3Ty1QzJp1K7xQm5I6r447OFzje22JR944qX
	 4LjwjAlYjFqgy9GbMvEme0s+hDTmK6Z/X66ELwWxO6APTBGfp6gAEjFFbU8cfipnWX
	 FvNDgYvu8z2/XfTtLH3+rGvyf47jd8cl/UjbNdUuwn2IEJXXeUwu8nqOVn2E0oL8lg
	 kmHtHO0ofEqOjmztnEPQcJ8A5iLh+44CQv5ITmZKSpdfiXbUeneZjTcp1Dpdx9tPIS
	 OUagnD6x2ox6RZZVXbmH6DKEtE05eZjfhmZsi7jrUGPxQGGV13B8KKKtmJjSYdoS9J
	 0dpn2z/yes91A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568CE392665D;
	Sat,  1 Aug 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cls_route: fix fastmap use-after-free on
 filter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554420589.962130.16882000918810831215.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 00:30:05 +0000
References: <20260729094411.46257-1-jhs@mojatatu.com>
In-Reply-To: <20260729094411.46257-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 john.fastabend@gmail.com, jiri@resnulli.us, zdi-disclosures@trendmicro.com,
 santosh.kalluri129@gmail.com, victor@mojatatu.com, security@kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 05:44:11 -0400 you wrote:
> The route4 classifier maintains a 16-slot fastmap cache that stores raw
> struct route4_filter pointers indexed by (id, iif). The reader
> (route4_classify) populates this cache via route4_set_fastmap() for every
> classified packet that hits a filter. The writer (route4_delete,
> route4_change) clears the cache via route4_reset_fastmap() before
> RCU-deferred kfree of the filter.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cls_route: fix fastmap use-after-free on filter
    https://git.kernel.org/netdev/net/c/47d7f7051253

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


