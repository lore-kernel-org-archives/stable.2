Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8323BF66D;
	Mon, 20 Jul 2026 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578842; cv=none; b=A8h30tuK0WvfgMVJwe9uZUqzyx7/TBa93PIwIZhL7wcYQrSVX0vxYWvIKtzRRPukORgBa+LkFMmkJ1NdnqfMdKf/G35KBu0wthVRE5LTZfW1aktmzO950jJso5S65oiv7jEhlGadGanDnYzo0wp1V7DZr1/yjN//NL8PDBN2Aq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578842; c=relaxed/simple;
	bh=dS0YhtpYvFpvYqY/xhJDvfquRQ27CnUF5e2EIri7Y88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SQHv9jZvBfjxci05r3sHD//pumvaWR8gH4Ul04GSxmdyrCjr/fr9i3jJtOwclmDHZVZMUblf8/cm0DceZ4uBh3rQk/+ep2XGcLXXlipFkM7z49aVZYPALGSMGIWVCjVlT59/rjfDCWCqQm/Gf6wnB0EgCMRdFKXVYqCncQp0Krc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDT5IzSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDT5IzSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9751F000E9;
	Mon, 20 Jul 2026 20:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784578841;
	bh=CTV2IbPplGKApFleI5lyKDmZ2j1ZG8Ulifo8HhO0kwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IDT5IzSlrSixK5mZN75S0DOtVbPh0wHA/FQTlud1uy+htGvlLbC0bC8Ipznaf3OAX
	 f4rNO9l9xH54drdPl4oV0r1xu+eX6T30UsEbJiWXXxb9gtpdzZCv6VDIOWUf4TYG2k
	 OcGaNmcbH3UxoTLAUKwZhLgCLPtLyLROZcGK1PYwUWg1S5m926PYjujL6Hc/eaD4Lb
	 tZUSCXbf4BY6o9549hNkdyZbJIP8yY5W2jIY4iNjIfm5CCRADmz8HzpTCluVmlFJuv
	 yA2+ZqknnJWvgKawizlYsWphcMZJLn07hOy6cN/aywRHEmtComUlGXSla0Ce978uIE
	 V/GmKA5Hyt+Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5687A39244CA;
	Mon, 20 Jul 2026 20:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: RFCOMM: Fix session UAF in set_termios
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178457881088.4151939.5706907972052659419.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 20:20:10 +0000
References: <20260719160311.2898053-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260719160311.2898053-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kees@kernel.org,
 kuba@kernel.org, suunj1331@gmail.com, dg573847474@gmail.com,
 tim.bird@sony.com, pengpeng@iscas.ac.cn, johan@kernel.org, hadess@hadess.net,
 jsuter@hardwave.de, davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Jul 2026 00:03:11 +0800 you wrote:
> rfcomm_tty_set_termios() tests dlc->session without rfcomm_mutex and
> later passes the pointer to rfcomm_send_rpn(). The latter dereferences
> both session->initiator and session->sock. Meanwhile, krfcommd can
> unlink the DLC and free the session while holding rfcomm_mutex.
> 
> The race can proceed as follows:
> 
> [...]

Here is the summary with links:
  - Bluetooth: RFCOMM: Fix session UAF in set_termios
    https://git.kernel.org/bluetooth/bluetooth-next/c/2ac5f666025e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


