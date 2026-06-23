Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A313D539;
	Tue, 23 Jun 2026 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179420; cv=none; b=qbWs/lh3g7WfoEIuwfbyGbG4BnaPCFcwjgHnA9OB7nWD/yyLLj+uUIOtIfGsVifUGswd98vSz9GwM6WGyJleyGVV1BeDiXfb51qmJOTdER6V21RcOi/xBm+qUN8ypEj48SqVptEsIPv986YY995kdfYJ7mX9UrGDewM77SPsAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179420; c=relaxed/simple;
	bh=JjpwHPkCa/5YR/LYb4oj0fFkOQyjck/WIQHTr4q/+nw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RUIl2BYJ39ngr8Rtr+SM4bH8SQL2aFgYt/BZ1KPcTPD/p5IKDhProq9CnCSE/mzPmkq7joYfNFbfAGPtNsM+0ZGFlp/V3YVFxRuR/IK6X8LtdyHRLTUb4gRqHkid6ih/JjzXwVtje/t9JSJA8yWjdHH50aDMONluCeYLXYAehKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joT0FP/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joT0FP/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8DA1F000E9;
	Tue, 23 Jun 2026 01:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179419;
	bh=L9o/ER0NHmE8whekACehxCdnV4FSKSbxVtU3EkoF0UY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=joT0FP/CFjXfnGz2Qs4+AYUNX8mGwAMl2dLO+JrS5Z+yk9CZJfK3yLDqUhOR9NtF5
	 YUiqW5D59z+Ze4EPrTUSuz2ehiX7GW1Vr/69brlcc9JTqRVd33pB5ZwABsjE+NmncG
	 S/nIDmFI2gJQouCsEI6YcrUFNGwznSsjADhpmiU53/qwlEEYPW+b52PLFge+jHteXc
	 DQtV+airJ5sTzNJN5RGdUTSXvH9LCFGDy0oNTm87emJFXPntTgcmusoJWNsQyNEPZh
	 xUnF6v4u/llt0Udmrp3moGgyDV5Iufsb5MvWqMY64Ylz4rwrI/snhyLgri2S9EO32b
	 inKL6BlXYi3PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2F3930A08;
	Tue, 23 Jun 2026 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnx2x: fix potential memory leak in
 bnx2x_alloc_mem_bp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217940930.1502813.18321326300451371106.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 01:50:09 +0000
References: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, barak@broadcom.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 11:53:50 +0530 you wrote:
> If the allocation of fp[i].tpa_info fails, the error path will not free
> the struct bnx2x_fastpath allocated earlier, as it is not linked to the
> bp structure yet. Fix that by linking it immediately after allocation.
> 
> Cc: stable@vger.kernel.org
> Fixes: 15192a8cf8a8 ("bnx2x: Split the FP structure")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> 
> [...]

Here is the summary with links:
  - [net] bnx2x: fix potential memory leak in bnx2x_alloc_mem_bp()
    https://git.kernel.org/netdev/net/c/a986fde914d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


