Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE04219FC;
	Wed,  1 Jul 2026 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865234; cv=none; b=Ak0kBMuBxfS39FP9OE8QORw6wgYRBvxPfs6VnI6+sB0XWq9oi1mYDH+zRzingWBKbkyrENkHcOiaVfXfq/KDlztPtj6nBaw1Ihb6mHpouOm8Avt0prvD/Cj7OovpTLpsS2McrumQ/jiL8evTE/bx6XrzwFPxCGlyOsUF+tcFDM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865234; c=relaxed/simple;
	bh=OxqYkdm5oukw/D3esIbkiVQa9chWlaRAg7W5RbvRH+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U6Vt6pFAh8csUai9ii5ady9tuG/KAo9OIFqEkn/vSceyGPFcMSPKl4vbQzABhNc6A6JmrmjOYUSRuaNVuN3jNHbqZHwAuV7Sj2hZhjfn8wzcA+/FEz0md88dpvq/FyMGj5TmushY751fCxLeqySyDQbkiVOJl+mWPeBmE8jgcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6x60UYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6x60UYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E981F000E9;
	Wed,  1 Jul 2026 00:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865233;
	bh=GDWm7UoY/GN1c2wmlf+OtBoCfI1+yNa848uEEQNmsW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X6x60UYSAeIFQPpJNA3E3PDheiJwJNLv0DBAmXAWrURY2bT8oD+vEnUd6bdMLdGYR
	 2O4k4b7M67h1RPvYcO1d6YnIDwE6f4Gbv4Jf44BdG1O/A7WY4zIfaT+qEBxR0ZMSB4
	 yjC9Sa/9DtHygMvpbUBZmjH1DCy0uic3HWnlTrjJIK0GpZBFf9xum92IQCNe+Nw3Se
	 SpFtDqlDqR9rMm5ugVMIqvdTA2R+JWXnHzsKCys2voAyJv5Pgo8mdJunFBrvaBQ4Ny
	 Ej7Xz9mq5reOLUw3tyJUCc6gsF1iWTtlhnO2YK7pDCuF36btqj6zNiQHYIob9HoDCF
	 vgW2Vt12r7MKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AA6393A963;
	Wed,  1 Jul 2026 00:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sgi: ioc3-eth: fix split TX DMA mapping lengths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286521663.349616.4283880275529616693.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:20:16 +0000
References: <4E1486BC4536407E+20260629080623.908426-1-raoxu@uniontech.com>
In-Reply-To: <4E1486BC4536407E+20260629080623.908426-1-raoxu@uniontech.com>
To: Xu Rao <raoxu@uniontech.com>
Cc: tsbogend@alpha.franken.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-mips@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 16:06:23 +0800 you wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> When a linear skb crosses a 16 KiB boundary, ioc3_start_xmit()
> splits it into two buffers of lengths s1 and s2.  The descriptor
> advertises those lengths through B1CNT and B2CNT.
> 
> The first buffer is mapped with s1, but the second buffer is also
> mapped with s1 even though the device is told to fetch s2 bytes from
> it.  When the lengths differ, the DMA mapping does not cover the same
> region as the second descriptor buffer, which can result in incorrect
> cache maintenance or a DMA fault on implementations that enforce the
> mapped range.
> 
> [...]

Here is the summary with links:
  - [net] net: sgi: ioc3-eth: fix split TX DMA mapping lengths
    https://git.kernel.org/netdev/net-next/c/cd066559a073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


