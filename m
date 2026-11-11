Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355212;
	b=gQQyNtLheIA1Ef+02QPrM2mchCHj71LlzL/+Pr35ewCToM5DDSDt5yWzWdK8UzU0TNvb
	 /let4Y+xHYSngjPGR4rO3P6B1k9+rUztyOZ/gUXy7hh5yjWPOH8WbemZupZiv0cblJU/B
	 asBU2StWpmRAaFcyjvzd7489fg3GCxYJRlLITDixGeEfV4Pi/LDEOCiZcP1caVXHrjiRU
	 857vKul3URrvvrcS9Qs3glCbruRDrAqrQlaEyILSyEboM9C/UV6vTAJZ4A6o0q5FRT4nt
	 LmBLfBwEG2aUGdX9nkh17Gl19B5VLlDNgsCoDS7iTjyJQglcTkHUTKycqvStL/Uj+pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2V2odHw5C1ZkkpeHbdSVGWqAI+/qYN7jzWWhm8KUJyA=;
	b=nlGKdEPuduAXekwTrGTE/rmtDgnrRlvUY+xDG/hsFbjdqnHfHMvdJtGb4AB4WlXLvDbP
	 IfOnQKcJZ7RCjaFricbD4iRCohugY6OjxpjUL6qotmke2uL93Go2/fRxuEbu2zc3Nlk/U
	 ut8RrqmcY9H9JJkRbHot8ya2TzEaW2I9VVH+nCdMTfj3NPRjwPIRQKiTnzG5mi9ZJ8kvK
	 adjsyWef+F3Kg6o2eQfw4XAVeeJlW6hNLU7TdB1/tXc4Q5Lt5Ubp6+qqqk+lUgsznZ9w2
	 hZ9R2GRoHJNBrgkUMgvZkdA8YcA7/xsCLAFfc8p1kEk1RmpLYnFXsDYrvn0e8mvot6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOWsIOl5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC5606A32E;
	Wed, 11 Nov 2026 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOWsIOl5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD611F0089F;
	Wed, 11 Nov 2026 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355212;
	bh=2V2odHw5C1ZkkpeHbdSVGWqAI+/qYN7jzWWhm8KUJyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dOWsIOl5Zj4B3Few2VK4ZvCoUN6bHYaGQm6UgrIHhjAxtGUlnUUHZ/kr3wv15P/YY
	 6lJowviHeJ06bk7YIUKO1YYfZrt0eml6stMCdXJ1NW134VLrIMWv/P79fPvaDbcY0q
	 94G5XRNIGx/WAOYYb8/eV2Eo5zKk2RLGn0TBRiA2U8BylnMHnRlzBV7rpHgj/Lbjdx
	 prHUKDAWJUT8xx8R3doltyOboQFl4bL8l1gEuu5YfH+hjAJp9G5IUkjN+I2NKRIYkN
	 OZY2h188NjaZoGJ/pACDbFJD48fKReCr0yu04ojdOYSkiVpwNtyWoIY0HHnBA1USnS
	 trMxXRaPV2XKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2103C39E8A4C;
	Wed, 11 Nov 2026 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435521067.125436.9895323339042656331.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:00:10 +0000
References: <20261106-fib-trie-nospec-v3-1-53da6550dcf8@nvidia.com>
In-Reply-To: <20261106-fib-trie-nospec-v3-1-53da6550dcf8@nvidia.com>
To: Daniel Trujillo <datrujillo@nvidia.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Nov 2026 05:02:23 +0000 you wrote:
> From: Daniël Trujillo <datrujillo@nvidia.com>
> 
> fib_table_lookup() checks the child index against the bounds before
> passing it to get_child_rcu().
> 
> The index is derived from the lookup key, which in turn is derived from
> flp->daddr. A userspace process can therefore influence the index by
> triggering lookups for chosen destination IPv4 addresses.
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv4: fib_trie: prevent speculative out-of-bounds child access
    https://git.kernel.org/netdev/net/c/fd3d73286662

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


