Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7D3F6C58;
	Tue, 13 Oct 2026 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899418; cv=none; b=TSRwhbqxAAHJC93ZMQ5MkRFdxWw6SgWfh5SJHNUMNC3E2Svc36y6N7M6YNgVF6157doZ3GdxLUscozQiLkQxXJpNcupYpk5xcUo9qedTef9QaBxVy9SrYg1smwR8TTl6g8m9zTWscNj+yN3D4rQoU691FGgK3DFvCMnaLyhxCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899418; c=relaxed/simple;
	bh=cshvhmMpmj1/BGULN8c5GQlFcwoTI7EoColSY6FUwLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OqcaU3F9qw7q+e79w7MUvRqHNGcla2cc59BPu3LcHWfoN3nI1cN/zlJaIGiOZbtUSQqHPAlaBbz/YPjoJlE2EzBcF287o3/q+jg/15/3qKOJtgZcwJamsEOQJrSJ7DdiYCDrBXo0IK5HGq2PMSitxplg6HefE1zudSz+phKlagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tojjyhoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tojjyhoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079191F000FF;
	Tue, 13 Oct 2026 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899417;
	bh=zg2VDZQb+FRJn50eJZLLWaUjmGmkT0kLF6b3QjB13pQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Tojjyhocn1XQxGx7z9MsJCYAMx7xxtEZZvyILR2tzktjKngHJJmaAYycD1hf/kmd6
	 YJvnlqttPXTiXBY7djPTUvKynqul3JcaQC7EPtC9bYyaxRlXR/P+gOmomMId2UpfAS
	 ln/O3SOmXgexJ9XRxhmS0DpNi8ZbU9onvzwEVmaRrEsr0O+KC77yOKqIm2BkTM50nW
	 m84aP8fYso/0sisguB4nWcr9JJillrKmIhBWLAj5CxBGxqqa++DzeaR5G73jsU5lnx
	 Oa8dBm9+Ic8elzJuVAQoWJaAvRNiCaidA1l/bJ+uuSPYcFgspaWbQZa0I3V+TUSXhT
	 px5Sm8ZYv4YNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1643392720A;
	Tue, 13 Oct 2026 13:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: alacritech: fix dma_free_coherent() in error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179189941555.316800.15857623450721648198.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 13:50:15 +0000
References: <20261006140912.50828-2-fourier.thomas@gmail.com>
In-Reply-To: <20261006140912.50828-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, LinoSanfilippo@gmx.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  6 Oct 2026 16:09:09 +0200 you wrote:
> In slic_init_stat_queue(), a series of coherent buffers is allocated
> with the length size. The size is then stored in stq->mem_size for
> normal deallocation. However, in the error path, stq->mem_size is also
> used but is not initialized. This error may leave the freed buffers
> mapped, leaking a resource and allowing the device to access freed
> memory.
> 
> [...]

Here is the summary with links:
  - [net] net: alacritech: fix dma_free_coherent() in error path
    https://git.kernel.org/netdev/net-next/c/05b5019b01fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


