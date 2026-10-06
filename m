Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F5471CE7;
	Tue,  6 Oct 2026 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297019; cv=none; b=ZVoVJqT5HgbNFTB+hQ4XYWg7Pz5hpRVp5hh6vgjiIugXYWoZkOs60vQ8O5ztqgqvVBm6ICsB4j5RSGrfL/ZlRX3sJkOyXIAFgJyzFTpaXEHATyY8eJ5V89ZScMIhkoNnKYH/4DIdkTQ67o3dUprMih8tJUY7HSwSp4pFKO09SYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297019; c=relaxed/simple;
	bh=8Gf4hkKNJBvi//o7LfbOKl2r0riWIoUG3kUl91GOc3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dB/m8/VD2CtPuv2wEYUlN6vFMeUnQ//RN+85ghBrggSsuDXzERQbJOLV6c3fx19duFJyt71obaUTzuIqOx5ftK3Wyc7ly5s+2Z5WvYPSQdFIeg9wTxVUK7ryg0+zJV7jjMxboDucU+K1QZXZdODpymiX4Rxw5DGdJCRFh03U+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3KqJ4GZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3KqJ4GZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073771F0089B;
	Tue,  6 Oct 2026 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297017;
	bh=CIYpXNW18bJwoJzCXAWx6KXR8WZIuuQ7v6fHR03q5pU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X3KqJ4GZW/gxpB7gkXn9H1f82vq3llAv5t5DcFZdb2fRZFwexzfEXdwfI+C/BMLYG
	 phWMCujpg1GIWu3FpcK8+bpOvNHZnN9kn2680VFRUO4DOT4SQEUUb22awJqjhpyEdw
	 eciOParBAe1NciVjqamb19CS8Hyq6XhUNT/ya4d53Llly5ESZJa3hwX7SnLBlOB9Mr
	 wphYJWRmqoOGp2L9UOaRNZtAEX2UxI4fTKKOX1NAbDu/Ot5q16NvGNhkB3TOR76p0e
	 9m+YmhLoWaNtIYAnZoJX44HDnRK/x+EdcyuXSYp0NDAuc7+SicSS+ukGqF1l40QQzV
	 3PbZUurdUJWxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F137739D5FF3;
	Tue,  6 Oct 2026 14:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: Reject concurrent BIS listener setup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179129701552.2655967.7619580785559847090.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 14:30:15 +0000
References: <20261004162548.3968712-1-nicoyip.dev@gmail.com>
In-Reply-To: <20261004162548.3968712-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, iulia.tanasescu@nxp.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Oct 2026 00:25:48 +0800 you wrote:
> iso_sock_listen() drops the socket lock before calling iso_listen_bis()
> to preserve the hdev->lock ordering. Two concurrent listen() calls on
> the same broadcast socket can therefore both observe BT_BOUND. Caller
> A can attach connA and release the locks, then caller B can acquire
> them and attach connB before A publishes BT_LISTEN.
> 
> __iso_chan_add() checks whether connB already has a socket, but not
> whether the socket already has a connection. The second attachment
> overwrites iso_pi(sk)->conn, leaking the connA reference and leaving
> connA->sk intact. Socket teardown follows connB, so later events on
> connA can cause a stale socket access.
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: Reject concurrent BIS listener setup
    https://git.kernel.org/bluetooth/bluetooth-next/c/555ff78fa719

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


