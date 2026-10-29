Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232006;
	b=NU6v86bDnxs7Vmi/PlNXef4U1F1GaviAcA8Wk4gNU5j7Qq1D0KTn/ODbxebvJCIv9AIK
	 Fw1f2kqUPKUZjuQcJ84+aA1aFrcftGBfcQPCVqvZ+6iNz1wdg6M9jIlvXSNSW0HOGvHO3
	 menRj9MSz/nJzC8Inxz11wHvVCOSDOOw7CdlQ417KFF+yhwxMLjPjv2m7uGQs82oRLoAj
	 1JlcDW/mhQW9jcQuvZ2z183wwq3+R9G3gyvYjp+O0iTTmsDwzHv2U1Pt3xv/uMsr3iVus
	 es1VC6y5iFjzosgXqIOgIBbY7jj64ZfDWM1Jz0+W4UipMQgxmq6VUc/vp8K4EaGmbbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=zcIo/dMXo5OSrkwLK1ivxZ7QH8Wzl+noqDoXCZOkxrQ=;
	b=i7x4TjvUIAPvoFrBi/zQ6Nt/R8MZLXy7dSsl4RyqEGKrBGKIqy1IpYkadIGmCuv9FkWo
	 BAT0xc2SP120YDh6TpVwTC+BsY6BI20W1oRZkkHtvS5cihpFzGnzD3m6bgstEAwd3lICi
	 EbOaGc0cIzfVYf1ASj/ah74VyLECaONPvuATXdqeyZoDjFNHiTsaJ70KQnF3iVhzlsTRt
	 e2O2xU+NArLkCc++yvQ2w4ErgKihItwLNSgpYuTHyDo/evAJwGKG4MCr4BvTGpkZGr91o
	 wLmQW1ne4Q7oVBqjb4F21hsuXLpdIzTCJ5v8HnzdEixt98ykIQdcGvK6wx+oia6FALg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhUTEw87;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE30606A31A;
	Thu, 29 Oct 2026 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhUTEw87
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81F11F01825;
	Thu, 29 Oct 2026 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793232005;
	bh=zcIo/dMXo5OSrkwLK1ivxZ7QH8Wzl+noqDoXCZOkxrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QhUTEw87XlhuPF3CseBuhCrWZWwmAfpcm6oITA3RR9pACu4fzuIrP56ZEkG6NrlV3
	 yZCxUz3l0hnviQDYx622JlgAVyUGIl5v04AqbIb+JKMdwkVBqHa7/CRoostJUfffxc
	 trfiCaZ5R4N5J92shAMTd/5QArq6YL2qmfpdIRYHnbe4rzo3BFt0QPEl2O+7w62uDP
	 Y1WPdwLEEiyYmTeAjQmwP57IDxauika04+zwrFT8bSyselj+3YBtBhomvB7XGmqtDf
	 +qZ44sRH4wdmy17aHBRWGFhfoJJJ2iSJvTdBvvYp+0r2BHuOx+YCJg8RZ9hzAIp7Wa
	 pWYSSyPKVTh5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5123AAFC4C;
	Thu, 29 Oct 2026 00:00:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net/sched: fix packet reordering on requeue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323200431.1486772.18153835422208182912.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 00:00:04 +0000
References: <20261026153113.3275494-1-antonio@mandelbit.com>
In-Reply-To: <20261026153113.3275494-1-antonio@mandelbit.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 16:31:12 +0100 you wrote:
> dev_requeue_skb() appends requeued skbs to the tail of q->gso_skb, while
> dequeue_skb() takes them back one at a time from the head. If the driver
> returns NETDEV_TX_BUSY again for the first of them, it moves behind the
> skbs still parked there and is sent after them.
> 
> This showed up as heavy TCP reordering while benchmarking over veth,
> which returns NETDEV_TX_BUSY whenever its ring is full since
> commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops").
> 
> [...]

Here is the summary with links:
  - [net] net/sched: fix packet reordering on requeue
    https://git.kernel.org/netdev/net/c/14368b9aa101

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


