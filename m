Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186344A40F;
	Thu,  6 Aug 2026 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046146; cv=none; b=dqvDDFHlW7iud9qs80tKjbSiTGlkQteIotZTecR1h3gwT3b9o7j8f6SqH0xnls0+f7fZgmB8rlXvYWgzn+U/r1cjbIfkazxLvCePWZV7srD9SeM+0yI+izaCS/67zfR5lsEfvQVuxTDlFn5hW9bh180gyfTJ1HUSgVCWGoxZCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046146; c=relaxed/simple;
	bh=gg9go1CQ0PyIkUfhAnQFiXlcpHPN5QJ0izKU/NxzhAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e1MaS3YXr53eKMrCnPIBc6OW6srwwWWspDyA0ZpZIBB2KJHdZ9MXsYUTQ06XikuX1WHBuyyUI2k7DYyKK0us/0X6cQ39w5oPaB4Io9hs625oHZ+HR8XwPXVPvR7xLVbSc5vL67FPfMFUB0vSpsluECRR9J+ll6b3PaGGppsV0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGb3qfqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGb3qfqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008001F0155E;
	Thu,  6 Aug 2026 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046142;
	bh=GBNsF+3chnaBmNz5A4RwCTlN10HCHEw9jHtzWQljr6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cGb3qfqh5onJxjDjYPIulXVZCzRs2+7JEP2W/wEiMV/35wzu7toDlnJeCVLxDFQOS
	 FGKHaAHt7ECLuz8TOAonw/qfJEcvtaYYiPY6ZOQ3n+fMS1Y8fxRD28dbWwlCBOlSrQ
	 ddJTXdEDXubLp+7AJ7jasyZ6VKkp7zEIn5a24UezIOTnRcKfbCUHI41DKMxdZRCJSd
	 T0vOU7eXN5sjQ0CHPocZjlZVYUYtyUudb9YsCWYvlBvMD9AWvZc3MS5SyqprMceU5m
	 W9RNoLomqeEbgV+DL3JI9i2MRSYmAgSbaHGYZkrlynBmwyMYMtBuQHxzdB1T1UEtye
	 vu8YSWtv/TZ8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6ABBB3809A29;
	Thu,  6 Aug 2026 19:55:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: reject HCI_CMD_SYNC params_len above 255
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178604610113.1449574.5255542768701146933.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 19:55:01 +0000
References: <20260806174001.267127-1-ali@iusegentoo.com>
In-Reply-To: <20260806174001.267127-1-ali@iusegentoo.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Aug 2026 17:39:53 +0000 you wrote:
> mgmt_hci_cmd_sync() checks that the message length agrees with params_len
> but puts no upper bound on it. params_len is __le16 while the parameter
> length in the HCI command header is a u8:
> 
> 	struct hci_command_hdr {
> 		__le16	opcode;
> 		__u8	plen;
> 	} __packed;
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: reject HCI_CMD_SYNC params_len above 255
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ed4fd40f49c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


