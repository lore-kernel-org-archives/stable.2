Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926637;
	b=a9JGu/d8L5MWsIl29vfdqL+86xxGzuuifBb3L0i0OI2uMwINFQrb2tWiFPpl2yzRgzUF
	 HDozgFJDAIq3JixCb1RexUm1lvL27lMVRtdKnwBzxh32HgwYSPg/k6+HMhUSlUPm8jMkH
	 /W1MZvgTcrtIp6GV7F2Oy3zM92o6ONF1aRM8Jwp0PoW0dPEF7fYTE7qgNyICS7uhuzYiZ
	 NsigvCH9nF/IH0bkuFKYvm+gHr19OXWOQEgxgfml0Zt5tqZ57CIflI2AR+3pyDrfWh6D7
	 /M5xc6bkBGM3rCxGBvDjoF+b3459EnwsIgEM/f7Y3avzlDSscJhGviVe9f9L326ptdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926637;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=7fNxTmo1iJxAalqGfiJl8NK5T396HgpYiPcomm03E7g=;
	b=04N8hNnQnwT999mTLl94gyAARVeM7dT+KREiX+35Ra9I05Z9WKkBs8mR1ni3w/k0278P
	 norYkz5m5yFvMB53Q2RrivbvkDKNeog15SGEKBaNrKjppX+PvySAvWbzidZdgMFQMtfPx
	 tNiO9/8cEhwXhF8kBaZO8vXa1/2KojElBZc9AWHH9NBu3L9IZDKKzX6T3j9MEucON59VD
	 fqDB/87b9u/JRE8BGHONUgRAV4+Hzx/6ZVkpiKnHEwwqgXiM5CsyQmpP8EYja2Lp8Akj/
	 ANmckfhgRxMLfxWaX8TGjm5EbVgOV61lBL6WbxTSnwHUh93AdD/FZer33olWqWNTPSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MberW9n1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB2606A31B;
	Fri,  6 Nov 2026 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MberW9n1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A351F0089F;
	Fri,  6 Nov 2026 00:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926636;
	bh=7fNxTmo1iJxAalqGfiJl8NK5T396HgpYiPcomm03E7g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MberW9n17EZW4JlwHg7V3W2ZtrrnmWJZJwd5mtDOUt4gkSqspi6hiq2lUAbh20wMI
	 rFqBlTQbht0+DqdtjOuN0SmjyEXbBZuLJoOEBOhsuMPw947OvgOtUtQ1DSF/r9bcfj
	 jfPS2xcTdyOKwzwT2S2xU/hIBHVm2AtyCalEnBOlBIpZ3tC23W8ZtJLLbnxF9ax6nN
	 h55b3FV4Vbss7w5ODyoF/SwwbSZ5vFg4fCMdugmp4oJc/2nejeb/0Nu8RXnzmhgLrX
	 /+6BYha2HZanVKCEFyQHV4pcd91eQnyc1DXTb6/pKN+uTUAxK3zV1vLQ8stm7ZWGn5
	 oFwmv9LsdOSZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D85E2391B1B3;
	Fri,  6 Nov 2026 00:57:16 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261104081535-mutt-send-email-mst@kernel.org>
References: <20261104081535-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261104081535-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 1a577f9402c1780cc1e663f48d5dd54c02051b09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69e2b55fc3b4fa3639b8c320374c255f046ddda5
Message-Id: <179392663544.268614.18316121610882837897.pr-tracker-bot@kernel.org>
Date: Fri, 06 Nov 2026 00:57:15 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, longpareto@gmail.com, mst@redhat.com, oss.patchbox@gmail.com, p@1g4.org, phx0fer@gmail.com, physicalmtea@gmail.com, sergiiushakov@google.com, shubham@octane.security, stable@vger.kernel.org, stjepan.poljak@gmail.com, syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 4 Nov 2026 08:15:35 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69e2b55fc3b4fa3639b8c320374c255f046ddda5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
