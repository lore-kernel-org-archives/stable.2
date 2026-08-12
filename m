Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1C1A682A;
	Wed, 12 Aug 2026 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498258; cv=none; b=Dj8pkAXFhYIh6Vb1ed4oSPBGSlN2IoIPOycFGq7UEFDWRGTCXgG3A2Knlg7SGjhZB33mTWM79ThG8zu8gwbnb9DT0e0nS80umBEi3PcsyjgFECxnKwqSntof2r7x1DO3vfRFUflEoPDt8+5OspwetWOB66pS2HoOW9mxi26W2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498258; c=relaxed/simple;
	bh=Bpu85HgzgD3EuLDzwbOg9JA4P0SC3KSNEg/8s57JXj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YVjzOe1UAn1QXNOxDaWi+RmSQzxtc/PiTYP59jdXniJg3GlJPznPFh8o93vVo7D0c9+YbGQSbXP5E6/o8S6Ex8dAzcov6aPe6K5YxPq9iAB5MnfRYJCtnNxdYmGRh1I7dUa5vEvqgRowinFuV6ztFoiXuu5WmXMaIKOnswk1FdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8y7Mxdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8y7Mxdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901401F000E9;
	Wed, 12 Aug 2026 01:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498256;
	bh=sfrtK4cOGTNKAcmDslTJhy++Uid1L3px5KwZv4jvA3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l8y7MxdmcF0CZ4offhP+ROFJWSYkRmokrebxatp0HL/MyVOAD+j8Zz4OEFEwvs1nF
	 eeMX97R0tQ1GCRJUlS+/+Qd7tEXN48Q08++8dr+ceZwwwb9nGsB6Pe522NYhysEGjW
	 pnTHdbgS5XaQywHFoibKJimRGAkz00gDbG0o14uzkgFi8PFqhkaTyJKhAAT8Tp/cxT
	 0fOekYeXx3yOsaFp7Tai17sGcp0jiex3sSpCrMNj4pvAvSmCRoQA7GSFHHPneDE8hv
	 r4FLlXBuLam/u54cUqgzFrcko98jJVJUPsRStRU1/N8hxSaTCa4pf7XiLg2obGZnNn
	 qVqBfdgvGJLNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A863809A3C;
	Wed, 12 Aug 2026 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] gve: Bug fixes for header-split and PTP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178649821214.1227528.12284058871566052074.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 01:30:12 +0000
References: <20260807224315.234152-1-hramamurthy@google.com>
In-Reply-To: <20260807224315.234152-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, thostet@google.com, jordanrhee@google.com,
 ziweixiao@google.com, willemb@google.com, nktgrg@google.com,
 pkaligineedi@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Aug 2026 22:43:13 +0000 you wrote:
> This series contains 2 bug fixes for gve.
> 
> Patch 1 fixes an issue which causes TX timeouts due to HW detection of
> an illegal descriptor. This happens when receiving header-only packets
> with header split enabled - this produces an SKB with a zero-length
> fragment.
> 
> [...]

Here is the summary with links:
  - [net,1/2] gve: fix zero-length skb frag with header-split
    https://git.kernel.org/netdev/net/c/6bf14575c655
  - [net,2/2] gve: fix NULL dereference due to missing ptp adjfine
    https://git.kernel.org/netdev/net/c/3992ced109c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


