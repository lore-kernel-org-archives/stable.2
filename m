Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B24B8DFA;
	Thu, 11 Jun 2026 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200697; cv=none; b=fok7dep/GSv5JGCyevmhNIt7MZaCRIyru+7huHintzIcm2UWH9nYmaJXF27FqmuMN8ufaco+6wh0ZaVXTZDCo5o7xirF13PHVwYauUXDY6X9th/cqEaWUvN3f9LWd98p0pOFWaysPtbJrJjI+kBLAHW9q400xeplbTtE4EIvFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200697; c=relaxed/simple;
	bh=ABLMV2ze7nA13chgOYBc7ZBGhU14qUVooJW1CnoLBCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JCzOY2w7wmhghlTSGpNqmJSJY23R+SN83W94s4eezKKw4o5OCamBbdNBpx2yQvJzRBPlOgiqxQADWMS1DIrPjCVfqNlbnn631gU07lkulONyyqYmjWIfHYxZziVuoPvZrXAWVXBUirRp6+SX5/iimAzjzlsxRhDregUDrktunuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcCJR+XJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcCJR+XJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152371F00893;
	Thu, 11 Jun 2026 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200696;
	bh=OdLaVCwOyuDeurYpZqPZMIvDONKwz5Fq6cM3k7eHo0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CcCJR+XJbXwmLbSgCj/9hq5qcM3YNulSkEAB7KTAmHZh4eob+8FKSSQjslgYaVidZ
	 +v3oWOQgqY8wQBW4MHTNYNHihiyQ5JOT5guRVXc1tToOjwDQKL2MOIvD7wuUxHcbGH
	 43tZ65rTsZurQWz2Qtq+Wuvmn46SwEQt3VgLC3gZ6Q/7LJOjmVeY1z4hxQFskuWOBC
	 r1PoR6o70WrRVjQokFrts9MfVU3FR8mXHPywqam5CUs10fAa9NLOE9LzSGnHDyRsiW
	 GewR9mt1ETVDeGPDPGd/a8ri0GsBQOdszE1DBKN7ByaqCBAw4wCywf0vt9Im91e+PA
	 wulZ+2o6HJjrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939413930F87;
	Thu, 11 Jun 2026 17:58:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtksdio: fix infinite loop in
 btmtksdio_txrx_work()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120069313.286318.5639664453006485239.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:13 +0000
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
In-Reply-To: <20260609121329.1262170-1-senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, mark-yw.chen@mediatek.com,
 sean.wang@mediatek.com, tfiga@chromium.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jun 2026 21:10:06 +0900 you wrote:
> Every once in a while we see a hung btmtksdio_flush() task:
> 
>  INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
>  __cancel_work_timer+0x3f4/0x460
>  cancel_work_sync+0x1c/0x2c
>  btmtksdio_flush+0x2c/0x40
>  hci_dev_open_sync+0x10c4/0x2190
>  [..]
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a4263306d01d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


