Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159283C13EF;
	Wed, 19 Aug 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159460; cv=none; b=aKnmRsfse75VmRAs+Vjhfgt/0ZaEOO1ZTPyS7wMigjNov7JC6RogZPZdk8q18yhKPwPEZsCHWeYZuj7WyxNMWhNKuQfn0fbS9ybzKbSaQ58ewOkansbiW8Z7XVRQW79LZan9NL0kIujeCZCnDh3a4tqisOYLVqHsvg5WUFxqPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159460; c=relaxed/simple;
	bh=UGJKchJC4n2gY1dhQyFSV4uaEp6udia2Ar0p7zG3+tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R2aK269MHO8SgWbWMst3bOXczWRQ/v9+MTc9wFtOBotiYVgikqh7S0uPhCrS4Ks56cmfEiMLibtJPPpVlBnZFWT6NuRohGXPJ7HUwSQTgLhuiivLYHFN/8soNeGzFtnu5/CxD/44v/YxY2efeFNyZEW+Hna5pyI3UCRQpBOh/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3KRlkX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3KRlkX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A728E1F000E9;
	Wed, 19 Aug 2026 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787159458;
	bh=Lx/ol6yGQVQHJpcUaqVf68i0kinLwAiN5QVIVSAVol0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I3KRlkX+UMcbj1tjxCSFht777xUEQ7UMhSvCH6UtQ5S9viDq/G+IW00/s+5gYWc7F
	 rRvWf1PaR+ZJkm7IvLiKB3z5LRZgkXmV/TLYDiveP1e1W5+occh1cVBkhi4Ce9QgHN
	 BC+TNCcLx8m774p+Xb/l+kYqLR6oovCGqjKk4LfM1+WWRWZUtj5k5R474pGgFanyJ2
	 EbGsKxEPHZWUAYemwQMirr+9kVH3HHERdYhOeqbHfnBYxZy1z6jg2rHfmIjzLn5w9p
	 veyZXR3awTbP/dGxwmOtr3HbWCqtC0/jcGq1LHRm35L7dsihdXgp8z6uhN295A4tu/
	 MOsaXJzTtXvxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D094A38119E6;
	Wed, 19 Aug 2026 17:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_core: use skb_get() instead of
 skb_clone()
 for req_skb
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178715940938.3583745.2165256517061172398.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 17:10:09 +0000
References: <20260819135321.1444185-1-xin.chen2@oss.qualcomm.com>
In-Reply-To: <20260819135321.1444185-1-xin.chen2@oss.qualcomm.com>
To: Xin Chen <xin.chen2@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_chejiang@quicinc.com, liulzhao@qti.qualcomm.com, cxin@qti.qualcomm.com,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Aug 2026 21:53:21 +0800 you wrote:
> BT enable fails intermittently with -ETIMEDOUT (-110).  The kernel log
> shows the HCI Read Local Version command was sent and the firmware
> replied with status 0x00 (logged by hci_req_cmd_complete() BT_DBG),
> but the waiter in __hci_cmd_sync_sk() never woke up and timed out
> after 10 s:
> 
>   bluetooth hci0: Opcode 0xfc00              // __hci_cmd_sync_sk
>   bluetooth hci0: opcode 0xfc00 plen 1       // hci_cmd_sync_add
>   bluetooth hci0: skb len 4                  // hci_cmd_sync_alloc
>   bluetooth hci0: length 1                   // hci_req_sync_run
>   Bluetooth: hci0 cmd_cnt 1 cmd queued 1     // hci_cmd_work
>   Bluetooth: hci0 type 1 len 4               // hci_send_frame
>   Bluetooth: opcode 0xfc00 status 0x00       // hci_req_cmd_complete
>   <-- req_skb NULL: req_complete_skb not set,
>       hci_cmd_sync_complete() never called,
>       req_status stays HCI_REQ_PEND            -->
>   <-- 10 s later: wait_event_interruptible_timeout expires -->
>   bluetooth hci0: end: err -110              // __hci_cmd_sync_sk
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: use skb_get() instead of skb_clone() for req_skb
    https://git.kernel.org/bluetooth/bluetooth-next/c/be766d775060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


