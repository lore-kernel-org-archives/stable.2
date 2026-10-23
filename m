Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797010;
	b=XroEU0xLGh3bX6LWp2vFf9LSMq6v0yRFWOy8mQQ//fpakf1aAhxklPClMNeDjc6igREK
	 jp1tD3QsQN/ag3Mmvp3JrNq3BgYkUv2Hnszf3ctl6nbWe/sAZwCj8c4Rw2m4QjzN4aNej
	 YN/lVv+HCLEhJCeWcJVUwqraBqhlk9tgAr7EzrLD6BXPxtLdOweR3DaYMXLFeSxjUQnAT
	 vvAkJBpkMn4l5NIL5AN7EtvprYT5nqz3kva41km+DMc3fneVjL42uyqp4VryrW2cDj/ej
	 5LbxxM2v3tsBSZMl6bXXe673aqnqqXx8zGuwVzaiXh8LrjjasLCjyGIcMIrTdOPQzkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=MIrAFhWXAPIb7lEuheQJc4PPEjxhRvQnGG7L3QhTTS0=;
	b=3CFm6r63lDg0csYzU9ZfNB1ZTfiffce+/M49PqFwRjcbOBC+RKtKO6IeK0/Mu4FBY03S
	 KrbO7vQeT8oDfOxZntzCZ0P5sPMWvp0WC5FTH60huVfDjK06MA1c/ZIi7c3KfxnPMJFmq
	 Mg4qWCCjkeIirSSMzm02t6rSN7pWLGNX4oD+PSc7jPolahzVEOA7gYGJVLVpdJRLe1eHk
	 ZMh4CDxK2t2bfK1LvqmsP9K6KHffi1qn4NEHc+R9r1dmGiFOvqepk1WEBKfO4ORElOznv
	 +XZFHpiCzaIFkhUb5EjK+Ix8AkV4GFio88h6m1NtMGjs2YhmU4WV5XXCTPJ09P7yUFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tk1mxgaO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9C606A334;
	Fri, 23 Oct 2026 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tk1mxgaO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA6B1F031E2;
	Fri, 23 Oct 2026 23:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792797009;
	bh=MIrAFhWXAPIb7lEuheQJc4PPEjxhRvQnGG7L3QhTTS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Tk1mxgaOl0SDRmoaEBsgEEIIES2z/ZAHOArtAag04sG953btzUd5zLyLbGYJqZe4u
	 yp7qeKz+bpBYAmJW2lf6632XWrKqdroOrMlCxjwReRd1EZ9MzHwqVO3r5PoTSI3Hdk
	 JI0ct+DgU3jLWF45gWWYTzoNPjFvT2zQTiKB5wJ2ZkiEqvxETct7nyZT2pMrTlQZTi
	 o8otwmSe6xepkfSHQ6qPJbDsQU3UmLKrJ8LJaopLuQ2aZ37vLKfzPd0j5fFAmvuUq6
	 PlGWRZX2P2mZ/rKa74x4pI3W/rCy0oDT2saDrxjFXrcUL0xoHQOAcEjw26NYsKXpoK
	 rrZ/hfCIXtiCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4449F391B16B;
	Fri, 23 Oct 2026 23:10:09 +0000 (UTC)
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
Subject: Re: [PATCH net] veth: fix stale peer max_mtu on XDP program
 replacement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179279700781.1316845.9472584301770180599.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 23:10:07 +0000
References: <20261020020147.790274-1-yanxia@cmss.chinamobile.com>
In-Reply-To: <20261020020147.790274-1-yanxia@cmss.chinamobile.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lorenzo@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 10:01:47 +0800 you wrote:
> veth_xdp_set() calculates the peer MTU limit from the incoming program's
> XDP fragment capability, but only stores it when no program was attached.
> Replacing a program with one having a different fragment capability
> therefore leaves the peer's max_mtu stale.
> 
> Replacing a regular program with an xdp.frags program keeps rejecting
> otherwise valid jumbo MTUs. The opposite replacement leaves a larger
> limit in place and permits MTUs which a fresh attachment of the regular
> program would reject.
> 
> [...]

Here is the summary with links:
  - [net] veth: fix stale peer max_mtu on XDP program replacement
    https://git.kernel.org/netdev/net/c/c955325db639

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


