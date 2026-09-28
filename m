Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307494E9C0C;
	Mon, 28 Sep 2026 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610111; cv=none; b=M3d/FlBTBfgYltO946AlBBuv9i2f9y9H91cu1xRTFCkG7nDayd7C041apaTxt7S+3Vx7xIrdTn1UOfL3sgxYciB3NG5qCNayHJu0CAoN9f/T3Nd7bQJ8SrcmBtdh3uh2P3ULSutcUwODCj1m242RdtB9I52obKVZfVIGeifAppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610111; c=relaxed/simple;
	bh=MH81L24qVnaKHX7KPOznSih2eWsdZxVO2HHnWVcO6uk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZEkA82QUiIQEfQ1LN6tObPqxRzi+GB20KZEl/XUa2uUbnot5sSLmsLPDmXH6nLrqsbPjK+xdIWS0ktpDavXGw0e/p/5ROUXLpxFZ248Zlu81AJeA8PPUZBvM2jivKvQXvcLhGfUrmZ00HhZ9MBsMlOHnOaZtumx56W0b5j9FjHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN8V4Cw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN8V4Cw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1513F1F00893;
	Mon, 28 Sep 2026 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610104;
	bh=P3scYBTurQ1ZwJVBSM3x36hfBIj6nZWkYrKgVfTyJyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QN8V4Cw995Fby1/zN7Kz6ekcYF34zgw09uk6WcKDhyzvVvyjL0kYxFCDbEX1K8h2v
	 U9C5DJyvLpkukrQHsI8b/L6y9CPkevlduaxEaeBq6v1vWRAyI3JeyvHfgT2G99H903
	 PUNljLZHAtoaUzZtBHF8zD54y/rGengUZzb96Qxx0z0iPZhvv+0A4KPnyHZsV4d2nM
	 8zfvIsZueLzi8mYzMtvkpp0gyuD/ZvlRFa8cLw4558XMq7hAcApCo4CITZN4FgtfAX
	 jM00xbZs/Y4ycZZWG6DZbO3W3KCpYRcgexCtr1t3pKBfadHoBwMe+iVWfndISgcXjq
	 4CFBOgNOIiqnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1965D3924456;
	Mon, 28 Sep 2026 15:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: RFCOMM: Fix initial port reference race
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061002863.4169639.16838238725128380155.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 15:40:28 +0000
References: <20260926172723.2405885-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260926172723.2405885-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kuba@kernel.org,
 broonie@kernel.org, johan@kernel.org, tim.bird@sony.com, kees@kernel.org,
 peter@hurleysoftware.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Sep 2026 01:27:23 +0800 you wrote:
> For RFCOMM_RELEASE_ONHUP devices, rfcomm_tty_install() and
> __rfcomm_release_dev() both use RFCOMM_TTY_OWNED to decide who drops the
> initial tty_port reference. The release path tests the bit separately
> from the install path setting it, so both can drop that reference.
> 
> The synchronous hangup does not prevent this race: port->tty is not
> assigned until tty_port_open(), after installation. The following
> interleaving is possible:
> 
> [...]

Here is the summary with links:
  - Bluetooth: RFCOMM: Fix initial port reference race
    https://git.kernel.org/bluetooth/bluetooth-next/c/2d696c1ed346

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


