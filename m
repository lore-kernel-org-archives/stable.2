Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571425;
	b=1Wr/au0pVCDRQNFR5nvK1y0yn7wCBTHi1z0yf/v7+HDisirRj9Bnbi3ltEDNcb+u7Fp7
	 5Vxm+QEJWMdA18sZ082ihnRFH4obI6thIJTYJRS7CG9QPbLW2nNKy+T5Vv3Viz1CiugTF
	 0/5lzPjmqXJTRU1e3aPj6WIFW0zD8t88ODxpZBpXAzIFDTcSXjhUwniuUNxil6jxrVAGu
	 /kb53vHmO3xKvQOnODI+ZhNhSK6m+bY9HasDemVGXATJpvLGyo50igupun6PcQ4QbaQSi
	 HUicxkFw/3F64F5xhY8k/g90OAb8c/HIoUqh4ESlLFbmMe60mLLQBxRQ4DS9xjaBD2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571425;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=UARKkxG8v/FxLOwHbeoJk4xGIgzo4xkYbvdWI9tXmCk=;
	b=lQU0aIqv+ZrFhtnq4WRDcCvGVymhrwuZmYfFYZB0lzyds/RD6WSg4ZNNLQklsGZgHpK+
	 1t8YAcyazn8X/fIaWSgehGBchp+AfQZ6o4VjDYX8hRP/g0OhXk450DaeFzLL7akaOuEgN
	 FLfYyyZMKYGpGkN9R8WbBMBmZ+/Ere1ggUp6ZMDJIs94oEflv6TQCD7li6fTKn5tDk0Vd
	 5ynsXRiyjJAwevxOq1jlO4lNvjZgYtlAhvnZVlGYZgduwk5g4F2AORaH/jHFea+GGJso0
	 HadxwTQn3hukoVeSgo4HtGLpIXE2Fv8o3QUx5IM4VTtFdQVxHISo+57PaWPtGo/LKwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWlsXTGV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B3607412D;
	Sun,  1 Nov 2026 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWlsXTGV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACE31F000C1;
	Sun,  1 Nov 2026 22:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571425;
	bh=UARKkxG8v/FxLOwHbeoJk4xGIgzo4xkYbvdWI9tXmCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aWlsXTGVrdI7jijjtDRDpVp2iW7JbtpN8zW3KaG3LTUEXDnqc/gmpYJDMGSLYrxfI
	 T+zxJhPLwsWmx6EUEMjqIjWZn7ZT7BGqvbxqA/hID2NwI+EHpyzr9oZlL/rmxd/FXT
	 pAJRIt559uJkZ2N4OIT3WzqBZoWyjOL1ykUQOH/xrLuM6+Ipji/sLX6MkbPs5+x0PZ
	 +nraQLUY2Uy9qNbMrxA9H671ALuOk0qGqfqGmZg5eU+XAmpDGjAhik7aIYMppbZ6HE
	 Cdatf7nxg/lUVofezd0mBqPw9JAuna1jOzH7NflXaQKGDpDj+1q4yh4WrY/AwLCuMt
	 DXF4usnxXgVrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401F638003B8;
	Sun,  1 Nov 2026 22:17:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] clk: tenstorrent: Assign .num before accessing .hws
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357142379.2624073.14814247366912220033.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:17:03 +0000
References: 
 <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: linux-riscv@lists.infradead.org, dfustini@oss.tenstorrent.com,
 jms@oss.tenstorrent.com, sboyd@kernel.org, bmasney+clk@redhat.com,
 jbrunet+clk@baylibre.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, asrinivasan@oss.tenstorrent.com,
 kees@kernel.org, linux-hardening@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Drew Fustini (Tenstorrent) <fustini@kernel.org>:

On Sat,  5 Sep 2026 21:48:35 +0100 you wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in atlantis_prcm_clocks_register() due to .num being
> assigned only after every clock has been stored in .hws[]. With
> CONFIG_UBSAN_BOUNDS and a compiler that implements __counted_by (GCC
> 15.1+ or Clang 20.1+), this triggers an array-index-out-of-bounds report
> during probe, and with CONFIG_UBSAN_TRAP the first store traps so the
> clock provider never registers.
> 
> [...]

Here is the summary with links:
  - clk: tenstorrent: Assign .num before accessing .hws
    https://git.kernel.org/riscv/c/da9f1312b06e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


