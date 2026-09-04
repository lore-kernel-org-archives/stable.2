Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F631716D;
	Fri,  4 Sep 2026 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565271; cv=none; b=nc8qdaWzFN8hD3+KG61ZfFwja+ib9uoAQLW5lB1hfJ7FfVyHc3oJACtmrn5Hx2gjNJPy2Jv4wNAJ4fdVGVtGcVTJ7vv/f8d9LQF25Pkd51XhV+eI6FJO29vHZfflQ0fWsl645lEPp3YKc9E56kEIssb1DTXtUCHJSilLrb4eyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565271; c=relaxed/simple;
	bh=n7BBZpH23tbPgcnxHkNC7x6fjYr5MNyTcsQX0mbZL34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=day4qfpu8g3DSGNJqdCI5A9BoQCNoj0qYrda+lr3UbGzS1VmphtA7Cwl343L0T/VMPsHAAL2lk60LpwLxInl8mYSoteH4zzq0EuNPfOc8aoYSmKqcw8t5hy8ID+wdIUx6GgBOqWjGhPzPBI42sjt7jUNp9HalJzeMB5QR4RnuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1illChG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1illChG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8591F00A3D;
	Fri,  4 Sep 2026 23:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788565269;
	bh=qaHgXpfnp/h4GXHHgLdFYBamein3Xy6trVzat+Kixy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m1illChGEwdolJMwiaSsq3/BYuxG0rvUL/DuHD9hiq7/uainQXZZAmcR5Fw0+h4JG
	 gpO+5LxIrj9b0+vylTBYO5eA+rI2IY4pCgzVR/hJ/xnNva/g92Sgj5bcmqdmhKz4mU
	 QM+iG/FgK8BoZ0Nve5KnUQ8ATDqPWyLRchwvHtHrmLdxzsERqPlhxdPW8XoGLu7UiL
	 1XYFUarW+m/BvjBdWkaaIuJn8uGlBwRocFv/jh/uIpC9Q34EieOMJGohtiBZA5/nv/
	 xUQnMdscdVPrRaU1X92jnLjn9hF7rpcM5WvgUCPYy5BDv/k7fwfaaYddlx7xdv3Wkm
	 t5ZiX68L7C+1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AAF3924FC0;
	Fri,  4 Sep 2026 23:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net: cap tx_queue_len at S16_MAX to prevent
 oversized ring allocations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856521039.1019727.11940822267177362056.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:40:10 +0000
References: <QDISC-2899.v2.20260901233641@mojatatu.com>
In-Reply-To: <QDISC-2899.v2.20260901233641@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, donald.hunter@gmail.com, vega@nebusec.ai,
 victor@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 17:29:07 -0400 you wrote:
> An unprivileged user (via unshare -Urn) can set a huge tx_queue_len
> and exhaust global memory through ring allocations sized from it
> (pfifo_fast skb_arrays, tun/tap ptr_rings).
> The reproducer from vega@nebusec.ai set the following params for
> illustration: txqlen of 500000 -> ~32 GiB/ring attempts, 1.6 GB tun,
> ~960 MB tap. Gets worse when you consider qdiscs like mq.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
    https://git.kernel.org/netdev/net/c/66ab4c59b74d
  - [net,v2,2/3] net: reject oversized tx_queue_len at netlink parse time
    https://git.kernel.org/netdev/net/c/1aa9e143bf51
  - [net,v2,3/3] selftests: tc-testing: add tx_queue_len cap regression tests
    https://git.kernel.org/netdev/net/c/0a7252d7f854

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


