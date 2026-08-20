Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D43C3BED;
	Thu, 20 Aug 2026 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257881; cv=none; b=OaOTabJhwcbU0Sy8GbkeHuyBQ8SsSpO0plxyiBpMmg+LNdqsErErenKzUxQFyijPHq/o/VKIl+EGV/ztRr04Wy1ffgIhO2BuySKKO6GerPfrqDg8k5kCQIvblvKHJm3Q6FNlSgP9BxWeJd4jw3Yv4jxuN/RrpMNCMsfb83/cM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257881; c=relaxed/simple;
	bh=oPPEqWg54BZos1qdS0KYs8k+In6R3o1sc2dHKxPaqfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uUO6fwO3lLZRWZhB1+WvK/r1KXsahKsi1ddmnBCmLCz6kivdj8zJwuy+HF6a08hbkhRZrYPAS+n7W/FMO4w25wrayv8Rtbhw7BKKETwX1zO0g0Ep0SPjal+79enbVb8r73zACvrGzSKlX7qbqHkxZQOCjC0jd0wjJ3yQTIFXs8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9vntcEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9vntcEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BC61F00A3A;
	Thu, 20 Aug 2026 20:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257876;
	bh=5tuYkouMIEcOArFytrs8YKMb7M1bAek8TM5fLRAeDgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L9vntcEh8neJKtXNfS5OoUPul/kH3cQcmh8l1FNInoAeIiis+QGWwGLfrk7aP6LOy
	 m3xLrSAmtRErGoOfuy7tjF6GKH7BvwMETRHHTgYpgF15BY/OItfIWYmPVXTIqGTDOB
	 r/5/Is41z3h5bc5jSBz6HNUDoV+heeOiiUKbWcGpdLQv5MlwCOJ9aneVWAcqVAtYdz
	 saF7fzkQcsqTDT6lKO+K0X8L3Vk9RTFMQJl2cYN5YEx7awp3vrYhubs2cfZ3tLHBTV
	 IZOAXVV2czdqLK9Mu6UTcGSzIyAB0L8Ntgvtjd0404gF5rUcF5H0+Tg2hw/aBS/bC7
	 V4xnYFiilq3Xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56751392445B;
	Thu, 20 Aug 2026 20:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] batman-adv: reject unrepresentable multicast TVLV
 offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725782688.470503.16295189825749503544.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:30:26 +0000
References: <20260817084955.944189-1-david.lee@trailofbits.com>
In-Reply-To: <20260817084955.944189-1-david.lee@trailofbits.com>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 sven@narfation.org, kylebot@openai.com, davem@davemloft.net,
 linus.luessing@c0d3.blue, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dominik.czarnota@trailofbits.com,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 08:49:54 +0000 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> The network and transport header fields in struct sk_buff are 16-bit
> offsets from skb->head, and U16_MAX is reserved as the unset transport
> header value. batadv_tvlv_call_handler() sets both fields from a received
> multicast TVLV without checking whether the TVLV end is representable.
> 
> [...]

Here is the summary with links:
  - [net,v3] batman-adv: reject unrepresentable multicast TVLV offsets
    https://git.kernel.org/netdev/net/c/f12c2de4f542

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


