Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A54E7800;
	Mon, 28 Sep 2026 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610110; cv=none; b=CLUlqFqXGqX/ylxI1fEukKyqNJtm+E2aQGZCxwjGbrXQrkCukJ+h3JkxbRCFLeR0dSCqtV7twYzlkbSbIUPUedRCw4JH4El079dCjQsAaSI9ETXTQXE2Nr0pnENzhDrOL7GGE1phxxr2rY2dSAu6ztLcAIiHR7J/bnIFb0S61Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610110; c=relaxed/simple;
	bh=M/fWg32X+jWRyGtUn6MYBCkwIPR3ZbEJvARH7OJcSJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Di0juaZyxv3/OSE1mjYY++2gYT8Jd2DvFmgMJ1woWHRj7OHv8QXxA00ltW0kwrE9tfykn+95Gy8cieHUVWBcj/9mn6iTqwjVBcyvRvJ8KInpLFd0UOekiFA3kON6rzbWlFf2SR8tC2UmbfU8YinOcQM1V2BW6KiAnB8oGBtoyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeq4J7p7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeq4J7p7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC061F000FF;
	Mon, 28 Sep 2026 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610102;
	bh=kvol/W8uAK3GHsZgg4kkIKgPe9oIcP7xYkscxk0HtjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jeq4J7p71XMWFQDIa+TeyN/DBpUG2qmrfbUgWTMl63cgNdezyFH8n9mxIRu3sgjor
	 671pSRbFRoahQrCNJDOfuz/YjNOkptlQ58yx/JzhAgdiNrHGCmlBU9Bvyj+8YggViB
	 rFGLfs7ErSSl4h8HsUY7is0I6uQMV3P5pSsUnSkvtQzh8vcJq458U/kVhoVexj3p0T
	 tdtCqtnb440KC3i8EyPbw9L6l7JXy/JooGE0OUtX90uwmUlnjsmEUEjlDVXVJ4+ei8
	 UoWTCWltdZyvRymA5gWDE4xt566Ogr2g8UHFYxwMU1SPh349qj8SDYCvaTVMfuxStv
	 lA/5MN8xuJtjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A013924456;
	Mon, 28 Sep 2026 15:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Lock parent access during enhanced
 SCO
 setup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061002714.4169639.10333863010515930414.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 15:40:27 +0000
References: <20260927110450.3902328-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260927110450.3902328-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Sep 2026 19:04:50 +0800 you wrote:
> Bluetooth: hci_conn: Lock parent access during enhanced SCO setup
> 
> hci_enhanced_setup_sync() runs on the request workqueue without the
> hci_dev_lock held by its caller when setup was queued. Its CVSD
> capability check and find_next_esco_param() dereference conn->parent
> while the receive workqueue can unlink and release that parent.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Lock parent access during enhanced SCO setup
    https://git.kernel.org/bluetooth/bluetooth-next/c/024e05f73a4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


