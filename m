Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B153BFE33;
	Fri, 18 Sep 2026 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697495; cv=none; b=YCzY9b0GP5ib5lrPEWyTrq42LofoGGtt1zAmt7nPe1mJVIkf4DkY92auPXsTK7ESIIfmm5CCHyEwoPwz34BthSoGOD4NgOIk+KmN9WDUW+mZSN9Fb9h8JWufUOBEC+vOizMReoUGMUbT7kg7mvI+90naRrnth7ENq9YGXblcaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697495; c=relaxed/simple;
	bh=ij5L5ZqeBDDqX+UWLF0jX2oVYc7Q8FRcvoyD0/LNXAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aV9F7SGptMb5lGU3324OXF1Q6R8OM1C0C5C232DkHRmyL0FjipoW4uD4sz4hd4ZyyVV3MHYNaDCpC2AR9mPa6Y+qK+bFSdArCGSYmNCmM1FWyw95sNUrX7j5cvmgpQqbb4t8eE1xKFKbT4ro1deroLOGrrwZx9PLy/XY6/RggC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbLpeJzo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbLpeJzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AF11F00893;
	Fri, 18 Sep 2026 02:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789697470;
	bh=RDSFiTnasejf/YPzfRZGymaqR+jEQwBUoaug2P+t0f8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fbLpeJzo3pgd5oJ5dnGlLyp+/gUUwi5CweXTwupqmTjrqVDEMqnt136O2jInvxIFu
	 O+6tlQU/cZB/vzW4gRmuN7Robaxs784IQzhOhIJkqzDzl0wruBBG1gkktV6meINoYT
	 auda8kpojvitDuEZ+CcftdWp/y1OhFZO26tc3JusK4AYWWXqoIvEe2zm/Nhynk9Lz0
	 VvBFk7+bUkg4rcDJQBB0kX8xmsNrsXTkx9rwAdeBlAkFfzrNbwJM9+pEC6umUiqxVC
	 nXavdN77KINIoqgafkm1E3L2lfZFosnf/URFjdEMwqG22E7oTPMSPla52Sd66ypRI2
	 biiFQxmnnd28w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199B0380820D;
	Fri, 18 Sep 2026 02:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] vsock: ignore empty child namespace mode writes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969740389.229945.4198091256546266269.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 02:10:03 +0000
References: <20260915173050.3176344-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915173050.3176344-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: sgarzare@redhat.com, bobbyeshleman@meta.com, leonardi@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 14:30:50 -0300 you wrote:
> __vsock_net_mode_string() returns success without updating new_mode when
> the transfer length is zero. Its caller then reads the uninitialized enum
> and may permanently store a stack-derived value in the write-once child
> mode.
> 
> Return before calling __vsock_net_mode_string() when *lenp is zero so
> that the helper is never invoked with nothing to parse and new_mode is
> never read uninitialized. This also prevents an empty write from
> locking the current mode.
> 
> [...]

Here is the summary with links:
  - [v3] vsock: ignore empty child namespace mode writes
    https://git.kernel.org/netdev/net/c/2ec28c09b320

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


