Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2DE371889;
	Sat, 22 Aug 2026 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787429461; cv=none; b=q8JGC3UR6kKZIzr59cYrsjiRMXfrN05vD/jV2BZ10oDPlpSoHUlR2MAmwqC4Wsi5eaBIFmkPZCUwmTLfymOyxAF0DkXjRJIulJK170UzAienJEmKq55OshPjMmsQz/WHrk1At52AEQ18fzZyFSH5ZNvya40p+22dJhXmkOThrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787429461; c=relaxed/simple;
	bh=0R2BMXhX+R9RwwWcjmbOQBJgA6wnoEe1TfkypnUzjfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=caO3X/2iA/q+Ts5aV9n29V4q/vI9hTNpGpqtoY304d1zA5X1Qe5yRtkGBGgf0qN1qxF7gLi1UVwh7WNDJyZn6JTdTOAPGz54gexAuORdyZi8XDoX8ubWbJtHay3wOIvL2EIgSWPx+9UIvr+2NAHZlV6+Dhvt/5jxDUJO3hRHTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhmdYvvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhmdYvvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD54F1F00A3A;
	Sat, 22 Aug 2026 20:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787429459;
	bh=/P+ttF8JkD4mftaRqgP45/jEc51+WCm8e6WATTMbhx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lhmdYvvTZwgjcNSCfw7NWRHtwyyDQDV+TdtF3w28yrgRdcs4afw5RqRESl1siYgLC
	 HCSrejvNny7bTPy54Q+nYx5vdEKA/lxGHbrJGHVf8Zb4n+YHu/LrFr/nxuhUm/0aOz
	 q15XU3thMHWSQjcNZGPuesdt1drafcQPR209x+/+Kn6fm6OZ+39PTvcGbW/ibR1e27
	 ViZJoHGg1FuUj//3xEGgPpbYFBCn1pkYPnYfbUMGfvBbHffPOahu/50iESJOcd0Tuo
	 Q92IXCMfeMzRtXZWS/8PQiRRIAEtUDHOcLd/yTgywQGju0o03puPTgeOv9FOwcf+G1
	 aiw9gyUSuObdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C3380CEF9;
	Sat, 22 Aug 2026 20:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipip: fix skb leak in collect_md mode when
 metadata_dst
 allocation fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178742940838.1814690.12298036275271719275.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:10:08 +0000
References: <20260819104338.432631-2-littlesmilingcloud@gmail.com>
In-Reply-To: <20260819104338.432631-2-littlesmilingcloud@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, ast@kernel.org, tgraf@suug.ch, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Aug 2026 13:43:39 +0300 you wrote:
> In collect_md mode ipip_tunnel_rcv() returns 0 without freeing the skb
> when ip_tun_rx_dst() fails to allocate the metadata_dst. ipip_rcv() and
> mplsip_rcv() are registered as xfrm_tunnel handlers, so tunnel4_rcv()
> and tunnelmpls4_rcv() read the zero return as "the packet has been
> consumed" and do not free it either. The skb is leaked.
> 
> The other tunnel drivers all dispose of the packet at this point:
> ip6_tunnel.c jumps to its drop label, ip_gre.c and ip6_gre.c return
> PACKET_REJECT, which makes gre_rcv() free the skb. Only ipip returns 0.
> 
> [...]

Here is the summary with links:
  - [net] ipip: fix skb leak in collect_md mode when metadata_dst allocation fails
    https://git.kernel.org/netdev/net/c/6776efe4a52f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


