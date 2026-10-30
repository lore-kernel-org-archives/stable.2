Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355006;
	b=pnWJlFVz2TOLfFgS6CMFJ8J8KtcNEQEyOAstoGtpPhW5m8RML0nl8R2v0MyQGIDnhD/d
	 8sdeEowxRLvARMJbc+XSne4kfTWk/aqLw6vv9QoNYAzFEAS3jnkWGhHbFYQij4kESiUi8
	 1INC2HP1oM4YNMHn0N42UK6K8zM7p789r6yXKLoTYjlrbi3jPBgRPGFh1lzdhH8zgerg5
	 l8sPDOctuQrJVdbRZW1ZnQEWwXw/k7WzESyGTZb7oUV7uYZrlKbFk7S1XbjgySqtLhTXH
	 /zdqOW74ZPel+xpVpyJn9riTS8+KCdfFsSIpHfrDQ0XOKPJvMf3H+7SkSrEmD/hMv7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Fj4VgTyKpbQHPNQf8lhh6JhpdgtR8Rf8gD9G+4TbHwE=;
	b=rFs9V8k93w8pCzyjXF7vpnF78AzDvBykO2YTis8ygl/2lnc58v5AYrMbjOni6WJY8MQ2
	 /pW9dC7EutbnmwUna+RUo3Zs6KpANPtTqZzzigKecBHoDpATO9cyf16PdNMxXnyS4/GWo
	 PKnxd2dAJjbk95dp7aden2KAUbXYI4n3ZnbbEb8ejGfcJoC6SH13zldUK++vAK8f4sFYT
	 87Nz7fbToSUZTpeUgvas1ckmusOPEuOAPNGZKjk00HCdFXgLlsaAuFWyg3KCbG1f7zGwo
	 xnrlHeqGGfnj9L++OeT6Bu7EgyeJnhKR9+512ZdTglpg9gN+5AQaMPyDWVNi3aGvJ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K4AEW/QL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92753606A31C;
	Fri, 30 Oct 2026 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4AEW/QL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43731F000C1;
	Fri, 30 Oct 2026 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793355005;
	bh=Fj4VgTyKpbQHPNQf8lhh6JhpdgtR8Rf8gD9G+4TbHwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K4AEW/QL+59deKQr2OYBXgObW0eQg85+CJWLoZKK88MgmKyhnm5UTv2DSbQUHFGPR
	 t3YPSo6KAiKeAAltz5xDkJgZtyyT1pBHB5o/t38Z5Mg4g4BTUcICknLURMmt3Irzc7
	 QKWRCDlgWAnKQdFi7PRnmYYSawDkNTG5jjCsrwBOmBd81f7ruHVOgr6AzgQc9xr93f
	 rMJ1YKT28SzvxERAzXYsDjOi7/kNPWklt3ol9DwL2AJb2RCsPOukpWqZI+socMd/s0
	 +uwYSOxXFRmlLBHIgGMMvMDIBHApOHe5/lm1+ECYlK7oYw0GZqUvIw9KMKqEeqaCPL
	 l3XQjBp8LVZEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1EA3800454;
	Fri, 30 Oct 2026 10:10:05 +0000 (UTC)
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
Subject: Re: [PATCH net] macvlan: fix allmulti reference counting in passthru
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179335500455.975222.9987670053252532591.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 10:10:04 +0000
References: <20261027024635.366900-1-prasad@arista.com>
In-Reply-To: <20261027024635.366900-1-prasad@arista.com>
To: Prasad Koya <prasad@arista.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Mon, 26 Oct 2026 19:46:35 -0700 you wrote:
> Enabling allmulticast on a down passthru macvlan, bringing it up,
> then toggling allmulticast off and on can underflow the lower device's
> allmulti reference count.
> 
> macvlan_change_rx_flags() only propagates IFF_ALLMULTI changes while
> the macvlan is up. However, the passthru path in macvlan_open() skips
> taking an allmulti reference when IFF_ALLMULTI is already set.
> Clearing allmulticast after opening the device therefore decrements
> a reference that was never taken. With no other allmulti users, the
> unsigned counter wraps from zero to UINT_MAX. The next increment
> fails with -EOVERFLOW and reports "allmulti touches roof".
> 
> [...]

Here is the summary with links:
  - [net] macvlan: fix allmulti reference counting in passthru mode
    https://git.kernel.org/netdev/net/c/d8a4f4c59da5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


