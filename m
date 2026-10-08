Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE74F5E1E;
	Thu,  8 Oct 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484817; cv=none; b=LxGL4JDkZcEwKmUlA4FXASYd1SZW2zYyMDIoH/wm+JMM07VjgwNedO+51glpNKSLjiJ+MjROqn/rMUw0TsaRLVmNnetvxxwH+PMEUGGW0gbzFIt0/jTKhojnJlfMz5nmoQHS8KpToUu4bbPjFoV7Id6LTk4FdPTeNGlHqy/XHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484817; c=relaxed/simple;
	bh=3XIdxFmnxOCt5ptNgrEjlBbSUU5Xvj2JTqqcv8NLt/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sl2ZQUH/SOBj++d91mcAptU/E842jSD81ttiV2EWZkV57dqgzbWDIwKqoC1eDlD2rZ3ioFz3MlxYSMZKMtVIPnA8xaCgoveqTYueO85k/2wNDvRR36/hTcgqzuN3iki8PSTfUszMqVYiT7xEVfiHsbeDrm/7ixmlLvTTTcJa08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJwc4GiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJwc4GiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3471F00898;
	Thu,  8 Oct 2026 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791484814;
	bh=VkDY4ley1sWol3yb7WWyF4QJs3i/YJjEQTTXobutVZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PJwc4GiZZYOldv17sp8Wbd5dZHYRxlbCEjXpM7m8KfHhoRfuJhF4nCkeNels1AOWY
	 /c0T4I8kXGt2G7KecUytwwHjpgVOT7YC1e5z1uRqbzQgvUVjLYWza6peUvrIShJ6lk
	 HBs9MRyZLz4WG6hsYhcf6kYCfxj/NZVtXM9I0NfTNGtegslWE2bGcPVUuBFAOXJVeS
	 33ERJzN7z5nuiRBHmB+xGRL7IqzOkfV4gA25LY3CjA5n49uGuxP5+/BfSYpkZpaBjq
	 1hbTGWcuC1T6L0aLRjYTXBTk/AyGuPVi8S4aSiyEFyeCsHCWmRrl8R9xnNxc1wAhvx
	 SK7Mgbn4X/OAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F170C380CEC8;
	Thu,  8 Oct 2026 18:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xen/netfront: drop RX packets with a short Ethernet
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148481252.386807.13451642616243196690.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:40:12 +0000
References: 
 <20261007-b4-xen-netfront-short-head-v1-1-12d7113a7e4e@toxicpanda.com>
In-Reply-To: 
 <20261007-b4-xen-netfront-short-head-v1-1-12d7113a7e4e@toxicpanda.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, chrisw@sous-sol.org,
 jeremy@xensource.com, jeff@garzik.org, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 07 Oct 2026 17:55:40 +0000 you wrote:
> handle_incoming_queue() pulls pull_to bytes into the head before
> calling eth_type_trans().  pull_to is the length of the first RX slot,
> capped at RX_COPY_THRESHOLD, and that length comes from the backend.
> Nothing checks it against ETH_HLEN.
> 
> If the first slot is shorter than ETH_HLEN and more slots follow, the
> head ends up shorter than an Ethernet header while skb->len is longer,
> and eth_type_trans() BUG()s in __skb_pull().  If the whole packet is
> shorter than ETH_HLEN, eth_type_trans() reads the header past the end
> of the data instead.
> 
> [...]

Here is the summary with links:
  - [net] xen/netfront: drop RX packets with a short Ethernet header
    https://git.kernel.org/netdev/net/c/089e58805c45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


