Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272207;
	b=QdnLBLBZ4wlFEMDBvGNeJ/NR3N5/jyIg4pbAmjHNSr3qrD2zbwZ1yLobNVCn2lf6kdyw
	 yK7hqlk7G226m5Qy9eP6KlfWf8BO2rlsH1BUPFO+DxNiJC4mcxW0BeY/J4uv7o+AY/i5V
	 DGaAUXkyPyT6Pf12ZWT7sCKW4A/6b4zd5hh0bC9Cw3vEK61aYXR9Dw3xhR5r/Q879TN+N
	 FuMO4a5oIsr/MogmYzrIV2f5C0lNJ0142HT7W8tTZljSM0wuCwXtbi/NRFEEqCZEkQKwL
	 Uoeg6NkIroVjXf2ZslFNenMQBmem1gfezWtzH3UeZPNkGNIHLk4MrO8S7MecmgYbfzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kczBu1gg7dLToH9eOyELlascBJYNLluBdMh7coHIHKk=;
	b=uQ253PUGAgYfvMM0RywmrpnE3Fg0HjP0e7Mv3+hQx7RC58qB6DZi6FenfD29KltZA86O
	 aazkEGdg30A997vAeaSGoCjkAmp1izHNGyNQ69gqjrBfP7o+GrflM+lKKcxZ9SuIMGRQk
	 r4Dpy5N6sAbb9dQ/DvswshIRh78KUWmsOtLGTuf4M0nRbNQtusmrPrfcBgbHmCFw5WwxD
	 mINNFFkPGjr2RcywCqbBJJMmLrvNgey8YmIlr1P6aaE7shYvH8maJFea+E/9bPQrzukVb
	 ihApY6S7cb7o8qKU0XK+hT/nNVyDnqBvR3szyz+Ke5yCES4SaqvHvHf7L7kaLlWCFIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCdfpV5C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308B606A31A;
	Thu, 29 Oct 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCdfpV5C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCD81F01825;
	Thu, 29 Oct 2026 11:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793272206;
	bh=kczBu1gg7dLToH9eOyELlascBJYNLluBdMh7coHIHKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HCdfpV5CBctFOiKFERljtg6mYIBC6YY+B2REc/1/np4cVLOxuBpUhOfdXRLDljWha
	 AE/shxfYt5JEUkWhECM4sgdUEg1b+0K1jnlCnieyIlUncbKR1XH8t0FIXrCriYfsbu
	 4bvz3adDyD3clbGRctdd01ByUXL6bmsrXDg4FJ+ngIfeajghalWSndcTLVSqy1Y1zl
	 IgQOCJdGDawmaZvo6xcUwhnnM0/UZZzxtIWWXJ9x2OT43V9gZ22/ZlLuUcc3zqpFvp
	 y7EkQzR1onw0LKzhIEQ8wmGDwRQpEjMUG3cnUVTYqo8DPYPdsmJ9nrVe40TJ2NAPVZ
	 x7WF/h5tmcSGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 445D93ABD290;
	Thu, 29 Oct 2026 11:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3] r8152: Use BMSR to detect the link state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179327220507.1762735.7924167128121822178.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 11:10:05 +0000
References: <20261026012345.1902285-1-lilinmao@kylinos.cn>
In-Reply-To: <20261026012345.1902285-1-lilinmao@kylinos.cn>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, hayeswang@realtek.com,
 nic_swsd@realtek.com, hsu.chih.kai@realtek.com, mail@birger-koblitz.de,
 zhangxiangqian@kylinos.cn, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Oct 2026 09:23:45 +0800 you wrote:
> r8152 detects carrier from PLA_PHYSTATUS without reading BMSR, so
> BMSR_LSTATUS can remain latched low after link up. Since
> commit f6f2e946aa4d ("net: mii: Fix the Speed display when the network
> cable is not connected"), the first speed query can then report
> SPEED_UNKNOWN, which applications such as NetworkManager may cache
> until the next carrier change.
> 
> [...]

Here is the summary with links:
  - [net,v3] r8152: Use BMSR to detect the link state
    https://git.kernel.org/netdev/net/c/85b4bc79dde7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


