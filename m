Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369F3BB11A;
	Tue, 11 Aug 2026 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479057; cv=none; b=AR74X13vY6iIQ87NI8PdnrsE53JUpdNJCtcXctZ+x7uaucNdbeO2d4eGBmkrZbk7DYcgzWPm1KGutDU5n0I7F7uuqevHeJr2Bnn3M+O+aH6SLYSwC1ENDxLL0yams0WIcKe0A9OHoKqSqC7alMJ+AC0IWBzMazx4MRoRMQEt+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479057; c=relaxed/simple;
	bh=CIso/86JLfrEPwILUe13FopFr/2qlvGV5Z54YAmf+pk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BumpaYteOo2dTod2vX5Je+XhZqfdjnvLvKL0ste+RMI3M0wIT6eDt8yWmOFlewlP4ybRQXszHQE0Hyg/ELY+1u4anbPwn9DcA+WuTLAy+thMxJe1FpTQ0NHO1LzuBcLHSGI/E9lh6EiVU0uI6m/2ZOHRaKaXwShCSmddYUWLLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLygJqAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLygJqAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164DE1F000E9;
	Tue, 11 Aug 2026 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479056;
	bh=pPQFH9sSlBsoBtSiFBm+IlkSlH9WRsC3JjKwa7xNBbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XLygJqAkPJKaJEBwn2Ij3bPL4xYvIsuCs9aJynHunIXXtE4EDAAReENDwnFrpi0AY
	 mDa93CF1NUx5E93WV3DMVG4LO6cRxx0GKrFcAUlr1phbQ2FSwYSwO/HF38huFIAM+K
	 4zOkyIUXC+CcxCo8YNJ9g9N40slXWPO1bycfW7bkQ5CmWlO2JVWEgYrWt1VcIe53/s
	 jbWKxczdjpmIfCOUtdd3/4V1ROaqbldyIQowmoeSsscW5Nj2AWeJisCLJ1VQTttlvT
	 nNf9eKwa5TuL91KD+jgtexkBa7FrtpI8ah8npM52YNXqoiWhB6ox3TpvgAnnWm41sZ
	 ZwSjhhKLLhQdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4578C3809A0A;
	Tue, 11 Aug 2026 20:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_bcm: fix usage_count leak when
 autosuspend_delay is negative
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647901188.1134064.781270046343002067.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:11 +0000
References: <20260808051532.2553947-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808051532.2553947-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, frederic.danis@linux.intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  8 Aug 2026 13:15:32 +0800 you wrote:
> bcm_request_irq() calls pm_runtime_use_autosuspend(), but bcm_close()
> does not call the matching pm_runtime_dont_use_autosuspend() when
> tearing down runtime PM.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during driver teardown, this reference is not dropped and usage_count
> remains unbalanced.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
    https://git.kernel.org/bluetooth/bluetooth-next/c/32b42c0704fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


