Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349BA47A0B7;
	Tue,  4 Aug 2026 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865250; cv=none; b=UWLpY2cfF4a9sj40A2DtQ+QN1enMcUSsVLaA4Tn7mVbaCtCDojC+uc4Of5CSTzPzgs+YWclfd+PK+KCejEdfSASukZvtHywXYKXtkO6vAfM2z6G8QWJqvXJAqkMttP8RbRSBpDATIgbhwVTeh0lugWY+Q7GWNBm+H3dg295tQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865250; c=relaxed/simple;
	bh=1Gvy0YnhCFHz9R40XGJRRen+L9TGMswqURmKNmaANT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gFL/BSLt7j9SxSgVjlyuOHdyoTNA0W2ZEBNeLY05F9T/CqLbrzInV3vPmipqTnFwW7PxIX0QWFRwAfnFQ+osax+mZBWl0sOPIWnrrpq8TahUbqdm0gKH8dJCd7YeYM5MfpUx1WwZubk/fSTW43kRCwM859sx/462MuGSlm4RcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbYUVMvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbYUVMvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F221F000E9;
	Tue,  4 Aug 2026 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785865248;
	bh=pYc+xR+1kMR/SPnAgf9RsQg0UI57Wv1R0uqzS2KcMl4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AbYUVMvdJq6OIMFVJ57mx1JGbf6RuDVrjQUPEIP2FljFFhuFg6nGQxEoSjD/MAIrK
	 f4vPFchckpDkYxHnAYy9xMlBl3XY5tfW/5YL5E7s70/MOrmki4c6VoBq7MhR/tOQKy
	 9f50+Bgcd/0rWv7cta7TInITxiDVLshIGU+Fd+yIwBjLW2Pb+4gIUwS17B7wkxLLL6
	 jfI1BX0cIWBnozq+lVV/KNEZgPRWL6oG4quQfweTgpj1aXEzHicXQ3/UAeWMs2/gF/
	 EU0p+dWgOzZZfZPwcOfcedLWeJbR2VQl1TrMtqHKR5PM2l9vKT9LHo2Wgqua3HZQ/x
	 Tvd0Yf7wIxnDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939D33926272;
	Tue,  4 Aug 2026 17:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix accept list UAF during
 suspend
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178586520913.3702995.13748671232397528991.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 17:40:09 +0000
References: <20260801070524.3547883-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260801070524.3547883-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  1 Aug 2026 15:05:24 +0800 you wrote:
> hci_update_event_filter_sync() walks hdev->accept_list while sending a
> synchronous HCI command for each remote-wakeup device.  The suspend path
> holds hdev->req_lock, but accept-list updates are serialized by hdev->lock.
> Consequently, remove_device() can free the current list entry during the
> controller wait.
> 
> The following interleaving causes the use-after-free:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: Fix accept list UAF during suspend
    https://git.kernel.org/bluetooth/bluetooth-next/c/8b715ab95872

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


