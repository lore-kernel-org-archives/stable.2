Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5B3D3D0E;
	Thu, 20 Aug 2026 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257885; cv=none; b=nwvffaR+s6FbWIIDTg8frE+y6IpLGq6aeMdROxBSQ0eUgiun4wRsbcMuEkE88TP1C2mfqPYcEcFPAQKe1til/74tcSxlvYvgr6TG/240pQt0770Gyf8Z24vrJnoboJ7P3zvd3KCj/Z1DqMC15mwgpU9PnsFjWmws/Gpz7M6Xdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257885; c=relaxed/simple;
	bh=SF1ZLWZ4jD6SQq4Y87dUhtVYl4OOHFRuJIqn+lzaIOs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SjfDNq5it5yKyTflf0SL8jXb3/uCnbNPPhC/Z+lJwK7HbH/CDBwY3gDnFedftSxJkbX3kzefy1GMdHklPptQt2uYweImxZcAgTsGOh12e7sNed6cBgvanK8XiXMo0NO+vqVITSmJpj9Zr2q8oOgoTYDL0WgRZByiqb1nuH+oUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6/uQymq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6/uQymq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57741F000E9;
	Thu, 20 Aug 2026 20:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257879;
	bh=p14Z4rh/tWJ/sf7PmVu4uu9PQ2snMiC0YNc8oKGME0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q6/uQymqSbJ6Zwy2IPHn22nnmQq/9QnrFs2yw0sOAtzRGeV4UzY2uPvrFwdO9bGb/
	 jiwSZtmqa42GNvMaPacTCwb4XxIU2/jI0+T1CFimRWRjPg2GYext1DVE404Yhsf08c
	 4Bw/jjnMOQfpJfYWUIpXab6Y/tGjVOOtoR+k644Nd1lIggup8UXHOnaPcov+lms7Lb
	 UvYbD472yqZ5u/MsziAUY/3DG+YK1N/jOh9Ke1GxuZ1+fKq+LPs57zzIvMbQAFAtiw
	 3+Is1/tUFTwiwsGUvC4FyL0qorCD27Lf9i6Cfhc6GNlnGq6O89JxSrMPUCtI/d2x0V
	 OjKs+adN2oilg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567CB392445B;
	Thu, 20 Aug 2026 20:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] vlan: fix skb_under_panic and races when toggling
 HW
 VLAN offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725782988.470503.15788449935898012814.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:30:29 +0000
References: <20260811085246.2267779-1-edumazet@google.com>
In-Reply-To: <20260811085246.2267779-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, xietangxin@h-partners.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 08:52:46 +0000 you wrote:
> Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
> NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features(),
> which dynamically changed vlandev->hard_header_len.
> 
> This causes two issues:
> 1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_output2)
>    read dev->hard_header_len without holding RTNL lock. Mutating
>    hard_header_len dynamically under RTNL creates a data race where upper
>    layers reserve insufficient headroom based on a stale hard_header_len,
>    resulting in skb_under_panic when vlan_dev_hard_header() is called.
> 2. In addition, vlan_transfer_features() updated hard_header_len without
>    updating header_ops, causing a mismatch between allocated headroom
>    and header creation.
> 
> [...]

Here is the summary with links:
  - [v3,net] vlan: fix skb_under_panic and races when toggling HW VLAN offload
    https://git.kernel.org/netdev/net/c/447cbe95ebb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


