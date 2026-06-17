Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768632FA2B;
	Wed, 17 Jun 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716597; cv=none; b=n0zxlftSrur2OK2IL2J2A/kPpxpI/5Eg0eLV4Hf9bRwfbGQQwVRWkIaRjkv8/CpxU30kTmeDSOfNwWRwc6TnYTZ3zrflj5lCqOYOGeMu9TUN44o1lUMfJRq+ivsa4wu56XfOCZcEPRXXbpru3fD6XxzTZBTvdUP1HaZEqMmtN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716597; c=relaxed/simple;
	bh=2tu9Ndzm7e7ymDfPxW7a6jiGBH/GxO+26oHdgDtE/UM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dPLEyASFlCgBkMNDqv+aQmlaytoau7Jw3FKF2GHR/bU4DbE9uGzSuqX3YEGv2u7SXeXyzqT9x9pBDDAKzj4AB0DC2q4V4MRd/Sj0TQmaRXdkvUFAPQlfZjbVfvH1bi4Wh3KpH9Jwgk/4vPoO2q8x7hkSg1wHMAQUwCoETt4zfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEPyKk3E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEPyKk3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAFF1F00A3D;
	Wed, 17 Jun 2026 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716594;
	bh=E44XtN03WqA3ejVy8uRHfadaoVzphs4tobBkxTahb9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FEPyKk3EDKwnTQyUWm09S4Fo/rpxddZ0sPq5su4KpGy+CJmgfB29mBPukGRgeYPqE
	 eet+slDdwlrD3UKYdNss1+CA71wlB0dP9E5roBpR5HFa3jY+9SIl9R0knqKABEOgF1
	 +D7sPdZnNZxH7vRG2JWJRtA6IXnWmDzgmbDYHdFZNPWpdevwV5umxusJgAU0/WkbTG
	 owgPUNpGEdsyKQ7CWEIxoJzFcC0dq3vX+IOvmoeRqBCO7A4LlhXrNWH2IOQrxHdzdn
	 JWcUL6UM3bKBFNmPxdn+u11rouhNPxLfNA0/wZaJV18KYqBxL/ad6RC3JooJY/K8QO
	 6BEWCc3F0Izog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AC33930F8E;
	Wed, 17 Jun 2026 17:16:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: fix memory leak in
 rvu_setup_hw_resources()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178171658788.1670911.17461690846628878234.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jun 2026 17:16:27 +0000
References: <20260617013416.113860-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260617013416.113860-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 zilin@seu.edu.cn, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Jun 2026 09:34:16 +0800 you wrote:
> If rvu_npc_exact_init() fails in rvu_setup_hw_resources(), the function
> returns directly instead of jumping to the error handling path. This
> causes a resource leak for the previously initialized CGX, NPC, fwdata,
> and MSI-X states.
> 
> Fix this by replacing the direct return with goto cgx_err to ensure
> proper cleanup.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix memory leak in rvu_setup_hw_resources()
    https://git.kernel.org/bpf/bpf-next/c/09a5bf856aa7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


