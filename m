Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099EE449B16;
	Thu,  8 Oct 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484809; cv=none; b=XSmXLYhyKpgsgK3Xfm2TBegeYbvZFMsFGkj0qTT9WrRZh+B9CvjW1QxZtwjRdzpIIVgEmGQSY6Xb49LAbMAKIhC4bImkzlEwE16noh33vyKM9pRZsWRHgU6A0x91+66HGA4haDYI7yrKGPL0wJxpwFIgaAZUO1Bz9b4kEr8uhA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484809; c=relaxed/simple;
	bh=L2AGMIqzHDniFNjdXg8YiMT90fZg0cHwwcuphLPjdQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BxCt/KnZaKWCxg8b10Q09aHMafkFUENOEln/hCj0CVeTRavbhwhlVK5X3JS/zCkpWA1NgUwBOzfFUNMuU5hUU/4SUUis4atpR8wY8cNJvHaS2duvhSi8TCfGA2i77vqHxnBV63PHMC4MzW6b7sMxeAz+6CfflWvjIxw2UJI/t9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE8DO7r7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE8DO7r7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D181F000FF;
	Thu,  8 Oct 2026 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791484806;
	bh=TGkfYgnaT/9Bwsykl5EbmNC1O7Vtif2NAmiMXr+tD/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XE8DO7r71MFF9qx4BSmcjeFuWYXn8rs5WVIZHMmoMzSW352c7sOaKggjR66kv//ou
	 HunBejoasz67e0sIVFD0FFEAe7x2M7NfxCDGVlvk+k8Dj2mSe3hI0xrQ8hJRDqo9TZ
	 D34OsAfKbPeFz5+y2UEsxzxd0gPWB6OjaKFVtzEe4CFHJueRgZBop+GZWyfMnhnQQV
	 OCn10cLK1if4Q+A7aigqrzf8pz4tucW+xBMGBXI0pBZd5dfVDvVwe9B/Egal8Kp0wP
	 pkhB8inoF6fIjRPhGYeTWa/vL1wfQfgesBJWD9BzGSmu2XZU6WfWqVEXbJ6yef6isu
	 1Cr3Z3RovBBUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7755C380CEC8;
	Thu,  8 Oct 2026 18:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148480528.386807.11659403908487908478.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:40:05 +0000
References: 
 <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
In-Reply-To: 
 <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, kaiyuanz@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 07 Oct 2026 17:29:34 +0000 you wrote:
> When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
> after copying only the linear part, and the rest of the caller's buffer
> is left as it was.  The callers copy into a buffer that is about to go
> out on the wire: an ICMP error quoting the offending packet, or a
> driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
> is zeroed beforehand, so whatever was in memory there gets sent.
> 
> [...]

Here is the summary with links:
  - [net] net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()
    https://git.kernel.org/netdev/net/c/ab9414ed70bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


