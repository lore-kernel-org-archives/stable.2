Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506407;
	b=w9aa6uqJydKNV1kgY1ja/HJuWKTlcNARJcV4eKRoiGyIv4YsbUmMuH+wz/gs1cWZDmBf
	 7Xb8M6dS8dv+AHCyv6dew0vi5nKO9HyLmIgJgbZCDmBpV4eFVlmN+z8gfCTeTqbnbsTGI
	 mlBv3PysR8qo7Kwq4aHQ/0T6p40TkNXvJVBh8BDh8FlDfrw0AxrqvvXqQ4Qi6wiEOyEPG
	 x15pb6g3TWRWayAqdzci9uedYFw3WbYmLR9FQcMddl/RtqpYdst+KvI1pLPFXXDSTvkSA
	 Hh9LLL5JXZ6eiCu/YMWJfyB3ujx+LAaiywD4ezIBiLR7UqMOznrXvFE56FzSPvB0dvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=74E+9z4uWRmmkeRkAU8beQOIwYaKDHbJfj34RGUWY4Q=;
	b=4a4zP2vFfTM4VvxMiorF5wFINfLvbERH16JLpJmGarsFJzQKfixL/HzMtFqUVQV3CWl7
	 8eCj4UuOmxq8KOoFSpdbXlejaWqBIzTLGlQwHhBAHS2i/bWZBpXpRMyE/L2AsUZsSaJ7b
	 S3PO1D0fMZuqMRTc+2vcZpmSGhlr1yUUTQS66PzhajiVecizKPXlDVbwrG0G8ABxLZK22
	 kc7RiF8MWW/SxXfMbiiTFEV529e3KJjLEZz2ALHxoQipl97HjUMGxzJAidBPMVpOS73Ck
	 g+G0BsKiR9Qz30S2sOvQ6CbNDZ7g+dJa1k1vy/6H3VNlqXn37E769tboJvdCJS/9F1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muD8m8Zv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC4606A323;
	Thu, 12 Nov 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muD8m8Zv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477DC1F000C4;
	Thu, 12 Nov 2026 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794506407;
	bh=74E+9z4uWRmmkeRkAU8beQOIwYaKDHbJfj34RGUWY4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=muD8m8ZvLGaRrVzmLf8zDKP10kpM+sqtUKGz+3Cd7UFNca5JgAjTD54L0rxWxNVLY
	 ZSr8JbRSz9QJtFtUu9wXq7XUzX4wugc9NK+YIaGq4UEEfcNycsbLWc8uIouQfRkrPy
	 vt4bzOz6EGWW+XVy0TEKPfSUhPvavdwLadv/9p/XUMEOLRgnBBKwzpVbWPjI+1/NrZ
	 8ySmH7URpzBEDcSrGxuMIe6ybC1MtoN1W5BAwYUfTYoyjqnKyu/Ng1SzZxDekqMV4u
	 TcswtiBpuMeyWHox7LC2ugiW+wNMmH8OQcsAl/91KffBJQxuZ27dqoqirJbzArrLh7
	 fQ6tE9llBnFoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A44F380AA7D;
	Thu, 12 Nov 2026 18:00:07 +0000 (UTC)
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
Subject: Re: [PATCH net] gtp: free the skb after handling an echo response
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450640576.567589.2698592522112399495.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:00:05 +0000
References: <20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com>
In-Reply-To: <20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 09:03:26 +0000 you wrote:
> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> 
> gtp0_handle_echo_resp() and gtp1u_handle_echo_resp() return the result
> of genlmsg_multicast_netns() to gtp_encap_recv().  When the netlink
> notification is delivered that result is 0, and gtp_encap_recv() treats
> 0 as "the skb has been consumed":
> 
> [...]

Here is the summary with links:
  - [net] gtp: free the skb after handling an echo response
    https://git.kernel.org/netdev/net/c/f17b293d155f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


