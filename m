Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327019;
	b=TvQlQ2uTOtQUfOhQhU/ROYTnfhMaWSS9JG2NeoMOWIZv8yBY0NUTQf/HtxGjZMg6Lv26
	 JBVkfMb8Ih8i/3sBA+GjpP50buZW0ePCRcKOm/CnpkBfMViwLFXyfv3eel1VWUTySpXIa
	 ZhF6meLsCW1WUxiADrXu6qB5wDSzmSeO9ckUFGZPxlUp5j61PX/SSWlcC31ndKOVS/3OX
	 i+7+T5AVSogqq96BUvwGGZO/nGmmpMyzWXdVqbsCWyBpWtggfHvx6H5On1K8Wl1JQQiDF
	 TrplPJOAL+7fRegt6zP7Afhs/oMw4gIe+J0Lfktq5JofiX2D55lYVElaDJuzjdPpTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327019;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FtgSy50ncFX8mtmhpa8fDaaHWvyfYPmRejYYMo9Zq54=;
	b=a18OaAyqDxn3SNtjaFVvjzisUfM72vUzCZ/BkTHphn3ERb/SowZoNrj+866kaQrrG46M
	 PKEZSfDmtBYwoZq/lCDaniilfwQ4IEFsYyXFNMKPK/piKr+TRCRNj5xVXXjhCffopn+JG
	 dEDieRzEXYRgaAMQdee57zI9kfYUW9cVs0m3DM/PPq18dePBu7AyKzp2kV1x/OnnoT/eN
	 tCDeNweZYwawXNHu8/Hk90MQkSP24mgYf7rz1Co6tXb7FS7N6H1X7klz0dUKhMMZ1Bxq/
	 fbm3TFO7sXw5pNS6y3pHLn1go3KkSPPS1vYMv1rzE6bmch8SAs/G0sGgjXL2/yBv/Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAHfvYZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975D606A332;
	Tue, 10 Nov 2026 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAHfvYZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59201F008A1;
	Tue, 10 Nov 2026 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327018;
	bh=FtgSy50ncFX8mtmhpa8fDaaHWvyfYPmRejYYMo9Zq54=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FAHfvYZEgvnG2OTMz/gTJHhj2QEtGKpZItyvU8aYui3AdU8f5mHsnwNhhilfvzK/Z
	 Af4vt4rPu3fyk1Kuw9Mwe0UFvCMxkhIo8Dm4vzNSz+EvSRPd7c0ICiyfG+EjuoGWZh
	 i6mIziLWHNqMe9WRUND9rOmHSStfs2pEbmUriyZ/GSKsj6/CUjaovOtbWbmNuQoMZg
	 2L3/0Nwzyir1P1jQ/N29fDX5UVUcrFGSJ47vfNH5toFN+tJVoZ71d6W/J8pOjpTmHZ
	 UVYoI2viqsHzEX0oG277p6cvLrBGN1nkWTsRv9UXs6wihgGLGMI+krtilAqG3dAwPd
	 mQ04JI0kWI/dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B07339D267B;
	Tue, 10 Nov 2026 16:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_qca: clear qca_memdump when discarding
 dump
 packets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432701717.4062787.5293659281594260012.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:10:17 +0000
References: <20261110-hci-qca-memdump-v1-1-239974fc4944@gmail.com>
In-Reply-To: <20261110-hci-qca-memdump-v1-1-239974fc4944@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, brgl@kernel.org,
 linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Nov 2026 03:55:41 +0000 you wrote:
> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> 
> qca_controller_memdump() frees qca_memdump when a memdump packet with a
> non-zero sequence number arrives while QCA_MEMDUMP_COLLECTION is not
> set, but leaves qca->qca_memdump pointing at the freed object.
> 
> The next run of the work reads the stale pointer into its local
> variable, skips the allocation and uses the freed memory.  Another
> packet with a non-zero sequence number frees it a second time, and a
> packet with sequence number 0 writes ram_dump_size, current_seq_no and
> received_dump into it.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_qca: clear qca_memdump when discarding dump packets
    https://git.kernel.org/bluetooth/bluetooth-next/c/45a25a1bfd26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


