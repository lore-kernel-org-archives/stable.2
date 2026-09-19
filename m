Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A1768EA;
	Sat, 19 Sep 2026 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776690; cv=none; b=CqhRN4akWg+/uCJ5V/AlY1gyh7rQaT+9PeKI4XRu4YTm11PxcHt0PdRm3Cbw0L1m7iQZtLm6xvI4znmpGk8bsRzbl5nEmOCIhNKCDsE8rMyT2tGwjnXAqhFZT96AkEOG6aTtoRuRRiI/zV85gdX0Y+eKbPsEYu4OgJo4dcrkE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776690; c=relaxed/simple;
	bh=y4YGe3OhDAz+8bGGzF7i/mcIygKGkFQDPfiAhT2bsRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sAkRRgmxYUWDB56DEkabxtENRQo6/3Xl5/25asYFJyt/VO1uibQfwDrmx2Rfc8/TFritZUEEKzsrAGSj4mKZurv5r+uelvqFSADcjC3HAY0lvkNq4qr2EzKcGRr/xpbPAoX90bypQcsqHZ9rkr+ltityX2jvZc/ErAPB8BxATVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNnT8ta0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNnT8ta0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B161F000FF;
	Sat, 19 Sep 2026 00:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776687;
	bh=KOINVxgqoFKzSX8a5gZMH+tl2aPxnd4p5tQznpEqfMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VNnT8ta0xWtd97FG0fmVQs33InxDyXuVJLUfN/ARATvkI8pwkUsXBgBPIZMnpEz1W
	 BGYsIWhgxr9FRjfCk8Z7psbkMjzbXLZ5yXsn8gUBT5BRU8mVHi7Wpy7amPGpNgdRtP
	 en6ya0/Oh/I/rDKpUS8Vr8NXzmdl9yeEXpK3s0N8XHOBFHZQFLvBBEjvRpw+Z8pBHX
	 rAdjsB8r6aT9the5G4F/632MoknxCLFZ4ka/jLrl8NdDIRI7VHBQGcgJ2wxjFqfBFD
	 xMOwIYsXi5g07Sf5r+NBrzKh0nA88WcsejI5QMu2eAvKe1xCAIWenCUG3GU+mK8NpD
	 aqz8idK9dGUpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B13811977;
	Sat, 19 Sep 2026 00:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dpaa2: ptp: fix device node reference leak on remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977662064.1197442.16493624007705281871.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:10:20 +0000
References: <20260916030015.2818545-1-lgs201920130244@gmail.com>
In-Reply-To: <20260916030015.2818545-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: yangbo.lu@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 11:00:15 +0800 you wrote:
> dpaa2_ptp_probe() gets a referenced device node with
> of_find_compatible_node() and stores it in dev->of_node.
> 
> The probe failure paths release this reference with of_node_put().
> However, after a successful probe, dpaa2_ptp_remove() tears down the
> PTP and MC resources without dropping the device node reference.
> 
> [...]

Here is the summary with links:
  - net: dpaa2: ptp: fix device node reference leak on remove
    https://git.kernel.org/netdev/net-next/c/9211c455dee8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


