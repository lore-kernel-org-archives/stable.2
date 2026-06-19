Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4B331ECD;
	Fri, 19 Jun 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781833219; cv=none; b=S+Wx75BzoUNhqeq4NC1oJy42yq8scVDeEqOfao5u2+16MNBTFfZJZC3ShoCv6hnVTu2NYmZx0glVqkdG2XG/Z+maO+h87QKifMGQDPu92/FTASqX3bX8G5Uhy5TaDAy+kgx/ioPyj8uIkMWYKVp3bNjEnAnFlVdHGLtNhVEjlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781833219; c=relaxed/simple;
	bh=OMGc/FfEktxfQRVv4yh+XP3iVxW1FKHFnlBq/V1UXQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Msz1SWmjVW8FiylBQOiQ4cQffako3oXTGoduwY/TNfdkNTMEM4Lk+nOva1mxjX1foPLEUeNPzdxw56lcAJ8W1UGMdShqEbg8lYz3Orpq4x1x6hbW8gpLQ83fubVgLN6PabiabdFToR6PIGd1HwndP0bfUoBHnNC7/bSfX/W+oLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUN23Jw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUN23Jw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157281F000E9;
	Fri, 19 Jun 2026 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781833218;
	bh=mK5BfPSbPbNmSJfkqLieA0AlM+6/LqQH26cAtdI2oDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IUN23Jw1+XGWT5l1yVU3NFefMJJ0MOtP4RlpoJA9TKHI1IV1YXDrDQ1H7dAOPZcAk
	 BxYrS/KO+vOoaPLLV1PrQTsH1gdQpwFlKzuegdgdy3mgqCvAhJqTePAFTTVsL2et/O
	 9TMU8W4V6EhyJRkzdnxj9T9SaVbp/cO/XDdYe/q01XgmT67aE9qPW8jAQL/A2F2DGL
	 pT2NJQwazkqmLfYAMV1o/1eA9r6vkWc3xnZbqUe7RhxxhlRXJq1vYZQQoBGgx0yW7B
	 vza5f9ihvmcRm8unhr8e1TVN5FDJ/P0bQc8hQR8il6jIvgP59+geM8KiuNCOmSAFdo
	 9JsbEHIshMDgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938E23A78A7C;
	Fri, 19 Jun 2026 01:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] tipc: fix slab-use-after-free Read in
 tipc_aead_decrypt_done
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183321113.3155315.15934048751827396777.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:40:11 +0000
References: <20260617075818.37431-1-doruk@0sec.ai>
In-Reply-To: <20260617075818.37431-1-doruk@0sec.ai>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aleksander.lobakin@intel.com, tung.quang.nguyen@est.tech,
 tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 09:58:18 +0200 you wrote:
> tipc_aead_decrypt() goes straight from tipc_bearer_hold(b) to
> crypto_aead_decrypt(req) without taking a reference on the netns, unlike
> the encrypt path. When crypto_aead_decrypt() is offloaded asynchronously
> (e.g. the SIMD aead wrapper queuing to cryptd), the cryptd worker runs
> tipc_aead_decrypt_done() later. If the bearer's netns is torn down in the
> meantime, cleanup_net() -> tipc_exit_net() -> tipc_crypto_stop() frees the
> per-netns tipc_crypto, and the completion then reads it:
> tipc_aead_decrypt_done() dereferences aead->crypto->stats and
> aead->crypto->net, and tipc_crypto_rcv_complete() dereferences
> aead->crypto->aead[] and the node table -- reading freed memory.
> 
> [...]

Here is the summary with links:
  - [net,v4] tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done
    https://git.kernel.org/netdev/net/c/bda3348872a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


