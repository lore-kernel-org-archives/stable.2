Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921729ACFD;
	Thu,  8 Oct 2026 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421211; cv=none; b=jCW5zVi+EsZLeHXsJaVrPpRWju1Od5crbxcwon1n1tSPwOoBwAS3Km1m/JMt+qcxxNWRx0skYsCZbFRSreGnLa4lnvEgbAK0ViXrKr9iAOUhGa+qTvVk5zd6gOWE71vsHXmgfTRubFgrRPZaa+ov+yGFnbVL1DPjxeg3/E+9B3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421211; c=relaxed/simple;
	bh=cp82urAXFXMTikIT7UBjIAFXXWGt4Ptp44O9K2nwy6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L3k+p8ONkH/Jtxkub/jeBWhmZfR8dB9PhOr0tHsCQu6VcDzTXh4eLHBgPHLauSxKDUytxXhbVfigEUr/4n9JmOGiKVG1YREJNbDTNwGGHeigH0+byttZcPaxvIk6wJQFDjGof1KuUGg4EVookONdHev+IkOwxriau5Ir6ilA1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV3cZ8as; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV3cZ8as"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A141F00898;
	Thu,  8 Oct 2026 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791421210;
	bh=WF7Jdk4MYnFTmQQdeE3aSgjiTVvBLV1kcsPClV3E9FA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eV3cZ8as9aR0yBXukyFHhYjzktPTo554LVEbrExXv4ktk1bUOuEO5JFLHOZR1U9IN
	 q+kD2YeH7U1SHsot8oJjEmq5kU/B+3dtBbhSjOIM+nHndrwaZS5sZE7jwSz8xRsArg
	 WZJD8smLDRtmUA/sk2S4GeTHdKBjgQ+CcJSEqC7LAJHIgWES/D9fJGcCCL0IPoWiBZ
	 CPpJxU9CpjYcRNsX50E6ti9wRn540nVGBztvKCEgjly5zRnLZBDP6urUzk81vQi0lm
	 FepEebYXimYdiVTHpqVaJtG7UdGM6Jy6za4J0UG196iCRlwTlMf05qMSlhwKvpRBJA
	 Lz20+IfpEsNlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1FC3809A08;
	Thu,  8 Oct 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] bnxt_en: fix DMA mapping length for padded small
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142120877.3755089.7300655408899224651.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 01:00:08 +0000
References: <20261007051747.455273-1-edumazet@kernel.org>
In-Reply-To: <20261007051747.455273-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, sfle@kth.se,
 edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, berni@debian.org, joe@dama.to

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Oct 2026 07:17:47 +0200 you wrote:
> Stefan Fleischmann reported Intel IOMMU DMA Read faults on BCM57412
> NetXtreme-E NICs when transmitting packets on VLAN/macvlan interfaces:
> 
>   DMAR: [DMA Read NO_PASID] Request device [18:00.0] fault addr 0xfc499000
>         [fault reason 0x06] PTE Read access is not set
>   bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0xb4 0x41a} len: 0 due to firmware status: 0x2000001
>   ...
>   NETDEV WATCHDOG: eno1np0 (bnxt_en): transmit queue 0 timed out
> 
> [...]

Here is the summary with links:
  - [v3,net] bnxt_en: fix DMA mapping length for padded small packets
    https://git.kernel.org/netdev/net/c/a51d233ccd48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


