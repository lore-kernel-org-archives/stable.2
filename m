Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09A403AFD;
	Tue, 11 Aug 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479081; cv=none; b=HqouWJnWdN/nW9zxwWAog0UDjll/fbzLxorTimmOHCRhWbGibLOiQA5TsWKu92Pg6HxVnLPqF4CSIocCJ4mTviPyTXarFMuuuO1N+Z1UoislIRV4KUtJXp2QsQTE8y1WVZs5ePBb0+XLxqQ7FVeMPsVo4jESdoELzs67FP/aXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479081; c=relaxed/simple;
	bh=ia2i7DuhoXD8nEgx/AYMK9Pvi2BhbPBe0evVFut8Td8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qtPXATiYNkxh2k3wfL4gSodmvJKHtjS9hCmvQS1PaIqJBwVBaGu1r2QHY9kvhPG+KPI5df2TyfNHPu3fSGKuez5ojMzddwflu05ysdQfLH1A9qkI9WeIkQDJalZu6F4ypdWAc+eVvVh0JBxBcPWMBOkp6PS9kDDJpocVpkqkufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf4Of6Pn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf4Of6Pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E681F00A3D;
	Tue, 11 Aug 2026 20:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479073;
	bh=RT3qQkVztkNGxXbVF39Q+UWXmERDBnJs7WrbpxxlNH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sf4Of6Pn10sqZk5fNomPsxJgDiQNGTNQN/PPH30yG03o1SnxdVAHUBBuWd4979TS4
	 pTadiQXDyh60SA07tT77XCOCI/pPOlk1+t6MtLojzW0/mvIoYBnSEkZUSAMY9NR8XP
	 GcWB+XfLOZs7krP1oXhR3VHSNlA+E68MgYeAWdn/sTLpgBtDcbtZR9dZ+Li/08gVfV
	 cE9M5DxxrYgzj786em0bYq2fTNWh0/9h5RtTicvgyDjCrZSxGMPELbOC0ctox6E8EG
	 ZC26aLI28IfwFS8Z61mPlOACFnEKHZxhIHtCtKXQ+TAavub5LlzpqJE4swflTiDBOW
	 aRs2C40CB7TyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5687F3809A0A;
	Tue, 11 Aug 2026 20:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_intel: fix usage_count leak when
 autosuspend_delay is negative
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647902888.1134064.482617253125004598.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:28 +0000
References: <20260808053057.2566366-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808053057.2566366-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, loic.poulain@oss.qualcomm.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  8 Aug 2026 13:30:57 +0800 you wrote:
> intel_set_power() calls pm_runtime_use_autosuspend() when powering on
> the device, but the power-off path does not call the matching
> pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count remains
> unbalanced.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative
    https://git.kernel.org/bluetooth/bluetooth-next/c/bc2791e60e08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


