Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775253B6370;
	Tue, 29 Sep 2026 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725810; cv=none; b=p8uIhD1xAQN4kg6QPk3C81X4ju2gwieYOnhe1a+djDcSH9rHW+RCt58SydLtOlZXeKkYTzLOxkTkM9u9wgomLkTrfmpo7Epn/bE7TqTLJwtymFYltqb8ONgbYCfeWuIKX/y/woSxYz+X8I9PrKgCmGkEWVl2YdUUyCJiE3KMwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725810; c=relaxed/simple;
	bh=8w2HKW1hOCY/1LMK3e6/ZsRot11crplpjWA+dW+c0cM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UEOd5khoysm27m7A7W9m5A/zHNMjkPhhLnKuLAHvxlxF16ykj3cWkZgNWHatWIqeBRg0MTgU/W/cAWrA/8DNHDgbt9aqc74gOcOoeRfNZcOgqPP6ccaS08gg6ja+vR3MGTLJLWdbwVriZBQnx27+RM2jxY6TEwSRu9lA+f+eLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPIqWhSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPIqWhSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C411F000FF;
	Tue, 29 Sep 2026 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790725809;
	bh=xxUwmjfHxdPkhVzSMNKGk/NalI7DwH719XPdmccjABc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CPIqWhSGp0SiwyZQ2eEI3dQJgc5ebYaBrht90l5fxZ+UTQzXUJEeqL1DCrnkiIwGZ
	 XWdqJcsZKqfploqJ1K3eZ5honEenojtiqtxhW8mnQzuxYxxwi646alzkegw9L4e/pB
	 8ceVnMg5U2im3S3AL/8F5dT08QvQu8cMSkmnzCl4qn8165AcsL1FoR1PAX/c04lnzb
	 GawtANFuCsjHLVqO9caH/TSZVT8UkfFW0rRPItCWjoYPxbqfDbIEA1WGC8Dk7PopL/
	 YAyzzE9/lOTrQMitJKC8qq+5T7fNCafbMyN5jE4w+OBxJxMES265KF13+ySz3FJYfe
	 M4ONOyKZhe0DA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15FC39D5FDD;
	Tue, 29 Sep 2026 23:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] usb: atm: use request_firmware_direct() for firmware
 probing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179072580753.1169866.12044189359267660382.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 23:50:07 +0000
References: <20260924050654.15347-1-valigurasm@gmail.com>
In-Reply-To: <20260924050654.15347-1-valigurasm@gmail.com>
To: Matvey Valigura <valigurasm@gmail.com>
Cc: gregkh@linuxfoundation.org, 3chas3@gmail.com, duncan.sands@free.fr,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 syzbot+9ca2c9f85bd8b5e46516@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 08:06:54 +0300 you wrote:
> When disconnecting a device while firmware is not present on the system,
> usbatm_usb_disconnect() waits for the heavy_init thread to finish:
>     wait_for_completion(&instance->thread_exited);
> 
> If CONFIG_FW_LOADER_USER_HELPER_FALLBACK is enabled, missing firmware
> causes request_firmware() to fall back to sysfs/udevd. This creates a
> circular dependency during disconnect:
> 1. usb_disconnect() holds device_lock(&udev->dev).
> 2. usbatm_usb_disconnect() waits for instance->thread to exit.
> 3. instance->thread waits for request_firmware() sysfs fallback.
> 4. udevd receives the firmware uevent and attempts to read sysfs
>    attributes (e.g. serial), blocking on device_lock(&udev->dev).
> 
> [...]

Here is the summary with links:
  - usb: atm: use request_firmware_direct() for firmware probing
    https://git.kernel.org/netdev/net-next/c/f10883b37d9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


