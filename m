Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD923393C;
	Thu, 23 Jul 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800841; cv=none; b=TgoXzhLbkPzyBblp62CWuFL4QN0HH6ukfCZHbiHzU3SpkNC9hXq+xXEFme5kiFNFvtPyokLeSKRqxoE79ztWUZrrgCMUtrxk/ApFvebxaMaRdYWFhBTDbQZ12lJ/d7ff8RcamaMRySumHbXBAas0KaZ+fCnW2u/qIxDsRsq8SQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800841; c=relaxed/simple;
	bh=yLwlWMjGlmNOvX2xqRqyDkGHLz5Mas6s2NWIMsRLzlM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MB04Vk8E2MguNLT89bqPe1m6tE4jmZz9O3uBYioyTjXRGTRJ1cryekum9NyDkNK5CF6bZSrXow93wiBlLfIap2YDBb46yw79y5EUcI0oThgCe1+8vl5cxbCDjCTK8o+Hc56NFa3+nklVhMcRvqx6D2G7asx3pnSLQlnQ3khJOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fraicX4t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fraicX4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C9F1F00A3A;
	Thu, 23 Jul 2026 10:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784800839;
	bh=64jLRdjGOV13XRhg3nTslFaj9ixO+K1fBIX/mLV6wSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fraicX4t3Ak5ud/2+rXGbx1bddS5khQ4jWvN/fbxh1Nsa0O5Tz/UfInzmWM2sg644
	 xENnMZ2A9Tnxs4qyQpSF0XLLAJC5FzBnjnRw/jGgyXnbaQoOiLZG0kYc0T6nMZblok
	 gfe3aVUM4uczcv67W9IOdeulcCYxdDFfIBo1KhYotcWwlYwXnusJSH3kcm889STN1s
	 9AdctGuXyhKQ5l412vW5gbbX0nBEUN2P65mdkTQxxPimCGmJhHsAnmXHcyxY9K2uDl
	 vsgh9fsTsF6f8B1zCz8vqPeAPNEQXx0jXvkzbC2ihv+htP8tYuxFcKMYIRZ8VCEw4e
	 mmrKKZyes58Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939073810902;
	Thu, 23 Jul 2026 10:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178480080614.2220921.17021057508770530521.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 10:00:06 +0000
References: <20260713104752.241175-1-david.lee@trailofbits.com>
In-Reply-To: <20260713104752.241175-1-david.lee@trailofbits.com>
To: David Lee <david.lee@trailofbits.com>
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dominik.czarnota@trailofbits.com,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Jul 2026 10:47:50 +0000 you wrote:
> x25_kill_by_neigh() walks the global X.25 socket list looking for sockets
> attached to a terminating neighbour. x25_list_lock protects list membership
> while the lookup is in progress, but it does not pin a socket's lifetime
> after the lock is dropped.
> 
> The function currently drops x25_list_lock before calling lock_sock(s). A
> concurrent close can run x25_release(), remove the same socket from
> x25_list, and drop the last socket reference in that window. The neighbour
> teardown path can then lock or inspect a freed struct sock/struct x25_sock.
> 
> [...]

Here is the summary with links:
  - [net] net/x25: fix use-after-free in x25_kill_by_neigh()
    https://git.kernel.org/netdev/net/c/5499e0602d2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


