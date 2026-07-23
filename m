Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0013BB9E0;
	Thu, 23 Jul 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820066; cv=none; b=RHakJxE5SYSNoiecZmraqiJOY4VpU3ukx06uTOIiCJSbpSi9EGHqYv6Kn/OvexwtY9efURKHgroAG29KJ1wbSQijlO0lOgwpeM4AZG/wSFruJjA1dzGu46VC8cOfOZDlviekKmA6Zk+ljJoPvoIh5MhDqPzHzLHvQMK3Q4ZUEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820066; c=relaxed/simple;
	bh=A6lni+G3GvSxgEEpupRpkqdr3vXaQwvGcU5EBLs/Fd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LBNi9Po6qnFqOYFupa6fRn0yYD22v4J3QKTXbfgYYxjc9zGatb926qbLA3Ro0nXiDpLcYflvs/Za3zE6FMYioaEaN+H5XOLSAt1p8Vue4MSIaa7DykiZ2jwZcdi/ag29L5zLThtkRyGNCsMauFbnJg1196kCCaIzpf6uUxi2dFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAA41F00A3E;
	Thu, 23 Jul 2026 15:21:00 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198963924453;
	Thu, 23 Jul 2026 15:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] vxlan,
 geneve: require CAP_NET_ADMIN in the device netns for changelink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482001663.2315735.8917962308148940780.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 15:20:16 +0000
References: <20260716203500.70573-1-doruk@0sec.ai>
In-Reply-To: <20260716203500.70573-1-doruk@0sec.ai>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, fmancera@suse.de,
 sd@queasysnail.net, linville@tuxdriver.com, mschiffer@universe-factory.net,
 maoyixie.tju@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jul 2026 22:34:58 +0200 you wrote:
> The recent series "require CAP_NET_ADMIN in the device netns for
> changelink" (8165f7ff57d9..27ccb68e7ccc) added rtnl_dev_link_net_capable()
> and gated the eight IP tunnel drivers (ip_gre, ipip, ip_vti, ip6_tunnel,
> ip6_gre, ip6_vti, sit, xfrm_interface). VXLAN and GENEVE share the exact
> same shape but were not covered: both store the underlay netns sticky at
> newlink (vxlan->net / geneve->net) and their changelink() operates on that
> netns, while the generic RTM_NEWLINK path only checks CAP_NET_ADMIN against
> dev_net(dev). Once such a device is created in or moved to another netns,
> a caller privileged in dev_net(dev) but not in the underlay netns can
> reconfigure the tunnel'"'"'s underlay.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] vxlan: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/3a61bd9637f3
  - [net,v2,2/2] geneve: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/8efb8f8bbb35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


