Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D81310652;
	Tue, 22 Sep 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073676; cv=none; b=kMDeuYRM0iGAipI0CSwRGgF4RMrE0OEMsir9NWp+aWoHwM8B2n1cxSRj+69rHxUCKDNe9PT9uRTx1EUvz31kKS0IXi2M8IZaE/wKS+LDcBqge/pB8eUkwDkG5DW1l8E3MxbAZo1aVsDWgyCeh7fXvbzIgX+SRxhJLx33zD6yPYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073676; c=relaxed/simple;
	bh=hV9vsYtX101V9r5i+QJXr04DOL+KEXBc+LAGYMcY8PA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cF5o3W38iggL6yv5vKXfLQDbSu2xPa3AY5FArUVLEC1CLhJPEmZf2gqLcGRFlJ4Vs3BrfBN6HM0uwE1yQ8gTJwtyB110U3pRnN56CZU+VcMph67uajpKzVtRMTJHNt4uXDQWJvuKSrsYsQrOIR0jzkrNNmNPkyVY3JLANecROjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhqBAf9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhqBAf9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7526B1F000FF;
	Tue, 22 Sep 2026 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790073674;
	bh=5QRKoNwPzI5qvafb9DBbhShF+AI5DcS7c/jRC31Z35Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YhqBAf9t06FtnTDzPWmAgBDBzkDwoTkaWj+CuLhMtX04sFsM2uui/JTeyAywEBpjy
	 E3zD0K1/ZyFsr2VuQuDKoF0GBa3eFYj4anlnba8nnn2Mslf7SlVrL/jN2W+XsiG5si
	 NZCYYEmWnug6PdfOb9MFV9HVkFOWfMYeQlW/BMHJcrpCZdwjMoYa8PLTWvzOCXKRD3
	 FjYKqdELFTfn3vEQ2+ozJxtqVbLFcIN5lSc9E1PS6pZ7M86ftw7uRf7wGsbr5F945A
	 o4aCBZBDZ61KgQP6SySbB1s0Wogo5/bW3WoYZbuXgPxrcbr657A5ThdCbSAVU6OCC8
	 oNtEyAdzcJJPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AFB38119C2;
	Tue, 22 Sep 2026 10:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] fsl/fman: Fix clk reference leak in read_dts_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179007360564.3550552.3992065333873284402.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 10:40:05 +0000
References: <20260917110135.2148068-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917110135.2148068-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 igal.liberman@freescale.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 madalin.bucur@nxp.com, netdev@vger.kernel.org, pabeni@redhat.com,
 sean.anderson@linux.dev, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Sep 2026 11:01:35 +0000 you wrote:
> of_clk_get() returns a clock with its reference count incremented, but
> read_dts_node() only uses it to read the rate and never calls clk_put().
> The clock is not stored anywhere, so the reference cannot be released
> later either.
> 
> Release the clock once its rate has been read, which also covers the
> error path taken when the rate is zero.
> 
> [...]

Here is the summary with links:
  - fsl/fman: Fix clk reference leak in read_dts_node()
    https://git.kernel.org/netdev/net/c/a644f09b2090

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


