Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960406;
	b=ZQHsSAbSgi1nA4c95d7DwuBJZU+n7TDFmmfFS9E2kugykMcZ/vjj6hv6O9gl+qTxOotw
	 SzTXIqak5gcG9GMV5gnyb45zYB5b2ROXp44Z32KecAdRyWdibbeWyW512/5UMQeGU0Z7i
	 Eqm4QfQ34BDJoTSqWBzmqa5fPjUe4MKc88VA9gwDfRlzwUjM7ZBuQIBTkbyItGC8P+p5p
	 qHm/5dCiKOV2Z+ywPCoKsiRUjU1q/4M80U3Ot11P8SIkAQafcO+Ly1Y/+KAX2XDnf5/uL
	 aubszEpDXyby1ydvecnTJC9vAoinRsEwm4s/p6iTsh2L59Bm4iHZOEV7WgAAbJXPNYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JNl5Xakwn7jLlETiJBK8Gnvf3fDOngSL4R4QB3bVpzo=;
	b=u+ng2VtF5dzvpyeZErIQvGk+B0Gz23Y+R3/kbDVIQGhm/WnQTVhcqlS/XNd5g8jf26Cx
	 2QtBKJyPbUgtYgng9jIEJUZx0WUKfnDoxbY0YsMKXUzX47eDAcGAGKDC9EzZKeL8q5oiu
	 4bcZc9r/WTxIG+9YeXHhfBo7wYxcw4gJsl9CDGKVOKq7j29EbKSyr3HLhxncc/a0vz9pp
	 OUB+cbV67bKm9atC6AOzaoTp39G5zw3ASIyn6YfHxyFMoRBO1OxKEu+HqviOhfFu3XBfs
	 r9Rh7G/HCdX0jjJpkfU5B+Ue9nEOy9I1xVqaersL+FC0t/1EWRhrZxuxmIgpkOCVTHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMlhxpE7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33C6082BD7;
	Fri,  6 Nov 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMlhxpE7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FE91F008A3;
	Fri,  6 Nov 2026 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793960405;
	bh=JNl5Xakwn7jLlETiJBK8Gnvf3fDOngSL4R4QB3bVpzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AMlhxpE7ccDf9aq0sq4DRpa/AYB94KUdxbV0HQFIp5A/p7i9xlKmcwto1X/DXyluF
	 scxzMWYViSbOjAujSQa5aWF9eaWvu3NLp1YMXOj54XeJEe2UPRNpkSrMRCPeCKnV74
	 v2ax4OqKZ86wlK/Cnh5/Npbevnd60UuXxUqiWAXr42BNqqMGBVE+93Ux4IVzpSZ8wR
	 mp7vit4xYDMmT96dmcU7kzWvkkGmBmpPrBeCCtzrVUgt+AMndCUvInKL2I3fSbEgnu
	 1ZX1bTGrRBDy9+E9aJ1ncyd+99YcczBtn9XRX5Kwv1WiJy+zxFwh4cIadUuutizotX
	 FmADaxTr4vv0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B0503924A54;
	Fri,  6 Nov 2026 10:20:05 +0000 (UTC)
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
Subject: Re: [PATCH net v2] hv_netvsc: Stop PPI parsing on invalid metadata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179396040443.513493.15670101315738233771.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 10:20:04 +0000
References: <20261030093459.4004663-1-ernis@linux.microsoft.com>
In-Reply-To: <20261030093459.4004663-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, lkmlabelt@gmail.com,
 parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, liuwe@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri, 30 Oct 2026 02:34:59 -0700 you wrote:
> rndis_get_ppi() uses continue when a per-packet information entry has an
> invalid size or offset, or cannot hold the requested metadata. However,
> the remaining length and entry pointer are only updated at the bottom
> of the loop. Each error path therefore retries the same invalid entry
> indefinitely, repeatedly logging the error and preventing receive
> processing from completing.
> 
> [...]

Here is the summary with links:
  - [net,v2] hv_netvsc: Stop PPI parsing on invalid metadata
    https://git.kernel.org/netdev/net/c/19a227903e65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


