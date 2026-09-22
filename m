Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0A53E2E1;
	Tue, 22 Sep 2026 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077285; cv=none; b=PgpbSJ14vdMtdQYz9PBVwxZwUDQrJJu156J15nCwYxqwhGhv44HWxFY8RRhaGMbHHdSLB1tE11010fEAKgOehq1X3CQmyiOpo6vIGnOwZg5Q9evVDhvFtCUe8MYxFD3GeTLwn5H4joUs30NbxrN6b9NXjDVj+rCJt6wrGqtuXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077285; c=relaxed/simple;
	bh=u3sjn4c6K8C8jHrj3CcZ7zVWcqdYF6UZLIp4Nt7nT3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PQDaI/tZ/D2U+HupddkWvCW8D36c4k100ofGTdLTTAMEbN3n7RqTm8YtsGbjdpD8X+Tm6tI1cKrL/pCn1UiPOzw2zS85PitPcOnqnkrlX4mU+Pr7cEXsYoi2btHDIYZcF0Qtz8lhe98KNKGF8RbpM6WaKlX5MDovEriZiz157W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWSc6HFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWSc6HFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EC71F000FF;
	Tue, 22 Sep 2026 11:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077273;
	bh=eG5EWX5b9oPO4xXbwR1EIBMODFBugrvojXmWfkujSRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lWSc6HFIV5F0/RJA8Vvl6GHyWpU46gTxWcX8oo1fvs18bRetUeovhn7/ioayh6AeT
	 2oXAKt6+n4/Ry/RV4QkvMPqijRdYU3ely2TcFu/8UgvYRYugC5gcWeXql3uM/jqTAV
	 vx8faJQY81MTrp1ajLU+RTs4svFggpaE8mEhhAJUvKNZh+ytrBJRuYTx9L2FDvX6hQ
	 LwQvlTObPakptIkR7YF/4Ur4SrtybT6XPePpvb6VCB2MQ4Q0pTCqH5aRJZSlZyI73y
	 Z4FsAdKLxF46KILghoi6VrOPBVXlxH8hM56GahcbxqjPXE8UgH0fKV/gI2Z4190lgy
	 AJa7uxAfDtLHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1979038119E2;
	Tue, 22 Sep 2026 11:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: fix dma_alloc_coherent() leak on
 macb_alloc() error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179007720490.3575540.4790715195538944680.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 11:40:04 +0000
References: <20260918-macb-alloc-leak-v1-1-aba9a3d4f6e3@bootlin.com>
In-Reply-To: <20260918-macb-alloc-leak-v1-1-aba9a3d4f6e3@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nicolas.ferre@microchip.com, sean.anderson@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Sep 2026 21:53:52 +0200 you wrote:
> Fix 3 leaks in macb_alloc() error paths:
> - Tx buffer allocated but crossing a 4G boundary: Tx leaked.
> - Rx buffer allocation fails: Tx leaked.
> - Rx buffer allocated but crossing a 4G boundary: Tx & Rx leaked.
> 
> This is because our error handling calls macb_free(bp) which in turn
> frees the buffers stored in bp->queues[0], but nothing has been stored
> in there. Fix by storing allocated buffers into bp->queues[0] ASAP.
> 
> [...]

Here is the summary with links:
  - [net] net: macb: fix dma_alloc_coherent() leak on macb_alloc() error paths
    https://git.kernel.org/netdev/net/c/23d42b9a3bcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


