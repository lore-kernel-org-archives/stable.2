Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1540DB42;
	Thu, 27 Aug 2026 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827864; cv=none; b=WjAy6QLn+dRZSLKksY4WLs5pa/uSah3rcMGxzsNTfyys94lJ0IOWbn1RdRGSW6CNxkwZxzICpuvMb5Jd49XYxU1x0Dkip8iQE5VffASk70RljKdLM0Ad/xtwM+XHLZ09wCzZYOXSNCnoSWSri6r70rlg0TUkbrKH4eozRC0hQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827864; c=relaxed/simple;
	bh=TwFShiIpAHR2BE36dP58qYN0KG5LfgyIQX9eXQkzsi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YW9RjVa1pr5GeHW4HOQVVup83ATsrGkoTVcIHacToIGBGLyCC6j9NUAJv8x7sf3Bo5pik2Nu6W/fc1HRpptrrpQSf4puPT3u6Alf/7A/xyu34JYfEAwOcYULX90+xs99/Q/O3Xtuc03owD6B4NZJYmgm+eBRDTzboQU7tHu2iNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeLl8ReN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeLl8ReN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A111F000E9;
	Thu, 27 Aug 2026 10:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787827863;
	bh=LRQ/tYb3r8887oPPrEHjtLg41BYUQ/dsQx+cIOUaWLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OeLl8ReNb073wT8lQWMsZ9tX8ixeWpH0hxithw0krRsmH6Jv94fBQKTPtSN4k5QFX
	 VENvlv8Y3wUKUzzjBnZfMVmJU4ZxMgmrB4CUnOHwsF0cVs9jN/nvgJHfiCu4lzKoJE
	 S4Tx6L+oKClAAUquVeyAavr9NpncIYAbHjaWk7lHicnC8UCIZftZf0cZUwxPNf9L6z
	 zV/sZO2SOGgMrwgNj04ljioSL32Vdt1sFYyi58IG7QmSLShV3+q3sIjs+RjaUyFqKn
	 /D/PxQmIDIuW6LZA8j3Kw4Tdp6ps2YmiO81fXb6f7PwVzcCCNUpMkDCVMWjFGLEJ7M
	 YMf6tvhXIWqqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09B23809A19;
	Thu, 27 Aug 2026 10:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] slip: fix use-after-free in sl_sync()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178782780840.1160948.18084154764950747859.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 10:50:08 +0000
References: <20260824100547.164773-1-haa@amicon.ru>
In-Reply-To: <20260824100547.164773-1-haa@amicon.ru>
To: Aleksandr Khromov <haa@amicon.ru>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 lvc-project@linuxtesting.org, rrv@amicon.ru

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 24 Aug 2026 13:05:47 +0300 you wrote:
> slip_devs[] stores bare net_device pointers and takes no reference on
> them.  sl_sync() and sl_alloc() walk that table from slip_open() under
> rtnl_lock(), while an entry is dropped by sl_free_netdev(), which
> sl_setup() installs as dev->priv_destructor.
> 
> priv_destructor is called from netdev_run_todo(), which deliberately
> runs with the RTNL semaphore released so that it can sleep while waiting
> for the device refcount to drop:
> 
> [...]

Here is the summary with links:
  - [net,v2] slip: fix use-after-free in sl_sync()
    https://git.kernel.org/netdev/net/c/2c4e7c42d77e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


