Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581607;
	b=c1DyzZ1d4uR3lvE6Tvy/LhVvxUXyNfqqoJM2IvNNCZw4aC2EkjGTi7vgTNXZh3axSt1a
	 tbAsZWWhCUNEakFI3amiIJFhckSTB0thMgj7XlJek2tIunrQwU+2UqoTfEB1Q/bB97Tkn
	 6av8h9CANRfh8BLH+qt96R5Nn7QuzBmNo/iMqyoUJ+7UCLll8hENkK9V/HbMvBmP5oRVU
	 DFQGxGQhR/T22vyO1EA5Ui+KQpM/Qqf+BEqo/6l+vsLjP0JtCVgxQfjBNlwWpdLW/KyTi
	 WD19iUh3etCo1nHNNV4RJtofN2Vzvx0vA0+VxxiGdvph4F1oTdfuz0ixqJyeI4JLoIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pG5q8xjLFfDgmmlhQ1gG2nIa9ztAUDpubqE5Fgs/Mho=;
	b=4iY7LMrtIlPXzKs0eynJbRRFWlpw190Do0xt1J54sCaFOK/7xRAF+trTg9a44mv6E9Ff
	 vSqs5TWKJ3SdiNZkq2AKskWtU/842sMP10DVWfgdcwRfZKNIUlRiWQHcKSyzz7Y8fStxR
	 6VUu9eA7f3AP2bpzCSUh9TOXpXs2TzYAOygtlAS2hP2l0ok8yT8sQb7xlVoYsn8qYzFeq
	 Mr7me6HPPZBgZiAJPnjbd1IFuw99+T4Kf+L+NS+wap3wsPS0DAQ1HRc1QqpNUUf/ruMVU
	 TaL0wQRfpSYweAKlcmCFRPfZmpG5LSFHMIRyYmFdK2BBBmKojIa+tCmlzNWH57PFu8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8pZr9PF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BB5606A319;
	Wed, 21 Oct 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8pZr9PF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DBC1F000C4;
	Wed, 21 Oct 2026 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792581606;
	bh=pG5q8xjLFfDgmmlhQ1gG2nIa9ztAUDpubqE5Fgs/Mho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c8pZr9PFfyigTxKhPj4kPy4yrFRYPaW+SzlDGH2XKPI+r+aHTwthZyQtI/YULqGSM
	 BVJEMpBqCU8X+S/WfnCAsqclm8BgDjsORbZYiPC33hdsDl9A+hkguvNNYgOAczD6cZ
	 6dG0waAlhN02PGiXWJe0oVTlQDcXwN5iEjR3ghwzGTBySpL9hOY0wAkmFGPv6LYxzQ
	 iCfiisA2ItS0wB8PiXaa2zFmOsqF4jsuV5z1yMxLK/HhT7YYBzbJftoN2S/xi7Z8mX
	 UAhPAujDslODlnT+BN5Ol6Qhvy4od/vTyLPwWkO2PhfaSrLVFzzwew6ogG0VNlkAN6
	 S+7olHTvwtnuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3983809A29;
	Wed, 21 Oct 2026 11:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net] virtio_net: atomically disable rx mode work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179258160503.565300.13046039788150219852.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 11:20:05 +0000
References: <20261017114237.2786302-2-bestswngs@gmail.com>
In-Reply-To: <20261017114237.2786302-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, sln@onemain.com, xmei5@asu.edu,
 stable@vger.kernel.org, co+d17c2bc750a9cbbb@bugs.sh

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 17 Oct 2026 04:42:38 -0700 you wrote:
> virtio-net uses a boolean to gate rx_mode_work during device teardown.
> The flag is changed under RTNL, but ndo_set_rx_mode checks it under the
> address-list lock. A callback can therefore pass the check and enqueue work
> after teardown has flushed it. The work is also enabled before late
> probe operations that can fail, allowing probe unwind to free the netdev
> with work still queued.
> 
> [...]

Here is the summary with links:
  - [net] virtio_net: atomically disable rx mode work
    https://git.kernel.org/netdev/net/c/123470748205

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


