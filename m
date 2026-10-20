Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523417;
	b=n/LyC+uXIiPwlqV/8VHnM5arY8NFpJq8bRr1CMzWy+nBtMx8WRiWYH9E+azC/02KLKER
	 Ui/L2gCau/v9zk2NSlT+gYCS8Uadnq8ATQjGmuzp00Gom+dy40c6UgZe/8JXWBxzxuUuw
	 tlGfV+8Uy1HTg4QPzHaViRMuKpuNGdyd3EkveQtXuTTLu9waLb8N1h5LJqve4x26b+/5p
	 ZfuiGQ2WyqVne7Kv2IrqL/wBwQp50ofITJt/gd5p91gMjSzwVu3NThuMlh+7dBhGB7u0C
	 AK1QKXi0vGierNIBbBFs27XG1IdyHvD9TyVaBpMfwkbv3dq2shQOHjxNkhqjibrwFVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523417;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=RikwiHz8q0HsJLZT4M1TLtOxNEmvzvr/D1bXpPlVyRQ=;
	b=FWVZxoMTXwMLfA5GSvjXCjlpxT5iUU/dgCIl5tsc9rb64uWAc+5tvHMzHn8qsE3Y2TRi
	 87s2gkybiA06HcQePHHLHJp97Wc5BGyRQ8qOiNtv53Pfr1eY19KLKN5A+NV9akD2GrcTk
	 IQ4TSa2mua5J3pNHw0RQCq+F1s9tPrz4LuDu3kovhdarYhLoWBCfVvWlvj+3XD2QuYnpN
	 P2Aea0STF/5ad3NL2z7blteCY6sZQuD+YnHHBztbfrA9NPO36QOwolaezNHOMx4QyjkxM
	 q5u9KGyBt4NSNvTcyTYWpX90fWeu/IPp4PeOX/kUjqVZB16JeeA/IZYmdya+FKBzS7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGD+exYz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6563606A321;
	Tue, 20 Oct 2026 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGD+exYz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827821F000CB;
	Tue, 20 Oct 2026 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792523416;
	bh=RikwiHz8q0HsJLZT4M1TLtOxNEmvzvr/D1bXpPlVyRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JGD+exYzyW4tiqpfSdvc17FGbOLrNAui31N3Pd3wbiZmeAg0oiwaeqRx8/A7H9sQy
	 EL9zoZRX/YCXV9eQSe1NsRTHMfBr5v2LvI6AFtpHpSjKkNaB185L8tz1kwTwUQRyFh
	 UaEYafu0HvH8vb98Gz6k3qoHy76+oQpXqMes43QR/5xROMRI83ke/R793tL5/8+3HA
	 AfmI4U4M79vhPNhJM1shgA0kJPKvNhC249pRnlkZachKeJnrIq4nuwfAglAeypG8O9
	 cFSvZWLMI0HcrWfz7RpcGm/vodesqH8qmrrOSJUhIzFtZAvcr4m3xcr2JjPmr6TLrm
	 RILPQhjzPUI6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774413808209;
	Tue, 20 Oct 2026 19:10:16 +0000 (UTC)
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
Subject: Re: [PATCH net] net: axienet: don't advance the TX ring head before
 the descriptor is ready
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252341531.164064.14961781434199526406.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:10:15 +0000
References: 
 <20261013-b4-axienet-dmaengine-ring-head-v1-1-7add24e74477@toxicpanda.com>
In-Reply-To: 
 <20261013-b4-axienet-dmaengine-ring-head-v1-1-7add24e74477@toxicpanda.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 18:25:06 +0000 you wrote:
> axienet_start_xmit_dmaengine() bumps lp->tx_ring_head before
> skb_to_sgvec(), dma_map_sg() and device_prep_slave_sg(), and none of
> their error paths undo it.  The skb is freed and nothing is submitted,
> but the slot stays claimed.  axienet_dma_tx_cb() walks tx_ring_tail
> once per completion, so the next completion lands on the abandoned slot
> and dereferences whatever skb pointer is left there: NULL if the slot
> was never used or was already completed, or a stale skb that gets
> consumed a second time.  Every completion after that is accounted
> against the wrong slot.
> 
> [...]

Here is the summary with links:
  - [net] net: axienet: don't advance the TX ring head before the descriptor is ready
    https://git.kernel.org/netdev/net-next/c/cb790252f8e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


