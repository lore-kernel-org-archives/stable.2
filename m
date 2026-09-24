Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC17446053;
	Thu, 24 Sep 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267477; cv=none; b=LBGS+2BNjtJz5FHGMypVV94hlg4LxShZ5+J/Eh1oZC6jbMIYX8JSqHYjRey3l5BW6rmDBKC//tf3tIv6ZQjGlaEs6Pc12HRZn/YqsZgORZERjOpzHzppSQY9u9268ZnUf3/GEiHsZYvBWYr4ItPYslKH3JRK6gLVrMG7XNsoXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267477; c=relaxed/simple;
	bh=IdA+mcFIM/aPB3twx0y7leb4szaFE/tPvTooXY9G6LA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OILzECM2DxC4qPB/oQQUknbbyyM+7p0ae/ZWl/ZN3lkHEQOkVw6j4hXmq6W2NY4pOv5DzobMguAefu0w1DimS6+7QhJX99jEUofP+aCmNZEdY7dTzpTrhSp2c8qo7hqntHls9Cf67/GK0Ku6AGJAZM43x04QjXPwkLfjoBe/9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk5g+hFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk5g+hFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2B31F00893;
	Thu, 24 Sep 2026 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267475;
	bh=ow/Q57RKC0ibuf1QxYnFsae0EBpIqB7kmXidBtLR4os=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nk5g+hFX1F5vuh0mFcjO9vJLU3bQNQh2q8Jv8EOPPrKTp3bmz34Q81opzVIUcFbpm
	 2CdBEc85FeGnWgT7q8USMGOtJhkks+q+7mcp14Jh6v9myPXNrdt7DX/I5/Wir5PrmV
	 e9SdfZ9QC8T/tnGDT5i7ytogWbRuFCQn6fRQqz4nXRlTg3MC6VTPXlGk0rHWbs5eCZ
	 39wScb4ed3A7SI86rDT+Yc7fP3S54TsGUY94l+HD/yILUenFyLW3nRDF/oo4JiJmMl
	 uC6RxEVoxLAq7fJemHXmn6f12lFPYshTTmMFFKciI90D/HurIMP2Q9glFSC1eFEPvx
	 M4oLnshqtfj/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198543A566CE;
	Thu, 24 Sep 2026 16:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP
 whitelist
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026740490.1641283.14259237051960646702.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 16:30:04 +0000
References: <20260920074500.826121-1-wangming01@loongson.cn>
In-Reply-To: <20260920074500.826121-1-wangming01@loongson.cn>
To: Ming Wang <wangming01@loongson.cn>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org,
 oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 15:44:59 +0800 you wrote:
> The MeiG Smart SRM821 5G module (0x2dee:0x4d53) crashes and drops off
> the USB bus when it receives a Zero Length Packet (ZLP) after sending
> or receiving an NTB of exactly 16384 bytes (tx_max).
> 
> According to the MBIM specification, devices do not require a ZLP
> if the NTB size is exactly dwNtbOutMaxSize. However, the cdc_mbim
> driver defaults to sending ZLPs for devices not explicitly whitelisted
> to accommodate non-conformant hardware. This default behavior breaks
> the strictly conformant MeiG SRM821 module.
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP whitelist
    https://git.kernel.org/netdev/net/c/f75f21ef3628

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


