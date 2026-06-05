Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0726F2AF;
	Fri,  5 Jun 2026 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624210; cv=none; b=idTmdDb4MfJZArh7AeL7iQC3zJgfT1h5V6ZEeq75KY6UdiWhIAHvwWBjY4ek36NuUZMpSyC06MxKfQ3Hfn1hWPA4I4UrdGh1LiJusFfeNpTn9an6XQbEasivMeQeTnDeIAhYMsED0Y3A+EHzJO6axLR4tmgKjDIR3ZpJbYPEOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624210; c=relaxed/simple;
	bh=E8tq9JTmqzIzMUhNsp8AWo7/7jpeHjhzbUMGM3VZHlg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q6QrJTOnk3iQk7gwaFG0pfMlRrAylJPMB8yV3nBSkJ6YL0QpBEXl9ZE/Cv6t2Y1yO6XMOqCNWBWy33x/0RNtvLbphNC8YlzFGFFygE1Bzmlz++okKCEyEIdJzKd6dKMqpMq9+fAgktl9J9MQrofaGDOL6XR7+vtKxSy1Xro6CmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTaCdzGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTaCdzGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B731F00893;
	Fri,  5 Jun 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624205;
	bh=yRWRGczbHTPTKvulLxgT7hEEz9Y303qfmiWdzHhb25w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jTaCdzGm/lJ/FzHw8GxhC4ZjwsHSf+c3BO3rINyIO5XHMYflEMvD2eMllE6H2uiBz
	 7kZTGO8PyphuUztbo+y0A7k5RbRD8bErJPr5yycRfUC5bKnB1gtu9OaWYCUr0gwiFD
	 8AxCCy0Uvurpz8NN2vRYTDY6ht6G95VCJTNIIa/+JWQf3Wy89AXb6kyB2Fr/3GVG7E
	 0LHkCXWPJP0zv58EhLSeEIwVauckcW54s3YnPyhna1HwbkyoJgcqCB2aQ2yLEQUHWd
	 tfJ36v11UdWr0U+7J7aqS8k+qyBQb/asPtIaWWXC4lveZZEeBcbeb1tIhZYKa4jViv
	 NsKnWTjijlpcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 639CB3930A8B;
	Fri,  5 Jun 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] net: mv643xx: fix OF node refcount
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062420611.3099818.5746082184387994358.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:50:06 +0000
References: <20260602073414.22500-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260602073414.22500-1-bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: sebastian.hesselbarth@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 09:34:14 +0200 you wrote:
> Platform devices created with platform_device_alloc() call
> platform_device_release() when the last reference to the device's
> kobject is dropped. This function calls of_node_put() unconditionally.
> This works fine for devices created with platform_device_register_full()
> but users of the split approach (platform_device_alloc() +
> platform_device_add()) must bump the reference of the of_node they
> assign manually. Add the missing call to of_node_get().
> 
> [...]

Here is the summary with links:
  - [RESEND,net] net: mv643xx: fix OF node refcount
    https://git.kernel.org/netdev/net/c/4aacf509e537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


