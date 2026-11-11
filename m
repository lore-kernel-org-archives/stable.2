Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355213;
	b=fz+qwZmz4jEPaUNp2JN+AQb4135k22MzbNHBj/IGIETgj/7c0dZkpZLDSlF/tRNOcY5j
	 tJZp7z1cjVZd6iYTXl6bJWURFow9kJ5yKu0Z7f8ItHbm7sTLkQe6CPvsCZl67DIr9yoi5
	 rliBUFFK9F5aIjg8mUHj8HTAW9LIRDw97yEZ4pofHOQ1BknFD9zwSerX4AA3S5wFjm/sT
	 +Nfa4xerrrAlsP8HsAkH+iNOMk0/kBuhUbWtgAttBKzefc9iOTju+2+I2T2hcFleChxIH
	 G6Z+QZuvgrwUBFD7zuAJEBaWHE0qukdJiO0pJnpCHlt9DaL/YkXNLHfRL9EAkYZYVHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pe7yckFoOcxSVtHvpin4iYoemsGaYsL1ql9aqtlmMUg=;
	b=N0xqB7ziQTLDYFSVjdxLo1IX/E9vaZbcsU6mb5g5B2BBCdvGsXaaa3umCf4msk2JbUGW
	 QlMLvm7wXGaAdo8N8DqZdQzr6AJdoQIs3UZ/II8UwCwr1MxtrzCvnnNrlKjCqL+UaTr8w
	 oFvqRsoQleHD9P8rFNijPciE5xZUBImCoVbwA4G5QxNk6tOXOAIjUAdIiyo38r0xW48rh
	 Pp63QzBJjOmRwsN2I31WJmeTIcF0dh3kVz0HxT7VHI2OPJR5k4+944haqcIbXwWtIp4zP
	 0IduYfP1xACugHOir0j2x+On3eEPYj4R6m46GDagjTk06LUbQoSf0E6/KnGzdMP3fMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NM1/Fcki";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8A606A33A;
	Wed, 11 Nov 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NM1/Fcki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A6B1F0093D;
	Wed, 11 Nov 2026 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355213;
	bh=pe7yckFoOcxSVtHvpin4iYoemsGaYsL1ql9aqtlmMUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NM1/Fckij5mOXKI5Bb4o71FRGU0eqBBXBQmisBuksnz820Ccvdkq4KJg2/W075lwA
	 Ud7dDemfVUb4Y8UZK5EQtY7qGUGuYK99eqMACUmnQWhuy99yXdfyRJkSKNTxSJISCz
	 aMxacqe+DLeu0IPzeNZsAXpEfi+WmGvJOEytK+c7WH8ypQ5LUF7nTC6bkRKHzvY2y2
	 R6J8Hv9y/53V7nn/RwVtlgeW0m7L8n/cRIV1XjE0i5HBSOJN7hrvlaYglsz4jOo1Wj
	 a+gejRQGvzh74dQAuLseAiM3kJ65eqgePmaspbFCP0uwmgOF2dSrbBZDh+PKp/Qp+u
	 zjXIJ53XAGaSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B1A139E8A4C;
	Wed, 11 Nov 2026 00:00:13 +0000 (UTC)
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
Subject: Re: [PATCH net v2] tcp: fix authentication bypass via unsupported TCP
 auth options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435521217.125436.80998723021088734.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:00:12 +0000
References: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 dima@arista.com, fruggeri@arista.com, noureddine@arista.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Nov 2026 22:47:33 +0000 you wrote:
> tcp_inbound_hash() parses both TCP-MD5 and TCP-AO options when at
> least one of the two features is enabled. With TCP_MD5SIG=y and
> TCP_AO=n, a packet carrying an AO option reaches the disabled
> tcp_inbound_ao_hash() stub. That stub returns success, so sockets
> configured to require MD5 authentication end up accepting
> unauthenticated data. A forged AO option skips the unsigned fast
> path, which is the only place where tcp_inbound_hash() can return
> SKB_DROP_REASON_TCP_MD5NOTFOUND.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: fix authentication bypass via unsupported TCP auth options
    https://git.kernel.org/netdev/net/c/7cc235fb1251

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


