Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060411;
	b=s16SlSAkvH/aMP7JKe9BoKf7Z5JFy1CCS9qoXnRi1tMvbEwLXBDUQvy3qOYs40m56zjg
	 x71U76yOZsROpEvzV0ONx2JR9f8ApXg/HAPgQlVxstMwsIRyegn5MEOnJ+JkKVSmeFc1g
	 JJ2/d/aVbI0MONYJFOmmQskzc9ubnsiZD4vPD65FwNNZbZiQavwP7NTMk/dLK1fECY6uU
	 c81hMg6QL3uWy4pw8s2bsE5rjVHbOMPt9KBJqfFc0VZIZCvxCJfZ86DBCGF+2n4YrJCjG
	 Q84cmlpWqF7GPdr7kKmabCe+QKYZ8QyfYQfcwvAt/JCLlAoT4p+4U17n+JE+QBMC7PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fnFK9si7GCQQ1LNZF3afXP0EKD127WuNV6E27ntNrtI=;
	b=sWZoIrl3ARohgjBCbbMFkKUk5xcEmuAwjvb2/3XG6Sf6CsPYNndMjeIikIh/p6lG4muq
	 EGRxm8ucIIBCTdmgUQr52U6Hq79FevH8M/6r4kfhV1WJGdRT3wPgaMhyNwmwvYXKlXrba
	 VA9+r/9pzk+JM6E0lefgEf135NzzhHx51SY7U4+wW7YriMxPhaTH2m30sMCJ79LFZEkhc
	 Szfmzj1Wcb83SdsaVIjG5nQn6K/tAZTChpXjV8GDW9uEaMa74yaA+jwXro/8krhYKS0Ja
	 +ZL/9v8fgFoMjxD3qPC2EgLXhdjJ0N5DjDJaJKojLjB73c75aw59q05+wWo3Dfz/Vew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCE9sb19;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AA1606A323;
	Tue, 27 Oct 2026 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCE9sb19
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DA01F01825;
	Tue, 27 Oct 2026 00:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060411;
	bh=fnFK9si7GCQQ1LNZF3afXP0EKD127WuNV6E27ntNrtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZCE9sb193IITckGJMy4UDYALM9IYBoaAVAbgZByCz2ebt5phbW38y7XF2KWvVKzox
	 Rju2onQRKztTKeYsn42izwJGJZVsox6cBukQIoV/7K+stbAQRf4uEquer/Oek0FtXa
	 BV+oU67TDoZ3tspwY2t4qUTU/qsO7Fqlx+FrylhipaVwQDlLHVKsgXAODmCRMoEEp3
	 ZaJYXhO0/oTHNkngHEI8CWJv9UY0vhpAyGaKuR5F2NHtHViRRGzn3m3E6hRXhn0cKx
	 Ad611shbxDcVGGNBkkq8OJuMGnCHc0ay1SlrSnIUwfB914CI5oJlM957lgTM/K27zh
	 Dzx6TVrKWskIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0736F3AA80F1;
	Tue, 27 Oct 2026 00:20:11 +0000 (UTC)
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
Subject: Re: [PATCH net] xsk: restore UMEM flags after failed pool assignment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179306040962.3479540.779090181651847653.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 00:20:09 +0000
References: <20261021224705.2078753-1-p@1g4.org>
In-Reply-To: <20261021224705.2078753-1-p@1g4.org>
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 22:47:33 +0000 you wrote:
> xp_assign_dev() sets XDP_UMEM_SG_FLAG before checking whether the
> device supports multibuffer zero-copy. If assignment fails, xsk_bind()
> destroys the pool but retains the registered UMEM. A subsequent bind
> without XDP_USE_SG inherits the stale flag.
> 
> The flag also changes RX buffer sizing after DMA mapping. On igc, a
> failed SG bind followed by a non-SG retry with 4096-byte chunks and
> 1792 bytes of headroom passes admission with 2048 bytes, but programs
> a 1024-byte RX buffer. On I225-V hardware, an ordinary 1514-byte frame
> is truncated to 1024 bytes or 1008 with RX timestamps enabled.
> Restoring the original flags eliminates the truncation in both cases.
> 
> [...]

Here is the summary with links:
  - [net] xsk: restore UMEM flags after failed pool assignment
    https://git.kernel.org/netdev/net/c/b88b826ec54a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


