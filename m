Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087F36E460;
	Thu, 24 Sep 2026 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217092; cv=none; b=uUV4oAhdu7HDmCB8P6rHK1ks4juumDYhYsTPU5rfGeRHvHijVpk0z3ehG/IuRb5XnB447F62bdDJxhwbxxCTtaIW3mvhjOlBXxqx0oCzwhqSMFUnAMlUC5i5MShsdj7BrP4E6EuhrLiwqgMI6q4BVCwl6P1b1geeoSC5XzyWuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217092; c=relaxed/simple;
	bh=z8A+upRzWOoH0KV2oHewwc5lQGyYPK2YWGejk+BBYMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oAAf693IuFOckGNR9zHPwjNMcIlsWROqXLb4fbYUx8ksanzSQgWcrKPSSSgV3cbWdBDEqouTLLhpc5OXKLEDzsu891lc+E1EOAJzYJGCRA0m2wUex6QCB0VINLF8UuDN7OzlCl6kXYQFIThO1oz2qvVP9yEB7C16/unVPaUkk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC5xI6yM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC5xI6yM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85461F000FF;
	Thu, 24 Sep 2026 02:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790217090;
	bh=2qc7d2EWlAB6vGwNe4e6/zzd/A8J1JEyXp8FOsKTS5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JC5xI6yMewNWhNsEmO7JHny5cUGcQ9hRjrTCOpGEA7hCuTOaO71iLRgCRIouRJuFL
	 qeQIZpHkVP8d9aNMCRDhC2i9B2eHQeLTeohmixvAQKQHP4e3DVjsP7NNIBmPJ9iy5V
	 SEIlkyAb9Q3dNW2JVdoItMt1Ip+5ZW042ZB2aGPSgJmuYQnxGISbIBveFxSpf0ua/S
	 k34VaEIlqR9t4pROBMgDFb1qLEikHLLRsdkEzFKiBPGGDaZ6sNUxJh6zTbcbn1Q052
	 qPvIhCwNc/XHsoZCUpnGPhdgzCyS4TRlL4T+zwRJeHD+ksrZ2BVuf1pyBv7+3d4kyj
	 tFmJ2lPOdXp/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6939E9611;
	Thu, 24 Sep 2026 02:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: npu: cancel wdt_work after releasing the
 WDT
 IRQ
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021702008.1285615.10214789929001458933.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:30:20 +0000
References: <20260922000914.542068-1-mhun512@gmail.com>
In-Reply-To: <20260922000914.542068-1-mhun512@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 ae878000@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 20:09:14 -0400 you wrote:
> airoha_npu_remove() calls cancel_work_sync() on each core's wdt_work,
> but the watchdog IRQ that queues it is requested with devm_request_irq()
> and is freed only after .remove() returns.  airoha_npu_wdt_handler() can
> therefore schedule_work() again once the cancel has returned.  struct
> airoha_npu, which contains the work, is devm_kzalloc()'d and is freed in
> that same unwind, so the late work dereferences freed memory.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: npu: cancel wdt_work after releasing the WDT IRQ
    https://git.kernel.org/netdev/net/c/4bdee8060d1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


