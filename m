Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75D44C665;
	Fri, 24 Jul 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919670; cv=none; b=p2DfOm4cSgdrO3EXGQcG717ZM4vJwCQz4qtAzcA4XBxoeo27hFEHTdTF/OEbjscpGbErs9JLPzBkXPZQEIlOw0GkCEFD8gH2VMKQbUhGbGpI4AcLRK1b083tpiM7YUB52Bn+yGdS1IDbEMHntJLQ//rHhBUZ1tZCEGMkmISiyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919670; c=relaxed/simple;
	bh=PP1zfFatwH9Eoxl5Bp/t+XKX+QccPA2KtKAMrbtIwPk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bNuZEiYyOi9w8RCW8S13fcEAn3EwMLatVbLfw/kucqnl5YpVvQBRgXx6I6qhgpnD87z02LD0KvxwIn6iz0lvmyH5Gf7JCsVjwBpvOGd6iQh+e4oP3ZQVegjT1zLIEsJ1sPdMNspx72GNoMb3e3YDtT4i9kx1BaIL2X2JZQVu+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkY8wNFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkY8wNFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF581F0155B;
	Fri, 24 Jul 2026 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919649;
	bh=J8uBhasEdyS93FlRgjpW7W6YMfqspF1QUxEV/9S74mY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EkY8wNFM+AVv0R5+uCNGz6y45JnBfXEh5fXlhxY+JuD6jJtH5EhCwoFEXUrSjJF1T
	 0FMUjyEWLXM9fEZtJp8uKc+D/jjWLyR5yQoZplfM16o11xx+/QC/EctrGDK2JJ+dFf
	 kcuwvqcgPnhSh8xHplfp/i0T8zCR+49jd00JR3c4RD9qcpmykDTK3U3yHsv12qeCcA
	 naRhhwmG8jzMgGpBiQLDlSc9VGeffBnYimu1HB9H2Nk2auIVgZMxWcg3OkuiC6WAx9
	 8GMx7zcWNEFkJdTxbS6DPHh4GrLVrkY+v0gXcGb1dAhSbXgqT++dNtjEvPjXjkuFjm
	 lqX68IHEvrJbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8B380CEF6;
	Fri, 24 Jul 2026 19:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix advertising data UAFs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178491961639.3273549.12844487841228908666.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 19:00:16 +0000
References: <20260723153440.3224299-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260723153440.3224299-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Jul 2026 23:34:40 +0800 you wrote:
> hci_find_adv_instance() returns an adv_info pointer that is valid only
> while hdev->lock is held.  The advertising command-sync paths perform
> instance lookups without that lock and, in some cases, retain the pointer
> while waiting for a controller response.
> 
> An advertising termination event can therefore interleave as follows:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: Fix advertising data UAFs
    https://git.kernel.org/bluetooth/bluetooth-next/c/a3ad01d51d4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


