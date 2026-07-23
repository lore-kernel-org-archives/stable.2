Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0347127E;
	Thu, 23 Jul 2026 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815875; cv=none; b=gD5it4voECSOFIiNIXNkQYpKvvSQIdy4v2Wi1dfbJu6PTXBqju+UCCMRxbWyOb44Zwo+cngwQmMx4Yd3bLbxdVTvGq1lza8HNfvsCIcZ3YH7GVaJl/1IbkISOLmRAshX31cEkZMr77g19INU7F7JCIS0VZtlbji0SgGu6naLUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815875; c=relaxed/simple;
	bh=p6WkchOCYzOVY6zEwRdkb+zFs9CR4kcU0gjhWQkCgmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R0BCUOl2I2rt1AeyTyjUmmQgl08L+F0tXK76R+5DDVYVorNcDAkEDEZe6uyMDBEdietAew5mZ5TLOLHKCCIm+zrgAsI5/vTy+ZAXGBoBNbDOn5r7G8HGLgVbGN7Jqw3Mj5UctGu+Kvlk4/Pvxydr1J9kiceBdIWwWG89LKftjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPlILeGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPlILeGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7618E1F00ACA;
	Thu, 23 Jul 2026 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815858;
	bh=DCvPzEsh4nrnPR+hEEpFS72uJ0+9vc6qXxMHhO29ScA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nPlILeGM1WL+9LzqlyP1GrPpxh82lQb7dkRG315XeLYnEd26oqGAWT5FQ3Ta1xhh9
	 fuRvKYf/roIknIPIWbrWU8/icl1gqCEgY+HFSaW8J1YX0XpmMGV+VKbjwrODQP7fVO
	 q6YMmIN6HUc1yfwYlf9BDu3i5M/H2e70SdDkWK/cdVLiCIokaG1EuUl0OZPYCX9WiU
	 wzs+TLv19pEEN9LssCYQ17WNxCNvxrDmY9pkBzkp++l9U7FBLNrNU3aiHbnuGX3MWp
	 wsUvGS7KD2EWwZdaQJnrBkIhJQmWLBYK9/9WEtJfNDQ8fHnKGQcRLdUoJ/B/RBOrxU
	 oGPOYLRld0lHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AFE380CFD4;
	Thu, 23 Jul 2026 14:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH REPOST net] amt: fix use-after-free in AMT delayed works
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481582639.2248593.459357737908941152.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 14:10:26 +0000
References: <20260722113919.7723-1-shlomojune6@gmail.com>
In-Reply-To: <20260722113919.7723-1-shlomojune6@gmail.com>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, ap420073@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 19:39:19 +0800 you wrote:
> When an AMT device is removed, pending delayed works can still access
> the freed amt_dev structure, which may result in kernel crashes or
> memory corruption.
> 
> amt_dev_stop() cancels req_wq and discovery_wq with
> cancel_delayed_work_sync(), but these works can be scheduled again
> from event_wq after the cancellation. This allows delayed works to
> access the freed amt_dev structure after the netdev has been released.
> 
> [...]

Here is the summary with links:
  - [REPOST,net] amt: fix use-after-free in AMT delayed works
    https://git.kernel.org/netdev/net/c/ea20c44935d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


