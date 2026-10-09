Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61D45D910;
	Fri,  9 Oct 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555621; cv=none; b=WyK/PTf0a4qTaARlZmE7kzEPpdXhYu6OblXlx2UUQ4jAovngzWCmAmEfW4lz/xo5xMKiKYiZ5+w+ccfCl8b52+XkWJUasZuafHJBEEGm7s6obbYDhxsquCPr2ISJ2erw1Oi+qQXUQQTKolPi2gnBEfbyi/fKNlCuHsgDI66ekTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555621; c=relaxed/simple;
	bh=4uKyMLDUljGUfYtJnxMQHcDq6AQOy7KGZLEP23PA3a4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VM7hDUwWrwc/lA86DDneQyH9K/QKE1/590Jv6xZzz46AQrxWBVb1zzHjOM5sJokIxZciB23IbAvHzhbhz7EDUADoz7VLHqJSqVA0X1X5SsxbztDKmAe6wccu53i85ja8mWG7ogPaejW4VEa2pVPLOh9byLbvRe6b30sxL7NtGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IesZmGlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IesZmGlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819391F0089C;
	Fri,  9 Oct 2026 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555610;
	bh=3FHf7rArdR+VTdbZleZtktKDs6UXtKrMfhlvCqIMY40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IesZmGlvUVLEW6184WdfKkweZ4wlCg34fxNM+cqrLrDz+YXp+WeYWzVzB0txXh/vQ
	 FACDdjn7BSDP7VcNJ49Z2UMXzCNZfxrgnqz8NQkAJ30YRVNhUHFctOjNaVYzWpFwPS
	 Kha53hu00gXOtOROmMCczYCZkBJqTekyZVJU52wnRVW8E5XwBfKVO/4BpDBfSr4Z9a
	 zZinaxjKLiuqTSCo4K9kMiaZJGmAGpEgWd9pV807ceMkzlj9XN7RnryObE2ESv8vX4
	 1bzg/riXkFq/VcGCGW7CZMOKvX/h/NHltlYVztNCwS06uGYMP7BYShCJnuyUyrcxsq
	 LM5Diqg+OffTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773FB39253CC;
	Fri,  9 Oct 2026 14:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_vhci: Pin module for debugfs file
 operations
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179155560901.812174.12507365136782263933.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 14:20:09 +0000
References: <20261008045413.465999-1-dungvn2345@gmail.com>
In-Reply-To: <20261008045413.465999-1-dungvn2345@gmail.com>
To: Bui Viet Dung <dungvn2345@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, ipravdin.official@gmail.com,
 pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 11:54:13 +0700 you wrote:
> An open debugfs file retains its file_operations pointer in the
> debugfs proxy state. However, force_suspend_fops, force_wakeup_fops,
> aosp_capable_fops, and force_devcoredump_fops have no .owner set to
> THIS_MODULE. As a result, full_proxy_open_regular() calls fops_get()
> which succeeds without taking a reference to the hci_vhci module.
> 
> When userspace opens any of these debugfs files and later closes
> the /dev/vhci file descriptor (triggering vhci_release() and
> debugfs file removal), the open debugfs file descriptor remains valid
> in userspace. Because the module refcount was not incremented,
> the hci_vhci module can be unloaded via delete_module (rmmod hci_vhci).
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_vhci: Pin module for debugfs file operations
    https://git.kernel.org/bluetooth/bluetooth-next/c/da8aab8ed08d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


