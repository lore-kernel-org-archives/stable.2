Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A536167E;
	Sun, 18 Oct 2026 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347487; cv=none; b=AI4xFanPMc4zTFUqIMMhLXnc/dKpQYRdP2G0TnKdrdweBTp5sxJnfblAvbTEVUDbXL4hCk2NCn74NrSyNFpnlO9L0zB7WDxYMY58OrRfdo03zLH/GG5wpYo9fOo01jroivWfW7g+0fLTLKipVwP9phDZuWqmKF25qrcWq4xerhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347487; c=relaxed/simple;
	bh=XJth+HKxvYna6YDFIFBLrjzpehs6n6LP+6RgkSTn5ec=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=glQ28MOoOsBjIX1j1CBAulg1N3GCUfetp0D2N3gUzuDy1m2hBVP9T3c5T3i3nsi3wsCcA1dLfFyG+2UZQEtAmu4ETfKymCKQOCOAj4jDVUlql1Iq9XCC+nYGQrQrBWSRWy8L2sZ30/Qsl8TZg2OI6Olca9rMNXZl7R99sWpLZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA515O6i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA515O6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071FF1F000C4;
	Sun, 18 Oct 2026 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792347486;
	bh=22jeEpUyPP/pwrwGF4/O8LzXdVriFcQz5XvICjLCcnI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bA515O6i0tKz6njMMnfjRs9MecCTEvenDUWvGb/y+SbC9mErb9EDa0AeNvkniCef6
	 x/g/ZAszHJgnx58eHHKR9jp0X4ptwW5a+KuWVuOtzwOQ0xoKctaXrdT/QtgMg1OUa/
	 JtFEdHmKhrFTsN1FH4hGuB9T04puwIiiWRbGyx740M8+Bu1MtZv04eChxqTfawvltN
	 ULaXDqTca79jx/8x8BPp9RYLecH58Tb+IHBl566JtlNF2YazAkJAI+oW7x+LnN9F51
	 2OPFWGpLykElk2HMSrS1XOUJoFSFDzJr4N6wxkPq5ZL9m5nAIqCyGOakNy+OaGM0ZK
	 Y8pcZXv97Bz6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F166E381196A;
	Sun, 18 Oct 2026 18:18:05 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v7.3-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261018103634.GA346762@sakamocchi.jp>
References: <20261018103634.GA346762@sakamocchi.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261018103634.GA346762@sakamocchi.jp>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-7.3-final
X-PR-Tracked-Commit-Id: 7f9f2d6abc40f79e802b4063859eda343043b85c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0ff06b3a7bd3aa0cd99d0294e60b3ed28c9bfac
Message-Id: <179234748448.1773475.6407537424612811996.pr-tracker-bot@kernel.org>
Date: Sun, 18 Oct 2026 18:18:04 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Oct 2026 19:36:34 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-7.3-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0ff06b3a7bd3aa0cd99d0294e60b3ed28c9bfac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
