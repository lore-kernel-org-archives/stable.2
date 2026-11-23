Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448406;
	b=Y9ybokh2sH3e0q/EDiXEYrTM4hnJbcC5QdS9CHPOkQd6KfI/jDSUcCfjxvhNKHIt5k3U
	 4hFSdlGCKxxivhb6c9TmpRagi49xvMJKweIW9yh5RRSnCAS3xzdoMiPKLU9nEUmV0ofYb
	 eYrDWmTPMuaKiwVbKfQuDBI/GXqiM1jtjLne2tHPnHkeYuPxRBNP5deq7THhdNHyQEBGF
	 Vq7w2Qk1hf0iad5qvPxh/ub5qNXzsLi2HBv2uTTppkHtiKp4j+GM2QeD17oG83wdHrtmG
	 TpiXemJR5J9ssE+yXaIBIBBnHzyLhNmxCZBE56P0GX8qVBQiQLjOa7YphCwjdK7FdOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=tmv+B1VnlhVohvsJFYjQzaVVSattLcuz6YtYy4yGAPM=;
	b=h3ilaqNKWSht2dLMq8hFH8Zk6OWSmG8BD1fDOm+du65Om9lEXeNbhvHm4AYlRo5BSN40
	 XctPNt/WUZRPtrXoCPKzGtBbxDNcSmboL+t1D3TNsXR4a96Xe1HSgQyiFW9bOaxeHREpV
	 XCm7uQJ1I0OXWIKlp/z3ZPadHeMQNQhOVAqmh3eMMH+feys0lRTfHcjisp0Yzr3WxzitJ
	 OpZ/NQb4xlyCLgquqvGAW3zbLJQntdGb5pt59gaVUX1Hn5CgtRn5/J9KZcY+TnXAN8V2z
	 mfAkpgadKQiwsB0baASoCvKc8Lo5NWIzzeM6zcodAysmX7kRmDuUyJrKxJHnvNBE2mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QE5x/nRR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC3606A685;
	Mon, 23 Nov 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QE5x/nRR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9A91F000D4;
	Mon, 23 Nov 2026 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448405;
	bh=tmv+B1VnlhVohvsJFYjQzaVVSattLcuz6YtYy4yGAPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QE5x/nRRceEgpVzqWcrxl6MAG/11BIpxlg1KeAHYczG4vKDcMJ27azQzFYlv0mt1t
	 J0y/LTTtMOMQZrSqw0YtDssEo6RAZ/K0klpNmm/8BTLjM5f5rGBOtiUSZC6K2YQ6Xq
	 RkWAvPNAe2y+XS5br6Yw6H/KsJyNg1+sdTs7cYVse153YuPSlVA/I6J1MR/nK67ila
	 cg6yaIGkd8YPX+JrhMBYPLOrl4BmEnthYXrovxZB3ZlBhyR49ew55LK5DH48GJl9g3
	 awNFjHrMuGCkiIhwG4elccQHEIT/7TdGWW+3/6jtY0dh976qct+mZGq4dzpB+QFdYj
	 lkCmjOZVzp/bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4411392EE0C;
	Mon, 23 Nov 2026 15:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net v3] gve: fix checksum state and gso_segs of HW-GRO
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179544840453.2474785.1388253483478693353.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 15:40:04 +0000
References: <20261118212045.3575303-1-joshwash@google.com>
In-Reply-To: <20261118212045.3575303-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, nktgrg@google.com, willemb@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, pkaligineedi@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Nov 2026 13:20:45 -0800 you wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> With HW-GRO enabled, gve_rx_complete_rsc() turns a coalesced packet into
> a GSO skb by setting gso_size, gso_segs and gso_type, but leaves it
> CHECKSUM_UNNECESSARY with th->check as the device wrote it. Unlike
> tcp4_gro_complete() and tcp6_gro_complete() for a SW-GRO packet, it does
> not seed th->check with the TCP pseudo-header checksum or set
> CHECKSUM_PARTIAL.
> 
> [...]

Here is the summary with links:
  - [net,v3] gve: fix checksum state and gso_segs of HW-GRO packets
    https://git.kernel.org/netdev/net/c/bda3c8381653

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


