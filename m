Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1406513564;
	Fri,  4 Sep 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541045; cv=none; b=XD8p8xVQdVl405nPV3yq3m0V4bMDtCS1ay8TO80cn6PU925OsRazX2M/N0f5lsdduxv8bFJwUzeF2kc4Qdt2kvuOhscwbpdNG8dNz2/49HpDIZ6qKBJiZAPcgLKvOThepqo9YVBgOksPooMIeN6oD17mabDvKqAd0q9L29pTwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541045; c=relaxed/simple;
	bh=TMS6nElHUv9PW/vu4oDQgnH0oz79d1wxu+JfD+TP2vw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T/HAdDORCUVfv6LJ8KX/aeWVSisQFbQBdh8s5KqEUERKZ55f44htwwXq+rVIAxN5V5mrQFhxV9rupop1V30g3kEQrul63u+EotH7E8+TA9Z6rdRu40kZxnmR9ERIfg/5kRHGzq58gX5ZIXPjB1pQ32GAa37hNXHinTsrAE5NVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4I26FZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4I26FZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBF41F00A3F;
	Fri,  4 Sep 2026 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541043;
	bh=AeV3yyLfLRe+VbWsMimr7r2EXKFZGRtitq/WNlvi64M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q4I26FZM/XVYYHNnYCG6LFg3oZfqt3KL7lFviCoy4rvrt/l6JPESFEsWyQwRtn8nt
	 XYoyZpJThe4/bVatxDDx+vTFUYCC2VppieuTjM7gqEQaOGRWkh73JrsyFjO0j3Qq2n
	 zNejp5Dq2YC54iXQqqTXHVbo76s5bsMYZ+JAquqy/deyknYO/YcmJm/rGVK5kRrefF
	 gk2ceuA/2d+j+TbEr4k/AYExGrV2aPrcGAhnv+9tY6SQHgf0p8P8CDvr6xbLgcN9S5
	 y/8LBP+0Vg/6kxjGLSrHjyrJSYVLFZujgFT7KCHjMITHhqRZQVa/aMwPT6rgeT+uns
	 0e3jU7V9p0NPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A873924A50;
	Fri,  4 Sep 2026 16:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btqcomsmd: destroy RPMsg endpoints before
 freeing hci_dev
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854098363.344939.15503505083732657527.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:23 +0000
References: <049D60B81C44FFA9+20260904025457.3523467-1-raoxu@uniontech.com>
In-Reply-To: <049D60B81C44FFA9+20260904025457.3523467-1-raoxu@uniontech.com>
To: raoxu <raoxu@uniontech.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 bartosz.golaszewski@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Sep 2026 10:54:57 +0800 you wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The command and ACL RPMsg endpoints store struct btqcomsmd as their
> callback private data. The receive callbacks dereference btq->hdev
> without taking an hci_dev reference.
> 
> The current teardown order frees the hci_dev before destroying the RPMsg
> endpoints in both the hci_register_dev() error path and the driver remove
> path. If WCNSS delivers data in that window, the endpoint callback can
> run with an already freed hci_dev and pass it to the Bluetooth core.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
    https://git.kernel.org/bluetooth/bluetooth-next/c/b3850074b2c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


