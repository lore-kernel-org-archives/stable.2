Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0D4E324F;
	Fri,  9 Oct 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555612; cv=none; b=hWT2gY2LjD93ycyB3cn8mUBf8i5PICDtYt/EN88b6V2mYMWYi+3JyLv7A0foa0hZgHHljuZ0Ozg+qvilroOoWv/nOXXfT+VnNMOhu3ODkOs4FkPKUVTjc8jUPY9kHFp9u6SnAvLjfedEaLJtYbfC+AJHnBuV+Iwf4NiiC4wsCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555612; c=relaxed/simple;
	bh=FsOoSK9larQ1a8GxYHh826DxEKgeRxZCwAWMdUqFvoc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Iaj/2NPOk+IiSeEQYb6mh+CvQAVjQRYKGzBnum/1Y5iQLuDzEwBT6QiYdnOaSrFx/ZLETZd61pWcOAA7Q+YQbAsx+QYtUHTs+KJzd1R63NSm1WH7Rgma+v0bXlDYnIgC/TjhzfayhbweorMlgkEnHGkeHLmGmspDe0HOiJL0hHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuW81jiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuW81jiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832851F00898;
	Fri,  9 Oct 2026 14:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555607;
	bh=0dU+CeDLS2/syMkumwBLuxcJ7FiQJnpdbMZTMAnDj6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GuW81jiSAOsw/I6oosp/8JM6s1PsIKfyCZRaYstsv/plYJyTXMlQHTynOiE5wVz9u
	 tYpT8m9wBMOmvr1du4jg4hkvxfp4cpVHiYRah9xNv8Y3Qf99MisFxmiJt9X8aWy+cG
	 CghgfNEldSD/yd3rgv0056DzisEwYGK5AdQ8RYK3gnR95ZEwm+bzdufPIX16sEgnSd
	 CyVBtIuDAL0zrB2x2SFsxw/izCdjUn4lA/IKMWd3WbX2Mc1QzONWDMn80KfDdsqVmn
	 EwvU2T5ELyHZ/o7r0KWMNypfiUgoETcBWxIOXXYopAcUGaW+pqHja07jsOqscthXXr
	 vWLM/mdw2KLeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773C039253CC;
	Fri,  9 Oct 2026 14:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: 6lowpan: Pin module for 6lowpan_control
 debugfs
 file
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179155560628.812174.5344547417953773024.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 14:20:06 +0000
References: <20261008051129.508322-1-dungvn2345@gmail.com>
In-Reply-To: <20261008051129.508322-1-dungvn2345@gmail.com>
To: Bui Viet Dung <dungvn2345@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 12:11:29 +0700 you wrote:
> An open debugfs file retains lowpan_control_fops in the debugfs proxy
> state. However, lowpan_control_fops has no .owner set to THIS_MODULE.
> As a result, full_proxy_open_regular() calls fops_get() which succeeds
> without taking a reference to the bluetooth_6lowpan module.
> 
> With CONFIG_BT_6LOWPAN=m, a userspace process can keep the debugfs file
> descriptor for 6lowpan_control open across module unload
> (delete_module / rmmod bluetooth_6lowpan). When the process subsequently
> closes the file descriptor, full_proxy_release() accesses the already
> freed and unmapped lowpan_control_fops table, causing a kernel page fault
> or oops.
> 
> [...]

Here is the summary with links:
  - Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
    https://git.kernel.org/bluetooth/bluetooth-next/c/b019e48cee2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


