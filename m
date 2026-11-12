Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509412;
	b=X75FJuRnzj2y+fKd83Uwcp92Sd8GGJ2sap14xqtzPVJfD6rW3BXArC+HZlSNUYjxiv7C
	 8njzOUKa6UiQWvbVyl5FUtz7ckaZ3L//BnoyOEtTXaCLvbWOTdoc2Zs91QR3pwcowQCV8
	 8Mztvw6FBKG2bg/4I5GkGY0Y2Ju+cqT1247en8z2UsLJvYB86dIXzvJBED2RSQp4Gs+bT
	 9Cfr/y0cdocMJkLvaic3u8K6XHr1yosRedbgaX7x4Kw01Bf6Qfg5Gt6jCS45LGeziaFEW
	 BUk1jqe9zvifaqLqJ5V96Aa9/au95T2VYdQu4xC2lbe8j3wxl1i0i3/vtGuKGhy7tvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=h3XMbSIx3RGmcIByP1HsmQLLJ3ABgYmEHYdROaunBeI=;
	b=guCpmLj6Sa0Vn/VJwg539R/enVz7Z+b68WWw0r5xsTJQEkui0RQe6ogOFBzAqQNWHDC5
	 v0GAq2sZb21hvli2pw+J2IsS7IVFVb5xzl8zkj3b/to3oEzYCfUHevYSMqGaC9F9i/qmM
	 rXR9V12ODmW98vJOeP/e+n7WuYOq7DlAo96Dm1/iMADZA4QhSjEyF4X0P+awpGFgjwj8/
	 IuTcrJjDmbSknH2mmaEpKGevv76+YzFSDl8MAys3F9Shwf6pyh217zRzCNIyLD76GUJ4u
	 K6bv2V2LrbbbH3dps1Jfsl055KZSxjfVbkv5uRZHjsZ1mb9vG2naz/+rhWyWQ/nojQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi7ji3Qn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F41606A893;
	Thu, 12 Nov 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi7ji3Qn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05F01F000C6;
	Thu, 12 Nov 2026 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509411;
	bh=h3XMbSIx3RGmcIByP1HsmQLLJ3ABgYmEHYdROaunBeI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Oi7ji3Qn3XaqdT1iigQpPJmvDv+g+M/AL9qC2Fp/u4Agp9s5V7cF0qkRl3CDcWls7
	 HSTFvBDDiiVncNg8nCq2xzwibt1VkHJA3B8i/OcExyqwsN1jlOPdxlrLRGD9NLxsa9
	 OuJZ8BYV4kL2RJd+v5cJBt9Ktn5KuNRqaQHJ5YeUq0Ol60nFCk8d4tQHSAlhDrbAwf
	 CBLGdzg9bPYHwE/c6wSovEXL2tkGx3b0JQNvcKeyM7BDHUQrNJajEyWUA0z5jmMh9c
	 bs27bx1QMruchZA7q8DH3ggzPsIfvGAzcK+j49BJeZNLM2G8wvOsCGiyrPOHgoR3I8
	 iiuIyBCHZnOcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4425391AF9C;
	Thu, 12 Nov 2026 18:50:11 +0000 (UTC)
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
Subject: Re: [PATCH net] net: netns: fix INT_MAX nsid cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450941027.590019.10618104051930565627.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:50:10 +0000
References: <20261111033525.65828-1-zhaogongyi@bytedance.com>
In-Reply-To: <20261111033525.65828-1-zhaogongyi@bytedance.com>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 realwujing@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 11:35:25 +0800 you wrote:
> A syzkaller reproducer assigning INT_MAX as a peer nsid triggers an
> idr_get_next() warning during netns cleanup. With panic_on_warn, this
> panics the kernel.
> 
> alloc_netid() also overflows reqid + 1 for this nsid. Use
> idr_alloc_u32() for requested IDs and idr_get_next_ul() for cleanup so
> the cursor can advance past INT_MAX.
> 
> [...]

Here is the summary with links:
  - [net] net: netns: fix INT_MAX nsid cleanup
    https://git.kernel.org/netdev/net/c/dd6f1e7582f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


