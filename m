Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3A3FF1A9;
	Tue, 11 Aug 2026 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479075; cv=none; b=cWqGJnPy158KGq9ivO1asHnombOnqOcm2TSjuizKLIFreWBGiUPUx0zqTR3fqITZaDpEX81SccYtTKzbIVp9uT1LAG+bOYPGnJTk9jtpjrjmZ2y0P0FU1xEVXnBAxHRoIGFWKehdhwUtEGs7wUqQFKRLSSN/VJ850KCmqxoqmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479075; c=relaxed/simple;
	bh=FS8Ngr3ES28jvnkCU4exV5piid3LZrQOR1OWFHNs6dk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BqldTUkk3dfDbaA4FIRHDRGnF/msIIk3YxkqX8ssKCbpSGm+otvYYDiYo9AcIN7kydhYHrv9MDTYENu59JpMxbSzMnisXYVYDidevlU2cu9KgJlXK2sexHrgeKTIl9MpZgePNhvu78sLKoOxoIjh01cMD9OWjXKg2UFMZ+S2+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDaQfUrc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDaQfUrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257ED1F00A3A;
	Tue, 11 Aug 2026 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479070;
	bh=8GC+0QB27jd7rP7KrxRKKIz3HAKvo0l1RP26hKoHrD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jDaQfUrcUllk2dT64fZGtu4eejqEhdAhUgi2sxwfFbXJ8dZ4zcibVrgokQhHYgvz9
	 t5CwteCyiEPwLSij5Q0+wngOaKYvwZQ5O8N0hOYLX29JVg8kU/Bnuw4dvvgZ0roayX
	 2o4wj84U17+cygxlPkQ3rBCBSAlQnlyxWdekU8POxmje6tu3EcjbFHw5ihnutHkv3u
	 v48CII0/8QWWgyKmfLIsqd/pqBWvU83/xvDCXmEBED8EQxGvyCrb+zKctcNyOXSQXz
	 L/MJPQSSc3r5FrWArNdq/rx7KeFLQEZQxoHr9Tc92VwbRN0QTVWo02Hd2vqmL/dsnv
	 /0V3B+t9MUyQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5681F3809A0A;
	Tue, 11 Aug 2026 20:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_h5: fix usage_count leak when
 autosuspend_delay is negative
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647902588.1134064.14529193736524382598.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:25 +0000
References: <20260808052655.2562268-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808052655.2562268-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, apusaka@chromium.org,
 abhishekpandit@chromium.org, hildawu@realtek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  8 Aug 2026 13:26:54 +0800 you wrote:
> h5_btrtl_open() calls pm_runtime_use_autosuspend(), but
> h5_btrtl_close() does not call the matching
> pm_runtime_dont_use_autosuspend() when tearing down runtime PM.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during driver teardown, this reference is not dropped and usage_count
> remains unbalanced.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_h5: fix usage_count leak when autosuspend_delay is negative
    https://git.kernel.org/bluetooth/bluetooth-next/c/9e257e358642

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


