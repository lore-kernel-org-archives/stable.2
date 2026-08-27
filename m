Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CFE41F5F9;
	Thu, 27 Aug 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823064; cv=none; b=movJdLNhBaqq6ApyEHLmjMxXGhQYfUol9bEfN6scwiWnHQtByF8ri1gmdJgMAhxkFtvqK2KFjWIW+AIynniTgUtT0/Hh1uzd5MhvnNiu6B0qMmzQ0z1Y6Hxi0YFFTy8sSDzs5ZfxGhBj/FED1gEE3VYs4WSQnxVPn1e3hxaqU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823064; c=relaxed/simple;
	bh=z9gOTOSGXQ/VZsPnM8CkrFQ8xs42Ca+3qxX/QOsoTrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r1Hadkl31pdz/bulk2e1qDsl8iixZptwz0/gPtHsS9uEAQE6YW4DmbNU5jWy1Cg2V2lA68neSpB6YiyEf4SgA6lD+37E+lO6QN47PLD9uAVwNrZOe7J6LUvsLBrp1q0/s6BRmsQNRw746xdHXj+m08d1KCR8WSaOZXPpzOm0sFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJjjtXZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJjjtXZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10061F000E9;
	Thu, 27 Aug 2026 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787823062;
	bh=3oiO3N2aT3fEYSxIM4HiiN9LFV/h5c7GV2ZTWhxZWPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IJjjtXZeJ9FYoV/3GpWD1XchP+0HCXX1D73SzvG/zX+m4Ab9T35nnzdYw2Z/yMzaU
	 jXcqCMhme4X/TlCiDXf+O0VkhPl/OmcwEjyTDwXUg5g+7Ai/SDdnGU0ycZ2lSMq7hm
	 emLGQiDExR2Kz+QxKAsMrU5t7uNA23O/+hLLfCkCv7y+hw7lI65mgZ/p5LMLkGfiH8
	 PZ98j7HuFBl5NeMyYgKEvFTTTI5L6khqanvW984GGU1dQ3VHQUXXDC7A+ZUGFvPYGa
	 aivx2pAmup8b+s6vdrqeArQLFrOPW6uaP5KJ9pwGv25+Gqi0D8Ck1IMDDDlYmhV9jL
	 UQyJ1xwhUqkFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC43809A18;
	Thu, 27 Aug 2026 09:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Write doorbell when linearizing skb fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178782300828.1128343.11581842807705981665.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 09:30:08 +0000
References: <20260826000234.2031564-1-joe@dama.to>
In-Reply-To: <20260826000234.2031564-1-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew.gospodarek@broadcom.com, somnath.kotur@broadcom.com, horms@kernel.org,
 kalesh-anakkur.purayil@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Aug 2026 17:02:33 -0700 you wrote:
> When the driver is handed a burst of packets, the doorbell is deferred
> until the end. If the last packet has a huge number of frags, but fails
> to linearize, the doorbell will not be written adding latency on TX for
> any packets in the ring and holding their DMA mappings until the next
> TX. Note that the queue is not stopped, so this issue would delay
> pending BDs until the next TX.
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Write doorbell when linearizing skb fails
    https://git.kernel.org/netdev/net/c/00eeab0c644a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


