Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B52339362;
	Tue, 11 Aug 2026 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479054; cv=none; b=t+YHJC6PwhwmW90FiA/tpf6bARt6m02IhwkmzYyGUu7JRE8lXBevdRmLktsHV6BCT0V03cPGx7CLGzcn8D1uCB5f35koXee1E0uUUWFMNBXhbqbqDoRYpIuWpgDOGOEZ4WruDPkBDNlidAOOA5Bsha3+/cUwOMQw0caeAQ3XYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479054; c=relaxed/simple;
	bh=stpbv0KcR2KOoscbn3KPL/KpkGDLP7p1zQUqmnIp7h0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uhH8HvlUp++zLq7hsI8Vde97FhWxu2hUFq6GmW6fnXRPPEwjuAbNxUqBCMacb0FxFqi2iHAXE50gQPlRILOsGNk378ghV2cCD1XZm8Q0WTKcOyei/yM64Nz+YdTgea66JMcRB+OXdm4791tBgGWa5Op8Ds1FqhcsPlyeobP5Wb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa0Kx7cF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa0Kx7cF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262001F000E9;
	Tue, 11 Aug 2026 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479053;
	bh=UhuEC/4562OpSNwFZZdYO9lXAnVG6MPZxQSg8oCCs90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oa0Kx7cFzOx77VC7YXuocRX9Ebj+65YiLu/J6K6MB5JgIWZCrFETJxP0I9u+nUZ6f
	 4RCqbA4YXbxLBDnuoCJr9kMhuInPw6P2rF1exuO2r2ynnsIn70ntS/PZ4TR+IFuFrN
	 NGYwnlbdRFpoHnKwwG6YhOyi+6esCN03g1NzOcp4K3D8RA5rm8Lq2hG5pZOGnnbXpe
	 iJsu0SwlTIBpt+alvz/L/cMepMj7nPNuqrSgMqeM4BjdvVCeKGNRblpzd4oOtVgPST
	 SMNhVi1NLF9jEmtpnz6Ms8IUY9rGajiw0bYz0kip6xLuzJKQtqBSzBmYDljGlb4Wxz
	 Vl0VA/VVYwcIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569883809A0A;
	Tue, 11 Aug 2026 20:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when
 dropping
 the last request
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647900915.1134064.11707666593550364764.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:09 +0000
References: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, brgl@kernel.org,
 iabdelka@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Aug 2026 10:37:29 +0200 you wrote:
> From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
> 
> A synchronous HCI command that never receives a response leaves
> HCI_CMD_PENDING set: hci_req_cmd_complete() is the only place that clears
> it, and it only runs when a response matching the last command sent
> arrives.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the last request
    https://git.kernel.org/bluetooth/bluetooth-next/c/ed516e3f1aa6
  - [2/2] Bluetooth: hci_sync: Factor common cleanup code into a helper
    https://git.kernel.org/bluetooth/bluetooth-next/c/2fe8aa99af55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


