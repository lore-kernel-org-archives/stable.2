Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43C1531C8;
	Thu,  6 Aug 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033250; cv=none; b=X7QmGpb7WjVYNwB+YscSih37pKECGyiQHtQhls3E9b32cJ9v7RuueESVUqHslCDDv9cM0RLfzkw3D21wZGRCgk9YvrmAd9tyqz+WcsOPrs8keT5AJCSMfq5q5za7DyQOIZbpCL+eqx4PFMxdlT3/tVJuF0+CuBC/6ra1w/fWirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033250; c=relaxed/simple;
	bh=YcLWmQ1vF37tEb/5wQezZfHg5bkuaXNi9X3Dyd3dkK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N+eET2rjp1/6Spgra63tXg36/fgFpyxWK9DUk6MNGf9b3rgWthY/pr9fh0C55AEFZLJwOgR4g3U1HA+tbdgNEwCmsn1Zl+xKHhorLBiIn3ia6MheBhJlQNlWCVCZ1kvGT7nT/EOzr6i7ilbGrIFPZLjXkbwsiEXgNphJgslFEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB+1FFag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB+1FFag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1462F1F00A3A;
	Thu,  6 Aug 2026 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033249;
	bh=H4CS06pqDeqDgqBFrDJWA+vdCzBz96OdRV3HljHaHvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OB+1FFagPhz8bRmjd6/cxDHE4ezRob5W06lNz7JiD+uPHRCOybauk6IXc6Zyzqq0j
	 u9FgaLVbYCGdISdHIMC1Hy/rCpacDhMGd27NVMW5Nuvsi9kKHtMaMNO2IZASXzitxS
	 nPiVMj95Ei+EZzd5wGXtL3N8j4o7oT4mSiOezkUpp673uYp8PKfvkvrFhwpTWSQW5r
	 kbzC+ZexHK5MBMy3ECJOQAPEvqu6DGXHAUDB3D2nn3mVRoecW9UmOOe2TeMsjl3BwH
	 V3K1k6REVEKO4JKwX7cIQoOR1SRhsFuP68dRvzTpEq8Ep2Otk6pDDYTyH+jFEbY+7p
	 SvQKH2hWFWuMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B6F380820D;
	Thu,  6 Aug 2026 16:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tls: rx: restore msg_iter before TLS 1.3 optimistic retry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603320838.1362900.14870685122061393780.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:20:08 +0000
References: <20260804125528.2139928-1-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260804125528.2139928-1-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 netdev@vger.kernel.org, jeremy.jean@oss.cyber.gouv.fr, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Aug 2026 12:55:28 +0000 you wrote:
> tls_decrypt_sg() advances msg->msg_iter when it maps user pages for
> the optimistic TLS 1.3 zero-copy path. If the decrypted record turns
> out not to be unpadded application data, tls_decrypt_sw() retries into
> a kernel skb, but leaves the iterator advanced.
> 
> The subsequent copy from the skb then writes decrypted bytes again at
> a later point in the caller iovecs while recvmsg() reports only the
> post-retry length. A TLS peer can trigger this after the receiver
> enables TLS_RX_EXPECT_NO_PAD.
> 
> [...]

Here is the summary with links:
  - tls: rx: restore msg_iter before TLS 1.3 optimistic retry
    https://git.kernel.org/netdev/net/c/1c8629651cb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


