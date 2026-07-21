Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2A25392A;
	Tue, 21 Jul 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650845; cv=none; b=isL1Ooc1htTF/rfRaDTPbFksOXjFMZ3y1GynE/RDfhLgeCEcrCrPSX0+QelRjPYtPzDNkBoLCeaHhGn/d21BEpCPcGcgr9831WP6tDInd3hppYdKv7XTG2UddrytIul5/Phwo/QZQLAZCGW/kq7PuvytZ6YcjuB/UKJ53lJj9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650845; c=relaxed/simple;
	bh=7jJNim5CJX3N5kflZeb02JSot3PGGJFmkgS6o3NvKhw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MomaI2gO+ZVP7itNRfBbrYnMk6iUplR3ltjttsTg2a3GYaq+V7fZEVHTLtcG7/1qsfEVUuHkdF1533nyVorcm0NOFvgvPZeIJeBAwtZ4HJ2nundKRVrrlY59F+HqVGonToQXn0+72ULlV2i1A4MI43EaroU/LM/DKP87IIgiQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqx5EZH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqx5EZH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4071F000E9;
	Tue, 21 Jul 2026 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784650844;
	bh=TEDb1rdTXXaOxGcVedScyLy6E03LA81nmhhVXtSJWRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Iqx5EZH6ygkfr0meqZq3fusjkqWib9uCYd7aOapnev/TowlPDbzWI2gmLCW+irH5P
	 fGa2vMQq2/E2s1ACy/jHVO+UCubIWZD9zkjbbWLjeUpxs8Rh5v8zpZWWu9fDzUGMXs
	 47TqWH3l/7jyAn21OBokR+GZD5IOh4btZpSCf6drWWejmbl3Tv89sjMMS4APpl9PR9
	 QvuhZp1JmQqYKOrq9JkmS8PKwuKSD87AM8fvor21xTDkNQlkmORNvRQCujabxV/d2L
	 YA15rGFzWJsDkoCaVkur79X78Oy1x25B5erzHToXjxG/uYSCsv3Avl9W9uSrvAZj8Y
	 27Isyc+e11nWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6E3924FFE;
	Tue, 21 Jul 2026 16:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7] net: gro: fix double aggregation of flush-marked skbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465081339.386198.5230421842534744687.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 16:20:13 +0000
References: <20260709014704.3625-1-shiming.cheng@mediatek.com>
In-Reply-To: <20260709014704.3625-1-shiming.cheng@mediatek.com>
To: =?utf-8?b?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKSA8c2hpbWluZy5jaGVuZ0BtZWRpYXRl?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?b?ay5jb20+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, willemb@google.com,
 daniel.zahka@gmail.com, alice@isovalent.com, sd@queasysnail.net,
 eilaimemedsnaimel@gmail.com, imv4bel@gmail.com, nbd@nbd.name,
 dsahern@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, steffen.klassert@secunet.com, lena.wang@mediatek.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Jul 2026 09:46:39 +0800 you wrote:
> Commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a GSO
> packet.") added a flush check to skb_gro_receive(), but
> skb_gro_receive_list() lacks the same validation.
> 
> As a result, packets marked with NAPI_GRO_CB(skb)->flush may still be
> re-aggregated.
> 
> [...]

Here is the summary with links:
  - [v7] net: gro: fix double aggregation of flush-marked skbs
    https://git.kernel.org/netdev/net/c/e751256486d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


