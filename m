Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CDA3A380A;
	Thu, 25 Jun 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352827; cv=none; b=U6tkAQ8qDyEX3ODcT2pZcodIoWZOrOLNXz8HGFCNTxGRbzQBkPg/4VOzytxsiUdxWf7HEkyM8+pdfRjf0tr/M7LBHPEpf7i1Xf9qNBl1wwfYGVOQ1PsJ7URfUY3ZOSBk1h3OhRx9M7nz5Obl00Opx/R6sVx8h3RhhtRiCns5eT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352827; c=relaxed/simple;
	bh=JhpRxmaYdLqWV9sLIwrq7oeRsE8pP9kCiPjtC76SgQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cz8bg9Ch4N3UkCZy2uZLeQhqIqe/PUsffovYlbqXddDDMltvy0RtrvUSBZyO7LoUvmoFRrzDzLypjXl2u2pVq9ivOZU71D3LFjfxae7zVYLPMmxhlHaySPShrHc+/ZlZ9EZUsVAJCau19PQBKb0uts0RDrFC7GukpDlk7LsO3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I00Flp+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I00Flp+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90561F000E9;
	Thu, 25 Jun 2026 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352825;
	bh=B2eXHOvj8J5ukFiAwrkLBUAk2f5BrRG8ICf3A/V3/hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I00Flp+Ubn3WzMqwq6mhZ4w67rOcvDuV/U6W6iel6E91muTk7VXfuDaJ5FhB7HOT+
	 YjBBmcguJtKARqNPGBCx6qEVECM0d+69OQ9H6FDTTvUIZI48O9V8r/CqQmcOV7MZPC
	 oLJL+wUkYu6UCZq1sPriQjV/d+UUiGHMMrly0kmQx8aJuyvBiGdRw8ewqyu4W1ScRL
	 RwWVEUnRLAW5KC3y0EkTHUd5Ku+O1Vi9xtkw/U0f6kKFAv6SdTWBK49Oa6jWhCkT+P
	 uuV/1WOcG2/p644ZgS/4QAhXaXoeVZrNZxcr1Wwkl6pIjibv5aoDmZTznLmQPkldUI
	 SL6E7i0W8KKFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569673AAA6D4;
	Thu, 25 Jun 2026 02:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: t7xx: destroy DMA pool on CLDMA late init
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235281379.3078979.8826482950004098829.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:00:13 +0000
References: <20260621031714.3605022-1-haoxiang_li2024@163.com>
In-Reply-To: <20260621031714.3605022-1-haoxiang_li2024@163.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ilpo.jarvinen@linux.intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Jun 2026 11:17:14 +0800 you wrote:
> t7xx_cldma_late_init() creates md_ctrl->gpd_dmapool before
> initializing the TX and RX rings. If any ring initialization
> fails, the error path frees the already initialized rings but
> leaves the DMA pool allocated.
> 
> Destroy md_ctrl->gpd_dmapool on the late-init failure path
> to avoid leaking the DMA pool.
> 
> [...]

Here is the summary with links:
  - net: wwan: t7xx: destroy DMA pool on CLDMA late init failure
    https://git.kernel.org/netdev/net/c/2bd6f26d4ce1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


