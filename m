Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440823D297;
	Tue,  8 Sep 2026 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827472; cv=none; b=ZeHnOC5rdJT4vUadrw3P4MvcFfj1zAPfNOuP0KiyDhNeWYFbs9J3VCX9QjpRPiECeV0wSETo7lqNtY+z4siq1VxpgpcGpHfTf4gAWklTsNkx++El/hpaU9KYuQshhbZ3J3/P1bMMHmh+z9/nzxULz9tIL0EhSlgHpyWN46lBr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827472; c=relaxed/simple;
	bh=0iNFbhrOR/6e6APD/zQAhq+Dkp7fgrCJSCtG37CERtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BdS/1wEKz48KS/CKr1KOH3g4UgXbeqmtbHMiTn3fV6XgfQZUK2566RVTsuyVqSJfgojWxROzPvn5sm25gKocD6sEYCfDpN2XfIQQM/WT0kzQcHWUsjkqC38PEft9pczmbHSojpXSDLtHdhy3/3PdJCIOSfmCHkjZ1RLakIzxTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDLUNFY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDLUNFY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298E11F00A3A;
	Tue,  8 Sep 2026 00:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788827471;
	bh=hBCowP6x56PI81r+XGOaYYk3znN7BEdM9DBIs45Tdgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iDLUNFY8wZmVlZtXlu1T9bpDBZ0QLWofzoBKNSfxHG8NrwyXzScTD1SiNoMGiVgTh
	 IhGdDMf5kwVkjA3vSqNNPChfQmOmsuPf/CVonTLbBtANbnsrX2+DXzrMeh70oBcvbJ
	 sSEnL9Mc0CRWodngV2OSMhzfI0A+SdRKAZ4gQCOVWPZNbNSG+CwxOEovypDbSlnjOd
	 Zhen7NC0kYlz3ds0jqXAISky1M06PyyKAdPGvt8JpVNlHUaKGdReHArTI0Clg+e5kL
	 bRclT7gMVkMzj8+IK/Dy8E6aGfyNDHZ8PDSuC7tf60goQ1Z9T8b01Rv/QGE9IORFiO
	 ByGGPfB4cBaQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C7139E8A5B;
	Tue,  8 Sep 2026 00:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: microchip_t1: fix NULL pointer
 dereference
 in lan887x_phy_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882740988.3220068.2607068471712359307.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 00:30:09 +0000
References: <20260903113046.163630-1-15815827059@163.com>
In-Reply-To: <20260903113046.163630-1-15815827059@163.com>
To: huhai <15815827059@163.com>
Cc: kuba@kernel.org, andrew@lunn.ch, divya.koppera@microchip.com,
 netdev@vger.kernel.org, xuanqiang.luo@linux.dev, Divya.Koppera@microchip.com,
 huhai@kylinos.cn, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 19:30:46 +0800 you wrote:
> From: Henry Hu <huhai@kylinos.cn>
> 
> The issue was discovered via smatch static analyzer:
> 
>   make CHECK="smatch -p=kernel"  C=2  drivers/net/phy/microchip_t1.o
>     CHECK   scripts/mod/empty.c
>     DESCEND objtool
>     CHECK   drivers/net/phy/microchip_t1.c
>   drivers/net/phy/microchip_t1.c:1295 lan887x_phy_init() warn: 'priv->clock' can also be NULL
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: microchip_t1: fix NULL pointer dereference in lan887x_phy_init()
    https://git.kernel.org/netdev/net-next/c/a4050ce7e46c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


