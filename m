Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03930E85D;
	Wed,  5 Aug 2026 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892857; cv=none; b=qdywKrtSQ1zvci3SldisTWU7N0YXIDqKShSvJUKCCssiwciRTc/tKml5wQWRuN/0LAtKjTJ1jCvpxVcc3jeOMF5NVdePBxNLg6l1ZQ/waY7TX4IgnRg8ztZjn9X30k7BPdGZ/s9VH61nExSWtTHh83ubKx6bKYabrwuCDV6Z2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892857; c=relaxed/simple;
	bh=Buc3p+ZfXIfKqnWSF5TLAeRncLxLyhIj/Edh59KJz5I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LSYt1HMBhqEguwnj/4ydtI4o4wMV2shfZxVrpPTmtKmdsLheVh9xlBmDa74JxD392P17YGxLOTq79oB/76Q4U6mVfPyGEbPYfIbXyiFLfD7G5j7mCHxQTBj7CDGQCgm6OdLXwdkfzSNB9TmXP3Z/JFCdvCYlK9OGoejfPItC2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHwAmVDV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHwAmVDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2C51F00A3A;
	Wed,  5 Aug 2026 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892855;
	bh=bhHkfcy5PeuLYsQIz5g/xi5J0W5jFB9SOzSmJubyPJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HHwAmVDVV74f2gxSBgTn9OkhdyU+g9kbTM4yrJYqSnqHraU1i6AamdjNSuMpRaNr9
	 siLZofzpotkWUsDrNHl9JOIkxc8AEKiaHh98lCD/2ioMGCWIN4Af5sXRyRLuDneGhq
	 KpPxUtTBl3e0MIrOgxr1jIZJB3RJveiUAbKbsyfRIH+M+Ns0wjLdPJh4H5CCJxug/K
	 Yl4x2AodCIEZcLYXsHHBcpbtiOoxDwPJghBubDVPDhYwCRAzxM4AyZF2Qo+9ceJg89
	 h583m3PCgK/J/1ynpIJuCTv+niQ2tKC9A71yVPJcnP2TF1jiR02lhT3+Rui5oPrfUv
	 MAd1ABEl3tvbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568EB3926666;
	Wed,  5 Aug 2026 01:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] usbnet: cap max_mtu for drivers without bind
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589281589.3863162.4194216540460778959.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:20:15 +0000
References: <20260731092711.857684-1-lvivier@redhat.com>
In-Reply-To: <20260731092711.857684-1-lvivier@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sbrivio@redhat.com,
 kuba@kernel.org, oneukum@suse.com, linux-usb@vger.kernel.org,
 jarod@redhat.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 11:27:11 +0200 you wrote:
> usbnet_probe() initializes max_mtu to ETH_MAX_MTU and only caps it
> inside the if (info->bind) block. Drivers without a bind callback
> never enter this block, so max_mtu stays at ETH_MAX_MTU.
> 
> QEMU's usb-net device (0x0525/0xa4a2) is claimed by the cdc_subset
> driver which has no bind callback. The guest accepts any MTU from DHCP
> (e.g. 65520 from passt), leading to TCP segments that exceed the
> device's 2048-byte receive buffer and are silently dropped.
> 
> [...]

Here is the summary with links:
  - [net,v3] usbnet: cap max_mtu for drivers without bind callback
    https://git.kernel.org/netdev/net/c/1505b2cb6ae1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


