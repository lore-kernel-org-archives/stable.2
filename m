Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A715158A8;
	Thu, 15 Oct 2026 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060827; cv=none; b=eV8YrA7O98Pa5ZxIRwQyhgUmKBE+Nnl1nKwkGFlYk7KrjLykX1nnnRLS7cMxWwJ1d702y9GmGa/DygL2n3Zey9Pk6+hVnydE+2otOdFC+3CVWA+2bD5qSDmtvzTkjom02FTXhlEp+LGR9zmFoG9tBSz1F3Fiios1gEyhJw3fzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060827; c=relaxed/simple;
	bh=enB60hlE4h/ZjQI+sb6pI/zh7W1GTcOFQR40B5mb3UQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UXbslH8AKLsk/TFbnjeu60b9w9CuzAXYAeRn/EeR4PAvJSo1/aSWXew7JGr7GT0x0q+ZxUMKzslZilqzZlOkjY7KIDQ513uNt/DAQJUcP5XfdKXvl3l30UGQZ7k4tX9SmI4gguX/3katptB7KJ2fgbpwfbrB1jLW/ZW+0qMLo0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgU/Tl3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgU/Tl3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496021F000C6;
	Thu, 15 Oct 2026 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060826;
	bh=KbbkmuxduT7XfcUWCC2aKsI7Khe57nLKdZ8AH8YUSVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RgU/Tl3wgMe1HOLAuHJfw92bIhh6ygNByt8tACPfJEujJ9ZHytsFKtlnuFBWd3MYG
	 q1OFdgyIDgepVtQ2L/ni2914azSAKRrr3XSZGzrL4cVjSgal88VgiNQvKy9RP6XMD/
	 1ptAKoVXq0XtQRx6faNF7r9Cpoz85la72vzn5dOI37R6HdbcJA3K6Z9IyAHHmZsaHl
	 +ZuF9Zqeo2PFQfqIS7wo02Gq68DjaVDbS0I1J6WCxYoZYbzyx5oJ5pGH0QNZECbwP+
	 Idohp87NAb9IXSXLiR1Y1u3HrRGmhZmPBy93v1u3mRaeWaH6wZ+CZzqRbKiVJTuTEc
	 BHUUx0+FZwhoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A23D392EA58;
	Thu, 15 Oct 2026 10:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wwan: wwan_hwsim: Pin module for debugfs file operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179206082476.3345829.11602787441325035331.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 10:40:24 +0000
References: <20261008130753.313875-1-dungvn2345@gmail.com>
In-Reply-To: <20261008130753.313875-1-dungvn2345@gmail.com>
To: Bui Viet Dung <dungvn2345@gmail.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Oct 2026 20:07:53 +0700 you wrote:
> An open debugfs file retains its file_operations pointer in the
> debugfs proxy state. However, wwan_hwsim_debugfs_portdestroy_fops,
> wwan_hwsim_debugfs_portcreate_fops, wwan_hwsim_debugfs_devdestroy_fops,
> and wwan_hwsim_debugfs_devcreate_fops in wwan_hwsim.c have no
> .owner set to THIS_MODULE.
> 
> As a result, full_proxy_open_regular() calls fops_get() which succeeds
> without taking a reference to the wwan_hwsim module. When a userspace
> process opens any of these debugfs files, a subsequent module unload
> (rmmod wwan_hwsim) can succeed while the file descriptor remains open.
> 
> [...]

Here is the summary with links:
  - wwan: wwan_hwsim: Pin module for debugfs file operations
    https://git.kernel.org/netdev/net-next/c/a388f17e23b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


