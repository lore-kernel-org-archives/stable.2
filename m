Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB862ED154;
	Wed, 16 Sep 2026 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581690; cv=none; b=GpfbzhIUMkZ+kpYgIuW2PbJ0XXLly+zWZ7RUqlLRrytLD/zvptnHRTRpw69yy796bxbFYOiBw98ZGGkupejJwOgpHAd23RBzlQL8VM+e1Ngsr1T1H/rrjrdeTT9+8PoPAgXJVi9oDPpmoRxVYqgva8bVbHfyur2WkEUuJQYLVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581690; c=relaxed/simple;
	bh=AJKCUq9A8Zu+G4x2d7S2wREdOZHWrDmobJLPcTuAvDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PZBwumnJoCCCvhv/Lw91Byc84d3AQgwhu21IGHbDTdoVA0xDueV/zeQQXRuV2GFbRlcAtyAUDqAixuiCkAZ5v2ttVzHHbiNuOVSi3zu16H7njNLcLFFk3dk82SzytM6HqqeS9yh7EvpUijx4wDRjyZVrcNfm9iYdCgEqdbI72Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlcAoX7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlcAoX7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1141F0089B;
	Wed, 16 Sep 2026 18:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581676;
	bh=4YGfH7wG3boUknue714fwLygUWmZyxq4CTJy7wyKZDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IlcAoX7ISOGpMihEgMbbLI+/ihA6Z8Jt2+HXnVUfRXVIAPRLb7+QnrOIsuPPeFR4n
	 p5oz4UHc3q9jeLtjMXvpA9knKuj4a/9VC/nSUvsFxqVObmLlkBN0Gg/Q+UEPX3WX/w
	 t2QG/bPwf71QyiJZXFkpIpfbpjukU4S2TQaqSCqKjRoLKav09g33qGYMSyGWs8Li0r
	 F2QyVoxsJJ/zBP27/EfbUZrOluOXCmshS0N3E3QqJH3Y/7x9HfFd2AFwYvhBzp2QCL
	 nIz9hSNPpZO8gtSxEL+9FpgeLgK/et3gNEHjzp9cNwhzmI0y11+v63cRCa05s+h443
	 PM0aVaYXmnNfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5684039E8A50;
	Wed, 16 Sep 2026 18:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: mgmt: fix race in read_unconf_index_list()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958160987.2777538.5804352292158547567.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:00:09 +0000
References: <20260915155952.3104711-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915155952.3104711-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 12:59:52 -0300 you wrote:
> read_unconf_index_list() counts unconfigured controllers before allocating
> its response, then checks the device flags again while filling it.
> 
> hci_dev_list_lock stabilizes list membership, but it does not serialize the
> per-device flags. During asynchronous controller setup, the worker can set
> HCI_UNCONFIGURED and clear HCI_SETUP between the two passes. A controller
> omitted from the allocation count can then become eligible for the fill
> pass, causing an out-of-bounds write to rp->index[].
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: mgmt: fix race in read_unconf_index_list()
    https://git.kernel.org/bluetooth/bluetooth-next/c/b5dbb41b212c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


