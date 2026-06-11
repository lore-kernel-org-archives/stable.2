Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF963803D9;
	Thu, 11 Jun 2026 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218822; cv=none; b=bGDky6bVkMI2SI7i+OBYerKUCQotklRLLI2SxvS7Rs6EYv+cWOVhKwHwVpO3VTs+0ASXiP3CE70k6NyWgY2VnXR9faXnjbyUkB5Wu8lvVuYRPqwB4UTV8xRtIK3zRbtV8K5wV+PJZtLCGaNeLgckUMV0Nr5XxYDodvxRo8PH2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218822; c=relaxed/simple;
	bh=wl0QIuKggj8Rvf3hNU5aOtP6Jx6G53FKrBCQYHZ2EDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UC7AZf74/QKVhi0iLLCOa/Khaj2pYqh9VF5L/uHGNQcS9DQJzg9NwkENXhrbmzVfWpkRF0YR1OnQWZtfoEfWVntnY0ru/6NGBFBvCLeaWzZLyMbOqQFqVlS2w1rcYEtwx66dAH7jzPDcl0dzdQek4xUTT5X7zGnqMN+aHP1xZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkqEHVmw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkqEHVmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1481F000E9;
	Thu, 11 Jun 2026 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218821;
	bh=wtGa6+1BtelsAGDuuKGrfoq5Ahdw17vFw8gqBmiODD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nkqEHVmwtibwZ1xAJNvjkWlVbjT/NvmsodglpYkPiZoki6ZR+zKJz0wwch92Lo/w0
	 VrKQJVlFWWmXw49nHWcs9Fa8dfHFrWq+cT+eEXB+LejirTyC7s+g+nZRPH9i9a8EXP
	 7kvGmJMLM0s8TunUpkJIAG4BIUu2vH2+4KUbts3yl4/k4MGmrg32o33EIDH7GS9kvA
	 /BRKVoivPrGiE7ubjKquW+QrH6CbK+gopmNJR7kvRlGDWjMmYx9MVEFIQPlnvHEtKR
	 l5/6315J13qrw7gReuTMOWpvPtOontrMH1QdHjf88Rb3t+yL2vh8/5QOVRNMyQYZ9t
	 5+gnqTKlx27tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9383B3930FB3;
	Thu, 11 Jun 2026 23:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121881813.398116.915603452601810782.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:00:18 +0000
References: <20260609083709.209743-1-vulab@iscas.ac.cn>
In-Reply-To: <20260609083709.209743-1-vulab@iscas.ac.cn>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 08:37:09 +0000 you wrote:
> When mlxsw_sp_port_lag_index_get() fails, mlxsw_sp_port_lag_join()
> returns an error without releasing the lag reference obtained by
> the earlier mlxsw_sp_lag_get().  All other error paths in the
> function jump to the cleanup label that ends with
> mlxsw_sp_lag_put(), so this is a single missed release.
> 
> Fix the leak by replacing the bare 'return err' with a goto to the
> existing error cleanup label, which will drop the reference safely.
> 
> [...]

Here is the summary with links:
  - mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
    https://git.kernel.org/netdev/net-next/c/41c8c1d65b32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


