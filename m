Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743AE3C10A3;
	Thu, 10 Sep 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073472; cv=none; b=ZP+OKsJlNpjP+ItlZ3sxokhSZN5dlDPuV4i5SRhlt3E29/pnJ4csScrjPc7nLHH+xyXuiBGbedXSzA1jvyw9Ii2wpqKKlMux23bj6c6KU99PMV2sS/zmSodFJlaPUvrUmbjhxHhM1qeWd+IykZdvcPZb9Av5Cpcg1BXigblKgwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073472; c=relaxed/simple;
	bh=LfJlwhLJhS3nA3C0C6ijsPj0sUen1IaqXxD5DqBuil8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mpQJYs0peD6+A529RARxK7hRv4DHHkgADfmYAQ3nVWyf5k/7OrIEJ/6/C1lfKIlqHu91xk/IeM1jkjckMJbwAQ/nD4a6Rbe//t5oBtMC/ODBimYLoklHiVaCr69GS9xG6MX9jKj/XGOwnRTg7lQcMNVoiCXDQhFzacYvWPZqxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZdqDVOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZdqDVOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE871F000FF;
	Thu, 10 Sep 2026 20:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789073471;
	bh=0XGOLbepuWdRrCppwS7Mqf2t8tDlDTO4Yc/5dw//KAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jZdqDVOcG3RulGMVO0v3y5bOKRZLksHd13mxs3dFq8univbbr9oECUONKmVbLIl87
	 mySXAEpIMiSGX2Q5cY6zoVkmzXgOjbGXzMXCCOrLdAm0RT6c6LEFUh1+eYV9Wa8P/r
	 5OEmiezAuUfUFnNn76nBwAPEPC/TKPs3gLc8RqTPL9VqROtPYDLaBdBfZHmr+u3AaZ
	 nN1Fjd2o3cRdS8j6ooBp4BVsU5AcnrFByQ/Wqr1JYZpnQzJN5yUAS+fAehquoCOSb8
	 tIh2nTDBOPn/mYSEs9SBKB5Csj25pCnBbPa8JY8qAow8EmuhkxCHgScvsFaUTQqhBx
	 xm+u/toPY3tJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B5E380DBDC;
	Thu, 10 Sep 2026 20:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Serialize local codec list cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178907340813.2075844.8834816914605472412.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 20:50:08 +0000
References: <20260821174350.3034506-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260821174350.3034506-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 22 Aug 2026 01:43:50 +0800 you wrote:
> hci_dev_close_sync() clears hdev->local_codecs after releasing hdev->lock.
> Codec list additions and both traversals in sco_sock_getsockopt() use that
> lock, but the close path does not. A close and BT_CODEC query can therefore
> interleave as follows:
> 
>   hci_dev_close_sync()          sco_sock_getsockopt()
>                                 hci_dev_lock()
>                                 fetch codec entry
>   hci_codec_list_clear()
>     kfree(entry)
>                                 read entry->id
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Serialize local codec list cleanup
    https://git.kernel.org/bluetooth/bluetooth-next/c/ee0662ba1e0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


