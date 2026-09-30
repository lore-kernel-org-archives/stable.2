Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618A353A82;
	Wed, 30 Sep 2026 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731209; cv=none; b=nTjDEj97MvWPG6tfdO+xRfdf/ItVwVCe39yofiWEf/zJYg4ePWVmGV/zlE/AIffuGsRgZo8feeJSWfhWkXw1etjXY1uSXk5x48P+WvKjARGfuPdKRTtZBiYLb9+Fs3h/bZSpKP3ht0BPlyR1ivg+TBL3KfiHhTzYPkf+0ztU6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731209; c=relaxed/simple;
	bh=THI2KG5NQAStDxoB/qn6mpOIaIEALQnqV/JhVVGzDoQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EvGeXUOgS9R49VENoqXbRaBZpQMGlvtlTJhiJcBnR4vQ9ymNiIMu5gtnC7r0k2gTDLHzysZK/764wKRzzuMC0wLZ0+jJamC70NG6rdDtaKdvxYilEkkKgwi/5ZQ/n91nSbNqersP06jWkYQhiIILqubwJ+vW9zvzvbOV7GlG9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qiw9RLvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qiw9RLvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1520E1F000FF;
	Wed, 30 Sep 2026 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790731208;
	bh=qxvIJbadfddgzhqc0CpTK8nYZX+u3c7hC0aaBXTKXJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qiw9RLvt/GF1BZVZxmkYP41bMwd+fYMs8OpnXjLLYLz05CxaHPTwkLNv5cJShD+y7
	 5jJ+NMelbYAvfyx85dVpjVm+yvTju6Fy/fjl4BHsRMPsPrUFoa5fnGriVlga9WPwnz
	 4csLd4bf7OskQny0xzaVwj6JOuGbbOh4uGsQinLZki3pWIYkzfBpjuOQCNXO4BCVzr
	 ANHeKEIs3nU2kkRx5GlBqrJ8Aw5loS0Tc7RjU2VAg2JGWjggEDyvptXjnxmFrUndUc
	 920CAKGwBX9jj5v7BY1+K6JArx4w4CUQwrqBhwGjKy3xiu0VAyxCP9ltoITjNprKlM
	 ZKkHG5SY6P/HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14593924FEA;
	Wed, 30 Sep 2026 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: extend IPv6 exthdr detection of tunneled
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073120652.1194536.6933044569740005192.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 01:20:06 +0000
References: <20260926140506.2335137-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260926140506.2335137-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, xietangxin@yeah.net, willemb@google.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Sep 2026 10:04:54 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Commit c4336a07eb6b ("net: correctly handle tunneled traffic on IPV6_CSUM
> GSO fallback") split skb_gso_has_extension_hdr() into mutually exclusive
> branches on skb->encapsulation. This did not yet address all paths:
> 
> 1. With skb->encapsulation set, the outer header is not checked. IPv6
>    tunnels such as ip6_gre and ip6_tunnel add an outer Destination
>    Options header by default (encap_limit). Their GSO packets skip
>    software GSO, then skb_csum_hwoffload_help() sees the outer extension
>    header and calls skb_checksum_help() on the GSO skb, which warns and
>    drops it.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: extend IPv6 exthdr detection of tunneled packets
    https://git.kernel.org/netdev/net/c/5f0764cb1c81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


