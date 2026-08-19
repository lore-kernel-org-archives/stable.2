Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FA3C4542;
	Wed, 19 Aug 2026 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159464; cv=none; b=Ac+okx3FgYqvEFMhjIqxQVtksWHSzioUwexbmP2PPYAbqtaQeEds0oH3iBT8U2qx2YiSSopbqDFDFdjXTiEdcwwjmU9w01MlA0gNir45wp6QtHYkRHjLK46IRDST2t/zZ2vzm0uVThGl6StxioagVtjrFBD1+VlPhOIr42XKcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159464; c=relaxed/simple;
	bh=d9jE+86govlWycoaXcxZLDWMjvSG8DsGHtAUTOwJSQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VTxNH0ArMiXthj5ndKTP+SqeVFrR06kM67/rDzHeQSjc6gn+CO/xouXBL/J/cUYemamyvkkcxUD6q8WaCq7fcwUtzMcpwIxfaiRjuChqAHqdiah/+fkqihpvRWkeX8c23hRthzoSRlfbXGIjqVgMpuwEl793NelXMzt6MI2ooPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VG1HJgmL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VG1HJgmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD1E1F000E9;
	Wed, 19 Aug 2026 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787159463;
	bh=LedxdYdWgzAgqtKnJe6av06qaQp4gA/DyT4Mh/vG4Ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VG1HJgmL7T9tSNl6VcqWbRhFMgTJY+VpwU1o0/Qvq9P3GB/g+NGu2i9+4ZslUeM0i
	 mHBYFl4NzPd4LqqgUb6Vfv9VC9DPRkMbMfykvpK2OpfsOken3IVWmmiSG/EhbOilUa
	 fSyU1mhDh3Hzmb+BLGKc2S3G7yAkukEZLOOiTPa7IUIKx539DOSF1LthsMJkhhZdvv
	 zKCixkdjyhwZfXC8Df+3OkkszMiyftvckKsmXZTO/Ybpw+5AHmWiYI1AvPGe+n/b3u
	 CinXoeQbyhXyX8vHiSnyyDy83r9jvu1+tA2CDAa3UwIjtY+Is2h6dFEp9hAm8erQY9
	 fsX+ApJ6dDPOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5693138119E6;
	Wed, 19 Aug 2026 17:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: ISO: fix use-after-free of listener socket
 in
 iso_conn_ready
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178715941390.3583745.14863371844483477016.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 17:10:13 +0000
References: <tencent_FFECEB355DB76CFDA2C0FE89B8E509028905@qq.com>
In-Reply-To: <tencent_FFECEB355DB76CFDA2C0FE89B8E509028905@qq.com>
To: Hang Nan <2122295973@qq.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 pav@iki.fi

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Aug 2026 08:57:58 +0800 you wrote:
> iso_conn_ready() looks up the BIS listener socket with iso_get_sock(),
> which takes a reference, and then, without re-checking its state,
> creates a child socket from it:
> 
>     parent = iso_get_sock(hdev, ...);
>     if (!parent)
>         return;
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
    https://git.kernel.org/bluetooth/bluetooth-next/c/486f8908aa58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


