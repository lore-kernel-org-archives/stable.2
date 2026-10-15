Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A741381B0A;
	Thu, 15 Oct 2026 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062611; cv=none; b=dz0v0a0jzRjErggF3TLp52spO56Gfd5HOgUWPR4PLBMQRYRcGXdlvc187F+QxbDRo1ppUzFNu+z03YWlJcmQX1NLt4W2Ibw5/NZxsVKQPHq9K42RtEkHfV9C4QbVjwb4vhhc6dTVXuI1dqKiBD5Z0WJy24k1e3uW9/F6roLR8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062611; c=relaxed/simple;
	bh=p4eCl/qVCpYrVybyyT0uU/nCVkitGvxxHKDt+VlOgp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gB2j88oz6LwaTeIihilVtuezx7CJsBGItj9F0ji2J4flKE7fmO0yIa97XhtOXTHkYKaFfl6MFTiES9f9v6h/fMe/OWBGQwBQcRR8sjl02lTX3Kvqq0hGN3weMBnXvT6Jaz6WpHZPQm7nAWNj2B4/IONWEw78PJzlCGkNjOjvzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyvHCH+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyvHCH+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EFB1F000C4;
	Thu, 15 Oct 2026 11:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792062610;
	bh=4fZ0T/FRKNZKlaSurLx8IyMRUVHSqBKk1vrCoi5/09I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AyvHCH+6FbMvBYDM3JUSF8yFZrDLEa51vw8iiWHE4LJhIFl3DSv14kM78IMUb1+kG
	 0o08ezFhIYmpA1F7UaFzG7aDE80JKP209bxOeLQkrYWbd5nFQd7fNaOHCtNF/K/1tx
	 k2bT5zvoy8IoRBYI0LAIL+cddXmB0E9KJjk+f52pgT296OrQMNf9H3+Vkj62NPdauL
	 cageqmqYrEiUKaHBWhBpquz+fggZWxWh4fd7x6oYRWN7Ms+IttoZKrvk2rMe8P7hI6
	 sp5Ixspq69/Vm7JQkYBnwC40cRWKgOjhFp4koe+5eIsqSzQOin1eEtDftkAuBU9zOm
	 QQEH/tmIuHBZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1538392EA65;
	Thu, 15 Oct 2026 11:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: fix use-after-free in
 __tcf_action_put()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179206260877.3362884.12272330509635303725.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 11:10:08 +0000
References: <20261008181348.527035-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261008181348.527035-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Oct 2026 18:13:49 +0000 you wrote:
> __tcf_action_put() decrements the reference count before decrementing the
> binding count. Another thread can free the action between these operations,
> causing the binding-count update to access freed memory. KASAN reports it
> as:
> 
>   BUG: KASAN: slab-use-after-free in __tcf_action_put+0x327/0x340
>   Write of size 4 at addr ff11000000d46420 by task tc-put-pause/64
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: fix use-after-free in __tcf_action_put()
    https://git.kernel.org/netdev/net/c/7b16eb911091

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


