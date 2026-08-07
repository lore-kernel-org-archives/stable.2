Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693F476CD4;
	Fri,  7 Aug 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120259; cv=none; b=pdfNH0L4B8jBFrM0Zk9voIcfnpMxAONRswbPIsOfPGdYUO5wCtgRUhHhUHQZV0wxegYcXs2z6R+vOnIMsXkOZLpM/2sSTdH1g/3upmzHXHil8Izza/vrYOXXDewajkhBOZQgJpL/qUt8ZvZIA/5Ah0iCq7FZBpWrXTy2Ol4PrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120259; c=relaxed/simple;
	bh=mYearBEOIf8TE1MSn83xVeA9AiH2qSt+rTrhoi1VrMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t3GrMgC32j2QsInoeO/ew6tqYmay5x99AIRXEE083WJ7nW9z8lGCzReTybrPbrYb4CMCTAjV+8vjPrQO//3gzSTwVaDHMhsIk/pm0ka/Fv2HvuPGgh2iDVWUB4sE5GGPNTvOLwnd57ngdGQb8qgmO2JT4excbvjMMb79XO0n2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf2I7gkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf2I7gkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7F51F00A3A;
	Fri,  7 Aug 2026 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786120257;
	bh=lVUJ2FA02dZCEZ5mIsCIpXk83F8HfAW1NwMT5l3/MNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hf2I7gkDWIVlzfTtoPFp814RYuo/pzPlVRTeGIKXpuwwmA+l2zKv3v2Kk5GwFfRap
	 78xBF7epj4T3E+HAgUtIANAcCM7JTo0RVYwIn7Km3g9cn2qflyfEbiNoDmQiwFgpEA
	 V6RFJzjwjAmDg4jKmZirSShdLIPOoRGNwZ+vYm6hPgbkaNv0v4dFjoMRjDhfTtQsN7
	 IbCzJ4qNwi5fhhIXUuBZEYDUULCtPUAPXU8YEZIriEQX294sUz9IzAqWk2srDzJ4VZ
	 FRF/pJqo1lCYEVaEqt1IsYtxrZneAiZhhtukH+JXtFCUBKk0lpNyfKoezda9Uf/i/O
	 XEW0GZQbmwdWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ACD380CEE3;
	Fri,  7 Aug 2026 16:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: do not force BT_LISTEN after a failed BIG
 sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178612021613.1887768.3651042341721067643.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 16:30:16 +0000
References: <20260807010003.85655-1-ali@iusegentoo.com>
In-Reply-To: <20260807010003.85655-1-ali@iusegentoo.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Aug 2026 00:59:55 +0000 you wrote:
> iso_sock_recvmsg() handles the deferred setup of a broadcast sink by
> dropping the socket lock, calling iso_conn_big_sync() and taking the
> lock again:
> 
> 	release_sock(sk);
> 	iso_conn_big_sync(sk);
> 	lock_sock(sk);
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: do not force BT_LISTEN after a failed BIG sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/e177adea1f98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


