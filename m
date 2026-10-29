Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290212;
	b=HJ29gzQmUfkHtOHGz21hxqUXiKwQZbc+xRgSx19NSwDB76jhEZnUPmjncs4cMcEkuPiO
	 ULd9DA0/vCLEguJ49W50WqSIuvuAQpIuJJnlGl6NWdNniMBdJELIICWvctOuO6+5BCtRr
	 aUZe1F9GMJs7B6IL5o66nklwy2zf5hq99g07Twten8S1kd82iAyv1J4XR8OVc7xP6aEzY
	 MBjBlwVUP1T6CATWH9sfXNlMMBwrPg82yxi+22Y2vddL0vgWhEPu36GwyN27IHK9s5PnH
	 mehxg9BFm6omK5+uv+IYh3/PzAOH6nG5sUiYLXXyXVt40rqdGl2o0X+Y25qxlmnJPlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gvdo6UhNV38uYbvU9MdvDPD33qtyP2Hg0RyJi2Ujyjg=;
	b=A1mv/tYwPs/Q+2BP31Fp3v38G069XC35mseQ6W1cLjKG9BQnAgEbXivybLRcYWLKJv9/
	 9hFfY3RjERIjNoqrJLsp8ZpJvH7M85ladLXkzHg/8aW+cv+jBTI/EQGfCOWspwrWV0Z+S
	 /A/yUWVSO7XJuwBJAdjysnY0/JuI20Iqd9uzppmw6EFxzdbjjX/ZuYuZeWxZRbdrrPmdG
	 b0bdwr1KXcKGvG3bcfXjuLcvMXdS5ptWt5mKUbI0QQVQgT0FdYhTzTFhALOQ5skwdZbKU
	 xc/BmQSImSLIzVg7Di40Tw7SWCvwSuIoBSARll7UQHo8+0Uc3Fk4fFZ3n9JUJ6iHvtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dX2Wy+57;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892660A3809;
	Thu, 29 Oct 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dX2Wy+57
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32321F01829;
	Thu, 29 Oct 2026 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290211;
	bh=gvdo6UhNV38uYbvU9MdvDPD33qtyP2Hg0RyJi2Ujyjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dX2Wy+57PJGLJwMrWBqUi9n9iC4SP11oZcFmTIeM04hN7V/l1a9JZ68ZUQF5TlXXt
	 OTTStSNLuTSoKTuBBFcauLYg89DuYXpUpI2TZuGykGcZXa0CbGQWYDgFsZLoanu6IT
	 D9PRJ5kM+wbiRTgJixJyRLir4fKFawXxnD90WTaZqUQyACFQlmkv8I+K428NZg4/Zs
	 vHAMljodCwZGBqQzP/pRldNS1278FHnyg9cRVmQ4QLcIyDlbwiOstwnNIqdvKlWTTF
	 wluWfux0xqay+BdQgHsTtHPO8Bl1s6yhazaQU73X/Ge4KUeYpStuAyendCbbfLF3e7
	 kbk3tbm+LVPZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3163808221;
	Thu, 29 Oct 2026 16:10:11 +0000 (UTC)
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
Subject: Re: [PATCH net] net/packet: check TX_RING fragments before memory
 accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329021045.546068.359093054305133059.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:10:10 +0000
References: <20261028181450.2221013-1-edumazet@kernel.org>
In-Reply-To: <20261028181450.2221013-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, kylebot@openai.com,
 stable@vger.kernel.org, willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Oct 2026 19:14:50 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> tpacket_fill_skb() adds the full non-linear payload length to
> skb->truesize and sk_wmem_alloc before checking MAX_SKB_FRAGS. With
> PACKET_VNET_HDR, userspace can submit a ring-sized frame even when it
> greatly exceeds the device MTU.
> 
> [...]

Here is the summary with links:
  - [net] net/packet: check TX_RING fragments before memory accounting
    https://git.kernel.org/netdev/net/c/dc4dd12f80e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


