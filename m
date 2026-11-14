Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617407;
	b=BhZjbMnRaOyq/eMI8ntd1fzGo+Ui6WvTT+cjoSB2XColH98GtEI0I0A8+Vgbvbqt/ES2
	 5B99E/4FSnmvCvXnt55FQUQlAUOwLyLk6iPqnyz+OxzSaV7wLkHLd77AuhYcCeBk10ZRh
	 5Qsr4XqQZyaQA2gFi2HsNyGJoJxE6J2x0s+BzQLnVaeaYvleUFh0LmjFOjzrCV/hE2jtN
	 GInisZZcAOUFi9jxdJ57CxopU/I3XXUK3oLTny7x8hrNMvMiBUIIHk6KfLAFvWsALY5uX
	 0ZoY42mOzUa9nMaH3h/o1upVE/GUWKn1XkOUJ2jTrHMF//fHo5a9htIk6J7QV2s8U1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=RV2WT/ax20xY4zHVO5Fo+VeAWkgRpjWTrwUTpYs4W74=;
	b=CyJOe+6dDWgwH83bwMGhApOglJ+1+xyFfEFBdsK84QAH5uV0ES0vhWerLmYFylyqUHeE
	 HH9I7L4/O6cdtFMdqqO/8AxfzUHrOX7aLawxYkX29AE9+JRNLzuXWmxFjtCaFnT74SgP4
	 MhkvMzqVyjXRsEezrVgnMxL9mF5lKROE8469DQy2ejiefRDJJGCECelbaBcnxWkV/hqzs
	 +pTjWRmcobe/YBXRGLlR03TjxQTa87O0g8iO63EbNgvWnherzFoK2RLw5B3yrg+0eyjb0
	 PsEL9aMtXAlIaW00nmXFuRJ71PAa6VXkpPyM5FKHcK0KbzZUma9c/lsugAGBxLwTa2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljHD7OWy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC9606A889;
	Sat, 14 Nov 2026 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljHD7OWy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D051F000C6;
	Sat, 14 Nov 2026 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617407;
	bh=RV2WT/ax20xY4zHVO5Fo+VeAWkgRpjWTrwUTpYs4W74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ljHD7OWyETYSKtGS8YYjTMQkDGjPZEMZpO8DCHFCXJNvg/eRSSgowhgROVGKE/22i
	 TUdjL7hyeiTQ1qN1atqvhL/A3SYYcGtwxvC9gusQk3waVR9EKO+3tjUP1i9EEqEoiR
	 h52zb/9FL70Ryehkc5h/LIJnvFpGoUxLPSEw0ycL3eMxSMOfy4Pf+RzOwNFq6m/G9j
	 eQjEXQCzUSMZzpA0/+cjZRRNhNZvcg1wLZU6ZgtgNNlDzrkK//qmtUPsmFULeGLhB+
	 4CxMc5twr1BKgo3XP6M0BrsDsNp9wfxdw0pbufotmfbrm3BrGa0LIcax6DI7xUfaaB
	 awSIs1ySuxS5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8882B380821F;
	Sat, 14 Nov 2026 00:50:07 +0000 (UTC)
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
Subject: Re: [PATCH net v2] virtio_net: check RX buffer length before DMA sync
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179461740627.1921910.2264840033885936833.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 00:50:06 +0000
References: <20261110-b4-virtionet-rxlen-v2-1-6ec5aa0edf9f@dfb.sh>
In-Reply-To: <20261110-b4-virtionet-rxlen-v2-1-6ec5aa0edf9f@dfb.sh>
To: Vladimir Petrzhikovskii <vladimir@dfb.sh>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 vishs@meta.com, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, nikolai@kalinidze.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 16:38:27 +0100 you wrote:
> An RX queue that uses the DMA API (rq->use_page_pool_dma, for example
> with VIRTIO_F_ACCESS_PLATFORM) syncs each received buffer with
> page_pool_dma_sync_for_cpu() using the length the device wrote to the
> used ring, and checks that length against the posted buffer only after
> the sync.
> 
> With SWIOTLB bouncing (swiotlb=force, or a confidential-computing
> guest), the sync copies from the shared bounce buffer into the guest's
> private page, so an oversized length also copies the bytes the device
> wrote past the posted buffer over the neighbouring page pool fragments.
> The later check drops the packet, but the copy has already happened. A
> malicious device, such as a host the confidential guest does not
> trust, can overwrite guest kernel memory next to an RX buffer with
> bytes it chooses, which is enough to take an unprivileged guest
> process to root.
> 
> [...]

Here is the summary with links:
  - [net,v2] virtio_net: check RX buffer length before DMA sync
    https://git.kernel.org/netdev/net/c/29dfa436bc48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


