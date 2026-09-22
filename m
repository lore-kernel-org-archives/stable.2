Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64907552956;
	Tue, 22 Sep 2026 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089280; cv=none; b=McpvXsNOnhF61bclgmAcWIXMBJD25XT0/TDwR1P/BehiVJBhQoApZW6ALc3P4ioFpTcNep5iYuD+SZVnbMxRXuTqfnez3ue87U+8ekVikbYxXcdYqY0dnwbMfbOGsbkG7gTfpfaNHKxij/eBe4EzcKiTt1gcW3ou0iuBHX8fqs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089280; c=relaxed/simple;
	bh=ZpI5mIjmV46iqD++tBY206x/Udwgi0fzSLq0wOO5V+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AaCfySk0MLWTuQVF2JAc62vPhIGpF4p36Qpw6iPV7jRwlotFOAETSnS37CxsJGbOGYEhMq7oB02kAfJYSVN+ykEjtTS2aQaFiP8Gujv0rwBTaP7/6LgRLAr7ehJGfBRqFaPy5TET3xwZAld6JwkhKnucHPW6O+IKy2rePig/mS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B26CdTGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B26CdTGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A66F1F000FF;
	Tue, 22 Sep 2026 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089279;
	bh=7oMw4XnCSKbkwDJXFO11SnmPfzz/ci+tLNPOI24UQRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B26CdTGW7eR01r50fyOJaiC/KNsl4EUD8ptPrPc9JgjnyM92r1qkY7GeuSrbaxf/u
	 Y+n3rOgrQ+kB4mPHhqtxPDeipExCcb63nWHDnypdSxZBjneX+rZsk5QVSsaBPIZmgR
	 TVnnEYiFjd2Lnuz5FsPKgcYcgRcYnqzQ5UhTnDbbEyOxx0/yRiNSnj8Zi1X18IKcJ1
	 iDDXtlwl1gGo5xKINUqjdF2rnTrO+tKIl8ru48WkovdSwYWNvILbzrLmBKtLisVJNm
	 ALJ5rq2qkGfecljunkJ4G+KSs4/ILk0kW6rx64L9o1YrdDGVk62Deag0wCJxY6LVBl
	 jWVFu98kpmMZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4A3811A4B;
	Tue, 22 Sep 2026 15:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: Fix inquiry cache timestamps on
 64-bit
 systems
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179008921025.4126096.7212004044919126524.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:00:10 +0000
References: <20260922020141.389269-1-lilinmao@kylinos.cn>
In-Reply-To: <20260922020141.389269-1-lilinmao@kylinos.cn>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Sep 2026 10:01:41 +0800 you wrote:
> On 64-bit systems, outgoing BR/EDR connections always fall back to page
> scan repetition mode R2 with no clock offset once the system has been
> up for more than five minutes, even when inquiry found the peer only
> seconds earlier. This lengthens paging and can increase the risk of a
> Page Timeout.
> 
> The inquiry cache stores jiffies in __u32 timestamps, but its age
> helpers subtract them from unsigned long jiffies. INITIAL_JIFFIES casts
> -300 * HZ through unsigned int, so jiffies crosses 2^32 five minutes
> after boot on 64-bit systems. Assigning it to __u32 then drops the upper
> 32 bits. In one trace, a 7.6-second-old entry (HZ=1000) was reported as
> 2^32 + 7620 ticks old and rejected by hci_acl_create_conn_sync().
> hci_inquiry() is affected by the same truncation when checking the whole
> cache. 32-bit systems are unaffected because unsigned long is 32 bits
> wide there.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: Fix inquiry cache timestamps on 64-bit systems
    https://git.kernel.org/bluetooth/bluetooth-next/c/ea983244b99a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


