Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C8C4E73DD;
	Mon, 28 Sep 2026 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610112; cv=none; b=LyRW/LxcmC6hcmxqXgucFXEd6TSK52HUDdTE4hCkNRuX4WdhfivyR1RJF8D5zTkiavvEv5DoGYhUsAMrUQj/RxggwgmKlssRMHcJyGlnYWJEM4fWM/GlvEIf5TtQEAHjV7beGIsca5+SfnfgYl0uyULRrZRSE0nUlElrduFYq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610112; c=relaxed/simple;
	bh=4Xw9kuabujU4yzNhnLtlgulQmVqIM2VNYD3Pol5QHBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NFNAVSmMpaXoEgzaBsE4Ht9Bmnbo9J3IUQUC/4Vxg2ObU1TFowHZwG0nM9N4Wv3U185BmmvLRISQbXlUa+SwJNSNATX+WutytGnOI3bq+eNdImEYwGv86FPK9hvHDDP5+5VR22KyfDqF100pbvL0Rr72kmdPY4LbLCYsTimdH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlevlfPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlevlfPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FC21F00899;
	Mon, 28 Sep 2026 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610107;
	bh=Tgf/xz+nv+0X6hvPyf9iZulgauVuwBAMlz+MDk7Nhas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LlevlfPXEEtXLFdGCuusVsKYCXSIK1rTWfvqEoaqxffFO8wVs5QowbGmCIzMmm5ck
	 gQssCyLXObr7/gk2tDfBn4xIaORSPcUE8DQxQrGgKabAVjRu9tHzN8oGO+LAGb6PT8
	 D/WmvzPtx+Hw1u8aKdsFWh5rtp1IwYv8/sHhkZECG5I37TyNSo8u1A9h6q8uIzw0cV
	 5d4ftCbqigtwjSnSQo2CvblDXdhG9IPl6q7iGYmp7a+iAc2QfAPcz9jDsSYlyWjSXh
	 pE+ZRx3ZRUcrU+8VDttP7AwRMsPFf2I11OTaEZ8zgtzb6/odI8n7rI82s1aixDrTB2
	 Kpd2UMtLGCAjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198083924456;
	Mon, 28 Sep 2026 15:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: Serialize fragmented ISO packet
 queueing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061003164.4169639.3011615107768318520.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 15:40:31 +0000
References: <20260926172935.2423925-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260926172935.2423925-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Sep 2026 01:29:35 +0800 you wrote:
> The fragmented path in hci_queue_iso() calls __skb_queue_tail() without
> holding conn->data_q.lock. The socket lock serializes senders, but the
> transmit worker can concurrently remove packets from this queue using
> skb_dequeue().
> 
> After an insertion saves the old tail pointer, hci_sched_iso() can dequeue
> that packet and pass it to the driver. The driver can free the packet
> before the insertion resumes and writes to the old tail's next pointer,
> causing a use-after-free. Concurrent updates can also corrupt the queue.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: Serialize fragmented ISO packet queueing
    https://git.kernel.org/bluetooth/bluetooth-next/c/1a572db43c05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


