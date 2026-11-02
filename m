Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629809;
	b=NvMwCwa5bI6ke9ZSw5kwVzbGZj3efrmPQJjRwjaBZMNvG7arXzt8nYcnml/+JnDsI6sT
	 xUZYYOkS9AyTob0sAPOy/bNwUFeEQBbJO8M4kBW9Sk6/fAfSfptjDlPklcgl1nYjo0nTq
	 IdVJeJ4SgMXKX/K+fYTD+zrVwlZ0IIHr1TtiE2hiPQtH+8JzS6R++I32ZJyMkSnlAGMx5
	 IQ6QmII+fpdRL8QWYxQaKYy/SjJfcVDLObNC1JawBSBvql+9X1bAzt/DHkipwK5ax8j6L
	 zUpEiYIlQYwJDHgv1Xfx2Q2ED450SuhFGGhviFdfsQ1ROG6tFsO8SsX59loo7AyvV9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=cbhi+0a3f6UJgghKe8qL1BYuP63+zwhGFl8VKZMMoVw=;
	b=PK6j7aGD53Eg3lcq2XF5FWLDUUat3Ko87RQp7bJTkNidEqKnQm2SSAhgTZQqkp0fU/ak
	 SFokRljloettMEr//hux0svGestLgCEwu5OzXe8oQ1122yFrqJUvLn7w3h4mlLMK3GeIh
	 sHl/vTZr9sUEWDjzbZO/vaV36pvZsuqQfgjVpQbSuNFfbE4u1QKvwWw53OV1vzlKQC9Yn
	 1CoorlPxNryh6vbWRCGphQ66UR/G+vGcEsXUtqUqTAKclhH738YuHg9ly25Zt7DpcmFdR
	 seSEfJPFx4X0v4LjDGyw01oIwYHlvAy/xGCzgq42ZGVqhsX81CSkik6nRaAqVLhf4Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpePrpLT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F6606A90F;
	Mon,  2 Nov 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpePrpLT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D111F00A17;
	Mon,  2 Nov 2026 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629808;
	bh=cbhi+0a3f6UJgghKe8qL1BYuP63+zwhGFl8VKZMMoVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XpePrpLTp1iNQ3636CD4UYju62+hvItmogM4jMkmBqjnyg4SsEwzyPhbI2ccCvHF2
	 zd5/L2b2j3gB3j76FU7v/kMx8r9y3BhIJRUE0eNRJqOGxc8HJ+P4K5f/3B95oEe+AI
	 rx2FjObCom6DJjXrtKjhra6Y9qk7PYI8fOU2wA2i1GCy0kUn2ypqtaQYi6RUilYT2Y
	 IB+UgRQ3NQY9TSpy6ffkOPr+EhLBvXJ3Mt9BQd04Y/c3iDhZvdUGYstZ2ODmDCz7vY
	 AR2UoOxyQiPqisB6zAOF0zzPHGgDIZhdr+hiK5I+BejvPOex+guvup1E1k1Brks/xL
	 DkRlTz4O8T9zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2D6380821F;
	Mon,  2 Nov 2026 14:30:08 +0000 (UTC)
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
Subject: Re: [PATCH net v5 1/2] veth: keep carrier off when resizing channels
 with
 a down peer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179362980730.4080032.15822012314713396959.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 14:30:07 +0000
References: <20261029024259.3700-1-yana06070@163.com>
In-Reply-To: <20261029024259.3700-1-yana06070@163.com>
To: Xia Yan <yana06070@163.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, shuah@kernel.org, hangbin.liu@linux.dev,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 10:42:58 +0800 you wrote:
> veth_set_channels() temporarily turns carrier off while reconfiguring a
> running interface. It then turns carrier on for both ends without
> checking whether the peer is administratively up. If only one end is up,
> changing its channel counts therefore reports LOWER_UP even though the
> peer remains down.
> 
> For example, after creating a pair with two RX and TX queues per end:
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] veth: keep carrier off when resizing channels with a down peer
    https://git.kernel.org/netdev/net/c/2d0219177934
  - [net,v5,2/2] selftests: net: check veth carrier after changing channel counts
    https://git.kernel.org/netdev/net/c/c1f04ea0aa0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


