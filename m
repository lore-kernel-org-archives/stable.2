Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356554E80BD;
	Mon, 28 Sep 2026 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610102; cv=none; b=cH8ouvU/kgYR6AWjQdYo1wXdkm8nAxGHttAhEBPzjGfsw1FJ2trmZ47L0e+tEHouEZd8QCgTZUwX/7Cv2y1sPDL0b9BCqYnOLeF2jRYWK6oGvJpE64MphitNyc28EBAuW7wGIsyxti0STIHj0yACXnXO0uGdKdgOV65l5gVOyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610102; c=relaxed/simple;
	bh=jL4caIJzxzRJr2YUMdvc2AqfuluFzuD7NUujgixAlVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ngdbZWmtzq0x1SPzpnMxN0ugXnFreYxK7uC4Icnrb4LByc6aT8C3Gn00wrM0B+iRfQPDxYCcu1E3+w4Thn5+GQWYW/DJZbaa7Yk8Qv1esWLau1eMgzP7SI8Fri6lu6AYFxO3doJC2MsxkrvQgm+/rExesR1O6ABshB7MT5BtPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUyCETm8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUyCETm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D85B1F000FF;
	Mon, 28 Sep 2026 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610099;
	bh=FtW11PVTP9GCRoWt6jMHP3dIcybSEctK/p+rm7VvPTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZUyCETm8RPGnsCs+8BNaWTeF6eZz3idPF33QMQlw/YTsvWSVMcREDV1Mf52OIh6BL
	 L2RZKZmkLsQBWgReBi1n3dhoyXmv8wM8+DI4/I+pFcSji10+4G1u8QehmKtm3e7hW7
	 kWAf6j9WH4pZ9vZbnRp3bBZj3SlGzE2tix16KAlIvHt3s9FXd0/yy8hk77tPjvalEV
	 jxpFOOtRH5jhQXF5CeuMdPAvgU5zVD/HejSSMPKvN+Tgw1zRxbis0y/56A/vBjr316
	 W0pR/oeEIsCuk3GhBUqpCdd5cVWF6961oWF5yWBO2ZufrDIe1hyLzXhHeqcSW1YBHQ
	 ElmrKwNi6wtQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A113924456;
	Mon, 28 Sep 2026 15:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix inquiry cache use-after-free
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061002421.4169639.12676467973914024013.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 15:40:24 +0000
References: <20260926172831.2415074-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260926172831.2415074-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, verdre@v0yd.nl,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Sep 2026 01:28:31 +0800 you wrote:
> The sync command worker holds hdev->req_lock, but inquiry-cache updates
> and flushes use hdev->lock. Both hci_acl_create_conn_sync() and
> hci_stop_discovery_sync() look up entries and read their fields without
> taking hdev->lock.
> 
> After either lookup returns, a concurrent HCIINQUIRY ioctl can acquire
> hdev->lock and flush the cache, freeing the entry. The worker then reads
> the freed entry while preparing a create-connection or remote-name-cancel
> command. The list traversal also races with cache updates and removal.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Fix inquiry cache use-after-free
    https://git.kernel.org/bluetooth/bluetooth-next/c/8ed67535fdff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


