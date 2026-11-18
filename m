Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794970208;
	b=BzVcKeLufC3pjMYJNYLoB3Znzh11ugz59EkgDQYyNjbGJjSOrwfWO3dkdc7m6xE2WGJt
	 tAPrxQDd5cGCA4c5VS6KXad+6CkFdon8XyXr9kaJJ7/BKDLxGDnUsyx5nPNKMii+637Cy
	 XV3JmLhuPP4fbKv+Eb0q6xx2wfnePgq9nZmNzBn96fqcFetN59UisRQe0aoQBzBdSDv2u
	 FpMPy2wqzheCAv3aXewi1CdCIOLvHYFHs5kwARTiqT1MhTW4fvLUSl02fvTxt/Y1mTtyr
	 uG0mlFvfn3cf4AQ41FOmxTDMkMmxK+2pAE+YgVi4nLUSGe7abecHVF3HddVB+NwXU2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794970208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=j7U+ccaHY06PnqrG7nHH2eGpc05Za8Z7TLgy7M/1gzc=;
	b=f/Ck/ZkA4ifrNKZT38pZIHCM/ywkovvCIbdtLmwVOGmiJWAHKsGm1z+PATGk7hZJ1/SM
	 VkwIp0pMv1IIKGaboRbe4Zla31vCWM0JnW3mgcwaC2FC6iA7aNlqzCzTqyV/5+z/bh+Lk
	 awU7nnQ1OZ//OKyzojNsl73xtM131bjsMBgYt4kOMZ62BrZi9fuJgIic75rIKqIAj8GAL
	 nbYoBMeSDlhcK5Rv1xDfOXpLew7LUVU9t7h2Q+e+H3zUn01zDp10DrQ0sQJUTHHtwM0x+
	 1SSVZlt1Zmj6MZexF0kC3RCZmZg2SA8M86ujNWobt9CpcgqtzjbObF4LYxbanLQ0gKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGPph4qo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE1606A335;
	Wed, 18 Nov 2026 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGPph4qo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818861F000C4;
	Wed, 18 Nov 2026 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794970208;
	bh=j7U+ccaHY06PnqrG7nHH2eGpc05Za8Z7TLgy7M/1gzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DGPph4qozijWqU1oAE7i4R3aK4Fl9oNRdRby78BQUKTCgJC3ynIhQAnqFXzyIFrzg
	 cBfk08EjVatXUqcISmJxDCztioz2pxb0rCmfWt9Cp2mRKPw05wsj4u2bfyz921yNT+
	 N6lQ/aRrwwmPoZkbkJN2yk0fyh1RBJYzPh97dvZvIx4EhfiQhJ4IPnpM7sT6YYY8Wi
	 5hx5n4jRqMemnFgKJKoEQ5Hg3ZBV1Thm0EsMUWyvJJuncj67iMfJdyyZAtBdMVNQhY
	 dq4ugX7w4X4szlUM5gXDLo/cutPhBpw9BCa/PuL3QR9UZVwITohrPZ1zszEsOAwWdi
	 DiudQVJftkO0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 776B9392B1FF;
	Wed, 18 Nov 2026 02:50:08 +0000 (UTC)
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
Subject: Re: [PATCH net] net: microchip: encx24j600: Avoid unsequenced
 accesses
 to jiffies in encx24j600_tx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179497020702.1430642.4658392192974700419.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 02:50:07 +0000
References: <20261114-encx24j600-wunsequenced-v1-1-c978fc36cacd@kernel.org>
In-Reply-To: <20261114-encx24j600-wunsequenced-v1-1-c978fc36cacd@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Nov 2026 21:38:26 -0700 you wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in encx24j600_tx(), which
> can break the build with CONFIG_WERROR=y / W=e:
> 
>   drivers/net/ethernet/microchip/encx24j600.c:898:14: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>     898 |                   jiffies, jiffies - dev_trans_start(dev));
>         |                   ~~~~~~~  ^
> 
> [...]

Here is the summary with links:
  - [net] net: microchip: encx24j600: Avoid unsequenced accesses to jiffies in encx24j600_tx()
    https://git.kernel.org/netdev/net/c/5ec918f8d66a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


