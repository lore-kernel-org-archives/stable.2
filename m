Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC24734EB;
	Tue,  6 Oct 2026 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297020; cv=none; b=mvzTPH4KZhOHuYMSLeNWeFZmiYVLLL2jSvO2plZqJKYvNo0fklgjkTrj7P3lWWNNwbhQeqLWcEhxVNIMsZ0IRQp7h7HHBufCBLnDuo3auSpe0s3MD1t+wIm0ix0jEYMucWKVmylv36SdgMOcKQs4cEt04cGAxJdsd/506I97AqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297020; c=relaxed/simple;
	bh=vrOU9bfp+RncdV+cVcVLzc1fx/iNr7EaVtAFSZTZ4pY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VoSCICchZRAjviG/KG2IvCt8tX6V4fZXZe+5sbybndsu27geXcRf0jjq0mwMUA0cXb/kw2q1w5PpioyKD0reNt5QYLctrGecfQUmI69vBj2DZrZAYv3Og+z7Hdy3MFomwiQbdalYo9zkQnxUY2zbYrLC/TYITOxaHO4tygG3DUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf0bG5eQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf0bG5eQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837C01F0089C;
	Tue,  6 Oct 2026 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297018;
	bh=UO/9+eEhIvCO71IuYsraukizcPwWbL0DuiUMIGPI0HM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bf0bG5eQ+9Gxzi9onMz9/vT4Qnx99QGHJ6xQi6am9D6ctOGgi6VSDr6VhSb5n4tn4
	 /6gMJV5JJmweK4ySXaRIW2nmJf+NrgbsEvHlw+wMrcyJaf2HjlfGW0gBd7TajvVjBt
	 IoJUAARTbcK1CzpOoa6xiCvA7ydP0m8HlPI7qx1lv/OAQ8xq/yVRDZepXbb5SEkm3g
	 4U2Q/4b77Z7hak6O+zunU/IH1x146wi0NRsf9CuM6yWcjswi4qa8byXaKrCJFTCNOr
	 mN9sqZrb8kw5Ho8Muo7eUxcs4c43dh9YZK64UCRWdbw58fetDdwxH9lzD6vnioakmw
	 tWvvp498xtoiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 771E339D5FF3;
	Tue,  6 Oct 2026 14:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: ISO: Serialize concurrent connect calls
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179129701702.2655967.13266802072066582497.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 14:30:17 +0000
References: <20261005075031.868260-1-nicoyip.dev@gmail.com>
In-Reply-To: <20261005075031.868260-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pav@iki.fi,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Oct 2026 15:50:31 +0800 you wrote:
> iso_sock_connect() checks the socket state before taking the socket lock
> and drops the lock again before setting up a connection. Two callers can
> both pass the admission check while the socket is open or bound.
> 
> Caller A can copy its destination for route selection, then caller B can
> replace the socket destination before A binds or connects the CIS. A
> then uses B's destination with the route selected for its own request.
> B can also proceed after A attaches a connection and sets BT_CONNECT.
> For deferred BIS setup, B can bind a second BIS and overwrite
> iso_pi(sk)->conn, leaving the first connection's reference and conn->sk
> back-pointer stranded. Concurrent CIS connects can likewise replace the
> socket's connection. Later teardown only detaches the current connection,
> so a callback on the old connection can race with socket release and
> access a freed socket.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: ISO: Serialize concurrent connect calls
    https://git.kernel.org/bluetooth/bluetooth-next/c/e32d80293a0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


